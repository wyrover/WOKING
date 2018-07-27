(*
 * This file is part of FFmpeg.
 *
 * FFmpeg is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * FFmpeg is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with FFmpeg; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 *)

(**
 * @file
 * simple audio converter
 *
 * @example transcode_aac.c
 * Convert an input audio file to AAC in an MP4 container using FFmpeg.
 * @author Andreas Unterweger (dustsigns@gmail.com)
 *)

(*
 * FFVCL - Delphi FFmpeg VCL Components
 * http://www.DelphiFFmpeg.com
 *
 * Original file: doc/examples/transcode_aac.c
 * Ported by CodeCoolie@CNSW 2014/08/31 -> $Date:: 2018-01-15 #$
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

program transcode_aac;

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

  FFTypes,

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
(** The output bit rate in kbit/s *)
  OUTPUT_BIT_RATE = 96000;
(** The number of output channels *)
  OUTPUT_CHANNELS = 2;

type
  PPAVCodecContext = ^PAVCodecContext;

(** Open an input file and the required decoder. *)
function open_input_file(const filename: PAnsiChar;
  input_format_context: PPAVFormatContext;
  input_codec_context: PPAVCodecContext): Integer;
var
  avctx: PAVCodecContext;
  input_codec: PAVCodec;
  error: Integer;
begin
  (** Open the input file to read from it. *)
  error := avformat_open_input(input_format_context, filename, nil, nil);
  if error < 0 then
  begin
    Writeln(ErrOutput, Format('Could not open input file ''%s'' (error ''%s'')',
            [filename, av_err2str(error)]));
    input_format_context^ := nil;
    Result := error;
    Exit;
  end;

  (** Get information on the input file (number of streams etc.). *)
  error := avformat_find_stream_info(input_format_context^, nil);
  if error < 0 then
  begin
    Writeln(ErrOutput, Format('Could not open find stream info (error ''%s'')',
            [av_err2str(error)]));
    avformat_close_input(input_format_context);
    Result := error;
    Exit;
  end;

  (** Make sure that there is only one stream in the input file. *)
  if input_format_context^.nb_streams <> 1 then
  begin
    Writeln(ErrOutput, Format('Expected one audio input stream, but found %d',
            [input_format_context^.nb_streams]));
    avformat_close_input(input_format_context);
    Result := AVERROR_EXIT;
    Exit;
  end;

  (** Find a decoder for the audio stream. *)
  input_codec := avcodec_find_decoder(input_format_context^.streams^.codecpar.codec_id);
  if not Assigned(input_codec) then
  begin
    Writeln(ErrOutput, 'Could not find input codec');
    avformat_close_input(input_format_context);
    Result := AVERROR_EXIT;
    Exit;
  end;

  (** allocate a new decoding context *)
  avctx := avcodec_alloc_context3(input_codec);
  if not Assigned(avctx) then
  begin
    Writeln(ErrOutput, 'Could not allocate a decoding context');
    avformat_close_input(input_format_context);
    Result := AVERROR_ENOMEM;
    Exit;
  end;

  (** initialize the stream parameters with demuxer information *)
  error := avcodec_parameters_to_context(avctx, input_format_context^.streams^.codecpar);
  if error < 0 then
  begin
    avformat_close_input(input_format_context);
    avcodec_free_context(@avctx);
    Result := error;
    Exit;
  end;

  (** Open the decoder for the audio stream to use it later. *)
  error := avcodec_open2(avctx, input_codec, nil);
  if error < 0 then
  begin
    Writeln(ErrOutput, Format('Could not open input codec (error ''%s'')',
            [av_err2str(error)]));
    avformat_close_input(input_format_context);
    avcodec_free_context(@avctx);
    Result := error;
    Exit;
  end;

  (** Save the decoder context for easier access later. *)
  input_codec_context^ := avctx;

  Result := 0;
end;

(**
 * Open an output file and the required encoder.
 * Also set some basic encoder parameters.
 * Some of these parameters are based on the input file's parameters.
 *)
function open_output_file(const filename: PAnsiChar;
  input_codec_context: PAVCodecContext;
  output_format_context: PPAVFormatContext;
  output_codec_context: PPAVCodecContext): Integer;
var
  avctx: PAVCodecContext;
  output_io_context: PAVIOContext;
  stream: PAVStream;
  output_codec: PAVCodec;
  error: Integer;
label
  cleanup;
begin
  avctx := nil;
  output_io_context := nil;

  (** Open the output file to write to it. *)
  error := avio_open(@output_io_context, filename,
                         AVIO_FLAG_WRITE);
  if error < 0 then
  begin
    Writeln(ErrOutput, Format('Could not open output file ''%s'' (error ''%s'')',
            [filename, av_err2str(error)]));
    Result := error;
    Exit;
  end;

  (** Create a new format context for the output container format. *)
  output_format_context^ := avformat_alloc_context();
  if not Assigned(output_format_context^) then
  begin
    Writeln(ErrOutput, 'Could not allocate output format context');
    Result := AVERROR_ENOMEM;
    Exit;
  end;

  (** Associate the output file (pointer) with the container format context. *)
  output_format_context^.pb := output_io_context;

  (** Guess the desired container format based on the file extension. *)
  output_format_context^.oformat := av_guess_format(nil, filename, nil);
  if not Assigned(output_format_context^.oformat) then
  begin
    Writeln(ErrOutput, 'Could not find output file format');
    goto cleanup;
  end;

  av_strlcpy(output_format_context^.filename, filename,
             SizeOf(output_format_context^.filename));

  (** Find the encoder to be used by its name. *)
  output_codec := avcodec_find_encoder(AV_CODEC_ID_AAC);
  if not Assigned(output_codec) then
  begin
    Writeln(ErrOutput, 'Could not find an AAC encoder.');
    goto cleanup;
  end;

  (** Create a new audio stream in the output file container. *)
  stream := avformat_new_stream(output_format_context^, nil);
  if not Assigned(stream) then
  begin
    Writeln(ErrOutput, 'Could not create new stream');
    error := AVERROR_ENOMEM;
    goto cleanup;
  end;

  avctx := avcodec_alloc_context3(output_codec);
  if not Assigned(avctx) then
  begin
    Writeln(ErrOutput, 'Could not allocate an encoding context');
    error := AVERROR_ENOMEM;
    goto cleanup;
  end;

  (**
   * Set the basic encoder parameters.
   * The input file's sample rate is used to avoid a sample rate conversion.
   *)
  avctx.channels       := OUTPUT_CHANNELS;
  avctx.channel_layout := av_get_default_channel_layout(OUTPUT_CHANNELS);
  avctx.sample_rate    := input_codec_context.sample_rate;
  avctx.sample_fmt     := output_codec.sample_fmts^;
  avctx.bit_rate       := OUTPUT_BIT_RATE;

  (** Allow the use of the experimental AAC encoder *)
  avctx.strict_std_compliance := FF_COMPLIANCE_EXPERIMENTAL;

  (** Set the sample rate for the container. *)
  stream.time_base.den := input_codec_context.sample_rate;
  stream.time_base.num := 1;

  (**
   * Some container formats (like MP4) require global headers to be present
   * Mark the encoder so that it behaves accordingly.
   *)
  if (output_format_context^.oformat.flags and AVFMT_GLOBALHEADER) <> 0 then
    avctx.flags := avctx.flags or AV_CODEC_FLAG_GLOBAL_HEADER;

  (** Open the encoder for the audio stream to use it later. *)
  error := avcodec_open2(avctx, output_codec, nil);
  if error < 0 then
  begin
    Writeln(ErrOutput, Format('Could not open output codec (error ''%s'')',
            [av_err2str(error)]));
    goto cleanup;
  end;

  error := avcodec_parameters_from_context(stream.codecpar, avctx);
  if error < 0 then
  begin
    Writeln(ErrOutput, 'Could not initialize stream parameters');
    goto cleanup;
  end;

  (** Save the encoder context for easier access later. *)
  output_codec_context^ := avctx;

  Result := 0;
  Exit;

cleanup:
  avcodec_free_context(@avctx);
  avio_closep(@output_format_context^.pb);
  avformat_free_context(output_format_context^);
  output_format_context^ := nil;
  if error < 0 then
    Result := error
  else
    Result := AVERROR_EXIT;
end;

(** Initialize one data packet for reading or writing. *)
procedure init_packet(packet: PAVPacket);
begin
  av_init_packet(packet);
  (** Set the packet data and size so that it is recognized as being empty. *)
  packet.data := nil;
  packet.size := 0;
end;

(** Initialize one audio frame for reading from the input file *)
function init_input_frame(frame: PPAVFrame): Integer;
begin
  frame^ := av_frame_alloc();
  if not Assigned(frame^) then
  begin
    Writeln(ErrOutput, 'Could not allocate input frame');
    Result := AVERROR_ENOMEM;
  end
  else
    Result := 0;
end;

(**
 * Initialize the audio resampler based on the input and output codec settings.
 * If the input and output sample formats differ, a conversion is required
 * libswresample takes care of this, but requires initialization.
 *)
function init_resampler(input_codec_context: PAVCodecContext;
  output_codec_context: PAVCodecContext;
  resample_context: PPSwrContext): Integer;
var
  error: Integer;
begin
  (**
   * Create a resampler context for the conversion.
   * Set the conversion parameters.
   * Default channel layouts based on the number of channels
   * are assumed for simplicity (they are sometimes not detected
   * properly by the demuxer and/or decoder).
   *)
  resample_context^ := swr_alloc_set_opts(nil,
                                        av_get_default_channel_layout(output_codec_context.channels),
                                        output_codec_context.sample_fmt,
                                        output_codec_context.sample_rate,
                                        av_get_default_channel_layout(input_codec_context.channels),
                                        input_codec_context.sample_fmt,
                                        input_codec_context.sample_rate,
                                        0, nil);
  if not Assigned(resample_context^) then
  begin
    Writeln(ErrOutput, 'Could not allocate resample context');
    Result := AVERROR_ENOMEM;
    Exit;
  end;
  (**
  * Perform a sanity check so that the number of converted samples is
  * not greater than the number of samples to be converted.
  * If the sample rates differ, this case has to be handled differently
  *)
  Assert(output_codec_context.sample_rate = input_codec_context.sample_rate);

  (** Open the resampler with the specified parameters. *)
  error := swr_init(resample_context^);
  if error < 0 then
  begin
    Writeln(ErrOutput, 'Could not open resample context');
    swr_free(resample_context);
    Result := error;
    Exit;
  end;
  Result := 0;
end;

type
  PPAVAudioFifo = ^PAVAudioFifo;

(** Initialize a FIFO buffer for the audio samples to be encoded. *)
function init_fifo(fifo: PPAVAudioFifo; output_codec_context: PAVCodecContext): Integer;
begin
  (** Create the FIFO buffer based on the specified output sample format. *)
  fifo^ := av_audio_fifo_alloc(output_codec_context.sample_fmt,
                               output_codec_context.channels, 1);
  if not Assigned(fifo^) then
  begin
    Writeln(ErrOutput, 'Could not allocate FIFO');
    Result := AVERROR_ENOMEM;
  end
  else
    Result := 0;
end;

(** Write the header of the output file container. *)
function write_output_file_header(output_format_context: PAVFormatContext): Integer;
var
  error: Integer;
begin
  error := avformat_write_header(output_format_context, nil);
  if error < 0 then
  begin
    Writeln(ErrOutput, Format('Could not write output file header (error ''%s'')',
            [av_err2str(error)]));
    Result := error;
  end
  else
    Result := 0;
end;

(** Decode one audio frame from the input file. *)
function decode_audio_frame(frame: PAVFrame;
  input_format_context: PAVFormatContext;
  input_codec_context: PAVCodecContext;
  data_present, finished: PInteger): Integer;
var
  (** Packet used for temporary storage. *)
  input_packet: TAVPacket;
  error: Integer;
begin
  init_packet(@input_packet);

  (** Read one audio frame from the input file into a temporary packet. *)
  error := av_read_frame(input_format_context, @input_packet);
  if error < 0 then
  begin
    (** If we are at the end of the file, flush the decoder below. *)
    if error = AVERROR_EOF then
      finished^ := 1
    else
    begin
      Writeln(ErrOutput, Format('Could not read frame (error ''%s'')',
              [av_err2str(error)]));
      Result := error;
      Exit;
    end;
  end;

  (**
   * Decode the audio frame stored in the temporary packet.
   * The input audio stream decoder is used to do this.
   * If we are at the end of the file, pass an empty packet to the decoder
   * to flush it.
   *)
  error := avcodec_decode_audio4(input_codec_context, frame,
                                     data_present, @input_packet);
  if error < 0 then
  begin
    Writeln(ErrOutput, Format('Could not decode frame (error ''%s'')',
            [av_err2str(error)]));
    av_packet_unref(@input_packet);
    Result := error;
    Exit;
  end;

  (**
   * If the decoder has not been flushed completely, we are not finished,
   * so that this function has to be called again.
   *)
  if (finished^ <> 0) and (data_present^ <> 0) then
    finished^ := 0;
  av_packet_unref(@input_packet);
  Result := 0;
end;

(**
 * Initialize a temporary storage for the specified number of audio samples.
 * The conversion requires temporary storage due to the different format.
 * The number of audio samples to be allocated is specified in frame_size.
 *)
function init_converted_samples(converted_input_samples: PPPByte;
  output_codec_context: PAVCodecContext;
  frame_size: Integer): Integer;
var
  error: Integer;
begin
  (**
   * Allocate as many pointers as there are audio channels.
   * Each pointer will later point to the audio samples of the corresponding
   * channels (although it may be nil for interleaved formats).
   *)
  converted_input_samples^ := av_calloc(output_codec_context.channels,
                                          SizeOf(converted_input_samples^^));
  if not Assigned(converted_input_samples^) then
  begin
    Writeln(ErrOutput, 'Could not allocate converted input sample pointers');
    Result := AVERROR_ENOMEM;
    Exit;
  end;

  (**
   * Allocate memory for the samples of all channels in one consecutive
   * block for convenience.
   *)
  error := av_samples_alloc(converted_input_samples^, nil,
                                output_codec_context.channels,
                                frame_size,
                                output_codec_context.sample_fmt, 0);
  if error < 0 then
  begin
    Writeln(ErrOutput,
            Format('Could not allocate converted input samples (error ''%s'')',
            [av_err2str(error)]));
    av_freep(@converted_input_samples^^);
    av_free(converted_input_samples^);
    Result := error;
    Exit;
  end;
  Result := 0;
end;

(**
 * Convert the input audio samples into the output sample format.
 * The conversion happens on a per-frame basis, the size of which is specified
 * by frame_size.
 *)
function convert_samples(const input_data: PPByte;
  converted_data: PPByte; const frame_size: Integer;
  resample_context: PSwrContext): Integer;
var
  error: Integer;
begin
  (** Convert the samples using the resampler. *)
  error := swr_convert(resample_context,
                           converted_data, frame_size,
                           input_data    , frame_size);
  if error < 0 then
  begin
    Writeln(ErrOutput, Format('Could not convert input samples (error ''%s'')',
            [av_err2str(error)]));
    Result := error;
    Exit;
  end;

  Result := 0;
end;

(** Add converted input audio samples to the FIFO buffer for later processing. *)
function add_samples_to_fifo(fifo: PAVAudioFifo;
  converted_input_samples: PPByte;
  const frame_size: Integer): Integer;
var
  error: Integer;
begin
  (**
   * Make the FIFO as large as it needs to be to hold both,
   * the old and the new samples.
   *)
  error := av_audio_fifo_realloc(fifo, av_audio_fifo_size(fifo) + frame_size);
  if error < 0 then
  begin
    Writeln(ErrOutput, 'Could not reallocate FIFO');
    Result := error;
    Exit;
  end;

  (** Store the new samples in the FIFO buffer. *)
  if av_audio_fifo_write(fifo, PPointer(converted_input_samples),
                          frame_size) < frame_size then
  begin
    Writeln(ErrOutput, 'Could not write data to FIFO');
    Result := AVERROR_EXIT;
    Exit;
  end;
  Result := 0;
end;

(**
 * Read one audio frame from the input file, decodes, converts and stores
 * it in the FIFO buffer.
 *)
function read_decode_convert_and_store(fifo: PAVAudioFifo;
  input_format_context: PAVFormatContext;
  input_codec_context: PAVCodecContext;
  output_codec_context: PAVCodecContext;
  resampler_context: PSwrContext;
  finished: PInteger): Integer;
var
  (** Temporary storage of the input samples of the frame read from the file. *)
  input_frame: PAVFrame;
  (** Temporary storage for the converted input samples. *)
  converted_input_samples: PPByte;
  data_present: Integer;
  ret: Integer;
label
  cleanup;
begin
  input_frame := nil;
  converted_input_samples := nil;
  ret := AVERROR_EXIT;

  if init_input_frame(@input_frame) <> 0 then
    goto cleanup;
  (** Decode one frame worth of audio samples. *)
  if decode_audio_frame(input_frame, input_format_context,
                         input_codec_context, @data_present, finished) <> 0 then
    goto cleanup;
  (**
   * If we are at the end of the file and there are no more samples
   * in the decoder which are delayed, we are actually finished.
   * This must not be treated as an error.
   *)
  if (finished^ <> 0) and (data_present = 0) then
  begin
    ret := 0;
    goto cleanup;
  end;
  (** If there is decoded data, convert and store it *)
  if data_present <> 0 then
  begin
    (** Initialize the temporary storage for the converted input samples. *)
    if init_converted_samples(@converted_input_samples, output_codec_context,
                               input_frame.nb_samples) <> 0 then
      goto cleanup;

    (**
     * Convert the input samples to the desired output sample format.
     * This requires a temporary storage provided by converted_input_samples.
     *)
    if convert_samples(PPByte(input_frame.extended_data), converted_input_samples,
                        input_frame.nb_samples, resampler_context) <> 0 then
      goto cleanup;

    (** Add the converted input samples to the FIFO buffer for later processing. *)
    if add_samples_to_fifo(fifo, converted_input_samples,
                            input_frame.nb_samples) <> 0 then
      goto cleanup;
  end;
  ret := 0;

cleanup:
  if Assigned(converted_input_samples) then
  begin
    av_freep(@converted_input_samples^);
    av_free(converted_input_samples);
  end;
  av_frame_free(@input_frame);

  Result := ret;
end;

(**
 * Initialize one input frame for writing to the output file.
 * The frame will be exactly frame_size samples large.
 *)
function init_output_frame(frame: PPAVFrame;
  output_codec_context: PAVCodecContext;
  frame_size: Integer): Integer;
var
  error: Integer;
begin
  (** Create a new frame to store the audio samples. *)
  frame^ := av_frame_alloc();
  if not Assigned(frame^) then
  begin
    Writeln(ErrOutput, 'Could not allocate output frame');
    Result := AVERROR_EXIT;
    Exit;
  end;

  (**
   * Set the frame's parameters, especially its size and format.
   * av_frame_get_buffer needs this to allocate memory for the
   * audio samples of the frame.
   * Default channel layouts based on the number of channels
   * are assumed for simplicity.
   *)
  frame^.nb_samples     := frame_size;
  frame^.channel_layout := output_codec_context.channel_layout;
  frame^.format         := Ord(output_codec_context.sample_fmt);
  frame^.sample_rate    := output_codec_context.sample_rate;

  (**
   * Allocate the samples of the created frame. This call will make
   * sure that the audio frame can hold as many samples as specified.
   *)
  error := av_frame_get_buffer(frame^, 0);
  if error < 0 then
  begin
    Writeln(ErrOutput, Format('Could not allocate output frame samples (error ''%s'')',
            [av_err2str(error)]));
    av_frame_free(frame);
    Result := error;
    Exit;
  end;

  Result := 0;
end;

(** Global timestamp for the audio frames *)
var
  pts: Int64 = 0;

(** Encode one frame worth of audio to the output file. *)
function encode_audio_frame(frame: PAVFrame;
  output_format_context: PAVFormatContext;
  output_codec_context: PAVCodecContext;
  data_present: PInteger): Integer;
var
  (** Packet used for temporary storage. *)
  output_packet: TAVPacket;
  error: Integer;
begin
  init_packet(@output_packet);

  (** Set a timestamp based on the sample rate for the container. *)
  if Assigned(frame) then
  begin
    frame.pts := pts;
    Inc(pts, frame.nb_samples);
  end;

  (**
   * Encode the audio frame and store it in the temporary packet.
   * The output audio stream encoder is used to do this.
   *)
  error := avcodec_encode_audio2(output_codec_context, @output_packet,
                                     frame, data_present);
  if error < 0 then
  begin
    Writeln(ErrOutput, Format('Could not encode frame (error ''%s'')',
            [av_err2str(error)]));
    av_packet_unref(@output_packet);
    Result := error;
    Exit;
  end;

  (** Write one audio frame from the temporary packet to the output file. *)
  if data_present^ <> 0 then
  begin
    error := av_write_frame(output_format_context, @output_packet);
    if error < 0 then
    begin
      Writeln(ErrOutput, Format('Could not write frame (error ''%s'')',
              [av_err2str(error)]));
      av_packet_unref(@output_packet);
      Result := error;
      Exit;
    end;

    av_packet_unref(@output_packet);
  end;

  Result := 0;
end;

(**
 * Load one audio frame from the FIFO buffer, encode and write it to the
 * output file.
 *)
function load_encode_and_write(fifo: PAVAudioFifo;
  output_format_context: PAVFormatContext;
  output_codec_context: PAVCodecContext): Integer;
var
  (** Temporary storage of the output samples of the frame written to the file. *)
  output_frame: PAVFrame;
  frame_size: Integer;
  data_written: Integer;
begin
  (**
   * Use the maximum number of possible samples per frame.
   * If there is less than the maximum possible frame size in the FIFO
   * buffer use this number. Otherwise, use the maximum possible frame size
   *)
  frame_size := av_audio_fifo_size(fifo);
  if frame_size > output_codec_context.frame_size then
    frame_size := output_codec_context.frame_size;

  (** Initialize temporary storage for one output frame. *)
  if init_output_frame(@output_frame, output_codec_context, frame_size) <> 0 then
  begin
    Result := AVERROR_EXIT;
    Exit;
  end;

  (**
   * Read as many samples from the FIFO buffer as required to fill the frame.
   * The samples are stored in the frame temporarily.
   *)
  if av_audio_fifo_read(fifo, PPointer(@output_frame.data[0]), frame_size) < frame_size then
  begin
    Writeln(ErrOutput, 'Could not read data from FIFO');
    av_frame_free(@output_frame);
    Result := AVERROR_EXIT;
    Exit;
  end;

  (** Encode one frame worth of audio samples. *)
  if encode_audio_frame(output_frame, output_format_context,
                         output_codec_context, @data_written) <> 0 then
  begin
    av_frame_free(@output_frame);
    Result := AVERROR_EXIT;
    Exit;
  end;
  av_frame_free(@output_frame);
  Result := 0;
end;

(** Write the trailer of the output file container. *)
function write_output_file_trailer(output_format_context: PAVFormatContext): Integer;
var
  error: Integer;
begin
  error := av_write_trailer(output_format_context);
  if error < 0 then
  begin
    Writeln(ErrOutput, Format('Could not write output file trailer (error ''%s'')',
            [av_err2str(error)]));
    Result := error;
  end
  else
    Result := 0;
end;

(** Convert an audio file to an AAC file in an MP4 container. *)
function main(): Integer;
var
  input_format_context, output_format_context: PAVFormatContext;
  input_codec_context, output_codec_context: PAVCodecContext;
  resample_context: PSwrContext;
  fifo: PAVAudioFifo;
  ret: Integer;
  output_frame_size: Integer;
  finished: Integer;
  data_written: Integer;
label
  cleanup;
begin
  input_format_context := nil;
  output_format_context := nil;
  input_codec_context := nil;
  output_codec_context := nil;
  resample_context := nil;
  fifo := nil;
  ret := AVERROR_EXIT;

  if ParamCount < 2 then
  begin
    Writeln(ErrOutput, Format('Usage: %s <input file> <output file>', [ExtractFileName(ParamStr(0))]));
    Result := 1;
    Exit;
  end;

  (** Register all codecs and formats so that they can be used. *)
  av_register_all();
  (** Open the input file for reading. *)
  if open_input_file(PAnsiChar(AnsiString(ParamStr(1))), @input_format_context,
                      @input_codec_context) <> 0 then
    goto cleanup;
  (** Open the output file for writing. *)
  if open_output_file(PAnsiChar(AnsiString(ParamStr(2))), input_codec_context,
                       @output_format_context, @output_codec_context) <> 0 then
    goto cleanup;
  (** Initialize the resampler to be able to convert audio sample formats. *)
  if init_resampler(input_codec_context, output_codec_context,
                     @resample_context) <> 0 then
    goto cleanup;
  (** Initialize the FIFO buffer to store audio samples to be encoded. *)
  if init_fifo(@fifo, output_codec_context) <> 0 then
    goto cleanup;
  (** Write the header of the output file container. *)
  if write_output_file_header(output_format_context) <> 0 then
    goto cleanup;

  (**
   * Loop as long as we have input samples to read or output samples
   * to write; abort as soon as we have neither.
   *)
  while True do
  begin
    (** Use the encoder's desired frame size for processing. *)
    output_frame_size := output_codec_context.frame_size;
    finished          := 0;

    (**
     * Make sure that there is one frame worth of samples in the FIFO
     * buffer so that the encoder can do its work.
     * Since the decoder's and the encoder's frame size may differ, we
     * need to FIFO buffer to store as many frames worth of input samples
     * that they make up at least one frame worth of output samples.
     *)
    while av_audio_fifo_size(fifo) < output_frame_size do
    begin
      (**
       * Decode one frame worth of audio samples, convert it to the
       * output sample format and put it into the FIFO buffer.
       *)
      if read_decode_convert_and_store(fifo, input_format_context,
                                        input_codec_context,
                                        output_codec_context,
                                        resample_context, @finished) <> 0 then
        goto cleanup;

      (**
       * If we are at the end of the input file, we continue
       * encoding the remaining audio samples to the output file.
       *)
      if finished <> 0 then
        Break;
    end;

    (**
     * If we have enough samples for the encoder, we encode them.
     * At the end of the file, we pass the remaining samples to
     * the encoder.
     *)
    while (av_audio_fifo_size(fifo) >= output_frame_size) or
          ((finished <> 0) and (av_audio_fifo_size(fifo) > 0)) do
      (**
       * Take one frame worth of audio samples from the FIFO buffer,
       * encode it and write it to the output file.
       *)
      if load_encode_and_write(fifo, output_format_context,
                                output_codec_context) <> 0 then
        goto cleanup;

    (**
     * If we are at the end of the input file and have encoded
     * all remaining samples, we can exit this loop and finish.
     *)
    if finished <> 0 then
    begin
      data_written := 0;
      (** Flush the encoder as it may have delayed frames. *)
      repeat
        if encode_audio_frame(nil, output_format_context,
                               output_codec_context, @data_written) <> 0 then
          goto cleanup;
      until data_written = 0;
      Break;
    end;
  end;

  (** Write the trailer of the output file container. *)
  if write_output_file_trailer(output_format_context) <> 0 then
    goto cleanup;

  ret := 0;

cleanup:
  if Assigned(fifo) then
    av_audio_fifo_free(fifo);
  swr_free(@resample_context);
  if Assigned(output_codec_context) then
    avcodec_free_context(@output_codec_context);
  if Assigned(output_format_context) then
  begin
    avio_closep(@output_format_context.pb);
    avformat_free_context(output_format_context);
  end;
  if Assigned(input_codec_context) then
    avcodec_free_context(@input_codec_context);
  if Assigned(input_format_context) then
    avformat_close_input(@input_format_context);

  Result := Ord(ret < 0);
end;

begin
  try
    ExitCode := main();
  except
    on E: Exception do
      Writeln(ErrOutput, E.ClassName, ': ', E.Message);
  end;
end.
