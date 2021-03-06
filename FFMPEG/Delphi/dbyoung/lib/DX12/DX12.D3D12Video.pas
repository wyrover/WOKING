unit DX12.D3D12Video;

{ **************************************************************************
  Copyright 2017 Norbert Sonnleitner

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
   SOFTWARE.
  ************************************************************************** }

{ **************************************************************************
  Additional Copyright (C) for this modul:

  Copyright (c) Microsoft Corporation.  All rights reserved.

  This unit consists of the following header files
  File name: D3D12Video.h
  Header version: 10.0.16299.0

  ************************************************************************** }

{$mode delphi}

interface

uses
    Windows, Classes, SysUtils, DX12.DXGI, DX12.D3D12;

const
    IID_ID3D12VideoDecoderHeap: TGUID = '{0946B7C9-EBF6-4047-BB73-8683E27DBB1F}';
    IID_ID3D12VideoDevice: TGUID = '{1F052807-0B46-4ACC-8A89-364F793718A4}';
    IID_ID3D12VideoDecoder: TGUID = '{C59B6BDC-7720-4074-A136-17A156037470}';
    IID_ID3D12VideoProcessor: TGUID = '{304FDB32-BEDE-410A-8545-943AC6A46138}';
    IID_ID3D12VideoDecodeCommandList: TGUID = '{3B60536E-AD29-4E64-A269-F853837E5E53}';
    IID_ID3D12VideoProcessCommandList: TGUID = '{AEB2543A-167F-4682-ACC8-D159ED4A6209}';

    D3D12_VIDEO_DECODE_PROFILE_MPEG2: TGUID = '{ee27417f-5e28-4e65-beea-1d26b508adc9}';
    D3D12_VIDEO_DECODE_PROFILE_MPEG1_AND_MPEG2: TGUID = '{86695f12-340e-4f04-9fd3-9253dd327460}';
    D3D12_VIDEO_DECODE_PROFILE_H264: TGUID = '{1b81be68-a0c7-11d3-b984-00c04f2e73c5}';
    D3D12_VIDEO_DECODE_PROFILE_H264_STEREO_PROGRESSIVE: TGUID = '{d79be8da-0cf1-4c81-b82a-69a4e236f43d}';
    D3D12_VIDEO_DECODE_PROFILE_H264_STEREO: TGUID = '{f9aaccbb-c2b6-4cfc-8779-5707b1760552}';
    D3D12_VIDEO_DECODE_PROFILE_H264_MULTIVIEW: TGUID = '{705b9d82-76cf-49d6-b7e6-ac8872db013c}';
    D3D12_VIDEO_DECODE_PROFILE_VC1: TGUID = '{1b81beA3-a0c7-11d3-b984-00c04f2e73c5}';
    D3D12_VIDEO_DECODE_PROFILE_VC1_D2010: TGUID = '{1b81beA4-a0c7-11d3-b984-00c04f2e73c5}';
    D3D12_VIDEO_DECODE_PROFILE_MPEG4PT2_SIMPLE: TGUID = '{efd64d74-c9e8-41d7-a5e9-e9b0e39fa319}';
    D3D12_VIDEO_DECODE_PROFILE_MPEG4PT2_ADVSIMPLE_NOGMC: TGUID = '{ed418a9f-010d-4eda-9ae3-9a65358d8d2e}';
    D3D12_VIDEO_DECODE_PROFILE_HEVC_MAIN: TGUID = '{5b11d51b-2f4c-4452-bcc3-09f2a1160cc0}';
    D3D12_VIDEO_DECODE_PROFILE_HEVC_MAIN10: TGUID = '{107af0e0-ef1a-4d19-aba8-67a163073d13}';
    D3D12_VIDEO_DECODE_PROFILE_VP9: TGUID = '{463707f8-a1d0-4585-876d-83aa6d60b89e}';
    D3D12_VIDEO_DECODE_PROFILE_VP9_10BIT_PROFILE2: TGUID = '{a4c749ef-6ecf-48aa-8448-50a7a1165ff7}';
    D3D12_VIDEO_DECODE_PROFILE_VP8: TGUID = '{90b899ea-3a62-4705-88b3-8df04b2744e7}';

type

    TD3D12_VIDEO_FIELD_TYPE = (
        D3D12_VIDEO_FIELD_TYPE_NONE = 0,
        D3D12_VIDEO_FIELD_TYPE_INTERLACED_TOP_FIELD_FIRST = 1,
        D3D12_VIDEO_FIELD_TYPE_INTERLACED_BOTTOM_FIELD_FIRST = 2
        );

    TD3D12_VIDEO_FRAME_STEREO_FORMAT = (
        D3D12_VIDEO_FRAME_STEREO_FORMAT_NONE = 0,
        D3D12_VIDEO_FRAME_STEREO_FORMAT_MONO = 1,
        D3D12_VIDEO_FRAME_STEREO_FORMAT_HORIZONTAL = 2,
        D3D12_VIDEO_FRAME_STEREO_FORMAT_VERTICAL = 3,
        D3D12_VIDEO_FRAME_STEREO_FORMAT_SEPARATE = 4
        );

    TD3D12_VIDEO_FORMAT = record
        Format: TDXGI_FORMAT;
        ColorSpace: TDXGI_COLOR_SPACE_TYPE;
    end;
    PD3D12_VIDEO_FORMAT = ^TD3D12_VIDEO_FORMAT;

    TD3D12_VIDEO_SAMPLE = record
        Width: UINT;
        Height: UINT;
        Format: TD3D12_VIDEO_FORMAT;
    end;
    PD3D12_VIDEO_SAMPLE = ^TD3D12_VIDEO_SAMPLE;

    TD3D12_VIDEO_FRAME_CODED_INTERLACE_TYPE = (
        D3D12_VIDEO_FRAME_CODED_INTERLACE_TYPE_NONE = 0,
        D3D12_VIDEO_FRAME_CODED_INTERLACE_TYPE_FIELD_BASED = 1
        );

    TD3D12_FEATURE_VIDEO = (
        D3D12_FEATURE_VIDEO_DECODE_SUPPORT = 0,
        D3D12_FEATURE_VIDEO_DECODE_PROFILES = 1,
        D3D12_FEATURE_VIDEO_DECODE_FORMATS = 2,
        D3D12_FEATURE_VIDEO_DECODE_CONVERSION_SUPPORT = 3,
        D3D12_FEATURE_VIDEO_PROCESS_SUPPORT = 5,
        D3D12_FEATURE_VIDEO_PROCESS_MAX_INPUT_STREAMS = 6,
        D3D12_FEATURE_VIDEO_PROCESS_REFERENCE_INFO = 7,
        D3D12_FEATURE_VIDEO_DECODER_HEAP_SIZE = 8,
        D3D12_FEATURE_VIDEO_PROCESSOR_SIZE = 9,
        D3D12_FEATURE_VIDEO_DECODE_PROFILE_COUNT = 10,
        D3D12_FEATURE_VIDEO_DECODE_FORMAT_COUNT = 11,
        D3D12_FEATURE_VIDEO_ARCHITECTURE = 17
        );

    TD3D12_BITSTREAM_ENCRYPTION_TYPE = (
        D3D12_BITSTREAM_ENCRYPTION_TYPE_NONE = 0
        );

    TD3D12_VIDEO_DECODE_CONFIGURATION = record
        DecodeProfile: TGUID;
        BitstreamEncryption: TD3D12_BITSTREAM_ENCRYPTION_TYPE;
        InterlaceType: TD3D12_VIDEO_FRAME_CODED_INTERLACE_TYPE;
    end;
    PD3D12_VIDEO_DECODE_CONFIGURATION = ^TD3D12_VIDEO_DECODE_CONFIGURATION;

    TD3D12_VIDEO_DECODER_DESC = record
        NodeMask: UINT;
        Configuration: TD3D12_VIDEO_DECODE_CONFIGURATION;
    end;
    PD3D12_VIDEO_DECODER_DESC = ^TD3D12_VIDEO_DECODER_DESC;

    TD3D12_VIDEO_DECODER_HEAP_DESC = record
        NodeMask: UINT;
        Configuration: TD3D12_VIDEO_DECODE_CONFIGURATION;
        DecodeWidth: UINT;
        DecodeHeight: UINT;
        Format: TDXGI_FORMAT;
        FrameRate: TDXGI_RATIONAL;
        BitRate: UINT;
        MaxDecodePictureBufferCount: UINT;
    end;
    PD3D12_VIDEO_DECODER_HEAP_DESC = ^TD3D12_VIDEO_DECODER_HEAP_DESC;

    TD3D12_VIDEO_SIZE_RANGE = record
        MaxWidth: UINT;
        MaxHeight: UINT;
        MinWidth: UINT;
        MinHeight: UINT;
    end;
    PD3D12_VIDEO_SIZE_RANGE = ^TD3D12_VIDEO_SIZE_RANGE;

    TD3D12_VIDEO_PROCESS_FILTER = (
        D3D12_VIDEO_PROCESS_FILTER_BRIGHTNESS = 0,
        D3D12_VIDEO_PROCESS_FILTER_CONTRAST = 1,
        D3D12_VIDEO_PROCESS_FILTER_HUE = 2,
        D3D12_VIDEO_PROCESS_FILTER_SATURATION = 3,
        D3D12_VIDEO_PROCESS_FILTER_NOISE_REDUCTION = 4,
        D3D12_VIDEO_PROCESS_FILTER_EDGE_ENHANCEMENT = 5,
        D3D12_VIDEO_PROCESS_FILTER_ANAMORPHIC_SCALING = 6,
        D3D12_VIDEO_PROCESS_FILTER_STEREO_ADJUSTMENT = 7
        );

    TD3D12_VIDEO_PROCESS_FILTER_FLAGS = (
        D3D12_VIDEO_PROCESS_FILTER_FLAG_NONE = 0,
        D3D12_VIDEO_PROCESS_FILTER_FLAG_BRIGHTNESS = (1 shl Ord(D3D12_VIDEO_PROCESS_FILTER_BRIGHTNESS)),
        D3D12_VIDEO_PROCESS_FILTER_FLAG_CONTRAST = (1 shl Ord(D3D12_VIDEO_PROCESS_FILTER_CONTRAST)),
        D3D12_VIDEO_PROCESS_FILTER_FLAG_HUE = (1 shl Ord(D3D12_VIDEO_PROCESS_FILTER_HUE)),
        D3D12_VIDEO_PROCESS_FILTER_FLAG_SATURATION = (1 shl Ord(D3D12_VIDEO_PROCESS_FILTER_SATURATION)),
        D3D12_VIDEO_PROCESS_FILTER_FLAG_NOISE_REDUCTION = (1 shl Ord(D3D12_VIDEO_PROCESS_FILTER_NOISE_REDUCTION)),
        D3D12_VIDEO_PROCESS_FILTER_FLAG_EDGE_ENHANCEMENT = (1 shl Ord(D3D12_VIDEO_PROCESS_FILTER_EDGE_ENHANCEMENT)),
        D3D12_VIDEO_PROCESS_FILTER_FLAG_ANAMORPHIC_SCALING = (1 shl Ord(D3D12_VIDEO_PROCESS_FILTER_ANAMORPHIC_SCALING)),
        D3D12_VIDEO_PROCESS_FILTER_FLAG_STEREO_ADJUSTMENT = (1 shl Ord(D3D12_VIDEO_PROCESS_FILTER_STEREO_ADJUSTMENT))
        );


    TD3D12_VIDEO_PROCESS_DEINTERLACE_FLAGS = (
        D3D12_VIDEO_PROCESS_DEINTERLACE_FLAG_NONE = 0,
        D3D12_VIDEO_PROCESS_DEINTERLACE_FLAG_BOB = $1,
        D3D12_VIDEO_PROCESS_DEINTERLACE_FLAG_CUSTOM = $80000000
        );


    TD3D12_VIDEO_PROCESS_ALPHA_BLENDING = record
        Enable: boolean;
        Alpha: single;
    end;
    PD3D12_VIDEO_PROCESS_ALPHA_BLENDING = ^TD3D12_VIDEO_PROCESS_ALPHA_BLENDING;

    TD3D12_VIDEO_PROCESS_LUMA_KEY = record
        Enable: boolean;
        Lower: single;
        Upper: single;
    end;
    PD3D12_VIDEO_PROCESS_LUMA_KEY = ^TD3D12_VIDEO_PROCESS_LUMA_KEY;

    TD3D12_VIDEO_PROCESS_INPUT_STREAM_DESC = record
        Format: TDXGI_FORMAT;
        ColorSpace: TDXGI_COLOR_SPACE_TYPE;
        SourceAspectRatio: TDXGI_RATIONAL;
        DestinationAspectRatio: TDXGI_RATIONAL;
        FrameRate: TDXGI_RATIONAL;
        SourceSizeRange: TD3D12_VIDEO_SIZE_RANGE;
        DestinationSizeRange: TD3D12_VIDEO_SIZE_RANGE;
        EnableOrientation: boolean;
        FilterFlags: TD3D12_VIDEO_PROCESS_FILTER_FLAGS;
        StereoFormat: TD3D12_VIDEO_FRAME_STEREO_FORMAT;
        FieldType: TD3D12_VIDEO_FIELD_TYPE;
        DeinterlaceMode: TD3D12_VIDEO_PROCESS_DEINTERLACE_FLAGS;
        EnableAlphaBlending: boolean;
        LumaKey: TD3D12_VIDEO_PROCESS_LUMA_KEY;
        NumPastFrames: UINT;
        NumFutureFrames: UINT;
        EnableAutoProcessing: boolean;
    end;
    PD3D12_VIDEO_PROCESS_INPUT_STREAM_DESC = ^TD3D12_VIDEO_PROCESS_INPUT_STREAM_DESC;

    TD3D12_VIDEO_PROCESS_ALPHA_FILL_MODE = (
        D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE_OPAQUE = 0,
        D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE_BACKGROUND = 1,
        D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE_DESTINATION = 2,
        D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE_SOURCE_STREAM = 3
        );

    TD3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC = record
        Format: TDXGI_FORMAT;
        ColorSpace: TDXGI_COLOR_SPACE_TYPE;
        AlphaFillMode: TD3D12_VIDEO_PROCESS_ALPHA_FILL_MODE;
        AlphaFillModeSourceStreamIndex: UINT;
        BackgroundColor: array [0..3] of single;
        FrameRate: TDXGI_RATIONAL;
        EnableStereo: boolean;
    end;
    PD3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC = ^TD3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC;




    ID3D12VideoDecoderHeap = interface(ID3D12Pageable)
        ['{0946B7C9-EBF6-4047-BB73-8683E27DBB1F}']
        function GetDesc(): TD3D12_VIDEO_DECODER_HEAP_DESC; stdcall;
    end;

    PID3D12VideoDecoderHeap = ^ID3D12VideoDecoderHeap;



    ID3D12VideoDevice = interface(IUnknown)
        ['{1F052807-0B46-4ACC-8A89-364F793718A4}']
        function CheckFeatureSupport(FeatureVideo: TD3D12_FEATURE_VIDEO; var pFeatureSupportData: Pointer;
            FeatureSupportDataSize: UINT): HResult; stdcall;
        function CreateVideoDecoder(const pDesc: TD3D12_VIDEO_DECODER_DESC; const riid: TGUID; out ppVideoDecoder): HResult; stdcall;
        function CreateVideoDecoderHeap(const pVideoDecoderHeapDesc: TD3D12_VIDEO_DECODER_HEAP_DESC; const riid: TGUID;
            out ppVideoDecoderHeap): HResult; stdcall;
        function CreateVideoProcessor(NodeMask: UINT; const pOutputStreamDesc: TD3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC;
            NumInputStreamDescs: UINT; const pInputStreamDescs: PD3D12_VIDEO_PROCESS_INPUT_STREAM_DESC;
            const riid: TGUID; out ppVideoProcessor): HResult; stdcall;
    end;

    PID3D12VideoDevice = ^ID3D12VideoDevice;




    ID3D12VideoDecoder = interface(ID3D12Pageable)
        ['{C59B6BDC-7720-4074-A136-17A156037470}']
        function GetDesc(): TD3D12_VIDEO_DECODER_DESC; stdcall;
    end;

    PID3D12VideoDecoder = ^ID3D12VideoDecoder;


    TD3D12_VIDEO_DECODE_TIER = (
        D3D12_VIDEO_DECODE_TIER_NOT_SUPPORTED = 0,
        D3D12_VIDEO_DECODE_TIER_1 = 1,
        D3D12_VIDEO_DECODE_TIER_2 = 2,
        D3D12_VIDEO_DECODE_TIER_3 = 3
        );

    TD3D12_VIDEO_DECODE_SUPPORT_FLAGS = (
        D3D12_VIDEO_DECODE_SUPPORT_FLAG_NONE = 0,
        D3D12_VIDEO_DECODE_SUPPORT_FLAG_SUPPORTED = $1
        );


    TD3D12_VIDEO_DECODE_CONFIGURATION_FLAGS = (
        D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_NONE = 0,
        D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_HEIGHT_ALIGNMENT_MULTIPLE_32_REQUIRED = $1,
        D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_POST_PROCESSING_SUPPORTED = $2,
        D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_REFERENCE_ONLY_ALLOCATIONS_REQUIRED = $4,
        D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_ALLOW_RESOLUTION_CHANGE_ON_NON_KEY_FRAME = $8
        );


    TD3D12_VIDEO_DECODE_STATUS = (
        D3D12_VIDEO_DECODE_STATUS_OK = 0,
        D3D12_VIDEO_DECODE_STATUS_CONTINUE = 1,
        D3D12_VIDEO_DECODE_STATUS_CONTINUE_SKIP_DISPLAY = 2,
        D3D12_VIDEO_DECODE_STATUS_RESTART = 3
        );

    TD3D12_VIDEO_DECODE_ARGUMENT_TYPE = (
        D3D12_VIDEO_DECODE_ARGUMENT_TYPE_PICTURE_PARAMETERS = 0,
        D3D12_VIDEO_DECODE_ARGUMENT_TYPE_INVERSE_QUANTIZATION_MATRIX = 1,
        D3D12_VIDEO_DECODE_ARGUMENT_TYPE_SLICE_CONTROL = 2,
        D3D12_VIDEO_DECODE_ARGUMENT_TYPE_MAX_VALID = 3
        );

    TD3D12_FEATURE_DATA_VIDEO_DECODE_SUPPORT = record
        NodeIndex: UINT;
        Configuration: TD3D12_VIDEO_DECODE_CONFIGURATION;
        Width: UINT;
        Height: UINT;
        DecodeFormat: TDXGI_FORMAT;
        FrameRate: TDXGI_RATIONAL;
        BitRate: UINT;
        SupportFlags: TD3D12_VIDEO_DECODE_SUPPORT_FLAGS;
        ConfigurationFlags: TD3D12_VIDEO_DECODE_CONFIGURATION_FLAGS;
        DecodeTier: TD3D12_VIDEO_DECODE_TIER;
    end;
    PD3D12_FEATURE_DATA_VIDEO_DECODE_SUPPORT = ^TD3D12_FEATURE_DATA_VIDEO_DECODE_SUPPORT;

    TD3D12_FEATURE_DATA_VIDEO_DECODE_PROFILE_COUNT = record
        NodeIndex: UINT;
        ProfileCount: UINT;
    end;
    PD3D12_FEATURE_DATA_VIDEO_DECODE_PROFILE_COUNT = ^TD3D12_FEATURE_DATA_VIDEO_DECODE_PROFILE_COUNT;

    TD3D12_FEATURE_DATA_VIDEO_DECODE_PROFILES = record
        NodeIndex: UINT;
        ProfileCount: UINT;
        pProfiles: PGUID;
    end;
    PD3D12_FEATURE_DATA_VIDEO_DECODE_PROFILES = ^TD3D12_FEATURE_DATA_VIDEO_DECODE_PROFILES;

    TD3D12_FEATURE_DATA_VIDEO_DECODE_FORMAT_COUNT = record
        NodeIndex: UINT;
        Configuration: TD3D12_VIDEO_DECODE_CONFIGURATION;
        FormatCount: UINT;
    end;
    PD3D12_FEATURE_DATA_VIDEO_DECODE_FORMAT_COUNT = ^TD3D12_FEATURE_DATA_VIDEO_DECODE_FORMAT_COUNT;

    TD3D12_FEATURE_DATA_VIDEO_DECODE_FORMATS = record
        NodeIndex: UINT;
        Configuration: TD3D12_VIDEO_DECODE_CONFIGURATION;
        FormatCount: UINT;
        pOutputFormats: PDXGI_FORMAT;
    end;
    PD3D12_FEATURE_DATA_VIDEO_DECODE_FORMATS = ^TD3D12_FEATURE_DATA_VIDEO_DECODE_FORMATS;

    TD3D12_FEATURE_DATA_VIDEO_ARCHITECTURE = record
        IOCoherent: boolean;
    end;
    PD3D12_FEATURE_DATA_VIDEO_ARCHITECTURE = ^TD3D12_FEATURE_DATA_VIDEO_ARCHITECTURE;

    TD3D12_VIDEO_DECODE_CONVERSION_SUPPORT_FLAGS = (
        D3D12_VIDEO_DECODE_CONVERSION_SUPPORT_FLAG_NONE = 0,
        D3D12_VIDEO_DECODE_CONVERSION_SUPPORT_FLAG_SUPPORTED = $1
        );


    TD3D12_VIDEO_SCALE_SUPPORT_FLAGS = (
        D3D12_VIDEO_SCALE_SUPPORT_FLAG_NONE = 0,
        D3D12_VIDEO_SCALE_SUPPORT_FLAG_POW2_ONLY = $1,
        D3D12_VIDEO_SCALE_SUPPORT_FLAG_EVEN_DIMENSIONS_ONLY = $2
        );


    TD3D12_VIDEO_SCALE_SUPPORT = record
        OutputSizeRange: TD3D12_VIDEO_SIZE_RANGE;
        Flags: TD3D12_VIDEO_SCALE_SUPPORT_FLAGS;
    end;
    PD3D12_VIDEO_SCALE_SUPPORT = ^TD3D12_VIDEO_SCALE_SUPPORT;

    TD3D12_FEATURE_DATA_VIDEO_DECODE_CONVERSION_SUPPORT = record
        NodeIndex: UINT;
        Configuration: TD3D12_VIDEO_DECODE_CONFIGURATION;
        DecodeSample: TD3D12_VIDEO_SAMPLE;
        OutputFormat: TD3D12_VIDEO_FORMAT;
        FrameRate: TDXGI_RATIONAL;
        BitRate: UINT;
        SupportFlags: TD3D12_VIDEO_DECODE_CONVERSION_SUPPORT_FLAGS;
        ScaleSupport: TD3D12_VIDEO_SCALE_SUPPORT;
    end;
    PD3D12_FEATURE_DATA_VIDEO_DECODE_CONVERSION_SUPPORT = ^TD3D12_FEATURE_DATA_VIDEO_DECODE_CONVERSION_SUPPORT;

    TD3D12_FEATURE_DATA_VIDEO_DECODER_HEAP_SIZE = record
        VideoDecoderHeapDesc: TD3D12_VIDEO_DECODER_HEAP_DESC;
        MemoryPoolL0Size: UINT64;
        MemoryPoolL1Size: UINT64;
    end;
    PD3D12_FEATURE_DATA_VIDEO_DECODER_HEAP_SIZE = ^TD3D12_FEATURE_DATA_VIDEO_DECODER_HEAP_SIZE;

    TD3D12_FEATURE_DATA_VIDEO_PROCESSOR_SIZE = record
        NodeMask: UINT;
        pOutputStreamDesc: PD3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC;
        NumInputStreamDescs: UINT;
        pInputStreamDescs: PD3D12_VIDEO_PROCESS_INPUT_STREAM_DESC;
        MemoryPoolL0Size: UINT64;
        MemoryPoolL1Size: UINT64;
    end;
    PD3D12_FEATURE_DATA_VIDEO_PROCESSOR_SIZE = ^TD3D12_FEATURE_DATA_VIDEO_PROCESSOR_SIZE;

    TD3D12_QUERY_DATA_VIDEO_DECODE_STATISTICS = record
        Status: UINT64;
        NumMacroblocksAffected: UINT64;
        FrameRate: TDXGI_RATIONAL;
        BitRate: UINT;
    end;
    PD3D12_QUERY_DATA_VIDEO_DECODE_STATISTICS = ^TD3D12_QUERY_DATA_VIDEO_DECODE_STATISTICS;

    TD3D12_VIDEO_DECODE_SUB_SAMPLE_MAPPING_BLOCK = record
        ClearSize: UINT;
        EncryptedSize: UINT;
    end;
    PD3D12_VIDEO_DECODE_SUB_SAMPLE_MAPPING_BLOCK = ^TD3D12_VIDEO_DECODE_SUB_SAMPLE_MAPPING_BLOCK;

    TD3D12_VIDEO_DECODE_FRAME_ARGUMENT = record
        AType: TD3D12_VIDEO_DECODE_ARGUMENT_TYPE;
        Size: UINT;
        pData: Pointer;
    end;
    PD3D12_VIDEO_DECODE_FRAME_ARGUMENT = ^TD3D12_VIDEO_DECODE_FRAME_ARGUMENT;

    TD3D12_VIDEO_DECODE_REFERENCE_FRAMES = record
        NumTexture2Ds: UINT;
        ppTexture2Ds: PID3D12Resource;
        pSubresources: PUINT;
        ppHeaps: PID3D12VideoDecoderHeap;
    end;
    PD3D12_VIDEO_DECODE_REFERENCE_FRAMES = ^TD3D12_VIDEO_DECODE_REFERENCE_FRAMES;

    TD3D12_VIDEO_DECODE_COMPRESSED_BITSTREAM = record
        pBuffer: ID3D12Resource;
        Offset: UINT64;
        Size: UINT64;
    end;
    PD3D12_VIDEO_DECODE_COMPRESSED_BITSTREAM = ^TD3D12_VIDEO_DECODE_COMPRESSED_BITSTREAM;

    TD3D12_VIDEO_DECODE_CONVERSION_ARGUMENTS = record
        Enable: boolean;
        pReferenceTexture2D: ID3D12Resource;
        ReferenceSubresource: UINT;
        OutputColorSpace: TDXGI_COLOR_SPACE_TYPE;
        DecodeColorSpace: TDXGI_COLOR_SPACE_TYPE;
    end;
    PD3D12_VIDEO_DECODE_CONVERSION_ARGUMENTS = ^TD3D12_VIDEO_DECODE_CONVERSION_ARGUMENTS;

    TD3D12_VIDEO_DECODE_INPUT_STREAM_ARGUMENTS = record
        NumFrameArguments: UINT;
        FrameArguments: array [0..9] of TD3D12_VIDEO_DECODE_FRAME_ARGUMENT;
        ReferenceFrames: TD3D12_VIDEO_DECODE_REFERENCE_FRAMES;
        CompressedBitstream: TD3D12_VIDEO_DECODE_COMPRESSED_BITSTREAM;
        pHeap: ID3D12VideoDecoderHeap;
    end;
    PD3D12_VIDEO_DECODE_INPUT_STREAM_ARGUMENTS = ^TD3D12_VIDEO_DECODE_INPUT_STREAM_ARGUMENTS;

    TD3D12_VIDEO_DECODE_OUTPUT_STREAM_ARGUMENTS = record
        pOutputTexture2D: ID3D12Resource;
        OutputSubresource: UINT;
        ConversionArguments: TD3D12_VIDEO_DECODE_CONVERSION_ARGUMENTS;
    end;
    PD3D12_VIDEO_DECODE_OUTPUT_STREAM_ARGUMENTS = ^TD3D12_VIDEO_DECODE_OUTPUT_STREAM_ARGUMENTS;



    ID3D12VideoProcessor = interface(ID3D12Pageable)
        ['{304FDB32-BEDE-410A-8545-943AC6A46138}']
        function GetNodeMask(): UINT; stdcall;
        function GetNumInputStreamDescs(): UINT; stdcall;
        function GetInputStreamDescs(NumInputStreamDescs: UINT; out pInputStreamDescs: PD3D12_VIDEO_PROCESS_INPUT_STREAM_DESC): HResult;
            stdcall;
        function GetOutputStreamDesc(): TD3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC; stdcall;
    end;



    TD3D12_VIDEO_PROCESS_FEATURE_FLAGS = (
        D3D12_VIDEO_PROCESS_FEATURE_FLAG_NONE = 0,
        D3D12_VIDEO_PROCESS_FEATURE_FLAG_ALPHA_FILL = $1,
        D3D12_VIDEO_PROCESS_FEATURE_FLAG_LUMA_KEY = $2,
        D3D12_VIDEO_PROCESS_FEATURE_FLAG_STEREO = $4,
        D3D12_VIDEO_PROCESS_FEATURE_FLAG_ROTATION = $8,
        D3D12_VIDEO_PROCESS_FEATURE_FLAG_FLIP = $10,
        D3D12_VIDEO_PROCESS_FEATURE_FLAG_ALPHA_BLENDING = $20,
        D3D12_VIDEO_PROCESS_FEATURE_FLAG_PIXEL_ASPECT_RATIO = $40
        );


    TD3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAGS = (
        D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_NONE = 0,
        D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_DENOISE = $1,
        D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_DERINGING = $2,
        D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_EDGE_ENHANCEMENT = $4,
        D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_COLOR_CORRECTION = $8,
        D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_FLESH_TONE_MAPPING = $10,
        D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_IMAGE_STABILIZATION = $20,
        D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_SUPER_RESOLUTION = $40,
        D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_ANAMORPHIC_SCALING = $80,
        D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_CUSTOM = $80000000
        );


    TD3D12_VIDEO_PROCESS_ORIENTATION = (
        D3D12_VIDEO_PROCESS_ORIENTATION_DEFAULT = 0,
        D3D12_VIDEO_PROCESS_ORIENTATION_FLIP_HORIZONTAL = 1,
        D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_90 = 2,
        D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_90_FLIP_HORIZONTAL = 3,
        D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_180 = 4,
        D3D12_VIDEO_PROCESS_ORIENTATION_FLIP_VERTICAL = 5,
        D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_270 = 6,
        D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_270_FLIP_HORIZONTAL = 7
        );

    TD3D12_VIDEO_PROCESS_INPUT_STREAM_FLAGS = (
        D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAG_NONE = 0,
        D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAG_FRAME_DISCONTINUITY = $1,
        D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAG_FRAME_REPEAT = $2
        );


    TD3D12_VIDEO_PROCESS_FILTER_RANGE = record
        Minimum: INT32;
        Maximum: INT32;
        ADefault: INT32;
        Multiplier: single;
    end;
    PD3D12_VIDEO_PROCESS_FILTER_RANGE = ^TD3D12_VIDEO_PROCESS_FILTER_RANGE;

    TD3D12_VIDEO_PROCESS_SUPPORT_FLAGS = (
        D3D12_VIDEO_PROCESS_SUPPORT_FLAG_NONE = 0,
        D3D12_VIDEO_PROCESS_SUPPORT_FLAG_SUPPORTED = $1
        );


    TD3D12_FEATURE_DATA_VIDEO_PROCESS_SUPPORT = record
        NodeIndex: UINT;
        InputSample: TD3D12_VIDEO_SAMPLE;
        InputFieldType: TD3D12_VIDEO_FIELD_TYPE;
        InputStereoFormat: TD3D12_VIDEO_FRAME_STEREO_FORMAT;
        InputFrameRate: TDXGI_RATIONAL;
        OutputFormat: TD3D12_VIDEO_FORMAT;
        OutputStereoFormat: TD3D12_VIDEO_FRAME_STEREO_FORMAT;
        OutputFrameRate: TDXGI_RATIONAL;
        SupportFlags: TD3D12_VIDEO_PROCESS_SUPPORT_FLAGS;
        ScaleSupport: TD3D12_VIDEO_SCALE_SUPPORT;
        FeatureSupport: TD3D12_VIDEO_PROCESS_FEATURE_FLAGS;
        DeinterlaceSupport: TD3D12_VIDEO_PROCESS_DEINTERLACE_FLAGS;
        AutoProcessingSupport: TD3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAGS;
        FilterSupport: TD3D12_VIDEO_PROCESS_FILTER_FLAGS;
        FilterRangeSupport: array [0.. 31] of TD3D12_VIDEO_PROCESS_FILTER_RANGE;
    end;
    PD3D12_FEATURE_DATA_VIDEO_PROCESS_SUPPORT = ^TD3D12_FEATURE_DATA_VIDEO_PROCESS_SUPPORT;

    TD3D12_FEATURE_DATA_VIDEO_PROCESS_MAX_INPUT_STREAMS = record
        NodeIndex: UINT;
        MaxInputStreams: UINT;
    end;
    PD3D12_FEATURE_DATA_VIDEO_PROCESS_MAX_INPUT_STREAMS = ^TD3D12_FEATURE_DATA_VIDEO_PROCESS_MAX_INPUT_STREAMS;

    TD3D12_FEATURE_DATA_VIDEO_PROCESS_REFERENCE_INFO = record
        NodeIndex: UINT;
        DeinterlaceMode: TD3D12_VIDEO_PROCESS_DEINTERLACE_FLAGS;
        Filters: TD3D12_VIDEO_PROCESS_FILTER_FLAGS;
        FeatureSupport: TD3D12_VIDEO_PROCESS_FEATURE_FLAGS;
        InputFrameRate: TDXGI_RATIONAL;
        OutputFrameRate: TDXGI_RATIONAL;
        EnableAutoProcessing: boolean;
        PastFrames: UINT;
        FutureFrames: UINT;
    end;
    PD3D12_FEATURE_DATA_VIDEO_PROCESS_REFERENCE_INFO = ^TD3D12_FEATURE_DATA_VIDEO_PROCESS_REFERENCE_INFO;

    TD3D12_VIDEO_PROCESS_REFERENCE_SET = record
        NumPastFrames: UINT;
        ppPastFrames: PID3D12Resource;
        pPastSubresources: PUINT;
        NumFutureFrames: UINT;
        ppFutureFrames: PID3D12Resource;
        pFutureSubresources: PUINT;
    end;
    PD3D12_VIDEO_PROCESS_REFERENCE_SET = ^TD3D12_VIDEO_PROCESS_REFERENCE_SET;

    TD3D12_VIDEO_PROCESS_TRANSFORM = record
        SourceRectangle: TD3D12_RECT;
        DestinationRectangle: TD3D12_RECT;
        Orientation: TD3D12_VIDEO_PROCESS_ORIENTATION;
    end;
    PD3D12_VIDEO_PROCESS_TRANSFORM = ^TD3D12_VIDEO_PROCESS_TRANSFORM;

    TD3D12_VIDEO_PROCESS_INPUT_STREAM_RATE = record
        OutputIndex: UINT;
        InputFrameOrField: UINT;
    end;
    PD3D12_VIDEO_PROCESS_INPUT_STREAM_RATE = ^TD3D12_VIDEO_PROCESS_INPUT_STREAM_RATE;

    TD3D12_VIDEO_PROCESS_INPUT_STREAM = record
        pTexture2D: ID3D12Resource;
        Subresource: UINT;
        ReferenceSet: TD3D12_VIDEO_PROCESS_REFERENCE_SET;
    end;
    PD3D12_VIDEO_PROCESS_INPUT_STREAM = ^TD3D12_VIDEO_PROCESS_INPUT_STREAM;

    TD3D12_VIDEO_PROCESS_INPUT_STREAM_ARGUMENTS = record
        InputStream: array [0..1] of TD3D12_VIDEO_PROCESS_INPUT_STREAM;
        Transform: TD3D12_VIDEO_PROCESS_TRANSFORM;
        Flags: TD3D12_VIDEO_PROCESS_INPUT_STREAM_FLAGS;
        RateInfo: TD3D12_VIDEO_PROCESS_INPUT_STREAM_RATE;
        FilterLevels: array[0..31] of INT32;
        AlphaBlending: TD3D12_VIDEO_PROCESS_ALPHA_BLENDING;
    end;
    PD3D12_VIDEO_PROCESS_INPUT_STREAM_ARGUMENTS = ^TD3D12_VIDEO_PROCESS_INPUT_STREAM_ARGUMENTS;

    TD3D12_VIDEO_PROCESS_OUTPUT_STREAM = record
        pTexture2D: ID3D12Resource;
        Subresource: UINT;
    end;
    PD3D12_VIDEO_PROCESS_OUTPUT_STREAM = ^TD3D12_VIDEO_PROCESS_OUTPUT_STREAM;

    TD3D12_VIDEO_PROCESS_OUTPUT_STREAM_ARGUMENTS = record
        OutputStream: array [0..1] of TD3D12_VIDEO_PROCESS_OUTPUT_STREAM;
        TargetRectangle: TD3D12_RECT;
    end;
    PD3D12_VIDEO_PROCESS_OUTPUT_STREAM_ARGUMENTS = ^TD3D12_VIDEO_PROCESS_OUTPUT_STREAM_ARGUMENTS;




    ID3D12VideoDecodeCommandList = interface(ID3D12CommandList)
        ['{3B60536E-AD29-4E64-A269-F853837E5E53}']
        function Close(): HResult; stdcall;
        function Reset(pAllocator: ID3D12CommandAllocator): HResult; stdcall;
        procedure ClearState(); stdcall;
        procedure ResourceBarrier(NumBarriers: UINT; const pBarriers: PD3D12_RESOURCE_BARRIER); stdcall;
        procedure DiscardResource(pResource: ID3D12Resource; const pRegion: TD3D12_DISCARD_REGION); stdcall;
        procedure BeginQuery(pQueryHeap: ID3D12QueryHeap; QType: TD3D12_QUERY_TYPE; Index: UINT); stdcall;
        procedure EndQuery(pQueryHeap: ID3D12QueryHeap; QType: TD3D12_QUERY_TYPE; Index: UINT); stdcall;
        procedure ResolveQueryData(pQueryHeap: ID3D12QueryHeap; QType: TD3D12_QUERY_TYPE; StartIndex: UINT;
            NumQueries: UINT; pDestinationBuffer: ID3D12Resource; AlignedDestinationBufferOffset: UINT64); stdcall;
        procedure SetPredication(pBuffer: ID3D12Resource; AlignedBufferOffset: UINT64; Operation: TD3D12_PREDICATION_OP); stdcall;
        procedure SetMarker(Metadata: UINT; const pData: Pointer; Size: UINT); stdcall;
        procedure BeginEvent(Metadata: UINT; const pData: Pointer; Size: UINT); stdcall;
        procedure EndEvent(); stdcall;
        procedure DecodeFrame(pDecoder: ID3D12VideoDecoder; const pOutputArguments: TD3D12_VIDEO_DECODE_OUTPUT_STREAM_ARGUMENTS;
            const pInputArguments: TD3D12_VIDEO_DECODE_INPUT_STREAM_ARGUMENTS); stdcall;
        procedure WriteBufferImmediate(Count: UINT; const pParams: PD3D12_WRITEBUFFERIMMEDIATE_PARAMETER;
            const pModes: PD3D12_WRITEBUFFERIMMEDIATE_MODE); stdcall;
    end;



    ID3D12VideoProcessCommandList = interface(ID3D12CommandList)
        ['{AEB2543A-167F-4682-ACC8-D159ED4A6209}']
        function Close(): HResult; stdcall;
        function Reset(pAllocator: ID3D12CommandAllocator): HResult; stdcall;
        procedure ClearState(); stdcall;
        procedure ResourceBarrier(NumBarriers: UINT; const pBarriers: PD3D12_RESOURCE_BARRIER); stdcall;
        procedure DiscardResource(pResource: ID3D12Resource; const pRegion: TD3D12_DISCARD_REGION); stdcall;
        procedure BeginQuery(pQueryHeap: ID3D12QueryHeap; QType: TD3D12_QUERY_TYPE; Index: UINT); stdcall;
        procedure EndQuery(pQueryHeap: ID3D12QueryHeap; QType: TD3D12_QUERY_TYPE; Index: UINT); stdcall;
        procedure ResolveQueryData(pQueryHeap: ID3D12QueryHeap; QType: TD3D12_QUERY_TYPE; StartIndex: UINT;
            NumQueries: UINT; pDestinationBuffer: ID3D12Resource; AlignedDestinationBufferOffset: UINT64); stdcall;
        procedure SetPredication(pBuffer: ID3D12Resource; AlignedBufferOffset: UINT64; Operation: TD3D12_PREDICATION_OP); stdcall;
        procedure SetMarker(Metadata: UINT; const pData: pointer; Size: UINT); stdcall;
        procedure BeginEvent(Metadata: UINT; const pData: pointer; Size: UINT); stdcall;
        procedure EndEvent(); stdcall;
        procedure ProcessFrames(pVideoProcessor: ID3D12VideoProcessor;
            const pOutputArguments: TD3D12_VIDEO_PROCESS_OUTPUT_STREAM_ARGUMENTS; NumInputStreams: UINT;
            const pInputArguments: PD3D12_VIDEO_PROCESS_INPUT_STREAM_ARGUMENTS); stdcall;
        procedure WriteBufferImmediate(Count: UINT; const pParams: PD3D12_WRITEBUFFERIMMEDIATE_PARAMETER;
            const pModes: PD3D12_WRITEBUFFERIMMEDIATE_MODE); stdcall;
    end;


implementation

end.

