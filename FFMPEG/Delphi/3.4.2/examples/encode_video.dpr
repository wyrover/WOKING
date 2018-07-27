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
 * video encoding with libavcodec API example
 *
 * @example encode_video.c
 *)

(*
 * FFVCL - Delphi FFmpeg VCL Components
 * http://www.DelphiFFmpeg.com
 *
 * Original file: doc/examples/encode_video.c
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

program encode_video;

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

function encode(enc_ctx: PAVCodecContext; frame: PAVFrame; pkt: PAVPacket; outfile: THandle): Boolean;
var
  ret: Integer;
begin
  (* send the frame to the encoder *)
  if Assigned(frame) then
    Writeln(Format('Send frame %3d', [frame.pts]));

  ret := avcodec_send_frame(enc_ctx, frame);
  if ret < 0 then
  begin
    Writeln(ErrOutput, 'Error sending a frame for encoding');
    Result := False;
    Exit;
  end;

  while ret >= 0 do
  begin
    ret := avcodec_receive_packet(enc_ctx, pkt);
    if (ret = AVERROR_EAGAIN) or (ret = AVERROR_EOF) then
    begin
      Result := True;
      Exit;
    end
    else if ret < 0 then
    begin
      Writeln(ErrOutput, 'Error during encoding');
      Result := False;
      Exit;
    end;

    Writeln(Format('Write packet %3d (size=%5d)', [pkt.pts, pkt.size]));
    FileWrite(outfile, pkt.data^, pkt.size);
    av_packet_unref(pkt);
  end;
  Result := True;
end;

function main(): Integer;
const
  endcode: array[0..3] of Byte = ( 0, 0, 1, $b7 );
var
  filename, codec_name: string;
  codec: PAVCodec;
  c: PAVCodecContext;
  idx, i, ret, x, y: Integer;
  f: THandle;
  frame: PAVFrame;
  pkt: PAVPacket;
begin
  if ParamCount < 2 then
  begin
    Writeln(Format('Usage: %s <output file> <codec name>', [ExtractFileName(ParamStr(0))]));
    Result := 1;
    Exit;
  end;
  filename := ParamStr(1);
  codec_name := ParamStr(2);

  avcodec_register_all();

  (* find the mpeg1video encoder *)
  codec := avcodec_find_encoder_by_name(PAnsiChar(codec_name));
  if not Assigned(codec) then
  begin
    Writeln(ErrOutput, Format('Codec "%s" not found', [codec_name]));
    Result := 1;
    Exit;
  end;

  c := avcodec_alloc_context3(codec);
  if not Assigned(c) then
  begin
    Writeln(ErrOutput, 'Could not allocate video codec context');
    Result := 1;
    Exit;
  end;

  pkt := av_packet_alloc();
  if not Assigned(pkt) then
  begin
    Result := 1;
    Exit;
  end;

  (* put sample parameters *)
  c.bit_rate := 400000;
  (* resolution must be a multiple of two *)
  c.width := 352;
  c.height := 288;
  (* frames per second *)
  c.time_base.num := 1;
  c.time_base.den := 25;
  c.framerate.num := 25;
  c.framerate.den := 1;

  (* emit one intra frame every ten frames
   * check frame pict_type before passing frame
   * to encoder, if frame->pict_type is AV_PICTURE_TYPE_I
   * then gop_size is ignored and the output of encoder
   * will always be I frame irrespective to gop_size
   *)
  c.gop_size := 10;
  c.max_b_frames := 1;
  c.pix_fmt := AV_PIX_FMT_YUV420P;

  if codec.id = AV_CODEC_ID_H264 then
    av_opt_set(c.priv_data, 'preset', 'slow', 0);

  (* open it *)
  ret := avcodec_open2(c, codec, nil);
  if ret < 0 then
  begin
    Writeln(ErrOutput, Format('Could not open codec: %s', [av_err2str(ret)]));
    Result := 1;
    Exit;
  end;

  f := FileCreate(filename);
  if f = INVALID_HANDLE_VALUE then
  begin
    Writeln(ErrOutput, Format('Could not open %s', [filename]));
    Result := 1;
    Exit;
  end;

  frame := av_frame_alloc();
  if not Assigned(frame) then
  begin
    Writeln(ErrOutput, 'Could not allocate video frame');
    Result := 1;
    Exit;
  end;
  frame.format := Ord(c.pix_fmt);
  frame.width  := c.width;
  frame.height := c.height;

  ret := av_frame_get_buffer(frame, 32);
  if ret < 0 then
  begin
    Writeln(ErrOutput, 'Could not allocate the video frame data');
    Result := 1;
    Exit;
  end;

  (* encode 1 second of video *)
  idx := 1;
  for i := 0 to 25 - 1 do
  begin
    //fflush(stdout);

    (* make sure the frame data is writable *)
    ret := av_frame_make_writable(frame);
    if ret < 0 then
    begin
      Writeln(ErrOutput, 'av_frame_make_writable() failed');
      Result := 1;
      Exit;
    end;

    (* prepare a dummy image *)
    (* Y *)
    for y := 0 to c.height - 1 do
      for x := 0 to c.width - 1 do
        PByte(@PAnsiChar(frame.data[0])[y * frame.linesize[0] + x])^ := x + y + i * 3;

    (* Cb and Cr *)
    for y := 0 to c.height div 2 - 1 do
      for x := 0 to c.width div 2 - 1 do
      begin
        PByte(@PAnsiChar(frame.data[1])[y * frame.linesize[1] + x])^ := 128 + y + i * 2;
        PByte(@PAnsiChar(frame.data[2])[y * frame.linesize[2] + x])^ := 64 + x + i * 5;
      end;

    frame.pts := i;

    (* encode the image *)
    if not encode(c, frame, pkt, f) then
    begin
      Result := 1;
      Exit;
    end;
  end;
  Result := 0;

  (* flush the encoder *)
  if not encode(c, nil, pkt, f) then
    Result := 1;

  (* add sequence end code to have a real MPEG file *)
  FileWrite(f, endcode[0], SizeOf(endcode));
  FileClose(f);

  avcodec_free_context(@c);
  av_frame_free(@frame);
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
