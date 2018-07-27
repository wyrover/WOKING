(*
 * Copyright (c) 2001 Fabrice Bellard
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *)

(**
 * @file
 * audio decoding with libavcodec API example
 *
 * @example decode_audio.c
 *)

(*
 * FFVCL - Delphi FFmpeg VCL Components
 * http://www.DelphiFFmpeg.com
 *
 * Original file: doc/examples/decode_audio.c
 * Ported by CodeCoolie@CNSW 2017/12/17 -> $Date:: 2018-04-20 #$
 *)

(*
FFmpeg Delphi/Pascal Headers and Examples License Agreement

A modified part of FFVCL - Delphi FFmpeg VCL Components.
Copyright (c) 2008-2018 DelphiFFmpeg.com
All rights reserved.
http://www.DelphiFFmpeg.com

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:
1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

This source code is provided "as is" by DelphiFFmpeg.com without
warranty of any kind, either expressed or implied, including but not
limited to the implied warranties of merchantability and/or fitness
for a particular purpose.

Please also notice the License agreement of FFmpeg libraries.
*)

program decode_audio;

{$APPTYPE CONSOLE}

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

uses
{$IFDEF FPC}
  {$IFDEF MSWINDOWS}
    Windows,
  {$ENDIF}
  SysUtils,
{$ELSE}
  {$IF CompilerVersion >= 23.0}
    {$IFDEF MSWINDOWS}
      Winapi.Windows,
    {$ENDIF}
    System.SysUtils,
  {$ELSE}
    {$IFDEF MSWINDOWS}
      Windows,
    {$ENDIF}
    SysUtils,
  {$IFEND}
{$ENDIF}

  FFUtils,

  libavcodec,
  libavcodec_avfft,
  libavdevice,
  libavfilter,
  libavfilter_avcodec,
  libavfilter_buffersink,
  libavfilter_buffersrc,
  libavfilter_formats,
  libavformat,
  libavformat_avio,
  libavformat_url,
  libavutil,
  libavutil_audio_fifo,
  libavutil_avstring,
  libavutil_bprint,
  libavutil_buffer,
  libavutil_channel_layout,
  libavutil_common,
  libavutil_cpu,
  libavutil_dict,
  libavutil_display,
  libavutil_error,
  libavutil_eval,
  libavutil_fifo,
  libavutil_file,
  libavutil_frame,
  libavutil_imgutils,
  libavutil_log,
  libavutil_mathematics,
  libavutil_md5,
  libavutil_mem,
  libavutil_motion_vector,
  libavutil_opt,
  libavutil_parseutils,
  libavutil_pixdesc,
  libavutil_pixfmt,
  libavutil_rational,
  libavutil_samplefmt,
  libavutil_time,
  libavutil_timestamp,
  libswresample,
  libswscale;

const
  AUDIO_INBUF_SIZE    = 20480;
  AUDIO_REFILL_THRESH = 4096;

function decode(dec_ctx: PAVCodecContext; pkt: PAVPacket; frame: PAVFrame; outfile: THandle): Boolean;
var
  i, ch: Integer;
  ret, data_size: Integer;
begin
  (* send the packet with the compressed data to the decoder *)
  ret := avcodec_send_packet(dec_ctx, pkt);
  if ret < 0 then
  begin
    Writeln(ErrOutput, 'Error submitting the packet to the decoder');
    Result := False;
    Exit;
  end;

  (* read all the output frames (in general there may be any number of them *)
  while ret >= 0 do
  begin
    ret := avcodec_receive_frame(dec_ctx, frame);
    if (ret = AVERROR_EAGAIN) or (ret = AVERROR_EOF) then
    begin
      Result := True;
      Exit;
    end
    else if ret < 0 then
    begin
      Writeln(ErrOutput, 'Error during decoding');
      Result := False;
      Exit;
    end;
    data_size := av_get_bytes_per_sample(dec_ctx.sample_fmt);
    if data_size < 0 then
    begin
      (* This should not occur, checking just for paranoia *)
      Writeln(ErrOutput, 'Failed to calculate data size');
      Result := False;
      Exit;
    end;
    for i := 0 to frame.nb_samples - 1 do
      for ch := 0 to dec_ctx.channels - 1 do
        FileWrite(outfile, PByte(Integer(frame.data[ch]) + data_size * i)^, data_size);
  end;
  Result := True;
end;

function main(): Integer;
var
  outfilename, filename: string;
  codec: PAVCodec;
  c: PAVCodecContext;
  parser: PAVCodecParserContext;
  len, ret: Integer;
  f, outfile: THandle;
  inbuf: array[0..AUDIO_INBUF_SIZE + AV_INPUT_BUFFER_PADDING_SIZE - 1] of Byte;
  data: PByte;
  pkt: PAVPacket;
  decoded_frame: PAVFrame;
  data_size: Integer;
label
  fail;
begin
  parser := nil;
  decoded_frame := nil;

  if ParamCount < 2 then
  begin
    Writeln(Format('Usage: %s <input file> <output file>', [ExtractFileName(ParamStr(0))]));
    Result := 1;
    Exit;
  end;
  filename := ParamStr(1);
  outfilename := ParamStr(2);

  (* register all the codecs *)
  avcodec_register_all();

  pkt := av_packet_alloc();

  (* find the MPEG audio decoder *)
  codec := avcodec_find_decoder(AV_CODEC_ID_MP2);
  if not Assigned(codec) then
  begin
    Writeln(ErrOutput, 'Codec not found');
    Result := 1;
    Exit;
  end;

  parser := av_parser_init(Ord(codec.id));
  if not Assigned(parser) then
  begin
    Writeln(ErrOutput, 'Parser not found');
    Result := 1;
    Exit;
  end;

  c := avcodec_alloc_context3(codec);
  if not Assigned(c) then
  begin
    Writeln(ErrOutput, 'Could not allocate audio codec context');
    Result := 1;
    Exit;
  end;

  (* open it *)
  if avcodec_open2(c, codec, nil) < 0 then
  begin
    Writeln(ErrOutput, 'Could not open codec');
    Result := 1;
    Exit;
  end;

  f := FileOpen(filename, fmOpenRead);
  if f = INVALID_HANDLE_VALUE then
  begin
    Writeln(ErrOutput, Format('Could not open %s', [filename]));
    Result := 1;
    Exit;
  end;
  outfile := FileCreate(outfilename);
  if outfile = INVALID_HANDLE_VALUE then
  begin
    Writeln(ErrOutput, Format('Could not open %s', [outfilename]));
    av_free(c);
    Result := 1;
    Exit;
  end;

  (* decode until eof *)
  data := @inbuf[0];
  data_size := FileRead(f, inbuf[0], AUDIO_INBUF_SIZE);

  while data_size > 0 do
  begin
    if not Assigned(decoded_frame) then
    begin
      decoded_frame := av_frame_alloc();
      if not Assigned(decoded_frame) then
      begin
        Writeln(ErrOutput, 'Could not allocate audio frame');
        Result := 1;
        Exit;
      end;
    end;

    ret := av_parser_parse2(parser, c, @pkt.data, @pkt.size,
                            data, data_size,
                            AV_NOPTS_VALUE, AV_NOPTS_VALUE, 0);
    if ret < 0 then
    begin
      Writeln(ErrOutput, 'Error while parsing');
      Result := 1;
      Exit;
    end;
    Inc(data, ret);
    Dec(data_size, ret);

    if pkt.size > 0 then
      if not decode(c, pkt, decoded_frame, outfile) then
      begin
        Result := 1;
        goto fail;
      end;

    if data_size < AUDIO_REFILL_THRESH then
    begin
      Move(data^, inbuf[0], data_size);
      data := @inbuf[0];
      len := FileRead(f, PByte(PAnsiChar(data) + data_size)^,
                  AUDIO_INBUF_SIZE - data_size);
      if len > 0 then
        Inc(data_size, len);
    end;
  end;
  Result := 0;

  (* flush the decoder *)
  pkt.data := nil;
  pkt.size := 0;
  if not decode(c, pkt, decoded_frame, outfile) then
    Result := 1;

fail:
  FileClose(outfile);
  FileClose(f);

  avcodec_free_context(@c);
  av_parser_close(parser);
  av_frame_free(@decoded_frame);
  av_packet_free(@pkt);
end;

begin
  try
    ExitCode := main();
  except
    on E: Exception do
      Writeln(ErrOutput, E.ClassName, ': ', E.Message);
  end;
end.
