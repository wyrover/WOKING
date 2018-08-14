unit DX12.D3D11;
{$IFDEF FPC}
{$MODE delphi}{$H+}
{$ENDIF}

interface

{$Z4}

uses
  Windows, Classes, SysUtils, DX12.DXGI, DX12.D3DCommon;

const
  DLL_D3D11                                                                     = 'd3d11.dll';
  D3DCompiler_DLL                                                               = 'D3dcompiler_44.dll';
  IID_ID3D11DeviceChild: TGUID                                                  = '{1841e5c8-16b0-489b-bcc8-44cfb0d5deae}';
  IID_ID3D11DepthStencilState: TGUID                                            = '{03823efb-8d8f-4e1c-9aa2-f64bb2cbfdf1}';
  IID_ID3D11BlendState: TGUID                                                   = '{75b68faa-347d-4159-8f45-a0640f01cd9a}';
  IID_ID3D11RasterizerState: TGUID                                              = '{9bb4ab81-ab1a-4d8f-b506-fc04200b6ee7}';
  IID_ID3D11Resource: TGUID                                                     = '{dc8e63f3-d12b-4952-b47b-5e45026a862d}';
  IID_ID3D11Buffer: TGUID                                                       = '{48570b85-d1ee-4fcd-a250-eb350722b037}';
  IID_ID3D11Texture1D: TGUID                                                    = '{f8fb5c27-c6b3-4f75-a4c8-439af2ef564c}';
  IID_ID3D11Texture2D: TGUID                                                    = '{6f15aaf2-d208-4e89-9ab4-489535d34f9c}';
  IID_ID3D11Texture3D: TGUID                                                    = '{037e866e-f56d-4357-a8af-9dabbe6e250e}';
  IID_ID3D11View: TGUID                                                         = '{839d1216-bb2e-412b-b7f4-a9dbebe08ed1}';
  IID_ID3D11ShaderResourceView: TGUID                                           = '{b0e06fe0-8192-4e1a-b1ca-36d7414710b2}';
  IID_ID3D11RenderTargetView: TGUID                                             = '{dfdba067-0b8d-4865-875b-d7b4516cc164}';
  IID_ID3D11DepthStencilView: TGUID                                             = '{9fdac92a-1876-48c3-afad-25b94f84a9b6}';
  IID_ID3D11UnorderedAccessView: TGUID                                          = '{28acf509-7f5c-48f6-8611-f316010a6380}';
  IID_ID3D11VertexShader: TGUID                                                 = '{3b301d64-d678-4289-8897-22f8928b72f3}';
  IID_ID3D11HullShader: TGUID                                                   = '{8e5c6061-628a-4c8e-8264-bbe45cb3d5dd}';
  IID_ID3D11DomainShader: TGUID                                                 = '{f582c508-0f36-490c-9977-31eece268cfa}';
  IID_ID3D11GeometryShader: TGUID                                               = '{38325b96-effb-4022-ba02-2e795b70275c}';
  IID_ID3D11PixelShader: TGUID                                                  = '{ea82e40d-51dc-4f33-93d4-db7c9125ae8c}';
  IID_ID3D11ComputeShader: TGUID                                                = '{4f5b196e-c2bd-495e-bd01-1fded38e4969}';
  IID_ID3D11InputLayout: TGUID                                                  = '{e4819ddc-4cf0-4025-bd26-5de82a3e07b7}';
  IID_ID3D11SamplerState: TGUID                                                 = '{da6fea51-564c-4487-9810-f0d0f9b4e3a5}';
  IID_ID3D11Asynchronous: TGUID                                                 = '{4b35d0cd-1e15-4258-9c98-1b1333f6dd3b}';
  IID_ID3D11Query: TGUID                                                        = '{d6c00747-87b7-425e-b84d-44d108560afd}';
  IID_ID3D11Predicate: TGUID                                                    = '{9eb576dd-9f77-4d86-81aa-8bab5fe490e2}';
  IID_ID3D11Counter: TGUID                                                      = '{6e8c49fb-a371-4770-b440-29086022b741}';
  IID_ID3D11ClassInstance: TGUID                                                = '{a6cd7faa-b0b7-4a2f-9436-8662a65797cb}';
  IID_ID3D11ClassLinkage: TGUID                                                 = '{ddf57cba-9543-46e4-a12b-f207a0fe7fed}';
  IID_ID3D11CommandList: TGUID                                                  = '{a24bc4d1-769e-43f7-8013-98ff566c18e2}';
  IID_ID3D11DeviceContext: TGUID                                                = '{c0bfa96c-e089-44fb-8eaf-26f8796190da}';
  IID_ID3D11VideoDecoder: TGUID                                                 = '{3C9C5B51-995D-48d1-9B8D-FA5CAEDED65C}';
  IID_ID3D11VideoProcessorEnumerator: TGUID                                     = '{31627037-53AB-4200-9061-05FAA9AB45F9}';
  IID_ID3D11VideoProcessor: TGUID                                               = '{1D7B0652-185F-41c6-85CE-0C5BE3D4AE6C}';
  IID_ID3D11AuthenticatedChannel: TGUID                                         = '{3015A308-DCBD-47aa-A747-192486D14D4A}';
  IID_ID3D11CryptoSession: TGUID                                                = '{9B32F9AD-BDCC-40a6-A39D-D5C865845720}';
  IID_ID3D11VideoDecoderOutputView: TGUID                                       = '{C2931AEA-2A85-4f20-860F-FBA1FD256E18}';
  IID_ID3D11VideoProcessorInputView: TGUID                                      = '{11EC5A5F-51DC-4945-AB34-6E8C21300EA5}';
  IID_ID3D11VideoProcessorOutputView: TGUID                                     = '{A048285E-25A9-4527-BD93-D68B68C44254}';
  IID_ID3D11VideoContext: TGUID                                                 = '{61F21C45-3C0E-4a74-9CEA-67100D9AD5E4}';
  IID_ID3D11VideoDevice: TGUID                                                  = '{10EC4D5B-975A-4689-B9E4-D0AAC30FE333}';
  IID_ID3D11Device: TGUID                                                       = '{db6f6ddb-ac77-4e88-8253-819df9bbf140}';
  D3D11_DECODER_PROFILE_MPEG2_MOCOMP: TGUID                                     = '{e6a9f44b-61b0-4563-9ea4-63d2a3c6fe66}';
  D3D11_DECODER_PROFILE_MPEG2_IDCT: TGUID                                       = '{bf22ad00-03ea-4690-8077-473346209b7e}';
  D3D11_DECODER_PROFILE_MPEG2_VLD: TGUID                                        = '{ee27417f-5e28-4e65-beea-1d26b508adc9}';
  D3D11_DECODER_PROFILE_MPEG1_VLD: TGUID                                        = '{6f3ec719-3735-42cc-8063-65cc3cb36616}';
  D3D11_DECODER_PROFILE_MPEG2and1_VLD: TGUID                                    = '{86695f12-340e-4f04-9fd3-9253dd327460}';
  D3D11_DECODER_PROFILE_H264_MOCOMP_NOFGT: TGUID                                = '{1b81be64-a0c7-11d3-b984-00c04f2e73c5}';
  D3D11_DECODER_PROFILE_H264_MOCOMP_FGT: TGUID                                  = '{1b81be65-a0c7-11d3-b984-00c04f2e73c5}';
  D3D11_DECODER_PROFILE_H264_IDCT_NOFGT: TGUID                                  = '{1b81be66-a0c7-11d3-b984-00c04f2e73c5}';
  D3D11_DECODER_PROFILE_H264_IDCT_FGT: TGUID                                    = '{1b81be67-a0c7-11d3-b984-00c04f2e73c5}';
  D3D11_DECODER_PROFILE_H264_VLD_NOFGT: TGUID                                   = '{1b81be68-a0c7-11d3-b984-00c04f2e73c5}';
  D3D11_DECODER_PROFILE_H264_VLD_FGT: TGUID                                     = '{1b81be69-a0c7-11d3-b984-00c04f2e73c5}';
  D3D11_DECODER_PROFILE_H264_VLD_WITHFMOASO_NOFGT: TGUID                        = '{d5f04ff9-3418-45d8-9561-32a76aae2ddd}';
  D3D11_DECODER_PROFILE_H264_VLD_STEREO_PROGRESSIVE_NOFGT: TGUID                = '{d79be8da-0cf1-4c81-b82a-69a4e236f43d}';
  D3D11_DECODER_PROFILE_H264_VLD_STEREO_NOFGT: TGUID                            = '{f9aaccbb-c2b6-4cfc-8779-5707b1760552}';
  D3D11_DECODER_PROFILE_H264_VLD_MULTIVIEW_NOFGT: TGUID                         = '{705b9d82-76cf-49d6-b7e6-ac8872db013c}';
  D3D11_DECODER_PROFILE_WMV8_POSTPROC: TGUID                                    = '{1b81be80-a0c7-11d3-b984-00c04f2e73c5}';
  D3D11_DECODER_PROFILE_WMV8_MOCOMP: TGUID                                      = '{1b81be81-a0c7-11d3-b984-00c04f2e73c5}';
  D3D11_DECODER_PROFILE_WMV9_POSTPROC: TGUID                                    = '{1b81be90-a0c7-11d3-b984-00c04f2e73c5}';
  D3D11_DECODER_PROFILE_WMV9_MOCOMP: TGUID                                      = '{1b81be91-a0c7-11d3-b984-00c04f2e73c5}';
  D3D11_DECODER_PROFILE_WMV9_IDCT: TGUID                                        = '{1b81be94-a0c7-11d3-b984-00c04f2e73c5}';
  D3D11_DECODER_PROFILE_VC1_POSTPROC: TGUID                                     = '{1b81beA0-a0c7-11d3-b984-00c04f2e73c5}';
  D3D11_DECODER_PROFILE_VC1_MOCOMP: TGUID                                       = '{1b81beA1-a0c7-11d3-b984-00c04f2e73c5}';
  D3D11_DECODER_PROFILE_VC1_IDCT: TGUID                                         = '{1b81beA2-a0c7-11d3-b984-00c04f2e73c5}';
  D3D11_DECODER_PROFILE_VC1_VLD: TGUID                                          = '{1b81beA3-a0c7-11d3-b984-00c04f2e73c5}';
  D3D11_DECODER_PROFILE_VC1_D2010: TGUID                                        = '{1b81beA4-a0c7-11d3-b984-00c04f2e73c5}';
  D3D11_DECODER_PROFILE_MPEG4PT2_VLD_SIMPLE: TGUID                              = '{efd64d74-c9e8-41d7-a5e9-e9b0e39fa319}';
  D3D11_DECODER_PROFILE_MPEG4PT2_VLD_ADVSIMPLE_NOGMC: TGUID                     = '{ed418a9f-010d-4eda-9ae3-9a65358d8d2e}';
  D3D11_DECODER_PROFILE_MPEG4PT2_VLD_ADVSIMPLE_GMC: TGUID                       = '{ab998b5b-4258-44a9-9feb-94e597a6baae}';
  D3D11_DECODER_PROFILE_HEVC_VLD_MAIN: TGUID                                    = '{5b11d51b-2f4c-4452-bcc3-09f2a1160cc0}';
  D3D11_DECODER_PROFILE_HEVC_VLD_MAIN10: TGUID                                  = '{107af0e0-ef1a-4d19-aba8-67a163073d13}';
  D3D11_DECODER_PROFILE_VP9_VLD_PROFILE0: TGUID                                 = '{463707f8-a1d0-4585-876d-83aa6d60b89e}';
  D3D11_DECODER_PROFILE_VP9_VLD_10BIT_PROFILE2: TGUID                           = '{a4c749ef-6ecf-48aa-8448-50a7a1165ff7}';
  D3D11_DECODER_PROFILE_VP8_VLD: TGUID                                          = '{90b899ea-3a62-4705-88b3-8df04b2744e7}';
  D3D11_CRYPTO_TYPE_AES128_CTR: TGUID                                           = '{9b6bd711-4f74-41c9-9e7b-0be2d7d93b4f}';
  D3D11_AUTHENTICATED_QUERY_PROTECTION: TGUID                                   = '{a84eb584-c495-48aa-b94d-8bd2d6fbce05}';
  D3D11_AUTHENTICATED_QUERY_CHANNEL_TYPE: TGUID                                 = '{bc1b18a5-b1fb-42ab-bd94-b5828b4bf7be}';
  D3D11_AUTHENTICATED_QUERY_DEVICE_HANDLE: TGUID                                = '{ec1c539d-8cff-4e2a-bcc4-f5692f99f480}';
  D3D11_AUTHENTICATED_QUERY_CRYPTO_SESSION: TGUID                               = '{2634499e-d018-4d74-ac17-7f724059528d}';
  D3D11_AUTHENTICATED_QUERY_UNRESTRICTED_PROTECTED_SHARED_RESOURCE_COUNT: TGUID = '{012f0bd6-e662-4474-befd-aa53e5143c6d}';
  D3D11_AUTHENTICATED_QUERY_OUTPUT_ID_COUNT: TGUID                              = '{2c042b5e-8c07-46d5-aabe-8f75cbad4c31}';
  D3D11_AUTHENTICATED_QUERY_OUTPUT_ID: TGUID                                    = '{839ddca3-9b4e-41e4-b053-892bd2a11ee7}';
  D3D11_AUTHENTICATED_QUERY_ACCESSIBILITY_ATTRIBUTES: TGUID                     = '{6214d9d2-432c-4abb-9fce-216eea269e3b}';
  D3D11_AUTHENTICATED_QUERY_ENCRYPTION_WHEN_ACCESSIBLE_GUID_COUNT: TGUID        = '{b30f7066-203c-4b07-93fc-ceaafd61241e}';
  D3D11_AUTHENTICATED_QUERY_ENCRYPTION_WHEN_ACCESSIBLE_GUID: TGUID              = '{f83a5958-e986-4bda-beb0-411f6a7a01b7}';
  D3D11_AUTHENTICATED_QUERY_CURRENT_ENCRYPTION_WHEN_ACCESSIBLE: TGUID           = '{ec1791c7-dad3-4f15-9ec3-faa93d60d4f0}';
  D3D11_AUTHENTICATED_CONFIGURE_INITIALIZE: TGUID                               = '{06114bdb-3523-470a-8dca-fbc2845154f0}';
  D3D11_AUTHENTICATED_CONFIGURE_PROTECTION: TGUID                               = '{50455658-3f47-4362-bf99-bfdfcde9ed29}';
  D3D11_AUTHENTICATED_CONFIGURE_CRYPTO_SESSION: TGUID                           = '{6346cc54-2cfc-4ad4-8224-d15837de7700}';
  D3D11_AUTHENTICATED_CONFIGURE_SHARED_RESOURCE: TGUID                          = '{0772d047-1b40-48e8-9ca6-b5f510de9f01}';
  D3D11_AUTHENTICATED_CONFIGURE_ENCRYPTION_WHEN_ACCESSIBLE: TGUID               = '{41fff286-6ae0-4d43-9d55-a46e9efd158a}';
  D3D11_AUTHENTICATED_QUERY_RESTRICTED_SHARED_RESOURCE_PROCESS_COUNT: TGUID     = '{0db207b3-9450-46a6-82de-1b96d44f9cf2}';
  D3D11_AUTHENTICATED_QUERY_RESTRICTED_SHARED_RESOURCE_PROCESS: TGUID           = '{649bbadb-f0f4-4639-a15b-24393fc3abac}';
  D3D11_KEY_EXCHANGE_RSAES_OAEP: TGUID                                          = '{c1949895-d72a-4a1d-8e5d-ed857d171520}';
  IID_ID3D11ShaderReflectionType: TGUID                                         = '{6E6FFA6A-9BAE-4613-A51E-91652D508C21}';
  IID_ID3D11ShaderReflectionVariable: TGUID                                     = '{51F23923-F3E5-4BD1-91CB-606177D8DB4C}';
  IID_ID3D11ShaderReflectionConstantBuffer: TGUID                               = '{EB62D63D-93DD-4318-8AE8-C6F83AD371B8}';
  IID_ID3D11LibraryReflection: TGUID                                            = '{54384F1B-5B3E-4BB7-AE01-60BA3097CBB6}';
  IID_ID3D11FunctionReflection: TGUID                                           = '{207BCECB-D683-4A06-A8A3-9B149B9F73A4}';
  IID_ID3D11ShaderReflection: TGUID                                             = '{8d536ca1-0cca-4956-a837-786963755584}';
  IID_ID3D11FunctionParameterReflection: TGUID                                  = '{42757488-334F-47FE-982E-1A65D08CC462}';
  IID_ID3D11Module: TGUID                                                       = '{CAC701EE-80FC-4122-8242-10B39C8CEC34}';
  IID_ID3D11ModuleInstance: TGUID                                               = '{469E07F7-045A-48D5-AA12-68A478CDF75D}';
  IID_ID3D11Linker: TGUID                                                       = '{59A6CD0E-E10D-4C1F-88C0-63ABA1DAF30E}';
  IID_ID3D11LinkingNode: TGUID                                                  = '{D80DD70C-8D2F-4751-94A1-03C79B3556DB}';
  IID_ID3D11FunctionLinkingGraph: TGUID                                         = '{54133220-1CE8-43D3-8236-9855C5CEECFF}';
  IID_ID3D11ShaderTrace: TGUID                                                  = '{36b013e6-2811-4845-baa7-d623fe0df104}';
  IID_ID3D11ShaderTraceFactory: TGUID                                           = '{1fbad429-66ab-41cc-9617-667ac10e4459}';
  IID_ID3D11Debug: TGUID                                                        = '{79cf2233-7536-4948-9d36-1e4692dc5760}';
  IID_ID3D11SwitchToRef: TGUID                                                  = '{1ef337e3-58e7-4f83-a692-db221f5ed47e}';
  IID_ID3D11TracingDevice: TGUID                                                = '{1911c771-1587-413e-a7e0-fb26c3de0268}';
  IID_ID3D11RefTrackingOptions: TGUID                                           = '{193dacdf-0db2-4c05-a55c-ef06cac56fd9}';
  IID_ID3D11RefDefaultTrackingOptions: TGUID                                    = '{03916615-c644-418c-9bf4-75db5be63ca0}';
  IID_ID3D11InfoQueue: TGUID                                                    = '{6543dbb6-1b48-42f5-ab82-e97ec74326f6}';
  DXGI_DEBUG_D3D11: TGUID                                                       = '{4b99317b-ac39-4aa6-bb0b-baa04784798f}';
  D3D11_SDK_VERSION                                                             = (7);
  D3D11_16BIT_INDEX_STRIP_CUT_VALUE                                             = $FFFF;
  D3D11_32BIT_INDEX_STRIP_CUT_VALUE                                             = $FFFFFFFF;
  D3D11_8BIT_INDEX_STRIP_CUT_VALUE                                              = $FF;
  D3D11_ARRAY_AXIS_ADDRESS_RANGE_BIT_COUNT                                      = 9;
  D3D11_CLIP_OR_CULL_DISTANCE_COUNT                                             = 8;
  D3D11_CLIP_OR_CULL_DISTANCE_ELEMENT_COUNT                                     = 2;
  D3D11_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT                             = 14;
  D3D11_COMMONSHADER_CONSTANT_BUFFER_COMPONENTS                                 = 4;
  D3D11_COMMONSHADER_CONSTANT_BUFFER_COMPONENT_BIT_COUNT                        = 32;
  D3D11_COMMONSHADER_CONSTANT_BUFFER_HW_SLOT_COUNT                              = 15;
  D3D11_COMMONSHADER_CONSTANT_BUFFER_PARTIAL_UPDATE_EXTENTS_BYTE_ALIGNMENT      = 16;
  D3D11_COMMONSHADER_CONSTANT_BUFFER_REGISTER_COMPONENTS                        = 4;
  D3D11_COMMONSHADER_CONSTANT_BUFFER_REGISTER_COUNT                             = 15;
  D3D11_COMMONSHADER_CONSTANT_BUFFER_REGISTER_READS_PER_INST                    = 1;
  D3D11_COMMONSHADER_CONSTANT_BUFFER_REGISTER_READ_PORTS                        = 1;
  D3D11_COMMONSHADER_FLOWCONTROL_NESTING_LIMIT                                  = 64;
  D3D11_COMMONSHADER_IMMEDIATE_CONSTANT_BUFFER_REGISTER_COMPONENTS              = 4;
  D3D11_COMMONSHADER_IMMEDIATE_CONSTANT_BUFFER_REGISTER_COUNT                   = 1;
  D3D11_COMMONSHADER_IMMEDIATE_CONSTANT_BUFFER_REGISTER_READS_PER_INST          = 1;
  D3D11_COMMONSHADER_IMMEDIATE_CONSTANT_BUFFER_REGISTER_READ_PORTS              = 1;
  D3D11_COMMONSHADER_IMMEDIATE_VALUE_COMPONENT_BIT_COUNT                        = 32;
  D3D11_COMMONSHADER_INPUT_RESOURCE_REGISTER_COMPONENTS                         = 1;
  D3D11_COMMONSHADER_INPUT_RESOURCE_REGISTER_COUNT                              = 128;
  D3D11_COMMONSHADER_INPUT_RESOURCE_REGISTER_READS_PER_INST                     = 1;
  D3D11_COMMONSHADER_INPUT_RESOURCE_REGISTER_READ_PORTS                         = 1;
  D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT                                  = 128;
  D3D11_COMMONSHADER_SAMPLER_REGISTER_COMPONENTS                                = 1;
  D3D11_COMMONSHADER_SAMPLER_REGISTER_COUNT                                     = 16;
  D3D11_COMMONSHADER_SAMPLER_REGISTER_READS_PER_INST                            = 1;
  D3D11_COMMONSHADER_SAMPLER_REGISTER_READ_PORTS                                = 1;
  D3D11_COMMONSHADER_SAMPLER_SLOT_COUNT                                         = 16;
  D3D11_COMMONSHADER_SUBROUTINE_NESTING_LIMIT                                   = 32;
  D3D11_COMMONSHADER_TEMP_REGISTER_COMPONENTS                                   = 4;
  D3D11_COMMONSHADER_TEMP_REGISTER_COMPONENT_BIT_COUNT                          = 32;
  D3D11_COMMONSHADER_TEMP_REGISTER_COUNT                                        = 4096;
  D3D11_COMMONSHADER_TEMP_REGISTER_READS_PER_INST                               = 3;
  D3D11_COMMONSHADER_TEMP_REGISTER_READ_PORTS                                   = 3;
  D3D11_COMMONSHADER_TEXCOORD_RANGE_REDUCTION_MAX                               = 10;
  D3D11_COMMONSHADER_TEXCOORD_RANGE_REDUCTION_MIN                               = -10;
  D3D11_COMMONSHADER_TEXEL_OFFSET_MAX_NEGATIVE                                  = -8;
  D3D11_COMMONSHADER_TEXEL_OFFSET_MAX_POSITIVE                                  = 7;
  D3D11_CS_4_X_BUCKET00_MAX_BYTES_TGSM_WRITABLE_PER_THREAD                      = 256;
  D3D11_CS_4_X_BUCKET00_MAX_NUM_THREADS_PER_GROUP                               = 64;
  D3D11_CS_4_X_BUCKET01_MAX_BYTES_TGSM_WRITABLE_PER_THREAD                      = 240;
  D3D11_CS_4_X_BUCKET01_MAX_NUM_THREADS_PER_GROUP                               = 68;
  D3D11_CS_4_X_BUCKET02_MAX_BYTES_TGSM_WRITABLE_PER_THREAD                      = 224;
  D3D11_CS_4_X_BUCKET02_MAX_NUM_THREADS_PER_GROUP                               = 72;
  D3D11_CS_4_X_BUCKET03_MAX_BYTES_TGSM_WRITABLE_PER_THREAD                      = 208;
  D3D11_CS_4_X_BUCKET03_MAX_NUM_THREADS_PER_GROUP                               = 76;
  D3D11_CS_4_X_BUCKET04_MAX_BYTES_TGSM_WRITABLE_PER_THREAD                      = 192;
  D3D11_CS_4_X_BUCKET04_MAX_NUM_THREADS_PER_GROUP                               = 84;
  D3D11_CS_4_X_BUCKET05_MAX_BYTES_TGSM_WRITABLE_PER_THREAD                      = 176;
  D3D11_CS_4_X_BUCKET05_MAX_NUM_THREADS_PER_GROUP                               = 92;
  D3D11_CS_4_X_BUCKET06_MAX_BYTES_TGSM_WRITABLE_PER_THREAD                      = 160;
  D3D11_CS_4_X_BUCKET06_MAX_NUM_THREADS_PER_GROUP                               = 100;
  D3D11_CS_4_X_BUCKET07_MAX_BYTES_TGSM_WRITABLE_PER_THREAD                      = 144;
  D3D11_CS_4_X_BUCKET07_MAX_NUM_THREADS_PER_GROUP                               = 112;
  D3D11_CS_4_X_BUCKET08_MAX_BYTES_TGSM_WRITABLE_PER_THREAD                      = 128;
  D3D11_CS_4_X_BUCKET08_MAX_NUM_THREADS_PER_GROUP                               = 128;
  D3D11_CS_4_X_BUCKET09_MAX_BYTES_TGSM_WRITABLE_PER_THREAD                      = 112;
  D3D11_CS_4_X_BUCKET09_MAX_NUM_THREADS_PER_GROUP                               = 144;
  D3D11_CS_4_X_BUCKET10_MAX_BYTES_TGSM_WRITABLE_PER_THREAD                      = 96;
  D3D11_CS_4_X_BUCKET10_MAX_NUM_THREADS_PER_GROUP                               = 168;
  D3D11_CS_4_X_BUCKET11_MAX_BYTES_TGSM_WRITABLE_PER_THREAD                      = 80;
  D3D11_CS_4_X_BUCKET11_MAX_NUM_THREADS_PER_GROUP                               = 204;
  D3D11_CS_4_X_BUCKET12_MAX_BYTES_TGSM_WRITABLE_PER_THREAD                      = 64;
  D3D11_CS_4_X_BUCKET12_MAX_NUM_THREADS_PER_GROUP                               = 256;
  D3D11_CS_4_X_BUCKET13_MAX_BYTES_TGSM_WRITABLE_PER_THREAD                      = 48;
  D3D11_CS_4_X_BUCKET13_MAX_NUM_THREADS_PER_GROUP                               = 340;
  D3D11_CS_4_X_BUCKET14_MAX_BYTES_TGSM_WRITABLE_PER_THREAD                      = 32;
  D3D11_CS_4_X_BUCKET14_MAX_NUM_THREADS_PER_GROUP                               = 512;
  D3D11_CS_4_X_BUCKET15_MAX_BYTES_TGSM_WRITABLE_PER_THREAD                      = 16;
  D3D11_CS_4_X_BUCKET15_MAX_NUM_THREADS_PER_GROUP                               = 768;
  D3D11_CS_4_X_DISPATCH_MAX_THREAD_GROUPS_IN_Z_DIMENSION                        = 1;
  D3D11_CS_4_X_RAW_UAV_BYTE_ALIGNMENT                                           = 256;
  D3D11_CS_4_X_THREAD_GROUP_MAX_THREADS_PER_GROUP                               = 768;
  D3D11_CS_4_X_THREAD_GROUP_MAX_X                                               = 768;
  D3D11_CS_4_X_THREAD_GROUP_MAX_Y                                               = 768;
  D3D11_CS_4_X_UAV_REGISTER_COUNT                                               = 1;
  D3D11_CS_DISPATCH_MAX_THREAD_GROUPS_PER_DIMENSION                             = 65535;
  D3D11_CS_TGSM_REGISTER_COUNT                                                  = 8192;
  D3D11_CS_TGSM_REGISTER_READS_PER_INST                                         = 1;
  D3D11_CS_TGSM_RESOURCE_REGISTER_COMPONENTS                                    = 1;
  D3D11_CS_TGSM_RESOURCE_REGISTER_READ_PORTS                                    = 1;
  D3D11_CS_THREADGROUPID_REGISTER_COMPONENTS                                    = 3;
  D3D11_CS_THREADGROUPID_REGISTER_COUNT                                         = 1;
  D3D11_CS_THREADIDINGROUPFLATTENED_REGISTER_COMPONENTS                         = 1;
  D3D11_CS_THREADIDINGROUPFLATTENED_REGISTER_COUNT                              = 1;
  D3D11_CS_THREADIDINGROUP_REGISTER_COMPONENTS                                  = 3;
  D3D11_CS_THREADIDINGROUP_REGISTER_COUNT                                       = 1;
  D3D11_CS_THREADID_REGISTER_COMPONENTS                                         = 3;
  D3D11_CS_THREADID_REGISTER_COUNT                                              = 1;
  D3D11_CS_THREAD_GROUP_MAX_THREADS_PER_GROUP                                   = 1024;
  D3D11_CS_THREAD_GROUP_MAX_X                                                   = 1024;
  D3D11_CS_THREAD_GROUP_MAX_Y                                                   = 1024;
  D3D11_CS_THREAD_GROUP_MAX_Z                                                   = 64;
  D3D11_CS_THREAD_GROUP_MIN_X                                                   = 1;
  D3D11_CS_THREAD_GROUP_MIN_Y                                                   = 1;
  D3D11_CS_THREAD_GROUP_MIN_Z                                                   = 1;
  D3D11_CS_THREAD_LOCAL_TEMP_REGISTER_POOL                                      = 16384;
  D3D11_DEFAULT_BLEND_FACTOR_ALPHA                                              = 1.0;
  D3D11_DEFAULT_BLEND_FACTOR_BLUE                                               = 1.0;
  D3D11_DEFAULT_BLEND_FACTOR_GREEN                                              = 1.0;
  D3D11_DEFAULT_BLEND_FACTOR_RED                                                = 1.0;
  D3D11_DEFAULT_BORDER_COLOR_COMPONENT                                          = 0.0;
  D3D11_DEFAULT_DEPTH_BIAS                                                      = 0;
  D3D11_DEFAULT_DEPTH_BIAS_CLAMP                                                = 0.0;
  D3D11_DEFAULT_MAX_ANISOTROPY                                                  = 16;
  D3D11_DEFAULT_MIP_LOD_BIAS                                                    = 0.0;
  D3D11_DEFAULT_RENDER_TARGET_ARRAY_INDEX                                       = 0;
  D3D11_DEFAULT_SAMPLE_MASK                                                     = $FFFFFFFF;
  D3D11_DEFAULT_SCISSOR_ENDX                                                    = 0;
  D3D11_DEFAULT_SCISSOR_ENDY                                                    = 0;
  D3D11_DEFAULT_SCISSOR_STARTX                                                  = 0;
  D3D11_DEFAULT_SCISSOR_STARTY                                                  = 0;
  D3D11_DEFAULT_SLOPE_SCALED_DEPTH_BIAS                                         = 0.0;
  D3D11_DEFAULT_STENCIL_READ_MASK                                               = $FF;
  D3D11_DEFAULT_STENCIL_REFERENCE                                               = 0;
  D3D11_DEFAULT_STENCIL_WRITE_MASK                                              = $FF;
  D3D11_DEFAULT_VIEWPORT_AND_SCISSORRECT_INDEX                                  = 0;
  D3D11_DEFAULT_VIEWPORT_HEIGHT                                                 = 0;
  D3D11_DEFAULT_VIEWPORT_MAX_DEPTH                                              = 0.0;
  D3D11_DEFAULT_VIEWPORT_MIN_DEPTH                                              = 0.0;
  D3D11_DEFAULT_VIEWPORT_TOPLEFTX                                               = 0;
  D3D11_DEFAULT_VIEWPORT_TOPLEFTY                                               = 0;
  D3D11_DEFAULT_VIEWPORT_WIDTH                                                  = 0;
  D3D11_DS_INPUT_CONTROL_POINTS_MAX_TOTAL_SCALARS                               = 3968;
  D3D11_DS_INPUT_CONTROL_POINT_REGISTER_COMPONENTS                              = 4;
  D3D11_DS_INPUT_CONTROL_POINT_REGISTER_COMPONENT_BIT_COUNT                     = 32;
  D3D11_DS_INPUT_CONTROL_POINT_REGISTER_COUNT                                   = 32;
  D3D11_DS_INPUT_CONTROL_POINT_REGISTER_READS_PER_INST                          = 2;
  D3D11_DS_INPUT_CONTROL_POINT_REGISTER_READ_PORTS                              = 1;
  D3D11_DS_INPUT_DOMAIN_POINT_REGISTER_COMPONENTS                               = 3;
  D3D11_DS_INPUT_DOMAIN_POINT_REGISTER_COMPONENT_BIT_COUNT                      = 32;
  D3D11_DS_INPUT_DOMAIN_POINT_REGISTER_COUNT                                    = 1;
  D3D11_DS_INPUT_DOMAIN_POINT_REGISTER_READS_PER_INST                           = 2;
  D3D11_DS_INPUT_DOMAIN_POINT_REGISTER_READ_PORTS                               = 1;
  D3D11_DS_INPUT_PATCH_CONSTANT_REGISTER_COMPONENTS                             = 4;
  D3D11_DS_INPUT_PATCH_CONSTANT_REGISTER_COMPONENT_BIT_COUNT                    = 32;
  D3D11_DS_INPUT_PATCH_CONSTANT_REGISTER_COUNT                                  = 32;
  D3D11_DS_INPUT_PATCH_CONSTANT_REGISTER_READS_PER_INST                         = 2;
  D3D11_DS_INPUT_PATCH_CONSTANT_REGISTER_READ_PORTS                             = 1;
  D3D11_DS_INPUT_PRIMITIVE_ID_REGISTER_COMPONENTS                               = 1;
  D3D11_DS_INPUT_PRIMITIVE_ID_REGISTER_COMPONENT_BIT_COUNT                      = 32;
  D3D11_DS_INPUT_PRIMITIVE_ID_REGISTER_COUNT                                    = 1;
  D3D11_DS_INPUT_PRIMITIVE_ID_REGISTER_READS_PER_INST                           = 2;
  D3D11_DS_INPUT_PRIMITIVE_ID_REGISTER_READ_PORTS                               = 1;
  D3D11_DS_OUTPUT_REGISTER_COMPONENTS                                           = 4;
  D3D11_DS_OUTPUT_REGISTER_COMPONENT_BIT_COUNT                                  = 32;
  D3D11_DS_OUTPUT_REGISTER_COUNT                                                = 32;
  D3D11_FLOAT16_FUSED_TOLERANCE_IN_ULP                                          = 0.6;
  D3D11_FLOAT32_MAX                                                             = 3.402823466E+38;
  D3D11_FLOAT32_TO_INTEGER_TOLERANCE_IN_ULP                                     = 0.6;
  D3D11_FLOAT_TO_SRGB_EXPONENT_DENOMINATOR                                      = 2.4;
  D3D11_FLOAT_TO_SRGB_EXPONENT_NUMERATOR                                        = 1.0;
  D3D11_FLOAT_TO_SRGB_OFFSET                                                    = 0.055;
  D3D11_FLOAT_TO_SRGB_SCALE_1                                                   = 12.92;
  D3D11_FLOAT_TO_SRGB_SCALE_2                                                   = 1.055;
  D3D11_FLOAT_TO_SRGB_THRESHOLD                                                 = 0.0031308;
  D3D11_FTOI_INSTRUCTION_MAX_INPUT                                              = 2147483647.999;
  D3D11_FTOI_INSTRUCTION_MIN_INPUT                                              = -2147483648.999;
  D3D11_FTOU_INSTRUCTION_MAX_INPUT                                              = 4294967295.999;
  D3D11_FTOU_INSTRUCTION_MIN_INPUT                                              = 0.0;
  D3D11_GS_INPUT_INSTANCE_ID_READS_PER_INST                                     = 2;
  D3D11_GS_INPUT_INSTANCE_ID_READ_PORTS                                         = 1;
  D3D11_GS_INPUT_INSTANCE_ID_REGISTER_COMPONENTS                                = 1;
  D3D11_GS_INPUT_INSTANCE_ID_REGISTER_COMPONENT_BIT_COUNT                       = 32;
  D3D11_GS_INPUT_INSTANCE_ID_REGISTER_COUNT                                     = 1;
  D3D11_GS_INPUT_PRIM_CONST_REGISTER_COMPONENTS                                 = 1;
  D3D11_GS_INPUT_PRIM_CONST_REGISTER_COMPONENT_BIT_COUNT                        = 32;
  D3D11_GS_INPUT_PRIM_CONST_REGISTER_COUNT                                      = 1;
  D3D11_GS_INPUT_PRIM_CONST_REGISTER_READS_PER_INST                             = 2;
  D3D11_GS_INPUT_PRIM_CONST_REGISTER_READ_PORTS                                 = 1;
  D3D11_GS_INPUT_REGISTER_COMPONENTS                                            = 4;
  D3D11_GS_INPUT_REGISTER_COMPONENT_BIT_COUNT                                   = 32;
  D3D11_GS_INPUT_REGISTER_COUNT                                                 = 32;
  D3D11_GS_INPUT_REGISTER_READS_PER_INST                                        = 2;
  D3D11_GS_INPUT_REGISTER_READ_PORTS                                            = 1;
  D3D11_GS_INPUT_REGISTER_VERTICES                                              = 32;
  D3D11_GS_MAX_INSTANCE_COUNT                                                   = 32;
  D3D11_GS_MAX_OUTPUT_VERTEX_COUNT_ACROSS_INSTANCES                             = 1024;
  D3D11_GS_OUTPUT_ELEMENTS                                                      = 32;
  D3D11_GS_OUTPUT_REGISTER_COMPONENTS                                           = 4;
  D3D11_GS_OUTPUT_REGISTER_COMPONENT_BIT_COUNT                                  = 32;
  D3D11_GS_OUTPUT_REGISTER_COUNT                                                = 32;
  D3D11_HS_CONTROL_POINT_PHASE_INPUT_REGISTER_COUNT                             = 32;
  D3D11_HS_CONTROL_POINT_PHASE_OUTPUT_REGISTER_COUNT                            = 32;
  D3D11_HS_CONTROL_POINT_REGISTER_COMPONENTS                                    = 4;
  D3D11_HS_CONTROL_POINT_REGISTER_COMPONENT_BIT_COUNT                           = 32;
  D3D11_HS_CONTROL_POINT_REGISTER_READS_PER_INST                                = 2;
  D3D11_HS_CONTROL_POINT_REGISTER_READ_PORTS                                    = 1;
  D3D11_HS_FORK_PHASE_INSTANCE_COUNT_UPPER_BOUND                                = $FFFFFFFF;
  D3D11_HS_INPUT_FORK_INSTANCE_ID_REGISTER_COMPONENTS                           = 1;
  D3D11_HS_INPUT_FORK_INSTANCE_ID_REGISTER_COMPONENT_BIT_COUNT                  = 32;
  D3D11_HS_INPUT_FORK_INSTANCE_ID_REGISTER_COUNT                                = 1;
  D3D11_HS_INPUT_FORK_INSTANCE_ID_REGISTER_READS_PER_INST                       = 2;
  D3D11_HS_INPUT_FORK_INSTANCE_ID_REGISTER_READ_PORTS                           = 1;
  D3D11_HS_INPUT_JOIN_INSTANCE_ID_REGISTER_COMPONENTS                           = 1;
  D3D11_HS_INPUT_JOIN_INSTANCE_ID_REGISTER_COMPONENT_BIT_COUNT                  = 32;
  D3D11_HS_INPUT_JOIN_INSTANCE_ID_REGISTER_COUNT                                = 1;
  D3D11_HS_INPUT_JOIN_INSTANCE_ID_REGISTER_READS_PER_INST                       = 2;
  D3D11_HS_INPUT_JOIN_INSTANCE_ID_REGISTER_READ_PORTS                           = 1;
  D3D11_HS_INPUT_PRIMITIVE_ID_REGISTER_COMPONENTS                               = 1;
  D3D11_HS_INPUT_PRIMITIVE_ID_REGISTER_COMPONENT_BIT_COUNT                      = 32;
  D3D11_HS_INPUT_PRIMITIVE_ID_REGISTER_COUNT                                    = 1;
  D3D11_HS_INPUT_PRIMITIVE_ID_REGISTER_READS_PER_INST                           = 2;
  D3D11_HS_INPUT_PRIMITIVE_ID_REGISTER_READ_PORTS                               = 1;
  D3D11_HS_JOIN_PHASE_INSTANCE_COUNT_UPPER_BOUND                                = $FFFFFFFF;
  D3D11_HS_MAXTESSFACTOR_LOWER_BOUND                                            = 1.0;
  D3D11_HS_MAXTESSFACTOR_UPPER_BOUND                                            = 64.0;
  D3D11_HS_OUTPUT_CONTROL_POINTS_MAX_TOTAL_SCALARS                              = 3968;
  D3D11_HS_OUTPUT_CONTROL_POINT_ID_REGISTER_COMPONENTS                          = 1;
  D3D11_HS_OUTPUT_CONTROL_POINT_ID_REGISTER_COMPONENT_BIT_COUNT                 = 32;
  D3D11_HS_OUTPUT_CONTROL_POINT_ID_REGISTER_COUNT                               = 1;
  D3D11_HS_OUTPUT_CONTROL_POINT_ID_REGISTER_READS_PER_INST                      = 2;
  D3D11_HS_OUTPUT_CONTROL_POINT_ID_REGISTER_READ_PORTS                          = 1;
  D3D11_HS_OUTPUT_PATCH_CONSTANT_REGISTER_COMPONENTS                            = 4;
  D3D11_HS_OUTPUT_PATCH_CONSTANT_REGISTER_COMPONENT_BIT_COUNT                   = 32;
  D3D11_HS_OUTPUT_PATCH_CONSTANT_REGISTER_COUNT                                 = 32;
  D3D11_HS_OUTPUT_PATCH_CONSTANT_REGISTER_READS_PER_INST                        = 2;
  D3D11_HS_OUTPUT_PATCH_CONSTANT_REGISTER_READ_PORTS                            = 1;
  D3D11_HS_OUTPUT_PATCH_CONSTANT_REGISTER_SCALAR_COMPONENTS                     = 128;
  D3D11_IA_DEFAULT_INDEX_BUFFER_OFFSET_IN_BYTES                                 = 0;
  D3D11_IA_DEFAULT_PRIMITIVE_TOPOLOGY                                           = 0;
  D3D11_IA_DEFAULT_VERTEX_BUFFER_OFFSET_IN_BYTES                                = 0;
  D3D11_IA_INDEX_INPUT_RESOURCE_SLOT_COUNT                                      = 1;
  D3D11_IA_INSTANCE_ID_BIT_COUNT                                                = 32;
  D3D11_IA_INTEGER_ARITHMETIC_BIT_COUNT                                         = 32;
  D3D11_IA_PATCH_MAX_CONTROL_POINT_COUNT                                        = 32;
  D3D11_IA_PRIMITIVE_ID_BIT_COUNT                                               = 32;
  D3D11_IA_VERTEX_ID_BIT_COUNT                                                  = 32;
  D3D11_IA_VERTEX_INPUT_RESOURCE_SLOT_COUNT                                     = 32;
  D3D11_IA_VERTEX_INPUT_STRUCTURE_ELEMENTS_COMPONENTS                           = 128;
  D3D11_IA_VERTEX_INPUT_STRUCTURE_ELEMENT_COUNT                                 = 32;
  D3D11_INTEGER_DIVIDE_BY_ZERO_QUOTIENT                                         = $FFFFFFFF;
  D3D11_INTEGER_DIVIDE_BY_ZERO_REMAINDER                                        = $FFFFFFFF;
  D3D11_KEEP_RENDER_TARGETS_AND_DEPTH_STENCIL                                   = $FFFFFFFF;
  D3D11_KEEP_UNORDERED_ACCESS_VIEWS                                             = $FFFFFFFF;
  D3D11_LINEAR_GAMMA                                                            = 1.0;
  D3D11_MAJOR_VERSION                                                           = 11;
  D3D11_MAX_BORDER_COLOR_COMPONENT                                              = 1.0;
  D3D11_MAX_DEPTH                                                               = 1.0;
  D3D11_MAX_MAXANISOTROPY                                                       = 16;
  D3D11_MAX_MULTISAMPLE_SAMPLE_COUNT                                            = 32;
  D3D11_MAX_POSITION_VALUE                                                      = 3.402823466E+34;
  D3D11_MAX_TEXTURE_DIMENSION_2_TO_EXP                                          = 17;
  D3D11_MINOR_VERSION                                                           = 0;
  D3D11_MIN_BORDER_COLOR_COMPONENT                                              = 0.0;
  D3D11_MIN_DEPTH                                                               = 0.0;
  D3D11_MIN_MAXANISOTROPY                                                       = 0;
  D3D11_MIP_LOD_BIAS_MAX                                                        = 15.99;
  D3D11_MIP_LOD_BIAS_MIN                                                        = -16.0;
  D3D11_MIP_LOD_FRACTIONAL_BIT_COUNT                                            = 8;
  D3D11_MIP_LOD_RANGE_BIT_COUNT                                                 = 8;
  D3D11_MULTISAMPLE_ANTIALIAS_LINE_WIDTH                                        = 1.4;
  D3D11_NONSAMPLE_FETCH_OUT_OF_RANGE_ACCESS_RESULT                              = 0;
  D3D11_PIXEL_ADDRESS_RANGE_BIT_COUNT                                           = 15;
  D3D11_PRE_SCISSOR_PIXEL_ADDRESS_RANGE_BIT_COUNT                               = 16;
  D3D11_PS_CS_UAV_REGISTER_COMPONENTS                                           = 1;
  D3D11_PS_CS_UAV_REGISTER_COUNT                                                = 8;
  D3D11_PS_CS_UAV_REGISTER_READS_PER_INST                                       = 1;
  D3D11_PS_CS_UAV_REGISTER_READ_PORTS                                           = 1;
  D3D11_PS_FRONTFACING_DEFAULT_VALUE                                            = $FFFFFFFF;
  D3D11_PS_FRONTFACING_FALSE_VALUE                                              = 0;
  D3D11_PS_FRONTFACING_TRUE_VALUE                                               = $FFFFFFFF;
  D3D11_PS_INPUT_REGISTER_COMPONENTS                                            = 4;
  D3D11_PS_INPUT_REGISTER_COMPONENT_BIT_COUNT                                   = 32;
  D3D11_PS_INPUT_REGISTER_COUNT                                                 = 32;
  D3D11_PS_INPUT_REGISTER_READS_PER_INST                                        = 2;
  D3D11_PS_INPUT_REGISTER_READ_PORTS                                            = 1;
  D3D11_PS_LEGACY_PIXEL_CENTER_FRACTIONAL_COMPONENT                             = 0.0;
  D3D11_PS_OUTPUT_DEPTH_REGISTER_COMPONENTS                                     = 1;
  D3D11_PS_OUTPUT_DEPTH_REGISTER_COMPONENT_BIT_COUNT                            = 32;
  D3D11_PS_OUTPUT_DEPTH_REGISTER_COUNT                                          = 1;
  D3D11_PS_OUTPUT_MASK_REGISTER_COMPONENTS                                      = 1;
  D3D11_PS_OUTPUT_MASK_REGISTER_COMPONENT_BIT_COUNT                             = 32;
  D3D11_PS_OUTPUT_MASK_REGISTER_COUNT                                           = 1;
  D3D11_PS_OUTPUT_REGISTER_COMPONENTS                                           = 4;
  D3D11_PS_OUTPUT_REGISTER_COMPONENT_BIT_COUNT                                  = 32;
  D3D11_PS_OUTPUT_REGISTER_COUNT                                                = 8;
  D3D11_PS_PIXEL_CENTER_FRACTIONAL_COMPONENT                                    = 0.5;
  D3D11_RAW_UAV_SRV_BYTE_ALIGNMENT                                              = 16;
  D3D11_REQ_BLEND_OBJECT_COUNT_PER_DEVICE                                       = 4096;
  D3D11_REQ_BUFFER_RESOURCE_TEXEL_COUNT_2_TO_EXP                                = 27;
  D3D11_REQ_CONSTANT_BUFFER_ELEMENT_COUNT                                       = 4096;
  D3D11_REQ_DEPTH_STENCIL_OBJECT_COUNT_PER_DEVICE                               = 4096;
  D3D11_REQ_DRAWINDEXED_INDEX_COUNT_2_TO_EXP                                    = 32;
  D3D11_REQ_DRAW_VERTEX_COUNT_2_TO_EXP                                          = 32;
  D3D11_REQ_FILTERING_HW_ADDRESSABLE_RESOURCE_DIMENSION                         = 16384;
  D3D11_REQ_GS_INVOCATION_32BIT_OUTPUT_COMPONENT_LIMIT                          = 1024;
  D3D11_REQ_IMMEDIATE_CONSTANT_BUFFER_ELEMENT_COUNT                             = 4096;
  D3D11_REQ_MAXANISOTROPY                                                       = 16;
  D3D11_REQ_MIP_LEVELS                                                          = 15;
  D3D11_REQ_MULTI_ELEMENT_STRUCTURE_SIZE_IN_BYTES                               = 2048;
  D3D11_REQ_RASTERIZER_OBJECT_COUNT_PER_DEVICE                                  = 4096;
  D3D11_REQ_RENDER_TO_BUFFER_WINDOW_WIDTH                                       = 16384;
  D3D11_REQ_RESOURCE_SIZE_IN_MEGABYTES_EXPRESSION_A_TERM                        = 128;
  D3D11_REQ_RESOURCE_SIZE_IN_MEGABYTES_EXPRESSION_B_TERM                        = 0.25;
  D3D11_REQ_RESOURCE_SIZE_IN_MEGABYTES_EXPRESSION_C_TERM                        = 2048;
  D3D11_REQ_RESOURCE_VIEW_COUNT_PER_DEVICE_2_TO_EXP                             = 20;
  D3D11_REQ_SAMPLER_OBJECT_COUNT_PER_DEVICE                                     = 4096;
  D3D11_REQ_TEXTURE1D_ARRAY_AXIS_DIMENSION                                      = 2048;
  D3D11_REQ_TEXTURE1D_U_DIMENSION                                               = 16384;
  D3D11_REQ_TEXTURE2D_ARRAY_AXIS_DIMENSION                                      = 2048;
  D3D11_REQ_TEXTURE2D_U_OR_V_DIMENSION                                          = 16384;
  D3D11_REQ_TEXTURE3D_U_V_OR_W_DIMENSION                                        = 2048;
  D3D11_REQ_TEXTURECUBE_DIMENSION                                               = 16384;
  D3D11_RESINFO_INSTRUCTION_MISSING_COMPONENT_RETVAL                            = 0;
  D3D11_SHADER_MAJOR_VERSION                                                    = 5;
  D3D11_SHADER_MAX_INSTANCES                                                    = 65535;
  D3D11_SHADER_MAX_INTERFACES                                                   = 253;
  D3D11_SHADER_MAX_INTERFACE_CALL_SITES                                         = 4096;
  D3D11_SHADER_MAX_TYPES                                                        = 65535;
  D3D11_SHADER_MINOR_VERSION                                                    = 0;
  D3D11_SHIFT_INSTRUCTION_PAD_VALUE                                             = 0;
  D3D11_SHIFT_INSTRUCTION_SHIFT_VALUE_BIT_COUNT                                 = 5;
  D3D11_SIMULTANEOUS_RENDER_TARGET_COUNT                                        = 8;
  D3D11_SO_BUFFER_MAX_STRIDE_IN_BYTES                                           = 2048;
  D3D11_SO_BUFFER_MAX_WRITE_WINDOW_IN_BYTES                                     = 512;
  D3D11_SO_BUFFER_SLOT_COUNT                                                    = 4;
  D3D11_SO_DDI_REGISTER_INDEX_DENOTING_GAP                                      = $FFFFFFFF;
  D3D11_SO_NO_RASTERIZED_STREAM                                                 = $FFFFFFFF;
  D3D11_SO_OUTPUT_COMPONENT_COUNT                                               = 128;
  D3D11_SO_STREAM_COUNT                                                         = 4;
  D3D11_SPEC_DATE_DAY                                                           = 16;
  D3D11_SPEC_DATE_MONTH                                                         = 05;
  D3D11_SPEC_DATE_YEAR                                                          = 2011;
  D3D11_SPEC_VERSION                                                            = 1.07;
  D3D11_SRGB_GAMMA                                                              = 2.2;
  D3D11_SRGB_TO_FLOAT_DENOMINATOR_1                                             = 12.92;
  D3D11_SRGB_TO_FLOAT_DENOMINATOR_2                                             = 1.055;
  D3D11_SRGB_TO_FLOAT_EXPONENT                                                  = 2.4;
  D3D11_SRGB_TO_FLOAT_OFFSET                                                    = 0.055;
  D3D11_SRGB_TO_FLOAT_THRESHOLD                                                 = 0.04045;
  D3D11_SRGB_TO_FLOAT_TOLERANCE_IN_ULP                                          = 0.5;
  D3D11_STANDARD_COMPONENT_BIT_COUNT                                            = 32;
  D3D11_STANDARD_COMPONENT_BIT_COUNT_DOUBLED                                    = 64;
  D3D11_STANDARD_MAXIMUM_ELEMENT_ALIGNMENT_BYTE_MULTIPLE                        = 4;
  D3D11_STANDARD_PIXEL_COMPONENT_COUNT                                          = 128;
  D3D11_STANDARD_PIXEL_ELEMENT_COUNT                                            = 32;
  D3D11_STANDARD_VECTOR_SIZE                                                    = 4;
  D3D11_STANDARD_VERTEX_ELEMENT_COUNT                                           = 32;
  D3D11_STANDARD_VERTEX_TOTAL_COMPONENT_COUNT                                   = 64;
  D3D11_SUBPIXEL_FRACTIONAL_BIT_COUNT                                           = 8;
  D3D11_SUBTEXEL_FRACTIONAL_BIT_COUNT                                           = 8;
  D3D11_TESSELLATOR_MAX_EVEN_TESSELLATION_FACTOR                                = 64;
  D3D11_TESSELLATOR_MAX_ISOLINE_DENSITY_TESSELLATION_FACTOR                     = 64;
  D3D11_TESSELLATOR_MAX_ODD_TESSELLATION_FACTOR                                 = 63;
  D3D11_TESSELLATOR_MAX_TESSELLATION_FACTOR                                     = 64;
  D3D11_TESSELLATOR_MIN_EVEN_TESSELLATION_FACTOR                                = 2;
  D3D11_TESSELLATOR_MIN_ISOLINE_DENSITY_TESSELLATION_FACTOR                     = 1;
  D3D11_TESSELLATOR_MIN_ODD_TESSELLATION_FACTOR                                 = 1;
  D3D11_TEXEL_ADDRESS_RANGE_BIT_COUNT                                           = 16;
  D3D11_UNBOUND_MEMORY_ACCESS_RESULT                                            = 0;
  D3D11_VIEWPORT_AND_SCISSORRECT_MAX_INDEX                                      = 15;
  D3D11_VIEWPORT_AND_SCISSORRECT_OBJECT_COUNT_PER_PIPELINE                      = 16;
  D3D11_VIEWPORT_BOUNDS_MAX                                                     = 32767;
  D3D11_VIEWPORT_BOUNDS_MIN                                                     = -32768;
  D3D11_VS_INPUT_REGISTER_COMPONENTS                                            = 4;
  D3D11_VS_INPUT_REGISTER_COMPONENT_BIT_COUNT                                   = 32;
  D3D11_VS_INPUT_REGISTER_COUNT                                                 = 32;
  D3D11_VS_INPUT_REGISTER_READS_PER_INST                                        = 2;
  D3D11_VS_INPUT_REGISTER_READ_PORTS                                            = 1;
  D3D11_VS_OUTPUT_REGISTER_COMPONENTS                                           = 4;
  D3D11_VS_OUTPUT_REGISTER_COMPONENT_BIT_COUNT                                  = 32;
  D3D11_VS_OUTPUT_REGISTER_COUNT                                                = 32;
  D3D11_WHQL_CONTEXT_COUNT_FOR_RESOURCE_LIMIT                                   = 10;
  D3D11_WHQL_DRAWINDEXED_INDEX_COUNT_2_TO_EXP                                   = 25;
  D3D11_WHQL_DRAW_VERTEX_COUNT_2_TO_EXP                                         = 25;
  D3D11_1_UAV_SLOT_COUNT                                                        = 64;
  D3D11_2_TILED_RESOURCE_TILE_SIZE_IN_BYTES                                     = 65536;
  D3D11_APPEND_ALIGNED_ELEMENT                                                  = ($FFFFFFFF);
  _FACD3D11                                                                     = $87C;
  _FACD3D11DEBUG                                                                = (_FACD3D11 + 1);
  MAKE_D3D11_HRESULT                                                            = 1 shl 31 or _FACD3D11;
  MAKE_D3D11_STATUS                                                             = _FACD3D11;

const
  D3D11_FILTER_REDUCTION_TYPE_MASK  = ($3);
  D3D11_FILTER_REDUCTION_TYPE_SHIFT = (7);
  D3D11_FILTER_TYPE_MASK            = ($3);
  D3D11_MIN_FILTER_SHIFT            = (4);
  D3D11_MAG_FILTER_SHIFT            = (2);
  D3D11_MIP_FILTER_SHIFT            = (0);
  D3D11_COMPARISON_FILTERING_BIT    = ($80);
  D3D11_ANISOTROPIC_FILTERING_BIT   = ($40);

const
  D3D_RETURN_PARAMETER_INDEX                       = (-1);
  D3D_SHADER_REQUIRES_DOUBLES                      = $00000001;
  D3D_SHADER_REQUIRES_EARLY_DEPTH_STENCIL          = $00000002;
  D3D_SHADER_REQUIRES_UAVS_AT_EVERY_STAGE          = $00000004;
  D3D_SHADER_REQUIRES_64_UAVS                      = $00000008;
  D3D_SHADER_REQUIRES_MINIMUM_PRECISION            = $00000010;
  D3D_SHADER_REQUIRES_11_1_DOUBLE_EXTENSIONS       = $00000020;
  D3D_SHADER_REQUIRES_11_1_SHADER_EXTENSIONS       = $00000040;
  D3D_SHADER_REQUIRES_LEVEL_9_COMPARISON_FILTERING = $00000080;
  D3D_SHADER_REQUIRES_TILED_RESOURCES              = $00000100;

const
  D3D11_TRACE_COMPONENT_X                        = $1;
  D3D11_TRACE_COMPONENT_Y                        = $2;
  D3D11_TRACE_COMPONENT_Z                        = $4;
  D3D11_TRACE_COMPONENT_W                        = $8;
  D3D11_SHADER_TRACE_FLAG_RECORD_REGISTER_WRITES = $1;
  D3D11_SHADER_TRACE_FLAG_RECORD_REGISTER_READS  = $2;
  D3D11_TRACE_REGISTER_FLAGS_RELATIVE_INDEXING   = $1;
  D3D11_TRACE_MISC_GS_EMIT                       = $1;
  D3D11_TRACE_MISC_GS_CUT                        = $2;
  D3D11_TRACE_MISC_PS_DISCARD                    = $4;
  D3D11_TRACE_MISC_GS_EMIT_STREAM                = $8;
  D3D11_TRACE_MISC_GS_CUT_STREAM                 = $10;
  D3D11_TRACE_MISC_HALT                          = $20;
  D3D11_TRACE_MISC_MESSAGE                       = $40;

const
  D3D11_SDK_LAYERS_VERSION                                                   = (1);
  D3D11_DEBUG_FEATURE_FLUSH_PER_RENDER_OP                                    = ($1);
  D3D11_DEBUG_FEATURE_FINISH_PER_RENDER_OP                                   = ($2);
  D3D11_DEBUG_FEATURE_PRESENT_PER_RENDER_OP                                  = ($4);
  D3D11_DEBUG_FEATURE_ALWAYS_DISCARD_OFFERED_RESOURCE                        = ($8);
  D3D11_DEBUG_FEATURE_NEVER_DISCARD_OFFERED_RESOURCE                         = ($10);
  D3D11_DEBUG_FEATURE_AVOID_BEHAVIOR_CHANGING_DEBUG_AIDS                     = ($40);
  D3D11_DEBUG_FEATURE_DISABLE_TILED_RESOURCE_MAPPING_TRACKING_AND_VALIDATION = ($80);
  D3D11_REGKEY_PATH                                                          = 'Software\\Microsoft\\Direct3D';
  D3D11_MUTE_DEBUG_OUTPUT                                                    = 'MuteDebugOutput';
  D3D11_ENABLE_BREAK_ON_MESSAGE                                              = 'EnableBreakOnMessage';
  D3D11_INFOQUEUE_STORAGE_FILTER_OVERRIDE                                    = 'InfoQueueStorageFilterOverride';
  D3D11_MUTE_CATEGORY                                                        = 'Mute_CATEGORY_%s';
  D3D11_MUTE_SEVERITY                                                        = 'Mute_SEVERITY_%s';
  D3D11_MUTE_ID_STRING                                                       = 'Mute_ID_%s';
  D3D11_MUTE_ID_DECIMAL                                                      = 'Mute_ID_%d';
  D3D11_UNMUTE_SEVERITY_INFO                                                 = 'Unmute_SEVERITY_INFO';
  D3D11_BREAKON_CATEGORY                                                     = 'BreakOn_CATEGORY_%s';
  D3D11_BREAKON_SEVERITY                                                     = 'BreakOn_SEVERITY_%s';
  D3D11_BREAKON_ID_STRING                                                    = 'BreakOn_ID_%s';
  D3D11_BREAKON_ID_DECIMAL                                                   = 'BreakOn_ID_%d';
  D3D11_APPSIZE_STRING                                                       = 'Size';
  D3D11_APPNAME_STRING                                                       = 'Name';
  D3D11_FORCE_DEBUGGABLE                                                     = 'ForceDebuggable';
  D3D11_FORCE_SHADER_SKIP_OPTIMIZATION                                       = 'ForceShaderSkipOptimization';
  D3D11_INFO_QUEUE_DEFAULT_MESSAGE_COUNT_LIMIT                               = 1024;

type
  ID3D11Buffer                = interface;
  ID3D11RenderTargetView      = interface;
  ID3D11Texture1D             = interface;
  ID3D11Texture2D             = interface;
  ID3D11Texture3D             = interface;
  TD3D11_INPUT_CLASSIFICATION = (D3D11_INPUT_PER_VERTEX_DATA = 0, D3D11_INPUT_PER_INSTANCE_DATA = 1);
  TD3D11_FILL_MODE            = (D3D11_FILL_WIREFRAME = 2, D3D11_FILL_SOLID = 3);
  TD3D11_CULL_MODE            = (D3D11_CULL_NONE = 1, D3D11_CULL_FRONT = 2, D3D11_CULL_BACK = 3);
  TD3D11_RESOURCE_DIMENSION   = (D3D11_RESOURCE_DIMENSION_UNKNOWN = 0, D3D11_RESOURCE_DIMENSION_BUFFER = 1, D3D11_RESOURCE_DIMENSION_TEXTURE1D = 2, D3D11_RESOURCE_DIMENSION_TEXTURE2D = 3, D3D11_RESOURCE_DIMENSION_TEXTURE3D = 4);
  TD3D11_DSV_DIMENSION        = (D3D11_DSV_DIMENSION_UNKNOWN = 0, D3D11_DSV_DIMENSION_TEXTURE1D = 1, D3D11_DSV_DIMENSION_TEXTURE1DARRAY = 2, D3D11_DSV_DIMENSION_TEXTURE2D = 3, D3D11_DSV_DIMENSION_TEXTURE2DARRAY = 4, D3D11_DSV_DIMENSION_TEXTURE2DMS = 5, D3D11_DSV_DIMENSION_TEXTURE2DMSARRAY = 6);
  TD3D11_RTV_DIMENSION        = (D3D11_RTV_DIMENSION_UNKNOWN = 0, D3D11_RTV_DIMENSION_BUFFER = 1, D3D11_RTV_DIMENSION_TEXTURE1D = 2, D3D11_RTV_DIMENSION_TEXTURE1DARRAY = 3, D3D11_RTV_DIMENSION_TEXTURE2D = 4, D3D11_RTV_DIMENSION_TEXTURE2DARRAY = 5, D3D11_RTV_DIMENSION_TEXTURE2DMS = 6, D3D11_RTV_DIMENSION_TEXTURE2DMSARRAY = 7, D3D11_RTV_DIMENSION_TEXTURE3D = 8);
  TD3D11_UAV_DIMENSION        = (D3D11_UAV_DIMENSION_UNKNOWN = 0, D3D11_UAV_DIMENSION_BUFFER = 1, D3D11_UAV_DIMENSION_TEXTURE1D = 2, D3D11_UAV_DIMENSION_TEXTURE1DARRAY = 3, D3D11_UAV_DIMENSION_TEXTURE2D = 4, D3D11_UAV_DIMENSION_TEXTURE2DARRAY = 5, D3D11_UAV_DIMENSION_TEXTURE3D = 8);
  TD3D11_USAGE                = (D3D11_USAGE_DEFAULT = 0, D3D11_USAGE_IMMUTABLE = 1, D3D11_USAGE_DYNAMIC = 2, D3D11_USAGE_STAGING = 3);
  TD3D11_BIND_FLAG            = (D3D11_BIND_VERTEX_BUFFER = $1, D3D11_BIND_INDEX_BUFFER = $2, D3D11_BIND_CONSTANT_BUFFER = $4, D3D11_BIND_SHADER_RESOURCE = $8, D3D11_BIND_STREAM_OUTPUT = $10, D3D11_BIND_RENDER_TARGET = $20, D3D11_BIND_DEPTH_STENCIL = $40, D3D11_BIND_UNORDERED_ACCESS = $80, D3D11_BIND_DECODER = $200, D3D11_BIND_VIDEO_ENCODER = $400);
  TD3D11_CPU_ACCESS_FLAG      = (D3D11_CPU_ACCESS_WRITE = $10000, D3D11_CPU_ACCESS_READ = $20000);
  TD3D11_RESOURCE_MISC_FLAG   = (D3D11_RESOURCE_MISC_GENERATE_MIPS = $1, D3D11_RESOURCE_MISC_SHARED = $2, D3D11_RESOURCE_MISC_TEXTURECUBE = $4, D3D11_RESOURCE_MISC_DRAWINDIRECT_ARGS = $10, D3D11_RESOURCE_MISC_BUFFER_ALLOW_RAW_VIEWS = $20, D3D11_RESOURCE_MISC_BUFFER_STRUCTURED = $40, D3D11_RESOURCE_MISC_RESOURCE_CLAMP = $80, D3D11_RESOURCE_MISC_SHARED_KEYEDMUTEX = $100,
    D3D11_RESOURCE_MISC_GDI_COMPATIBLE = $200, D3D11_RESOURCE_MISC_SHARED_NTHANDLE = $800, D3D11_RESOURCE_MISC_RESTRICTED_CONTENT = $1000, D3D11_RESOURCE_MISC_RESTRICT_SHARED_RESOURCE = $2000, D3D11_RESOURCE_MISC_RESTRICT_SHARED_RESOURCE_DRIVER = $4000, D3D11_RESOURCE_MISC_GUARDED = $8000, D3D11_RESOURCE_MISC_TILE_POOL = $20000, D3D11_RESOURCE_MISC_TILED = $40000);
  TD3D11_MAP        = (D3D11_MAP_READ = 1, D3D11_MAP_WRITE = 2, D3D11_MAP_READ_WRITE = 3, D3D11_MAP_WRITE_DISCARD = 4, D3D11_MAP_WRITE_NO_OVERWRITE = 5);
  TD3D11_MAP_FLAG   = (D3D11_MAP_FLAG_DO_NOT_WAIT = $100000);
  TD3D11_RAISE_FLAG = (D3D11_RAISE_FLAG_DRIVER_INTERNAL_ERROR = $1);
  TD3D11_CLEAR_FLAG = (D3D11_CLEAR_DEPTH = $1, D3D11_CLEAR_STENCIL = $2);

  TD3D11_INPUT_ELEMENT_DESC = record
    SemanticName: PAnsiChar;
    SemanticIndex: UINT;
    Format: TDXGI_FORMAT;
    InputSlot: UINT;
    AlignedByteOffset: UINT;
    InputSlotClass: TD3D11_INPUT_CLASSIFICATION;
    InstanceDataStepRate: UINT;
  end;

  PD3D11_INPUT_ELEMENT_DESC = ^TD3D11_INPUT_ELEMENT_DESC;
  TD3D11_PRIMITIVE_TOPOLOGY = TD3D_PRIMITIVE_TOPOLOGY;
  PD3D11_PRIMITIVE_TOPOLOGY = ^TD3D11_PRIMITIVE_TOPOLOGY;
  TD3D11_PRIMITIVE          = TD3D_PRIMITIVE;
  PD3D11_PRIMITIVE          = ^TD3D11_PRIMITIVE;

  TD3D11_SO_DECLARATION_ENTRY = record
    Stream: UINT;
    SemanticName: PAnsiChar;
    SemanticIndex: UINT;
    StartComponent: byte;
    ComponentCount: byte;
    OutputSlot: byte;
  end;

  PD3D11_SO_DECLARATION_ENTRY = ^TD3D11_SO_DECLARATION_ENTRY;

  { TD3D11_VIEWPORT }
  TD3D11_VIEWPORT = record
    TopLeftX: Single;
    TopLeftY: Single;
    Width: Single;
    Height: Single;
    MinDepth: Single;
    MaxDepth: Single;
    class operator Equal(a, b: TD3D11_VIEWPORT): LongBool;
    class operator NotEqual(a, b: TD3D11_VIEWPORT): LongBool;
    procedure Init(TopLeftX: Single; TopLeftY: Single; Width: Single; Height: Single; MinDepth: Single = D3D11_MIN_DEPTH; MaxDepth: Single = D3D11_MAX_DEPTH); overload;
    procedure Init(InBuffer: ID3D11Buffer; pRTView: ID3D11RenderTargetView; TopLeftX: Single = 0.0; MinDepth: Single = D3D11_MIN_DEPTH; MaxDepth: Single = D3D11_MAX_DEPTH); overload;
    procedure Init(pTex1D: ID3D11Texture1D; pRTView: ID3D11RenderTargetView; TopLeftX: Single = 0.0; MinDepth: Single = D3D11_MIN_DEPTH; MaxDepth: Single = D3D11_MAX_DEPTH); overload;
    procedure Init(pTex2D: ID3D11Texture2D; pRTView: ID3D11RenderTargetView; TopLeftX: Single = 0.0; TopLeftY: Single = 0.0; MinDepth: Single = D3D11_MIN_DEPTH; MaxDepth: Single = D3D11_MAX_DEPTH); overload;
    procedure Init(pTex3D: ID3D11Texture3D; pRTView: ID3D11RenderTargetView; TopLeftX: Single = 0.0; TopLeftY: Single = 0.0; MinDepth: Single = D3D11_MIN_DEPTH; MaxDepth: Single = D3D11_MAX_DEPTH); overload;
  end;

  PD3D11_VIEWPORT      = ^TD3D11_VIEWPORT;
  TD3D11_SRV_DIMENSION = TD3D_SRV_DIMENSION;
  PD3D11_SRV_DIMENSION = ^TD3D11_SRV_DIMENSION;
  TD3D11_RECT          = TRECT;
  PD3D11_RECT          = ^TD3D11_RECT;

  { TD3D11_BOX }
  TD3D11_BOX = record
    left: UINT;
    top: UINT;
    front: UINT;
    right: UINT;
    bottom: UINT;
    back: UINT;
    class operator Equal(a, b: TD3D11_BOX): LongBool;
    class operator NotEqual(a, b: TD3D11_BOX): LongBool;
    procedure Init(ALeft: LONG; ATop: LONG; AFront: LONG; ARight: LONG; ABottom: LONG; ABack: LONG);
  end;

  PD3D11_BOX   = ^TD3D11_BOX;
  ID3D11Device = interface;

  ID3D11DeviceChild = interface(IUnknown)
    ['{1841e5c8-16b0-489b-bcc8-44cfb0d5deae}']
    procedure GetDevice(out ppDevice: ID3D11Device); stdcall;
    function GetPrivateData(guid: TGUID; var pDataSize: UINT; out pData: Pointer): HResult; stdcall;
    function SetPrivateData(guid: TGUID; DataSize: UINT; pData: Pointer): HResult; stdcall;
    function SetPrivateDataInterface(guid: TGUID; pData: IUnknown): HResult; stdcall;
  end;

  PID3D11DeviceChild      = ^ID3D11DeviceChild;
  TD3D11_COMPARISON_FUNC  = (D3D11_COMPARISON_NEVER = 1, D3D11_COMPARISON_LESS = 2, D3D11_COMPARISON_EQUAL = 3, D3D11_COMPARISON_LESS_EQUAL = 4, D3D11_COMPARISON_GREATER = 5, D3D11_COMPARISON_NOT_EQUAL = 6, D3D11_COMPARISON_GREATER_EQUAL = 7, D3D11_COMPARISON_ALWAYS = 8);
  TD3D11_DEPTH_WRITE_MASK = (D3D11_DEPTH_WRITE_MASK_ZERO = 0, D3D11_DEPTH_WRITE_MASK_ALL = 1);
  TD3D11_STENCIL_OP       = (D3D11_STENCIL_OP_KEEP = 1, D3D11_STENCIL_OP_ZERO = 2, D3D11_STENCIL_OP_REPLACE = 3, D3D11_STENCIL_OP_INCR_SAT = 4, D3D11_STENCIL_OP_DECR_SAT = 5, D3D11_STENCIL_OP_INVERT = 6, D3D11_STENCIL_OP_INCR = 7, D3D11_STENCIL_OP_DECR = 8);

  TD3D11_DEPTH_STENCILOP_DESC = record
    StencilFailOp: TD3D11_STENCIL_OP;
    StencilDepthFailOp: TD3D11_STENCIL_OP;
    StencilPassOp: TD3D11_STENCIL_OP;
    StencilFunc: TD3D11_COMPARISON_FUNC;
  end;

  PD3D11_DEPTH_STENCILOP_DESC = ^TD3D11_DEPTH_STENCILOP_DESC;

  { TD3D11_DEPTH_STENCIL_DESC }
  TD3D11_DEPTH_STENCIL_DESC = record
    DepthEnable: LongBool;
    DepthWriteMask: TD3D11_DEPTH_WRITE_MASK;
    DepthFunc: TD3D11_COMPARISON_FUNC;
    StencilEnable: LongBool;
    StencilReadMask: UINT8;
    StencilWriteMask: UINT8;
    FrontFace: TD3D11_DEPTH_STENCILOP_DESC;
    BackFace: TD3D11_DEPTH_STENCILOP_DESC;
    procedure Init;
    function defaultStencilOp: TD3D11_DEPTH_STENCILOP_DESC;
  end;

  PD3D11_DEPTH_STENCIL_DESC = ^TD3D11_DEPTH_STENCIL_DESC;
  TD3D11_BLEND = (D3D11_BLEND_ZERO = 1, D3D11_BLEND_ONE = 2, D3D11_BLEND_SRC_COLOR = 3, D3D11_BLEND_INV_SRC_COLOR = 4, D3D11_BLEND_SRC_ALPHA = 5, D3D11_BLEND_INV_SRC_ALPHA = 6, D3D11_BLEND_DEST_ALPHA = 7, D3D11_BLEND_INV_DEST_ALPHA = 8, D3D11_BLEND_DEST_COLOR = 9, D3D11_BLEND_INV_DEST_COLOR = 10, D3D11_BLEND_SRC_ALPHA_SAT = 11, D3D11_BLEND_BLEND_FACTOR = 14, D3D11_BLEND_INV_BLEND_FACTOR = 15,
    D3D11_BLEND_SRC1_COLOR = 16, D3D11_BLEND_INV_SRC1_COLOR = 17, D3D11_BLEND_SRC1_ALPHA = 18, D3D11_BLEND_INV_SRC1_ALPHA = 19);
  TD3D11_BLEND_OP           = (D3D11_BLEND_OP_ADD = 1, D3D11_BLEND_OP_SUBTRACT = 2, D3D11_BLEND_OP_REV_SUBTRACT = 3, D3D11_BLEND_OP_MIN = 4, D3D11_BLEND_OP_MAX = 5);
  TD3D11_COLOR_WRITE_ENABLE = (D3D11_COLOR_WRITE_ENABLE_RED = 1, D3D11_COLOR_WRITE_ENABLE_GREEN = 2, D3D11_COLOR_WRITE_ENABLE_BLUE = 4, D3D11_COLOR_WRITE_ENABLE_ALPHA = 8, D3D11_COLOR_WRITE_ENABLE_ALL = (Ord(D3D11_COLOR_WRITE_ENABLE_RED) or Ord(D3D11_COLOR_WRITE_ENABLE_GREEN) or Ord(D3D11_COLOR_WRITE_ENABLE_BLUE) or Ord(D3D11_COLOR_WRITE_ENABLE_ALPHA)));

  TD3D11_RENDER_TARGET_BLEND_DESC = record
    BlendEnable: LongBool;
    SrcBlend: TD3D11_BLEND;
    DestBlend: TD3D11_BLEND;
    BlendOp: TD3D11_BLEND_OP;
    SrcBlendAlpha: TD3D11_BLEND;
    DestBlendAlpha: TD3D11_BLEND;
    BlendOpAlpha: TD3D11_BLEND_OP;
    RenderTargetWriteMask: UINT8;
  end;

  { TD3D11_BLEND_DESC }
  TD3D11_BLEND_DESC = record
    AlphaToCoverageEnable: LongBool;
    IndependentBlendEnable: LongBool;
    RenderTarget: array [0 .. 7] of TD3D11_RENDER_TARGET_BLEND_DESC;
    procedure Init;
    function defaultRenderTargetBlendDesc: TD3D11_RENDER_TARGET_BLEND_DESC;
  end;

  PD3D11_BLEND_DESC = ^TD3D11_BLEND_DESC;

  { TD3D11_RASTERIZER_DESC }
  TD3D11_RASTERIZER_DESC = record
    FillMode: TD3D11_FILL_MODE;
    CullMode: TD3D11_CULL_MODE;
    FrontCounterClockwise: LongBool;
    DepthBias: Integer;
    DepthBiasClamp: Single;
    SlopeScaledDepthBias: Single;
    DepthClipEnable: LongBool;
    ScissorEnable: LongBool;
    MultisampleEnable: LongBool;
    AntialiasedLineEnable: LongBool;
    procedure Init;
  end;

  PD3D11_RASTERIZER_DESC = ^TD3D11_RASTERIZER_DESC;

  ID3D11DepthStencilState = interface(ID3D11DeviceChild)
    ['{03823efb-8d8f-4e1c-9aa2-f64bb2cbfdf1}']
    procedure GetDesc(out pDesc: TD3D11_DEPTH_STENCIL_DESC); stdcall;
  end;

  PID3D11DepthStencilState = ^ID3D11DepthStencilState;

  ID3D11BlendState = interface(ID3D11DeviceChild)
    ['{75b68faa-347d-4159-8f45-a0640f01cd9a}']
    procedure GetDesc(out pDesc: TD3D11_BLEND_DESC); stdcall;
  end;

  PID3D11BlendState = ^ID3D11BlendState;

  ID3D11RasterizerState = interface(ID3D11DeviceChild)
    ['{9bb4ab81-ab1a-4d8f-b506-fc04200b6ee7}']
    procedure GetDesc(out pDesc: TD3D11_RASTERIZER_DESC); stdcall;
  end;

  PID3D11RasterizerState = ^ID3D11RasterizerState;

  TD3D11_SUBRESOURCE_DATA = record
    pSysMem: Pointer;
    SysMemPitch: UINT;
    SysMemSlicePitch: UINT;
  end;

  PD3D11_SUBRESOURCE_DATA = ^TD3D11_SUBRESOURCE_DATA;

  TD3D11_MAPPED_SUBRESOURCE = record
    pData: Pointer;
    RowPitch: UINT;
    DepthPitch: UINT;
  end;

  PD3D11_MAPPED_SUBRESOURCE = ^TD3D11_MAPPED_SUBRESOURCE;

  ID3D11Resource = interface(ID3D11DeviceChild)
    ['{dc8e63f3-d12b-4952-b47b-5e45026a862d}']
    procedure GetType(out pResourceDimension: TD3D11_RESOURCE_DIMENSION); stdcall;
    procedure SetEvictionPriority(EvictionPriority: UINT); stdcall;
    function GetEvictionPriority(): UINT; stdcall;
  end;

  PID3D11Resource = ^ID3D11Resource;

  { TD3D11_BUFFER_DESC }
  TD3D11_BUFFER_DESC = record
    ByteWidth: UINT;
    Usage: TD3D11_USAGE;
    BindFlags: UINT;
    CPUAccessFlags: UINT;
    MiscFlags: UINT;
    StructureByteStride: UINT;
    procedure Init(AByteWidth: UINT; ABindFlags: UINT; AUsage: TD3D11_USAGE = D3D11_USAGE_DEFAULT; ACPUAccessFlags: UINT = 0; AMiscFlags: UINT = 0; AStructureByteStride: UINT = 0);
  end;

  PD3D11_BUFFER_DESC = ^TD3D11_BUFFER_DESC;

  ID3D11Buffer = interface(ID3D11Resource)
    ['{48570b85-d1ee-4fcd-a250-eb350722b037}']
    procedure GetDesc(out pDesc: TD3D11_BUFFER_DESC); stdcall;
  end;

  PID3D11Buffer = ^ID3D11Buffer;

  { TD3D11_TEXTURE1D_DESC }
  TD3D11_TEXTURE1D_DESC = record
    Width: UINT;
    MipLevels: UINT;
    ArraySize: UINT;
    Format: TDXGI_FORMAT;
    Usage: TD3D11_USAGE;
    BindFlags: UINT;
    CPUAccessFlags: UINT;
    MiscFlags: UINT;
    procedure Init(AFormat: TDXGI_FORMAT; AWidth: UINT; AArraySize: UINT = 1; AMipLevels: UINT = 0; ABindFlags: UINT = Ord(D3D11_BIND_SHADER_RESOURCE); AUsage: TD3D11_USAGE = D3D11_USAGE_DEFAULT; ACPUAccessFlags: UINT = 0; AMiscFlags: UINT = 0);
  end;

  PD3D11_TEXTURE1D_DESC = ^TD3D11_TEXTURE1D_DESC;

  ID3D11Texture1D = interface(ID3D11Resource)
    ['{f8fb5c27-c6b3-4f75-a4c8-439af2ef564c}']
    procedure GetDesc(out pDesc: TD3D11_TEXTURE1D_DESC); stdcall;
  end;

  { TD3D11_TEXTURE2D_DESC }
  TD3D11_TEXTURE2D_DESC = record
    Width: UINT;
    Height: UINT;
    MipLevels: UINT;
    ArraySize: UINT;
    Format: TDXGI_FORMAT;
    SampleDesc: TDXGI_SAMPLE_DESC;
    Usage: TD3D11_USAGE;
    BindFlags: UINT;
    CPUAccessFlags: UINT;
    MiscFlags: UINT;
    procedure Init(AFormat: TDXGI_FORMAT; AWidth: UINT; AHeight: UINT; AArraySize: UINT = 1; AMipLevels: UINT = 0; ABindFlags: UINT = Ord(D3D11_BIND_SHADER_RESOURCE); AUsage: TD3D11_USAGE = D3D11_USAGE_DEFAULT; ACPUAccessFlags: UINT = 0; ASampleCount: UINT = 1; ASampleQuality: UINT = 0; AMiscFlags: UINT = 0);
  end;

  PD3D11_TEXTURE2D_DESC = ^TD3D11_TEXTURE2D_DESC;

  ID3D11Texture2D = interface(ID3D11Resource)
    ['{6f15aaf2-d208-4e89-9ab4-489535d34f9c}']
    procedure GetDesc(out pDesc: TD3D11_TEXTURE2D_DESC); stdcall;
  end;

  { TD3D11_TEXTURE3D_DESC }
  TD3D11_TEXTURE3D_DESC = record
    Width: UINT;
    Height: UINT;
    Depth: UINT;
    MipLevels: UINT;
    Format: TDXGI_FORMAT;
    Usage: TD3D11_USAGE;
    BindFlags: UINT;
    CPUAccessFlags: UINT;
    MiscFlags: UINT;
    procedure Init(AFormat: TDXGI_FORMAT; AWidth: UINT; AHeight: UINT; ADepth: UINT; AMipLevels: UINT = 0; ABindFlags: UINT = Ord(D3D11_BIND_SHADER_RESOURCE); AUsage: TD3D11_USAGE = D3D11_USAGE_DEFAULT; ACPUAccessFlags: UINT = 0; AMiscFlags: UINT = 0);
  end;

  PD3D11_TEXTURE3D_DESC = ^TD3D11_TEXTURE3D_DESC;

  ID3D11Texture3D = interface(ID3D11Resource)
    ['{037e866e-f56d-4357-a8af-9dabbe6e250e}']
    procedure GetDesc(out pDesc: TD3D11_TEXTURE3D_DESC); stdcall;
  end;

  TD3D11_TEXTURECUBE_FACE = (D3D11_TEXTURECUBE_FACE_POSITIVE_X = 0, D3D11_TEXTURECUBE_FACE_NEGATIVE_X = 1, D3D11_TEXTURECUBE_FACE_POSITIVE_Y = 2, D3D11_TEXTURECUBE_FACE_NEGATIVE_Y = 3, D3D11_TEXTURECUBE_FACE_POSITIVE_Z = 4, D3D11_TEXTURECUBE_FACE_NEGATIVE_Z = 5);

  ID3D11View = interface(ID3D11DeviceChild)
    ['{839d1216-bb2e-412b-b7f4-a9dbebe08ed1}']
    procedure GetResource(out ppResource: ID3D11Resource); stdcall;
  end;

  TD3D11_BUFFER_SRV = record
    case Integer of
      0:
        (FirstElement: UINT;
          NumElements: UINT;);
      1:
        (ElementOffset: UINT;
          ElementWidth: UINT;);
  end;

  PD3D11_BUFFER_SRV        = ^TD3D11_BUFFER_SRV;
  TD3D11_BUFFEREX_SRV_FLAG = (D3D11_BUFFEREX_SRV_FLAG_RAW = $1);

  TD3D11_BUFFEREX_SRV = record
    FirstElement: UINT;
    NumElements: UINT;
    Flags: UINT;
  end;

  PD3D11_BUFFEREX_SRV = ^TD3D11_BUFFEREX_SRV;

  TD3D11_TEX1D_SRV = record
    MostDetailedMip: UINT;
    MipLevels: UINT;
  end;

  TD3D11_TEX1D_ARRAY_SRV = record
    MostDetailedMip: UINT;
    MipLevels: UINT;
    FirstArraySlice: UINT;
    ArraySize: UINT;
  end;

  TD3D11_TEX2D_SRV = record
    MostDetailedMip: UINT;
    MipLevels: UINT;
  end;

  TD3D11_TEX2D_ARRAY_SRV = record
    MostDetailedMip: UINT;
    MipLevels: UINT;
    FirstArraySlice: UINT;
    ArraySize: UINT;
  end;

  TD3D11_TEX3D_SRV = record
    MostDetailedMip: UINT;
    MipLevels: UINT;
  end;

  TD3D11_TEXCUBE_SRV = record
    MostDetailedMip: UINT;
    MipLevels: UINT;
  end;

  TD3D11_TEXCUBE_ARRAY_SRV = record
    MostDetailedMip: UINT;
    MipLevels: UINT;
    First2DArrayFace: UINT;
    NumCubes: UINT;
  end;

  TD3D11_TEX2DMS_SRV = record
    UnusedField_NothingToDefine: UINT;
  end;

  TD3D11_TEX2DMS_ARRAY_SRV = record
    FirstArraySlice: UINT;
    ArraySize: UINT;
  end;

  { TD3D11_SHADER_RESOURCE_VIEW_DESC }
  TD3D11_SHADER_RESOURCE_VIEW_DESC = record
    Format: TDXGI_FORMAT;
    ViewDimension: TD3D11_SRV_DIMENSION;
    procedure Init(AViewDimension: TD3D11_SRV_DIMENSION; AFormat: TDXGI_FORMAT = DXGI_FORMAT_UNKNOWN; AMostDetailedMip: UINT = 0; AMipLevels: INT32 = -1; AFirstArraySlice: UINT = 0; AArraySize: INT32 = -1; AFlags: UINT = 0); overload;
    procedure Init(ABuffer: ID3D11Buffer; AFormat: TDXGI_FORMAT; AfirstElement: UINT; AnumElements: UINT; AFlags: UINT = 0); overload;
    procedure Init(pTex1D: ID3D11Texture1D; AViewDimension: TD3D11_SRV_DIMENSION; AFormat: TDXGI_FORMAT = DXGI_FORMAT_UNKNOWN; AMostDetailedMip: UINT = 0; AMipLevels: INT32 = -1; AFirstArraySlice: UINT = 0; AArraySize: INT32 = -1); overload;
    procedure Init(pTex2D: ID3D11Texture2D; AViewDimension: TD3D11_SRV_DIMENSION; AFormat: TDXGI_FORMAT = DXGI_FORMAT_UNKNOWN; AMostDetailedMip: UINT = 0; AMipLevels: INT32 = -1; AFirstArraySlice: UINT = 0; AArraySize: INT32 = -1); overload;
    procedure Init(pTex3D: ID3D11Texture3D; AFormat: TDXGI_FORMAT = DXGI_FORMAT_UNKNOWN; AMostDetailedMip: UINT = 0; AMipLevels: INT32 = -1); overload;
    case Integer of
      0:
        (Buffer: TD3D11_BUFFER_SRV;);
      1:
        (Texture1D: TD3D11_TEX1D_SRV;);
      2:
        (Texture1DArray: TD3D11_TEX1D_ARRAY_SRV;);
      3:
        (Texture2D: TD3D11_TEX2D_SRV;);
      4:
        (Texture2DArray: TD3D11_TEX2D_ARRAY_SRV;);
      5:
        (Texture2DMS: TD3D11_TEX2DMS_SRV;);
      6:
        (Texture2DMSArray: TD3D11_TEX2DMS_ARRAY_SRV;);
      7:
        (Texture3D: TD3D11_TEX3D_SRV;);
      8:
        (TextureCube: TD3D11_TEXCUBE_SRV;);
      9:
        (TextureCubeArray: TD3D11_TEXCUBE_ARRAY_SRV;);
      10:
        (BufferEx: TD3D11_BUFFEREX_SRV;);
  end;

  PD3D11_SHADER_RESOURCE_VIEW_DESC = ^TD3D11_SHADER_RESOURCE_VIEW_DESC;

  ID3D11ShaderResourceView = interface(ID3D11View)
    ['{b0e06fe0-8192-4e1a-b1ca-36d7414710b2}']
    procedure GetDesc(out pDesc: TD3D11_SHADER_RESOURCE_VIEW_DESC); stdcall;
  end;

  PID3D11ShaderResourceView = ^ID3D11ShaderResourceView;

  TD3D11_BUFFER_RTV = record
    case Integer of
      0:
        (FirstElement: UINT;
          NumElements: UINT;);
      1:
        (ElementOffset: UINT;
          ElementWidth: UINT;
        );
  end;

  PD3D11_BUFFER_RTV = ^TD3D11_BUFFER_RTV;

  TD3D11_TEX1D_RTV = record
    MipSlice: UINT;
  end;

  TD3D11_TEX1D_ARRAY_RTV = record
    MipSlice: UINT;
    FirstArraySlice: UINT;
    ArraySize: UINT;
  end;

  TD3D11_TEX2D_RTV = record
    MipSlice: UINT;
  end;

  TD3D11_TEX2DMS_RTV = record
    UnusedField_NothingToDefine: UINT;
  end;

  TD3D11_TEX2D_ARRAY_RTV = record
    MipSlice: UINT;
    FirstArraySlice: UINT;
    ArraySize: UINT;
  end;

  TD3D11_TEX2DMS_ARRAY_RTV = record
    FirstArraySlice: UINT;
    ArraySize: UINT;
  end;

  TD3D11_TEX3D_RTV = record
    MipSlice: UINT;
    FirstWSlice: UINT;
    WSize: UINT;
  end;

  { TD3D11_RENDER_TARGET_VIEW_DESC }
  TD3D11_RENDER_TARGET_VIEW_DESC = record
    Format: TDXGI_FORMAT;
    ViewDimension: TD3D11_RTV_DIMENSION;
    procedure Init(AViewDimension: TD3D11_RTV_DIMENSION; AFormat: TDXGI_FORMAT = DXGI_FORMAT_UNKNOWN; MipSlice: UINT = 0; FirstArraySlice: UINT = 0; ArraySize: INT32 = -1); overload;
    procedure Init(pBuffer: ID3D11Buffer; AFormat: TDXGI_FORMAT; FirstElement: UINT; NumElements: UINT); overload;
    procedure Init(pTex1D: ID3D11Texture1D; AViewDimension: TD3D11_RTV_DIMENSION; AFormat: TDXGI_FORMAT = DXGI_FORMAT_UNKNOWN; MipSlice: UINT = 0; FirstArraySlice: UINT = 0; ArraySize: INT32 = -1); overload;
    procedure Init(pTex2D: ID3D11Texture2D; AViewDimension: TD3D11_RTV_DIMENSION; AFormat: TDXGI_FORMAT = DXGI_FORMAT_UNKNOWN; MipSlice: UINT = 0; FirstArraySlice: UINT = 0; ArraySize: INT32 = -1); overload;
    procedure Init(pTex3D: ID3D11Texture3D; AFormat: TDXGI_FORMAT = DXGI_FORMAT_UNKNOWN; MipSlice: UINT = 0; FirstWSlice: UINT = 0; WSize: INT32 = -1); overload;
    case Integer of
      0:
        (Buffer: TD3D11_BUFFER_RTV;);
      1:
        (Texture1D: TD3D11_TEX1D_RTV;);
      2:
        (Texture1DArray: TD3D11_TEX1D_ARRAY_RTV;);
      3:
        (Texture2D: TD3D11_TEX2D_RTV;);
      4:
        (Texture2DArray: TD3D11_TEX2D_ARRAY_RTV;);
      5:
        (Texture2DMS: TD3D11_TEX2DMS_RTV;);
      6:
        (Texture2DMSArray: TD3D11_TEX2DMS_ARRAY_RTV;);
      7:
        (Texture3D: TD3D11_TEX3D_RTV;);
  end;

  PD3D11_RENDER_TARGET_VIEW_DESC = ^TD3D11_RENDER_TARGET_VIEW_DESC;

  ID3D11RenderTargetView = interface(ID3D11View)
    ['{dfdba067-0b8d-4865-875b-d7b4516cc164}']
    procedure GetDesc(out pDesc: TD3D11_RENDER_TARGET_VIEW_DESC); stdcall;
  end;

  PID3D11RenderTargetView = ^ID3D11RenderTargetView;

  TD3D11_TEX1D_DSV = record
    MipSlice: UINT;
  end;

  TD3D11_TEX1D_ARRAY_DSV = record
    MipSlice: UINT;
    FirstArraySlice: UINT;
    ArraySize: UINT;
  end;

  TD3D11_TEX2D_DSV = record
    MipSlice: UINT;
  end;

  TD3D11_TEX2D_ARRAY_DSV = record
    MipSlice: UINT;
    FirstArraySlice: UINT;
    ArraySize: UINT;
  end;

  TD3D11_TEX2DMS_DSV = record
    UnusedField_NothingToDefine: UINT;
  end;

  TD3D11_TEX2DMS_ARRAY_DSV = record
    FirstArraySlice: UINT;
    ArraySize: UINT;
  end;

  TD3D11_DSV_FLAG = (D3D11_DSV_READ_ONLY_DEPTH = $1, D3D11_DSV_READ_ONLY_STENCIL = $2);

  { TD3D11_DEPTH_STENCIL_VIEW_DESC }
  TD3D11_DEPTH_STENCIL_VIEW_DESC = record
    Format: TDXGI_FORMAT;
    ViewDimension: TD3D11_DSV_DIMENSION;
    Flags: UINT;
    procedure Init(AViewDimension: TD3D11_DSV_DIMENSION; AFormat: TDXGI_FORMAT = DXGI_FORMAT_UNKNOWN; MipSlice: UINT = 0; FirstArraySlice: UINT = 0; ArraySize: INT32 = -1; AFlags: UINT = 0); overload;
    procedure Init(pTex1D: ID3D11Texture1D; AViewDimension: TD3D11_DSV_DIMENSION; AFormat: TDXGI_FORMAT = DXGI_FORMAT_UNKNOWN; MipSlice: UINT = 0; FirstArraySlice: UINT = 0; ArraySize: INT32 = -1; AFlags: UINT = 0); overload;
    procedure Init(pTex2D: ID3D11Texture2D; AViewDimension: TD3D11_DSV_DIMENSION; AFormat: TDXGI_FORMAT = DXGI_FORMAT_UNKNOWN; MipSlice: UINT = 0; FirstArraySlice: UINT = 0; ArraySize: INT32 = -1; AFlags: UINT = 0); overload;
    case Integer of
      0:
        (Texture1D: TD3D11_TEX1D_DSV;);
      1:
        (Texture1DArray: TD3D11_TEX1D_ARRAY_DSV;);
      2:
        (Texture2D: TD3D11_TEX2D_DSV;);
      3:
        (Texture2DArray: TD3D11_TEX2D_ARRAY_DSV;);
      4:
        (Texture2DMS: TD3D11_TEX2DMS_DSV;);
      5:
        (Texture2DMSArray: TD3D11_TEX2DMS_ARRAY_DSV;);
  end;

  PD3D11_DEPTH_STENCIL_VIEW_DESC = ^TD3D11_DEPTH_STENCIL_VIEW_DESC;

  ID3D11DepthStencilView = interface(ID3D11View)
    ['{9fdac92a-1876-48c3-afad-25b94f84a9b6}']
    procedure GetDesc(out pDesc: TD3D11_DEPTH_STENCIL_VIEW_DESC); stdcall;
  end;

  PID3D11DepthStencilView = ^ID3D11DepthStencilView;
  TD3D11_BUFFER_UAV_FLAG  = (D3D11_BUFFER_UAV_FLAG_RAW = $1, D3D11_BUFFER_UAV_FLAG_APPEND = $2, D3D11_BUFFER_UAV_FLAG_COUNTER = $4);

  TD3D11_BUFFER_UAV = record
    FirstElement: UINT;
    NumElements: UINT;
    Flags: UINT;
  end;

  TD3D11_TEX1D_UAV = record
    MipSlice: UINT;
  end;

  TD3D11_TEX1D_ARRAY_UAV = record
    MipSlice: UINT;
    FirstArraySlice: UINT;
    ArraySize: UINT;
  end;

  TD3D11_TEX2D_UAV = record
    MipSlice: UINT;
  end;

  TD3D11_TEX2D_ARRAY_UAV = record
    MipSlice: UINT;
    FirstArraySlice: UINT;
    ArraySize: UINT;
  end;

  TD3D11_TEX3D_UAV = record
    MipSlice: UINT;
    FirstWSlice: UINT;
    WSize: UINT;
  end;

  { TD3D11_UNORDERED_ACCESS_VIEW_DESC }
  TD3D11_UNORDERED_ACCESS_VIEW_DESC = record
    Format: TDXGI_FORMAT;
    ViewDimension: TD3D11_UAV_DIMENSION;
    procedure Init(AViewDimension: TD3D11_UAV_DIMENSION; AFormat: TDXGI_FORMAT = DXGI_FORMAT_UNKNOWN; MipSlice: UINT = 0; FirstArraySlice: UINT = 0; ArraySize: INT32 = -1; Flags: UINT = 0); overload;
    procedure Init(ABuffer: ID3D11Buffer; AFormat: TDXGI_FORMAT; FirstElement: UINT; NumElements: UINT; Flags: UINT = 0); overload;
    procedure Init(pTex1D: ID3D11Texture1D; AViewDimension: TD3D11_UAV_DIMENSION; AFormat: TDXGI_FORMAT = DXGI_FORMAT_UNKNOWN; MipSlice: UINT = 0; FirstArraySlice: UINT = 0; ArraySize: INT32 = -1); overload;
    procedure Init(pTex2D: ID3D11Texture2D; AViewDimension: TD3D11_UAV_DIMENSION; Format: TDXGI_FORMAT = DXGI_FORMAT_UNKNOWN; MipSlice: UINT = 0; FirstArraySlice: UINT = 0; ArraySize: INT32 = -1); overload;
    procedure Init(pTex3D: ID3D11Texture3D; AFormat: TDXGI_FORMAT = DXGI_FORMAT_UNKNOWN; MipSlice: UINT = 0; FirstWSlice: UINT = 0; WSize: INT32 = -1); overload;
    case Integer of
      0:
        (Buffer: TD3D11_BUFFER_UAV;);
      1:
        (Texture1D: TD3D11_TEX1D_UAV;);
      2:
        (Texture1DArray: TD3D11_TEX1D_ARRAY_UAV;);
      3:
        (Texture2D: TD3D11_TEX2D_UAV;);
      4:
        (Texture2DArray: TD3D11_TEX2D_ARRAY_UAV;);
      5:
        (Texture3D: TD3D11_TEX3D_UAV;);
  end;

  PD3D11_UNORDERED_ACCESS_VIEW_DESC = ^TD3D11_UNORDERED_ACCESS_VIEW_DESC;

  ID3D11UnorderedAccessView = interface(ID3D11View)
    ['{28acf509-7f5c-48f6-8611-f316010a6380}']
    procedure GetDesc(out pDesc: TD3D11_UNORDERED_ACCESS_VIEW_DESC); stdcall;
  end;

  PID3D11UnorderedAccessView = ^ID3D11UnorderedAccessView;

  ID3D11VertexShader = interface(ID3D11DeviceChild)
    ['{3b301d64-d678-4289-8897-22f8928b72f3}']
  end;

  pID3D11VertexShader = ^ID3D11VertexShader;

  ID3D11HullShader = interface(ID3D11DeviceChild)
    ['{8e5c6061-628a-4c8e-8264-bbe45cb3d5dd}']
  end;

  PID3D11HullShader = ^ID3D11HullShader;

  ID3D11DomainShader = interface(ID3D11DeviceChild)
    ['{f582c508-0f36-490c-9977-31eece268cfa}']
  end;

  PID3D11DomainShader = ^ID3D11DomainShader;

  ID3D11GeometryShader = interface(ID3D11DeviceChild)
    ['{38325b96-effb-4022-ba02-2e795b70275c}']
  end;

  PID3D11GeometryShader = ^ID3D11GeometryShader;

  ID3D11PixelShader = interface(ID3D11DeviceChild)
    ['{ea82e40d-51dc-4f33-93d4-db7c9125ae8c}']
  end;

  PID3D11PixelShader = ^ID3D11PixelShader;

  ID3D11ComputeShader = interface(ID3D11DeviceChild)
    ['{4f5b196e-c2bd-495e-bd01-1fded38e4969}']
  end;

  PID3D11ComputeShader = ^ID3D11ComputeShader;

  ID3D11InputLayout = interface(ID3D11DeviceChild)
    ['{e4819ddc-4cf0-4025-bd26-5de82a3e07b7}']
  end;

  PID3D11InputLayout = ^ID3D11InputLayout;
  TD3D11_FILTER      = (D3D11_FILTER_MIN_MAG_MIP_POINT = 0, D3D11_FILTER_MIN_MAG_POINT_MIP_LINEAR = $1, D3D11_FILTER_MIN_POINT_MAG_LINEAR_MIP_POINT = $4, D3D11_FILTER_MIN_POINT_MAG_MIP_LINEAR = $5, D3D11_FILTER_MIN_LINEAR_MAG_MIP_POINT = $10, D3D11_FILTER_MIN_LINEAR_MAG_POINT_MIP_LINEAR = $11, D3D11_FILTER_MIN_MAG_LINEAR_MIP_POINT = $14, D3D11_FILTER_MIN_MAG_MIP_LINEAR = $15,
    D3D11_FILTER_ANISOTROPIC = $55, D3D11_FILTER_COMPARISON_MIN_MAG_MIP_POINT = $80, D3D11_FILTER_COMPARISON_MIN_MAG_POINT_MIP_LINEAR = $81, D3D11_FILTER_COMPARISON_MIN_POINT_MAG_LINEAR_MIP_POINT = $84, D3D11_FILTER_COMPARISON_MIN_POINT_MAG_MIP_LINEAR = $85, D3D11_FILTER_COMPARISON_MIN_LINEAR_MAG_MIP_POINT = $90, D3D11_FILTER_COMPARISON_MIN_LINEAR_MAG_POINT_MIP_LINEAR = $91,
    D3D11_FILTER_COMPARISON_MIN_MAG_LINEAR_MIP_POINT = $94, D3D11_FILTER_COMPARISON_MIN_MAG_MIP_LINEAR = $95, D3D11_FILTER_COMPARISON_ANISOTROPIC = $D5, D3D11_FILTER_MINIMUM_MIN_MAG_MIP_POINT = $100, D3D11_FILTER_MINIMUM_MIN_MAG_POINT_MIP_LINEAR = $101, D3D11_FILTER_MINIMUM_MIN_POINT_MAG_LINEAR_MIP_POINT = $104, D3D11_FILTER_MINIMUM_MIN_POINT_MAG_MIP_LINEAR = $105,
    D3D11_FILTER_MINIMUM_MIN_LINEAR_MAG_MIP_POINT = $110, D3D11_FILTER_MINIMUM_MIN_LINEAR_MAG_POINT_MIP_LINEAR = $111, D3D11_FILTER_MINIMUM_MIN_MAG_LINEAR_MIP_POINT = $114, D3D11_FILTER_MINIMUM_MIN_MAG_MIP_LINEAR = $115, D3D11_FILTER_MINIMUM_ANISOTROPIC = $155, D3D11_FILTER_MAXIMUM_MIN_MAG_MIP_POINT = $180, D3D11_FILTER_MAXIMUM_MIN_MAG_POINT_MIP_LINEAR = $181,
    D3D11_FILTER_MAXIMUM_MIN_POINT_MAG_LINEAR_MIP_POINT = $184, D3D11_FILTER_MAXIMUM_MIN_POINT_MAG_MIP_LINEAR = $185, D3D11_FILTER_MAXIMUM_MIN_LINEAR_MAG_MIP_POINT = $190, D3D11_FILTER_MAXIMUM_MIN_LINEAR_MAG_POINT_MIP_LINEAR = $191, D3D11_FILTER_MAXIMUM_MIN_MAG_LINEAR_MIP_POINT = $194, D3D11_FILTER_MAXIMUM_MIN_MAG_MIP_LINEAR = $195, D3D11_FILTER_MAXIMUM_ANISOTROPIC = $1D5);
  TD3D11_FILTER_TYPE           = (D3D11_FILTER_TYPE_POINT = 0, D3D11_FILTER_TYPE_LINEAR = 1);
  TD3D11_FILTER_REDUCTION_TYPE = (D3D11_FILTER_REDUCTION_TYPE_STANDARD = 0, D3D11_FILTER_REDUCTION_TYPE_COMPARISON = 1, D3D11_FILTER_REDUCTION_TYPE_MINIMUM = 2, D3D11_FILTER_REDUCTION_TYPE_MAXIMUM = 3);
  TD3D11_TEXTURE_ADDRESS_MODE  = (D3D11_TEXTURE_ADDRESS_WRAP = 1, D3D11_TEXTURE_ADDRESS_MIRROR = 2, D3D11_TEXTURE_ADDRESS_CLAMP = 3, D3D11_TEXTURE_ADDRESS_BORDER = 4, D3D11_TEXTURE_ADDRESS_MIRROR_ONCE = 5);

  { TD3D11_SAMPLER_DESC }
  TD3D11_SAMPLER_DESC = record
    Filter: TD3D11_FILTER;
    AddressU: TD3D11_TEXTURE_ADDRESS_MODE;
    AddressV: TD3D11_TEXTURE_ADDRESS_MODE;
    AddressW: TD3D11_TEXTURE_ADDRESS_MODE;
    MipLODBias: Single;
    MaxAnisotropy: UINT;
    ComparisonFunc: TD3D11_COMPARISON_FUNC;
    BorderColor: array [0 .. 3] of Single;
    MinLOD: Single;
    MaxLOD: Single;
    procedure Init; overload;
    procedure Init(AFilter: TD3D11_FILTER; AAddressU: TD3D11_TEXTURE_ADDRESS_MODE; AAddressV: TD3D11_TEXTURE_ADDRESS_MODE; AAddressW: TD3D11_TEXTURE_ADDRESS_MODE; AMipLODBias: Single; AMaxAnisotropy: UINT; AComparisonFunc: TD3D11_COMPARISON_FUNC; ABorderColor: TFloatArray4; AMinLOD: Single; AMaxLOD: Single); overload;
  end;

  PD3D11_SAMPLER_DESC = ^TD3D11_SAMPLER_DESC;

  ID3D11SamplerState = interface(ID3D11DeviceChild)
    ['{da6fea51-564c-4487-9810-f0d0f9b4e3a5}']
    procedure GetDesc(out pDesc: TD3D11_SAMPLER_DESC); stdcall;
  end;

  PID3D11SamplerState   = ^ID3D11SamplerState;
  TD3D11_FORMAT_SUPPORT = (D3D11_FORMAT_SUPPORT_BUFFER = $1, D3D11_FORMAT_SUPPORT_IA_VERTEX_BUFFER = $2, D3D11_FORMAT_SUPPORT_IA_INDEX_BUFFER = $4, D3D11_FORMAT_SUPPORT_SO_BUFFER = $8, D3D11_FORMAT_SUPPORT_TEXTURE1D = $10, D3D11_FORMAT_SUPPORT_TEXTURE2D = $20, D3D11_FORMAT_SUPPORT_TEXTURE3D = $40, D3D11_FORMAT_SUPPORT_TEXTURECUBE = $80, D3D11_FORMAT_SUPPORT_SHADER_LOAD = $100,
    D3D11_FORMAT_SUPPORT_SHADER_SAMPLE = $200, D3D11_FORMAT_SUPPORT_SHADER_SAMPLE_COMPARISON = $400, D3D11_FORMAT_SUPPORT_SHADER_SAMPLE_MONO_TEXT = $800, D3D11_FORMAT_SUPPORT_MIP = $1000, D3D11_FORMAT_SUPPORT_MIP_AUTOGEN = $2000, D3D11_FORMAT_SUPPORT_RENDER_TARGET = $4000, D3D11_FORMAT_SUPPORT_BLENDABLE = $8000, D3D11_FORMAT_SUPPORT_DEPTH_STENCIL = $10000,
    D3D11_FORMAT_SUPPORT_CPU_LOCKABLE = $20000, D3D11_FORMAT_SUPPORT_MULTISAMPLE_RESOLVE = $40000, D3D11_FORMAT_SUPPORT_DISPLAY = $80000, D3D11_FORMAT_SUPPORT_CAST_WITHIN_BIT_LAYOUT = $100000, D3D11_FORMAT_SUPPORT_MULTISAMPLE_RENDERTARGET = $200000, D3D11_FORMAT_SUPPORT_MULTISAMPLE_LOAD = $400000, D3D11_FORMAT_SUPPORT_SHADER_GATHER = $800000, D3D11_FORMAT_SUPPORT_BACK_BUFFER_CAST = $1000000,
    D3D11_FORMAT_SUPPORT_TYPED_UNORDERED_ACCESS_VIEW = $2000000, D3D11_FORMAT_SUPPORT_SHADER_GATHER_COMPARISON = $4000000, D3D11_FORMAT_SUPPORT_DECODER_OUTPUT = $8000000, D3D11_FORMAT_SUPPORT_VIDEO_PROCESSOR_OUTPUT = $10000000, D3D11_FORMAT_SUPPORT_VIDEO_PROCESSOR_INPUT = $20000000, D3D11_FORMAT_SUPPORT_VIDEO_ENCODER = $40000000);
  TD3D11_FORMAT_SUPPORT2 = (D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_ADD = $1, D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_BITWISE_OPS = $2, D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_COMPARE_STORE_OR_COMPARE_EXCHANGE = $4, D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_EXCHANGE = $8, D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_SIGNED_MIN_OR_MAX = $10, D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_UNSIGNED_MIN_OR_MAX = $20,
    D3D11_FORMAT_SUPPORT2_UAV_TYPED_LOAD = $40, D3D11_FORMAT_SUPPORT2_UAV_TYPED_STORE = $80, D3D11_FORMAT_SUPPORT2_OUTPUT_MERGER_LOGIC_OP = $100, D3D11_FORMAT_SUPPORT2_TILED = $200, D3D11_FORMAT_SUPPORT2_SHAREABLE = $400);

  ID3D11Asynchronous = interface(ID3D11DeviceChild)
    ['{4b35d0cd-1e15-4258-9c98-1b1333f6dd3b}']
    function GetDataSize(): UINT; stdcall;
  end;

  PID3D11Asynchronous       = ^ID3D11Asynchronous;
  TD3D11_ASYNC_GETDATA_FLAG = (D3D11_ASYNC_GETDATA_DONOTFLUSH = $1);
  TD3D11_QUERY              = (D3D11_QUERY_EVENT = 0, D3D11_QUERY_OCCLUSION = (D3D11_QUERY_EVENT + 1), D3D11_QUERY_TIMESTAMP = (D3D11_QUERY_OCCLUSION + 1), D3D11_QUERY_TIMESTAMP_DISJOINT = (D3D11_QUERY_TIMESTAMP + 1), D3D11_QUERY_PIPELINE_STATISTICS = (D3D11_QUERY_TIMESTAMP_DISJOINT + 1), D3D11_QUERY_OCCLUSION_PREDICATE = (D3D11_QUERY_PIPELINE_STATISTICS + 1),
    D3D11_QUERY_SO_STATISTICS = (D3D11_QUERY_OCCLUSION_PREDICATE + 1), D3D11_QUERY_SO_OVERFLOW_PREDICATE = (D3D11_QUERY_SO_STATISTICS + 1), D3D11_QUERY_SO_STATISTICS_STREAM0 = (D3D11_QUERY_SO_OVERFLOW_PREDICATE + 1), D3D11_QUERY_SO_OVERFLOW_PREDICATE_STREAM0 = (D3D11_QUERY_SO_STATISTICS_STREAM0 + 1), D3D11_QUERY_SO_STATISTICS_STREAM1 = (D3D11_QUERY_SO_OVERFLOW_PREDICATE_STREAM0 + 1),
    D3D11_QUERY_SO_OVERFLOW_PREDICATE_STREAM1 = (D3D11_QUERY_SO_STATISTICS_STREAM1 + 1), D3D11_QUERY_SO_STATISTICS_STREAM2 = (D3D11_QUERY_SO_OVERFLOW_PREDICATE_STREAM1 + 1), D3D11_QUERY_SO_OVERFLOW_PREDICATE_STREAM2 = (D3D11_QUERY_SO_STATISTICS_STREAM2 + 1), D3D11_QUERY_SO_STATISTICS_STREAM3 = (D3D11_QUERY_SO_OVERFLOW_PREDICATE_STREAM2 + 1),
    D3D11_QUERY_SO_OVERFLOW_PREDICATE_STREAM3 = (D3D11_QUERY_SO_STATISTICS_STREAM3 + 1));
  TD3D11_QUERY_MISC_FLAG = (D3D11_QUERY_MISC_PREDICATEHINT = $1);

  { TD3D11_QUERY_DESC }
  TD3D11_QUERY_DESC = record
    Query: TD3D11_QUERY;
    MiscFlags: UINT;
    procedure Init(AQuery: TD3D11_QUERY; AMiscFlags: UINT = 0);
  end;

  PD3D11_QUERY_DESC = ^TD3D11_QUERY_DESC;

  ID3D11Query = interface(ID3D11Asynchronous)
    ['{d6c00747-87b7-425e-b84d-44d108560afd}']
    procedure GetDesc(out pDesc: TD3D11_QUERY_DESC); stdcall;
  end;

  PID3D11Query = ^ID3D11Query;

  ID3D11Predicate = interface(ID3D11Query)
    ['{9eb576dd-9f77-4d86-81aa-8bab5fe490e2}']
  end;

  PID3D11Predicate = ^ID3D11Predicate;

  TD3D11_QUERY_DATA_TIMESTAMP_DISJOINT = record
    Frequency: UINT64;
    Disjoint: LongBool;
  end;

  TD3D11_QUERY_DATA_PIPELINE_STATISTICS = record
    IAVertices: UINT64;
    IAPrimitives: UINT64;
    VSInvocations: UINT64;
    GSInvocations: UINT64;
    GSPrimitives: UINT64;
    CInvocations: UINT64;
    CPrimitives: UINT64;
    PSInvocations: UINT64;
    HSInvocations: UINT64;
    DSInvocations: UINT64;
    CSInvocations: UINT64;
  end;

  TD3D11_QUERY_DATA_SO_STATISTICS = record
    NumPrimitivesWritten: UINT64;
    PrimitivesStorageNeeded: UINT64;
  end;

  TD3D11_COUNTER      = (D3D11_COUNTER_DEVICE_DEPENDENT_0 = $40000000);
  TD3D11_COUNTER_TYPE = (D3D11_COUNTER_TYPE_FLOAT32 = 0, D3D11_COUNTER_TYPE_UINT16 = (D3D11_COUNTER_TYPE_FLOAT32 + 1), D3D11_COUNTER_TYPE_UINT32 = (D3D11_COUNTER_TYPE_UINT16 + 1), D3D11_COUNTER_TYPE_UINT64 = (D3D11_COUNTER_TYPE_UINT32 + 1));

  { TD3D11_COUNTER_DESC }
  TD3D11_COUNTER_DESC = record
    Counter: TD3D11_COUNTER;
    MiscFlags: UINT;
    procedure Init(ACounter: TD3D11_COUNTER; AMiscFlags: UINT = 0);
  end;

  PD3D11_COUNTER_DESC = ^TD3D11_COUNTER_DESC;

  TD3D11_COUNTER_INFO = record
    LastDeviceDependentCounter: TD3D11_COUNTER;
    NumSimultaneousCounters: UINT;
    NumDetectableParallelUnits: UINT8;
  end;

  PD3D11_COUNTER_INFO = ^TD3D11_COUNTER_INFO;

  ID3D11Counter = interface(ID3D11Asynchronous)
    ['{6e8c49fb-a371-4770-b440-29086022b741}']
    procedure GetDesc(out pDesc: TD3D11_COUNTER_DESC); stdcall;
  end;

  PID3D11Counter                             = ^ID3D11Counter;
  TD3D11_STANDARD_MULTISAMPLE_QUALITY_LEVELS = (D3D11_STANDARD_MULTISAMPLE_PATTERN = $FFFFFFFF, D3D11_CENTER_MULTISAMPLE_PATTERN = $FFFFFFFE);
  TD3D11_DEVICE_CONTEXT_TYPE                 = (D3D11_DEVICE_CONTEXT_IMMEDIATE = 0, D3D11_DEVICE_CONTEXT_DEFERRED = (D3D11_DEVICE_CONTEXT_IMMEDIATE + 1));

  TD3D11_CLASS_INSTANCE_DESC = record
    InstanceId: UINT;
    InstanceIndex: UINT;
    TypeId: UINT;
    ConstantBuffer: UINT;
    BaseConstantBufferOffset: UINT;
    BaseTexture: UINT;
    BaseSampler: UINT;
    Created: LongBool;
  end;

  ID3D11ClassLinkage = interface;

  ID3D11ClassInstance = interface(ID3D11DeviceChild)
    ['{a6cd7faa-b0b7-4a2f-9436-8662a65797cb}']
    procedure GetClassLinkage(out ppLinkage: ID3D11ClassLinkage); stdcall;
    procedure GetDesc(out pDesc: TD3D11_CLASS_INSTANCE_DESC); stdcall;
    procedure GetInstanceName(out pInstanceName: PAnsiChar; var pBufferLength: SIZE_T); stdcall;
    procedure GetTypeName(out pTypeName: PAnsiChar; var pBufferLength: SIZE_T); stdcall;
  end;

  PID3D11ClassInstance = ^ID3D11ClassInstance;

  ID3D11ClassLinkage = interface(ID3D11DeviceChild)
    ['{ddf57cba-9543-46e4-a12b-f207a0fe7fed}']
    function GetClassInstance(pClassInstanceName: PAnsiChar; InstanceIndex: UINT; out ppInstance: ID3D11ClassInstance): HResult; stdcall;
    function CreateClassInstance(pClassTypeName: PAnsiChar; ConstantBufferOffset: UINT; ConstantVectorOffset: UINT; TextureOffset: UINT; SamplerOffset: UINT; out ppInstance: ID3D11ClassInstance): HResult; stdcall;
  end;

  PID3D11ClassLinkage = ^ID3D11ClassLinkage;

  ID3D11CommandList = interface(ID3D11DeviceChild)
    ['{a24bc4d1-769e-43f7-8013-98ff566c18e2}']
    function GetContextFlags(): UINT; stdcall;
  end;

  PID3D11CommandList = ^ID3D11CommandList;
  TD3D11_FEATURE     = (D3D11_FEATURE_THREADING = 0, D3D11_FEATURE_DOUBLES = (D3D11_FEATURE_THREADING + 1), D3D11_FEATURE_FORMAT_SUPPORT = (D3D11_FEATURE_DOUBLES + 1), D3D11_FEATURE_FORMAT_SUPPORT2 = (D3D11_FEATURE_FORMAT_SUPPORT + 1), D3D11_FEATURE_D3D10_X_HARDWARE_OPTIONS = (D3D11_FEATURE_FORMAT_SUPPORT2 + 1), D3D11_FEATURE_D3D11_OPTIONS = (D3D11_FEATURE_D3D10_X_HARDWARE_OPTIONS + 1),
    D3D11_FEATURE_ARCHITECTURE_INFO = (D3D11_FEATURE_D3D11_OPTIONS + 1), D3D11_FEATURE_D3D9_OPTIONS = (D3D11_FEATURE_ARCHITECTURE_INFO + 1), D3D11_FEATURE_SHADER_MIN_PRECISION_SUPPORT = (D3D11_FEATURE_D3D9_OPTIONS + 1), D3D11_FEATURE_D3D9_SHADOW_SUPPORT = (D3D11_FEATURE_SHADER_MIN_PRECISION_SUPPORT + 1), D3D11_FEATURE_D3D11_OPTIONS1 = (D3D11_FEATURE_D3D9_SHADOW_SUPPORT + 1),
    D3D11_FEATURE_D3D9_SIMPLE_INSTANCING_SUPPORT = (D3D11_FEATURE_D3D11_OPTIONS1 + 1), D3D11_FEATURE_MARKER_SUPPORT = (D3D11_FEATURE_D3D9_SIMPLE_INSTANCING_SUPPORT + 1), D3D11_FEATURE_D3D9_OPTIONS1 = (D3D11_FEATURE_MARKER_SUPPORT + 1), D3D11_FEATURE_D3D11_OPTIONS2 = (D3D11_FEATURE_D3D9_OPTIONS1 + 1), D3D11_FEATURE_D3D11_OPTIONS3 = (D3D11_FEATURE_D3D11_OPTIONS2 + 1),
    D3D11_FEATURE_GPU_VIRTUAL_ADDRESS_SUPPORT = (D3D11_FEATURE_D3D11_OPTIONS3 + 1), D3D11_FEATURE_D3D11_OPTIONS4 = (D3D11_FEATURE_GPU_VIRTUAL_ADDRESS_SUPPORT + 1), D3D11_FEATURE_SHADER_CACHE = (D3D11_FEATURE_D3D11_OPTIONS4 + 1));

  TD3D11_FEATURE_DATA_THREADING = record
    DriverConcurrentCreates: LongBool;
    DriverCommandLists: LongBool;
  end;

  TD3D11_FEATURE_DATA_DOUBLES = record
    DoublePrecisionFloatShaderOps: LongBool;
  end;

  TD3D11_FEATURE_DATA_FORMAT_SUPPORT = record
    InFormat: TDXGI_FORMAT;
    OutFormatSupport: UINT;
  end;

  TD3D11_FEATURE_DATA_FORMAT_SUPPORT2 = record
    InFormat: TDXGI_FORMAT;
    OutFormatSupport2: UINT;
  end;

  TD3D11_FEATURE_DATA_D3D10_X_HARDWARE_OPTIONS = record
    ComputeShaders_Plus_RawAndStructuredBuffers_Via_Shader_4_x: LongBool;
  end;

  TD3D11_FEATURE_DATA_D3D11_OPTIONS = record
    OutputMergerLogicOp: LongBool;
    UAVOnlyRenderingForcedSampleCount: LongBool;
    DiscardAPIsSeenByDriver: LongBool;
    FlagsForUpdateAndCopySeenByDriver: LongBool;
    ClearView: LongBool;
    CopyWithOverlap: LongBool;
    ConstantBufferPartialUpdate: LongBool;
    ConstantBufferOffsetting: LongBool;
    MapNoOverwriteOnDynamicConstantBuffer: LongBool;
    MapNoOverwriteOnDynamicBufferSRV: LongBool;
    MultisampleRTVWithForcedSampleCountOne: LongBool;
    SAD4ShaderInstructions: LongBool;
    ExtendedDoublesShaderInstructions: LongBool;
    ExtendedResourceSharing: LongBool;
  end;

  TD3D11_FEATURE_DATA_ARCHITECTURE_INFO = record
    TileBasedDeferredRenderer: LongBool;
  end;

  TD3D11_FEATURE_DATA_D3D9_OPTIONS = record
    FullNonPow2TextureSupport: LongBool;
  end;

  TD3D11_FEATURE_DATA_D3D9_SHADOW_SUPPORT = record
    SupportsDepthAsTextureWithLessEqualComparisonFilter: LongBool;
  end;

  TD3D11_SHADER_MIN_PRECISION_SUPPORT = (D3D11_SHADER_MIN_PRECISION_10_BIT = $1, D3D11_SHADER_MIN_PRECISION_16_BIT = $2);

  TD3D11_FEATURE_DATA_SHADER_MIN_PRECISION_SUPPORT = record
    PixelShaderMinPrecision: UINT;
    AllOtherShaderStagesMinPrecision: UINT;
  end;

  TD3D11_TILED_RESOURCES_TIER = (D3D11_TILED_RESOURCES_NOT_SUPPORTED = 0, D3D11_TILED_RESOURCES_TIER_1 = 1, D3D11_TILED_RESOURCES_TIER_2 = 2);

  TD3D11_FEATURE_DATA_D3D11_OPTIONS1 = record
    TiledResourcesTier: TD3D11_TILED_RESOURCES_TIER;
    MinMaxFiltering: LongBool;
    ClearViewAlsoSupportsDepthOnlyFormats: LongBool;
    MapOnDefaultBuffers: LongBool;
  end;

  TD3D11_FEATURE_DATA_D3D9_SIMPLE_INSTANCING_SUPPORT = record
    SimpleInstancingSupported: LongBool;
  end;

  TD3D11_FEATURE_DATA_MARKER_SUPPORT = record
    Profile: LongBool;
  end;

  TD3D11_FEATURE_DATA_D3D9_OPTIONS1 = record
    FullNonPow2TextureSupported: LongBool;
    DepthAsTextureWithLessEqualComparisonFilterSupported: LongBool;
    SimpleInstancingSupported: LongBool;
    TextureCubeFaceRenderTargetWithNonCubeDepthStencilSupported: LongBool;
  end;

  TD3D11_CONSERVATIVE_RASTERIZATION_TIER = (D3D11_CONSERVATIVE_RASTERIZATION_NOT_SUPPORTED = 0, D3D11_CONSERVATIVE_RASTERIZATION_TIER_1 = 1, D3D11_CONSERVATIVE_RASTERIZATION_TIER_2 = 2, D3D11_CONSERVATIVE_RASTERIZATION_TIER_3 = 3);
  PD3D11_CONSERVATIVE_RASTERIZATION_TIER = ^TD3D11_CONSERVATIVE_RASTERIZATION_TIER;

  TD3D11_FEATURE_DATA_D3D11_OPTIONS2 = record
    PSSpecifiedStencilRefSupported: boolean;
    TypedUAVLoadAdditionalFormats: boolean;
    ROVsSupported: boolean;
    ConservativeRasterizationTier: TD3D11_CONSERVATIVE_RASTERIZATION_TIER;
    TiledResourcesTier: TD3D11_TILED_RESOURCES_TIER;
    MapOnDefaultTextures: boolean;
    StandardSwizzle: boolean;
    UnifiedMemoryArchitecture: boolean;
  end;

  PD3D11_FEATURE_DATA_D3D11_OPTIONS2 = ^TD3D11_FEATURE_DATA_D3D11_OPTIONS2;

  TD3D11_FEATURE_DATA_D3D11_OPTIONS3 = record
    VPAndRTArrayIndexFromAnyShaderFeedingRasterizer: boolean;
  end;

  PD3D11_FEATURE_DATA_D3D11_OPTIONS3 = ^TD3D11_FEATURE_DATA_D3D11_OPTIONS3;

  TD3D11_FEATURE_DATA_GPU_VIRTUAL_ADDRESS_SUPPORT = record
    MaxGPUVirtualAddressBitsPerResource: UINT;
    MaxGPUVirtualAddressBitsPerProcess: UINT;
  end;

  PD3D11_FEATURE_DATA_GPU_VIRTUAL_ADDRESS_SUPPORT = ^TD3D11_FEATURE_DATA_GPU_VIRTUAL_ADDRESS_SUPPORT;
  TD3D11_SHADER_CACHE_SUPPORT_FLAGS               = (D3D11_SHADER_CACHE_SUPPORT_NONE = 0, D3D11_SHADER_CACHE_SUPPORT_AUTOMATIC_INPROC_CACHE = $1, D3D11_SHADER_CACHE_SUPPORT_AUTOMATIC_DISK_CACHE = $2);

  TD3D11_FEATURE_DATA_SHADER_CACHE = record
    SupportFlags: UINT;
  end;

  PD3D11_FEATURE_DATA_SHADER_CACHE = ^TD3D11_FEATURE_DATA_SHADER_CACHE;

  ID3D11DeviceContext = interface(ID3D11DeviceChild)
    ['{c0bfa96c-e089-44fb-8eaf-26f8796190da}']
    procedure VSSetConstantBuffers(StartSlot: UINT; NumBuffers: UINT; ppConstantBuffers: PID3D11Buffer); stdcall;
    procedure PSSetShaderResources(StartSlot: UINT; NumViews: UINT; ppShaderResourceViews: PID3D11ShaderResourceView); stdcall;
    procedure PSSetShader(pPixelShader: ID3D11PixelShader; ppClassInstances: PID3D11ClassInstance; NumClassInstances: UINT); stdcall;
    procedure PSSetSamplers(StartSlot: UINT; NumSamplers: UINT; ppSamplers: PID3D11SamplerState); stdcall;
    procedure VSSetShader(pVertexShader: ID3D11VertexShader; ppClassInstances: PID3D11ClassInstance; NumClassInstances: UINT); stdcall;
    procedure DrawIndexed(IndexCount: UINT; StartIndexLocation: UINT; BaseVertexLocation: Integer); stdcall;
    procedure Draw(VertexCount: UINT; StartVertexLocation: UINT); stdcall;
    function Map(pResource: ID3D11Resource; Subresource: UINT; MapType: TD3D11_MAP; MapFlags: UINT; out pMappedResource: TD3D11_MAPPED_SUBRESOURCE): HResult; stdcall;
    procedure Unmap(pResource: ID3D11Resource; Subresource: UINT); stdcall;
    procedure PSSetConstantBuffers(StartSlot: UINT; NumBuffers: UINT; ppConstantBuffers: PID3D11Buffer); stdcall;
    procedure IASetInputLayout(pInputLayout: ID3D11InputLayout); stdcall;
    procedure IASetVertexBuffers(StartSlot: UINT; NumBuffers: UINT; ppVertexBuffers: PID3D11Buffer; pStrides: PUINT; pOffsets: PUINT); stdcall;
    procedure IASetIndexBuffer(pIndexBuffer: ID3D11Buffer; Format: TDXGI_FORMAT; Offset: UINT); stdcall;
    procedure DrawIndexedInstanced(IndexCountPerInstance: UINT; InstanceCount: UINT; StartIndexLocation: UINT; BaseVertexLocation: Integer; StartInstanceLocation: UINT); stdcall;
    procedure DrawInstanced(VertexCountPerInstance: UINT; InstanceCount: UINT; StartVertexLocation: UINT; StartInstanceLocation: UINT); stdcall;
    procedure GSSetConstantBuffers(StartSlot: UINT; NumBuffers: UINT; ppConstantBuffers: PID3D11Buffer); stdcall;
    procedure GSSetShader(pShader: ID3D11GeometryShader; ppClassInstances: PID3D11ClassInstance; NumClassInstances: UINT); stdcall;
    procedure IASetPrimitiveTopology(Topology: TD3D11_PRIMITIVE_TOPOLOGY); stdcall;
    procedure VSSetShaderResources(StartSlot: UINT; NumViews: UINT; ppShaderResourceViews: PID3D11ShaderResourceView); stdcall;
    procedure VSSetSamplers(StartSlot: UINT; NumSamplers: UINT; ppSamplers: PID3D11SamplerState); stdcall;
    procedure _Begin(pAsync: ID3D11Asynchronous); stdcall;
    procedure _End(pAsync: ID3D11Asynchronous); stdcall;
    function GetData(pAsync: ID3D11Asynchronous; out pData: Pointer; DataSize: UINT; GetDataFlags: UINT): HResult; stdcall;
    procedure SetPredication(pPredicate: ID3D11Predicate; PredicateValue: LongBool); stdcall;
    procedure GSSetShaderResources(StartSlot: UINT; NumViews: UINT; ppShaderResourceViews: PID3D11ShaderResourceView); stdcall;
    procedure GSSetSamplers(StartSlot: UINT; NumSamplers: UINT; ppSamplers: PID3D11SamplerState); stdcall;
    procedure OMSetRenderTargets(NumViews: UINT; ppRenderTargetViews: PID3D11RenderTargetView; pDepthStencilView: ID3D11DepthStencilView); stdcall;
    procedure OMSetRenderTargetsAndUnorderedAccessViews(NumRTVs: UINT; ppRenderTargetViews: PID3D11RenderTargetView; pDepthStencilView: ID3D11DepthStencilView; UAVStartSlot: UINT; NumUAVs: UINT; ppUnorderedAccessViews: PID3D11UnorderedAccessView; pUAVInitialCounts: PUINT); stdcall;
    procedure OMSetBlendState(pBlendState: ID3D11BlendState; BlendFactor: TFloatArray4; SampleMask: UINT); stdcall;
    procedure OMSetDepthStencilState(pDepthStencilState: ID3D11DepthStencilState; StencilRef: UINT); stdcall;
    procedure SOSetTargets(NumBuffers: UINT; ppSOTargets: PID3D11Buffer; pOffsets: PUINT); stdcall;
    procedure DrawAuto(); stdcall;
    procedure DrawIndexedInstancedIndirect(pBufferForArgs: ID3D11Buffer; AlignedByteOffsetForArgs: UINT); stdcall;
    procedure DrawInstancedIndirect(pBufferForArgs: ID3D11Buffer; AlignedByteOffsetForArgs: UINT); stdcall;
    procedure Dispatch(ThreadGroupCountX: UINT; ThreadGroupCountY: UINT; ThreadGroupCountZ: UINT); stdcall;
    procedure DispatchIndirect(pBufferForArgs: ID3D11Buffer; AlignedByteOffsetForArgs: UINT); stdcall;
    procedure RSSetState(pRasterizerState: ID3D11RasterizerState); stdcall;
    procedure RSSetViewports(NumViewports: UINT; pViewports: PD3D11_VIEWPORT); stdcall;
    procedure RSSetScissorRects(NumRects: UINT; pRects: PD3D11_RECT); stdcall;
    procedure CopySubresourceRegion(pDstResource: ID3D11Resource; DstSubresource: UINT; DstX: UINT; DstY: UINT; DstZ: UINT; pSrcResource: ID3D11Resource; SrcSubresource: UINT; pSrcBox: PD3D11_BOX); stdcall;
    procedure CopyResource(pDstResource: ID3D11Resource; pSrcResource: ID3D11Resource); stdcall;
    procedure UpdateSubresource(pDstResource: ID3D11Resource; DstSubresource: UINT; pDstBox: PD3D11_BOX; pSrcData: Pointer; SrcRowPitch: UINT; SrcDepthPitch: UINT); stdcall;
    procedure CopyStructureCount(pDstBuffer: ID3D11Buffer; DstAlignedByteOffset: UINT; pSrcView: ID3D11UnorderedAccessView); stdcall;
    procedure ClearRenderTargetView(pRenderTargetView: ID3D11RenderTargetView; ColorRGBA: TFloatArray4); stdcall;
    procedure ClearUnorderedAccessViewUINT(pUnorderedAccessView: ID3D11UnorderedAccessView; Values: TUINTArray4); stdcall;
    procedure ClearUnorderedAccessViewFloat(pUnorderedAccessView: ID3D11UnorderedAccessView; Values: TFloatArray4); stdcall;
    procedure ClearDepthStencilView(pDepthStencilView: ID3D11DepthStencilView; ClearFlags: UINT; Depth: Single; Stencil: UINT8); stdcall;
    procedure GenerateMips(pShaderResourceView: ID3D11ShaderResourceView); stdcall;
    procedure SetResourceMinLOD(pResource: ID3D11Resource; MinLOD: Single); stdcall;
    function GetResourceMinLOD(pResource: ID3D11Resource): Single; stdcall;
    procedure ResolveSubresource(pDstResource: ID3D11Resource; DstSubresource: UINT; pSrcResource: ID3D11Resource; SrcSubresource: UINT; Format: TDXGI_FORMAT); stdcall;
    procedure ExecuteCommandList(pCommandList: ID3D11CommandList; RestoreContextState: LongBool); stdcall;
    procedure HSSetShaderResources(StartSlot: UINT; NumViews: UINT; ppShaderResourceViews: PID3D11ShaderResourceView); stdcall;
    procedure HSSetShader(pHullShader: ID3D11HullShader; ppClassInstances: PID3D11ClassInstance; NumClassInstances: UINT); stdcall;
    procedure HSSetSamplers(StartSlot: UINT; NumSamplers: UINT; ppSamplers: PID3D11SamplerState); stdcall;
    procedure HSSetConstantBuffers(StartSlot: UINT; NumBuffers: UINT; ppConstantBuffers: PID3D11Buffer); stdcall;
    procedure DSSetShaderResources(StartSlot: UINT; NumViews: UINT; ppShaderResourceViews: PID3D11ShaderResourceView); stdcall;
    procedure DSSetShader(pDomainShader: ID3D11DomainShader; ppClassInstances: PID3D11ClassInstance; NumClassInstances: UINT); stdcall;
    procedure DSSetSamplers(StartSlot: UINT; NumSamplers: UINT; ppSamplers: ID3D11SamplerState); stdcall;
    procedure DSSetConstantBuffers(StartSlot: UINT; NumBuffers: UINT; ppConstantBuffers: PID3D11Buffer); stdcall;
    procedure CSSetShaderResources(StartSlot: UINT; NumViews: UINT; ppShaderResourceViews: ID3D11ShaderResourceView); stdcall;
    procedure CSSetUnorderedAccessViews(StartSlot: UINT; NumUAVs: UINT; ppUnorderedAccessViews: PID3D11UnorderedAccessView; pUAVInitialCounts: PUINT); stdcall;
    procedure CSSetShader(pComputeShader: ID3D11ComputeShader; ppClassInstances: PID3D11ClassInstance; NumClassInstances: UINT); stdcall;
    procedure CSSetSamplers(StartSlot: UINT; NumSamplers: UINT; ppSamplers: PID3D11SamplerState); stdcall;
    procedure CSSetConstantBuffers(StartSlot: UINT; NumBuffers: UINT; ppConstantBuffers: PID3D11Buffer); stdcall;
    procedure VSGetConstantBuffers(StartSlot: UINT; NumBuffers: UINT; out ppConstantBuffers: PID3D11Buffer); stdcall;
    procedure PSGetShaderResources(StartSlot: UINT; NumViews: UINT; out ppShaderResourceViews: PID3D11ShaderResourceView); stdcall;
    procedure PSGetShader(out ppPixelShader: ID3D11PixelShader; out ppClassInstances: PID3D11ClassInstance; var pNumClassInstances: UINT); stdcall;
    procedure PSGetSamplers(StartSlot: UINT; NumSamplers: UINT; out ppSamplers: PID3D11SamplerState); stdcall;
    procedure VSGetShader(out ppVertexShader: ID3D11VertexShader; out ppClassInstances: PID3D11ClassInstance; var pNumClassInstances: UINT); stdcall;
    procedure PSGetConstantBuffers(StartSlot: UINT; NumBuffers: UINT; out ppConstantBuffers: PID3D11Buffer); stdcall;
    procedure IAGetInputLayout(out ppInputLayout: ID3D11InputLayout); stdcall;
    procedure IAGetVertexBuffers(StartSlot: UINT; NumBuffers: UINT; out ppVertexBuffers: PID3D11Buffer; out pStrides: PUINT; out pOffsets: PUINT); stdcall;
    procedure IAGetIndexBuffer(out pIndexBuffer: ID3D11Buffer; out Format: TDXGI_FORMAT; out Offset: UINT); stdcall;
    procedure GSGetConstantBuffers(StartSlot: UINT; NumBuffers: UINT; out ppConstantBuffers: PID3D11Buffer); stdcall;
    procedure GSGetShader(out ppGeometryShader: ID3D11GeometryShader; out ppClassInstances: PID3D11ClassInstance; var pNumClassInstances: UINT); stdcall;
    procedure IAGetPrimitiveTopology(out pTopology: TD3D11_PRIMITIVE_TOPOLOGY); stdcall;
    procedure VSGetShaderResources(StartSlot: UINT; NumViews: UINT; out ppShaderResourceViews: PID3D11ShaderResourceView); stdcall;
    procedure VSGetSamplers(StartSlot: UINT; NumSamplers: UINT; out ppSamplers: PID3D11SamplerState); stdcall;
    procedure GetPredication(out ppPredicate: ID3D11Predicate; out pPredicateValue: LongBool); stdcall;
    procedure GSGetShaderResources(StartSlot: UINT; NumViews: UINT; out ppShaderResourceViews: PID3D11ShaderResourceView); stdcall;
    procedure GSGetSamplers(StartSlot: UINT; NumSamplers: UINT; out ppSamplers: PID3D11SamplerState); stdcall;
    procedure OMGetRenderTargets(NumViews: UINT; out ppRenderTargetViews: PID3D11RenderTargetView; out ppDepthStencilView: ID3D11DepthStencilView); stdcall;
    procedure OMGetRenderTargetsAndUnorderedAccessViews(NumRTVs: UINT; out ppRenderTargetViews: PID3D11RenderTargetView; out ppDepthStencilView: ID3D11DepthStencilView; UAVStartSlot: UINT; NumUAVs: UINT; out ppUnorderedAccessViews: PID3D11UnorderedAccessView); stdcall;
    procedure OMGetBlendState(out ppBlendState: ID3D11BlendState; out BlendFactor: TFloatArray4; out pSampleMask: UINT); stdcall;
    procedure OMGetDepthStencilState(out ppDepthStencilState: ID3D11DepthStencilState; out pStencilRef: UINT); stdcall;
    procedure SOGetTargets(NumBuffers: UINT; out ppSOTargets: PID3D11Buffer); stdcall;
    procedure RSGetState(out ppRasterizerState: ID3D11RasterizerState); stdcall;
    procedure RSGetViewports(var pNumViewports: UINT; out pViewports: PD3D11_VIEWPORT); stdcall;
    procedure RSGetScissorRects(var pNumRects: UINT; out pRects: PD3D11_RECT); stdcall;
    procedure HSGetShaderResources(StartSlot: UINT; NumViews: UINT; out ppShaderResourceViews: PID3D11ShaderResourceView); stdcall;
    procedure HSGetShader(out ppHullShader: ID3D11HullShader; out ppClassInstances: PID3D11ClassInstance; var pNumClassInstances: UINT); stdcall;
    procedure HSGetSamplers(StartSlot: UINT; NumSamplers: UINT; out ppSamplers: PID3D11SamplerState); stdcall;
    procedure HSGetConstantBuffers(StartSlot: UINT; NumBuffers: UINT; out ppConstantBuffers: PID3D11Buffer); stdcall;
    procedure DSGetShaderResources(StartSlot: UINT; NumViews: UINT; out ppShaderResourceViews: PID3D11ShaderResourceView); stdcall;
    procedure DSGetShader(out ppDomainShader: ID3D11DomainShader; out ppClassInstances: PID3D11ClassInstance; var pNumClassInstances: UINT); stdcall;
    procedure DSGetSamplers(StartSlot: UINT; NumSamplers: UINT; out ppSamplers: PID3D11SamplerState); stdcall;
    procedure DSGetConstantBuffers(StartSlot: UINT; NumBuffers: UINT; out ppConstantBuffers: PID3D11Buffer); stdcall;
    procedure CSGetShaderResources(StartSlot: UINT; NumViews: UINT; out ppShaderResourceViews: PID3D11ShaderResourceView); stdcall;
    procedure CSGetUnorderedAccessViews(StartSlot: UINT; NumUAVs: UINT; out ppUnorderedAccessViews: PID3D11UnorderedAccessView); stdcall;
    procedure CSGetShader(out ppComputeShader: ID3D11ComputeShader; out ppClassInstances: PID3D11ClassInstance; var pNumClassInstances: UINT); stdcall;
    procedure CSGetSamplers(StartSlot: UINT; NumSamplers: UINT; out ppSamplers: PID3D11SamplerState); stdcall;
    procedure CSGetConstantBuffers(StartSlot: UINT; NumBuffers: UINT; out ppConstantBuffers: PID3D11Buffer); stdcall;
    procedure ClearState(); stdcall;
    procedure Flush(); stdcall;
    function GetType(): TD3D11_DEVICE_CONTEXT_TYPE; stdcall;
    function GetContextFlags(): UINT; stdcall;
    function FinishCommandList(RestoreDeferredContextState: LongBool; out ppCommandList: ID3D11CommandList): HResult; stdcall;
  end;

  TD3D11_VIDEO_DECODER_DESC = record
    guid: TGUID;
    SampleWidth: UINT;
    SampleHeight: UINT;
    OutputFormat: TDXGI_FORMAT;
  end;

  PD3D11_VIDEO_DECODER_DESC = ^TD3D11_VIDEO_DECODER_DESC;

  TD3D11_VIDEO_DECODER_CONFIG = record
    guidConfigBitstreamEncryption: TGUID;
    guidConfigMBcontrolEncryption: TGUID;
    guidConfigResidDiffEncryption: TGUID;
    ConfigBitstreamRaw: UINT;
    ConfigMBcontrolRasterOrder: UINT;
    ConfigResidDiffHost: UINT;
    ConfigSpatialResid8: UINT;
    ConfigResid8Subtraction: UINT;
    ConfigSpatialHost8or9Clipping: UINT;
    ConfigSpatialResidInterleaved: UINT;
    ConfigIntraResidUnsigned: UINT;
    ConfigResidDiffAccelerator: UINT;
    ConfigHostInverseScan: UINT;
    ConfigSpecificIDCT: UINT;
    Config4GroupedCoefs: UINT;
    ConfigMinRenderTargetBuffCount: USHORT;
    ConfigDecoderSpecific: USHORT;
  end;

  PD3D11_VIDEO_DECODER_CONFIG      = ^TD3D11_VIDEO_DECODER_CONFIG;
  TD3D11_VIDEO_DECODER_BUFFER_TYPE = (                          //
    D3D11_VIDEO_DECODER_BUFFER_PICTURE_PARAMETERS = 0,          //
    D3D11_VIDEO_DECODER_BUFFER_MACROBLOCK_CONTROL = 1,          //
    D3D11_VIDEO_DECODER_BUFFER_RESIDUAL_DIFFERENCE = 2,         //
    D3D11_VIDEO_DECODER_BUFFER_DEBLOCKING_CONTROL = 3,          //
    D3D11_VIDEO_DECODER_BUFFER_INVERSE_QUANTIZATION_MATRIX = 4, //
    D3D11_VIDEO_DECODER_BUFFER_SLICE_CONTROL = 5,               //
    D3D11_VIDEO_DECODER_BUFFER_BITSTREAM = 6,                   //
    D3D11_VIDEO_DECODER_BUFFER_MOTION_VECTOR = 7,               //
    D3D11_VIDEO_DECODER_BUFFER_FILM_GRAIN = 8);

  TD3D11_AES_CTR_IV = record
    IV: UINT64;
    Count: UINT64;
  end;

  TD3D11_ENCRYPTED_BLOCK_INFO = record
    NumEncryptedBytesAtBeginning: UINT;
    NumBytesInSkipPattern: UINT;
    NumBytesInEncryptPattern: UINT;
  end;

  PD3D11_ENCRYPTED_BLOCK_INFO = ^TD3D11_ENCRYPTED_BLOCK_INFO;

  TD3D11_VIDEO_DECODER_BUFFER_DESC = record
    BufferType: TD3D11_VIDEO_DECODER_BUFFER_TYPE;
    BufferIndex: UINT;
    DataOffset: UINT;
    DataSize: UINT;
    FirstMBaddress: UINT;
    NumMBsInBuffer: UINT;
    Width: UINT;
    Height: UINT;
    Stride: UINT;
    ReservedBits: UINT;
    pIV: Pointer;
    IVSize: UINT;
    PartialEncryption: LongBool;
    EncryptedBlockInfo: TD3D11_ENCRYPTED_BLOCK_INFO;
  end;

  PD3D11_VIDEO_DECODER_BUFFER_DESC = ^TD3D11_VIDEO_DECODER_BUFFER_DESC;

  TD3D11_VIDEO_DECODER_EXTENSION = record
    _Function: UINT;
    pPrivateInputData: Pointer;
    PrivateInputDataSize: UINT;
    pPrivateOutputData: Pointer;
    PrivateOutputDataSize: UINT;
    ResourceCount: UINT;
    ppResourceList: PID3D11Resource;
  end;

  PD3D11_VIDEO_DECODER_EXTENSION = ^TD3D11_VIDEO_DECODER_EXTENSION;

  ID3D11VideoDecoder = interface(ID3D11DeviceChild)
    ['{3C9C5B51-995D-48d1-9B8D-FA5CAEDED65C}']
    function GetCreationParameters(out pVideoDesc: TD3D11_VIDEO_DECODER_DESC; out pConfig: TD3D11_VIDEO_DECODER_CONFIG): HResult; stdcall;
    function GetDriverHandle(out pDriverHandle: THANDLE): HResult; stdcall;
  end;

  TD3D11_VIDEO_PROCESSOR_FORMAT_SUPPORT = (          //
    D3D11_VIDEO_PROCESSOR_FORMAT_SUPPORT_INPUT = $1, //
    D3D11_VIDEO_PROCESSOR_FORMAT_SUPPORT_OUTPUT = $2 //
    );

  TD3D11_VIDEO_PROCESSOR_DEVICE_CAPS = (                            //
    D3D11_VIDEO_PROCESSOR_DEVICE_CAPS_LINEAR_SPACE = $1,            //
    D3D11_VIDEO_PROCESSOR_DEVICE_CAPS_xvYCC = $2,                   //
    D3D11_VIDEO_PROCESSOR_DEVICE_CAPS_RGB_RANGE_CONVERSION = $4,    //
    D3D11_VIDEO_PROCESSOR_DEVICE_CAPS_YCbCr_MATRIX_CONVERSION = $8, //
    D3D11_VIDEO_PROCESSOR_DEVICE_CAPS_NOMINAL_RANGE = $10           //
    );

  TD3D11_VIDEO_PROCESSOR_FEATURE_CAPS = (                         //
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_ALPHA_FILL = $1,           //
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_CONSTRICTION = $2,         //
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_LUMA_KEY = $4,             //
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_ALPHA_PALETTE = $8,        //
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_LEGACY = $10,              //
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_STEREO = $20,              //
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_ROTATION = $40,            //
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_ALPHA_STREAM = $80,        //
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_PIXEL_ASPECT_RATIO = $100, //
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_MIRROR = $200,             //
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_SHADER_USAGE = $400,       //
    D3D11_VIDEO_PROCESSOR_FEATURE_CAPS_METADATA_HDR10 = $800      //
    );

  TD3D11_VIDEO_PROCESSOR_FILTER_CAPS = (                        //
    D3D11_VIDEO_PROCESSOR_FILTER_CAPS_BRIGHTNESS = $1,          //
    D3D11_VIDEO_PROCESSOR_FILTER_CAPS_CONTRAST = $2,            //
    D3D11_VIDEO_PROCESSOR_FILTER_CAPS_HUE = $4,                 //
    D3D11_VIDEO_PROCESSOR_FILTER_CAPS_SATURATION = $8,          //
    D3D11_VIDEO_PROCESSOR_FILTER_CAPS_NOISE_REDUCTION = $10,    //
    D3D11_VIDEO_PROCESSOR_FILTER_CAPS_EDGE_ENHANCEMENT = $20,   //
    D3D11_VIDEO_PROCESSOR_FILTER_CAPS_ANAMORPHIC_SCALING = $40, //
    D3D11_VIDEO_PROCESSOR_FILTER_CAPS_STEREO_ADJUSTMENT = $80   //
    );

  TD3D11_VIDEO_PROCESSOR_FORMAT_CAPS = (                      //
    D3D11_VIDEO_PROCESSOR_FORMAT_CAPS_RGB_INTERLACED = $1,    //
    D3D11_VIDEO_PROCESSOR_FORMAT_CAPS_RGB_PROCAMP = $2,       //
    D3D11_VIDEO_PROCESSOR_FORMAT_CAPS_RGB_LUMA_KEY = $4,      //
    D3D11_VIDEO_PROCESSOR_FORMAT_CAPS_PALETTE_INTERLACED = $8 //
    );

  TD3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS = (                         //
    D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_DENOISE = $1,              //
    D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_DERINGING = $2,            //
    D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_EDGE_ENHANCEMENT = $4,     //
    D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_COLOR_CORRECTION = $8,     //
    D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_FLESH_TONE_MAPPING = $10,  //
    D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_IMAGE_STABILIZATION = $20, //
    D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_SUPER_RESOLUTION = $40,    //
    D3D11_VIDEO_PROCESSOR_AUTO_STREAM_CAPS_ANAMORPHIC_SCALING = $80   //
    );

  TD3D11_VIDEO_PROCESSOR_STEREO_CAPS = (                       //
    D3D11_VIDEO_PROCESSOR_STEREO_CAPS_MONO_OFFSET = $1,        //
    D3D11_VIDEO_PROCESSOR_STEREO_CAPS_ROW_INTERLEAVED = $2,    //
    D3D11_VIDEO_PROCESSOR_STEREO_CAPS_COLUMN_INTERLEAVED = $4, //
    D3D11_VIDEO_PROCESSOR_STEREO_CAPS_CHECKERBOARD = $8,       //
    D3D11_VIDEO_PROCESSOR_STEREO_CAPS_FLIP_MODE = $10          //
    );

  TD3D11_VIDEO_PROCESSOR_CAPS = record
    DeviceCaps: UINT;
    FeatureCaps: UINT;
    FilterCaps: UINT;
    InputFormatCaps: UINT;
    AutoStreamCaps: UINT;
    StereoCaps: UINT;
    RateConversionCapsCount: UINT;
    MaxInputStreams: UINT;
    MaxStreamStates: UINT;
  end;

  PD3D11_VIDEO_PROCESSOR_CAPS = ^TD3D11_VIDEO_PROCESSOR_CAPS;

  TD3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS = (                                    //
    D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS_DEINTERLACE_BLEND = $1,               //
    D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS_DEINTERLACE_BOB = $2,                 //
    D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS_DEINTERLACE_ADAPTIVE = $4,            //
    D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS_DEINTERLACE_MOTION_COMPENSATION = $8, //
    D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS_INVERSE_TELECINE = $10,               //
    D3D11_VIDEO_PROCESSOR_PROCESSOR_CAPS_FRAME_RATE_CONVERSION = $20           //
    );

  TD3D11_VIDEO_PROCESSOR_ITELECINE_CAPS = (                   //
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_32 = $1,             //
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_22 = $2,             //
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_2224 = $4,           //
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_2332 = $8,           //
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_32322 = $10,         //
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_55 = $20,            //
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_64 = $40,            //
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_87 = $80,            //
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_222222222223 = $100, //
    D3D11_VIDEO_PROCESSOR_ITELECINE_CAPS_OTHER = $80000000    //
    );

  TD3D11_VIDEO_PROCESSOR_RATE_CONVERSION_CAPS = record
    PastFrames: UINT;
    FutureFrames: UINT;
    ProcessorCaps: UINT;
    ITelecineCaps: UINT;
    CustomRateCount: UINT;
  end;

  PD3D11_VIDEO_PROCESSOR_RATE_CONVERSION_CAPS = ^TD3D11_VIDEO_PROCESSOR_RATE_CONVERSION_CAPS;

  TD3D11_CONTENT_PROTECTION_CAPS = (                             //
    D3D11_CONTENT_PROTECTION_CAPS_SOFTWARE = $1,                 //
    D3D11_CONTENT_PROTECTION_CAPS_HARDWARE = $2,                 //
    D3D11_CONTENT_PROTECTION_CAPS_PROTECTION_ALWAYS_ON = $4,     //
    D3D11_CONTENT_PROTECTION_CAPS_PARTIAL_DECRYPTION = $8,       //
    D3D11_CONTENT_PROTECTION_CAPS_CONTENT_KEY = $10,             //
    D3D11_CONTENT_PROTECTION_CAPS_FRESHEN_SESSION_KEY = $20,     //
    D3D11_CONTENT_PROTECTION_CAPS_ENCRYPTED_READ_BACK = $40,     //
    D3D11_CONTENT_PROTECTION_CAPS_ENCRYPTED_READ_BACK_KEY = $80, //
    D3D11_CONTENT_PROTECTION_CAPS_SEQUENTIAL_CTR_IV = $100,      //
    D3D11_CONTENT_PROTECTION_CAPS_ENCRYPT_SLICEDATA_ONLY = $200, //
    D3D11_CONTENT_PROTECTION_CAPS_DECRYPTION_BLT = $400          //
    );

  TD3D11_VIDEO_CONTENT_PROTECTION_CAPS = record
    Caps: UINT;
    KeyExchangeTypeCount: UINT;
    BlockAlignmentSize: UINT;
    ProtectedMemorySize: ULONGLONG;
  end;

  PD3D11_VIDEO_CONTENT_PROTECTION_CAPS = ^TD3D11_VIDEO_CONTENT_PROTECTION_CAPS;

  TD3D11_VIDEO_PROCESSOR_CUSTOM_RATE = record
    CustomRate: TDXGI_RATIONAL;
    OutputFrames: UINT;
    InputInterlaced: LongBool;
    InputFramesOrFields: UINT;
  end;

  PD3D11_VIDEO_PROCESSOR_CUSTOM_RATE = ^TD3D11_VIDEO_PROCESSOR_CUSTOM_RATE;

  TD3D11_VIDEO_PROCESSOR_FILTER = (                      //
    D3D11_VIDEO_PROCESSOR_FILTER_BRIGHTNESS = 0,         //
    D3D11_VIDEO_PROCESSOR_FILTER_CONTRAST = 1,           //
    D3D11_VIDEO_PROCESSOR_FILTER_HUE = 2,                //
    D3D11_VIDEO_PROCESSOR_FILTER_SATURATION = 3,         //
    D3D11_VIDEO_PROCESSOR_FILTER_NOISE_REDUCTION = 4,    //
    D3D11_VIDEO_PROCESSOR_FILTER_EDGE_ENHANCEMENT = 5,   //
    D3D11_VIDEO_PROCESSOR_FILTER_ANAMORPHIC_SCALING = 6, //
    D3D11_VIDEO_PROCESSOR_FILTER_STEREO_ADJUSTMENT = 7   //
    );

  TD3D11_VIDEO_PROCESSOR_FILTER_RANGE = record
    Minimum: Integer;
    Maximum: Integer;
    _Default: Integer;
    Multiplier: Single;
  end;

  PD3D11_VIDEO_PROCESSOR_FILTER_RANGE = ^TD3D11_VIDEO_PROCESSOR_FILTER_RANGE;

  TD3D11_VIDEO_FRAME_FORMAT = (                                //
    D3D11_VIDEO_FRAME_FORMAT_PROGRESSIVE = 0,                  //
    D3D11_VIDEO_FRAME_FORMAT_INTERLACED_TOP_FIELD_FIRST = 1,   //
    D3D11_VIDEO_FRAME_FORMAT_INTERLACED_BOTTOM_FIELD_FIRST = 2 //
    );

  TD3D11_VIDEO_USAGE = (                   //
    D3D11_VIDEO_USAGE_PLAYBACK_NORMAL = 0, //
    D3D11_VIDEO_USAGE_OPTIMAL_SPEED = 1,   //
    D3D11_VIDEO_USAGE_OPTIMAL_QUALITY = 2  //
    );

  TD3D11_VIDEO_PROCESSOR_CONTENT_DESC = record
    InputFrameFormat: TD3D11_VIDEO_FRAME_FORMAT;
    InputFrameRate: TDXGI_RATIONAL;
    InputWidth: UINT;
    InputHeight: UINT;
    OutputFrameRate: TDXGI_RATIONAL;
    OutputWidth: UINT;
    OutputHeight: UINT;
    Usage: TD3D11_VIDEO_USAGE;
  end;

  PD3D11_VIDEO_PROCESSOR_CONTENT_DESC = ^TD3D11_VIDEO_PROCESSOR_CONTENT_DESC;

  ID3D11VideoProcessorEnumerator = interface(ID3D11DeviceChild)
    ['{31627037-53AB-4200-9061-05FAA9AB45F9}']
    function GetVideoProcessorContentDesc(out pContentDesc: TD3D11_VIDEO_PROCESSOR_CONTENT_DESC): HResult; stdcall;
    function CheckVideoProcessorFormat(Format: TDXGI_FORMAT; out pFlags: UINT): HResult; stdcall;
    function GetVideoProcessorCaps(out pCaps: TD3D11_VIDEO_PROCESSOR_CAPS): HResult; stdcall;
    function GetVideoProcessorRateConversionCaps(TypeIndex: UINT; out pCaps: TD3D11_VIDEO_PROCESSOR_RATE_CONVERSION_CAPS): HResult; stdcall;
    function GetVideoProcessorCustomRate(TypeIndex: UINT; CustomRateIndex: UINT; out pRate: TD3D11_VIDEO_PROCESSOR_CUSTOM_RATE): HResult; stdcall;
    function GetVideoProcessorFilterRange(Filter: TD3D11_VIDEO_PROCESSOR_FILTER; out pRange: TD3D11_VIDEO_PROCESSOR_FILTER_RANGE): HResult; stdcall;
  end;

  TD3D11_VIDEO_COLOR_RGBA = record
    R: Single;
    G: Single;
    b: Single;
    a: Single;
  end;

  PD3D11_VIDEO_COLOR_RGBA = ^TD3D11_VIDEO_COLOR_RGBA;

  TD3D11_VIDEO_COLOR_YCbCrA = record
    Y: Single;
    Cb: Single;
    Cr: Single;
    a: Single;
  end;

  PD3D11_VIDEO_COLOR_YCbCrA = ^TD3D11_VIDEO_COLOR_YCbCrA;

  TD3D11_VIDEO_COLOR = record
    case Integer of
      0:
        (YCbCr: TD3D11_VIDEO_COLOR_YCbCrA;);
      1:
        (RGBA: TD3D11_VIDEO_COLOR_RGBA;);
  end;

  PD3D11_VIDEO_COLOR = ^TD3D11_VIDEO_COLOR;

  TD3D11_VIDEO_PROCESSOR_NOMINAL_RANGE = (             //
    D3D11_VIDEO_PROCESSOR_NOMINAL_RANGE_UNDEFINED = 0, //
    D3D11_VIDEO_PROCESSOR_NOMINAL_RANGE_16_235 = 1,    //
    D3D11_VIDEO_PROCESSOR_NOMINAL_RANGE_0_255 = 2      //
    );

{$IFDEF FPC}

  TD3D11_VIDEO_PROCESSOR_COLOR_SPACE = { bitpacked } record
    Usage: Unsigned_Bits1;
    RGB_Range: Unsigned_Bits1;
    YCbCr_Matrix: Unsigned_Bits1;
    YCbCr_xvYCC: Unsigned_Bits1;
    Nominal_Range: Unsigned_Bits2;
    Reserved: Unsigned_Bits26;
  end;
{$ELSE}

  TD3D11_VIDEO_PROCESSOR_COLOR_SPACE = UINT;
{$ENDIF}
  PD3D11_VIDEO_PROCESSOR_COLOR_SPACE = ^TD3D11_VIDEO_PROCESSOR_COLOR_SPACE;

  TD3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE = (                //
    D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE_OPAQUE = 0,       //
    D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE_BACKGROUND = 1,   //
    D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE_DESTINATION = 2,  //
    D3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE_SOURCE_STREAM = 3 //
    );

  TD3D11_VIDEO_PROCESSOR_OUTPUT_RATE = (          //
    D3D11_VIDEO_PROCESSOR_OUTPUT_RATE_NORMAL = 0, //
    D3D11_VIDEO_PROCESSOR_OUTPUT_RATE_HALF = 1,   //
    D3D11_VIDEO_PROCESSOR_OUTPUT_RATE_CUSTOM = 2  //
    );

  TD3D11_VIDEO_PROCESSOR_STEREO_FORMAT = (                      //
    D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_MONO = 0,               //
    D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_HORIZONTAL = 1,         //
    D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_VERTICAL = 2,           //
    D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_SEPARATE = 3,           //
    D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_MONO_OFFSET = 4,        //
    D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_ROW_INTERLEAVED = 5,    //
    D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_COLUMN_INTERLEAVED = 6, //
    D3D11_VIDEO_PROCESSOR_STEREO_FORMAT_CHECKERBOARD = 7        //
    );

  TD3D11_VIDEO_PROCESSOR_STEREO_FLIP_MODE = (     //
    D3D11_VIDEO_PROCESSOR_STEREO_FLIP_NONE = 0,   //
    D3D11_VIDEO_PROCESSOR_STEREO_FLIP_FRAME0 = 1, //
    D3D11_VIDEO_PROCESSOR_STEREO_FLIP_FRAME1 = 2  //
    );

  TD3D11_VIDEO_PROCESSOR_ROTATION = (            //
    D3D11_VIDEO_PROCESSOR_ROTATION_IDENTITY = 0, //
    D3D11_VIDEO_PROCESSOR_ROTATION_90 = 1,       //
    D3D11_VIDEO_PROCESSOR_ROTATION_180 = 2,      //
    D3D11_VIDEO_PROCESSOR_ROTATION_270 = 3       //
    );

  ID3D11VideoProcessorInputView  = interface;
  PID3D11VideoProcessorInputView = ^ID3D11VideoProcessorInputView;

  TD3D11_VIDEO_PROCESSOR_STREAM = record
    Enable: LongBool;
    OutputIndex: UINT;
    InputFrameOrField: UINT;
    PastFrames: UINT;
    FutureFrames: UINT;
    ppPastSurfaces: PID3D11VideoProcessorInputView;
    pInputSurface: ID3D11VideoProcessorInputView;
    ppFutureSurfaces: PID3D11VideoProcessorInputView;
    ppPastSurfacesRight: PID3D11VideoProcessorInputView;
    pInputSurfaceRight: ID3D11VideoProcessorInputView;
    ppFutureSurfacesRight: PID3D11VideoProcessorInputView;
  end;

  PD3D11_VIDEO_PROCESSOR_STREAM = ^TD3D11_VIDEO_PROCESSOR_STREAM;

  ID3D11VideoProcessor = interface(ID3D11DeviceChild)
    ['{1D7B0652-185F-41c6-85CE-0C5BE3D4AE6C}']
    procedure GetContentDesc(out pDesc: TD3D11_VIDEO_PROCESSOR_CONTENT_DESC); stdcall;
    procedure GetRateConversionCaps(out pCaps: TD3D11_VIDEO_PROCESSOR_RATE_CONVERSION_CAPS); stdcall;
  end;

  TD3D11_OMAC = record
    Omac: array [0 .. 15] of byte;
  end;

  TD3D11_AUTHENTICATED_CHANNEL_TYPE = (D3D11_AUTHENTICATED_CHANNEL_D3D11 = 1, D3D11_AUTHENTICATED_CHANNEL_DRIVER_SOFTWARE = 2, D3D11_AUTHENTICATED_CHANNEL_DRIVER_HARDWARE = 3);

  ID3D11AuthenticatedChannel = interface(ID3D11DeviceChild)
    ['{3015A308-DCBD-47aa-A747-192486D14D4A}']
    function GetCertificateSize(out pCertificateSize: UINT): HResult; stdcall;
    function GetCertificate(CertificateSize: UINT; out pCertificate: PBYTE): HResult; stdcall;
    procedure GetChannelHandle(out pChannelHandle: THANDLE); stdcall;
  end;

  TD3D11_AUTHENTICATED_QUERY_INPUT = record
    QueryType: TGUID;
    hChannel: THANDLE;
    SequenceNumber: UINT;
  end;

  TD3D11_AUTHENTICATED_QUERY_OUTPUT = record
    Omac: TD3D11_OMAC;
    QueryType: TGUID;
    hChannel: THANDLE;
    SequenceNumber: UINT;
    ReturnCode: HResult;
  end;
{$IFDEF FPC}

  TD3D11_AUTHENTICATED_PROTECTION_FLAGS_FLAGS = { bitpacked } record
    ProtectionEnabled: Unsigned_Bits1;
    OverlayOrFullscreenRequired: Unsigned_Bits1;
    Reserved: Unsigned_Bits30;
  end;
{$ELSE}

  TD3D11_AUTHENTICATED_PROTECTION_FLAGS_FLAGS = UINT;
{$ENDIF}

  TD3D11_AUTHENTICATED_PROTECTION_FLAGS = record
    Flags: TD3D11_AUTHENTICATED_PROTECTION_FLAGS_FLAGS;
    Value: UINT;
  end;

  TD3D11_AUTHENTICATED_QUERY_PROTECTION_OUTPUT = record
    Output: TD3D11_AUTHENTICATED_QUERY_OUTPUT;
    ProtectionFlags: TD3D11_AUTHENTICATED_PROTECTION_FLAGS;
  end;

  TD3D11_AUTHENTICATED_QUERY_CHANNEL_TYPE_OUTPUT = record
    Output: TD3D11_AUTHENTICATED_QUERY_OUTPUT;
    ChannelType: TD3D11_AUTHENTICATED_CHANNEL_TYPE;
  end;

  TD3D11_AUTHENTICATED_QUERY_DEVICE_HANDLE_OUTPUT = record
    Output: TD3D11_AUTHENTICATED_QUERY_OUTPUT;
    DeviceHandle: THANDLE;
  end;

  TD3D11_AUTHENTICATED_QUERY_CRYPTO_SESSION_INPUT = record
    Input: TD3D11_AUTHENTICATED_QUERY_INPUT;
    DecoderHandle: THANDLE;
  end;

  TD3D11_AUTHENTICATED_QUERY_CRYPTO_SESSION_OUTPUT = record
    Output: TD3D11_AUTHENTICATED_QUERY_OUTPUT;
    DecoderHandle: THANDLE;
    CryptoSessionHandle: THANDLE;
    DeviceHandle: THANDLE;
  end;

  TD3D11_AUTHENTICATED_QUERY_RESTRICTED_SHARED_RESOURCE_PROCESS_COUNT_OUTPUT = record
    Output: TD3D11_AUTHENTICATED_QUERY_OUTPUT;
    RestrictedSharedResourceProcessCount: UINT;
  end;

  TD3D11_AUTHENTICATED_QUERY_RESTRICTED_SHARED_RESOURCE_PROCESS_INPUT = record
    Input: TD3D11_AUTHENTICATED_QUERY_INPUT;
    ProcessIndex: UINT;
  end;

  TD3D11_AUTHENTICATED_PROCESS_IDENTIFIER_TYPE = (D3D11_PROCESSIDTYPE_UNKNOWN = 0, D3D11_PROCESSIDTYPE_DWM = 1, D3D11_PROCESSIDTYPE_HANDLE = 2);

  TD3D11_AUTHENTICATED_QUERY_RESTRICTED_SHARED_RESOURCE_PROCESS_OUTPUT = record
    Output: TD3D11_AUTHENTICATED_QUERY_OUTPUT;
    ProcessIndex: UINT;
    ProcessIdentifier: TD3D11_AUTHENTICATED_PROCESS_IDENTIFIER_TYPE;
    ProcessHandle: THANDLE;
  end;

  TD3D11_AUTHENTICATED_QUERY_UNRESTRICTED_PROTECTED_SHARED_RESOURCE_COUNT_OUTPUT = record
    Output: TD3D11_AUTHENTICATED_QUERY_OUTPUT;
    UnrestrictedProtectedSharedResourceCount: UINT;
  end;

  TD3D11_AUTHENTICATED_QUERY_OUTPUT_ID_COUNT_INPUT = record
    Input: TD3D11_AUTHENTICATED_QUERY_INPUT;
    DeviceHandle: THANDLE;
    CryptoSessionHandle: THANDLE;
  end;

  TD3D11_AUTHENTICATED_QUERY_OUTPUT_ID_COUNT_OUTPUT = record
    Output: TD3D11_AUTHENTICATED_QUERY_OUTPUT;
    DeviceHandle: THANDLE;
    CryptoSessionHandle: THANDLE;
    OutputIDCount: UINT;
  end;

  TD3D11_AUTHENTICATED_QUERY_OUTPUT_ID_INPUT = record
    Input: TD3D11_AUTHENTICATED_QUERY_INPUT;
    DeviceHandle: THANDLE;
    CryptoSessionHandle: THANDLE;
    OutputIDIndex: UINT;
  end;

  TD3D11_AUTHENTICATED_QUERY_OUTPUT_ID_OUTPUT = record
    Output: TD3D11_AUTHENTICATED_QUERY_OUTPUT;
    DeviceHandle: THANDLE;
    CryptoSessionHandle: THANDLE;
    OutputIDIndex: UINT;
    OutputID: UINT64;
  end;

  TD3D11_BUS_TYPE = (D3D11_BUS_TYPE_OTHER = 0, D3D11_BUS_TYPE_PCI = $1, D3D11_BUS_TYPE_PCIX = $2, D3D11_BUS_TYPE_PCIEXPRESS = $3, D3D11_BUS_TYPE_AGP = $4, D3D11_BUS_IMPL_MODIFIER_INSIDE_OF_CHIPSET = $10000, D3D11_BUS_IMPL_MODIFIER_TRACKS_ON_MOTHER_BOARD_TO_CHIP = $20000, D3D11_BUS_IMPL_MODIFIER_TRACKS_ON_MOTHER_BOARD_TO_SOCKET = $30000, D3D11_BUS_IMPL_MODIFIER_DAUGHTER_BOARD_CONNECTOR = $40000,
    D3D11_BUS_IMPL_MODIFIER_DAUGHTER_BOARD_CONNECTOR_INSIDE_OF_NUAE = $50000, D3D11_BUS_IMPL_MODIFIER_NON_STANDARD = $80000000);

  TD3D11_AUTHENTICATED_QUERY_ACESSIBILITY_OUTPUT = record
    Output: TD3D11_AUTHENTICATED_QUERY_OUTPUT;
    BusType: TD3D11_BUS_TYPE;
    AccessibleInContiguousBlocks: LongBool;
    AccessibleInNonContiguousBlocks: LongBool;
  end;

  TD3D11_AUTHENTICATED_QUERY_ACCESSIBILITY_ENCRYPTION_GUID_COUNT_OUTPUT = record
    Output: TD3D11_AUTHENTICATED_QUERY_OUTPUT;
    EncryptionGuidCount: UINT;
  end;

  TD3D11_AUTHENTICATED_QUERY_ACCESSIBILITY_ENCRYPTION_GUID_INPUT = record
    Input: TD3D11_AUTHENTICATED_QUERY_INPUT;
    EncryptionGuidIndex: UINT;
  end;

  TD3D11_AUTHENTICATED_QUERY_ACCESSIBILITY_ENCRYPTION_GUID_OUTPUT = record
    Output: TD3D11_AUTHENTICATED_QUERY_OUTPUT;
    EncryptionGuidIndex: UINT;
    EncryptionGuid: TGUID;
  end;

  TD3D11_AUTHENTICATED_QUERY_CURRENT_ACCESSIBILITY_ENCRYPTION_OUTPUT = record
    Output: TD3D11_AUTHENTICATED_QUERY_OUTPUT;
    EncryptionGuid: TGUID;
  end;

  TD3D11_AUTHENTICATED_CONFIGURE_INPUT = record
    Omac: TD3D11_OMAC;
    ConfigureType: TGUID;
    hChannel: THANDLE;
    SequenceNumber: UINT;
  end;

  TD3D11_AUTHENTICATED_CONFIGURE_OUTPUT = record
    Omac: TD3D11_OMAC;
    ConfigureType: TGUID;
    hChannel: THANDLE;
    SequenceNumber: UINT;
    ReturnCode: HResult;
  end;

  TD3D11_AUTHENTICATED_CONFIGURE_INITIALIZE_INPUT = record
    Parameters: TD3D11_AUTHENTICATED_CONFIGURE_INPUT;
    StartSequenceQuery: UINT;
    StartSequenceConfigure: UINT;
  end;

  TD3D11_AUTHENTICATED_CONFIGURE_PROTECTION_INPUT = record
    Parameters: TD3D11_AUTHENTICATED_CONFIGURE_INPUT;
    Protections: TD3D11_AUTHENTICATED_PROTECTION_FLAGS;
  end;

  TD3D11_AUTHENTICATED_CONFIGURE_CRYPTO_SESSION_INPUT = record
    Parameters: TD3D11_AUTHENTICATED_CONFIGURE_INPUT;
    DecoderHandle: THANDLE;
    CryptoSessionHandle: THANDLE;
    DeviceHandle: THANDLE;
  end;

  TD3D11_AUTHENTICATED_CONFIGURE_SHARED_RESOURCE_INPUT = record
    Parameters: TD3D11_AUTHENTICATED_CONFIGURE_INPUT;
    ProcessType: TD3D11_AUTHENTICATED_PROCESS_IDENTIFIER_TYPE;
    ProcessHandle: THANDLE;
    AllowAccess: LongBool;
  end;

  TD3D11_AUTHENTICATED_CONFIGURE_ACCESSIBLE_ENCRYPTION_INPUT = record
    Parameters: TD3D11_AUTHENTICATED_CONFIGURE_INPUT;
    EncryptionGuid: TGUID;
  end;

  ID3D11CryptoSession = interface(ID3D11DeviceChild)
    ['{9B32F9AD-BDCC-40a6-A39D-D5C865845720}']
    procedure GetCryptoType(out pCryptoType: TGUID); stdcall;
    procedure GetDecoderProfile(out pDecoderProfile: TGUID); stdcall;
    function GetCertificateSize(out pCertificateSize: UINT): HResult; stdcall;
    function GetCertificate(CertificateSize: UINT; out pCertificate: PBYTE): HResult; stdcall;
    procedure GetCryptoSessionHandle(out pCryptoSessionHandle: THANDLE); stdcall;
  end;

  TD3D11_VDOV_DIMENSION = (D3D11_VDOV_DIMENSION_UNKNOWN = 0, D3D11_VDOV_DIMENSION_TEXTURE2D = 1);

  TD3D11_TEX2D_VDOV = record
    ArraySlice: UINT;
  end;

  TD3D11_VIDEO_DECODER_OUTPUT_VIEW_DESC = record
    DecodeProfile: TGUID;
    ViewDimension: TD3D11_VDOV_DIMENSION;
    case Integer of
      0:
        (Texture2D: TD3D11_TEX2D_VDOV;);
  end;

  PD3D11_VIDEO_DECODER_OUTPUT_VIEW_DESC = ^TD3D11_VIDEO_DECODER_OUTPUT_VIEW_DESC;

  ID3D11VideoDecoderOutputView = interface(ID3D11View)
    ['{C2931AEA-2A85-4f20-860F-FBA1FD256E18}']
    procedure GetDesc(out pDesc: TD3D11_VIDEO_DECODER_OUTPUT_VIEW_DESC); stdcall;
  end;

  TD3D11_VPIV_DIMENSION = (D3D11_VPIV_DIMENSION_UNKNOWN = 0, D3D11_VPIV_DIMENSION_TEXTURE2D = 1);

  TD3D11_TEX2D_VPIV = record
    MipSlice: UINT;
    ArraySlice: UINT;
  end;

  TD3D11_VIDEO_PROCESSOR_INPUT_VIEW_DESC = record
    FourCC: UINT;
    ViewDimension: TD3D11_VPIV_DIMENSION;
    case Integer of
      0:
        (Texture2D: TD3D11_TEX2D_VPIV;);
  end;

  PD3D11_VIDEO_PROCESSOR_INPUT_VIEW_DESC = ^TD3D11_VIDEO_PROCESSOR_INPUT_VIEW_DESC;

  ID3D11VideoProcessorInputView = interface(ID3D11View)
    ['{11EC5A5F-51DC-4945-AB34-6E8C21300EA5}']
    procedure GetDesc(out pDesc: TD3D11_VIDEO_PROCESSOR_INPUT_VIEW_DESC); stdcall;
  end;

  TD3D11_VPOV_DIMENSION = (D3D11_VPOV_DIMENSION_UNKNOWN = 0, D3D11_VPOV_DIMENSION_TEXTURE2D = 1, D3D11_VPOV_DIMENSION_TEXTURE2DARRAY = 2);

  TD3D11_TEX2D_VPOV = record
    MipSlice: UINT;
  end;

  TD3D11_TEX2D_ARRAY_VPOV = record
    MipSlice: UINT;
    FirstArraySlice: UINT;
    ArraySize: UINT;
  end;

  TD3D11_VIDEO_PROCESSOR_OUTPUT_VIEW_DESC = record
    ViewDimension: TD3D11_VPOV_DIMENSION;
    case Integer of
      0:
        (Texture2D: TD3D11_TEX2D_VPOV;);
      1:
        (Texture2DArray: TD3D11_TEX2D_ARRAY_VPOV;);
  end;

  PD3D11_VIDEO_PROCESSOR_OUTPUT_VIEW_DESC = ^TD3D11_VIDEO_PROCESSOR_OUTPUT_VIEW_DESC;

  ID3D11VideoProcessorOutputView = interface(ID3D11View)
    ['{A048285E-25A9-4527-BD93-D68B68C44254}']
    procedure GetDesc(out pDesc: TD3D11_VIDEO_PROCESSOR_OUTPUT_VIEW_DESC); stdcall;
  end;

  ID3D11VideoContext = interface(ID3D11DeviceChild)
    ['{61F21C45-3C0E-4a74-9CEA-67100D9AD5E4}']
    function GetDecoderBuffer(pDecoder: ID3D11VideoDecoder; _Type: TD3D11_VIDEO_DECODER_BUFFER_TYPE; out pBufferSize: UINT; ppBuffer: Pointer): HResult; stdcall;
    function ReleaseDecoderBuffer(pDecoder: ID3D11VideoDecoder; _Type: TD3D11_VIDEO_DECODER_BUFFER_TYPE): HResult; stdcall;
    function DecoderBeginFrame(pDecoder: ID3D11VideoDecoder; pView: ID3D11VideoDecoderOutputView; ContentKeySize: UINT; pContentKey: Pointer): HResult; stdcall;
    function DecoderEndFrame(pDecoder: ID3D11VideoDecoder): HResult; stdcall;
    function SubmitDecoderBuffers(pDecoder: ID3D11VideoDecoder; NumBuffers: UINT; pBufferDesc: PD3D11_VIDEO_DECODER_BUFFER_DESC): HResult; stdcall;
    function DecoderExtension(pDecoder: ID3D11VideoDecoder; pExtensionData: PD3D11_VIDEO_DECODER_EXTENSION): HResult; stdcall;
    procedure VideoProcessorSetOutputTargetRect(pVideoProcessor: ID3D11VideoProcessor; Enable: LongBool; pRect: pRect); stdcall;
    procedure VideoProcessorSetOutputBackgroundColor(pVideoProcessor: ID3D11VideoProcessor; YCbCr: LongBool; pColor: PD3D11_VIDEO_COLOR); stdcall;
    procedure VideoProcessorSetOutputColorSpace(pVideoProcessor: ID3D11VideoProcessor; pColorSpace: PD3D11_VIDEO_PROCESSOR_COLOR_SPACE); stdcall;
    procedure VideoProcessorSetOutputAlphaFillMode(pVideoProcessor: ID3D11VideoProcessor; AlphaFillMode: TD3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE; StreamIndex: UINT); stdcall;
    procedure VideoProcessorSetOutputConstriction(pVideoProcessor: ID3D11VideoProcessor; Enable: LongBool; Size: TSIZE); stdcall;
    procedure VideoProcessorSetOutputStereoMode(pVideoProcessor: ID3D11VideoProcessor; Enable: LongBool); stdcall;
    function VideoProcessorSetOutputExtension(pVideoProcessor: ID3D11VideoProcessor; pExtensionGuid: PGUID; DataSize: UINT; pData: Pointer): HResult; stdcall;
    procedure VideoProcessorGetOutputTargetRect(pVideoProcessor: ID3D11VideoProcessor; out Enabled: LongBool; out pRect: TRECT); stdcall;
    procedure VideoProcessorGetOutputBackgroundColor(pVideoProcessor: ID3D11VideoProcessor; out pYCbCr: LongBool; out pColor: TD3D11_VIDEO_COLOR); stdcall;
    procedure VideoProcessorGetOutputColorSpace(pVideoProcessor: ID3D11VideoProcessor; out pColorSpace: TD3D11_VIDEO_PROCESSOR_COLOR_SPACE); stdcall;
    procedure VideoProcessorGetOutputAlphaFillMode(pVideoProcessor: ID3D11VideoProcessor; out pAlphaFillMode: TD3D11_VIDEO_PROCESSOR_ALPHA_FILL_MODE; out pStreamIndex: UINT); stdcall;
    procedure VideoProcessorGetOutputConstriction(pVideoProcessor: ID3D11VideoProcessor; out pEnabled: BOOL; out pSize: TSIZE); stdcall;
    procedure VideoProcessorGetOutputStereoMode(pVideoProcessor: ID3D11VideoProcessor; out pEnabled: LongBool); stdcall;
    function VideoProcessorGetOutputExtension(pVideoProcessor: ID3D11VideoProcessor; pExtensionGuid: PGUID; DataSize: UINT; out pData: Pointer): HResult; stdcall;
    procedure VideoProcessorSetStreamFrameFormat(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; FrameFormat: TD3D11_VIDEO_FRAME_FORMAT); stdcall;
    procedure VideoProcessorSetStreamColorSpace(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; pColorSpace: PD3D11_VIDEO_PROCESSOR_COLOR_SPACE); stdcall;
    procedure VideoProcessorSetStreamOutputRate(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; OutputRate: TD3D11_VIDEO_PROCESSOR_OUTPUT_RATE; RepeatFrame: LongBool; pCustomRate: PDXGI_RATIONAL); stdcall;
    procedure VideoProcessorSetStreamSourceRect(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; Enable: LongBool; pRect: pRect); stdcall;
    procedure VideoProcessorSetStreamDestRect(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; Enable: LongBool; pRect: pRect); stdcall;
    procedure VideoProcessorSetStreamAlpha(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; Enable: LongBool; Alpha: Single); stdcall;
    procedure VideoProcessorSetStreamPalette(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; Count: UINT; pEntries: PUINT); stdcall;
    procedure VideoProcessorSetStreamPixelAspectRatio(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; Enable: LongBool; pSourceAspectRatio: PDXGI_RATIONAL; pDestinationAspectRatio: PDXGI_RATIONAL); stdcall;
    procedure VideoProcessorSetStreamLumaKey(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; Enable: LongBool; Lower: Single; Upper: Single); stdcall;
    procedure VideoProcessorSetStreamStereoFormat(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; Enable: LongBool; Format: TD3D11_VIDEO_PROCESSOR_STEREO_FORMAT; LeftViewFrame0: LongBool; BaseViewFrame0: LongBool; FlipMode: TD3D11_VIDEO_PROCESSOR_STEREO_FLIP_MODE; MonoOffset: Integer); stdcall;
    procedure VideoProcessorSetStreamAutoProcessingMode(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; Enable: LongBool); stdcall;
    procedure VideoProcessorSetStreamFilter(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; Filter: TD3D11_VIDEO_PROCESSOR_FILTER; Enable: LongBool; Level: Integer); stdcall;
    function VideoProcessorSetStreamExtension(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; pExtensionGuid: PGUID; DataSize: UINT; pData: Pointer): HResult; stdcall;
    procedure VideoProcessorGetStreamFrameFormat(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; out pFrameFormat: TD3D11_VIDEO_FRAME_FORMAT); stdcall;
    procedure VideoProcessorGetStreamColorSpace(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; out pColorSpace: TD3D11_VIDEO_PROCESSOR_COLOR_SPACE); stdcall;
    procedure VideoProcessorGetStreamOutputRate(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; out pOutputRate: TD3D11_VIDEO_PROCESSOR_OUTPUT_RATE; out pRepeatFrame: LongBool; out pCustomRate: TDXGI_RATIONAL); stdcall;
    procedure VideoProcessorGetStreamSourceRect(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; out pEnabled: LongBool; out pRect: TRECT); stdcall;
    procedure VideoProcessorGetStreamDestRect(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; out pEnabled: LongBool; out pRect: TRECT); stdcall;
    procedure VideoProcessorGetStreamAlpha(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; out pEnabled: LongBool; out pAlpha: Single); stdcall;
    procedure VideoProcessorGetStreamPalette(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; Count: UINT; out pEntries: PUINT); stdcall;
    procedure VideoProcessorGetStreamPixelAspectRatio(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; out pEnabled: LongBool; out pSourceAspectRatio: TDXGI_RATIONAL; out pDestinationAspectRatio: TDXGI_RATIONAL); stdcall;
    procedure VideoProcessorGetStreamLumaKey(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; out pEnabled: LongBool; out pLower: Single; out pUpper: Single); stdcall;
    procedure VideoProcessorGetStreamStereoFormat(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; out pEnable: LongBool; out pFormat: TD3D11_VIDEO_PROCESSOR_STEREO_FORMAT; out pLeftViewFrame0: LongBool; out pBaseViewFrame0: LongBool; out pFlipMode: TD3D11_VIDEO_PROCESSOR_STEREO_FLIP_MODE; out MonoOffset: Integer); stdcall;
    procedure VideoProcessorGetStreamAutoProcessingMode(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; out pEnabled: LongBool); stdcall;
    procedure VideoProcessorGetStreamFilter(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; Filter: TD3D11_VIDEO_PROCESSOR_FILTER; out pEnabled: LongBool; out pLevel: Integer); stdcall;
    function VideoProcessorGetStreamExtension(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; pExtensionGuid: PGUID; DataSize: UINT; pData: Pointer): HResult; stdcall;
    function VideoProcessorBlt(pVideoProcessor: ID3D11VideoProcessor; pView: ID3D11VideoProcessorOutputView; OutputFrame: UINT; StreamCount: UINT; pStreams: PD3D11_VIDEO_PROCESSOR_STREAM): HResult; stdcall;
    function NegotiateCryptoSessionKeyExchange(pCryptoSession: ID3D11CryptoSession; DataSize: UINT; var pData: Pointer): HResult; stdcall;
    procedure EncryptionBlt(pCryptoSession: ID3D11CryptoSession; pSrcSurface: ID3D11Texture2D; pDstSurface: ID3D11Texture2D; IVSize: UINT; var pIV: Pointer); stdcall;
    procedure DecryptionBlt(pCryptoSession: ID3D11CryptoSession; pSrcSurface: ID3D11Texture2D; pDstSurface: ID3D11Texture2D; pEncryptedBlockInfo: PD3D11_ENCRYPTED_BLOCK_INFO; ContentKeySize: UINT; pContentKey: Pointer; IVSize: UINT; var pIV: Pointer); stdcall;
    procedure StartSessionKeyRefresh(pCryptoSession: ID3D11CryptoSession; RandomNumberSize: UINT; out pRandomNumber: Pointer); stdcall;
    procedure FinishSessionKeyRefresh(pCryptoSession: ID3D11CryptoSession); stdcall;
    function GetEncryptionBltKey(pCryptoSession: ID3D11CryptoSession; KeySize: UINT; out pReadbackKey: Pointer): HResult; stdcall;
    function NegotiateAuthenticatedChannelKeyExchange(pChannel: ID3D11AuthenticatedChannel; DataSize: UINT; var pData: Pointer): HResult; stdcall;
    function QueryAuthenticatedChannel(pChannel: ID3D11AuthenticatedChannel; InputSize: UINT; pInput: Pointer; OutputSize: UINT; out pOutput: Pointer): HResult; stdcall;
    function ConfigureAuthenticatedChannel(pChannel: ID3D11AuthenticatedChannel; InputSize: UINT; pInput: Pointer; Out pOutput: TD3D11_AUTHENTICATED_CONFIGURE_OUTPUT): HResult; stdcall;
    procedure VideoProcessorSetStreamRotation(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; Enable: LongBool; Rotation: TD3D11_VIDEO_PROCESSOR_ROTATION); stdcall;
    procedure VideoProcessorGetStreamRotation(pVideoProcessor: ID3D11VideoProcessor; StreamIndex: UINT; out pEnable: LongBool; out pRotation: TD3D11_VIDEO_PROCESSOR_ROTATION); stdcall;
  end;

  ID3D11VideoDevice = interface(IUnknown)
    ['{10EC4D5B-975A-4689-B9E4-D0AAC30FE333}']
    function CreateVideoDecoder(pVideoDesc: PD3D11_VIDEO_DECODER_DESC; pConfig: PD3D11_VIDEO_DECODER_CONFIG; out ppDecoder: ID3D11VideoDecoder): HResult; stdcall;
    function CreateVideoProcessor(pEnum: ID3D11VideoProcessorEnumerator; RateConversionIndex: UINT; out ppVideoProcessor: ID3D11VideoProcessor): HResult; stdcall;
    function CreateAuthenticatedChannel(ChannelType: TD3D11_AUTHENTICATED_CHANNEL_TYPE; out ppAuthenticatedChannel: ID3D11AuthenticatedChannel): HResult; stdcall;
    function CreateCryptoSession(pCryptoType: PGUID; pDecoderProfile: PGUID; pKeyExchangeType: PGUID; out ppCryptoSession: ID3D11CryptoSession): HResult; stdcall;
    function CreateVideoDecoderOutputView(pResource: ID3D11Resource; pDesc: PD3D11_VIDEO_DECODER_OUTPUT_VIEW_DESC; out ppVDOVView: ID3D11VideoDecoderOutputView): HResult; stdcall;
    function CreateVideoProcessorInputView(pResource: ID3D11Resource; pEnum: ID3D11VideoProcessorEnumerator; pDesc: PD3D11_VIDEO_PROCESSOR_INPUT_VIEW_DESC; out ppVPIView: ID3D11VideoProcessorInputView): HResult; stdcall;
    function CreateVideoProcessorOutputView(pResource: ID3D11Resource; pEnum: ID3D11VideoProcessorEnumerator; pDesc: PD3D11_VIDEO_PROCESSOR_OUTPUT_VIEW_DESC; out ppVPOView: ID3D11VideoProcessorOutputView): HResult; stdcall;
    function CreateVideoProcessorEnumerator(pDesc: PD3D11_VIDEO_PROCESSOR_CONTENT_DESC; out ppEnum: ID3D11VideoProcessorEnumerator): HResult; stdcall;
    function GetVideoDecoderProfileCount(): UINT; stdcall;
    function GetVideoDecoderProfile(Index: UINT; out pDecoderProfile: TGUID): HResult; stdcall;
    function CheckVideoDecoderFormat(pDecoderProfile: PGUID; Format: TDXGI_FORMAT; out pSupported: LongBool): HResult; stdcall;
    function GetVideoDecoderConfigCount(pDesc: PD3D11_VIDEO_DECODER_DESC; out pCount: UINT): HResult; stdcall;
    function GetVideoDecoderConfig(pDesc: PD3D11_VIDEO_DECODER_DESC; Index: UINT; out pConfig: TD3D11_VIDEO_DECODER_CONFIG): HResult; stdcall;
    function GetContentProtectionCaps(pCryptoType: PGUID; pDecoderProfile: PGUID; out pCaps: TD3D11_VIDEO_CONTENT_PROTECTION_CAPS): HResult; stdcall;
    function CheckCryptoKeyExchange(pCryptoType: PGUID; pDecoderProfile: PGUID; Index: UINT; out pKeyExchangeType: TGUID): HResult; stdcall;
    function SetPrivateData(guid: TGUID; DataSize: UINT; pData: Pointer): HResult; stdcall;
    function SetPrivateDataInterface(guid: TGUID; pData: IUnknown): HResult; stdcall;
  end;

  ID3D11Device = interface(IUnknown)
    ['{db6f6ddb-ac77-4e88-8253-819df9bbf140}']
    function CreateBuffer(const pDesc: TD3D11_BUFFER_DESC; pInitialData: PD3D11_SUBRESOURCE_DATA; out ppBuffer: ID3D11Buffer): HResult; stdcall;
    function CreateTexture1D(pDesc: PD3D11_TEXTURE1D_DESC; pInitialData: PD3D11_SUBRESOURCE_DATA; out ppTexture1D: ID3D11Texture1D): HResult; stdcall;
    function CreateTexture2D(const pDesc: TD3D11_TEXTURE2D_DESC; pInitialData: PD3D11_SUBRESOURCE_DATA; out ppTexture2D: ID3D11Texture2D): HResult; stdcall;
    function CreateTexture3D(pDesc: PD3D11_TEXTURE3D_DESC; pInitialData: PD3D11_SUBRESOURCE_DATA; out ppTexture3D: ID3D11Texture3D): HResult; stdcall;
    function CreateShaderResourceView(pResource: ID3D11Resource; pDesc: PD3D11_SHADER_RESOURCE_VIEW_DESC; out ppSRView: ID3D11ShaderResourceView): HResult; stdcall;
    function CreateUnorderedAccessView(pResource: ID3D11Resource; pDesc: PD3D11_UNORDERED_ACCESS_VIEW_DESC; out ppUAView: ID3D11UnorderedAccessView): HResult; stdcall;
    function CreateRenderTargetView(pResource: ID3D11Resource; pDesc: PD3D11_RENDER_TARGET_VIEW_DESC; out ppRTView: ID3D11RenderTargetView): HResult; stdcall;
    function CreateDepthStencilView(pResource: ID3D11Resource; pDesc: PD3D11_DEPTH_STENCIL_VIEW_DESC; out ppDepthStencilView: ID3D11DepthStencilView): HResult; stdcall;
    function CreateInputLayout(pInputElementDescs: PD3D11_INPUT_ELEMENT_DESC; NumElements: UINT; pShaderBytecodeWithInputSignature: Pointer; BytecodeLength: SIZE_T; out ppInputLayout: ID3D11InputLayout): HResult; stdcall;
    function CreateVertexShader(pShaderBytecode: Pointer; BytecodeLength: SIZE_T; pClassLinkage: ID3D11ClassLinkage; out ppVertexShader: ID3D11VertexShader): HResult; stdcall;
    function CreateGeometryShader(pShaderBytecode: Pointer; BytecodeLength: SIZE_T; pClassLinkage: ID3D11ClassLinkage; out ppGeometryShader: ID3D11GeometryShader): HResult; stdcall;
    function CreateGeometryShaderWithStreamOutput(pShaderBytecode: Pointer; BytecodeLength: SIZE_T; pSODeclaration: PD3D11_SO_DECLARATION_ENTRY; NumEntries: UINT; pBufferStrides: PUINT; NumStrides: UINT; RasterizedStream: UINT; pClassLinkage: ID3D11ClassLinkage; out ppGeometryShader: ID3D11GeometryShader): HResult; stdcall;
    function CreatePixelShader(pShaderBytecode: Pointer; BytecodeLength: SIZE_T; pClassLinkage: ID3D11ClassLinkage; out ppPixelShader: ID3D11PixelShader): HResult; stdcall;
    function CreateHullShader(pShaderBytecode: Pointer; BytecodeLength: SIZE_T; pClassLinkage: ID3D11ClassLinkage; out ppHullShader: ID3D11HullShader): HResult; stdcall;
    function CreateDomainShader(pShaderBytecode: Pointer; BytecodeLength: SIZE_T; pClassLinkage: ID3D11ClassLinkage; out ppDomainShader: ID3D11DomainShader): HResult; stdcall;
    function CreateComputeShader(pShaderBytecode: Pointer; BytecodeLength: SIZE_T; pClassLinkage: ID3D11ClassLinkage; out ppComputeShader: ID3D11ComputeShader): HResult; stdcall;
    function CreateClassLinkage(out ppLinkage: ID3D11ClassLinkage): HResult; stdcall;
    function CreateBlendState(const pBlendStateDesc: TD3D11_BLEND_DESC; out ppBlendState: ID3D11BlendState): HResult; stdcall;
    function CreateDepthStencilState(const pDepthStencilDesc: TD3D11_DEPTH_STENCIL_DESC; out ppDepthStencilState: ID3D11DepthStencilState): HResult; stdcall;
    function CreateRasterizerState(const pRasterizerDesc: TD3D11_RASTERIZER_DESC; out ppRasterizerState: ID3D11RasterizerState): HResult; stdcall;
    function CreateSamplerState(const pSamplerDesc: TD3D11_SAMPLER_DESC; out ppSamplerState: ID3D11SamplerState): HResult; stdcall;
    function CreateQuery(pQueryDesc: PD3D11_QUERY_DESC; out ppQuery: ID3D11Query): HResult; stdcall;
    function CreatePredicate(pPredicateDesc: PD3D11_QUERY_DESC; out ppPredicate: ID3D11Predicate): HResult; stdcall;
    function CreateCounter(pCounterDesc: PD3D11_COUNTER_DESC; out ppCounter: ID3D11Counter): HResult; stdcall;
    function CreateDeferredContext(ContextFlags: UINT; out ppDeferredContext: ID3D11DeviceContext): HResult; stdcall;
    function OpenSharedResource(hResource: THANDLE; const ReturnedInterface: TGUID; out ppResource { : Pointer } ): HResult; stdcall;
    function CheckFormatSupport(Format: TDXGI_FORMAT; out pFormatSupport: UINT): HResult; stdcall;
    function CheckMultisampleQualityLevels(Format: TDXGI_FORMAT; SampleCount: UINT; out pNumQualityLevels: UINT): HResult; stdcall;
    procedure CheckCounterInfo(out pCounterInfo: TD3D11_COUNTER_INFO); stdcall;
    function CheckCounter(pDesc: PD3D11_COUNTER_DESC; out pType: TD3D11_COUNTER_TYPE; out pActiveCounters: UINT; out szName: PAnsiChar; var pNameLength: UINT; out szUnits: PAnsiChar; var pUnitsLength: UINT; out szDescription: PAnsiChar; var pDescriptionLength: UINT): HResult; stdcall;
    function CheckFeatureSupport(Feature: TD3D11_FEATURE; out pFeatureSupportData: Pointer; FeatureSupportDataSize: UINT): HResult; stdcall;
    function GetPrivateData(guid: TGUID; var pDataSize: UINT; out pData: Pointer): HResult; stdcall;
    function SetPrivateData(guid: TGUID; DataSize: UINT; pData: Pointer): HResult; stdcall;
    function SetPrivateDataInterface(guid: TGUID; pData: IUnknown): HResult; stdcall;
    function GetFeatureLevel(): TD3D_FEATURE_LEVEL; stdcall;
    function GetCreationFlags(): UINT; stdcall;
    function GetDeviceRemovedReason(): HResult; stdcall;
    procedure GetImmediateContext(out ppImmediateContext: ID3D11DeviceContext); stdcall;
    function SetExceptionMode(RaiseFlags: UINT): HResult; stdcall;
    function GetExceptionMode(): UINT; stdcall;
  end;

  TD3D11_CREATE_DEVICE_FLAG = (D3D11_CREATE_DEVICE_SINGLETHREADED = $1, D3D11_CREATE_DEVICE_DEBUG = $2, D3D11_CREATE_DEVICE_SWITCH_TO_REF = $4, D3D11_CREATE_DEVICE_PREVENT_INTERNAL_THREADING_OPTIMIZATIONS = $8, D3D11_CREATE_DEVICE_BGRA_SUPPORT = $20, D3D11_CREATE_DEVICE_DEBUGGABLE = $40, D3D11_CREATE_DEVICE_PREVENT_ALTERING_LAYER_SETTINGS_FROM_REGISTRY = $80,
    D3D11_CREATE_DEVICE_DISABLE_GPU_TIMEOUT = $100, D3D11_CREATE_DEVICE_VIDEO_SUPPORT = $800);
function D3D11CreateDevice(pAdapter: IDXGIAdapter; DriverType: TD3D_DRIVER_TYPE; Software: HMODULE; Flags: UINT; pFeatureLevels: PD3D_FEATURE_LEVEL; FeatureLevels: UINT; SDKVersion: UINT; out ppDevice: ID3D11Device; out pFeatureLevel: TD3D_FEATURE_LEVEL; out ppImmediateContext: ID3D11DeviceContext): HResult; stdcall; external DLL_D3D11;

{ D3D11Shader.h }
type
  TD3D11_SHADER_VERSION_TYPE = (D3D11_SHVER_PIXEL_SHADER = 0, D3D11_SHVER_VERTEX_SHADER = 1, D3D11_SHVER_GEOMETRY_SHADER = 2,
    // D3D11 Shaders
    D3D11_SHVER_HULL_SHADER = 3, D3D11_SHVER_DOMAIN_SHADER = 4, D3D11_SHVER_COMPUTE_SHADER = 5, D3D11_SHVER_RESERVED0 = $FFF0);
  PD3D11_SHADER_VERSION_TYPE = ^TD3D11_SHADER_VERSION_TYPE;
  // Parameter flags.
  TD3D_PARAMETER_FLAGS        = (D3D_PF_NONE = $00000000, D3D_PF_IN = $00000001, D3D_PF_OUT = $00000002, D3D_PF_FORCE_DWORD = $7FFFFFFF);
  PD3D_PARAMETER_FLAGS        = ^TD3D_PARAMETER_FLAGS;
  TD3D11_RESOURCE_RETURN_TYPE = TD3D_RESOURCE_RETURN_TYPE;
  TD3D11_CBUFFER_TYPE         = TD3D_CBUFFER_TYPE;

  TD3D11_SIGNATURE_PARAMETER_DESC = record
    SemanticName: PAnsiChar;                     // Name of the semantic
    SemanticIndex: UINT;                         // Index of the semantic
    _Register: UINT;                             // Number of member variables
    SystemValueType: TD3D_NAME;                  // A predefined system value, or D3D_NAME_UNDEFINED if not applicable
    ComponentType: TD3D_REGISTER_COMPONENT_TYPE; // Scalar type (e.g. uint, float, etc.)
    Mask: byte;                                  // Mask to indicate which components of the register
    // are used (combination of D3D10_COMPONENT_MASK values)
    ReadWriteMask: byte; // Mask to indicate whether a given component is
    // never written (if this is an output signature) or
    // always read (if this is an input signature).
    // (combination of D3D_MASK_* values)
    Stream: UINT;                     // Stream index
    MinPrecision: TD3D_MIN_PRECISION; // Minimum desired interpolation precision
  end;

  TD3D11_SHADER_BUFFER_DESC = record
    Name: PAnsiChar;          // Name of the constant buffer
    _Type: TD3D_CBUFFER_TYPE; // Indicates type of buffer content
    Variables: UINT;          // Number of member variables
    Size: UINT;               // Size of CB (in bytes)
    uFlags: UINT;             // Buffer description flags
  end;

  TD3D11_SHADER_VARIABLE_DESC = record
    Name: PAnsiChar;       // Name of the variable
    StartOffset: UINT;     // Offset in constant buffer's backing store
    Size: UINT;            // Size of variable (in bytes)
    uFlags: UINT;          // Variable flags
    DefaultValue: Pointer; // Raw pointer to default value
    StartTexture: UINT;    // First texture index (or -1 if no textures used)
    TextureSize: UINT;     // Number of texture slots possibly used.
    StartSampler: UINT;    // First sampler index (or -1 if no textures used)
    SamplerSize: UINT;     // Number of sampler slots possibly used.
  end;

  TD3D11_SHADER_TYPE_DESC = record
    _Class: TD3D_SHADER_VARIABLE_CLASS; // Variable class (e.g. object, matrix, etc.)
    _Type: TD3D_SHADER_VARIABLE_TYPE;   // Variable type (e.g. float, sampler, etc.)
    Rows: UINT;                         // Number of rows (for matrices, 1 for other numeric, 0 if not applicable)
    Columns: UINT;                      // Number of columns (for vectors & matrices, 1 for other numeric, 0 if not applicable)
    Elements: UINT;                     // Number of elements (0 if not an array)
    Members: UINT;                      // Number of members (0 if not a structure)
    Offset: UINT;                       // Offset from the start of structure (0 if not a structure member)
    Name: PAnsiChar;                    // Name of type, can be NULL
  end;

  TD3D11_TESSELLATOR_DOMAIN           = TD3D_TESSELLATOR_DOMAIN;
  TD3D11_TESSELLATOR_PARTITIONING     = TD3D_TESSELLATOR_PARTITIONING;
  TD3D11_TESSELLATOR_OUTPUT_PRIMITIVE = TD3D_TESSELLATOR_OUTPUT_PRIMITIVE;

  TD3D11_SHADER_DESC = record
    Version: UINT;                                        // Shader version
    Creator: PAnsiChar;                                   // Creator string
    Flags: UINT;                                          // Shader compilation/parse flags
    ConstantBuffers: UINT;                                // Number of constant buffers
    BoundResources: UINT;                                 // Number of bound resources
    InputParameters: UINT;                                // Number of parameters in the input signature
    OutputParameters: UINT;                               // Number of parameters in the output signature
    InstructionCount: UINT;                               // Number of emitted instructions
    TempRegisterCount: UINT;                              // Number of temporary registers used
    TempArrayCount: UINT;                                 // Number of temporary arrays used
    DefCount: UINT;                                       // Number of constant defines
    DclCount: UINT;                                       // Number of declarations (input + output)
    TextureNormalInstructions: UINT;                      // Number of non-categorized texture instructions
    TextureLoadInstructions: UINT;                        // Number of texture load instructions
    TextureCompInstructions: UINT;                        // Number of texture comparison instructions
    TextureBiasInstructions: UINT;                        // Number of texture bias instructions
    TextureGradientInstructions: UINT;                    // Number of texture gradient instructions
    FloatInstructionCount: UINT;                          // Number of floating point arithmetic instructions used
    IntInstructionCount: UINT;                            // Number of signed integer arithmetic instructions used
    UintInstructionCount: UINT;                           // Number of unsigned integer arithmetic instructions used
    StaticFlowControlCount: UINT;                         // Number of static flow control instructions used
    DynamicFlowControlCount: UINT;                        // Number of dynamic flow control instructions used
    MacroInstructionCount: UINT;                          // Number of macro instructions used
    ArrayInstructionCount: UINT;                          // Number of array instructions used
    CutInstructionCount: UINT;                            // Number of cut instructions used
    EmitInstructionCount: UINT;                           // Number of emit instructions used
    GSOutputTopology: TD3D_PRIMITIVE_TOPOLOGY;            // Geometry shader output topology
    GSMaxOutputVertexCount: UINT;                         // Geometry shader maximum output vertex count
    InputPrimitive: TD3D_PRIMITIVE;                       // GS/HS input primitive
    PatchConstantParameters: UINT;                        // Number of parameters in the patch constant signature
    cGSInstanceCount: UINT;                               // Number of Geometry shader instances
    cControlPoints: UINT;                                 // Number of control points in the HS->DS stage
    HSOutputPrimitive: TD3D_TESSELLATOR_OUTPUT_PRIMITIVE; // Primitive output by the tessellator
    HSPartitioning: TD3D_TESSELLATOR_PARTITIONING;        // Partitioning mode of the tessellator
    TessellatorDomain: TD3D_TESSELLATOR_DOMAIN;           // Domain of the tessellator (quad, tri, isoline)
    // instruction counts
    cBarrierInstructions: UINT;      // Number of barrier instructions in a compute shader
    cInterlockedInstructions: UINT;  // Number of interlocked instructions
    cTextureStoreInstructions: UINT; // Number of texture writes
  end;

  TD3D11_SHADER_INPUT_BIND_DESC = record
    Name: PAnsiChar;                       // Name of the resource
    _Type: TD3D_SHADER_INPUT_TYPE;         // Type of resource (e.g. texture, cbuffer, etc.)
    BindPoint: UINT;                       // Starting bind point
    BindCount: UINT;                       // Number of contiguous bind points (for arrays)
    uFlags: UINT;                          // Input binding flags
    ReturnType: TD3D_RESOURCE_RETURN_TYPE; // Return type (if texture)
    Dimension: TD3D_SRV_DIMENSION;         // Dimension (if texture)
    NumSamples: UINT;                      // Number of samples (0 if not MS texture)
  end;

  TD3D11_LIBRARY_DESC = record
    Creator: PAnsiChar;  // The name of the originator of the library.
    Flags: UINT;         // Compilation flags.
    FunctionCount: UINT; // Number of functions exported from the library.
  end;

  TD3D11_FUNCTION_DESC = record
    Version: UINT;                       // Shader version
    Creator: PAnsiChar;                  // Creator string
    Flags: UINT;                         // Shader compilation/parse flags
    ConstantBuffers: UINT;               // Number of constant buffers
    BoundResources: UINT;                // Number of bound resources
    InstructionCount: UINT;              // Number of emitted instructions
    TempRegisterCount: UINT;             // Number of temporary registers used
    TempArrayCount: UINT;                // Number of temporary arrays used
    DefCount: UINT;                      // Number of constant defines
    DclCount: UINT;                      // Number of declarations (input + output)
    TextureNormalInstructions: UINT;     // Number of non-categorized texture instructions
    TextureLoadInstructions: UINT;       // Number of texture load instructions
    TextureCompInstructions: UINT;       // Number of texture comparison instructions
    TextureBiasInstructions: UINT;       // Number of texture bias instructions
    TextureGradientInstructions: UINT;   // Number of texture gradient instructions
    FloatInstructionCount: UINT;         // Number of floating point arithmetic instructions used
    IntInstructionCount: UINT;           // Number of signed integer arithmetic instructions used
    UintInstructionCount: UINT;          // Number of unsigned integer arithmetic instructions used
    StaticFlowControlCount: UINT;        // Number of static flow control instructions used
    DynamicFlowControlCount: UINT;       // Number of dynamic flow control instructions used
    MacroInstructionCount: UINT;         // Number of macro instructions used
    ArrayInstructionCount: UINT;         // Number of array instructions used
    MovInstructionCount: UINT;           // Number of mov instructions used
    MovcInstructionCount: UINT;          // Number of movc instructions used
    ConversionInstructionCount: UINT;    // Number of type conversion instructions used
    BitwiseInstructionCount: UINT;       // Number of bitwise arithmetic instructions used
    MinFeatureLevel: TD3D_FEATURE_LEVEL; // Min target of the function byte code
    RequiredFeatureFlags: UINT64;        // Required feature flags
    Name: PAnsiChar;                     // Function name
    FunctionParameterCount: Integer;     // Number of logical parameters in the function signature (not including return)
    HasReturn: LongBool;                 // TRUE, if function returns a value, false - it is a subroutine
    Has10Level9VertexShader: LongBool;   // TRUE, if there is a 10L9 VS blob
    Has10Level9PixelShader: LongBool;    // TRUE, if there is a 10L9 PS blob
  end;

  TD3D11_PARAMETER_DESC = record
    Name: PAnsiChar;                            // Parameter name.
    SemanticName: PAnsiChar;                    // Parameter semantic name (+index).
    _Type: TD3D_SHADER_VARIABLE_TYPE;           // Element type.
    _Class: TD3D_SHADER_VARIABLE_CLASS;         // Scalar/Vector/Matrix.
    Rows: UINT;                                 // Rows are for matrix parameters.
    Columns: UINT;                              // Components or Columns in matrix.
    InterpolationMode: TD3D_INTERPOLATION_MODE; // Interpolation mode.
    Flags: TD3D_PARAMETER_FLAGS;                // Parameter modifiers.
    FirstInRegister: UINT;                      // The first input register for this parameter.
    FirstInComponent: UINT;                     // The first input register component for this parameter.
    FirstOutRegister: UINT;                     // The first output register for this parameter.
    FirstOutComponent: UINT;                    // The first output register component for this parameter.
  end;

  PD3D11_PARAMETER_DESC = ^TD3D11_PARAMETER_DESC;
{$IFDEF FPC}
{$INTERFACES Corba}
  ID3D11ShaderReflectionConstantBuffer = interface;

  ID3D11ShaderReflectionType = interface
    ['{6E6FFA6A-9BAE-4613-A51E-91652D508C21}']
    function GetDesc(out pDesc: TD3D11_SHADER_TYPE_DESC): HResult; stdcall;
    function GetMemberTypeByIndex(Index: UINT): ID3D11ShaderReflectionType; stdcall;
    function GetMemberTypeByName(Name: PAnsiChar): ID3D11ShaderReflectionType; stdcall;
    function GetMemberTypeName(Index: UINT): PAnsiChar; stdcall;
    function IsEqual(pType: ID3D11ShaderReflectionType): HResult; stdcall;
    function GetSubType(): ID3D11ShaderReflectionType; stdcall;
    function GetBaseClass(): ID3D11ShaderReflectionType; stdcall;
    function GetNumInterfaces(): UINT; stdcall;
    function GetInterfaceByIndex(uIndex: UINT): ID3D11ShaderReflectionType; stdcall;
    function IsOfType(pType: ID3D11ShaderReflectionType): HResult; stdcall;
    function ImplementsInterface(pBase: ID3D11ShaderReflectionType): HResult; stdcall;
  end;

  ID3D11ShaderReflectionVariable = interface
    ['{51F23923-F3E5-4BD1-91CB-606177D8DB4C}']
    function GetDesc(out pDesc: TD3D11_SHADER_VARIABLE_DESC): HResult; stdcall;
    function GetType(): ID3D11ShaderReflectionType; stdcall;
    function GetBuffer(): ID3D11ShaderReflectionConstantBuffer; stdcall;
    function GetInterfaceSlot(uArrayIndex: UINT): UINT; stdcall;
  end;

  ID3D11ShaderReflectionConstantBuffer = interface
    ['{EB62D63D-93DD-4318-8AE8-C6F83AD371B8}']
    function GetDesc(pDesc: TD3D11_SHADER_BUFFER_DESC): HResult; stdcall;
    function GetVariableByIndex(Index: UINT): ID3D11ShaderReflectionVariable; stdcall;
    function GetVariableByName(Name: PAnsiChar): ID3D11ShaderReflectionVariable; stdcall;
  end;

  ID3D11FunctionParameterReflection = interface
    ['{42757488-334F-47FE-982E-1A65D08CC462}']
    function GetDesc(out pDesc: TD3D11_PARAMETER_DESC): HResult; stdcall;
  end;

  ID3D11FunctionReflection = interface
    ['{207BCECB-D683-4A06-A8A3-9B149B9F73A4}']
    function GetDesc(out pDesc: TD3D11_FUNCTION_DESC): HResult; stdcall;
    function GetConstantBufferByIndex(BufferIndex: UINT): ID3D11ShaderReflectionConstantBuffer; stdcall;
    function GetConstantBufferByName(Name: PAnsiChar): ID3D11ShaderReflectionConstantBuffer; stdcall;
    function GetResourceBindingDesc(ResourceIndex: UINT; out pDesc: TD3D11_SHADER_INPUT_BIND_DESC): HResult; stdcall;
    function GetVariableByName(Name: PAnsiChar): ID3D11ShaderReflectionVariable; stdcall;
    function GetResourceBindingDescByName(Name: PAnsiChar; out pDesc: TD3D11_SHADER_INPUT_BIND_DESC): HResult; stdcall;
    // Use D3D_RETURN_PARAMETER_INDEX to get description of the return value.
    function GetFunctionParameter(ParameterIndex: Integer): ID3D11FunctionParameterReflection; stdcall;
  end;
{$INTERFACES com}
{$ELSE}

  ID3D11ShaderReflectionConstantBuffer = class;

  ID3D11ShaderReflectionType = class // Cannot use 'interface' as the QueryInterface, AddRef and Release methods are missing.
    function GetDesc(out pDesc: TD3D11_SHADER_TYPE_DESC): HResult; virtual; stdcall; abstract;
    function GetMemberTypeByIndex(Index: UINT): ID3D11ShaderReflectionType; virtual; stdcall; abstract;
    function GetMemberTypeByName(Name: PAnsiChar): ID3D11ShaderReflectionType; virtual; stdcall; abstract;
    function GetMemberTypeName(Index: UINT): PAnsiChar; virtual; stdcall; abstract;
    function IsEqual(pType: ID3D11ShaderReflectionType): HResult; virtual; stdcall; abstract;
    function GetSubType(): ID3D11ShaderReflectionType; virtual; stdcall; abstract;
    function GetBaseClass(): ID3D11ShaderReflectionType; virtual; stdcall; abstract;
    function GetNumInterfaces(): UINT; virtual; stdcall; abstract;
    function GetInterfaceByIndex(uIndex: UINT): ID3D11ShaderReflectionType; virtual; stdcall; abstract;
    function IsOfType(pType: ID3D11ShaderReflectionType): HResult; virtual; stdcall; abstract;
    function ImplementsInterface(pBase: ID3D11ShaderReflectionType): HResult; virtual; stdcall; abstract;
  end;

  ID3D11ShaderReflectionVariable = class // Cannot use 'interface' as the QueryInterface, AddRef and Release methods are missing.
    function GetDesc(out pDesc: TD3D11_SHADER_VARIABLE_DESC): HResult; virtual; stdcall; abstract;
    function GetType(): ID3D11ShaderReflectionType; virtual; stdcall; abstract;
    function GetBuffer(): ID3D11ShaderReflectionConstantBuffer; virtual; stdcall; abstract;
    function GetInterfaceSlot(uArrayIndex: UINT): UINT; virtual; stdcall; abstract;
  end;

  ID3D11ShaderReflectionConstantBuffer = class // Cannot use 'interface' as the QueryInterface, AddRef and Release methods are missing.
    function GetDesc(pDesc: TD3D11_SHADER_BUFFER_DESC): HResult; virtual; stdcall; abstract;
    function GetVariableByIndex(Index: UINT): ID3D11ShaderReflectionVariable; virtual; stdcall; abstract;
    function GetVariableByName(Name: PAnsiChar): ID3D11ShaderReflectionVariable; virtual; stdcall; abstract;
  end;

  ID3D11FunctionParameterReflection = class // Cannot use 'interface' as the QueryInterface, AddRef and Release methods are missing.
    function GetDesc(out pDesc: TD3D11_PARAMETER_DESC): HResult; virtual; stdcall; abstract;
  end;

  ID3D11FunctionReflection = class // Cannot use 'interface' as the QueryInterface, AddRef and Release methods are missing.
    function GetDesc(out pDesc: TD3D11_FUNCTION_DESC): HResult; virtual; stdcall; abstract;
    function GetConstantBufferByIndex(BufferIndex: UINT): ID3D11ShaderReflectionConstantBuffer; virtual; stdcall; abstract;
    function GetConstantBufferByName(Name: PAnsiChar): ID3D11ShaderReflectionConstantBuffer; virtual; stdcall; abstract;
    function GetResourceBindingDesc(ResourceIndex: UINT; out pDesc: TD3D11_SHADER_INPUT_BIND_DESC): HResult; virtual; stdcall; abstract;
    function GetVariableByName(Name: PAnsiChar): ID3D11ShaderReflectionVariable; virtual; stdcall; abstract;
    function GetResourceBindingDescByName(Name: PAnsiChar; out pDesc: TD3D11_SHADER_INPUT_BIND_DESC): HResult; virtual; stdcall; abstract;
    // Use D3D_RETURN_PARAMETER_INDEX to get description of the return value.
    function GetFunctionParameter(ParameterIndex: Integer): ID3D11FunctionParameterReflection; virtual; stdcall; abstract;
  end;
{$ENDIF}

  // The ID3D11ShaderReflection IID may change from SDK version to SDK version
  // if the reflection API changes.  This prevents new code with the new API
  // from working with an old binary.  Recompiling with the new header
  // will pick up the new IID.
  ID3D11ShaderReflection = interface(IUnknown)
    ['{8d536ca1-0cca-4956-a837-786963755584}']
    function GetDesc(out pDesc: TD3D11_SHADER_DESC): HResult; stdcall;
    function GetConstantBufferByIndex(Index: UINT): ID3D11ShaderReflectionConstantBuffer; stdcall;
    function GetConstantBufferByName(Name: PAnsiChar): ID3D11ShaderReflectionConstantBuffer; stdcall;
    function GetResourceBindingDesc(ResourceIndex: UINT; out pDesc: TD3D11_SHADER_INPUT_BIND_DESC): HResult; stdcall;
    function GetInputParameterDesc(ParameterIndex: UINT; out pDesc: TD3D11_SIGNATURE_PARAMETER_DESC): HResult; stdcall;
    function GetOutputParameterDesc(ParameterIndex: UINT; out pDesc: TD3D11_SIGNATURE_PARAMETER_DESC): HResult; stdcall;
    function GetPatchConstantParameterDesc(ParameterIndex: UINT; out pDesc: TD3D11_SIGNATURE_PARAMETER_DESC): HResult; stdcall;
    function GetVariableByName(Name: PAnsiChar): ID3D11ShaderReflectionVariable; stdcall;
    function GetResourceBindingDescByName(Name: PAnsiChar; out pDesc: TD3D11_SHADER_INPUT_BIND_DESC): HResult; stdcall;
    function GetMovInstructionCount(): UINT; stdcall;
    function GetMovcInstructionCount(): UINT; stdcall;
    function GetConversionInstructionCount(): UINT; stdcall;
    function GetBitwiseInstructionCount(): UINT; stdcall;
    function GetGSInputPrimitive(): TD3D_PRIMITIVE; stdcall;
    function IsSampleFrequencyShader(): LongBool; stdcall;
    function GetNumInterfaceSlots(): UINT; stdcall;
    function GetMinFeatureLevel(out pLevel: TD3D_FEATURE_LEVEL): HResult; stdcall;
    function GetThreadGroupSize(out pSizeX: UINT; out pSizeY: UINT; out pSizeZ: UINT): UINT; stdcall;
    function GetRequiresFlags(): UINT64; stdcall;
  end;

  ID3D11LibraryReflection = interface(IUnknown)
    ['{54384F1B-5B3E-4BB7-AE01-60BA3097CBB6}']
    function GetDesc(out pDesc: TD3D11_LIBRARY_DESC): HResult; stdcall;
    function GetFunctionByIndex(FunctionIndex: Integer): ID3D11FunctionReflection; stdcall;
  end;

  ID3D11ModuleInstance = interface;

  ID3D11Module = interface(IUnknown)
    ['{CAC701EE-80FC-4122-8242-10B39C8CEC34}']
    // Create an instance of a module for resource re-binding.
    function CreateInstance(pNamespace: PAnsiChar; out ppModuleInstance: ID3D11ModuleInstance): HResult; stdcall;
  end;

  ID3D11ModuleInstance = interface(IUnknown)
    ['{469E07F7-045A-48D5-AA12-68A478CDF75D}']
    // Resource binding API.
    function BindConstantBuffer(uSrcSlot: UINT; uDstSlot: UINT; cbDstOffset: UINT): HResult; stdcall;
    function BindConstantBufferByName(pName: PAnsiChar; uDstSlot: UINT; cbDstOffset: UINT): HResult; stdcall;
    function BindResource(uSrcSlot: UINT; uDstSlot: UINT; uCount: UINT): HResult; stdcall;
    function BindResourceByName(pName: PAnsiChar; uDstSlot: UINT; uCount: UINT): HResult; stdcall;
    function BindSampler(uSrcSlot: UINT; uDstSlot: UINT; uCount: UINT): HResult; stdcall;
    function BindSamplerByName(pName: PAnsiChar; uDstSlot: UINT; uCount: UINT): HResult; stdcall;
    function BindUnorderedAccessView(uSrcSlot: UINT; uDstSlot: UINT; uCount: UINT): HResult; stdcall;
    function BindUnorderedAccessViewByName(pName: PAnsiChar; uDstSlot: UINT; uCount: UINT): HResult; stdcall;
    function BindResourceAsUnorderedAccessView(uSrcSrvSlot: UINT; uDstUavSlot: UINT; uCount: UINT): HResult; stdcall;
    function BindResourceAsUnorderedAccessViewByName(pSrvName: PAnsiChar; uDstUavSlot: UINT; uCount: UINT): HResult; stdcall;
  end;

  ID3D11Linker = interface(IUnknown)
    ['{59A6CD0E-E10D-4C1F-88C0-63ABA1DAF30E}']
    // Link the shader and produce a shader blob suitable to D3D runtime.
    function Link(pEntry: ID3D11ModuleInstance; pEntryName: PAnsiChar; pTargetName: PAnsiChar; uFlags: UINT; out ppShaderBlob: ID3DBlob; out ppErrorBuffer: ID3DBlob): HResult; stdcall;
    // Add an instance of a library module to be used for linking.
    function UseLibrary(pLibraryMI: ID3D11ModuleInstance): HResult; stdcall;
    // Add a clip plane with the plane coefficients taken from a cbuffer entry for 10L9 shaders.
    function AddClipPlaneFromCBuffer(uCBufferSlot: UINT; uCBufferEntry: UINT): HResult; stdcall;
  end;

  ID3D11LinkingNode = interface(IUnknown)
    ['{D80DD70C-8D2F-4751-94A1-03C79B3556DB}']
  end;

  ID3D11FunctionLinkingGraph = interface(IUnknown)
    ['{54133220-1CE8-43D3-8236-9855C5CEECFF}']
    // Create a shader module out of FLG description.
    function CreateModuleInstance(out ppModuleInstance: ID3D11ModuleInstance; out ppErrorBuffer: ID3DBlob): HResult; stdcall;
    function SetInputSignature(pInputParameters: PD3D11_PARAMETER_DESC; cInputParameters: UINT; out ppInputNode: ID3D11LinkingNode): HResult; stdcall;
    function SetOutputSignature(pOutputParameters: PD3D11_PARAMETER_DESC; cOutputParameters: UINT; out ppOutputNode: ID3D11LinkingNode): HResult; stdcall;
    function CallFunction(pModuleInstanceNamespace: PAnsiChar; pModuleWithFunctionPrototype: ID3D11Module; pFunctionName: PAnsiChar; out ppCallNode: ID3D11LinkingNode): HResult; stdcall;
    function PassValue(pSrcNode: ID3D11LinkingNode; SrcParameterIndex: Integer; pDstNode: ID3D11LinkingNode; DstParameterIndex: Integer): HResult; stdcall;
    function PassValueWithSwizzle(pSrcNode: ID3D11LinkingNode; SrcParameterIndex: Integer; pSrcSwizzle: PAnsiChar; pDstNode: ID3D11LinkingNode; DstParameterIndex: Integer; pDstSwizzle: PAnsiChar): HResult; stdcall;
    function GetLastError(out ppErrorBuffer: ID3DBlob): HResult; stdcall;
    function GenerateHlsl(uFlags: UINT; out ppBuffer: ID3DBlob): HResult; stdcall;
  end;

  { D3D11ShaderTracing.h }
  TD3D11_SHADER_TYPE          = (D3D11_VERTEX_SHADER = 1, D3D11_HULL_SHADER = 2, D3D11_DOMAIN_SHADER = 3, D3D11_GEOMETRY_SHADER = 4, D3D11_PIXEL_SHADER = 5, D3D11_COMPUTE_SHADER = 6);
  TD3D11_TRACE_COMPONENT_MASK = UINT8;

  TD3D11_VERTEX_SHADER_TRACE_DESC = record
    Invocation: UINT64;
  end;

  TD3D11_HULL_SHADER_TRACE_DESC = record
    Invocation: UINT64;
  end;

  TD3D11_DOMAIN_SHADER_TRACE_DESC = record
    Invocation: UINT64;
  end;

  TD3D11_GEOMETRY_SHADER_TRACE_DESC = record
    Invocation: UINT64;
  end;

  TD3D11_PIXEL_SHADER_TRACE_DESC = record
    Invocation: UINT64;
    X: Integer;
    Y: Integer;
    SampleMask: UINT64;
  end;

  TD3D11_COMPUTE_SHADER_TRACE_DESC = record
    Invocation: UINT64;
    ThreadIDInGroup: array [0 .. 2] of UINT;
    ThreadGroupID: array [0 .. 2] of UINT;
  end;

  TD3D11_SHADER_TRACE_DESC = record
    _Type: TD3D11_SHADER_TYPE;
    Flags: UINT;
    case Integer of
      0:
        (VertexShaderTraceDesc: TD3D11_VERTEX_SHADER_TRACE_DESC;);
      1:
        (HullShaderTraceDesc: TD3D11_HULL_SHADER_TRACE_DESC;);
      2:
        (DomainShaderTraceDesc: TD3D11_DOMAIN_SHADER_TRACE_DESC;);
      3:
        (GeometryShaderTraceDesc: TD3D11_GEOMETRY_SHADER_TRACE_DESC;);
      4:
        (PixelShaderTraceDesc: TD3D11_PIXEL_SHADER_TRACE_DESC;);
      5:
        (ComputeShaderTraceDesc: TD3D11_COMPUTE_SHADER_TRACE_DESC;);
  end;

  PD3D11_SHADER_TRACE_DESC        = ^TD3D11_SHADER_TRACE_DESC;
  TD3D11_TRACE_GS_INPUT_PRIMITIVE = (D3D11_TRACE_GS_INPUT_PRIMITIVE_UNDEFINED = 0, D3D11_TRACE_GS_INPUT_PRIMITIVE_POINT = 1, D3D11_TRACE_GS_INPUT_PRIMITIVE_LINE = 2, D3D11_TRACE_GS_INPUT_PRIMITIVE_TRIANGLE = 3, D3D11_TRACE_GS_INPUT_PRIMITIVE_LINE_ADJ = 6, D3D11_TRACE_GS_INPUT_PRIMITIVE_TRIANGLE_ADJ = 7);

  TD3D11_TRACE_STATS = record
    TraceDesc: TD3D11_SHADER_TRACE_DESC;
    NumInvocationsInStamp: UINT8;
    TargetStampIndex: UINT8;
    NumTraceSteps: UINT;
    InputMask: array [0 .. 31] of TD3D11_TRACE_COMPONENT_MASK;
    OutputMask: array [0 .. 31] of TD3D11_TRACE_COMPONENT_MASK;
    NumTemps: UINT16;
    MaxIndexableTempIndex: UINT16;
    IndexableTempSize: array [0 .. 4095] of UINT16;
    ImmediateConstantBufferSize: UINT16;
    PixelPosition: array [0 .. 3, 0 .. 1] of UINT;
    PixelCoverageMask: array [0 .. 3] of UINT64;
    PixelDiscardedMask: array [0 .. 3] of UINT64;
    PixelCoverageMaskAfterShader: array [0 .. 3] of UINT64;
    PixelCoverageMaskAfterA2CSampleMask: array [0 .. 3] of UINT64;
    PixelCoverageMaskAfterA2CSampleMaskDepth: array [0 .. 3] of UINT64;
    PixelCoverageMaskAfterA2CSampleMaskDepthStencil: array [0 .. 3] of UINT64;
    PSOutputsDepth: LongBool;
    PSOutputsMask: LongBool;
    GSInputPrimitive: TD3D11_TRACE_GS_INPUT_PRIMITIVE;
    GSInputsPrimitiveID: LongBool;
    HSOutputPatchConstantMask: array [0 .. 31] of TD3D11_TRACE_COMPONENT_MASK;
    DSInputPatchConstantMask: array [0 .. 31] of TD3D11_TRACE_COMPONENT_MASK;
  end;

  TD3D11_TRACE_VALUE = record
    Bits: array [0 .. 3] of UINT;
    ValidMask: TD3D11_TRACE_COMPONENT_MASK;
  end;

  TD3D11_TRACE_REGISTER_TYPE = (D3D11_TRACE_OUTPUT_NULL_REGISTER = 0, D3D11_TRACE_INPUT_REGISTER = (D3D11_TRACE_OUTPUT_NULL_REGISTER + 1), D3D11_TRACE_INPUT_PRIMITIVE_ID_REGISTER = (D3D11_TRACE_INPUT_REGISTER + 1), D3D11_TRACE_IMMEDIATE_CONSTANT_BUFFER = (D3D11_TRACE_INPUT_PRIMITIVE_ID_REGISTER + 1), D3D11_TRACE_TEMP_REGISTER = (D3D11_TRACE_IMMEDIATE_CONSTANT_BUFFER + 1),
    D3D11_TRACE_INDEXABLE_TEMP_REGISTER = (D3D11_TRACE_TEMP_REGISTER + 1), D3D11_TRACE_OUTPUT_REGISTER = (D3D11_TRACE_INDEXABLE_TEMP_REGISTER + 1), D3D11_TRACE_OUTPUT_DEPTH_REGISTER = (D3D11_TRACE_OUTPUT_REGISTER + 1), D3D11_TRACE_CONSTANT_BUFFER = (D3D11_TRACE_OUTPUT_DEPTH_REGISTER + 1), D3D11_TRACE_IMMEDIATE32 = (D3D11_TRACE_CONSTANT_BUFFER + 1),
    D3D11_TRACE_SAMPLER = (D3D11_TRACE_IMMEDIATE32 + 1), D3D11_TRACE_RESOURCE = (D3D11_TRACE_SAMPLER + 1), D3D11_TRACE_RASTERIZER = (D3D11_TRACE_RESOURCE + 1), D3D11_TRACE_OUTPUT_COVERAGE_MASK = (D3D11_TRACE_RASTERIZER + 1), D3D11_TRACE_STREAM = (D3D11_TRACE_OUTPUT_COVERAGE_MASK + 1), D3D11_TRACE_THIS_POINTER = (D3D11_TRACE_STREAM + 1),
    D3D11_TRACE_OUTPUT_CONTROL_POINT_ID_REGISTER = (D3D11_TRACE_THIS_POINTER + 1), D3D11_TRACE_INPUT_FORK_INSTANCE_ID_REGISTER = (D3D11_TRACE_OUTPUT_CONTROL_POINT_ID_REGISTER + 1), D3D11_TRACE_INPUT_JOIN_INSTANCE_ID_REGISTER = (D3D11_TRACE_INPUT_FORK_INSTANCE_ID_REGISTER + 1), D3D11_TRACE_INPUT_CONTROL_POINT_REGISTER = (D3D11_TRACE_INPUT_JOIN_INSTANCE_ID_REGISTER + 1),
    D3D11_TRACE_OUTPUT_CONTROL_POINT_REGISTER = (D3D11_TRACE_INPUT_CONTROL_POINT_REGISTER + 1), D3D11_TRACE_INPUT_PATCH_CONSTANT_REGISTER = (D3D11_TRACE_OUTPUT_CONTROL_POINT_REGISTER + 1), D3D11_TRACE_INPUT_DOMAIN_POINT_REGISTER = (D3D11_TRACE_INPUT_PATCH_CONSTANT_REGISTER + 1), D3D11_TRACE_UNORDERED_ACCESS_VIEW = (D3D11_TRACE_INPUT_DOMAIN_POINT_REGISTER + 1),
    D3D11_TRACE_THREAD_GROUP_SHARED_MEMORY = (D3D11_TRACE_UNORDERED_ACCESS_VIEW + 1), D3D11_TRACE_INPUT_THREAD_ID_REGISTER = (D3D11_TRACE_THREAD_GROUP_SHARED_MEMORY + 1), D3D11_TRACE_INPUT_THREAD_GROUP_ID_REGISTER = (D3D11_TRACE_INPUT_THREAD_ID_REGISTER + 1), D3D11_TRACE_INPUT_THREAD_ID_IN_GROUP_REGISTER = (D3D11_TRACE_INPUT_THREAD_GROUP_ID_REGISTER + 1),
    D3D11_TRACE_INPUT_COVERAGE_MASK_REGISTER = (D3D11_TRACE_INPUT_THREAD_ID_IN_GROUP_REGISTER + 1), D3D11_TRACE_INPUT_THREAD_ID_IN_GROUP_FLATTENED_REGISTER = (D3D11_TRACE_INPUT_COVERAGE_MASK_REGISTER + 1), D3D11_TRACE_INPUT_GS_INSTANCE_ID_REGISTER = (D3D11_TRACE_INPUT_THREAD_ID_IN_GROUP_FLATTENED_REGISTER + 1),
    D3D11_TRACE_OUTPUT_DEPTH_GREATER_EQUAL_REGISTER = (D3D11_TRACE_INPUT_GS_INSTANCE_ID_REGISTER + 1), D3D11_TRACE_OUTPUT_DEPTH_LESS_EQUAL_REGISTER = (D3D11_TRACE_OUTPUT_DEPTH_GREATER_EQUAL_REGISTER + 1), D3D11_TRACE_IMMEDIATE64 = (D3D11_TRACE_OUTPUT_DEPTH_LESS_EQUAL_REGISTER + 1), D3D11_TRACE_INPUT_CYCLE_COUNTER_REGISTER = (D3D11_TRACE_IMMEDIATE64 + 1),
    D3D11_TRACE_INTERFACE_POINTER = (D3D11_TRACE_INPUT_CYCLE_COUNTER_REGISTER + 1));

  TD3D11_TRACE_REGISTER = record
    RegType: TD3D11_TRACE_REGISTER_TYPE;
    Index1D: UINT16;
    Index2D: UINT16;
    OperandIndex: UINT8;
    Flags: UINT8;
  end;

  PD3D11_TRACE_REGISTER             = ^TD3D11_TRACE_REGISTER;
  TD3D11_TRACE_MISC_OPERATIONS_MASK = UINT16;

  TD3D11_TRACE_STEP = record
    ID: UINT;
    InstructionActive: LongBool;
    NumRegistersWritten: UINT8;
    NumRegistersRead: UINT8;
    MiscOperations: TD3D11_TRACE_MISC_OPERATIONS_MASK;
    OpcodeType: UINT;
    CurrentGlobalCycle: UINT64;
  end;

  ID3D11ShaderTrace = interface(IUnknown)
    ['{36b013e6-2811-4845-baa7-d623fe0df104}']
    function TraceReady(out pTestCount: UINT64): HResult; stdcall;
    procedure ResetTrace(); stdcall;
    function GetTraceStats(out pTraceStats: TD3D11_TRACE_STATS): HResult; stdcall;
    function PSSelectStamp(stampIndex: UINT): HResult; stdcall;
    function GetInitialRegisterContents(pRegister: PD3D11_TRACE_REGISTER; out pValue: TD3D11_TRACE_VALUE): HResult; stdcall;
    function GetStep(stepIndex: UINT; out pTraceStep: TD3D11_TRACE_STEP): HResult; stdcall;
    function GetWrittenRegister(stepIndex: UINT; writtenRegisterIndex: UINT; out pRegister: TD3D11_TRACE_REGISTER; out pValue: TD3D11_TRACE_VALUE): HResult; stdcall;
    function GetReadRegister(stepIndex: UINT; readRegisterIndex: UINT; out pRegister: TD3D11_TRACE_REGISTER; out pValue: TD3D11_TRACE_VALUE): HResult; stdcall;
  end;

  ID3D11ShaderTraceFactory = interface(IUnknown)
    ['{1fbad429-66ab-41cc-9617-667ac10e4459}']
    function CreateShaderTrace(pShader: IUnknown; pTraceDesc: PD3D11_SHADER_TRACE_DESC; out ppShaderTrace: ID3D11ShaderTrace): HResult; stdcall;
  end;

  { D3D11SDKLayers.h }
  TD3D11_RLDO_FLAGS = (D3D11_RLDO_SUMMARY = $1, D3D11_RLDO_DETAIL = $2, D3D11_RLDO_IGNORE_INTERNAL = $4);

  ID3D11Debug = interface(IUnknown)
    ['{79cf2233-7536-4948-9d36-1e4692dc5760}']
    function SetFeatureMask(Mask: UINT): HResult; stdcall;
    function GetFeatureMask(): UINT; stdcall;
    function SetPresentPerRenderOpDelay(Milliseconds: UINT): HResult; stdcall;
    function GetPresentPerRenderOpDelay(): UINT; stdcall;
    function SetSwapChain(pSwapChain: IDXGISwapChain): HResult; stdcall;
    function GetSwapChain(out ppSwapChain: IDXGISwapChain): HResult; stdcall;
    function ValidateContext(pContext: ID3D11DeviceContext): HResult; stdcall;
    function ReportLiveDeviceObjects(Flags: TD3D11_RLDO_FLAGS): HResult; stdcall;
    function ValidateContextForDispatch(pContext: ID3D11DeviceContext): HResult; stdcall;
  end;

  ID3D11SwitchToRef = interface(IUnknown)
    ['{1ef337e3-58e7-4f83-a692-db221f5ed47e}']
    function SetUseRef(UseRef: LongBool): LongBool; stdcall;
    function GetUseRef(): LongBool; stdcall;
  end;

  TD3D11_SHADER_TRACKING_RESOURCE_TYPE = (D3D11_SHADER_TRACKING_RESOURCE_TYPE_NONE = 0, D3D11_SHADER_TRACKING_RESOURCE_TYPE_UAV_DEVICEMEMORY = 1, D3D11_SHADER_TRACKING_RESOURCE_TYPE_NON_UAV_DEVICEMEMORY = 2, D3D11_SHADER_TRACKING_RESOURCE_TYPE_ALL_DEVICEMEMORY = 3, D3D11_SHADER_TRACKING_RESOURCE_TYPE_GROUPSHARED_MEMORY = 4, D3D11_SHADER_TRACKING_RESOURCE_TYPE_ALL_SHARED_MEMORY = 5,
    D3D11_SHADER_TRACKING_RESOURCE_TYPE_GROUPSHARED_NON_UAV = 6, D3D11_SHADER_TRACKING_RESOURCE_TYPE_ALL = 7);
  TD3D11_SHADER_TRACKING_OPTION = (D3D11_SHADER_TRACKING_OPTION_IGNORE = 0, D3D11_SHADER_TRACKING_OPTION_TRACK_UNINITIALIZED = $1, D3D11_SHADER_TRACKING_OPTION_TRACK_RAW = $2, D3D11_SHADER_TRACKING_OPTION_TRACK_WAR = $4, D3D11_SHADER_TRACKING_OPTION_TRACK_WAW = $8, D3D11_SHADER_TRACKING_OPTION_ALLOW_SAME = $10, D3D11_SHADER_TRACKING_OPTION_TRACK_ATOMIC_CONSISTENCY = $20,
    D3D11_SHADER_TRACKING_OPTION_TRACK_RAW_ACROSS_THREADGROUPS = $40, D3D11_SHADER_TRACKING_OPTION_TRACK_WAR_ACROSS_THREADGROUPS = $80, D3D11_SHADER_TRACKING_OPTION_TRACK_WAW_ACROSS_THREADGROUPS = $100, D3D11_SHADER_TRACKING_OPTION_TRACK_ATOMIC_CONSISTENCY_ACROSS_THREADGROUPS = $200,
    D3D11_SHADER_TRACKING_OPTION_UAV_SPECIFIC_FLAGS = Ord(D3D11_SHADER_TRACKING_OPTION_TRACK_RAW_ACROSS_THREADGROUPS) or Ord(D3D11_SHADER_TRACKING_OPTION_TRACK_WAR_ACROSS_THREADGROUPS) or Ord(D3D11_SHADER_TRACKING_OPTION_TRACK_WAW_ACROSS_THREADGROUPS) or Ord(D3D11_SHADER_TRACKING_OPTION_TRACK_ATOMIC_CONSISTENCY_ACROSS_THREADGROUPS),
    D3D11_SHADER_TRACKING_OPTION_ALL_HAZARDS = Ord(D3D11_SHADER_TRACKING_OPTION_TRACK_RAW) or Ord(D3D11_SHADER_TRACKING_OPTION_TRACK_WAR) or Ord(D3D11_SHADER_TRACKING_OPTION_TRACK_WAW) or Ord(D3D11_SHADER_TRACKING_OPTION_TRACK_ATOMIC_CONSISTENCY) or Ord(D3D11_SHADER_TRACKING_OPTION_TRACK_RAW_ACROSS_THREADGROUPS) or Ord(D3D11_SHADER_TRACKING_OPTION_TRACK_WAR_ACROSS_THREADGROUPS) or
    Ord(D3D11_SHADER_TRACKING_OPTION_TRACK_WAW_ACROSS_THREADGROUPS) or Ord(D3D11_SHADER_TRACKING_OPTION_TRACK_ATOMIC_CONSISTENCY_ACROSS_THREADGROUPS), D3D11_SHADER_TRACKING_OPTION_ALL_HAZARDS_ALLOWING_SAME = Ord(D3D11_SHADER_TRACKING_OPTION_ALL_HAZARDS) or Ord(D3D11_SHADER_TRACKING_OPTION_ALLOW_SAME),
    D3D11_SHADER_TRACKING_OPTION_ALL_OPTIONS = Ord(D3D11_SHADER_TRACKING_OPTION_ALL_HAZARDS_ALLOWING_SAME) or Ord(D3D11_SHADER_TRACKING_OPTION_TRACK_UNINITIALIZED));

  ID3D11TracingDevice = interface(IUnknown)
    ['{1911c771-1587-413e-a7e0-fb26c3de0268}']
    function SetShaderTrackingOptionsByType(ResourceTypeFlags: UINT; Options: UINT): HResult; stdcall;
    function SetShaderTrackingOptions(pShader: IUnknown; Options: UINT): HResult; stdcall;
  end;

  ID3D11RefTrackingOptions = interface(IUnknown)
    ['{193dacdf-0db2-4c05-a55c-ef06cac56fd9}']
    function SetTrackingOptions(uOptions: UINT): HResult; stdcall;
  end;

  ID3D11RefDefaultTrackingOptions = interface(IUnknown)
    ['{03916615-c644-418c-9bf4-75db5be63ca0}']
    function SetTrackingOptions(ResourceTypeFlags: UINT; Options: UINT): HResult; stdcall;
  end;

  TD3D11_MESSAGE_CATEGORY = (D3D11_MESSAGE_CATEGORY_APPLICATION_DEFINED = 0, D3D11_MESSAGE_CATEGORY_MISCELLANEOUS = (D3D11_MESSAGE_CATEGORY_APPLICATION_DEFINED + 1), D3D11_MESSAGE_CATEGORY_INITIALIZATION = (D3D11_MESSAGE_CATEGORY_MISCELLANEOUS + 1), D3D11_MESSAGE_CATEGORY_CLEANUP = (D3D11_MESSAGE_CATEGORY_INITIALIZATION + 1),
    D3D11_MESSAGE_CATEGORY_COMPILATION = (D3D11_MESSAGE_CATEGORY_CLEANUP + 1), D3D11_MESSAGE_CATEGORY_STATE_CREATION = (D3D11_MESSAGE_CATEGORY_COMPILATION + 1), D3D11_MESSAGE_CATEGORY_STATE_SETTING = (D3D11_MESSAGE_CATEGORY_STATE_CREATION + 1), D3D11_MESSAGE_CATEGORY_STATE_GETTING = (D3D11_MESSAGE_CATEGORY_STATE_SETTING + 1),
    D3D11_MESSAGE_CATEGORY_RESOURCE_MANIPULATION = (D3D11_MESSAGE_CATEGORY_STATE_GETTING + 1), D3D11_MESSAGE_CATEGORY_EXECUTION = (D3D11_MESSAGE_CATEGORY_RESOURCE_MANIPULATION + 1), D3D11_MESSAGE_CATEGORY_SHADER = (D3D11_MESSAGE_CATEGORY_EXECUTION + 1));
  PD3D11_MESSAGE_CATEGORY = ^TD3D11_MESSAGE_CATEGORY;
  TD3D11_MESSAGE_SEVERITY = (D3D11_MESSAGE_SEVERITY_CORRUPTION = 0, D3D11_MESSAGE_SEVERITY_ERROR = (D3D11_MESSAGE_SEVERITY_CORRUPTION + 1), D3D11_MESSAGE_SEVERITY_WARNING = (D3D11_MESSAGE_SEVERITY_ERROR + 1), D3D11_MESSAGE_SEVERITY_INFO = (D3D11_MESSAGE_SEVERITY_WARNING + 1), D3D11_MESSAGE_SEVERITY_MESSAGE = (D3D11_MESSAGE_SEVERITY_INFO + 1));
  PD3D11_MESSAGE_SEVERITY = ^TD3D11_MESSAGE_SEVERITY;
  TD3D11_MESSAGE_ID       = (D3D11_MESSAGE_ID_UNKNOWN = 0, D3D11_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_HAZARD = (D3D11_MESSAGE_ID_UNKNOWN + 1), D3D11_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_HAZARD = (D3D11_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_HAZARD + 1), D3D11_MESSAGE_ID_DEVICE_VSSETSHADERRESOURCES_HAZARD = (D3D11_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_HAZARD + 1),
    D3D11_MESSAGE_ID_DEVICE_VSSETCONSTANTBUFFERS_HAZARD = (D3D11_MESSAGE_ID_DEVICE_VSSETSHADERRESOURCES_HAZARD + 1), D3D11_MESSAGE_ID_DEVICE_GSSETSHADERRESOURCES_HAZARD = (D3D11_MESSAGE_ID_DEVICE_VSSETCONSTANTBUFFERS_HAZARD + 1), D3D11_MESSAGE_ID_DEVICE_GSSETCONSTANTBUFFERS_HAZARD = (D3D11_MESSAGE_ID_DEVICE_GSSETSHADERRESOURCES_HAZARD + 1),
    D3D11_MESSAGE_ID_DEVICE_PSSETSHADERRESOURCES_HAZARD = (D3D11_MESSAGE_ID_DEVICE_GSSETCONSTANTBUFFERS_HAZARD + 1), D3D11_MESSAGE_ID_DEVICE_PSSETCONSTANTBUFFERS_HAZARD = (D3D11_MESSAGE_ID_DEVICE_PSSETSHADERRESOURCES_HAZARD + 1), D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETS_HAZARD = (D3D11_MESSAGE_ID_DEVICE_PSSETCONSTANTBUFFERS_HAZARD + 1),
    D3D11_MESSAGE_ID_DEVICE_SOSETTARGETS_HAZARD = (D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETS_HAZARD + 1), D3D11_MESSAGE_ID_STRING_FROM_APPLICATION = (D3D11_MESSAGE_ID_DEVICE_SOSETTARGETS_HAZARD + 1), D3D11_MESSAGE_ID_CORRUPTED_THIS = (D3D11_MESSAGE_ID_STRING_FROM_APPLICATION + 1), D3D11_MESSAGE_ID_CORRUPTED_PARAMETER1 = (D3D11_MESSAGE_ID_CORRUPTED_THIS + 1),
    D3D11_MESSAGE_ID_CORRUPTED_PARAMETER2 = (D3D11_MESSAGE_ID_CORRUPTED_PARAMETER1 + 1), D3D11_MESSAGE_ID_CORRUPTED_PARAMETER3 = (D3D11_MESSAGE_ID_CORRUPTED_PARAMETER2 + 1), D3D11_MESSAGE_ID_CORRUPTED_PARAMETER4 = (D3D11_MESSAGE_ID_CORRUPTED_PARAMETER3 + 1), D3D11_MESSAGE_ID_CORRUPTED_PARAMETER5 = (D3D11_MESSAGE_ID_CORRUPTED_PARAMETER4 + 1),
    D3D11_MESSAGE_ID_CORRUPTED_PARAMETER6 = (D3D11_MESSAGE_ID_CORRUPTED_PARAMETER5 + 1), D3D11_MESSAGE_ID_CORRUPTED_PARAMETER7 = (D3D11_MESSAGE_ID_CORRUPTED_PARAMETER6 + 1), D3D11_MESSAGE_ID_CORRUPTED_PARAMETER8 = (D3D11_MESSAGE_ID_CORRUPTED_PARAMETER7 + 1), D3D11_MESSAGE_ID_CORRUPTED_PARAMETER9 = (D3D11_MESSAGE_ID_CORRUPTED_PARAMETER8 + 1),
    D3D11_MESSAGE_ID_CORRUPTED_PARAMETER10 = (D3D11_MESSAGE_ID_CORRUPTED_PARAMETER9 + 1), D3D11_MESSAGE_ID_CORRUPTED_PARAMETER11 = (D3D11_MESSAGE_ID_CORRUPTED_PARAMETER10 + 1), D3D11_MESSAGE_ID_CORRUPTED_PARAMETER12 = (D3D11_MESSAGE_ID_CORRUPTED_PARAMETER11 + 1), D3D11_MESSAGE_ID_CORRUPTED_PARAMETER13 = (D3D11_MESSAGE_ID_CORRUPTED_PARAMETER12 + 1),
    D3D11_MESSAGE_ID_CORRUPTED_PARAMETER14 = (D3D11_MESSAGE_ID_CORRUPTED_PARAMETER13 + 1), D3D11_MESSAGE_ID_CORRUPTED_PARAMETER15 = (D3D11_MESSAGE_ID_CORRUPTED_PARAMETER14 + 1), D3D11_MESSAGE_ID_CORRUPTED_MULTITHREADING = (D3D11_MESSAGE_ID_CORRUPTED_PARAMETER15 + 1), D3D11_MESSAGE_ID_MESSAGE_REPORTING_OUTOFMEMORY = (D3D11_MESSAGE_ID_CORRUPTED_MULTITHREADING + 1),
    D3D11_MESSAGE_ID_IASETINPUTLAYOUT_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_MESSAGE_REPORTING_OUTOFMEMORY + 1), D3D11_MESSAGE_ID_IASETVERTEXBUFFERS_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_IASETINPUTLAYOUT_UNBINDDELETINGOBJECT + 1), D3D11_MESSAGE_ID_IASETINDEXBUFFER_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_IASETVERTEXBUFFERS_UNBINDDELETINGOBJECT + 1),
    D3D11_MESSAGE_ID_VSSETSHADER_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_IASETINDEXBUFFER_UNBINDDELETINGOBJECT + 1), D3D11_MESSAGE_ID_VSSETSHADERRESOURCES_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_VSSETSHADER_UNBINDDELETINGOBJECT + 1), D3D11_MESSAGE_ID_VSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_VSSETSHADERRESOURCES_UNBINDDELETINGOBJECT + 1),
    D3D11_MESSAGE_ID_VSSETSAMPLERS_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_VSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT + 1), D3D11_MESSAGE_ID_GSSETSHADER_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_VSSETSAMPLERS_UNBINDDELETINGOBJECT + 1), D3D11_MESSAGE_ID_GSSETSHADERRESOURCES_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_GSSETSHADER_UNBINDDELETINGOBJECT + 1),
    D3D11_MESSAGE_ID_GSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_GSSETSHADERRESOURCES_UNBINDDELETINGOBJECT + 1), D3D11_MESSAGE_ID_GSSETSAMPLERS_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_GSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT + 1), D3D11_MESSAGE_ID_SOSETTARGETS_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_GSSETSAMPLERS_UNBINDDELETINGOBJECT + 1),
    D3D11_MESSAGE_ID_PSSETSHADER_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_SOSETTARGETS_UNBINDDELETINGOBJECT + 1), D3D11_MESSAGE_ID_PSSETSHADERRESOURCES_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_PSSETSHADER_UNBINDDELETINGOBJECT + 1), D3D11_MESSAGE_ID_PSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_PSSETSHADERRESOURCES_UNBINDDELETINGOBJECT + 1),
    D3D11_MESSAGE_ID_PSSETSAMPLERS_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_PSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT + 1), D3D11_MESSAGE_ID_RSSETSTATE_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_PSSETSAMPLERS_UNBINDDELETINGOBJECT + 1), D3D11_MESSAGE_ID_OMSETBLENDSTATE_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_RSSETSTATE_UNBINDDELETINGOBJECT + 1),
    D3D11_MESSAGE_ID_OMSETDEPTHSTENCILSTATE_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_OMSETBLENDSTATE_UNBINDDELETINGOBJECT + 1), D3D11_MESSAGE_ID_OMSETRENDERTARGETS_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_OMSETDEPTHSTENCILSTATE_UNBINDDELETINGOBJECT + 1), D3D11_MESSAGE_ID_SETPREDICATION_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_OMSETRENDERTARGETS_UNBINDDELETINGOBJECT + 1),
    D3D11_MESSAGE_ID_GETPRIVATEDATA_MOREDATA = (D3D11_MESSAGE_ID_SETPREDICATION_UNBINDDELETINGOBJECT + 1), D3D11_MESSAGE_ID_SETPRIVATEDATA_INVALIDFREEDATA = (D3D11_MESSAGE_ID_GETPRIVATEDATA_MOREDATA + 1), D3D11_MESSAGE_ID_SETPRIVATEDATA_INVALIDIUNKNOWN = (D3D11_MESSAGE_ID_SETPRIVATEDATA_INVALIDFREEDATA + 1),
    D3D11_MESSAGE_ID_SETPRIVATEDATA_INVALIDFLAGS = (D3D11_MESSAGE_ID_SETPRIVATEDATA_INVALIDIUNKNOWN + 1), D3D11_MESSAGE_ID_SETPRIVATEDATA_CHANGINGPARAMS = (D3D11_MESSAGE_ID_SETPRIVATEDATA_INVALIDFLAGS + 1), D3D11_MESSAGE_ID_SETPRIVATEDATA_OUTOFMEMORY = (D3D11_MESSAGE_ID_SETPRIVATEDATA_CHANGINGPARAMS + 1),
    D3D11_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDFORMAT = (D3D11_MESSAGE_ID_SETPRIVATEDATA_OUTOFMEMORY + 1), D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDSAMPLES = (D3D11_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDFORMAT + 1), D3D11_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDUSAGE = (D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDSAMPLES + 1),
    D3D11_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDBINDFLAGS = (D3D11_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDUSAGE + 1), D3D11_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDCPUACCESSFLAGS = (D3D11_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDBINDFLAGS + 1), D3D11_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDMISCFLAGS = (D3D11_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDCPUACCESSFLAGS + 1),
    D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDCPUACCESSFLAGS = (D3D11_MESSAGE_ID_CREATEBUFFER_UNRECOGNIZEDMISCFLAGS + 1), D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDBINDFLAGS = (D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDCPUACCESSFLAGS + 1), D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDINITIALDATA = (D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDBINDFLAGS + 1),
    D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDDIMENSIONS = (D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDINITIALDATA + 1), D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDMIPLEVELS = (D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDDIMENSIONS + 1), D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDMISCFLAGS = (D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDMIPLEVELS + 1),
    D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDARG_RETURN = (D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDMISCFLAGS + 1), D3D11_MESSAGE_ID_CREATEBUFFER_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDARG_RETURN + 1), D3D11_MESSAGE_ID_CREATEBUFFER_NULLDESC = (D3D11_MESSAGE_ID_CREATEBUFFER_OUTOFMEMORY_RETURN + 1),
    D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDCONSTANTBUFFERBINDINGS = (D3D11_MESSAGE_ID_CREATEBUFFER_NULLDESC + 1), D3D11_MESSAGE_ID_CREATEBUFFER_LARGEALLOCATION = (D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDCONSTANTBUFFERBINDINGS + 1), D3D11_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDFORMAT = (D3D11_MESSAGE_ID_CREATEBUFFER_LARGEALLOCATION + 1),
    D3D11_MESSAGE_ID_CREATETEXTURE1D_UNSUPPORTEDFORMAT = (D3D11_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDFORMAT + 1), D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDSAMPLES = (D3D11_MESSAGE_ID_CREATETEXTURE1D_UNSUPPORTEDFORMAT + 1), D3D11_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDUSAGE = (D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDSAMPLES + 1),
    D3D11_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDBINDFLAGS = (D3D11_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDUSAGE + 1), D3D11_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDCPUACCESSFLAGS = (D3D11_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDBINDFLAGS + 1), D3D11_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDMISCFLAGS = (D3D11_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDCPUACCESSFLAGS + 1),
    D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDCPUACCESSFLAGS = (D3D11_MESSAGE_ID_CREATETEXTURE1D_UNRECOGNIZEDMISCFLAGS + 1), D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDBINDFLAGS = (D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDCPUACCESSFLAGS + 1), D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDINITIALDATA = (D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDBINDFLAGS + 1),
    D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDDIMENSIONS = (D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDINITIALDATA + 1), D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDMIPLEVELS = (D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDDIMENSIONS + 1), D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDMISCFLAGS = (D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDMIPLEVELS + 1),
    D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDARG_RETURN = (D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDMISCFLAGS + 1), D3D11_MESSAGE_ID_CREATETEXTURE1D_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDARG_RETURN + 1), D3D11_MESSAGE_ID_CREATETEXTURE1D_NULLDESC = (D3D11_MESSAGE_ID_CREATETEXTURE1D_OUTOFMEMORY_RETURN + 1),
    D3D11_MESSAGE_ID_CREATETEXTURE1D_LARGEALLOCATION = (D3D11_MESSAGE_ID_CREATETEXTURE1D_NULLDESC + 1), D3D11_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDFORMAT = (D3D11_MESSAGE_ID_CREATETEXTURE1D_LARGEALLOCATION + 1), D3D11_MESSAGE_ID_CREATETEXTURE2D_UNSUPPORTEDFORMAT = (D3D11_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDFORMAT + 1),
    D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDSAMPLES = (D3D11_MESSAGE_ID_CREATETEXTURE2D_UNSUPPORTEDFORMAT + 1), D3D11_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDUSAGE = (D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDSAMPLES + 1), D3D11_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDBINDFLAGS = (D3D11_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDUSAGE + 1),
    D3D11_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDCPUACCESSFLAGS = (D3D11_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDBINDFLAGS + 1), D3D11_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDMISCFLAGS = (D3D11_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDCPUACCESSFLAGS + 1), D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDCPUACCESSFLAGS = (D3D11_MESSAGE_ID_CREATETEXTURE2D_UNRECOGNIZEDMISCFLAGS + 1),
    D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDBINDFLAGS = (D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDCPUACCESSFLAGS + 1), D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDINITIALDATA = (D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDBINDFLAGS + 1), D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDDIMENSIONS = (D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDINITIALDATA + 1),
    D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDMIPLEVELS = (D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDDIMENSIONS + 1), D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDMISCFLAGS = (D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDMIPLEVELS + 1), D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDARG_RETURN = (D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDMISCFLAGS + 1),
    D3D11_MESSAGE_ID_CREATETEXTURE2D_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDARG_RETURN + 1), D3D11_MESSAGE_ID_CREATETEXTURE2D_NULLDESC = (D3D11_MESSAGE_ID_CREATETEXTURE2D_OUTOFMEMORY_RETURN + 1), D3D11_MESSAGE_ID_CREATETEXTURE2D_LARGEALLOCATION = (D3D11_MESSAGE_ID_CREATETEXTURE2D_NULLDESC + 1),
    D3D11_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDFORMAT = (D3D11_MESSAGE_ID_CREATETEXTURE2D_LARGEALLOCATION + 1), D3D11_MESSAGE_ID_CREATETEXTURE3D_UNSUPPORTEDFORMAT = (D3D11_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDFORMAT + 1), D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDSAMPLES = (D3D11_MESSAGE_ID_CREATETEXTURE3D_UNSUPPORTEDFORMAT + 1),
    D3D11_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDUSAGE = (D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDSAMPLES + 1), D3D11_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDBINDFLAGS = (D3D11_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDUSAGE + 1), D3D11_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDCPUACCESSFLAGS = (D3D11_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDBINDFLAGS + 1),
    D3D11_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDMISCFLAGS = (D3D11_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDCPUACCESSFLAGS + 1), D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDCPUACCESSFLAGS = (D3D11_MESSAGE_ID_CREATETEXTURE3D_UNRECOGNIZEDMISCFLAGS + 1), D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDBINDFLAGS = (D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDCPUACCESSFLAGS + 1),
    D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDINITIALDATA = (D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDBINDFLAGS + 1), D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDDIMENSIONS = (D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDINITIALDATA + 1), D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDMIPLEVELS = (D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDDIMENSIONS + 1),
    D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDMISCFLAGS = (D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDMIPLEVELS + 1), D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDARG_RETURN = (D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDMISCFLAGS + 1), D3D11_MESSAGE_ID_CREATETEXTURE3D_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_CREATETEXTURE3D_INVALIDARG_RETURN + 1),
    D3D11_MESSAGE_ID_CREATETEXTURE3D_NULLDESC = (D3D11_MESSAGE_ID_CREATETEXTURE3D_OUTOFMEMORY_RETURN + 1), D3D11_MESSAGE_ID_CREATETEXTURE3D_LARGEALLOCATION = (D3D11_MESSAGE_ID_CREATETEXTURE3D_NULLDESC + 1), D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_UNRECOGNIZEDFORMAT = (D3D11_MESSAGE_ID_CREATETEXTURE3D_LARGEALLOCATION + 1),
    D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDDESC = (D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_UNRECOGNIZEDFORMAT + 1), D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDFORMAT = (D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDDESC + 1), D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDDIMENSIONS = (D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDFORMAT + 1),
    D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDRESOURCE = (D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDDIMENSIONS + 1), D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_TOOMANYOBJECTS = (D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDRESOURCE + 1), D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDARG_RETURN = (D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_TOOMANYOBJECTS + 1),
    D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDARG_RETURN + 1), D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_UNRECOGNIZEDFORMAT = (D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_OUTOFMEMORY_RETURN + 1), D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_UNSUPPORTEDFORMAT = (D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_UNRECOGNIZEDFORMAT + 1),
    D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDDESC = (D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_UNSUPPORTEDFORMAT + 1), D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDFORMAT = (D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDDESC + 1), D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDDIMENSIONS = (D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDFORMAT + 1),
    D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDRESOURCE = (D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDDIMENSIONS + 1), D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_TOOMANYOBJECTS = (D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDRESOURCE + 1), D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDARG_RETURN = (D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_TOOMANYOBJECTS + 1),
    D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDARG_RETURN + 1), D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_UNRECOGNIZEDFORMAT = (D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_OUTOFMEMORY_RETURN + 1), D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDDESC = (D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_UNRECOGNIZEDFORMAT + 1),
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDFORMAT = (D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDDESC + 1), D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDDIMENSIONS = (D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDFORMAT + 1), D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDRESOURCE = (D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDDIMENSIONS + 1),
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_TOOMANYOBJECTS = (D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDRESOURCE + 1), D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDARG_RETURN = (D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_TOOMANYOBJECTS + 1), D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDARG_RETURN + 1),
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_OUTOFMEMORY = (D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_OUTOFMEMORY_RETURN + 1), D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_TOOMANYELEMENTS = (D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_OUTOFMEMORY + 1), D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDFORMAT = (D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_TOOMANYELEMENTS + 1),
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INCOMPATIBLEFORMAT = (D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDFORMAT + 1), D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSLOT = (D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INCOMPATIBLEFORMAT + 1), D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDINPUTSLOTCLASS = (D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSLOT + 1),
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_STEPRATESLOTCLASSMISMATCH = (D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDINPUTSLOTCLASS + 1), D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSLOTCLASSCHANGE = (D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_STEPRATESLOTCLASSMISMATCH + 1), D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSTEPRATECHANGE = (D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSLOTCLASSCHANGE + 1),
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDALIGNMENT = (D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSTEPRATECHANGE + 1), D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_DUPLICATESEMANTIC = (D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDALIGNMENT + 1), D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_UNPARSEABLEINPUTSIGNATURE = (D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_DUPLICATESEMANTIC + 1),
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_NULLSEMANTIC = (D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_UNPARSEABLEINPUTSIGNATURE + 1), D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_MISSINGELEMENT = (D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_NULLSEMANTIC + 1), D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_NULLDESC = (D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_MISSINGELEMENT + 1),
    D3D11_MESSAGE_ID_CREATEVERTEXSHADER_OUTOFMEMORY = (D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_NULLDESC + 1), D3D11_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDSHADERBYTECODE = (D3D11_MESSAGE_ID_CREATEVERTEXSHADER_OUTOFMEMORY + 1), D3D11_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDSHADERTYPE = (D3D11_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDSHADERBYTECODE + 1),
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADER_OUTOFMEMORY = (D3D11_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDSHADERTYPE + 1), D3D11_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDSHADERBYTECODE = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADER_OUTOFMEMORY + 1), D3D11_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDSHADERTYPE = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDSHADERBYTECODE + 1),
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTOFMEMORY = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDSHADERTYPE + 1), D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSHADERBYTECODE = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTOFMEMORY + 1),
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSHADERTYPE = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSHADERBYTECODE + 1), D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDNUMENTRIES = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSHADERTYPE + 1),
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTPUTSTREAMSTRIDEUNUSED = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDNUMENTRIES + 1), D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDDECL = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTPUTSTREAMSTRIDEUNUSED + 1),
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_EXPECTEDDECL = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDDECL + 1), D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTPUTSLOT0EXPECTED = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_EXPECTEDDECL + 1),
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDOUTPUTSLOT = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTPUTSLOT0EXPECTED + 1), D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_ONLYONEELEMENTPERSLOT = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDOUTPUTSLOT + 1),
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDCOMPONENTCOUNT = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_ONLYONEELEMENTPERSLOT + 1), D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTARTCOMPONENTANDCOMPONENTCOUNT = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDCOMPONENTCOUNT + 1),
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDGAPDEFINITION = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTARTCOMPONENTANDCOMPONENTCOUNT + 1), D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_REPEATEDOUTPUT = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDGAPDEFINITION + 1),
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDOUTPUTSTREAMSTRIDE = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_REPEATEDOUTPUT + 1), D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MISSINGSEMANTIC = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDOUTPUTSTREAMSTRIDE + 1),
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MASKMISMATCH = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MISSINGSEMANTIC + 1), D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_CANTHAVEONLYGAPS = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MASKMISMATCH + 1),
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DECLTOOCOMPLEX = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_CANTHAVEONLYGAPS + 1), D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MISSINGOUTPUTSIGNATURE = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DECLTOOCOMPLEX + 1),
    D3D11_MESSAGE_ID_CREATEPIXELSHADER_OUTOFMEMORY = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MISSINGOUTPUTSIGNATURE + 1), D3D11_MESSAGE_ID_CREATEPIXELSHADER_INVALIDSHADERBYTECODE = (D3D11_MESSAGE_ID_CREATEPIXELSHADER_OUTOFMEMORY + 1), D3D11_MESSAGE_ID_CREATEPIXELSHADER_INVALIDSHADERTYPE = (D3D11_MESSAGE_ID_CREATEPIXELSHADER_INVALIDSHADERBYTECODE + 1),
    D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDFILLMODE = (D3D11_MESSAGE_ID_CREATEPIXELSHADER_INVALIDSHADERTYPE + 1), D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDCULLMODE = (D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDFILLMODE + 1), D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDDEPTHBIASCLAMP = (D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDCULLMODE + 1),
    D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDSLOPESCALEDDEPTHBIAS = (D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDDEPTHBIASCLAMP + 1), D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_TOOMANYOBJECTS = (D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDSLOPESCALEDDEPTHBIAS + 1), D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_NULLDESC = (D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_TOOMANYOBJECTS + 1),
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDDEPTHWRITEMASK = (D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_NULLDESC + 1), D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDDEPTHFUNC = (D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDDEPTHWRITEMASK + 1), D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILFAILOP = (D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDDEPTHFUNC + 1),
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILZFAILOP = (D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILFAILOP + 1), D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILPASSOP = (D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILZFAILOP + 1),
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILFUNC = (D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILPASSOP + 1), D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILFAILOP = (D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILFUNC + 1),
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILZFAILOP = (D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILFAILOP + 1), D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILPASSOP = (D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILZFAILOP + 1),
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILFUNC = (D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILPASSOP + 1), D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_TOOMANYOBJECTS = (D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILFUNC + 1), D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_NULLDESC = (D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_TOOMANYOBJECTS + 1),
    D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDSRCBLEND = (D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_NULLDESC + 1), D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDDESTBLEND = (D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDSRCBLEND + 1), D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDBLENDOP = (D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDDESTBLEND + 1),
    D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDSRCBLENDALPHA = (D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDBLENDOP + 1), D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDDESTBLENDALPHA = (D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDSRCBLENDALPHA + 1), D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDBLENDOPALPHA = (D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDDESTBLENDALPHA + 1),
    D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDRENDERTARGETWRITEMASK = (D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDBLENDOPALPHA + 1), D3D11_MESSAGE_ID_CREATEBLENDSTATE_TOOMANYOBJECTS = (D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDRENDERTARGETWRITEMASK + 1), D3D11_MESSAGE_ID_CREATEBLENDSTATE_NULLDESC = (D3D11_MESSAGE_ID_CREATEBLENDSTATE_TOOMANYOBJECTS + 1),
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDFILTER = (D3D11_MESSAGE_ID_CREATEBLENDSTATE_NULLDESC + 1), D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDADDRESSU = (D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDFILTER + 1), D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDADDRESSV = (D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDADDRESSU + 1),
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDADDRESSW = (D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDADDRESSV + 1), D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMIPLODBIAS = (D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDADDRESSW + 1), D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMAXANISOTROPY = (D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMIPLODBIAS + 1),
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDCOMPARISONFUNC = (D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMAXANISOTROPY + 1), D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMINLOD = (D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDCOMPARISONFUNC + 1), D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMAXLOD = (D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMINLOD + 1),
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_TOOMANYOBJECTS = (D3D11_MESSAGE_ID_CREATESAMPLERSTATE_INVALIDMAXLOD + 1), D3D11_MESSAGE_ID_CREATESAMPLERSTATE_NULLDESC = (D3D11_MESSAGE_ID_CREATESAMPLERSTATE_TOOMANYOBJECTS + 1), D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_INVALIDQUERY = (D3D11_MESSAGE_ID_CREATESAMPLERSTATE_NULLDESC + 1),
    D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_INVALIDMISCFLAGS = (D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_INVALIDQUERY + 1), D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_UNEXPECTEDMISCFLAG = (D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_INVALIDMISCFLAGS + 1), D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_NULLDESC = (D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_UNEXPECTEDMISCFLAG + 1),
    D3D11_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_TOPOLOGY_UNRECOGNIZED = (D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_NULLDESC + 1), D3D11_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_TOPOLOGY_UNDEFINED = (D3D11_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_TOPOLOGY_UNRECOGNIZED + 1), D3D11_MESSAGE_ID_IASETVERTEXBUFFERS_INVALIDBUFFER = (D3D11_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_TOPOLOGY_UNDEFINED + 1),
    D3D11_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_OFFSET_TOO_LARGE = (D3D11_MESSAGE_ID_IASETVERTEXBUFFERS_INVALIDBUFFER + 1), D3D11_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_BUFFERS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_OFFSET_TOO_LARGE + 1), D3D11_MESSAGE_ID_IASETINDEXBUFFER_INVALIDBUFFER = (D3D11_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_BUFFERS_EMPTY + 1),
    D3D11_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_FORMAT_INVALID = (D3D11_MESSAGE_ID_IASETINDEXBUFFER_INVALIDBUFFER + 1), D3D11_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_OFFSET_TOO_LARGE = (D3D11_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_FORMAT_INVALID + 1), D3D11_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_OFFSET_UNALIGNED = (D3D11_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_OFFSET_TOO_LARGE + 1),
    D3D11_MESSAGE_ID_DEVICE_VSSETSHADERRESOURCES_VIEWS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_IASETINDEXBUFFER_OFFSET_UNALIGNED + 1), D3D11_MESSAGE_ID_VSSETCONSTANTBUFFERS_INVALIDBUFFER = (D3D11_MESSAGE_ID_DEVICE_VSSETSHADERRESOURCES_VIEWS_EMPTY + 1), D3D11_MESSAGE_ID_DEVICE_VSSETCONSTANTBUFFERS_BUFFERS_EMPTY = (D3D11_MESSAGE_ID_VSSETCONSTANTBUFFERS_INVALIDBUFFER + 1),
    D3D11_MESSAGE_ID_DEVICE_VSSETSAMPLERS_SAMPLERS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_VSSETCONSTANTBUFFERS_BUFFERS_EMPTY + 1), D3D11_MESSAGE_ID_DEVICE_GSSETSHADERRESOURCES_VIEWS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_VSSETSAMPLERS_SAMPLERS_EMPTY + 1), D3D11_MESSAGE_ID_GSSETCONSTANTBUFFERS_INVALIDBUFFER = (D3D11_MESSAGE_ID_DEVICE_GSSETSHADERRESOURCES_VIEWS_EMPTY + 1),
    D3D11_MESSAGE_ID_DEVICE_GSSETCONSTANTBUFFERS_BUFFERS_EMPTY = (D3D11_MESSAGE_ID_GSSETCONSTANTBUFFERS_INVALIDBUFFER + 1), D3D11_MESSAGE_ID_DEVICE_GSSETSAMPLERS_SAMPLERS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_GSSETCONSTANTBUFFERS_BUFFERS_EMPTY + 1), D3D11_MESSAGE_ID_SOSETTARGETS_INVALIDBUFFER = (D3D11_MESSAGE_ID_DEVICE_GSSETSAMPLERS_SAMPLERS_EMPTY + 1),
    D3D11_MESSAGE_ID_DEVICE_SOSETTARGETS_OFFSET_UNALIGNED = (D3D11_MESSAGE_ID_SOSETTARGETS_INVALIDBUFFER + 1), D3D11_MESSAGE_ID_DEVICE_PSSETSHADERRESOURCES_VIEWS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_SOSETTARGETS_OFFSET_UNALIGNED + 1), D3D11_MESSAGE_ID_PSSETCONSTANTBUFFERS_INVALIDBUFFER = (D3D11_MESSAGE_ID_DEVICE_PSSETSHADERRESOURCES_VIEWS_EMPTY + 1),
    D3D11_MESSAGE_ID_DEVICE_PSSETCONSTANTBUFFERS_BUFFERS_EMPTY = (D3D11_MESSAGE_ID_PSSETCONSTANTBUFFERS_INVALIDBUFFER + 1), D3D11_MESSAGE_ID_DEVICE_PSSETSAMPLERS_SAMPLERS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_PSSETCONSTANTBUFFERS_BUFFERS_EMPTY + 1), D3D11_MESSAGE_ID_DEVICE_RSSETVIEWPORTS_INVALIDVIEWPORT = (D3D11_MESSAGE_ID_DEVICE_PSSETSAMPLERS_SAMPLERS_EMPTY + 1),
    D3D11_MESSAGE_ID_DEVICE_RSSETSCISSORRECTS_INVALIDSCISSOR = (D3D11_MESSAGE_ID_DEVICE_RSSETVIEWPORTS_INVALIDVIEWPORT + 1), D3D11_MESSAGE_ID_CLEARRENDERTARGETVIEW_DENORMFLUSH = (D3D11_MESSAGE_ID_DEVICE_RSSETSCISSORRECTS_INVALIDSCISSOR + 1), D3D11_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_DENORMFLUSH = (D3D11_MESSAGE_ID_CLEARRENDERTARGETVIEW_DENORMFLUSH + 1),
    D3D11_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_INVALID = (D3D11_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_DENORMFLUSH + 1), D3D11_MESSAGE_ID_DEVICE_IAGETVERTEXBUFFERS_BUFFERS_EMPTY = (D3D11_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_INVALID + 1), D3D11_MESSAGE_ID_DEVICE_VSGETSHADERRESOURCES_VIEWS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_IAGETVERTEXBUFFERS_BUFFERS_EMPTY + 1),
    D3D11_MESSAGE_ID_DEVICE_VSGETCONSTANTBUFFERS_BUFFERS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_VSGETSHADERRESOURCES_VIEWS_EMPTY + 1), D3D11_MESSAGE_ID_DEVICE_VSGETSAMPLERS_SAMPLERS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_VSGETCONSTANTBUFFERS_BUFFERS_EMPTY + 1), D3D11_MESSAGE_ID_DEVICE_GSGETSHADERRESOURCES_VIEWS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_VSGETSAMPLERS_SAMPLERS_EMPTY + 1),
    D3D11_MESSAGE_ID_DEVICE_GSGETCONSTANTBUFFERS_BUFFERS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_GSGETSHADERRESOURCES_VIEWS_EMPTY + 1), D3D11_MESSAGE_ID_DEVICE_GSGETSAMPLERS_SAMPLERS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_GSGETCONSTANTBUFFERS_BUFFERS_EMPTY + 1), D3D11_MESSAGE_ID_DEVICE_SOGETTARGETS_BUFFERS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_GSGETSAMPLERS_SAMPLERS_EMPTY + 1),
    D3D11_MESSAGE_ID_DEVICE_PSGETSHADERRESOURCES_VIEWS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_SOGETTARGETS_BUFFERS_EMPTY + 1), D3D11_MESSAGE_ID_DEVICE_PSGETCONSTANTBUFFERS_BUFFERS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_PSGETSHADERRESOURCES_VIEWS_EMPTY + 1), D3D11_MESSAGE_ID_DEVICE_PSGETSAMPLERS_SAMPLERS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_PSGETCONSTANTBUFFERS_BUFFERS_EMPTY + 1),
    D3D11_MESSAGE_ID_DEVICE_RSGETVIEWPORTS_VIEWPORTS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_PSGETSAMPLERS_SAMPLERS_EMPTY + 1), D3D11_MESSAGE_ID_DEVICE_RSGETSCISSORRECTS_RECTS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_RSGETVIEWPORTS_VIEWPORTS_EMPTY + 1), D3D11_MESSAGE_ID_DEVICE_GENERATEMIPS_RESOURCE_INVALID = (D3D11_MESSAGE_ID_DEVICE_RSGETSCISSORRECTS_RECTS_EMPTY + 1),
    D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDDESTINATIONSUBRESOURCE = (D3D11_MESSAGE_ID_DEVICE_GENERATEMIPS_RESOURCE_INVALID + 1), D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCESUBRESOURCE = (D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDDESTINATIONSUBRESOURCE + 1),
    D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCEBOX = (D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCESUBRESOURCE + 1), D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCE = (D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCEBOX + 1), D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDDESTINATIONSTATE = (D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCE + 1),
    D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCESTATE = (D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDDESTINATIONSTATE + 1), D3D11_MESSAGE_ID_COPYRESOURCE_INVALIDSOURCE = (D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_INVALIDSOURCESTATE + 1), D3D11_MESSAGE_ID_COPYRESOURCE_INVALIDDESTINATIONSTATE = (D3D11_MESSAGE_ID_COPYRESOURCE_INVALIDSOURCE + 1),
    D3D11_MESSAGE_ID_COPYRESOURCE_INVALIDSOURCESTATE = (D3D11_MESSAGE_ID_COPYRESOURCE_INVALIDDESTINATIONSTATE + 1), D3D11_MESSAGE_ID_UPDATESUBRESOURCE_INVALIDDESTINATIONSUBRESOURCE = (D3D11_MESSAGE_ID_COPYRESOURCE_INVALIDSOURCESTATE + 1), D3D11_MESSAGE_ID_UPDATESUBRESOURCE_INVALIDDESTINATIONBOX = (D3D11_MESSAGE_ID_UPDATESUBRESOURCE_INVALIDDESTINATIONSUBRESOURCE + 1),
    D3D11_MESSAGE_ID_UPDATESUBRESOURCE_INVALIDDESTINATIONSTATE = (D3D11_MESSAGE_ID_UPDATESUBRESOURCE_INVALIDDESTINATIONBOX + 1), D3D11_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_DESTINATION_INVALID = (D3D11_MESSAGE_ID_UPDATESUBRESOURCE_INVALIDDESTINATIONSTATE + 1),
    D3D11_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_DESTINATION_SUBRESOURCE_INVALID = (D3D11_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_DESTINATION_INVALID + 1), D3D11_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_SOURCE_INVALID = (D3D11_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_DESTINATION_SUBRESOURCE_INVALID + 1),
    D3D11_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_SOURCE_SUBRESOURCE_INVALID = (D3D11_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_SOURCE_INVALID + 1), D3D11_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_FORMAT_INVALID = (D3D11_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_SOURCE_SUBRESOURCE_INVALID + 1), D3D11_MESSAGE_ID_BUFFER_MAP_INVALIDMAPTYPE = (D3D11_MESSAGE_ID_DEVICE_RESOLVESUBRESOURCE_FORMAT_INVALID + 1),
    D3D11_MESSAGE_ID_BUFFER_MAP_INVALIDFLAGS = (D3D11_MESSAGE_ID_BUFFER_MAP_INVALIDMAPTYPE + 1), D3D11_MESSAGE_ID_BUFFER_MAP_ALREADYMAPPED = (D3D11_MESSAGE_ID_BUFFER_MAP_INVALIDFLAGS + 1), D3D11_MESSAGE_ID_BUFFER_MAP_DEVICEREMOVED_RETURN = (D3D11_MESSAGE_ID_BUFFER_MAP_ALREADYMAPPED + 1), D3D11_MESSAGE_ID_BUFFER_UNMAP_NOTMAPPED = (D3D11_MESSAGE_ID_BUFFER_MAP_DEVICEREMOVED_RETURN + 1),
    D3D11_MESSAGE_ID_TEXTURE1D_MAP_INVALIDMAPTYPE = (D3D11_MESSAGE_ID_BUFFER_UNMAP_NOTMAPPED + 1), D3D11_MESSAGE_ID_TEXTURE1D_MAP_INVALIDSUBRESOURCE = (D3D11_MESSAGE_ID_TEXTURE1D_MAP_INVALIDMAPTYPE + 1), D3D11_MESSAGE_ID_TEXTURE1D_MAP_INVALIDFLAGS = (D3D11_MESSAGE_ID_TEXTURE1D_MAP_INVALIDSUBRESOURCE + 1),
    D3D11_MESSAGE_ID_TEXTURE1D_MAP_ALREADYMAPPED = (D3D11_MESSAGE_ID_TEXTURE1D_MAP_INVALIDFLAGS + 1), D3D11_MESSAGE_ID_TEXTURE1D_MAP_DEVICEREMOVED_RETURN = (D3D11_MESSAGE_ID_TEXTURE1D_MAP_ALREADYMAPPED + 1), D3D11_MESSAGE_ID_TEXTURE1D_UNMAP_INVALIDSUBRESOURCE = (D3D11_MESSAGE_ID_TEXTURE1D_MAP_DEVICEREMOVED_RETURN + 1),
    D3D11_MESSAGE_ID_TEXTURE1D_UNMAP_NOTMAPPED = (D3D11_MESSAGE_ID_TEXTURE1D_UNMAP_INVALIDSUBRESOURCE + 1), D3D11_MESSAGE_ID_TEXTURE2D_MAP_INVALIDMAPTYPE = (D3D11_MESSAGE_ID_TEXTURE1D_UNMAP_NOTMAPPED + 1), D3D11_MESSAGE_ID_TEXTURE2D_MAP_INVALIDSUBRESOURCE = (D3D11_MESSAGE_ID_TEXTURE2D_MAP_INVALIDMAPTYPE + 1),
    D3D11_MESSAGE_ID_TEXTURE2D_MAP_INVALIDFLAGS = (D3D11_MESSAGE_ID_TEXTURE2D_MAP_INVALIDSUBRESOURCE + 1), D3D11_MESSAGE_ID_TEXTURE2D_MAP_ALREADYMAPPED = (D3D11_MESSAGE_ID_TEXTURE2D_MAP_INVALIDFLAGS + 1), D3D11_MESSAGE_ID_TEXTURE2D_MAP_DEVICEREMOVED_RETURN = (D3D11_MESSAGE_ID_TEXTURE2D_MAP_ALREADYMAPPED + 1),
    D3D11_MESSAGE_ID_TEXTURE2D_UNMAP_INVALIDSUBRESOURCE = (D3D11_MESSAGE_ID_TEXTURE2D_MAP_DEVICEREMOVED_RETURN + 1), D3D11_MESSAGE_ID_TEXTURE2D_UNMAP_NOTMAPPED = (D3D11_MESSAGE_ID_TEXTURE2D_UNMAP_INVALIDSUBRESOURCE + 1), D3D11_MESSAGE_ID_TEXTURE3D_MAP_INVALIDMAPTYPE = (D3D11_MESSAGE_ID_TEXTURE2D_UNMAP_NOTMAPPED + 1),
    D3D11_MESSAGE_ID_TEXTURE3D_MAP_INVALIDSUBRESOURCE = (D3D11_MESSAGE_ID_TEXTURE3D_MAP_INVALIDMAPTYPE + 1), D3D11_MESSAGE_ID_TEXTURE3D_MAP_INVALIDFLAGS = (D3D11_MESSAGE_ID_TEXTURE3D_MAP_INVALIDSUBRESOURCE + 1), D3D11_MESSAGE_ID_TEXTURE3D_MAP_ALREADYMAPPED = (D3D11_MESSAGE_ID_TEXTURE3D_MAP_INVALIDFLAGS + 1),
    D3D11_MESSAGE_ID_TEXTURE3D_MAP_DEVICEREMOVED_RETURN = (D3D11_MESSAGE_ID_TEXTURE3D_MAP_ALREADYMAPPED + 1), D3D11_MESSAGE_ID_TEXTURE3D_UNMAP_INVALIDSUBRESOURCE = (D3D11_MESSAGE_ID_TEXTURE3D_MAP_DEVICEREMOVED_RETURN + 1), D3D11_MESSAGE_ID_TEXTURE3D_UNMAP_NOTMAPPED = (D3D11_MESSAGE_ID_TEXTURE3D_UNMAP_INVALIDSUBRESOURCE + 1),
    D3D11_MESSAGE_ID_CHECKFORMATSUPPORT_FORMAT_DEPRECATED = (D3D11_MESSAGE_ID_TEXTURE3D_UNMAP_NOTMAPPED + 1), D3D11_MESSAGE_ID_CHECKMULTISAMPLEQUALITYLEVELS_FORMAT_DEPRECATED = (D3D11_MESSAGE_ID_CHECKFORMATSUPPORT_FORMAT_DEPRECATED + 1), D3D11_MESSAGE_ID_SETEXCEPTIONMODE_UNRECOGNIZEDFLAGS = (D3D11_MESSAGE_ID_CHECKMULTISAMPLEQUALITYLEVELS_FORMAT_DEPRECATED + 1),
    D3D11_MESSAGE_ID_SETEXCEPTIONMODE_INVALIDARG_RETURN = (D3D11_MESSAGE_ID_SETEXCEPTIONMODE_UNRECOGNIZEDFLAGS + 1), D3D11_MESSAGE_ID_SETEXCEPTIONMODE_DEVICEREMOVED_RETURN = (D3D11_MESSAGE_ID_SETEXCEPTIONMODE_INVALIDARG_RETURN + 1), D3D11_MESSAGE_ID_REF_SIMULATING_INFINITELY_FAST_HARDWARE = (D3D11_MESSAGE_ID_SETEXCEPTIONMODE_DEVICEREMOVED_RETURN + 1),
    D3D11_MESSAGE_ID_REF_THREADING_MODE = (D3D11_MESSAGE_ID_REF_SIMULATING_INFINITELY_FAST_HARDWARE + 1), D3D11_MESSAGE_ID_REF_UMDRIVER_EXCEPTION = (D3D11_MESSAGE_ID_REF_THREADING_MODE + 1), D3D11_MESSAGE_ID_REF_KMDRIVER_EXCEPTION = (D3D11_MESSAGE_ID_REF_UMDRIVER_EXCEPTION + 1), D3D11_MESSAGE_ID_REF_HARDWARE_EXCEPTION = (D3D11_MESSAGE_ID_REF_KMDRIVER_EXCEPTION + 1),
    D3D11_MESSAGE_ID_REF_ACCESSING_INDEXABLE_TEMP_OUT_OF_RANGE = (D3D11_MESSAGE_ID_REF_HARDWARE_EXCEPTION + 1), D3D11_MESSAGE_ID_REF_PROBLEM_PARSING_SHADER = (D3D11_MESSAGE_ID_REF_ACCESSING_INDEXABLE_TEMP_OUT_OF_RANGE + 1), D3D11_MESSAGE_ID_REF_OUT_OF_MEMORY = (D3D11_MESSAGE_ID_REF_PROBLEM_PARSING_SHADER + 1), D3D11_MESSAGE_ID_REF_INFO = (D3D11_MESSAGE_ID_REF_OUT_OF_MEMORY + 1),
    D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEXPOS_OVERFLOW = (D3D11_MESSAGE_ID_REF_INFO + 1), D3D11_MESSAGE_ID_DEVICE_DRAWINDEXED_INDEXPOS_OVERFLOW = (D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEXPOS_OVERFLOW + 1), D3D11_MESSAGE_ID_DEVICE_DRAWINSTANCED_VERTEXPOS_OVERFLOW = (D3D11_MESSAGE_ID_DEVICE_DRAWINDEXED_INDEXPOS_OVERFLOW + 1),
    D3D11_MESSAGE_ID_DEVICE_DRAWINSTANCED_INSTANCEPOS_OVERFLOW = (D3D11_MESSAGE_ID_DEVICE_DRAWINSTANCED_VERTEXPOS_OVERFLOW + 1), D3D11_MESSAGE_ID_DEVICE_DRAWINDEXEDINSTANCED_INSTANCEPOS_OVERFLOW = (D3D11_MESSAGE_ID_DEVICE_DRAWINSTANCED_INSTANCEPOS_OVERFLOW + 1), D3D11_MESSAGE_ID_DEVICE_DRAWINDEXEDINSTANCED_INDEXPOS_OVERFLOW = (D3D11_MESSAGE_ID_DEVICE_DRAWINDEXEDINSTANCED_INSTANCEPOS_OVERFLOW + 1),
    D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEX_SHADER_NOT_SET = (D3D11_MESSAGE_ID_DEVICE_DRAWINDEXEDINSTANCED_INDEXPOS_OVERFLOW + 1), D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_SEMANTICNAME_NOT_FOUND = (D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEX_SHADER_NOT_SET + 1), D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_REGISTERINDEX = (D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_SEMANTICNAME_NOT_FOUND + 1),
    D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_COMPONENTTYPE = (D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_REGISTERINDEX + 1), D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_REGISTERMASK = (D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_COMPONENTTYPE + 1), D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_SYSTEMVALUE = (D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_REGISTERMASK + 1),
    D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_NEVERWRITTEN_ALWAYSREADS = (D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_SYSTEMVALUE + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEX_BUFFER_NOT_SET = (D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_NEVERWRITTEN_ALWAYSREADS + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_INPUTLAYOUT_NOT_SET = (D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEX_BUFFER_NOT_SET + 1),
    D3D11_MESSAGE_ID_DEVICE_DRAW_CONSTANT_BUFFER_NOT_SET = (D3D11_MESSAGE_ID_DEVICE_DRAW_INPUTLAYOUT_NOT_SET + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_CONSTANT_BUFFER_TOO_SMALL = (D3D11_MESSAGE_ID_DEVICE_DRAW_CONSTANT_BUFFER_NOT_SET + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_SAMPLER_NOT_SET = (D3D11_MESSAGE_ID_DEVICE_DRAW_CONSTANT_BUFFER_TOO_SMALL + 1),
    D3D11_MESSAGE_ID_DEVICE_DRAW_SHADERRESOURCEVIEW_NOT_SET = (D3D11_MESSAGE_ID_DEVICE_DRAW_SAMPLER_NOT_SET + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_VIEW_DIMENSION_MISMATCH = (D3D11_MESSAGE_ID_DEVICE_DRAW_SHADERRESOURCEVIEW_NOT_SET + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEX_BUFFER_STRIDE_TOO_SMALL = (D3D11_MESSAGE_ID_DEVICE_DRAW_VIEW_DIMENSION_MISMATCH + 1),
    D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEX_BUFFER_TOO_SMALL = (D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEX_BUFFER_STRIDE_TOO_SMALL + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_INDEX_BUFFER_NOT_SET = (D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEX_BUFFER_TOO_SMALL + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_INDEX_BUFFER_FORMAT_INVALID = (D3D11_MESSAGE_ID_DEVICE_DRAW_INDEX_BUFFER_NOT_SET + 1),
    D3D11_MESSAGE_ID_DEVICE_DRAW_INDEX_BUFFER_TOO_SMALL = (D3D11_MESSAGE_ID_DEVICE_DRAW_INDEX_BUFFER_FORMAT_INVALID + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_GS_INPUT_PRIMITIVE_MISMATCH = (D3D11_MESSAGE_ID_DEVICE_DRAW_INDEX_BUFFER_TOO_SMALL + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_RETURN_TYPE_MISMATCH = (D3D11_MESSAGE_ID_DEVICE_DRAW_GS_INPUT_PRIMITIVE_MISMATCH + 1),
    D3D11_MESSAGE_ID_DEVICE_DRAW_POSITION_NOT_PRESENT = (D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_RETURN_TYPE_MISMATCH + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_OUTPUT_STREAM_NOT_SET = (D3D11_MESSAGE_ID_DEVICE_DRAW_POSITION_NOT_PRESENT + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_BOUND_RESOURCE_MAPPED = (D3D11_MESSAGE_ID_DEVICE_DRAW_OUTPUT_STREAM_NOT_SET + 1),
    D3D11_MESSAGE_ID_DEVICE_DRAW_INVALID_PRIMITIVETOPOLOGY = (D3D11_MESSAGE_ID_DEVICE_DRAW_BOUND_RESOURCE_MAPPED + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEX_OFFSET_UNALIGNED = (D3D11_MESSAGE_ID_DEVICE_DRAW_INVALID_PRIMITIVETOPOLOGY + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEX_STRIDE_UNALIGNED = (D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEX_OFFSET_UNALIGNED + 1),
    D3D11_MESSAGE_ID_DEVICE_DRAW_INDEX_OFFSET_UNALIGNED = (D3D11_MESSAGE_ID_DEVICE_DRAW_VERTEX_STRIDE_UNALIGNED + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_OUTPUT_STREAM_OFFSET_UNALIGNED = (D3D11_MESSAGE_ID_DEVICE_DRAW_INDEX_OFFSET_UNALIGNED + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_LD_UNSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_DRAW_OUTPUT_STREAM_OFFSET_UNALIGNED + 1),
    D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_SAMPLE_UNSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_LD_UNSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_SAMPLE_C_UNSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_SAMPLE_UNSUPPORTED + 1),
    D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_MULTISAMPLE_UNSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_SAMPLE_C_UNSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_SO_TARGETS_BOUND_WITHOUT_SOURCE = (D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_MULTISAMPLE_UNSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_SO_STRIDE_LARGER_THAN_BUFFER = (D3D11_MESSAGE_ID_DEVICE_DRAW_SO_TARGETS_BOUND_WITHOUT_SOURCE + 1),
    D3D11_MESSAGE_ID_DEVICE_DRAW_OM_RENDER_TARGET_DOES_NOT_SUPPORT_BLENDING = (D3D11_MESSAGE_ID_DEVICE_DRAW_SO_STRIDE_LARGER_THAN_BUFFER + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_OM_DUAL_SOURCE_BLENDING_CAN_ONLY_HAVE_RENDER_TARGET_0 = (D3D11_MESSAGE_ID_DEVICE_DRAW_OM_RENDER_TARGET_DOES_NOT_SUPPORT_BLENDING + 1),
    D3D11_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_AT_FAULT = (D3D11_MESSAGE_ID_DEVICE_DRAW_OM_DUAL_SOURCE_BLENDING_CAN_ONLY_HAVE_RENDER_TARGET_0 + 1), D3D11_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_POSSIBLY_AT_FAULT = (D3D11_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_AT_FAULT + 1), D3D11_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_NOT_AT_FAULT = (D3D11_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_POSSIBLY_AT_FAULT + 1),
    D3D11_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_INVALIDARG_RETURN = (D3D11_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_NOT_AT_FAULT + 1), D3D11_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_INVALIDARG_RETURN + 1),
    D3D11_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_BADINTERFACE_RETURN = (D3D11_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_OUTOFMEMORY_RETURN + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_VIEWPORT_NOT_SET = (D3D11_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_BADINTERFACE_RETURN + 1), D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_TRAILING_DIGIT_IN_SEMANTIC = (D3D11_MESSAGE_ID_DEVICE_DRAW_VIEWPORT_NOT_SET + 1),
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_TRAILING_DIGIT_IN_SEMANTIC = (D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_TRAILING_DIGIT_IN_SEMANTIC + 1), D3D11_MESSAGE_ID_DEVICE_RSSETVIEWPORTS_DENORMFLUSH = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_TRAILING_DIGIT_IN_SEMANTIC + 1),
    D3D11_MESSAGE_ID_OMSETRENDERTARGETS_INVALIDVIEW = (D3D11_MESSAGE_ID_DEVICE_RSSETVIEWPORTS_DENORMFLUSH + 1), D3D11_MESSAGE_ID_DEVICE_SETTEXTFILTERSIZE_INVALIDDIMENSIONS = (D3D11_MESSAGE_ID_OMSETRENDERTARGETS_INVALIDVIEW + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_SAMPLER_MISMATCH = (D3D11_MESSAGE_ID_DEVICE_SETTEXTFILTERSIZE_INVALIDDIMENSIONS + 1),
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_TYPE_MISMATCH = (D3D11_MESSAGE_ID_DEVICE_DRAW_SAMPLER_MISMATCH + 1), D3D11_MESSAGE_ID_BLENDSTATE_GETDESC_LEGACY = (D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_TYPE_MISMATCH + 1), D3D11_MESSAGE_ID_SHADERRESOURCEVIEW_GETDESC_LEGACY = (D3D11_MESSAGE_ID_BLENDSTATE_GETDESC_LEGACY + 1),
    D3D11_MESSAGE_ID_CREATEQUERY_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_SHADERRESOURCEVIEW_GETDESC_LEGACY + 1), D3D11_MESSAGE_ID_CREATEPREDICATE_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_CREATEQUERY_OUTOFMEMORY_RETURN + 1), D3D11_MESSAGE_ID_CREATECOUNTER_OUTOFRANGE_COUNTER = (D3D11_MESSAGE_ID_CREATEPREDICATE_OUTOFMEMORY_RETURN + 1),
    D3D11_MESSAGE_ID_CREATECOUNTER_SIMULTANEOUS_ACTIVE_COUNTERS_EXHAUSTED = (D3D11_MESSAGE_ID_CREATECOUNTER_OUTOFRANGE_COUNTER + 1), D3D11_MESSAGE_ID_CREATECOUNTER_UNSUPPORTED_WELLKNOWN_COUNTER = (D3D11_MESSAGE_ID_CREATECOUNTER_SIMULTANEOUS_ACTIVE_COUNTERS_EXHAUSTED + 1), D3D11_MESSAGE_ID_CREATECOUNTER_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_CREATECOUNTER_UNSUPPORTED_WELLKNOWN_COUNTER + 1),
    D3D11_MESSAGE_ID_CREATECOUNTER_NONEXCLUSIVE_RETURN = (D3D11_MESSAGE_ID_CREATECOUNTER_OUTOFMEMORY_RETURN + 1), D3D11_MESSAGE_ID_CREATECOUNTER_NULLDESC = (D3D11_MESSAGE_ID_CREATECOUNTER_NONEXCLUSIVE_RETURN + 1), D3D11_MESSAGE_ID_CHECKCOUNTER_OUTOFRANGE_COUNTER = (D3D11_MESSAGE_ID_CREATECOUNTER_NULLDESC + 1),
    D3D11_MESSAGE_ID_CHECKCOUNTER_UNSUPPORTED_WELLKNOWN_COUNTER = (D3D11_MESSAGE_ID_CHECKCOUNTER_OUTOFRANGE_COUNTER + 1), D3D11_MESSAGE_ID_SETPREDICATION_INVALID_PREDICATE_STATE = (D3D11_MESSAGE_ID_CHECKCOUNTER_UNSUPPORTED_WELLKNOWN_COUNTER + 1), D3D11_MESSAGE_ID_QUERY_BEGIN_UNSUPPORTED = (D3D11_MESSAGE_ID_SETPREDICATION_INVALID_PREDICATE_STATE + 1),
    D3D11_MESSAGE_ID_PREDICATE_BEGIN_DURING_PREDICATION = (D3D11_MESSAGE_ID_QUERY_BEGIN_UNSUPPORTED + 1), D3D11_MESSAGE_ID_QUERY_BEGIN_DUPLICATE = (D3D11_MESSAGE_ID_PREDICATE_BEGIN_DURING_PREDICATION + 1), D3D11_MESSAGE_ID_QUERY_BEGIN_ABANDONING_PREVIOUS_RESULTS = (D3D11_MESSAGE_ID_QUERY_BEGIN_DUPLICATE + 1),
    D3D11_MESSAGE_ID_PREDICATE_END_DURING_PREDICATION = (D3D11_MESSAGE_ID_QUERY_BEGIN_ABANDONING_PREVIOUS_RESULTS + 1), D3D11_MESSAGE_ID_QUERY_END_ABANDONING_PREVIOUS_RESULTS = (D3D11_MESSAGE_ID_PREDICATE_END_DURING_PREDICATION + 1), D3D11_MESSAGE_ID_QUERY_END_WITHOUT_BEGIN = (D3D11_MESSAGE_ID_QUERY_END_ABANDONING_PREVIOUS_RESULTS + 1),
    D3D11_MESSAGE_ID_QUERY_GETDATA_INVALID_DATASIZE = (D3D11_MESSAGE_ID_QUERY_END_WITHOUT_BEGIN + 1), D3D11_MESSAGE_ID_QUERY_GETDATA_INVALID_FLAGS = (D3D11_MESSAGE_ID_QUERY_GETDATA_INVALID_DATASIZE + 1), D3D11_MESSAGE_ID_QUERY_GETDATA_INVALID_CALL = (D3D11_MESSAGE_ID_QUERY_GETDATA_INVALID_FLAGS + 1),
    D3D11_MESSAGE_ID_DEVICE_DRAW_PS_OUTPUT_TYPE_MISMATCH = (D3D11_MESSAGE_ID_QUERY_GETDATA_INVALID_CALL + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_GATHER_UNSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_DRAW_PS_OUTPUT_TYPE_MISMATCH + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_INVALID_USE_OF_CENTER_MULTISAMPLE_PATTERN = (D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_FORMAT_GATHER_UNSUPPORTED + 1),
    D3D11_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_STRIDE_TOO_LARGE = (D3D11_MESSAGE_ID_DEVICE_DRAW_INVALID_USE_OF_CENTER_MULTISAMPLE_PATTERN + 1), D3D11_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_INVALIDRANGE = (D3D11_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_STRIDE_TOO_LARGE + 1), D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_EMPTY_LAYOUT = (D3D11_MESSAGE_ID_DEVICE_IASETVERTEXBUFFERS_INVALIDRANGE + 1),
    D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_SAMPLE_COUNT_MISMATCH = (D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_EMPTY_LAYOUT + 1), D3D11_MESSAGE_ID_LIVE_OBJECT_SUMMARY = (D3D11_MESSAGE_ID_DEVICE_DRAW_RESOURCE_SAMPLE_COUNT_MISMATCH + 1), D3D11_MESSAGE_ID_LIVE_BUFFER = (D3D11_MESSAGE_ID_LIVE_OBJECT_SUMMARY + 1), D3D11_MESSAGE_ID_LIVE_TEXTURE1D = (D3D11_MESSAGE_ID_LIVE_BUFFER + 1),
    D3D11_MESSAGE_ID_LIVE_TEXTURE2D = (D3D11_MESSAGE_ID_LIVE_TEXTURE1D + 1), D3D11_MESSAGE_ID_LIVE_TEXTURE3D = (D3D11_MESSAGE_ID_LIVE_TEXTURE2D + 1), D3D11_MESSAGE_ID_LIVE_SHADERRESOURCEVIEW = (D3D11_MESSAGE_ID_LIVE_TEXTURE3D + 1), D3D11_MESSAGE_ID_LIVE_RENDERTARGETVIEW = (D3D11_MESSAGE_ID_LIVE_SHADERRESOURCEVIEW + 1),
    D3D11_MESSAGE_ID_LIVE_DEPTHSTENCILVIEW = (D3D11_MESSAGE_ID_LIVE_RENDERTARGETVIEW + 1), D3D11_MESSAGE_ID_LIVE_VERTEXSHADER = (D3D11_MESSAGE_ID_LIVE_DEPTHSTENCILVIEW + 1), D3D11_MESSAGE_ID_LIVE_GEOMETRYSHADER = (D3D11_MESSAGE_ID_LIVE_VERTEXSHADER + 1), D3D11_MESSAGE_ID_LIVE_PIXELSHADER = (D3D11_MESSAGE_ID_LIVE_GEOMETRYSHADER + 1),
    D3D11_MESSAGE_ID_LIVE_INPUTLAYOUT = (D3D11_MESSAGE_ID_LIVE_PIXELSHADER + 1), D3D11_MESSAGE_ID_LIVE_SAMPLER = (D3D11_MESSAGE_ID_LIVE_INPUTLAYOUT + 1), D3D11_MESSAGE_ID_LIVE_BLENDSTATE = (D3D11_MESSAGE_ID_LIVE_SAMPLER + 1), D3D11_MESSAGE_ID_LIVE_DEPTHSTENCILSTATE = (D3D11_MESSAGE_ID_LIVE_BLENDSTATE + 1), D3D11_MESSAGE_ID_LIVE_RASTERIZERSTATE = (D3D11_MESSAGE_ID_LIVE_DEPTHSTENCILSTATE + 1),
    D3D11_MESSAGE_ID_LIVE_QUERY = (D3D11_MESSAGE_ID_LIVE_RASTERIZERSTATE + 1), D3D11_MESSAGE_ID_LIVE_PREDICATE = (D3D11_MESSAGE_ID_LIVE_QUERY + 1), D3D11_MESSAGE_ID_LIVE_COUNTER = (D3D11_MESSAGE_ID_LIVE_PREDICATE + 1), D3D11_MESSAGE_ID_LIVE_DEVICE = (D3D11_MESSAGE_ID_LIVE_COUNTER + 1), D3D11_MESSAGE_ID_LIVE_SWAPCHAIN = (D3D11_MESSAGE_ID_LIVE_DEVICE + 1),
    D3D11_MESSAGE_ID_D3D10_MESSAGES_END = (D3D11_MESSAGE_ID_LIVE_SWAPCHAIN + 1), D3D11_MESSAGE_ID_D3D10L9_MESSAGES_START = $100000, D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_STENCIL_NO_TWO_SIDED = (D3D11_MESSAGE_ID_D3D10L9_MESSAGES_START + 1), D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_DepthBiasClamp_NOT_SUPPORTED = (D3D11_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_STENCIL_NO_TWO_SIDED + 1),
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_NO_COMPARISON_SUPPORT = (D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_DepthBiasClamp_NOT_SUPPORTED + 1), D3D11_MESSAGE_ID_CREATESAMPLERSTATE_EXCESSIVE_ANISOTROPY = (D3D11_MESSAGE_ID_CREATESAMPLERSTATE_NO_COMPARISON_SUPPORT + 1), D3D11_MESSAGE_ID_CREATESAMPLERSTATE_BORDER_OUT_OF_RANGE = (D3D11_MESSAGE_ID_CREATESAMPLERSTATE_EXCESSIVE_ANISOTROPY + 1),
    D3D11_MESSAGE_ID_VSSETSAMPLERS_NOT_SUPPORTED = (D3D11_MESSAGE_ID_CREATESAMPLERSTATE_BORDER_OUT_OF_RANGE + 1), D3D11_MESSAGE_ID_VSSETSAMPLERS_TOO_MANY_SAMPLERS = (D3D11_MESSAGE_ID_VSSETSAMPLERS_NOT_SUPPORTED + 1), D3D11_MESSAGE_ID_PSSETSAMPLERS_TOO_MANY_SAMPLERS = (D3D11_MESSAGE_ID_VSSETSAMPLERS_TOO_MANY_SAMPLERS + 1),
    D3D11_MESSAGE_ID_CREATERESOURCE_NO_ARRAYS = (D3D11_MESSAGE_ID_PSSETSAMPLERS_TOO_MANY_SAMPLERS + 1), D3D11_MESSAGE_ID_CREATERESOURCE_NO_VB_AND_IB_BIND = (D3D11_MESSAGE_ID_CREATERESOURCE_NO_ARRAYS + 1), D3D11_MESSAGE_ID_CREATERESOURCE_NO_TEXTURE_1D = (D3D11_MESSAGE_ID_CREATERESOURCE_NO_VB_AND_IB_BIND + 1),
    D3D11_MESSAGE_ID_CREATERESOURCE_DIMENSION_OUT_OF_RANGE = (D3D11_MESSAGE_ID_CREATERESOURCE_NO_TEXTURE_1D + 1), D3D11_MESSAGE_ID_CREATERESOURCE_NOT_BINDABLE_AS_SHADER_RESOURCE = (D3D11_MESSAGE_ID_CREATERESOURCE_DIMENSION_OUT_OF_RANGE + 1), D3D11_MESSAGE_ID_OMSETRENDERTARGETS_TOO_MANY_RENDER_TARGETS = (D3D11_MESSAGE_ID_CREATERESOURCE_NOT_BINDABLE_AS_SHADER_RESOURCE + 1),
    D3D11_MESSAGE_ID_OMSETRENDERTARGETS_NO_DIFFERING_BIT_DEPTHS = (D3D11_MESSAGE_ID_OMSETRENDERTARGETS_TOO_MANY_RENDER_TARGETS + 1), D3D11_MESSAGE_ID_IASETVERTEXBUFFERS_BAD_BUFFER_INDEX = (D3D11_MESSAGE_ID_OMSETRENDERTARGETS_NO_DIFFERING_BIT_DEPTHS + 1), D3D11_MESSAGE_ID_DEVICE_RSSETVIEWPORTS_TOO_MANY_VIEWPORTS = (D3D11_MESSAGE_ID_IASETVERTEXBUFFERS_BAD_BUFFER_INDEX + 1),
    D3D11_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_ADJACENCY_UNSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_RSSETVIEWPORTS_TOO_MANY_VIEWPORTS + 1), D3D11_MESSAGE_ID_DEVICE_RSSETSCISSORRECTS_TOO_MANY_SCISSORS = (D3D11_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_ADJACENCY_UNSUPPORTED + 1),
    D3D11_MESSAGE_ID_COPYRESOURCE_ONLY_TEXTURE_2D_WITHIN_GPU_MEMORY = (D3D11_MESSAGE_ID_DEVICE_RSSETSCISSORRECTS_TOO_MANY_SCISSORS + 1), D3D11_MESSAGE_ID_COPYRESOURCE_NO_TEXTURE_3D_READBACK = (D3D11_MESSAGE_ID_COPYRESOURCE_ONLY_TEXTURE_2D_WITHIN_GPU_MEMORY + 1), D3D11_MESSAGE_ID_COPYRESOURCE_NO_TEXTURE_ONLY_READBACK = (D3D11_MESSAGE_ID_COPYRESOURCE_NO_TEXTURE_3D_READBACK + 1),
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_UNSUPPORTED_FORMAT = (D3D11_MESSAGE_ID_COPYRESOURCE_NO_TEXTURE_ONLY_READBACK + 1), D3D11_MESSAGE_ID_CREATEBLENDSTATE_NO_ALPHA_TO_COVERAGE = (D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_UNSUPPORTED_FORMAT + 1), D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_DepthClipEnable_MUST_BE_TRUE = (D3D11_MESSAGE_ID_CREATEBLENDSTATE_NO_ALPHA_TO_COVERAGE + 1),
    D3D11_MESSAGE_ID_DRAWINDEXED_STARTINDEXLOCATION_MUST_BE_POSITIVE = (D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_DepthClipEnable_MUST_BE_TRUE + 1), D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_MUST_USE_LOWEST_LOD = (D3D11_MESSAGE_ID_DRAWINDEXED_STARTINDEXLOCATION_MUST_BE_POSITIVE + 1),
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_MINLOD_MUST_NOT_BE_FRACTIONAL = (D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_MUST_USE_LOWEST_LOD + 1), D3D11_MESSAGE_ID_CREATESAMPLERSTATE_MAXLOD_MUST_BE_FLT_MAX = (D3D11_MESSAGE_ID_CREATESAMPLERSTATE_MINLOD_MUST_NOT_BE_FRACTIONAL + 1),
    D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_FIRSTARRAYSLICE_MUST_BE_ZERO = (D3D11_MESSAGE_ID_CREATESAMPLERSTATE_MAXLOD_MUST_BE_FLT_MAX + 1), D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_CUBES_MUST_HAVE_6_SIDES = (D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_FIRSTARRAYSLICE_MUST_BE_ZERO + 1),
    D3D11_MESSAGE_ID_CREATERESOURCE_NOT_BINDABLE_AS_RENDER_TARGET = (D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_CUBES_MUST_HAVE_6_SIDES + 1), D3D11_MESSAGE_ID_CREATERESOURCE_NO_DWORD_INDEX_BUFFER = (D3D11_MESSAGE_ID_CREATERESOURCE_NOT_BINDABLE_AS_RENDER_TARGET + 1), D3D11_MESSAGE_ID_CREATERESOURCE_MSAA_PRECLUDES_SHADER_RESOURCE = (D3D11_MESSAGE_ID_CREATERESOURCE_NO_DWORD_INDEX_BUFFER + 1),
    D3D11_MESSAGE_ID_CREATERESOURCE_PRESENTATION_PRECLUDES_SHADER_RESOURCE = (D3D11_MESSAGE_ID_CREATERESOURCE_MSAA_PRECLUDES_SHADER_RESOURCE + 1), D3D11_MESSAGE_ID_CREATEBLENDSTATE_NO_INDEPENDENT_BLEND_ENABLE = (D3D11_MESSAGE_ID_CREATERESOURCE_PRESENTATION_PRECLUDES_SHADER_RESOURCE + 1),
    D3D11_MESSAGE_ID_CREATEBLENDSTATE_NO_INDEPENDENT_WRITE_MASKS = (D3D11_MESSAGE_ID_CREATEBLENDSTATE_NO_INDEPENDENT_BLEND_ENABLE + 1), D3D11_MESSAGE_ID_CREATERESOURCE_NO_STREAM_OUT = (D3D11_MESSAGE_ID_CREATEBLENDSTATE_NO_INDEPENDENT_WRITE_MASKS + 1), D3D11_MESSAGE_ID_CREATERESOURCE_ONLY_VB_IB_FOR_BUFFERS = (D3D11_MESSAGE_ID_CREATERESOURCE_NO_STREAM_OUT + 1),
    D3D11_MESSAGE_ID_CREATERESOURCE_NO_AUTOGEN_FOR_VOLUMES = (D3D11_MESSAGE_ID_CREATERESOURCE_ONLY_VB_IB_FOR_BUFFERS + 1), D3D11_MESSAGE_ID_CREATERESOURCE_DXGI_FORMAT_R8G8B8A8_CANNOT_BE_SHARED = (D3D11_MESSAGE_ID_CREATERESOURCE_NO_AUTOGEN_FOR_VOLUMES + 1), D3D11_MESSAGE_ID_VSSHADERRESOURCES_NOT_SUPPORTED = (D3D11_MESSAGE_ID_CREATERESOURCE_DXGI_FORMAT_R8G8B8A8_CANNOT_BE_SHARED + 1),
    D3D11_MESSAGE_ID_GEOMETRY_SHADER_NOT_SUPPORTED = (D3D11_MESSAGE_ID_VSSHADERRESOURCES_NOT_SUPPORTED + 1), D3D11_MESSAGE_ID_STREAM_OUT_NOT_SUPPORTED = (D3D11_MESSAGE_ID_GEOMETRY_SHADER_NOT_SUPPORTED + 1), D3D11_MESSAGE_ID_TEXT_FILTER_NOT_SUPPORTED = (D3D11_MESSAGE_ID_STREAM_OUT_NOT_SUPPORTED + 1),
    D3D11_MESSAGE_ID_CREATEBLENDSTATE_NO_SEPARATE_ALPHA_BLEND = (D3D11_MESSAGE_ID_TEXT_FILTER_NOT_SUPPORTED + 1), D3D11_MESSAGE_ID_CREATEBLENDSTATE_NO_MRT_BLEND = (D3D11_MESSAGE_ID_CREATEBLENDSTATE_NO_SEPARATE_ALPHA_BLEND + 1), D3D11_MESSAGE_ID_CREATEBLENDSTATE_OPERATION_NOT_SUPPORTED = (D3D11_MESSAGE_ID_CREATEBLENDSTATE_NO_MRT_BLEND + 1),
    D3D11_MESSAGE_ID_CREATESAMPLERSTATE_NO_MIRRORONCE = (D3D11_MESSAGE_ID_CREATEBLENDSTATE_OPERATION_NOT_SUPPORTED + 1), D3D11_MESSAGE_ID_DRAWINSTANCED_NOT_SUPPORTED = (D3D11_MESSAGE_ID_CREATESAMPLERSTATE_NO_MIRRORONCE + 1), D3D11_MESSAGE_ID_DRAWINDEXEDINSTANCED_NOT_SUPPORTED_BELOW_9_3 = (D3D11_MESSAGE_ID_DRAWINSTANCED_NOT_SUPPORTED + 1),
    D3D11_MESSAGE_ID_DRAWINDEXED_POINTLIST_UNSUPPORTED = (D3D11_MESSAGE_ID_DRAWINDEXEDINSTANCED_NOT_SUPPORTED_BELOW_9_3 + 1), D3D11_MESSAGE_ID_SETBLENDSTATE_SAMPLE_MASK_CANNOT_BE_ZERO = (D3D11_MESSAGE_ID_DRAWINDEXED_POINTLIST_UNSUPPORTED + 1), D3D11_MESSAGE_ID_CREATERESOURCE_DIMENSION_EXCEEDS_FEATURE_LEVEL_DEFINITION = (D3D11_MESSAGE_ID_SETBLENDSTATE_SAMPLE_MASK_CANNOT_BE_ZERO + 1),
    D3D11_MESSAGE_ID_CREATERESOURCE_ONLY_SINGLE_MIP_LEVEL_DEPTH_STENCIL_SUPPORTED = (D3D11_MESSAGE_ID_CREATERESOURCE_DIMENSION_EXCEEDS_FEATURE_LEVEL_DEFINITION + 1), D3D11_MESSAGE_ID_DEVICE_RSSETSCISSORRECTS_NEGATIVESCISSOR = (D3D11_MESSAGE_ID_CREATERESOURCE_ONLY_SINGLE_MIP_LEVEL_DEPTH_STENCIL_SUPPORTED + 1),
    D3D11_MESSAGE_ID_SLOT_ZERO_MUST_BE_D3D10_INPUT_PER_VERTEX_DATA = (D3D11_MESSAGE_ID_DEVICE_RSSETSCISSORRECTS_NEGATIVESCISSOR + 1), D3D11_MESSAGE_ID_CREATERESOURCE_NON_POW_2_MIPMAP = (D3D11_MESSAGE_ID_SLOT_ZERO_MUST_BE_D3D10_INPUT_PER_VERTEX_DATA + 1), D3D11_MESSAGE_ID_CREATESAMPLERSTATE_BORDER_NOT_SUPPORTED = (D3D11_MESSAGE_ID_CREATERESOURCE_NON_POW_2_MIPMAP + 1),
    D3D11_MESSAGE_ID_OMSETRENDERTARGETS_NO_SRGB_MRT = (D3D11_MESSAGE_ID_CREATESAMPLERSTATE_BORDER_NOT_SUPPORTED + 1), D3D11_MESSAGE_ID_COPYRESOURCE_NO_3D_MISMATCHED_UPDATES = (D3D11_MESSAGE_ID_OMSETRENDERTARGETS_NO_SRGB_MRT + 1), D3D11_MESSAGE_ID_D3D10L9_MESSAGES_END = (D3D11_MESSAGE_ID_COPYRESOURCE_NO_3D_MISMATCHED_UPDATES + 1), D3D11_MESSAGE_ID_D3D11_MESSAGES_START = $200000,
    D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDFLAGS = (D3D11_MESSAGE_ID_D3D11_MESSAGES_START + 1), D3D11_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDCLASSLINKAGE = (D3D11_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDFLAGS + 1), D3D11_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDCLASSLINKAGE = (D3D11_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDCLASSLINKAGE + 1),
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDNUMSTREAMS = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDCLASSLINKAGE + 1), D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTREAMTORASTERIZER = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDNUMSTREAMS + 1),
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDSTREAMS = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTREAMTORASTERIZER + 1), D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDCLASSLINKAGE = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDSTREAMS + 1),
    D3D11_MESSAGE_ID_CREATEPIXELSHADER_INVALIDCLASSLINKAGE = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDCLASSLINKAGE + 1), D3D11_MESSAGE_ID_CREATEDEFERREDCONTEXT_INVALID_COMMANDLISTFLAGS = (D3D11_MESSAGE_ID_CREATEPIXELSHADER_INVALIDCLASSLINKAGE + 1), D3D11_MESSAGE_ID_CREATEDEFERREDCONTEXT_SINGLETHREADED = (D3D11_MESSAGE_ID_CREATEDEFERREDCONTEXT_INVALID_COMMANDLISTFLAGS + 1),
    D3D11_MESSAGE_ID_CREATEDEFERREDCONTEXT_INVALIDARG_RETURN = (D3D11_MESSAGE_ID_CREATEDEFERREDCONTEXT_SINGLETHREADED + 1), D3D11_MESSAGE_ID_CREATEDEFERREDCONTEXT_INVALID_CALL_RETURN = (D3D11_MESSAGE_ID_CREATEDEFERREDCONTEXT_INVALIDARG_RETURN + 1), D3D11_MESSAGE_ID_CREATEDEFERREDCONTEXT_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_CREATEDEFERREDCONTEXT_INVALID_CALL_RETURN + 1),
    D3D11_MESSAGE_ID_FINISHDISPLAYLIST_ONIMMEDIATECONTEXT = (D3D11_MESSAGE_ID_CREATEDEFERREDCONTEXT_OUTOFMEMORY_RETURN + 1), D3D11_MESSAGE_ID_FINISHDISPLAYLIST_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_FINISHDISPLAYLIST_ONIMMEDIATECONTEXT + 1), D3D11_MESSAGE_ID_FINISHDISPLAYLIST_INVALID_CALL_RETURN = (D3D11_MESSAGE_ID_FINISHDISPLAYLIST_OUTOFMEMORY_RETURN + 1),
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTREAM = (D3D11_MESSAGE_ID_FINISHDISPLAYLIST_INVALID_CALL_RETURN + 1), D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDENTRIES = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTREAM + 1),
    D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDSTRIDES = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDENTRIES + 1), D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDNUMSTRIDES = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDSTRIDES + 1),
    D3D11_MESSAGE_ID_DEVICE_HSSETSHADERRESOURCES_HAZARD = (D3D11_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDNUMSTRIDES + 1), D3D11_MESSAGE_ID_DEVICE_HSSETCONSTANTBUFFERS_HAZARD = (D3D11_MESSAGE_ID_DEVICE_HSSETSHADERRESOURCES_HAZARD + 1), D3D11_MESSAGE_ID_HSSETSHADERRESOURCES_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_DEVICE_HSSETCONSTANTBUFFERS_HAZARD + 1),
    D3D11_MESSAGE_ID_HSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_HSSETSHADERRESOURCES_UNBINDDELETINGOBJECT + 1), D3D11_MESSAGE_ID_CREATEHULLSHADER_INVALIDCALL = (D3D11_MESSAGE_ID_HSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT + 1), D3D11_MESSAGE_ID_CREATEHULLSHADER_OUTOFMEMORY = (D3D11_MESSAGE_ID_CREATEHULLSHADER_INVALIDCALL + 1),
    D3D11_MESSAGE_ID_CREATEHULLSHADER_INVALIDSHADERBYTECODE = (D3D11_MESSAGE_ID_CREATEHULLSHADER_OUTOFMEMORY + 1), D3D11_MESSAGE_ID_CREATEHULLSHADER_INVALIDSHADERTYPE = (D3D11_MESSAGE_ID_CREATEHULLSHADER_INVALIDSHADERBYTECODE + 1), D3D11_MESSAGE_ID_CREATEHULLSHADER_INVALIDCLASSLINKAGE = (D3D11_MESSAGE_ID_CREATEHULLSHADER_INVALIDSHADERTYPE + 1),
    D3D11_MESSAGE_ID_DEVICE_HSSETSHADERRESOURCES_VIEWS_EMPTY = (D3D11_MESSAGE_ID_CREATEHULLSHADER_INVALIDCLASSLINKAGE + 1), D3D11_MESSAGE_ID_HSSETCONSTANTBUFFERS_INVALIDBUFFER = (D3D11_MESSAGE_ID_DEVICE_HSSETSHADERRESOURCES_VIEWS_EMPTY + 1), D3D11_MESSAGE_ID_DEVICE_HSSETCONSTANTBUFFERS_BUFFERS_EMPTY = (D3D11_MESSAGE_ID_HSSETCONSTANTBUFFERS_INVALIDBUFFER + 1),
    D3D11_MESSAGE_ID_DEVICE_HSSETSAMPLERS_SAMPLERS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_HSSETCONSTANTBUFFERS_BUFFERS_EMPTY + 1), D3D11_MESSAGE_ID_DEVICE_HSGETSHADERRESOURCES_VIEWS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_HSSETSAMPLERS_SAMPLERS_EMPTY + 1), D3D11_MESSAGE_ID_DEVICE_HSGETCONSTANTBUFFERS_BUFFERS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_HSGETSHADERRESOURCES_VIEWS_EMPTY + 1),
    D3D11_MESSAGE_ID_DEVICE_HSGETSAMPLERS_SAMPLERS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_HSGETCONSTANTBUFFERS_BUFFERS_EMPTY + 1), D3D11_MESSAGE_ID_DEVICE_DSSETSHADERRESOURCES_HAZARD = (D3D11_MESSAGE_ID_DEVICE_HSGETSAMPLERS_SAMPLERS_EMPTY + 1), D3D11_MESSAGE_ID_DEVICE_DSSETCONSTANTBUFFERS_HAZARD = (D3D11_MESSAGE_ID_DEVICE_DSSETSHADERRESOURCES_HAZARD + 1),
    D3D11_MESSAGE_ID_DSSETSHADERRESOURCES_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_DEVICE_DSSETCONSTANTBUFFERS_HAZARD + 1), D3D11_MESSAGE_ID_DSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_DSSETSHADERRESOURCES_UNBINDDELETINGOBJECT + 1), D3D11_MESSAGE_ID_CREATEDOMAINSHADER_INVALIDCALL = (D3D11_MESSAGE_ID_DSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT + 1),
    D3D11_MESSAGE_ID_CREATEDOMAINSHADER_OUTOFMEMORY = (D3D11_MESSAGE_ID_CREATEDOMAINSHADER_INVALIDCALL + 1), D3D11_MESSAGE_ID_CREATEDOMAINSHADER_INVALIDSHADERBYTECODE = (D3D11_MESSAGE_ID_CREATEDOMAINSHADER_OUTOFMEMORY + 1), D3D11_MESSAGE_ID_CREATEDOMAINSHADER_INVALIDSHADERTYPE = (D3D11_MESSAGE_ID_CREATEDOMAINSHADER_INVALIDSHADERBYTECODE + 1),
    D3D11_MESSAGE_ID_CREATEDOMAINSHADER_INVALIDCLASSLINKAGE = (D3D11_MESSAGE_ID_CREATEDOMAINSHADER_INVALIDSHADERTYPE + 1), D3D11_MESSAGE_ID_DEVICE_DSSETSHADERRESOURCES_VIEWS_EMPTY = (D3D11_MESSAGE_ID_CREATEDOMAINSHADER_INVALIDCLASSLINKAGE + 1), D3D11_MESSAGE_ID_DSSETCONSTANTBUFFERS_INVALIDBUFFER = (D3D11_MESSAGE_ID_DEVICE_DSSETSHADERRESOURCES_VIEWS_EMPTY + 1),
    D3D11_MESSAGE_ID_DEVICE_DSSETCONSTANTBUFFERS_BUFFERS_EMPTY = (D3D11_MESSAGE_ID_DSSETCONSTANTBUFFERS_INVALIDBUFFER + 1), D3D11_MESSAGE_ID_DEVICE_DSSETSAMPLERS_SAMPLERS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_DSSETCONSTANTBUFFERS_BUFFERS_EMPTY + 1), D3D11_MESSAGE_ID_DEVICE_DSGETSHADERRESOURCES_VIEWS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_DSSETSAMPLERS_SAMPLERS_EMPTY + 1),
    D3D11_MESSAGE_ID_DEVICE_DSGETCONSTANTBUFFERS_BUFFERS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_DSGETSHADERRESOURCES_VIEWS_EMPTY + 1), D3D11_MESSAGE_ID_DEVICE_DSGETSAMPLERS_SAMPLERS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_DSGETCONSTANTBUFFERS_BUFFERS_EMPTY + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_HS_XOR_DS_MISMATCH = (D3D11_MESSAGE_ID_DEVICE_DSGETSAMPLERS_SAMPLERS_EMPTY + 1),
    D3D11_MESSAGE_ID_DEFERRED_CONTEXT_REMOVAL_PROCESS_AT_FAULT = (D3D11_MESSAGE_ID_DEVICE_DRAW_HS_XOR_DS_MISMATCH + 1), D3D11_MESSAGE_ID_DEVICE_DRAWINDIRECT_INVALID_ARG_BUFFER = (D3D11_MESSAGE_ID_DEFERRED_CONTEXT_REMOVAL_PROCESS_AT_FAULT + 1), D3D11_MESSAGE_ID_DEVICE_DRAWINDIRECT_OFFSET_UNALIGNED = (D3D11_MESSAGE_ID_DEVICE_DRAWINDIRECT_INVALID_ARG_BUFFER + 1),
    D3D11_MESSAGE_ID_DEVICE_DRAWINDIRECT_OFFSET_OVERFLOW = (D3D11_MESSAGE_ID_DEVICE_DRAWINDIRECT_OFFSET_UNALIGNED + 1), D3D11_MESSAGE_ID_RESOURCE_MAP_INVALIDMAPTYPE = (D3D11_MESSAGE_ID_DEVICE_DRAWINDIRECT_OFFSET_OVERFLOW + 1), D3D11_MESSAGE_ID_RESOURCE_MAP_INVALIDSUBRESOURCE = (D3D11_MESSAGE_ID_RESOURCE_MAP_INVALIDMAPTYPE + 1),
    D3D11_MESSAGE_ID_RESOURCE_MAP_INVALIDFLAGS = (D3D11_MESSAGE_ID_RESOURCE_MAP_INVALIDSUBRESOURCE + 1), D3D11_MESSAGE_ID_RESOURCE_MAP_ALREADYMAPPED = (D3D11_MESSAGE_ID_RESOURCE_MAP_INVALIDFLAGS + 1), D3D11_MESSAGE_ID_RESOURCE_MAP_DEVICEREMOVED_RETURN = (D3D11_MESSAGE_ID_RESOURCE_MAP_ALREADYMAPPED + 1),
    D3D11_MESSAGE_ID_RESOURCE_MAP_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_RESOURCE_MAP_DEVICEREMOVED_RETURN + 1), D3D11_MESSAGE_ID_RESOURCE_MAP_WITHOUT_INITIAL_DISCARD = (D3D11_MESSAGE_ID_RESOURCE_MAP_OUTOFMEMORY_RETURN + 1), D3D11_MESSAGE_ID_RESOURCE_UNMAP_INVALIDSUBRESOURCE = (D3D11_MESSAGE_ID_RESOURCE_MAP_WITHOUT_INITIAL_DISCARD + 1),
    D3D11_MESSAGE_ID_RESOURCE_UNMAP_NOTMAPPED = (D3D11_MESSAGE_ID_RESOURCE_UNMAP_INVALIDSUBRESOURCE + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_RASTERIZING_CONTROL_POINTS = (D3D11_MESSAGE_ID_RESOURCE_UNMAP_NOTMAPPED + 1), D3D11_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_TOPOLOGY_UNSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_DRAW_RASTERIZING_CONTROL_POINTS + 1),
    D3D11_MESSAGE_ID_DEVICE_DRAW_HS_DS_SIGNATURE_MISMATCH = (D3D11_MESSAGE_ID_DEVICE_IASETPRIMITIVETOPOLOGY_TOPOLOGY_UNSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_HULL_SHADER_INPUT_TOPOLOGY_MISMATCH = (D3D11_MESSAGE_ID_DEVICE_DRAW_HS_DS_SIGNATURE_MISMATCH + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_HS_DS_CONTROL_POINT_COUNT_MISMATCH = (D3D11_MESSAGE_ID_DEVICE_DRAW_HULL_SHADER_INPUT_TOPOLOGY_MISMATCH + 1),
    D3D11_MESSAGE_ID_DEVICE_DRAW_HS_DS_TESSELLATOR_DOMAIN_MISMATCH = (D3D11_MESSAGE_ID_DEVICE_DRAW_HS_DS_CONTROL_POINT_COUNT_MISMATCH + 1), D3D11_MESSAGE_ID_CREATE_CONTEXT = (D3D11_MESSAGE_ID_DEVICE_DRAW_HS_DS_TESSELLATOR_DOMAIN_MISMATCH + 1), D3D11_MESSAGE_ID_LIVE_CONTEXT = (D3D11_MESSAGE_ID_CREATE_CONTEXT + 1), D3D11_MESSAGE_ID_DESTROY_CONTEXT = (D3D11_MESSAGE_ID_LIVE_CONTEXT + 1),
    D3D11_MESSAGE_ID_CREATE_BUFFER = (D3D11_MESSAGE_ID_DESTROY_CONTEXT + 1), D3D11_MESSAGE_ID_LIVE_BUFFER_WIN7 = (D3D11_MESSAGE_ID_CREATE_BUFFER + 1), D3D11_MESSAGE_ID_DESTROY_BUFFER = (D3D11_MESSAGE_ID_LIVE_BUFFER_WIN7 + 1), D3D11_MESSAGE_ID_CREATE_TEXTURE1D = (D3D11_MESSAGE_ID_DESTROY_BUFFER + 1), D3D11_MESSAGE_ID_LIVE_TEXTURE1D_WIN7 = (D3D11_MESSAGE_ID_CREATE_TEXTURE1D + 1),
    D3D11_MESSAGE_ID_DESTROY_TEXTURE1D = (D3D11_MESSAGE_ID_LIVE_TEXTURE1D_WIN7 + 1), D3D11_MESSAGE_ID_CREATE_TEXTURE2D = (D3D11_MESSAGE_ID_DESTROY_TEXTURE1D + 1), D3D11_MESSAGE_ID_LIVE_TEXTURE2D_WIN7 = (D3D11_MESSAGE_ID_CREATE_TEXTURE2D + 1), D3D11_MESSAGE_ID_DESTROY_TEXTURE2D = (D3D11_MESSAGE_ID_LIVE_TEXTURE2D_WIN7 + 1),
    D3D11_MESSAGE_ID_CREATE_TEXTURE3D = (D3D11_MESSAGE_ID_DESTROY_TEXTURE2D + 1), D3D11_MESSAGE_ID_LIVE_TEXTURE3D_WIN7 = (D3D11_MESSAGE_ID_CREATE_TEXTURE3D + 1), D3D11_MESSAGE_ID_DESTROY_TEXTURE3D = (D3D11_MESSAGE_ID_LIVE_TEXTURE3D_WIN7 + 1), D3D11_MESSAGE_ID_CREATE_SHADERRESOURCEVIEW = (D3D11_MESSAGE_ID_DESTROY_TEXTURE3D + 1),
    D3D11_MESSAGE_ID_LIVE_SHADERRESOURCEVIEW_WIN7 = (D3D11_MESSAGE_ID_CREATE_SHADERRESOURCEVIEW + 1), D3D11_MESSAGE_ID_DESTROY_SHADERRESOURCEVIEW = (D3D11_MESSAGE_ID_LIVE_SHADERRESOURCEVIEW_WIN7 + 1), D3D11_MESSAGE_ID_CREATE_RENDERTARGETVIEW = (D3D11_MESSAGE_ID_DESTROY_SHADERRESOURCEVIEW + 1), D3D11_MESSAGE_ID_LIVE_RENDERTARGETVIEW_WIN7 = (D3D11_MESSAGE_ID_CREATE_RENDERTARGETVIEW + 1),
    D3D11_MESSAGE_ID_DESTROY_RENDERTARGETVIEW = (D3D11_MESSAGE_ID_LIVE_RENDERTARGETVIEW_WIN7 + 1), D3D11_MESSAGE_ID_CREATE_DEPTHSTENCILVIEW = (D3D11_MESSAGE_ID_DESTROY_RENDERTARGETVIEW + 1), D3D11_MESSAGE_ID_LIVE_DEPTHSTENCILVIEW_WIN7 = (D3D11_MESSAGE_ID_CREATE_DEPTHSTENCILVIEW + 1), D3D11_MESSAGE_ID_DESTROY_DEPTHSTENCILVIEW = (D3D11_MESSAGE_ID_LIVE_DEPTHSTENCILVIEW_WIN7 + 1),
    D3D11_MESSAGE_ID_CREATE_VERTEXSHADER = (D3D11_MESSAGE_ID_DESTROY_DEPTHSTENCILVIEW + 1), D3D11_MESSAGE_ID_LIVE_VERTEXSHADER_WIN7 = (D3D11_MESSAGE_ID_CREATE_VERTEXSHADER + 1), D3D11_MESSAGE_ID_DESTROY_VERTEXSHADER = (D3D11_MESSAGE_ID_LIVE_VERTEXSHADER_WIN7 + 1), D3D11_MESSAGE_ID_CREATE_HULLSHADER = (D3D11_MESSAGE_ID_DESTROY_VERTEXSHADER + 1),
    D3D11_MESSAGE_ID_LIVE_HULLSHADER = (D3D11_MESSAGE_ID_CREATE_HULLSHADER + 1), D3D11_MESSAGE_ID_DESTROY_HULLSHADER = (D3D11_MESSAGE_ID_LIVE_HULLSHADER + 1), D3D11_MESSAGE_ID_CREATE_DOMAINSHADER = (D3D11_MESSAGE_ID_DESTROY_HULLSHADER + 1), D3D11_MESSAGE_ID_LIVE_DOMAINSHADER = (D3D11_MESSAGE_ID_CREATE_DOMAINSHADER + 1),
    D3D11_MESSAGE_ID_DESTROY_DOMAINSHADER = (D3D11_MESSAGE_ID_LIVE_DOMAINSHADER + 1), D3D11_MESSAGE_ID_CREATE_GEOMETRYSHADER = (D3D11_MESSAGE_ID_DESTROY_DOMAINSHADER + 1), D3D11_MESSAGE_ID_LIVE_GEOMETRYSHADER_WIN7 = (D3D11_MESSAGE_ID_CREATE_GEOMETRYSHADER + 1), D3D11_MESSAGE_ID_DESTROY_GEOMETRYSHADER = (D3D11_MESSAGE_ID_LIVE_GEOMETRYSHADER_WIN7 + 1),
    D3D11_MESSAGE_ID_CREATE_PIXELSHADER = (D3D11_MESSAGE_ID_DESTROY_GEOMETRYSHADER + 1), D3D11_MESSAGE_ID_LIVE_PIXELSHADER_WIN7 = (D3D11_MESSAGE_ID_CREATE_PIXELSHADER + 1), D3D11_MESSAGE_ID_DESTROY_PIXELSHADER = (D3D11_MESSAGE_ID_LIVE_PIXELSHADER_WIN7 + 1), D3D11_MESSAGE_ID_CREATE_INPUTLAYOUT = (D3D11_MESSAGE_ID_DESTROY_PIXELSHADER + 1),
    D3D11_MESSAGE_ID_LIVE_INPUTLAYOUT_WIN7 = (D3D11_MESSAGE_ID_CREATE_INPUTLAYOUT + 1), D3D11_MESSAGE_ID_DESTROY_INPUTLAYOUT = (D3D11_MESSAGE_ID_LIVE_INPUTLAYOUT_WIN7 + 1), D3D11_MESSAGE_ID_CREATE_SAMPLER = (D3D11_MESSAGE_ID_DESTROY_INPUTLAYOUT + 1), D3D11_MESSAGE_ID_LIVE_SAMPLER_WIN7 = (D3D11_MESSAGE_ID_CREATE_SAMPLER + 1),
    D3D11_MESSAGE_ID_DESTROY_SAMPLER = (D3D11_MESSAGE_ID_LIVE_SAMPLER_WIN7 + 1), D3D11_MESSAGE_ID_CREATE_BLENDSTATE = (D3D11_MESSAGE_ID_DESTROY_SAMPLER + 1), D3D11_MESSAGE_ID_LIVE_BLENDSTATE_WIN7 = (D3D11_MESSAGE_ID_CREATE_BLENDSTATE + 1), D3D11_MESSAGE_ID_DESTROY_BLENDSTATE = (D3D11_MESSAGE_ID_LIVE_BLENDSTATE_WIN7 + 1),
    D3D11_MESSAGE_ID_CREATE_DEPTHSTENCILSTATE = (D3D11_MESSAGE_ID_DESTROY_BLENDSTATE + 1), D3D11_MESSAGE_ID_LIVE_DEPTHSTENCILSTATE_WIN7 = (D3D11_MESSAGE_ID_CREATE_DEPTHSTENCILSTATE + 1), D3D11_MESSAGE_ID_DESTROY_DEPTHSTENCILSTATE = (D3D11_MESSAGE_ID_LIVE_DEPTHSTENCILSTATE_WIN7 + 1), D3D11_MESSAGE_ID_CREATE_RASTERIZERSTATE = (D3D11_MESSAGE_ID_DESTROY_DEPTHSTENCILSTATE + 1),
    D3D11_MESSAGE_ID_LIVE_RASTERIZERSTATE_WIN7 = (D3D11_MESSAGE_ID_CREATE_RASTERIZERSTATE + 1), D3D11_MESSAGE_ID_DESTROY_RASTERIZERSTATE = (D3D11_MESSAGE_ID_LIVE_RASTERIZERSTATE_WIN7 + 1), D3D11_MESSAGE_ID_CREATE_QUERY = (D3D11_MESSAGE_ID_DESTROY_RASTERIZERSTATE + 1), D3D11_MESSAGE_ID_LIVE_QUERY_WIN7 = (D3D11_MESSAGE_ID_CREATE_QUERY + 1),
    D3D11_MESSAGE_ID_DESTROY_QUERY = (D3D11_MESSAGE_ID_LIVE_QUERY_WIN7 + 1), D3D11_MESSAGE_ID_CREATE_PREDICATE = (D3D11_MESSAGE_ID_DESTROY_QUERY + 1), D3D11_MESSAGE_ID_LIVE_PREDICATE_WIN7 = (D3D11_MESSAGE_ID_CREATE_PREDICATE + 1), D3D11_MESSAGE_ID_DESTROY_PREDICATE = (D3D11_MESSAGE_ID_LIVE_PREDICATE_WIN7 + 1), D3D11_MESSAGE_ID_CREATE_COUNTER = (D3D11_MESSAGE_ID_DESTROY_PREDICATE + 1),
    D3D11_MESSAGE_ID_DESTROY_COUNTER = (D3D11_MESSAGE_ID_CREATE_COUNTER + 1), D3D11_MESSAGE_ID_CREATE_COMMANDLIST = (D3D11_MESSAGE_ID_DESTROY_COUNTER + 1), D3D11_MESSAGE_ID_LIVE_COMMANDLIST = (D3D11_MESSAGE_ID_CREATE_COMMANDLIST + 1), D3D11_MESSAGE_ID_DESTROY_COMMANDLIST = (D3D11_MESSAGE_ID_LIVE_COMMANDLIST + 1), D3D11_MESSAGE_ID_CREATE_CLASSINSTANCE = (D3D11_MESSAGE_ID_DESTROY_COMMANDLIST + 1),
    D3D11_MESSAGE_ID_LIVE_CLASSINSTANCE = (D3D11_MESSAGE_ID_CREATE_CLASSINSTANCE + 1), D3D11_MESSAGE_ID_DESTROY_CLASSINSTANCE = (D3D11_MESSAGE_ID_LIVE_CLASSINSTANCE + 1), D3D11_MESSAGE_ID_CREATE_CLASSLINKAGE = (D3D11_MESSAGE_ID_DESTROY_CLASSINSTANCE + 1), D3D11_MESSAGE_ID_LIVE_CLASSLINKAGE = (D3D11_MESSAGE_ID_CREATE_CLASSLINKAGE + 1),
    D3D11_MESSAGE_ID_DESTROY_CLASSLINKAGE = (D3D11_MESSAGE_ID_LIVE_CLASSLINKAGE + 1), D3D11_MESSAGE_ID_LIVE_DEVICE_WIN7 = (D3D11_MESSAGE_ID_DESTROY_CLASSLINKAGE + 1), D3D11_MESSAGE_ID_LIVE_OBJECT_SUMMARY_WIN7 = (D3D11_MESSAGE_ID_LIVE_DEVICE_WIN7 + 1), D3D11_MESSAGE_ID_CREATE_COMPUTESHADER = (D3D11_MESSAGE_ID_LIVE_OBJECT_SUMMARY_WIN7 + 1),
    D3D11_MESSAGE_ID_LIVE_COMPUTESHADER = (D3D11_MESSAGE_ID_CREATE_COMPUTESHADER + 1), D3D11_MESSAGE_ID_DESTROY_COMPUTESHADER = (D3D11_MESSAGE_ID_LIVE_COMPUTESHADER + 1), D3D11_MESSAGE_ID_CREATE_UNORDEREDACCESSVIEW = (D3D11_MESSAGE_ID_DESTROY_COMPUTESHADER + 1), D3D11_MESSAGE_ID_LIVE_UNORDEREDACCESSVIEW = (D3D11_MESSAGE_ID_CREATE_UNORDEREDACCESSVIEW + 1),
    D3D11_MESSAGE_ID_DESTROY_UNORDEREDACCESSVIEW = (D3D11_MESSAGE_ID_LIVE_UNORDEREDACCESSVIEW + 1), D3D11_MESSAGE_ID_DEVICE_SETSHADER_INTERFACES_FEATURELEVEL = (D3D11_MESSAGE_ID_DESTROY_UNORDEREDACCESSVIEW + 1), D3D11_MESSAGE_ID_DEVICE_SETSHADER_INTERFACE_COUNT_MISMATCH = (D3D11_MESSAGE_ID_DEVICE_SETSHADER_INTERFACES_FEATURELEVEL + 1),
    D3D11_MESSAGE_ID_DEVICE_SETSHADER_INVALID_INSTANCE = (D3D11_MESSAGE_ID_DEVICE_SETSHADER_INTERFACE_COUNT_MISMATCH + 1), D3D11_MESSAGE_ID_DEVICE_SETSHADER_INVALID_INSTANCE_INDEX = (D3D11_MESSAGE_ID_DEVICE_SETSHADER_INVALID_INSTANCE + 1), D3D11_MESSAGE_ID_DEVICE_SETSHADER_INVALID_INSTANCE_TYPE = (D3D11_MESSAGE_ID_DEVICE_SETSHADER_INVALID_INSTANCE_INDEX + 1),
    D3D11_MESSAGE_ID_DEVICE_SETSHADER_INVALID_INSTANCE_DATA = (D3D11_MESSAGE_ID_DEVICE_SETSHADER_INVALID_INSTANCE_TYPE + 1), D3D11_MESSAGE_ID_DEVICE_SETSHADER_UNBOUND_INSTANCE_DATA = (D3D11_MESSAGE_ID_DEVICE_SETSHADER_INVALID_INSTANCE_DATA + 1), D3D11_MESSAGE_ID_DEVICE_SETSHADER_INSTANCE_DATA_BINDINGS = (D3D11_MESSAGE_ID_DEVICE_SETSHADER_UNBOUND_INSTANCE_DATA + 1),
    D3D11_MESSAGE_ID_DEVICE_CREATESHADER_CLASSLINKAGE_FULL = (D3D11_MESSAGE_ID_DEVICE_SETSHADER_INSTANCE_DATA_BINDINGS + 1), D3D11_MESSAGE_ID_DEVICE_CHECKFEATURESUPPORT_UNRECOGNIZED_FEATURE = (D3D11_MESSAGE_ID_DEVICE_CREATESHADER_CLASSLINKAGE_FULL + 1), D3D11_MESSAGE_ID_DEVICE_CHECKFEATURESUPPORT_MISMATCHED_DATA_SIZE = (D3D11_MESSAGE_ID_DEVICE_CHECKFEATURESUPPORT_UNRECOGNIZED_FEATURE + 1),
    D3D11_MESSAGE_ID_DEVICE_CHECKFEATURESUPPORT_INVALIDARG_RETURN = (D3D11_MESSAGE_ID_DEVICE_CHECKFEATURESUPPORT_MISMATCHED_DATA_SIZE + 1), D3D11_MESSAGE_ID_DEVICE_CSSETSHADERRESOURCES_HAZARD = (D3D11_MESSAGE_ID_DEVICE_CHECKFEATURESUPPORT_INVALIDARG_RETURN + 1), D3D11_MESSAGE_ID_DEVICE_CSSETCONSTANTBUFFERS_HAZARD = (D3D11_MESSAGE_ID_DEVICE_CSSETSHADERRESOURCES_HAZARD + 1),
    D3D11_MESSAGE_ID_CSSETSHADERRESOURCES_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_DEVICE_CSSETCONSTANTBUFFERS_HAZARD + 1), D3D11_MESSAGE_ID_CSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_CSSETSHADERRESOURCES_UNBINDDELETINGOBJECT + 1), D3D11_MESSAGE_ID_CREATECOMPUTESHADER_INVALIDCALL = (D3D11_MESSAGE_ID_CSSETCONSTANTBUFFERS_UNBINDDELETINGOBJECT + 1),
    D3D11_MESSAGE_ID_CREATECOMPUTESHADER_OUTOFMEMORY = (D3D11_MESSAGE_ID_CREATECOMPUTESHADER_INVALIDCALL + 1), D3D11_MESSAGE_ID_CREATECOMPUTESHADER_INVALIDSHADERBYTECODE = (D3D11_MESSAGE_ID_CREATECOMPUTESHADER_OUTOFMEMORY + 1), D3D11_MESSAGE_ID_CREATECOMPUTESHADER_INVALIDSHADERTYPE = (D3D11_MESSAGE_ID_CREATECOMPUTESHADER_INVALIDSHADERBYTECODE + 1),
    D3D11_MESSAGE_ID_CREATECOMPUTESHADER_INVALIDCLASSLINKAGE = (D3D11_MESSAGE_ID_CREATECOMPUTESHADER_INVALIDSHADERTYPE + 1), D3D11_MESSAGE_ID_DEVICE_CSSETSHADERRESOURCES_VIEWS_EMPTY = (D3D11_MESSAGE_ID_CREATECOMPUTESHADER_INVALIDCLASSLINKAGE + 1), D3D11_MESSAGE_ID_CSSETCONSTANTBUFFERS_INVALIDBUFFER = (D3D11_MESSAGE_ID_DEVICE_CSSETSHADERRESOURCES_VIEWS_EMPTY + 1),
    D3D11_MESSAGE_ID_DEVICE_CSSETCONSTANTBUFFERS_BUFFERS_EMPTY = (D3D11_MESSAGE_ID_CSSETCONSTANTBUFFERS_INVALIDBUFFER + 1), D3D11_MESSAGE_ID_DEVICE_CSSETSAMPLERS_SAMPLERS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_CSSETCONSTANTBUFFERS_BUFFERS_EMPTY + 1), D3D11_MESSAGE_ID_DEVICE_CSGETSHADERRESOURCES_VIEWS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_CSSETSAMPLERS_SAMPLERS_EMPTY + 1),
    D3D11_MESSAGE_ID_DEVICE_CSGETCONSTANTBUFFERS_BUFFERS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_CSGETSHADERRESOURCES_VIEWS_EMPTY + 1), D3D11_MESSAGE_ID_DEVICE_CSGETSAMPLERS_SAMPLERS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_CSGETCONSTANTBUFFERS_BUFFERS_EMPTY + 1), D3D11_MESSAGE_ID_DEVICE_CREATEVERTEXSHADER_DOUBLEFLOATOPSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CSGETSAMPLERS_SAMPLERS_EMPTY + 1),
    D3D11_MESSAGE_ID_DEVICE_CREATEHULLSHADER_DOUBLEFLOATOPSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATEVERTEXSHADER_DOUBLEFLOATOPSNOTSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_CREATEDOMAINSHADER_DOUBLEFLOATOPSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATEHULLSHADER_DOUBLEFLOATOPSNOTSUPPORTED + 1),
    D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADER_DOUBLEFLOATOPSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATEDOMAINSHADER_DOUBLEFLOATOPSNOTSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DOUBLEFLOATOPSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADER_DOUBLEFLOATOPSNOTSUPPORTED + 1),
    D3D11_MESSAGE_ID_DEVICE_CREATEPIXELSHADER_DOUBLEFLOATOPSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DOUBLEFLOATOPSNOTSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_CREATECOMPUTESHADER_DOUBLEFLOATOPSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATEPIXELSHADER_DOUBLEFLOATOPSNOTSUPPORTED + 1),
    D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDSTRUCTURESTRIDE = (D3D11_MESSAGE_ID_DEVICE_CREATECOMPUTESHADER_DOUBLEFLOATOPSNOTSUPPORTED + 1), D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDFLAGS = (D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDSTRUCTURESTRIDE + 1), D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDRESOURCE = (D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDFLAGS + 1),
    D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDDESC = (D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDRESOURCE + 1), D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDFORMAT = (D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDDESC + 1), D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDDIMENSIONS = (D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDFORMAT + 1),
    D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_UNRECOGNIZEDFORMAT = (D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDDIMENSIONS + 1), D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETSANDUNORDEREDACCESSVIEWS_HAZARD = (D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_UNRECOGNIZEDFORMAT + 1),
    D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETSANDUNORDEREDACCESSVIEWS_OVERLAPPING_OLD_SLOTS = (D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETSANDUNORDEREDACCESSVIEWS_HAZARD + 1), D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETSANDUNORDEREDACCESSVIEWS_NO_OP = (D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETSANDUNORDEREDACCESSVIEWS_OVERLAPPING_OLD_SLOTS + 1),
    D3D11_MESSAGE_ID_CSSETUNORDEREDACCESSVIEWS_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETSANDUNORDEREDACCESSVIEWS_NO_OP + 1), D3D11_MESSAGE_ID_PSSETUNORDEREDACCESSVIEWS_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_CSSETUNORDEREDACCESSVIEWS_UNBINDDELETINGOBJECT + 1),
    D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDARG_RETURN = (D3D11_MESSAGE_ID_PSSETUNORDEREDACCESSVIEWS_UNBINDDELETINGOBJECT + 1), D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDARG_RETURN + 1), D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_TOOMANYOBJECTS = (D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_OUTOFMEMORY_RETURN + 1),
    D3D11_MESSAGE_ID_DEVICE_CSSETUNORDEREDACCESSVIEWS_HAZARD = (D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_TOOMANYOBJECTS + 1), D3D11_MESSAGE_ID_CLEARUNORDEREDACCESSVIEW_DENORMFLUSH = (D3D11_MESSAGE_ID_DEVICE_CSSETUNORDEREDACCESSVIEWS_HAZARD + 1), D3D11_MESSAGE_ID_DEVICE_CSSETUNORDEREDACCESSS_VIEWS_EMPTY = (D3D11_MESSAGE_ID_CLEARUNORDEREDACCESSVIEW_DENORMFLUSH + 1),
    D3D11_MESSAGE_ID_DEVICE_CSGETUNORDEREDACCESSS_VIEWS_EMPTY = (D3D11_MESSAGE_ID_DEVICE_CSSETUNORDEREDACCESSS_VIEWS_EMPTY + 1), D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDFLAGS = (D3D11_MESSAGE_ID_DEVICE_CSGETUNORDEREDACCESSS_VIEWS_EMPTY + 1), D3D11_MESSAGE_ID_CREATESHADERRESESOURCEVIEW_TOOMANYOBJECTS = (D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDFLAGS + 1),
    D3D11_MESSAGE_ID_DEVICE_DISPATCHINDIRECT_INVALID_ARG_BUFFER = (D3D11_MESSAGE_ID_CREATESHADERRESESOURCEVIEW_TOOMANYOBJECTS + 1), D3D11_MESSAGE_ID_DEVICE_DISPATCHINDIRECT_OFFSET_UNALIGNED = (D3D11_MESSAGE_ID_DEVICE_DISPATCHINDIRECT_INVALID_ARG_BUFFER + 1), D3D11_MESSAGE_ID_DEVICE_DISPATCHINDIRECT_OFFSET_OVERFLOW = (D3D11_MESSAGE_ID_DEVICE_DISPATCHINDIRECT_OFFSET_UNALIGNED + 1),
    D3D11_MESSAGE_ID_DEVICE_SETRESOURCEMINLOD_INVALIDCONTEXT = (D3D11_MESSAGE_ID_DEVICE_DISPATCHINDIRECT_OFFSET_OVERFLOW + 1), D3D11_MESSAGE_ID_DEVICE_SETRESOURCEMINLOD_INVALIDRESOURCE = (D3D11_MESSAGE_ID_DEVICE_SETRESOURCEMINLOD_INVALIDCONTEXT + 1), D3D11_MESSAGE_ID_DEVICE_SETRESOURCEMINLOD_INVALIDMINLOD = (D3D11_MESSAGE_ID_DEVICE_SETRESOURCEMINLOD_INVALIDRESOURCE + 1),
    D3D11_MESSAGE_ID_DEVICE_GETRESOURCEMINLOD_INVALIDCONTEXT = (D3D11_MESSAGE_ID_DEVICE_SETRESOURCEMINLOD_INVALIDMINLOD + 1), D3D11_MESSAGE_ID_DEVICE_GETRESOURCEMINLOD_INVALIDRESOURCE = (D3D11_MESSAGE_ID_DEVICE_GETRESOURCEMINLOD_INVALIDCONTEXT + 1), D3D11_MESSAGE_ID_OMSETDEPTHSTENCIL_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_DEVICE_GETRESOURCEMINLOD_INVALIDRESOURCE + 1),
    D3D11_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_DEPTH_READONLY = (D3D11_MESSAGE_ID_OMSETDEPTHSTENCIL_UNBINDDELETINGOBJECT + 1), D3D11_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_STENCIL_READONLY = (D3D11_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_DEPTH_READONLY + 1), D3D11_MESSAGE_ID_CHECKFEATURESUPPORT_FORMAT_DEPRECATED = (D3D11_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_STENCIL_READONLY + 1),
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_RETURN_TYPE_MISMATCH = (D3D11_MESSAGE_ID_CHECKFEATURESUPPORT_FORMAT_DEPRECATED + 1), D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_NOT_SET = (D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_RETURN_TYPE_MISMATCH + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_UNORDEREDACCESSVIEW_RENDERTARGETVIEW_OVERLAP = (D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_NOT_SET + 1),
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_DIMENSION_MISMATCH = (D3D11_MESSAGE_ID_DEVICE_DRAW_UNORDEREDACCESSVIEW_RENDERTARGETVIEW_OVERLAP + 1), D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_APPEND_UNSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_DIMENSION_MISMATCH + 1),
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMICS_UNSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_APPEND_UNSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_STRUCTURE_STRIDE_MISMATCH = (D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMICS_UNSUPPORTED + 1),
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_BUFFER_TYPE_MISMATCH = (D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_STRUCTURE_STRIDE_MISMATCH + 1), D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_RAW_UNSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_BUFFER_TYPE_MISMATCH + 1),
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_FORMAT_LD_UNSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_RAW_UNSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_FORMAT_STORE_UNSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_FORMAT_LD_UNSUPPORTED + 1),
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMIC_ADD_UNSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_FORMAT_STORE_UNSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMIC_BITWISE_OPS_UNSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMIC_ADD_UNSUPPORTED + 1),
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMIC_CMPSTORE_CMPEXCHANGE_UNSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMIC_BITWISE_OPS_UNSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMIC_EXCHANGE_UNSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMIC_CMPSTORE_CMPEXCHANGE_UNSUPPORTED + 1),
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMIC_SIGNED_MINMAX_UNSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMIC_EXCHANGE_UNSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMIC_UNSIGNED_MINMAX_UNSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMIC_SIGNED_MINMAX_UNSUPPORTED + 1),
    D3D11_MESSAGE_ID_DEVICE_DISPATCH_BOUND_RESOURCE_MAPPED = (D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_ATOMIC_UNSIGNED_MINMAX_UNSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_DISPATCH_THREADGROUPCOUNT_OVERFLOW = (D3D11_MESSAGE_ID_DEVICE_DISPATCH_BOUND_RESOURCE_MAPPED + 1), D3D11_MESSAGE_ID_DEVICE_DISPATCH_THREADGROUPCOUNT_ZERO = (D3D11_MESSAGE_ID_DEVICE_DISPATCH_THREADGROUPCOUNT_OVERFLOW + 1),
    D3D11_MESSAGE_ID_DEVICE_SHADERRESOURCEVIEW_STRUCTURE_STRIDE_MISMATCH = (D3D11_MESSAGE_ID_DEVICE_DISPATCH_THREADGROUPCOUNT_ZERO + 1), D3D11_MESSAGE_ID_DEVICE_SHADERRESOURCEVIEW_BUFFER_TYPE_MISMATCH = (D3D11_MESSAGE_ID_DEVICE_SHADERRESOURCEVIEW_STRUCTURE_STRIDE_MISMATCH + 1),
    D3D11_MESSAGE_ID_DEVICE_SHADERRESOURCEVIEW_RAW_UNSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_SHADERRESOURCEVIEW_BUFFER_TYPE_MISMATCH + 1), D3D11_MESSAGE_ID_DEVICE_DISPATCH_UNSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_SHADERRESOURCEVIEW_RAW_UNSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_DISPATCHINDIRECT_UNSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_DISPATCH_UNSUPPORTED + 1),
    D3D11_MESSAGE_ID_COPYSTRUCTURECOUNT_INVALIDOFFSET = (D3D11_MESSAGE_ID_DEVICE_DISPATCHINDIRECT_UNSUPPORTED + 1), D3D11_MESSAGE_ID_COPYSTRUCTURECOUNT_LARGEOFFSET = (D3D11_MESSAGE_ID_COPYSTRUCTURECOUNT_INVALIDOFFSET + 1), D3D11_MESSAGE_ID_COPYSTRUCTURECOUNT_INVALIDDESTINATIONSTATE = (D3D11_MESSAGE_ID_COPYSTRUCTURECOUNT_LARGEOFFSET + 1),
    D3D11_MESSAGE_ID_COPYSTRUCTURECOUNT_INVALIDSOURCESTATE = (D3D11_MESSAGE_ID_COPYSTRUCTURECOUNT_INVALIDDESTINATIONSTATE + 1), D3D11_MESSAGE_ID_CHECKFORMATSUPPORT_FORMAT_NOT_SUPPORTED = (D3D11_MESSAGE_ID_COPYSTRUCTURECOUNT_INVALIDSOURCESTATE + 1), D3D11_MESSAGE_ID_DEVICE_CSSETUNORDEREDACCESSVIEWS_INVALIDVIEW = (D3D11_MESSAGE_ID_CHECKFORMATSUPPORT_FORMAT_NOT_SUPPORTED + 1),
    D3D11_MESSAGE_ID_DEVICE_CSSETUNORDEREDACCESSVIEWS_INVALIDOFFSET = (D3D11_MESSAGE_ID_DEVICE_CSSETUNORDEREDACCESSVIEWS_INVALIDVIEW + 1), D3D11_MESSAGE_ID_DEVICE_CSSETUNORDEREDACCESSVIEWS_TOOMANYVIEWS = (D3D11_MESSAGE_ID_DEVICE_CSSETUNORDEREDACCESSVIEWS_INVALIDOFFSET + 1),
    D3D11_MESSAGE_ID_CLEARUNORDEREDACCESSVIEWFLOAT_INVALIDFORMAT = (D3D11_MESSAGE_ID_DEVICE_CSSETUNORDEREDACCESSVIEWS_TOOMANYVIEWS + 1), D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_COUNTER_UNSUPPORTED = (D3D11_MESSAGE_ID_CLEARUNORDEREDACCESSVIEWFLOAT_INVALIDFORMAT + 1), D3D11_MESSAGE_ID_REF_WARNING = (D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_COUNTER_UNSUPPORTED + 1),
    D3D11_MESSAGE_ID_DEVICE_DRAW_PIXEL_SHADER_WITHOUT_RTV_OR_DSV = (D3D11_MESSAGE_ID_REF_WARNING + 1), D3D11_MESSAGE_ID_SHADER_ABORT = (D3D11_MESSAGE_ID_DEVICE_DRAW_PIXEL_SHADER_WITHOUT_RTV_OR_DSV + 1), D3D11_MESSAGE_ID_SHADER_MESSAGE = (D3D11_MESSAGE_ID_SHADER_ABORT + 1), D3D11_MESSAGE_ID_SHADER_ERROR = (D3D11_MESSAGE_ID_SHADER_MESSAGE + 1),
    D3D11_MESSAGE_ID_OFFERRESOURCES_INVALIDRESOURCE = (D3D11_MESSAGE_ID_SHADER_ERROR + 1), D3D11_MESSAGE_ID_HSSETSAMPLERS_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_OFFERRESOURCES_INVALIDRESOURCE + 1), D3D11_MESSAGE_ID_DSSETSAMPLERS_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_HSSETSAMPLERS_UNBINDDELETINGOBJECT + 1),
    D3D11_MESSAGE_ID_CSSETSAMPLERS_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_DSSETSAMPLERS_UNBINDDELETINGOBJECT + 1), D3D11_MESSAGE_ID_HSSETSHADER_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_CSSETSAMPLERS_UNBINDDELETINGOBJECT + 1), D3D11_MESSAGE_ID_DSSETSHADER_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_HSSETSHADER_UNBINDDELETINGOBJECT + 1),
    D3D11_MESSAGE_ID_CSSETSHADER_UNBINDDELETINGOBJECT = (D3D11_MESSAGE_ID_DSSETSHADER_UNBINDDELETINGOBJECT + 1), D3D11_MESSAGE_ID_ENQUEUESETEVENT_INVALIDARG_RETURN = (D3D11_MESSAGE_ID_CSSETSHADER_UNBINDDELETINGOBJECT + 1), D3D11_MESSAGE_ID_ENQUEUESETEVENT_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_ENQUEUESETEVENT_INVALIDARG_RETURN + 1),
    D3D11_MESSAGE_ID_ENQUEUESETEVENT_ACCESSDENIED_RETURN = (D3D11_MESSAGE_ID_ENQUEUESETEVENT_OUTOFMEMORY_RETURN + 1), D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETSANDUNORDEREDACCESSVIEWS_NUMUAVS_INVALIDRANGE = (D3D11_MESSAGE_ID_ENQUEUESETEVENT_ACCESSDENIED_RETURN + 1),
    D3D11_MESSAGE_ID_USE_OF_ZERO_REFCOUNT_OBJECT = (D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETSANDUNORDEREDACCESSVIEWS_NUMUAVS_INVALIDRANGE + 1), D3D11_MESSAGE_ID_D3D11_MESSAGES_END = (D3D11_MESSAGE_ID_USE_OF_ZERO_REFCOUNT_OBJECT + 1), D3D11_MESSAGE_ID_D3D11_1_MESSAGES_START = $300000, D3D11_MESSAGE_ID_CREATE_VIDEODECODER = (D3D11_MESSAGE_ID_D3D11_1_MESSAGES_START + 1),
    D3D11_MESSAGE_ID_CREATE_VIDEOPROCESSORENUM = (D3D11_MESSAGE_ID_CREATE_VIDEODECODER + 1), D3D11_MESSAGE_ID_CREATE_VIDEOPROCESSOR = (D3D11_MESSAGE_ID_CREATE_VIDEOPROCESSORENUM + 1), D3D11_MESSAGE_ID_CREATE_DECODEROUTPUTVIEW = (D3D11_MESSAGE_ID_CREATE_VIDEOPROCESSOR + 1), D3D11_MESSAGE_ID_CREATE_PROCESSORINPUTVIEW = (D3D11_MESSAGE_ID_CREATE_DECODEROUTPUTVIEW + 1),
    D3D11_MESSAGE_ID_CREATE_PROCESSOROUTPUTVIEW = (D3D11_MESSAGE_ID_CREATE_PROCESSORINPUTVIEW + 1), D3D11_MESSAGE_ID_CREATE_DEVICECONTEXTSTATE = (D3D11_MESSAGE_ID_CREATE_PROCESSOROUTPUTVIEW + 1), D3D11_MESSAGE_ID_LIVE_VIDEODECODER = (D3D11_MESSAGE_ID_CREATE_DEVICECONTEXTSTATE + 1), D3D11_MESSAGE_ID_LIVE_VIDEOPROCESSORENUM = (D3D11_MESSAGE_ID_LIVE_VIDEODECODER + 1),
    D3D11_MESSAGE_ID_LIVE_VIDEOPROCESSOR = (D3D11_MESSAGE_ID_LIVE_VIDEOPROCESSORENUM + 1), D3D11_MESSAGE_ID_LIVE_DECODEROUTPUTVIEW = (D3D11_MESSAGE_ID_LIVE_VIDEOPROCESSOR + 1), D3D11_MESSAGE_ID_LIVE_PROCESSORINPUTVIEW = (D3D11_MESSAGE_ID_LIVE_DECODEROUTPUTVIEW + 1), D3D11_MESSAGE_ID_LIVE_PROCESSOROUTPUTVIEW = (D3D11_MESSAGE_ID_LIVE_PROCESSORINPUTVIEW + 1),
    D3D11_MESSAGE_ID_LIVE_DEVICECONTEXTSTATE = (D3D11_MESSAGE_ID_LIVE_PROCESSOROUTPUTVIEW + 1), D3D11_MESSAGE_ID_DESTROY_VIDEODECODER = (D3D11_MESSAGE_ID_LIVE_DEVICECONTEXTSTATE + 1), D3D11_MESSAGE_ID_DESTROY_VIDEOPROCESSORENUM = (D3D11_MESSAGE_ID_DESTROY_VIDEODECODER + 1), D3D11_MESSAGE_ID_DESTROY_VIDEOPROCESSOR = (D3D11_MESSAGE_ID_DESTROY_VIDEOPROCESSORENUM + 1),
    D3D11_MESSAGE_ID_DESTROY_DECODEROUTPUTVIEW = (D3D11_MESSAGE_ID_DESTROY_VIDEOPROCESSOR + 1), D3D11_MESSAGE_ID_DESTROY_PROCESSORINPUTVIEW = (D3D11_MESSAGE_ID_DESTROY_DECODEROUTPUTVIEW + 1), D3D11_MESSAGE_ID_DESTROY_PROCESSOROUTPUTVIEW = (D3D11_MESSAGE_ID_DESTROY_PROCESSORINPUTVIEW + 1), D3D11_MESSAGE_ID_DESTROY_DEVICECONTEXTSTATE = (D3D11_MESSAGE_ID_DESTROY_PROCESSOROUTPUTVIEW + 1),
    D3D11_MESSAGE_ID_CREATEDEVICECONTEXTSTATE_INVALIDFLAGS = (D3D11_MESSAGE_ID_DESTROY_DEVICECONTEXTSTATE + 1), D3D11_MESSAGE_ID_CREATEDEVICECONTEXTSTATE_INVALIDFEATURELEVEL = (D3D11_MESSAGE_ID_CREATEDEVICECONTEXTSTATE_INVALIDFLAGS + 1), D3D11_MESSAGE_ID_CREATEDEVICECONTEXTSTATE_FEATURELEVELS_NOT_SUPPORTED = (D3D11_MESSAGE_ID_CREATEDEVICECONTEXTSTATE_INVALIDFEATURELEVEL + 1),
    D3D11_MESSAGE_ID_CREATEDEVICECONTEXTSTATE_INVALIDREFIID = (D3D11_MESSAGE_ID_CREATEDEVICECONTEXTSTATE_FEATURELEVELS_NOT_SUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_DISCARDVIEW_INVALIDVIEW = (D3D11_MESSAGE_ID_CREATEDEVICECONTEXTSTATE_INVALIDREFIID + 1), D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION1_INVALIDCOPYFLAGS = (D3D11_MESSAGE_ID_DEVICE_DISCARDVIEW_INVALIDVIEW + 1),
    D3D11_MESSAGE_ID_UPDATESUBRESOURCE1_INVALIDCOPYFLAGS = (D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION1_INVALIDCOPYFLAGS + 1), D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDFORCEDSAMPLECOUNT = (D3D11_MESSAGE_ID_UPDATESUBRESOURCE1_INVALIDCOPYFLAGS + 1), D3D11_MESSAGE_ID_CREATEVIDEODECODER_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDFORCEDSAMPLECOUNT + 1),
    D3D11_MESSAGE_ID_CREATEVIDEODECODER_NULLPARAM = (D3D11_MESSAGE_ID_CREATEVIDEODECODER_OUTOFMEMORY_RETURN + 1), D3D11_MESSAGE_ID_CREATEVIDEODECODER_INVALIDFORMAT = (D3D11_MESSAGE_ID_CREATEVIDEODECODER_NULLPARAM + 1), D3D11_MESSAGE_ID_CREATEVIDEODECODER_ZEROWIDTHHEIGHT = (D3D11_MESSAGE_ID_CREATEVIDEODECODER_INVALIDFORMAT + 1),
    D3D11_MESSAGE_ID_CREATEVIDEODECODER_DRIVER_INVALIDBUFFERSIZE = (D3D11_MESSAGE_ID_CREATEVIDEODECODER_ZEROWIDTHHEIGHT + 1), D3D11_MESSAGE_ID_CREATEVIDEODECODER_DRIVER_INVALIDBUFFERUSAGE = (D3D11_MESSAGE_ID_CREATEVIDEODECODER_DRIVER_INVALIDBUFFERSIZE + 1), D3D11_MESSAGE_ID_GETVIDEODECODERPROFILECOUNT_OUTOFMEMORY = (D3D11_MESSAGE_ID_CREATEVIDEODECODER_DRIVER_INVALIDBUFFERUSAGE + 1),
    D3D11_MESSAGE_ID_GETVIDEODECODERPROFILE_NULLPARAM = (D3D11_MESSAGE_ID_GETVIDEODECODERPROFILECOUNT_OUTOFMEMORY + 1), D3D11_MESSAGE_ID_GETVIDEODECODERPROFILE_INVALIDINDEX = (D3D11_MESSAGE_ID_GETVIDEODECODERPROFILE_NULLPARAM + 1), D3D11_MESSAGE_ID_GETVIDEODECODERPROFILE_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_GETVIDEODECODERPROFILE_INVALIDINDEX + 1),
    D3D11_MESSAGE_ID_CHECKVIDEODECODERFORMAT_NULLPARAM = (D3D11_MESSAGE_ID_GETVIDEODECODERPROFILE_OUTOFMEMORY_RETURN + 1), D3D11_MESSAGE_ID_CHECKVIDEODECODERFORMAT_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_CHECKVIDEODECODERFORMAT_NULLPARAM + 1), D3D11_MESSAGE_ID_GETVIDEODECODERCONFIGCOUNT_NULLPARAM = (D3D11_MESSAGE_ID_CHECKVIDEODECODERFORMAT_OUTOFMEMORY_RETURN + 1),
    D3D11_MESSAGE_ID_GETVIDEODECODERCONFIGCOUNT_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_GETVIDEODECODERCONFIGCOUNT_NULLPARAM + 1), D3D11_MESSAGE_ID_GETVIDEODECODERCONFIG_NULLPARAM = (D3D11_MESSAGE_ID_GETVIDEODECODERCONFIGCOUNT_OUTOFMEMORY_RETURN + 1), D3D11_MESSAGE_ID_GETVIDEODECODERCONFIG_INVALIDINDEX = (D3D11_MESSAGE_ID_GETVIDEODECODERCONFIG_NULLPARAM + 1),
    D3D11_MESSAGE_ID_GETVIDEODECODERCONFIG_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_GETVIDEODECODERCONFIG_INVALIDINDEX + 1), D3D11_MESSAGE_ID_GETDECODERCREATIONPARAMS_NULLPARAM = (D3D11_MESSAGE_ID_GETVIDEODECODERCONFIG_OUTOFMEMORY_RETURN + 1), D3D11_MESSAGE_ID_GETDECODERDRIVERHANDLE_NULLPARAM = (D3D11_MESSAGE_ID_GETDECODERCREATIONPARAMS_NULLPARAM + 1),
    D3D11_MESSAGE_ID_GETDECODERBUFFER_NULLPARAM = (D3D11_MESSAGE_ID_GETDECODERDRIVERHANDLE_NULLPARAM + 1), D3D11_MESSAGE_ID_GETDECODERBUFFER_INVALIDBUFFER = (D3D11_MESSAGE_ID_GETDECODERBUFFER_NULLPARAM + 1), D3D11_MESSAGE_ID_GETDECODERBUFFER_INVALIDTYPE = (D3D11_MESSAGE_ID_GETDECODERBUFFER_INVALIDBUFFER + 1),
    D3D11_MESSAGE_ID_GETDECODERBUFFER_LOCKED = (D3D11_MESSAGE_ID_GETDECODERBUFFER_INVALIDTYPE + 1), D3D11_MESSAGE_ID_RELEASEDECODERBUFFER_NULLPARAM = (D3D11_MESSAGE_ID_GETDECODERBUFFER_LOCKED + 1), D3D11_MESSAGE_ID_RELEASEDECODERBUFFER_INVALIDTYPE = (D3D11_MESSAGE_ID_RELEASEDECODERBUFFER_NULLPARAM + 1),
    D3D11_MESSAGE_ID_RELEASEDECODERBUFFER_NOTLOCKED = (D3D11_MESSAGE_ID_RELEASEDECODERBUFFER_INVALIDTYPE + 1), D3D11_MESSAGE_ID_DECODERBEGINFRAME_NULLPARAM = (D3D11_MESSAGE_ID_RELEASEDECODERBUFFER_NOTLOCKED + 1), D3D11_MESSAGE_ID_DECODERBEGINFRAME_HAZARD = (D3D11_MESSAGE_ID_DECODERBEGINFRAME_NULLPARAM + 1),
    D3D11_MESSAGE_ID_DECODERENDFRAME_NULLPARAM = (D3D11_MESSAGE_ID_DECODERBEGINFRAME_HAZARD + 1), D3D11_MESSAGE_ID_SUBMITDECODERBUFFERS_NULLPARAM = (D3D11_MESSAGE_ID_DECODERENDFRAME_NULLPARAM + 1), D3D11_MESSAGE_ID_SUBMITDECODERBUFFERS_INVALIDTYPE = (D3D11_MESSAGE_ID_SUBMITDECODERBUFFERS_NULLPARAM + 1),
    D3D11_MESSAGE_ID_DECODEREXTENSION_NULLPARAM = (D3D11_MESSAGE_ID_SUBMITDECODERBUFFERS_INVALIDTYPE + 1), D3D11_MESSAGE_ID_DECODEREXTENSION_INVALIDRESOURCE = (D3D11_MESSAGE_ID_DECODEREXTENSION_NULLPARAM + 1), D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_DECODEREXTENSION_INVALIDRESOURCE + 1),
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_NULLPARAM = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_OUTOFMEMORY_RETURN + 1), D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_INVALIDFRAMEFORMAT = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_NULLPARAM + 1),
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_INVALIDUSAGE = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_INVALIDFRAMEFORMAT + 1), D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_INVALIDINPUTFRAMERATE = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_INVALIDUSAGE + 1),
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_INVALIDOUTPUTFRAMERATE = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_INVALIDINPUTFRAMERATE + 1), D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_INVALIDWIDTHHEIGHT = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_INVALIDOUTPUTFRAMERATE + 1),
    D3D11_MESSAGE_ID_GETVIDEOPROCESSORCONTENTDESC_NULLPARAM = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORENUMERATOR_INVALIDWIDTHHEIGHT + 1), D3D11_MESSAGE_ID_CHECKVIDEOPROCESSORFORMAT_NULLPARAM = (D3D11_MESSAGE_ID_GETVIDEOPROCESSORCONTENTDESC_NULLPARAM + 1), D3D11_MESSAGE_ID_GETVIDEOPROCESSORCAPS_NULLPARAM = (D3D11_MESSAGE_ID_CHECKVIDEOPROCESSORFORMAT_NULLPARAM + 1),
    D3D11_MESSAGE_ID_GETVIDEOPROCESSORRATECONVERSIONCAPS_NULLPARAM = (D3D11_MESSAGE_ID_GETVIDEOPROCESSORCAPS_NULLPARAM + 1), D3D11_MESSAGE_ID_GETVIDEOPROCESSORRATECONVERSIONCAPS_INVALIDINDEX = (D3D11_MESSAGE_ID_GETVIDEOPROCESSORRATECONVERSIONCAPS_NULLPARAM + 1), D3D11_MESSAGE_ID_GETVIDEOPROCESSORCUSTOMRATE_NULLPARAM = (D3D11_MESSAGE_ID_GETVIDEOPROCESSORRATECONVERSIONCAPS_INVALIDINDEX + 1),
    D3D11_MESSAGE_ID_GETVIDEOPROCESSORCUSTOMRATE_INVALIDINDEX = (D3D11_MESSAGE_ID_GETVIDEOPROCESSORCUSTOMRATE_NULLPARAM + 1), D3D11_MESSAGE_ID_GETVIDEOPROCESSORFILTERRANGE_NULLPARAM = (D3D11_MESSAGE_ID_GETVIDEOPROCESSORCUSTOMRATE_INVALIDINDEX + 1), D3D11_MESSAGE_ID_GETVIDEOPROCESSORFILTERRANGE_UNSUPPORTED = (D3D11_MESSAGE_ID_GETVIDEOPROCESSORFILTERRANGE_NULLPARAM + 1),
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOR_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_GETVIDEOPROCESSORFILTERRANGE_UNSUPPORTED + 1), D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOR_NULLPARAM = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOR_OUTOFMEMORY_RETURN + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTTARGETRECT_NULLPARAM = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOR_NULLPARAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTBACKGROUNDCOLOR_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTTARGETRECT_NULLPARAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTBACKGROUNDCOLOR_INVALIDALPHA = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTBACKGROUNDCOLOR_NULLPARAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTCOLORSPACE_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTBACKGROUNDCOLOR_INVALIDALPHA + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTALPHAFILLMODE_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTCOLORSPACE_NULLPARAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTALPHAFILLMODE_UNSUPPORTED = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTALPHAFILLMODE_NULLPARAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTALPHAFILLMODE_INVALIDSTREAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTALPHAFILLMODE_UNSUPPORTED + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTALPHAFILLMODE_INVALIDFILLMODE = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTALPHAFILLMODE_INVALIDSTREAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTCONSTRICTION_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTALPHAFILLMODE_INVALIDFILLMODE + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTSTEREOMODE_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTCONSTRICTION_NULLPARAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTSTEREOMODE_UNSUPPORTED = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTSTEREOMODE_NULLPARAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTEXTENSION_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTSTEREOMODE_UNSUPPORTED + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTTARGETRECT_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTEXTENSION_NULLPARAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTBACKGROUNDCOLOR_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTTARGETRECT_NULLPARAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTCOLORSPACE_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTBACKGROUNDCOLOR_NULLPARAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTALPHAFILLMODE_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTCOLORSPACE_NULLPARAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTCONSTRICTION_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTALPHAFILLMODE_NULLPARAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTCONSTRICTION_UNSUPPORTED = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTCONSTRICTION_NULLPARAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTCONSTRICTION_INVALIDSIZE = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTCONSTRICTION_UNSUPPORTED + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTSTEREOMODE_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTCONSTRICTION_INVALIDSIZE + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTEXTENSION_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTSTEREOMODE_NULLPARAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFRAMEFORMAT_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTEXTENSION_NULLPARAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFRAMEFORMAT_INVALIDFORMAT = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFRAMEFORMAT_NULLPARAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFRAMEFORMAT_INVALIDSTREAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFRAMEFORMAT_INVALIDFORMAT + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMCOLORSPACE_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFRAMEFORMAT_INVALIDSTREAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMCOLORSPACE_INVALIDSTREAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMCOLORSPACE_NULLPARAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMOUTPUTRATE_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMCOLORSPACE_INVALIDSTREAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMOUTPUTRATE_INVALIDRATE = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMOUTPUTRATE_NULLPARAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMOUTPUTRATE_INVALIDFLAG = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMOUTPUTRATE_INVALIDRATE + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMOUTPUTRATE_INVALIDSTREAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMOUTPUTRATE_INVALIDFLAG + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSOURCERECT_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMOUTPUTRATE_INVALIDSTREAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSOURCERECT_INVALIDSTREAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSOURCERECT_NULLPARAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSOURCERECT_INVALIDRECT = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSOURCERECT_INVALIDSTREAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMDESTRECT_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSOURCERECT_INVALIDRECT + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMDESTRECT_INVALIDSTREAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMDESTRECT_NULLPARAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMDESTRECT_INVALIDRECT = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMDESTRECT_INVALIDSTREAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMALPHA_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMDESTRECT_INVALIDRECT + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMALPHA_INVALIDSTREAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMALPHA_NULLPARAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMALPHA_INVALIDALPHA = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMALPHA_INVALIDSTREAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPALETTE_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMALPHA_INVALIDALPHA + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPALETTE_INVALIDSTREAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPALETTE_NULLPARAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPALETTE_INVALIDCOUNT = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPALETTE_INVALIDSTREAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPALETTE_INVALIDALPHA = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPALETTE_INVALIDCOUNT + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPIXELASPECTRATIO_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPALETTE_INVALIDALPHA + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPIXELASPECTRATIO_INVALIDSTREAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPIXELASPECTRATIO_NULLPARAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPIXELASPECTRATIO_INVALIDRATIO = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPIXELASPECTRATIO_INVALIDSTREAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMLUMAKEY_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPIXELASPECTRATIO_INVALIDRATIO + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMLUMAKEY_INVALIDSTREAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMLUMAKEY_NULLPARAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMLUMAKEY_INVALIDRANGE = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMLUMAKEY_INVALIDSTREAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMLUMAKEY_UNSUPPORTED = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMLUMAKEY_INVALIDRANGE + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMLUMAKEY_UNSUPPORTED + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_INVALIDSTREAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_NULLPARAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_UNSUPPORTED = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_INVALIDSTREAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_FLIPUNSUPPORTED = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_UNSUPPORTED + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_MONOOFFSETUNSUPPORTED = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_FLIPUNSUPPORTED + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_FORMATUNSUPPORTED = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_MONOOFFSETUNSUPPORTED + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_INVALIDFORMAT = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_FORMATUNSUPPORTED + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMAUTOPROCESSINGMODE_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMSTEREOFORMAT_INVALIDFORMAT + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMAUTOPROCESSINGMODE_INVALIDSTREAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMAUTOPROCESSINGMODE_NULLPARAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFILTER_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMAUTOPROCESSINGMODE_INVALIDSTREAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFILTER_INVALIDSTREAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFILTER_NULLPARAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFILTER_INVALIDFILTER = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFILTER_INVALIDSTREAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFILTER_UNSUPPORTED = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFILTER_INVALIDFILTER + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFILTER_INVALIDLEVEL = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFILTER_UNSUPPORTED + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMEXTENSION_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMFILTER_INVALIDLEVEL + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMEXTENSION_INVALIDSTREAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMEXTENSION_NULLPARAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMFRAMEFORMAT_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMEXTENSION_INVALIDSTREAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMCOLORSPACE_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMFRAMEFORMAT_NULLPARAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMOUTPUTRATE_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMCOLORSPACE_NULLPARAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMSOURCERECT_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMOUTPUTRATE_NULLPARAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMDESTRECT_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMSOURCERECT_NULLPARAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMALPHA_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMDESTRECT_NULLPARAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMPALETTE_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMALPHA_NULLPARAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMPIXELASPECTRATIO_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMPALETTE_NULLPARAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMLUMAKEY_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMPIXELASPECTRATIO_NULLPARAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMSTEREOFORMAT_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMLUMAKEY_NULLPARAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMAUTOPROCESSINGMODE_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMSTEREOFORMAT_NULLPARAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMFILTER_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMAUTOPROCESSINGMODE_NULLPARAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMEXTENSION_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMFILTER_NULLPARAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMEXTENSION_INVALIDSTREAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMEXTENSION_NULLPARAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMEXTENSION_INVALIDSTREAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDSTREAMCOUNT = (D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_NULLPARAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_TARGETRECT = (D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDSTREAMCOUNT + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDOUTPUT = (D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_TARGETRECT + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDPASTFRAMES = (D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDOUTPUT + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDFUTUREFRAMES = (D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDPASTFRAMES + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDSOURCERECT = (D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDFUTUREFRAMES + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDDESTRECT = (D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDSOURCERECT + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDINPUTRESOURCE = (D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDDESTRECT + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDARRAYSIZE = (D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDINPUTRESOURCE + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDARRAY = (D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDARRAYSIZE + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_RIGHTEXPECTED = (D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDARRAY + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_RIGHTNOTEXPECTED = (D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_RIGHTEXPECTED + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_STEREONOTENABLED = (D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_RIGHTNOTEXPECTED + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDRIGHTRESOURCE = (D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_STEREONOTENABLED + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_NOSTEREOSTREAMS = (D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INVALIDRIGHTRESOURCE + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INPUTHAZARD = (D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_NOSTEREOSTREAMS + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_OUTPUTHAZARD = (D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_INPUTHAZARD + 1), D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_VIDEOPROCESSORBLT_OUTPUTHAZARD + 1),
    D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_NULLPARAM = (D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_OUTOFMEMORY_RETURN + 1), D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_INVALIDTYPE = (D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_NULLPARAM + 1), D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_INVALIDBIND = (D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_INVALIDTYPE + 1),
    D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_UNSUPPORTEDFORMAT = (D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_INVALIDBIND + 1), D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_INVALIDMIP = (D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_UNSUPPORTEDFORMAT + 1), D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_UNSUPPORTEMIP = (D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_INVALIDMIP + 1),
    D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_INVALIDARRAYSIZE = (D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_UNSUPPORTEMIP + 1), D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_INVALIDARRAY = (D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_INVALIDARRAYSIZE + 1), D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_INVALIDDIMENSION = (D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_INVALIDARRAY + 1),
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_CREATEVIDEODECODEROUTPUTVIEW_INVALIDDIMENSION + 1), D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_NULLPARAM = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_OUTOFMEMORY_RETURN + 1), D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDTYPE = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_NULLPARAM + 1),
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDBIND = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDTYPE + 1), D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDMISC = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDBIND + 1), D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDUSAGE = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDMISC + 1),
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDFORMAT = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDUSAGE + 1), D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDFOURCC = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDFORMAT + 1), D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDMIP = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDFOURCC + 1),
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_UNSUPPORTEDMIP = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDMIP + 1), D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDARRAYSIZE = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_UNSUPPORTEDMIP + 1), D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDARRAY = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDARRAYSIZE + 1),
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDDIMENSION = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDARRAY + 1), D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDDIMENSION + 1),
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_NULLPARAM = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_OUTOFMEMORY_RETURN + 1), D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDTYPE = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_NULLPARAM + 1), D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDBIND = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDTYPE + 1),
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDFORMAT = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDBIND + 1), D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDMIP = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDFORMAT + 1), D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_UNSUPPORTEDMIP = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDMIP + 1),
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_UNSUPPORTEDARRAY = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_UNSUPPORTEDMIP + 1), D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDARRAY = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_UNSUPPORTEDARRAY + 1),
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDDIMENSION = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDARRAY + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_INVALID_USE_OF_FORCED_SAMPLE_COUNT = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDDIMENSION + 1), D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDLOGICOPS = (D3D11_MESSAGE_ID_DEVICE_DRAW_INVALID_USE_OF_FORCED_SAMPLE_COUNT + 1),
    D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDDARRAYWITHDECODER = (D3D11_MESSAGE_ID_CREATEBLENDSTATE_INVALIDLOGICOPS + 1), D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDDARRAYWITHDECODER = (D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDDARRAYWITHDECODER + 1),
    D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDDARRAYWITHDECODER = (D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDDARRAYWITHDECODER + 1), D3D11_MESSAGE_ID_DEVICE_LOCKEDOUT_INTERFACE = (D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDDARRAYWITHDECODER + 1), D3D11_MESSAGE_ID_REF_WARNING_ATOMIC_INCONSISTENT = (D3D11_MESSAGE_ID_DEVICE_LOCKEDOUT_INTERFACE + 1),
    D3D11_MESSAGE_ID_REF_WARNING_READING_UNINITIALIZED_RESOURCE = (D3D11_MESSAGE_ID_REF_WARNING_ATOMIC_INCONSISTENT + 1), D3D11_MESSAGE_ID_REF_WARNING_RAW_HAZARD = (D3D11_MESSAGE_ID_REF_WARNING_READING_UNINITIALIZED_RESOURCE + 1), D3D11_MESSAGE_ID_REF_WARNING_WAR_HAZARD = (D3D11_MESSAGE_ID_REF_WARNING_RAW_HAZARD + 1),
    D3D11_MESSAGE_ID_REF_WARNING_WAW_HAZARD = (D3D11_MESSAGE_ID_REF_WARNING_WAR_HAZARD + 1), D3D11_MESSAGE_ID_CREATECRYPTOSESSION_NULLPARAM = (D3D11_MESSAGE_ID_REF_WARNING_WAW_HAZARD + 1), D3D11_MESSAGE_ID_CREATECRYPTOSESSION_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_CREATECRYPTOSESSION_NULLPARAM + 1),
    D3D11_MESSAGE_ID_GETCRYPTOTYPE_NULLPARAM = (D3D11_MESSAGE_ID_CREATECRYPTOSESSION_OUTOFMEMORY_RETURN + 1), D3D11_MESSAGE_ID_GETDECODERPROFILE_NULLPARAM = (D3D11_MESSAGE_ID_GETCRYPTOTYPE_NULLPARAM + 1), D3D11_MESSAGE_ID_GETCRYPTOSESSIONCERTIFICATESIZE_NULLPARAM = (D3D11_MESSAGE_ID_GETDECODERPROFILE_NULLPARAM + 1),
    D3D11_MESSAGE_ID_GETCRYPTOSESSIONCERTIFICATE_NULLPARAM = (D3D11_MESSAGE_ID_GETCRYPTOSESSIONCERTIFICATESIZE_NULLPARAM + 1), D3D11_MESSAGE_ID_GETCRYPTOSESSIONCERTIFICATE_WRONGSIZE = (D3D11_MESSAGE_ID_GETCRYPTOSESSIONCERTIFICATE_NULLPARAM + 1), D3D11_MESSAGE_ID_GETCRYPTOSESSIONHANDLE_WRONGSIZE = (D3D11_MESSAGE_ID_GETCRYPTOSESSIONCERTIFICATE_WRONGSIZE + 1),
    D3D11_MESSAGE_ID_NEGOTIATECRPYTOSESSIONKEYEXCHANGE_NULLPARAM = (D3D11_MESSAGE_ID_GETCRYPTOSESSIONHANDLE_WRONGSIZE + 1), D3D11_MESSAGE_ID_ENCRYPTIONBLT_UNSUPPORTED = (D3D11_MESSAGE_ID_NEGOTIATECRPYTOSESSIONKEYEXCHANGE_NULLPARAM + 1), D3D11_MESSAGE_ID_ENCRYPTIONBLT_NULLPARAM = (D3D11_MESSAGE_ID_ENCRYPTIONBLT_UNSUPPORTED + 1),
    D3D11_MESSAGE_ID_ENCRYPTIONBLT_SRC_WRONGDEVICE = (D3D11_MESSAGE_ID_ENCRYPTIONBLT_NULLPARAM + 1), D3D11_MESSAGE_ID_ENCRYPTIONBLT_DST_WRONGDEVICE = (D3D11_MESSAGE_ID_ENCRYPTIONBLT_SRC_WRONGDEVICE + 1), D3D11_MESSAGE_ID_ENCRYPTIONBLT_FORMAT_MISMATCH = (D3D11_MESSAGE_ID_ENCRYPTIONBLT_DST_WRONGDEVICE + 1),
    D3D11_MESSAGE_ID_ENCRYPTIONBLT_SIZE_MISMATCH = (D3D11_MESSAGE_ID_ENCRYPTIONBLT_FORMAT_MISMATCH + 1), D3D11_MESSAGE_ID_ENCRYPTIONBLT_SRC_MULTISAMPLED = (D3D11_MESSAGE_ID_ENCRYPTIONBLT_SIZE_MISMATCH + 1), D3D11_MESSAGE_ID_ENCRYPTIONBLT_DST_NOT_STAGING = (D3D11_MESSAGE_ID_ENCRYPTIONBLT_SRC_MULTISAMPLED + 1),
    D3D11_MESSAGE_ID_ENCRYPTIONBLT_SRC_MAPPED = (D3D11_MESSAGE_ID_ENCRYPTIONBLT_DST_NOT_STAGING + 1), D3D11_MESSAGE_ID_ENCRYPTIONBLT_DST_MAPPED = (D3D11_MESSAGE_ID_ENCRYPTIONBLT_SRC_MAPPED + 1), D3D11_MESSAGE_ID_ENCRYPTIONBLT_SRC_OFFERED = (D3D11_MESSAGE_ID_ENCRYPTIONBLT_DST_MAPPED + 1), D3D11_MESSAGE_ID_ENCRYPTIONBLT_DST_OFFERED = (D3D11_MESSAGE_ID_ENCRYPTIONBLT_SRC_OFFERED + 1),
    D3D11_MESSAGE_ID_ENCRYPTIONBLT_SRC_CONTENT_UNDEFINED = (D3D11_MESSAGE_ID_ENCRYPTIONBLT_DST_OFFERED + 1), D3D11_MESSAGE_ID_DECRYPTIONBLT_UNSUPPORTED = (D3D11_MESSAGE_ID_ENCRYPTIONBLT_SRC_CONTENT_UNDEFINED + 1), D3D11_MESSAGE_ID_DECRYPTIONBLT_NULLPARAM = (D3D11_MESSAGE_ID_DECRYPTIONBLT_UNSUPPORTED + 1),
    D3D11_MESSAGE_ID_DECRYPTIONBLT_SRC_WRONGDEVICE = (D3D11_MESSAGE_ID_DECRYPTIONBLT_NULLPARAM + 1), D3D11_MESSAGE_ID_DECRYPTIONBLT_DST_WRONGDEVICE = (D3D11_MESSAGE_ID_DECRYPTIONBLT_SRC_WRONGDEVICE + 1), D3D11_MESSAGE_ID_DECRYPTIONBLT_FORMAT_MISMATCH = (D3D11_MESSAGE_ID_DECRYPTIONBLT_DST_WRONGDEVICE + 1),
    D3D11_MESSAGE_ID_DECRYPTIONBLT_SIZE_MISMATCH = (D3D11_MESSAGE_ID_DECRYPTIONBLT_FORMAT_MISMATCH + 1), D3D11_MESSAGE_ID_DECRYPTIONBLT_DST_MULTISAMPLED = (D3D11_MESSAGE_ID_DECRYPTIONBLT_SIZE_MISMATCH + 1), D3D11_MESSAGE_ID_DECRYPTIONBLT_SRC_NOT_STAGING = (D3D11_MESSAGE_ID_DECRYPTIONBLT_DST_MULTISAMPLED + 1),
    D3D11_MESSAGE_ID_DECRYPTIONBLT_DST_NOT_RENDER_TARGET = (D3D11_MESSAGE_ID_DECRYPTIONBLT_SRC_NOT_STAGING + 1), D3D11_MESSAGE_ID_DECRYPTIONBLT_SRC_MAPPED = (D3D11_MESSAGE_ID_DECRYPTIONBLT_DST_NOT_RENDER_TARGET + 1), D3D11_MESSAGE_ID_DECRYPTIONBLT_DST_MAPPED = (D3D11_MESSAGE_ID_DECRYPTIONBLT_SRC_MAPPED + 1),
    D3D11_MESSAGE_ID_DECRYPTIONBLT_SRC_OFFERED = (D3D11_MESSAGE_ID_DECRYPTIONBLT_DST_MAPPED + 1), D3D11_MESSAGE_ID_DECRYPTIONBLT_DST_OFFERED = (D3D11_MESSAGE_ID_DECRYPTIONBLT_SRC_OFFERED + 1), D3D11_MESSAGE_ID_DECRYPTIONBLT_SRC_CONTENT_UNDEFINED = (D3D11_MESSAGE_ID_DECRYPTIONBLT_DST_OFFERED + 1),
    D3D11_MESSAGE_ID_STARTSESSIONKEYREFRESH_NULLPARAM = (D3D11_MESSAGE_ID_DECRYPTIONBLT_SRC_CONTENT_UNDEFINED + 1), D3D11_MESSAGE_ID_STARTSESSIONKEYREFRESH_INVALIDSIZE = (D3D11_MESSAGE_ID_STARTSESSIONKEYREFRESH_NULLPARAM + 1), D3D11_MESSAGE_ID_FINISHSESSIONKEYREFRESH_NULLPARAM = (D3D11_MESSAGE_ID_STARTSESSIONKEYREFRESH_INVALIDSIZE + 1),
    D3D11_MESSAGE_ID_GETENCRYPTIONBLTKEY_NULLPARAM = (D3D11_MESSAGE_ID_FINISHSESSIONKEYREFRESH_NULLPARAM + 1), D3D11_MESSAGE_ID_GETENCRYPTIONBLTKEY_INVALIDSIZE = (D3D11_MESSAGE_ID_GETENCRYPTIONBLTKEY_NULLPARAM + 1), D3D11_MESSAGE_ID_GETCONTENTPROTECTIONCAPS_NULLPARAM = (D3D11_MESSAGE_ID_GETENCRYPTIONBLTKEY_INVALIDSIZE + 1),
    D3D11_MESSAGE_ID_CHECKCRYPTOKEYEXCHANGE_NULLPARAM = (D3D11_MESSAGE_ID_GETCONTENTPROTECTIONCAPS_NULLPARAM + 1), D3D11_MESSAGE_ID_CHECKCRYPTOKEYEXCHANGE_INVALIDINDEX = (D3D11_MESSAGE_ID_CHECKCRYPTOKEYEXCHANGE_NULLPARAM + 1), D3D11_MESSAGE_ID_CREATEAUTHENTICATEDCHANNEL_NULLPARAM = (D3D11_MESSAGE_ID_CHECKCRYPTOKEYEXCHANGE_INVALIDINDEX + 1),
    D3D11_MESSAGE_ID_CREATEAUTHENTICATEDCHANNEL_UNSUPPORTED = (D3D11_MESSAGE_ID_CREATEAUTHENTICATEDCHANNEL_NULLPARAM + 1), D3D11_MESSAGE_ID_CREATEAUTHENTICATEDCHANNEL_INVALIDTYPE = (D3D11_MESSAGE_ID_CREATEAUTHENTICATEDCHANNEL_UNSUPPORTED + 1), D3D11_MESSAGE_ID_CREATEAUTHENTICATEDCHANNEL_OUTOFMEMORY_RETURN = (D3D11_MESSAGE_ID_CREATEAUTHENTICATEDCHANNEL_INVALIDTYPE + 1),
    D3D11_MESSAGE_ID_GETAUTHENTICATEDCHANNELCERTIFICATESIZE_INVALIDCHANNEL = (D3D11_MESSAGE_ID_CREATEAUTHENTICATEDCHANNEL_OUTOFMEMORY_RETURN + 1), D3D11_MESSAGE_ID_GETAUTHENTICATEDCHANNELCERTIFICATESIZE_NULLPARAM = (D3D11_MESSAGE_ID_GETAUTHENTICATEDCHANNELCERTIFICATESIZE_INVALIDCHANNEL + 1),
    D3D11_MESSAGE_ID_GETAUTHENTICATEDCHANNELCERTIFICATE_INVALIDCHANNEL = (D3D11_MESSAGE_ID_GETAUTHENTICATEDCHANNELCERTIFICATESIZE_NULLPARAM + 1), D3D11_MESSAGE_ID_GETAUTHENTICATEDCHANNELCERTIFICATE_NULLPARAM = (D3D11_MESSAGE_ID_GETAUTHENTICATEDCHANNELCERTIFICATE_INVALIDCHANNEL + 1),
    D3D11_MESSAGE_ID_GETAUTHENTICATEDCHANNELCERTIFICATE_WRONGSIZE = (D3D11_MESSAGE_ID_GETAUTHENTICATEDCHANNELCERTIFICATE_NULLPARAM + 1), D3D11_MESSAGE_ID_NEGOTIATEAUTHENTICATEDCHANNELKEYEXCHANGE_INVALIDCHANNEL = (D3D11_MESSAGE_ID_GETAUTHENTICATEDCHANNELCERTIFICATE_WRONGSIZE + 1),
    D3D11_MESSAGE_ID_NEGOTIATEAUTHENTICATEDCHANNELKEYEXCHANGE_NULLPARAM = (D3D11_MESSAGE_ID_NEGOTIATEAUTHENTICATEDCHANNELKEYEXCHANGE_INVALIDCHANNEL + 1), D3D11_MESSAGE_ID_QUERYAUTHENTICATEDCHANNEL_NULLPARAM = (D3D11_MESSAGE_ID_NEGOTIATEAUTHENTICATEDCHANNELKEYEXCHANGE_NULLPARAM + 1),
    D3D11_MESSAGE_ID_QUERYAUTHENTICATEDCHANNEL_WRONGCHANNEL = (D3D11_MESSAGE_ID_QUERYAUTHENTICATEDCHANNEL_NULLPARAM + 1), D3D11_MESSAGE_ID_QUERYAUTHENTICATEDCHANNEL_UNSUPPORTEDQUERY = (D3D11_MESSAGE_ID_QUERYAUTHENTICATEDCHANNEL_WRONGCHANNEL + 1), D3D11_MESSAGE_ID_QUERYAUTHENTICATEDCHANNEL_WRONGSIZE = (D3D11_MESSAGE_ID_QUERYAUTHENTICATEDCHANNEL_UNSUPPORTEDQUERY + 1),
    D3D11_MESSAGE_ID_QUERYAUTHENTICATEDCHANNEL_INVALIDPROCESSINDEX = (D3D11_MESSAGE_ID_QUERYAUTHENTICATEDCHANNEL_WRONGSIZE + 1), D3D11_MESSAGE_ID_CONFIGUREAUTHENTICATEDCHANNEL_NULLPARAM = (D3D11_MESSAGE_ID_QUERYAUTHENTICATEDCHANNEL_INVALIDPROCESSINDEX + 1), D3D11_MESSAGE_ID_CONFIGUREAUTHENTICATEDCHANNEL_WRONGCHANNEL = (D3D11_MESSAGE_ID_CONFIGUREAUTHENTICATEDCHANNEL_NULLPARAM + 1),
    D3D11_MESSAGE_ID_CONFIGUREAUTHENTICATEDCHANNEL_UNSUPPORTEDCONFIGURE = (D3D11_MESSAGE_ID_CONFIGUREAUTHENTICATEDCHANNEL_WRONGCHANNEL + 1), D3D11_MESSAGE_ID_CONFIGUREAUTHENTICATEDCHANNEL_WRONGSIZE = (D3D11_MESSAGE_ID_CONFIGUREAUTHENTICATEDCHANNEL_UNSUPPORTEDCONFIGURE + 1),
    D3D11_MESSAGE_ID_CONFIGUREAUTHENTICATEDCHANNEL_INVALIDPROCESSIDTYPE = (D3D11_MESSAGE_ID_CONFIGUREAUTHENTICATEDCHANNEL_WRONGSIZE + 1), D3D11_MESSAGE_ID_VSSETCONSTANTBUFFERS_INVALIDBUFFEROFFSETORCOUNT = (D3D11_MESSAGE_ID_CONFIGUREAUTHENTICATEDCHANNEL_INVALIDPROCESSIDTYPE + 1),
    D3D11_MESSAGE_ID_DSSETCONSTANTBUFFERS_INVALIDBUFFEROFFSETORCOUNT = (D3D11_MESSAGE_ID_VSSETCONSTANTBUFFERS_INVALIDBUFFEROFFSETORCOUNT + 1), D3D11_MESSAGE_ID_HSSETCONSTANTBUFFERS_INVALIDBUFFEROFFSETORCOUNT = (D3D11_MESSAGE_ID_DSSETCONSTANTBUFFERS_INVALIDBUFFEROFFSETORCOUNT + 1),
    D3D11_MESSAGE_ID_GSSETCONSTANTBUFFERS_INVALIDBUFFEROFFSETORCOUNT = (D3D11_MESSAGE_ID_HSSETCONSTANTBUFFERS_INVALIDBUFFEROFFSETORCOUNT + 1), D3D11_MESSAGE_ID_PSSETCONSTANTBUFFERS_INVALIDBUFFEROFFSETORCOUNT = (D3D11_MESSAGE_ID_GSSETCONSTANTBUFFERS_INVALIDBUFFEROFFSETORCOUNT + 1),
    D3D11_MESSAGE_ID_CSSETCONSTANTBUFFERS_INVALIDBUFFEROFFSETORCOUNT = (D3D11_MESSAGE_ID_PSSETCONSTANTBUFFERS_INVALIDBUFFEROFFSETORCOUNT + 1), D3D11_MESSAGE_ID_NEGOTIATECRPYTOSESSIONKEYEXCHANGE_INVALIDSIZE = (D3D11_MESSAGE_ID_CSSETCONSTANTBUFFERS_INVALIDBUFFEROFFSETORCOUNT + 1),
    D3D11_MESSAGE_ID_NEGOTIATEAUTHENTICATEDCHANNELKEYEXCHANGE_INVALIDSIZE = (D3D11_MESSAGE_ID_NEGOTIATECRPYTOSESSIONKEYEXCHANGE_INVALIDSIZE + 1), D3D11_MESSAGE_ID_OFFERRESOURCES_INVALIDPRIORITY = (D3D11_MESSAGE_ID_NEGOTIATEAUTHENTICATEDCHANNELKEYEXCHANGE_INVALIDSIZE + 1), D3D11_MESSAGE_ID_GETCRYPTOSESSIONHANDLE_OUTOFMEMORY = (D3D11_MESSAGE_ID_OFFERRESOURCES_INVALIDPRIORITY + 1),
    D3D11_MESSAGE_ID_ACQUIREHANDLEFORCAPTURE_NULLPARAM = (D3D11_MESSAGE_ID_GETCRYPTOSESSIONHANDLE_OUTOFMEMORY + 1), D3D11_MESSAGE_ID_ACQUIREHANDLEFORCAPTURE_INVALIDTYPE = (D3D11_MESSAGE_ID_ACQUIREHANDLEFORCAPTURE_NULLPARAM + 1), D3D11_MESSAGE_ID_ACQUIREHANDLEFORCAPTURE_INVALIDBIND = (D3D11_MESSAGE_ID_ACQUIREHANDLEFORCAPTURE_INVALIDTYPE + 1),
    D3D11_MESSAGE_ID_ACQUIREHANDLEFORCAPTURE_INVALIDARRAY = (D3D11_MESSAGE_ID_ACQUIREHANDLEFORCAPTURE_INVALIDBIND + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMROTATION_NULLPARAM = (D3D11_MESSAGE_ID_ACQUIREHANDLEFORCAPTURE_INVALIDARRAY + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMROTATION_INVALIDSTREAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMROTATION_NULLPARAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMROTATION_INVALID = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMROTATION_INVALIDSTREAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMROTATION_UNSUPPORTED = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMROTATION_INVALID + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMROTATION_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMROTATION_UNSUPPORTED + 1),
    D3D11_MESSAGE_ID_DEVICE_CLEARVIEW_INVALIDVIEW = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMROTATION_NULLPARAM + 1), D3D11_MESSAGE_ID_DEVICE_CREATEVERTEXSHADER_DOUBLEEXTENSIONSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CLEARVIEW_INVALIDVIEW + 1), D3D11_MESSAGE_ID_DEVICE_CREATEVERTEXSHADER_SHADEREXTENSIONSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATEVERTEXSHADER_DOUBLEEXTENSIONSNOTSUPPORTED + 1),
    D3D11_MESSAGE_ID_DEVICE_CREATEHULLSHADER_DOUBLEEXTENSIONSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATEVERTEXSHADER_SHADEREXTENSIONSNOTSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_CREATEHULLSHADER_SHADEREXTENSIONSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATEHULLSHADER_DOUBLEEXTENSIONSNOTSUPPORTED + 1),
    D3D11_MESSAGE_ID_DEVICE_CREATEDOMAINSHADER_DOUBLEEXTENSIONSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATEHULLSHADER_SHADEREXTENSIONSNOTSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_CREATEDOMAINSHADER_SHADEREXTENSIONSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATEDOMAINSHADER_DOUBLEEXTENSIONSNOTSUPPORTED + 1),
    D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADER_DOUBLEEXTENSIONSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATEDOMAINSHADER_SHADEREXTENSIONSNOTSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADER_SHADEREXTENSIONSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADER_DOUBLEEXTENSIONSNOTSUPPORTED + 1),
    D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DOUBLEEXTENSIONSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADER_SHADEREXTENSIONSNOTSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_SHADEREXTENSIONSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DOUBLEEXTENSIONSNOTSUPPORTED + 1),
    D3D11_MESSAGE_ID_DEVICE_CREATEPIXELSHADER_DOUBLEEXTENSIONSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_SHADEREXTENSIONSNOTSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_CREATEPIXELSHADER_SHADEREXTENSIONSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATEPIXELSHADER_DOUBLEEXTENSIONSNOTSUPPORTED + 1),
    D3D11_MESSAGE_ID_DEVICE_CREATECOMPUTESHADER_DOUBLEEXTENSIONSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATEPIXELSHADER_SHADEREXTENSIONSNOTSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_CREATECOMPUTESHADER_SHADEREXTENSIONSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATECOMPUTESHADER_DOUBLEEXTENSIONSNOTSUPPORTED + 1),
    D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_MINPRECISION = (D3D11_MESSAGE_ID_DEVICE_CREATECOMPUTESHADER_SHADEREXTENSIONSNOTSUPPORTED + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMALPHA_UNSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_SHADER_LINKAGE_MINPRECISION + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPIXELASPECTRATIO_UNSUPPORTED = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMALPHA_UNSUPPORTED + 1),
    D3D11_MESSAGE_ID_DEVICE_CREATEVERTEXSHADER_UAVSNOTSUPPORTED = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMPIXELASPECTRATIO_UNSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_CREATEHULLSHADER_UAVSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATEVERTEXSHADER_UAVSNOTSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_CREATEDOMAINSHADER_UAVSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATEHULLSHADER_UAVSNOTSUPPORTED + 1),
    D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADER_UAVSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATEDOMAINSHADER_UAVSNOTSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UAVSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADER_UAVSNOTSUPPORTED + 1),
    D3D11_MESSAGE_ID_DEVICE_CREATEPIXELSHADER_UAVSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UAVSNOTSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_CREATECOMPUTESHADER_UAVSNOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CREATEPIXELSHADER_UAVSNOTSUPPORTED + 1),
    D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETSANDUNORDEREDACCESSVIEWS_INVALIDOFFSET = (D3D11_MESSAGE_ID_DEVICE_CREATECOMPUTESHADER_UAVSNOTSUPPORTED + 1), D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETSANDUNORDEREDACCESSVIEWS_TOOMANYVIEWS = (D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETSANDUNORDEREDACCESSVIEWS_INVALIDOFFSET + 1),
    D3D11_MESSAGE_ID_DEVICE_CLEARVIEW_NOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_OMSETRENDERTARGETSANDUNORDEREDACCESSVIEWS_TOOMANYVIEWS + 1), D3D11_MESSAGE_ID_SWAPDEVICECONTEXTSTATE_NOTSUPPORTED = (D3D11_MESSAGE_ID_DEVICE_CLEARVIEW_NOTSUPPORTED + 1), D3D11_MESSAGE_ID_UPDATESUBRESOURCE_PREFERUPDATESUBRESOURCE1 = (D3D11_MESSAGE_ID_SWAPDEVICECONTEXTSTATE_NOTSUPPORTED + 1),
    D3D11_MESSAGE_ID_GETDC_INACCESSIBLE = (D3D11_MESSAGE_ID_UPDATESUBRESOURCE_PREFERUPDATESUBRESOURCE1 + 1), D3D11_MESSAGE_ID_DEVICE_CLEARVIEW_INVALIDRECT = (D3D11_MESSAGE_ID_GETDC_INACCESSIBLE + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_SAMPLE_MASK_IGNORED_ON_FL9 = (D3D11_MESSAGE_ID_DEVICE_CLEARVIEW_INVALIDRECT + 1),
    D3D11_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE1_NOT_SUPPORTED = (D3D11_MESSAGE_ID_DEVICE_DRAW_SAMPLE_MASK_IGNORED_ON_FL9 + 1), D3D11_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_BY_NAME_NOT_SUPPORTED = (D3D11_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE1_NOT_SUPPORTED + 1), D3D11_MESSAGE_ID_ENQUEUESETEVENT_NOT_SUPPORTED = (D3D11_MESSAGE_ID_DEVICE_OPEN_SHARED_RESOURCE_BY_NAME_NOT_SUPPORTED + 1),
    D3D11_MESSAGE_ID_OFFERRELEASE_NOT_SUPPORTED = (D3D11_MESSAGE_ID_ENQUEUESETEVENT_NOT_SUPPORTED + 1), D3D11_MESSAGE_ID_OFFERRESOURCES_INACCESSIBLE = (D3D11_MESSAGE_ID_OFFERRELEASE_NOT_SUPPORTED + 1), D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDMSAA = (D3D11_MESSAGE_ID_OFFERRESOURCES_INACCESSIBLE + 1),
    D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDMSAA = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSORINPUTVIEW_INVALIDMSAA + 1), D3D11_MESSAGE_ID_DEVICE_CLEARVIEW_INVALIDSOURCERECT = (D3D11_MESSAGE_ID_CREATEVIDEOPROCESSOROUTPUTVIEW_INVALIDMSAA + 1), D3D11_MESSAGE_ID_DEVICE_CLEARVIEW_EMPTYRECT = (D3D11_MESSAGE_ID_DEVICE_CLEARVIEW_INVALIDSOURCERECT + 1),
    D3D11_MESSAGE_ID_UPDATESUBRESOURCE_EMPTYDESTBOX = (D3D11_MESSAGE_ID_DEVICE_CLEARVIEW_EMPTYRECT + 1), D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_EMPTYSOURCEBOX = (D3D11_MESSAGE_ID_UPDATESUBRESOURCE_EMPTYDESTBOX + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_OM_RENDER_TARGET_DOES_NOT_SUPPORT_LOGIC_OPS = (D3D11_MESSAGE_ID_COPYSUBRESOURCEREGION_EMPTYSOURCEBOX + 1),
    D3D11_MESSAGE_ID_DEVICE_DRAW_DEPTHSTENCILVIEW_NOT_SET = (D3D11_MESSAGE_ID_DEVICE_DRAW_OM_RENDER_TARGET_DOES_NOT_SUPPORT_LOGIC_OPS + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_RENDERTARGETVIEW_NOT_SET = (D3D11_MESSAGE_ID_DEVICE_DRAW_DEPTHSTENCILVIEW_NOT_SET + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_RENDERTARGETVIEW_NOT_SET_DUE_TO_FLIP_PRESENT = (D3D11_MESSAGE_ID_DEVICE_DRAW_RENDERTARGETVIEW_NOT_SET + 1),
    D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_NOT_SET_DUE_TO_FLIP_PRESENT = (D3D11_MESSAGE_ID_DEVICE_DRAW_RENDERTARGETVIEW_NOT_SET_DUE_TO_FLIP_PRESENT + 1), D3D11_MESSAGE_ID_D3D11_1_MESSAGES_END = (D3D11_MESSAGE_ID_DEVICE_UNORDEREDACCESSVIEW_NOT_SET_DUE_TO_FLIP_PRESENT + 1), D3D11_MESSAGE_ID_D3D11_2_MESSAGES_START = (D3D11_MESSAGE_ID_D3D11_1_MESSAGES_END + 1),
    D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDUSAGE = (D3D11_MESSAGE_ID_D3D11_2_MESSAGES_START + 1), D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDUSAGE = (D3D11_MESSAGE_ID_CREATEBUFFER_INVALIDUSAGE + 1), D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDUSAGE = (D3D11_MESSAGE_ID_CREATETEXTURE1D_INVALIDUSAGE + 1),
    D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_LEVEL9_STEPRATE_NOT_1 = (D3D11_MESSAGE_ID_CREATETEXTURE2D_INVALIDUSAGE + 1), D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_LEVEL9_INSTANCING_NOT_SUPPORTED = (D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_LEVEL9_STEPRATE_NOT_1 + 1), D3D11_MESSAGE_ID_UPDATETILEMAPPINGS_INVALID_PARAMETER = (D3D11_MESSAGE_ID_CREATEINPUTLAYOUT_LEVEL9_INSTANCING_NOT_SUPPORTED + 1),
    D3D11_MESSAGE_ID_COPYTILEMAPPINGS_INVALID_PARAMETER = (D3D11_MESSAGE_ID_UPDATETILEMAPPINGS_INVALID_PARAMETER + 1), D3D11_MESSAGE_ID_COPYTILES_INVALID_PARAMETER = (D3D11_MESSAGE_ID_COPYTILEMAPPINGS_INVALID_PARAMETER + 1), D3D11_MESSAGE_ID_UPDATETILES_INVALID_PARAMETER = (D3D11_MESSAGE_ID_COPYTILES_INVALID_PARAMETER + 1),
    D3D11_MESSAGE_ID_RESIZETILEPOOL_INVALID_PARAMETER = (D3D11_MESSAGE_ID_UPDATETILES_INVALID_PARAMETER + 1), D3D11_MESSAGE_ID_TILEDRESOURCEBARRIER_INVALID_PARAMETER = (D3D11_MESSAGE_ID_RESIZETILEPOOL_INVALID_PARAMETER + 1), D3D11_MESSAGE_ID_NULL_TILE_MAPPING_ACCESS_WARNING = (D3D11_MESSAGE_ID_TILEDRESOURCEBARRIER_INVALID_PARAMETER + 1),
    D3D11_MESSAGE_ID_NULL_TILE_MAPPING_ACCESS_ERROR = (D3D11_MESSAGE_ID_NULL_TILE_MAPPING_ACCESS_WARNING + 1), D3D11_MESSAGE_ID_DIRTY_TILE_MAPPING_ACCESS = (D3D11_MESSAGE_ID_NULL_TILE_MAPPING_ACCESS_ERROR + 1), D3D11_MESSAGE_ID_DUPLICATE_TILE_MAPPINGS_IN_COVERED_AREA = (D3D11_MESSAGE_ID_DIRTY_TILE_MAPPING_ACCESS + 1),
    D3D11_MESSAGE_ID_TILE_MAPPINGS_IN_COVERED_AREA_DUPLICATED_OUTSIDE = (D3D11_MESSAGE_ID_DUPLICATE_TILE_MAPPINGS_IN_COVERED_AREA + 1), D3D11_MESSAGE_ID_TILE_MAPPINGS_SHARED_BETWEEN_INCOMPATIBLE_RESOURCES = (D3D11_MESSAGE_ID_TILE_MAPPINGS_IN_COVERED_AREA_DUPLICATED_OUTSIDE + 1),
    D3D11_MESSAGE_ID_TILE_MAPPINGS_SHARED_BETWEEN_INPUT_AND_OUTPUT = (D3D11_MESSAGE_ID_TILE_MAPPINGS_SHARED_BETWEEN_INCOMPATIBLE_RESOURCES + 1), D3D11_MESSAGE_ID_CHECKMULTISAMPLEQUALITYLEVELS_INVALIDFLAGS = (D3D11_MESSAGE_ID_TILE_MAPPINGS_SHARED_BETWEEN_INPUT_AND_OUTPUT + 1), D3D11_MESSAGE_ID_GETRESOURCETILING_NONTILED_RESOURCE = (D3D11_MESSAGE_ID_CHECKMULTISAMPLEQUALITYLEVELS_INVALIDFLAGS + 1),
    D3D11_MESSAGE_ID_RESIZETILEPOOL_SHRINK_WITH_MAPPINGS_STILL_DEFINED_PAST_END = (D3D11_MESSAGE_ID_GETRESOURCETILING_NONTILED_RESOURCE + 1), D3D11_MESSAGE_ID_NEED_TO_CALL_TILEDRESOURCEBARRIER = (D3D11_MESSAGE_ID_RESIZETILEPOOL_SHRINK_WITH_MAPPINGS_STILL_DEFINED_PAST_END + 1), D3D11_MESSAGE_ID_CREATEDEVICE_INVALIDARGS = (D3D11_MESSAGE_ID_NEED_TO_CALL_TILEDRESOURCEBARRIER + 1),
    D3D11_MESSAGE_ID_CREATEDEVICE_WARNING = (D3D11_MESSAGE_ID_CREATEDEVICE_INVALIDARGS + 1), D3D11_MESSAGE_ID_CLEARUNORDEREDACCESSVIEWUINT_HAZARD = (D3D11_MESSAGE_ID_CREATEDEVICE_WARNING + 1), D3D11_MESSAGE_ID_CLEARUNORDEREDACCESSVIEWFLOAT_HAZARD = (D3D11_MESSAGE_ID_CLEARUNORDEREDACCESSVIEWUINT_HAZARD + 1),
    D3D11_MESSAGE_ID_TILED_RESOURCE_TIER_1_BUFFER_TEXTURE_MISMATCH = (D3D11_MESSAGE_ID_CLEARUNORDEREDACCESSVIEWFLOAT_HAZARD + 1), D3D11_MESSAGE_ID_D3D11_2_MESSAGES_END = (D3D11_MESSAGE_ID_TILED_RESOURCE_TIER_1_BUFFER_TEXTURE_MISMATCH + 1), D3D11_MESSAGE_ID_D3D11_3_MESSAGES_START = (D3D11_MESSAGE_ID_D3D11_2_MESSAGES_END + 1),
    D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_INVALID_CONSERVATIVERASTERMODE = (D3D11_MESSAGE_ID_D3D11_3_MESSAGES_START + 1), D3D11_MESSAGE_ID_DEVICE_DRAW_INVALID_SYSTEMVALUE = (D3D11_MESSAGE_ID_CREATERASTERIZERSTATE_INVALID_CONSERVATIVERASTERMODE + 1), D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_INVALIDCONTEXTTYPE = (D3D11_MESSAGE_ID_DEVICE_DRAW_INVALID_SYSTEMVALUE + 1),
    D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_DECODENOTSUPPORTED = (D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_INVALIDCONTEXTTYPE + 1), D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_ENCODENOTSUPPORTED = (D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_DECODENOTSUPPORTED + 1), D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDPLANEINDEX = (D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_ENCODENOTSUPPORTED + 1),
    D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDVIDEOPLANEINDEX = (D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDPLANEINDEX + 1), D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_AMBIGUOUSVIDEOPLANEINDEX = (D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDVIDEOPLANEINDEX + 1),
    D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDPLANEINDEX = (D3D11_MESSAGE_ID_CREATESHADERRESOURCEVIEW_AMBIGUOUSVIDEOPLANEINDEX + 1), D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDVIDEOPLANEINDEX = (D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDPLANEINDEX + 1),
    D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_AMBIGUOUSVIDEOPLANEINDEX = (D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDVIDEOPLANEINDEX + 1), D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDPLANEINDEX = (D3D11_MESSAGE_ID_CREATERENDERTARGETVIEW_AMBIGUOUSVIDEOPLANEINDEX + 1),
    D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDVIDEOPLANEINDEX = (D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDPLANEINDEX + 1), D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_AMBIGUOUSVIDEOPLANEINDEX = (D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDVIDEOPLANEINDEX + 1),
    D3D11_MESSAGE_ID_JPEGDECODE_INVALIDSCANDATAOFFSET = (D3D11_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_AMBIGUOUSVIDEOPLANEINDEX + 1), D3D11_MESSAGE_ID_JPEGDECODE_NOTSUPPORTED = (D3D11_MESSAGE_ID_JPEGDECODE_INVALIDSCANDATAOFFSET + 1), D3D11_MESSAGE_ID_JPEGDECODE_DIMENSIONSTOOLARGE = (D3D11_MESSAGE_ID_JPEGDECODE_NOTSUPPORTED + 1),
    D3D11_MESSAGE_ID_JPEGDECODE_INVALIDCOMPONENTS = (D3D11_MESSAGE_ID_JPEGDECODE_DIMENSIONSTOOLARGE + 1), D3D11_MESSAGE_ID_JPEGDECODE_DESTINATIONNOT2D = (D3D11_MESSAGE_ID_JPEGDECODE_INVALIDCOMPONENTS + 1), D3D11_MESSAGE_ID_JPEGDECODE_TILEDRESOURCESUNSUPPORTED = (D3D11_MESSAGE_ID_JPEGDECODE_DESTINATIONNOT2D + 1),
    D3D11_MESSAGE_ID_JPEGDECODE_GUARDRECTSUNSUPPORTED = (D3D11_MESSAGE_ID_JPEGDECODE_TILEDRESOURCESUNSUPPORTED + 1), D3D11_MESSAGE_ID_JPEGDECODE_FORMATUNSUPPORTED = (D3D11_MESSAGE_ID_JPEGDECODE_GUARDRECTSUNSUPPORTED + 1), D3D11_MESSAGE_ID_JPEGDECODE_INVALIDSUBRESOURCE = (D3D11_MESSAGE_ID_JPEGDECODE_FORMATUNSUPPORTED + 1),
    D3D11_MESSAGE_ID_JPEGDECODE_INVALIDMIPLEVEL = (D3D11_MESSAGE_ID_JPEGDECODE_INVALIDSUBRESOURCE + 1), D3D11_MESSAGE_ID_JPEGDECODE_EMPTYDESTBOX = (D3D11_MESSAGE_ID_JPEGDECODE_INVALIDMIPLEVEL + 1), D3D11_MESSAGE_ID_JPEGDECODE_DESTBOXNOT2D = (D3D11_MESSAGE_ID_JPEGDECODE_EMPTYDESTBOX + 1), D3D11_MESSAGE_ID_JPEGDECODE_DESTBOXNOTSUB = (D3D11_MESSAGE_ID_JPEGDECODE_DESTBOXNOT2D + 1),
    D3D11_MESSAGE_ID_JPEGDECODE_DESTBOXESINTERSECT = (D3D11_MESSAGE_ID_JPEGDECODE_DESTBOXNOTSUB + 1), D3D11_MESSAGE_ID_JPEGDECODE_XSUBSAMPLEMISMATCH = (D3D11_MESSAGE_ID_JPEGDECODE_DESTBOXESINTERSECT + 1), D3D11_MESSAGE_ID_JPEGDECODE_YSUBSAMPLEMISMATCH = (D3D11_MESSAGE_ID_JPEGDECODE_XSUBSAMPLEMISMATCH + 1),
    D3D11_MESSAGE_ID_JPEGDECODE_XSUBSAMPLEODD = (D3D11_MESSAGE_ID_JPEGDECODE_YSUBSAMPLEMISMATCH + 1), D3D11_MESSAGE_ID_JPEGDECODE_YSUBSAMPLEODD = (D3D11_MESSAGE_ID_JPEGDECODE_XSUBSAMPLEODD + 1), D3D11_MESSAGE_ID_JPEGDECODE_OUTPUTDIMENSIONSTOOLARGE = (D3D11_MESSAGE_ID_JPEGDECODE_YSUBSAMPLEODD + 1),
    D3D11_MESSAGE_ID_JPEGDECODE_NONPOW2SCALEUNSUPPORTED = (D3D11_MESSAGE_ID_JPEGDECODE_OUTPUTDIMENSIONSTOOLARGE + 1), D3D11_MESSAGE_ID_JPEGDECODE_FRACTIONALDOWNSCALETOLARGE = (D3D11_MESSAGE_ID_JPEGDECODE_NONPOW2SCALEUNSUPPORTED + 1), D3D11_MESSAGE_ID_JPEGDECODE_CHROMASIZEMISMATCH = (D3D11_MESSAGE_ID_JPEGDECODE_FRACTIONALDOWNSCALETOLARGE + 1),
    D3D11_MESSAGE_ID_JPEGDECODE_LUMACHROMASIZEMISMATCH = (D3D11_MESSAGE_ID_JPEGDECODE_CHROMASIZEMISMATCH + 1), D3D11_MESSAGE_ID_JPEGDECODE_INVALIDNUMDESTINATIONS = (D3D11_MESSAGE_ID_JPEGDECODE_LUMACHROMASIZEMISMATCH + 1), D3D11_MESSAGE_ID_JPEGDECODE_SUBBOXUNSUPPORTED = (D3D11_MESSAGE_ID_JPEGDECODE_INVALIDNUMDESTINATIONS + 1),
    D3D11_MESSAGE_ID_JPEGDECODE_1DESTUNSUPPORTEDFORMAT = (D3D11_MESSAGE_ID_JPEGDECODE_SUBBOXUNSUPPORTED + 1), D3D11_MESSAGE_ID_JPEGDECODE_3DESTUNSUPPORTEDFORMAT = (D3D11_MESSAGE_ID_JPEGDECODE_1DESTUNSUPPORTEDFORMAT + 1), D3D11_MESSAGE_ID_JPEGDECODE_SCALEUNSUPPORTED = (D3D11_MESSAGE_ID_JPEGDECODE_3DESTUNSUPPORTEDFORMAT + 1),
    D3D11_MESSAGE_ID_JPEGDECODE_INVALIDSOURCESIZE = (D3D11_MESSAGE_ID_JPEGDECODE_SCALEUNSUPPORTED + 1), D3D11_MESSAGE_ID_JPEGDECODE_INVALIDCOPYFLAGS = (D3D11_MESSAGE_ID_JPEGDECODE_INVALIDSOURCESIZE + 1), D3D11_MESSAGE_ID_JPEGDECODE_HAZARD = (D3D11_MESSAGE_ID_JPEGDECODE_INVALIDCOPYFLAGS + 1), D3D11_MESSAGE_ID_JPEGDECODE_UNSUPPORTEDSRCBUFFERUSAGE = (D3D11_MESSAGE_ID_JPEGDECODE_HAZARD + 1),
    D3D11_MESSAGE_ID_JPEGDECODE_UNSUPPORTEDSRCBUFFERMISCFLAGS = (D3D11_MESSAGE_ID_JPEGDECODE_UNSUPPORTEDSRCBUFFERUSAGE + 1), D3D11_MESSAGE_ID_JPEGDECODE_UNSUPPORTEDDSTTEXTUREUSAGE = (D3D11_MESSAGE_ID_JPEGDECODE_UNSUPPORTEDSRCBUFFERMISCFLAGS + 1), D3D11_MESSAGE_ID_JPEGDECODE_BACKBUFFERNOTSUPPORTED = (D3D11_MESSAGE_ID_JPEGDECODE_UNSUPPORTEDDSTTEXTUREUSAGE + 1),
    D3D11_MESSAGE_ID_JPEGDECODE_UNSUPPRTEDCOPYFLAGS = (D3D11_MESSAGE_ID_JPEGDECODE_BACKBUFFERNOTSUPPORTED + 1), D3D11_MESSAGE_ID_JPEGENCODE_NOTSUPPORTED = (D3D11_MESSAGE_ID_JPEGDECODE_UNSUPPRTEDCOPYFLAGS + 1), D3D11_MESSAGE_ID_JPEGENCODE_INVALIDSCANDATAOFFSET = (D3D11_MESSAGE_ID_JPEGENCODE_NOTSUPPORTED + 1),
    D3D11_MESSAGE_ID_JPEGENCODE_INVALIDCOMPONENTS = (D3D11_MESSAGE_ID_JPEGENCODE_INVALIDSCANDATAOFFSET + 1), D3D11_MESSAGE_ID_JPEGENCODE_SOURCENOT2D = (D3D11_MESSAGE_ID_JPEGENCODE_INVALIDCOMPONENTS + 1), D3D11_MESSAGE_ID_JPEGENCODE_TILEDRESOURCESUNSUPPORTED = (D3D11_MESSAGE_ID_JPEGENCODE_SOURCENOT2D + 1),
    D3D11_MESSAGE_ID_JPEGENCODE_GUARDRECTSUNSUPPORTED = (D3D11_MESSAGE_ID_JPEGENCODE_TILEDRESOURCESUNSUPPORTED + 1), D3D11_MESSAGE_ID_JPEGENCODE_XSUBSAMPLEMISMATCH = (D3D11_MESSAGE_ID_JPEGENCODE_GUARDRECTSUNSUPPORTED + 1), D3D11_MESSAGE_ID_JPEGENCODE_YSUBSAMPLEMISMATCH = (D3D11_MESSAGE_ID_JPEGENCODE_XSUBSAMPLEMISMATCH + 1),
    D3D11_MESSAGE_ID_JPEGENCODE_FORMATUNSUPPORTED = (D3D11_MESSAGE_ID_JPEGENCODE_YSUBSAMPLEMISMATCH + 1), D3D11_MESSAGE_ID_JPEGENCODE_INVALIDSUBRESOURCE = (D3D11_MESSAGE_ID_JPEGENCODE_FORMATUNSUPPORTED + 1), D3D11_MESSAGE_ID_JPEGENCODE_INVALIDMIPLEVEL = (D3D11_MESSAGE_ID_JPEGENCODE_INVALIDSUBRESOURCE + 1),
    D3D11_MESSAGE_ID_JPEGENCODE_DIMENSIONSTOOLARGE = (D3D11_MESSAGE_ID_JPEGENCODE_INVALIDMIPLEVEL + 1), D3D11_MESSAGE_ID_JPEGENCODE_HAZARD = (D3D11_MESSAGE_ID_JPEGENCODE_DIMENSIONSTOOLARGE + 1), D3D11_MESSAGE_ID_JPEGENCODE_UNSUPPORTEDDSTBUFFERUSAGE = (D3D11_MESSAGE_ID_JPEGENCODE_HAZARD + 1),
    D3D11_MESSAGE_ID_JPEGENCODE_UNSUPPORTEDDSTBUFFERMISCFLAGS = (D3D11_MESSAGE_ID_JPEGENCODE_UNSUPPORTEDDSTBUFFERUSAGE + 1), D3D11_MESSAGE_ID_JPEGENCODE_UNSUPPORTEDSRCTEXTUREUSAGE = (D3D11_MESSAGE_ID_JPEGENCODE_UNSUPPORTEDDSTBUFFERMISCFLAGS + 1), D3D11_MESSAGE_ID_JPEGENCODE_BACKBUFFERNOTSUPPORTED = (D3D11_MESSAGE_ID_JPEGENCODE_UNSUPPORTEDSRCTEXTUREUSAGE + 1),
    D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_UNSUPPORTEDCONTEXTTTYPEFORQUERY = (D3D11_MESSAGE_ID_JPEGENCODE_BACKBUFFERNOTSUPPORTED + 1), D3D11_MESSAGE_ID_FLUSH1_INVALIDCONTEXTTYPE = (D3D11_MESSAGE_ID_CREATEQUERYORPREDICATE_UNSUPPORTEDCONTEXTTTYPEFORQUERY + 1), D3D11_MESSAGE_ID_DEVICE_SETHARDWAREPROTECTION_INVALIDCONTEXT = (D3D11_MESSAGE_ID_FLUSH1_INVALIDCONTEXTTYPE + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTHDRMETADATA_NULLPARAM = (D3D11_MESSAGE_ID_DEVICE_SETHARDWAREPROTECTION_INVALIDCONTEXT + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTHDRMETADATA_INVALIDSIZE = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTHDRMETADATA_NULLPARAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTHDRMETADATA_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETOUTPUTHDRMETADATA_INVALIDSIZE + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTHDRMETADATA_INVALIDSIZE = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTHDRMETADATA_NULLPARAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMHDRMETADATA_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETOUTPUTHDRMETADATA_INVALIDSIZE + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMHDRMETADATA_INVALIDSTREAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMHDRMETADATA_NULLPARAM + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMHDRMETADATA_INVALIDSIZE = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMHDRMETADATA_INVALIDSTREAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMHDRMETADATA_NULLPARAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORSETSTREAMHDRMETADATA_INVALIDSIZE + 1),
    D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMHDRMETADATA_INVALIDSTREAM = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMHDRMETADATA_NULLPARAM + 1), D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMHDRMETADATA_INVALIDSIZE = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMHDRMETADATA_INVALIDSTREAM + 1), D3D11_MESSAGE_ID_D3D11_3_MESSAGES_END = (D3D11_MESSAGE_ID_VIDEOPROCESSORGETSTREAMHDRMETADATA_INVALIDSIZE + 1));
  PD3D11_MESSAGE_ID = ^TD3D11_MESSAGE_ID;

  TD3D11_MESSAGE = record
    Category: TD3D11_MESSAGE_CATEGORY;
    Severity: TD3D11_MESSAGE_SEVERITY;
    ID: TD3D11_MESSAGE_ID;
    pDescription: PChar;
    DescriptionByteLength: SIZE_T;
  end;

  PD3D11_MESSAGE = ^TD3D11_MESSAGE;

  TD3D11_INFO_QUEUE_FILTER_DESC = record
    NumCategories: UINT;
    pCategoryList: PD3D11_MESSAGE_CATEGORY;
    NumSeverities: UINT;
    pSeverityList: PD3D11_MESSAGE_SEVERITY;
    NumIDs: UINT;
    pIDList: PD3D11_MESSAGE_ID;
  end;

  PD3D11_INFO_QUEUE_FILTER_DESC = ^TD3D11_INFO_QUEUE_FILTER_DESC;

  TD3D11_INFO_QUEUE_FILTER = record
    AllowList: TD3D11_INFO_QUEUE_FILTER_DESC;
    DenyList: TD3D11_INFO_QUEUE_FILTER_DESC;
  end;

  PD3D11_INFO_QUEUE_FILTER = ^TD3D11_INFO_QUEUE_FILTER;

  ID3D11InfoQueue = interface(IUnknown)
    ['{6543dbb6-1b48-42f5-ab82-e97ec74326f6}']
    function SetMessageCountLimit(MessageCountLimit: UINT64): HResult; stdcall;
    procedure ClearStoredMessages(); stdcall;
    function GetMessage(MessageIndex: UINT64; out pMessage: PD3D11_MESSAGE; var pMessageByteLength: SIZE_T): HResult; stdcall;
    function GetNumMessagesAllowedByStorageFilter(): UINT64; stdcall;
    function GetNumMessagesDeniedByStorageFilter(): UINT64; stdcall;
    function GetNumStoredMessages(): UINT64; stdcall;
    function GetNumStoredMessagesAllowedByRetrievalFilter(): UINT64; stdcall;
    function GetNumMessagesDiscardedByMessageCountLimit(): UINT64; stdcall;
    function GetMessageCountLimit(): UINT64; stdcall;
    function AddStorageFilterEntries(pFilter: PD3D11_INFO_QUEUE_FILTER): HResult; stdcall;
    function GetStorageFilter(out pFilter: PD3D11_INFO_QUEUE_FILTER; var pFilterByteLength: SIZE_T): HResult; stdcall;
    procedure ClearStorageFilter(); stdcall;
    function PushEmptyStorageFilter(): HResult; stdcall;
    function PushCopyOfStorageFilter(): HResult; stdcall;
    function PushStorageFilter(pFilter: PD3D11_INFO_QUEUE_FILTER): HResult; stdcall;
    procedure PopStorageFilter(); stdcall;
    function GetStorageFilterStackSize(): UINT; stdcall;
    function AddRetrievalFilterEntries(pFilter: PD3D11_INFO_QUEUE_FILTER): HResult; stdcall;
    function GetRetrievalFilter(out pFilter: PD3D11_INFO_QUEUE_FILTER; var pFilterByteLength: SIZE_T): HResult; stdcall;
    procedure ClearRetrievalFilter(); stdcall;
    function PushEmptyRetrievalFilter(): HResult; stdcall;
    function PushCopyOfRetrievalFilter(): HResult; stdcall;
    function PushRetrievalFilter(pFilter: PD3D11_INFO_QUEUE_FILTER): HResult; stdcall;
    procedure PopRetrievalFilter(); stdcall;
    function GetRetrievalFilterStackSize(): UINT; stdcall;
    function AddMessage(Category: TD3D11_MESSAGE_CATEGORY; Severity: TD3D11_MESSAGE_SEVERITY; ID: TD3D11_MESSAGE_ID; pDescription: PAnsiChar): HResult; stdcall;
    function AddApplicationMessage(Severity: TD3D11_MESSAGE_SEVERITY; pDescription: PAnsiChar): HResult; stdcall;
    function SetBreakOnCategory(Category: TD3D11_MESSAGE_CATEGORY; bEnable: LongBool): HResult; stdcall;
    function SetBreakOnSeverity(Severity: TD3D11_MESSAGE_SEVERITY; bEnable: LongBool): HResult; stdcall;
    function SetBreakOnID(ID: TD3D11_MESSAGE_ID; bEnable: LongBool): HResult; stdcall;
    function GetBreakOnCategory(Category: TD3D11_MESSAGE_CATEGORY): LongBool; stdcall;
    function GetBreakOnSeverity(Severity: TD3D11_MESSAGE_SEVERITY): LongBool; stdcall;
    function GetBreakOnID(ID: TD3D11_MESSAGE_ID): LongBool; stdcall;
    procedure SetMuteDebugOutput(bMute: LongBool); stdcall;
    function GetMuteDebugOutput(): LongBool; stdcall;
  end;

function D3DDisassemble11Trace(pSrcData: Pointer; SrcDataSize: SIZE_T; pTrace: ID3D11ShaderTrace; StartStep: UINT; NumSteps: UINT; Flags: UINT; out ppDisassembly: ID3D10Blob): HResult; stdcall; external D3DCompiler_DLL;
function D3D11CreateDeviceAndSwapChain(pAdapter: IDXGIAdapter; DriverType: TD3D_DRIVER_TYPE; Software: HMODULE; Flags: UINT; const pFeatureLevels: PD3D_FEATURE_LEVEL; FeatureLevels: UINT; SDKVersion: UINT;
  { const } pSwapChainDesc: PDXGI_SWAP_CHAIN_DESC; out ppSwapChain: IDXGISwapChain; out ppDevice: ID3D11Device; out pFeatureLevel: TD3D_FEATURE_LEVEL; out ppImmediateContext: ID3D11DeviceContext): HResult; stdcall; external DLL_D3D11;
function D3D11_ENCODE_BASIC_FILTER(min, mag, mip, reduction: UINT): TD3D11_FILTER;
function D3D11_ENCODE_ANISOTROPIC_FILTER(reduction: UINT): TD3D11_FILTER;
function D3D11_DECODE_MIN_FILTER(d3d11Filter: TD3D11_FILTER): TD3D11_FILTER_TYPE;
function DefaultColor: TFloatArray4;
function D3D11CalcSubresource(MipSlice: UINT; ArraySlice: UINT; MipLevels: UINT): UINT;
function D3D11_SHVER_GET_TYPE(_Version: UINT): UINT;
function D3D11_SHVER_GET_MAJOR(_Version: UINT): UINT;
function D3D11_SHVER_GET_MINOR(_Version: UINT): UINT;

implementation

function D3D11_SHVER_GET_TYPE(_Version: UINT): UINT;
begin
  Result := (_Version shr 16) and $FFFF;
end;

function D3D11_SHVER_GET_MAJOR(_Version: UINT): UINT;
begin
  Result := (_Version shr 4) and $F;
end;

function D3D11_SHVER_GET_MINOR(_Version: UINT): UINT;
begin
  Result := (_Version shr 0) and $F;
end;

function D3D11_ENCODE_BASIC_FILTER(min, mag, mip, reduction: UINT): TD3D11_FILTER;
var
  X: longint;
begin
  X      := ((min and D3D11_FILTER_TYPE_MASK) shl D3D11_MIN_FILTER_SHIFT) or ((mag and D3D11_FILTER_TYPE_MASK) shl D3D11_MAG_FILTER_SHIFT) or ((mip and D3D11_FILTER_TYPE_MASK) shl D3D11_MIP_FILTER_SHIFT) or ((reduction and D3D11_FILTER_REDUCTION_TYPE_MASK) shl D3D11_FILTER_REDUCTION_TYPE_SHIFT);
  Result := TD3D11_FILTER(X);
end;

function D3D11_ENCODE_ANISOTROPIC_FILTER(reduction: UINT): TD3D11_FILTER;
begin
  Result := D3D11_ENCODE_BASIC_FILTER(Ord(D3D11_FILTER_TYPE_LINEAR), Ord(D3D11_FILTER_TYPE_LINEAR), Ord(D3D11_FILTER_TYPE_LINEAR), reduction);
  Result := TD3D11_FILTER(Ord(Result) or Ord(D3D11_ANISOTROPIC_FILTERING_BIT));
end;

function D3D11_DECODE_MIN_FILTER(d3d11Filter: TD3D11_FILTER): TD3D11_FILTER_TYPE;
begin
  Result := TD3D11_FILTER_TYPE((Ord(d3d11Filter) shr D3D11_MIN_FILTER_SHIFT) and D3D11_FILTER_TYPE_MASK);
end;

function DefaultColor: TFloatArray4;
begin
  Result[0] := 1.0;
  Result[1] := 1.0;
  Result[2] := 1.0;
  Result[3] := 1.0;
end;

function D3D11CalcSubresource(MipSlice: UINT; ArraySlice: UINT; MipLevels: UINT): UINT;
begin
  Result := MipSlice + (ArraySlice * MipLevels);
end;

function D3D11_DECODE_MAG_FILTER(d3d11Filter: TD3D11_FILTER): TD3D11_FILTER_TYPE;
begin
  Result := TD3D11_FILTER_TYPE((Ord(d3d11Filter) shr D3D11_MAG_FILTER_SHIFT) and D3D11_FILTER_TYPE_MASK);
end;

function D3D11_DECODE_MIP_FILTER(d3d11Filter: TD3D11_FILTER): TD3D11_FILTER_TYPE;
begin
  Result := TD3D11_FILTER_TYPE((Ord(d3d11Filter) shr D3D11_MIP_FILTER_SHIFT) and D3D11_FILTER_TYPE_MASK);
end;

function D3D11_DECODE_FILTER_REDUCTION(d3d11Filter: TD3D11_FILTER): TD3D11_FILTER_REDUCTION_TYPE;
begin
  Result := TD3D11_FILTER_REDUCTION_TYPE((Ord(d3d11Filter) shr D3D11_FILTER_REDUCTION_TYPE_SHIFT) and D3D11_FILTER_REDUCTION_TYPE_MASK);
end;

function D3D11_DECODE_IS_COMPARISON_FILTER(d3d11Filter: TD3D11_FILTER): LongBool;
begin
  Result := (D3D11_DECODE_FILTER_REDUCTION(d3d11Filter) = D3D11_FILTER_REDUCTION_TYPE_COMPARISON);
end;

function D3D11_DECODE_IS_ANISOTROPIC_FILTER(d3d11Filter: TD3D11_FILTER): LongBool;
begin
  Result := ((Ord(d3d11Filter) and D3D11_ANISOTROPIC_FILTERING_BIT = D3D11_ANISOTROPIC_FILTERING_BIT) and (D3D11_FILTER_TYPE_LINEAR = D3D11_DECODE_MIN_FILTER(d3d11Filter)) and (D3D11_FILTER_TYPE_LINEAR = D3D11_DECODE_MAG_FILTER(d3d11Filter)) and (D3D11_FILTER_TYPE_LINEAR = D3D11_DECODE_MIP_FILTER(d3d11Filter)));
end;

{ TD3D11_SAMPLER_DESC }
procedure TD3D11_SAMPLER_DESC.Init;
begin
  Filter         := D3D11_FILTER_MIN_MAG_MIP_LINEAR;
  AddressU       := D3D11_TEXTURE_ADDRESS_CLAMP;
  AddressV       := D3D11_TEXTURE_ADDRESS_CLAMP;
  AddressW       := D3D11_TEXTURE_ADDRESS_CLAMP;
  MipLODBias     := 0;
  MaxAnisotropy  := 1;
  ComparisonFunc := D3D11_COMPARISON_NEVER;
  BorderColor[0] := 1.0;
  BorderColor[1] := 1.0;
  BorderColor[2] := 1.0;
  BorderColor[3] := 1.0;
  MinLOD         := -3.402823466E+38; // -FLT_MAX
  MaxLOD         := 3.402823466E+38;  // FLT_MAX
end;

procedure TD3D11_SAMPLER_DESC.Init(AFilter: TD3D11_FILTER; AAddressU: TD3D11_TEXTURE_ADDRESS_MODE; AAddressV: TD3D11_TEXTURE_ADDRESS_MODE; AAddressW: TD3D11_TEXTURE_ADDRESS_MODE; AMipLODBias: Single; AMaxAnisotropy: UINT; AComparisonFunc: TD3D11_COMPARISON_FUNC; ABorderColor: TFloatArray4; AMinLOD: Single; AMaxLOD: Single);
begin
  Filter         := AFilter;
  AddressU       := AAddressU;
  AddressV       := AAddressV;
  AddressW       := AAddressW;
  MipLODBias     := AMipLODBias;
  MaxAnisotropy  := AMaxAnisotropy;
  ComparisonFunc := AComparisonFunc;
  BorderColor[0] := ABorderColor[0];
  BorderColor[1] := ABorderColor[1];
  BorderColor[2] := ABorderColor[2];
  BorderColor[3] := ABorderColor[3];
  MinLOD         := AMinLOD;
  MaxLOD         := AMaxLOD;
end;

{ TD3D11_UNORDERED_ACCESS_VIEW_DESC }
procedure TD3D11_UNORDERED_ACCESS_VIEW_DESC.Init(AViewDimension: TD3D11_UAV_DIMENSION; AFormat: TDXGI_FORMAT; MipSlice: UINT; FirstArraySlice: UINT; ArraySize: INT32; Flags: UINT);
begin
  Format        := AFormat;
  ViewDimension := AViewDimension;
  case (ViewDimension) of
    D3D11_UAV_DIMENSION_BUFFER:
      begin
        Buffer.FirstElement := MipSlice;
        Buffer.NumElements  := FirstArraySlice;
        Buffer.Flags        := Flags;
      end;
    D3D11_UAV_DIMENSION_TEXTURE1D:
      begin
        Texture1D.MipSlice := MipSlice;
      end;
    D3D11_UAV_DIMENSION_TEXTURE1DARRAY:
      begin
        Texture1DArray.MipSlice        := MipSlice;
        Texture1DArray.FirstArraySlice := FirstArraySlice;
        Texture1DArray.ArraySize       := ArraySize;
      end;
    D3D11_UAV_DIMENSION_TEXTURE2D:
      begin
        Texture2D.MipSlice := MipSlice;
      end;
    D3D11_UAV_DIMENSION_TEXTURE2DARRAY:
      begin
        Texture2DArray.MipSlice        := MipSlice;
        Texture2DArray.FirstArraySlice := FirstArraySlice;
        Texture2DArray.ArraySize       := ArraySize;
      end;
    D3D11_UAV_DIMENSION_TEXTURE3D:
      begin
        Texture3D.MipSlice    := MipSlice;
        Texture3D.FirstWSlice := FirstArraySlice;
        Texture3D.WSize       := ArraySize;
      end;
  end;
end;

procedure TD3D11_UNORDERED_ACCESS_VIEW_DESC.Init(ABuffer: ID3D11Buffer; AFormat: TDXGI_FORMAT; FirstElement: UINT; NumElements: UINT; Flags: UINT);
begin
  Format              := AFormat;
  ViewDimension       := D3D11_UAV_DIMENSION_BUFFER;
  Buffer.FirstElement := FirstElement;
  Buffer.NumElements  := NumElements;
  Buffer.Flags        := Flags;
end;

procedure TD3D11_UNORDERED_ACCESS_VIEW_DESC.Init(pTex1D: ID3D11Texture1D; AViewDimension: TD3D11_UAV_DIMENSION; AFormat: TDXGI_FORMAT; MipSlice: UINT; FirstArraySlice: UINT; ArraySize: INT32);
var
  TexDesc   : TD3D11_TEXTURE1D_DESC;
  lArraySize: Integer;
begin
  ViewDimension := AViewDimension;
  Format        := AFormat;
  lArraySize    := ArraySize;
  if (DXGI_FORMAT_UNKNOWN = Format) or ((lArraySize = -1) and (ViewDimension = D3D11_UAV_DIMENSION_TEXTURE1DARRAY)) then
  begin
    pTex1D.GetDesc(TexDesc);
    if (DXGI_FORMAT_UNKNOWN = Format) then
      Format := TexDesc.Format;
    if (-1 = lArraySize) then
      lArraySize := TexDesc.ArraySize - FirstArraySlice;
  end;
  case (ViewDimension) of
    D3D11_UAV_DIMENSION_TEXTURE1D:
      begin
        Texture1D.MipSlice := MipSlice;
      end;
    D3D11_UAV_DIMENSION_TEXTURE1DARRAY:
      begin
        Texture1DArray.MipSlice        := MipSlice;
        Texture1DArray.FirstArraySlice := FirstArraySlice;
        Texture1DArray.ArraySize       := ArraySize;
      end;
  end;
end;

procedure TD3D11_UNORDERED_ACCESS_VIEW_DESC.Init(pTex2D: ID3D11Texture2D; AViewDimension: TD3D11_UAV_DIMENSION; Format: TDXGI_FORMAT; MipSlice: UINT; FirstArraySlice: UINT; ArraySize: INT32);
var
  TexDesc   : TD3D11_TEXTURE2D_DESC;
  lArraySize: Integer;
begin
  ViewDimension := AViewDimension;
  Format        := Format;
  lArraySize    := ArraySize;
  if (DXGI_FORMAT_UNKNOWN = Format) or ((-1 = lArraySize) and (D3D11_UAV_DIMENSION_TEXTURE2DARRAY = ViewDimension)) then
  begin
    pTex2D.GetDesc(TexDesc);
    if (DXGI_FORMAT_UNKNOWN = Format) then
      Format := TexDesc.Format;
    if (-1 = lArraySize) then
      lArraySize := TexDesc.ArraySize - FirstArraySlice;
  end;
  case (ViewDimension) of
    D3D11_UAV_DIMENSION_TEXTURE2D:
      begin
        Texture2D.MipSlice := MipSlice;
      end;
    D3D11_UAV_DIMENSION_TEXTURE2DARRAY:
      begin
        Texture2DArray.MipSlice        := MipSlice;
        Texture2DArray.FirstArraySlice := FirstArraySlice;
        Texture2DArray.ArraySize       := lArraySize;
      end;
  end;
end;

procedure TD3D11_UNORDERED_ACCESS_VIEW_DESC.Init(pTex3D: ID3D11Texture3D; AFormat: TDXGI_FORMAT; MipSlice: UINT; FirstWSlice: UINT; WSize: INT32);
var
  TexDesc: TD3D11_TEXTURE3D_DESC;
  lwSize : Integer;
begin
  ViewDimension := D3D11_UAV_DIMENSION_TEXTURE3D;
  Format        := AFormat;
  lwSize        := WSize;
  if (DXGI_FORMAT_UNKNOWN = Format) or (-1 = lwSize) then
  begin
    pTex3D.GetDesc(TexDesc);
    if (DXGI_FORMAT_UNKNOWN = Format) then
      Format := TexDesc.Format;
    if (-1 = lwSize) then
      lwSize := TexDesc.Depth - FirstWSlice;
  end;
  Texture3D.MipSlice    := MipSlice;
  Texture3D.FirstWSlice := FirstWSlice;
  Texture3D.WSize       := lwSize;
end;

{ TD3D11_DEPTH_STENCIL_VIEW_DESC }
procedure TD3D11_DEPTH_STENCIL_VIEW_DESC.Init(AViewDimension: TD3D11_DSV_DIMENSION; AFormat: TDXGI_FORMAT; MipSlice: UINT; FirstArraySlice: UINT; ArraySize: INT32; AFlags: UINT);
begin
  Format        := AFormat;
  ViewDimension := AViewDimension;
  Flags         := AFlags;
  case (ViewDimension) of
    D3D11_DSV_DIMENSION_TEXTURE1D:
      begin
        Texture1D.MipSlice := MipSlice;
      end;
    D3D11_DSV_DIMENSION_TEXTURE1DARRAY:
      begin
        Texture1DArray.MipSlice        := MipSlice;
        Texture1DArray.FirstArraySlice := FirstArraySlice;
        Texture1DArray.ArraySize       := ArraySize;
      end;
    D3D11_DSV_DIMENSION_TEXTURE2D:
      begin
        Texture2D.MipSlice := MipSlice;
      end;
    D3D11_DSV_DIMENSION_TEXTURE2DARRAY:
      begin
        Texture2DArray.MipSlice        := MipSlice;
        Texture2DArray.FirstArraySlice := FirstArraySlice;
        Texture2DArray.ArraySize       := ArraySize;
      end;
    D3D11_DSV_DIMENSION_TEXTURE2DMS:
      begin
      end;
    D3D11_DSV_DIMENSION_TEXTURE2DMSARRAY:
      begin
        Texture2DMSArray.FirstArraySlice := FirstArraySlice;
        Texture2DMSArray.ArraySize       := ArraySize;
      end;
  end;
end;

procedure TD3D11_DEPTH_STENCIL_VIEW_DESC.Init(pTex1D: ID3D11Texture1D; AViewDimension: TD3D11_DSV_DIMENSION; AFormat: TDXGI_FORMAT; MipSlice: UINT; FirstArraySlice: UINT; ArraySize: INT32; AFlags: UINT);
var
  lArraySize: Integer;
  TexDesc   : TD3D11_TEXTURE1D_DESC;
begin
  ViewDimension := AViewDimension;
  Flags         := AFlags;
  Format        := AFormat;
  lArraySize    := ArraySize;
  if (DXGI_FORMAT_UNKNOWN = Format) or ((-1 = ArraySize) and (D3D11_DSV_DIMENSION_TEXTURE1DARRAY = ViewDimension)) then
  begin
    pTex1D.GetDesc(TexDesc);
    if (DXGI_FORMAT_UNKNOWN = Format) then
      Format := TexDesc.Format;
    if (-1 = lArraySize) then
      lArraySize := TexDesc.ArraySize - FirstArraySlice;
  end;
  case (ViewDimension) of
    D3D11_DSV_DIMENSION_TEXTURE1D:
      Texture1D.MipSlice := MipSlice;
    D3D11_DSV_DIMENSION_TEXTURE1DARRAY:
      begin
        Texture1DArray.MipSlice        := MipSlice;
        Texture1DArray.FirstArraySlice := FirstArraySlice;
        Texture1DArray.ArraySize       := lArraySize;
      end;
  end;
end;

procedure TD3D11_DEPTH_STENCIL_VIEW_DESC.Init(pTex2D: ID3D11Texture2D; AViewDimension: TD3D11_DSV_DIMENSION; AFormat: TDXGI_FORMAT; MipSlice: UINT; FirstArraySlice: UINT; ArraySize: INT32; AFlags: UINT);
var
  lArraySize: Integer;
  TexDesc   : TD3D11_TEXTURE2D_DESC;
begin
  ViewDimension := AViewDimension;
  Flags         := AFlags;
  Format        := AFormat;
  lArraySize    := ArraySize;
  if (DXGI_FORMAT_UNKNOWN = Format) or ((-1 = lArraySize) and ((D3D11_DSV_DIMENSION_TEXTURE2DARRAY = ViewDimension) or (D3D11_DSV_DIMENSION_TEXTURE2DMSARRAY = ViewDimension))) then
  begin
    pTex2D.GetDesc(TexDesc);
    if (DXGI_FORMAT_UNKNOWN = Format) then
      Format := TexDesc.Format;
    if (-1 = lArraySize) then
      lArraySize := TexDesc.ArraySize - FirstArraySlice;
  end;
  case (ViewDimension) of
    D3D11_DSV_DIMENSION_TEXTURE2D:
      begin
        Texture2D.MipSlice := MipSlice;
      end;
    D3D11_DSV_DIMENSION_TEXTURE2DARRAY:
      begin
        Texture2DArray.MipSlice        := MipSlice;
        Texture2DArray.FirstArraySlice := FirstArraySlice;
        Texture2DArray.ArraySize       := ArraySize;
      end;
    D3D11_DSV_DIMENSION_TEXTURE2DMS:
      begin;
      end;
    D3D11_DSV_DIMENSION_TEXTURE2DMSARRAY:
      begin
        Texture2DMSArray.FirstArraySlice := FirstArraySlice;
        Texture2DMSArray.ArraySize       := ArraySize;
      end;
  end;
end;

{ TD3D11_QUERY_DESC }
procedure TD3D11_QUERY_DESC.Init(AQuery: TD3D11_QUERY; AMiscFlags: UINT);
begin
  Query     := AQuery;
  MiscFlags := AMiscFlags;
end;

{ TD3D11_COUNTER_DESC }
procedure TD3D11_COUNTER_DESC.Init(ACounter: TD3D11_COUNTER; AMiscFlags: UINT);
begin
  Counter   := ACounter;
  MiscFlags := AMiscFlags;
end;

{ TD3D11_RENDER_TARGET_VIEW_DESC }
procedure TD3D11_RENDER_TARGET_VIEW_DESC.Init(AViewDimension: TD3D11_RTV_DIMENSION; AFormat: TDXGI_FORMAT; MipSlice: UINT; FirstArraySlice: UINT; ArraySize: INT32);
begin
  Format        := AFormat;
  ViewDimension := AViewDimension;
  case (ViewDimension) of
    D3D11_RTV_DIMENSION_BUFFER:
      begin
        Buffer.FirstElement := MipSlice;
        Buffer.NumElements  := FirstArraySlice;
      end;
    D3D11_RTV_DIMENSION_TEXTURE1D:
      begin
        Texture1D.MipSlice := MipSlice;
      end;
    D3D11_RTV_DIMENSION_TEXTURE1DARRAY:
      begin
        Texture1DArray.MipSlice        := MipSlice;
        Texture1DArray.FirstArraySlice := FirstArraySlice;
        Texture1DArray.ArraySize       := ArraySize;
      end;
    D3D11_RTV_DIMENSION_TEXTURE2D:
      begin
        Texture2D.MipSlice := MipSlice;
      end;
    D3D11_RTV_DIMENSION_TEXTURE2DARRAY:
      begin
        Texture2DArray.MipSlice        := MipSlice;
        Texture2DArray.FirstArraySlice := FirstArraySlice;
        Texture2DArray.ArraySize       := ArraySize;
      end;
    D3D11_RTV_DIMENSION_TEXTURE2DMS:
      begin
      end;
    D3D11_RTV_DIMENSION_TEXTURE2DMSARRAY:
      begin
        Texture2DMSArray.FirstArraySlice := FirstArraySlice;
        Texture2DMSArray.ArraySize       := ArraySize;
      end;
    D3D11_RTV_DIMENSION_TEXTURE3D:
      begin
        Texture3D.MipSlice    := MipSlice;
        Texture3D.FirstWSlice := FirstArraySlice;
        Texture3D.WSize       := ArraySize;
      end;
  end;
end;

procedure TD3D11_RENDER_TARGET_VIEW_DESC.Init(pBuffer: ID3D11Buffer; AFormat: TDXGI_FORMAT; FirstElement: UINT; NumElements: UINT);
begin
  Format              := AFormat;
  ViewDimension       := D3D11_RTV_DIMENSION_BUFFER;
  Buffer.FirstElement := FirstElement;
  Buffer.NumElements  := NumElements;
end;

procedure TD3D11_RENDER_TARGET_VIEW_DESC.Init(pTex1D: ID3D11Texture1D; AViewDimension: TD3D11_RTV_DIMENSION; AFormat: TDXGI_FORMAT; MipSlice: UINT; FirstArraySlice: UINT; ArraySize: INT32);
var
  TexDesc   : TD3D11_TEXTURE1D_DESC;
  lArraySize: Integer;
begin
  ViewDimension := AViewDimension;
  Format        := AFormat;
  lArraySize    := ArraySize;
  if (DXGI_FORMAT_UNKNOWN = Format) or ((-1 = lArraySize) and (D3D11_RTV_DIMENSION_TEXTURE1DARRAY = ViewDimension)) then
  begin
    pTex1D.GetDesc(TexDesc);
    if (DXGI_FORMAT_UNKNOWN = Format) then
      Format := TexDesc.Format;
    if (-1 = lArraySize) then
      lArraySize := TexDesc.ArraySize - FirstArraySlice;
  end;
  case (ViewDimension) of
    D3D11_RTV_DIMENSION_TEXTURE1D:
      begin
        Texture1D.MipSlice := MipSlice;
      end;
    D3D11_RTV_DIMENSION_TEXTURE1DARRAY:
      begin
        Texture1DArray.MipSlice        := MipSlice;
        Texture1DArray.FirstArraySlice := FirstArraySlice;
        Texture1DArray.ArraySize       := lArraySize;
      end;
  end;
end;

procedure TD3D11_RENDER_TARGET_VIEW_DESC.Init(pTex2D: ID3D11Texture2D; AViewDimension: TD3D11_RTV_DIMENSION; AFormat: TDXGI_FORMAT; MipSlice: UINT; FirstArraySlice: UINT; ArraySize: INT32);
var
  TexDesc   : TD3D11_TEXTURE2D_DESC;
  lArraySize: Integer;
begin
  ViewDimension := AViewDimension;
  Format        := AFormat;
  lArraySize    := ArraySize;
  if (DXGI_FORMAT_UNKNOWN = Format) or ((-1 = lArraySize) and ((D3D11_RTV_DIMENSION_TEXTURE2DARRAY = ViewDimension) or (D3D11_RTV_DIMENSION_TEXTURE2DMSARRAY = ViewDimension))) then
  begin
    pTex2D.GetDesc(TexDesc);
    if (DXGI_FORMAT_UNKNOWN = Format) then
      Format := TexDesc.Format;
    if (-1 = lArraySize) then
      lArraySize := TexDesc.ArraySize - FirstArraySlice;
  end;
  case (ViewDimension) of
    D3D11_RTV_DIMENSION_TEXTURE2D:
      begin
        Texture2D.MipSlice := MipSlice;
      end;
    D3D11_RTV_DIMENSION_TEXTURE2DARRAY:
      begin
        Texture2DArray.MipSlice        := MipSlice;
        Texture2DArray.FirstArraySlice := FirstArraySlice;
        Texture2DArray.ArraySize       := lArraySize;
      end;
    D3D11_RTV_DIMENSION_TEXTURE2DMS:
      begin
      end;
    D3D11_RTV_DIMENSION_TEXTURE2DMSARRAY:
      begin
        Texture2DMSArray.FirstArraySlice := FirstArraySlice;
        Texture2DMSArray.ArraySize       := lArraySize;
      end;
  end;
end;

procedure TD3D11_RENDER_TARGET_VIEW_DESC.Init(pTex3D: ID3D11Texture3D; AFormat: TDXGI_FORMAT; MipSlice: UINT; FirstWSlice: UINT; WSize: INT32);
var
  TexDesc: TD3D11_TEXTURE3D_DESC;
  lwSize : Integer;
begin
  Format        := AFormat;
  lwSize        := WSize;
  ViewDimension := D3D11_RTV_DIMENSION_TEXTURE3D;
  if (DXGI_FORMAT_UNKNOWN = Format) or (-1 = lwSize) then
  begin
    pTex3D.GetDesc(TexDesc);
    if (DXGI_FORMAT_UNKNOWN = Format) then
      Format := TexDesc.Format;
    if (-1 = lwSize) then
      lwSize := TexDesc.Depth - FirstWSlice;
  end;
  Texture3D.MipSlice    := MipSlice;
  Texture3D.FirstWSlice := FirstWSlice;
  Texture3D.WSize       := lwSize;
end;

{ TD3D11_SHADER_RESOURCE_VIEW_DESC }
procedure TD3D11_SHADER_RESOURCE_VIEW_DESC.Init(AViewDimension: TD3D11_SRV_DIMENSION; AFormat: TDXGI_FORMAT; AMostDetailedMip: UINT; AMipLevels: INT32; AFirstArraySlice: UINT; AArraySize: INT32; AFlags: UINT);
begin
  Format        := AFormat;
  ViewDimension := AViewDimension;
  case (AViewDimension) of
    D3D11_SRV_DIMENSION_BUFFER:
      begin
        Buffer.FirstElement := AMostDetailedMip;
        Buffer.NumElements  := AMipLevels;
      end;
    D3D11_SRV_DIMENSION_TEXTURE1D:
      begin
        Texture1D.MostDetailedMip := AMostDetailedMip;
        Texture1D.MipLevels       := AMipLevels;
      end;
    D3D11_SRV_DIMENSION_TEXTURE1DARRAY:
      begin
        Texture1DArray.MostDetailedMip := AMostDetailedMip;
        Texture1DArray.MipLevels       := AMipLevels;
        Texture1DArray.FirstArraySlice := AFirstArraySlice;
        Texture1DArray.ArraySize       := AArraySize;
      end;
    D3D11_SRV_DIMENSION_TEXTURE2D:
      begin
        Texture2D.MostDetailedMip := AMostDetailedMip;
        Texture2D.MipLevels       := AMipLevels;
      end;
    D3D11_SRV_DIMENSION_TEXTURE2DARRAY:
      begin
        Texture2DArray.MostDetailedMip := AMostDetailedMip;
        Texture2DArray.MipLevels       := AMipLevels;
        Texture2DArray.FirstArraySlice := AFirstArraySlice;
        Texture2DArray.ArraySize       := AArraySize;
      end;
    D3D11_SRV_DIMENSION_TEXTURE2DMS:
      begin
      end;
    D3D11_SRV_DIMENSION_TEXTURE2DMSARRAY:
      begin
        Texture2DMSArray.FirstArraySlice := AFirstArraySlice;
        Texture2DMSArray.ArraySize       := AArraySize;
      end;
    D3D11_SRV_DIMENSION_TEXTURE3D:
      begin
        Texture3D.MostDetailedMip := AMostDetailedMip;
        Texture3D.MipLevels       := AMipLevels;
      end;
    D3D11_SRV_DIMENSION_TEXTURECUBE:
      begin
        TextureCube.MostDetailedMip := AMostDetailedMip;
        TextureCube.MipLevels       := AMipLevels;
      end;
    D3D11_SRV_DIMENSION_TEXTURECUBEARRAY:
      begin
        TextureCubeArray.MostDetailedMip  := AMostDetailedMip;
        TextureCubeArray.MipLevels        := AMipLevels;
        TextureCubeArray.First2DArrayFace := AFirstArraySlice;
        TextureCubeArray.NumCubes         := AArraySize;
      end;
    D3D11_SRV_DIMENSION_BUFFEREX:
      begin
        BufferEx.FirstElement := AMostDetailedMip;
        BufferEx.NumElements  := AMipLevels;
        BufferEx.Flags        := AFlags;
      end;
  end;
end;

procedure TD3D11_SHADER_RESOURCE_VIEW_DESC.Init(ABuffer: ID3D11Buffer; AFormat: TDXGI_FORMAT; AfirstElement: UINT; AnumElements: UINT; AFlags: UINT);
begin
  Format                := AFormat;
  ViewDimension         := D3D11_SRV_DIMENSION_BUFFEREX;
  BufferEx.FirstElement := AfirstElement;
  BufferEx.NumElements  := AnumElements;
  BufferEx.Flags        := AFlags;
end;

procedure TD3D11_SHADER_RESOURCE_VIEW_DESC.Init(pTex1D: ID3D11Texture1D; AViewDimension: TD3D11_SRV_DIMENSION; AFormat: TDXGI_FORMAT; AMostDetailedMip: UINT; AMipLevels: INT32; AFirstArraySlice: UINT; AArraySize: INT32);
var
  TexDesc   : TD3D11_TEXTURE1D_DESC;
  lMipLevels: Integer;
  lArraySize: Integer;
begin
  lMipLevels    := AMipLevels;
  lArraySize    := AArraySize;
  ViewDimension := AViewDimension;
  if (DXGI_FORMAT_UNKNOWN = AFormat) or (-1 = lMipLevels) or ((-1 = lArraySize) and (D3D11_SRV_DIMENSION_TEXTURE1DARRAY = ViewDimension)) then
  begin
    pTex1D.GetDesc(TexDesc);
    if (DXGI_FORMAT_UNKNOWN = AFormat) then
      Format := TexDesc.Format;
    if (-1 = lMipLevels) then
      lMipLevels := TexDesc.MipLevels - AMostDetailedMip;
    if (-1 = lArraySize) then
      lArraySize := TexDesc.ArraySize - AFirstArraySlice;
  end;
  Format := AFormat;
  case (ViewDimension) of
    D3D11_SRV_DIMENSION_TEXTURE1D:
      begin
        Texture1D.MostDetailedMip := AMostDetailedMip;
        Texture1D.MipLevels       := lMipLevels;
      end;
    D3D11_SRV_DIMENSION_TEXTURE1DARRAY:
      begin
        Texture1DArray.MostDetailedMip := AMostDetailedMip;
        Texture1DArray.MipLevels       := lMipLevels;
        Texture1DArray.FirstArraySlice := AFirstArraySlice;
        Texture1DArray.ArraySize       := lArraySize;
      end;
  end;
end;

procedure TD3D11_SHADER_RESOURCE_VIEW_DESC.Init(pTex2D: ID3D11Texture2D; AViewDimension: TD3D11_SRV_DIMENSION; AFormat: TDXGI_FORMAT; AMostDetailedMip: UINT; AMipLevels: INT32; AFirstArraySlice: UINT; AArraySize: INT32);
var
  TexDesc   : TD3D11_TEXTURE2D_DESC;
  lMipLevels: Integer;
  lArraySize: Integer;
begin
  ViewDimension := AViewDimension;
  Format        := AFormat;
  lMipLevels    := AMipLevels;
  lArraySize    := AArraySize;
  if (DXGI_FORMAT_UNKNOWN = Format) or ((-1 = lMipLevels) and (D3D11_SRV_DIMENSION_TEXTURE2DMS <> ViewDimension) and (D3D11_SRV_DIMENSION_TEXTURE2DMSARRAY <> ViewDimension)) or ((-1 = lArraySize) and ((D3D11_SRV_DIMENSION_TEXTURE2DARRAY = ViewDimension) or (D3D11_SRV_DIMENSION_TEXTURE2DMSARRAY = ViewDimension) or (D3D11_SRV_DIMENSION_TEXTURECUBEARRAY = ViewDimension))) then
  begin
    pTex2D.GetDesc(TexDesc);
    if (DXGI_FORMAT_UNKNOWN = Format) then
      Format := TexDesc.Format;
    if (-1 = lMipLevels) then
      lMipLevels := TexDesc.MipLevels - AMostDetailedMip;
    if (-1 = lArraySize) then
    begin
      lArraySize := TexDesc.ArraySize - AFirstArraySlice;
      if (D3D11_SRV_DIMENSION_TEXTURECUBEARRAY = ViewDimension) then
        lArraySize := lArraySize div 6;
    end;
  end;
  case (ViewDimension) of
    D3D11_SRV_DIMENSION_TEXTURE2D:
      begin
        Texture2D.MostDetailedMip := AMostDetailedMip;
        Texture2D.MipLevels       := lMipLevels;
      end;
    D3D11_SRV_DIMENSION_TEXTURE2DARRAY:
      begin
        Texture2DArray.MostDetailedMip := AMostDetailedMip;
        Texture2DArray.MipLevels       := lMipLevels;
        Texture2DArray.FirstArraySlice := AFirstArraySlice;
        Texture2DArray.ArraySize       := lArraySize;
      end;
    D3D11_SRV_DIMENSION_TEXTURE2DMS:
      begin
      end;
    D3D11_SRV_DIMENSION_TEXTURE2DMSARRAY:
      begin
        Texture2DMSArray.FirstArraySlice := AFirstArraySlice;
        Texture2DMSArray.ArraySize       := lArraySize;
      end;
    D3D11_SRV_DIMENSION_TEXTURECUBE:
      begin
        TextureCube.MostDetailedMip := AMostDetailedMip;
        TextureCube.MipLevels       := lMipLevels;
      end;
    D3D11_SRV_DIMENSION_TEXTURECUBEARRAY:
      begin
        TextureCubeArray.MostDetailedMip  := AMostDetailedMip;
        TextureCubeArray.MipLevels        := lMipLevels;
        TextureCubeArray.First2DArrayFace := AFirstArraySlice;
        TextureCubeArray.NumCubes         := lArraySize;
      end;
  end;
end;

procedure TD3D11_SHADER_RESOURCE_VIEW_DESC.Init(pTex3D: ID3D11Texture3D; AFormat: TDXGI_FORMAT; AMostDetailedMip: UINT; AMipLevels: INT32);
var
  TexDesc   : TD3D11_TEXTURE3D_DESC;
  lMipLevels: Integer;
begin
  lMipLevels    := AMipLevels;
  ViewDimension := D3D11_SRV_DIMENSION_TEXTURE3D;
  Format        := AFormat;
  if (DXGI_FORMAT_UNKNOWN = Format) or (lMipLevels = -1) then
  begin
    pTex3D.GetDesc(TexDesc);
    if (DXGI_FORMAT_UNKNOWN = Format) then
      Format := TexDesc.Format;
    if (lMipLevels = -1) then
      lMipLevels := TexDesc.MipLevels - AMostDetailedMip;
  end;
  Texture3D.MostDetailedMip := AMostDetailedMip;
  Texture3D.MipLevels       := lMipLevels;
end;

{ TD3D11_TEXTURE3D_DESC }
procedure TD3D11_TEXTURE3D_DESC.Init(AFormat: TDXGI_FORMAT; AWidth: UINT; AHeight: UINT; ADepth: UINT; AMipLevels: UINT; ABindFlags: UINT; AUsage: TD3D11_USAGE; ACPUAccessFlags: UINT; AMiscFlags: UINT);
begin
  Width          := AWidth;
  Height         := AHeight;
  Depth          := ADepth;
  MipLevels      := AMipLevels;
  Format         := AFormat;
  Usage          := AUsage;
  BindFlags      := ABindFlags;
  CPUAccessFlags := ACPUAccessFlags;
  MiscFlags      := AMiscFlags;
end;

{ TD3D11_TEXTURE2D_DESC }
procedure TD3D11_TEXTURE2D_DESC.Init(AFormat: TDXGI_FORMAT; AWidth: UINT; AHeight: UINT; AArraySize: UINT; AMipLevels: UINT; ABindFlags: UINT; AUsage: TD3D11_USAGE; ACPUAccessFlags: UINT; ASampleCount: UINT; ASampleQuality: UINT; AMiscFlags: UINT);
begin
  Width              := AWidth;
  Height             := AHeight;
  MipLevels          := AMipLevels;
  ArraySize          := AArraySize;
  Format             := AFormat;
  SampleDesc.Count   := ASampleCount;
  SampleDesc.Quality := ASampleQuality;
  Usage              := AUsage;
  BindFlags          := ABindFlags;
  CPUAccessFlags     := ACPUAccessFlags;
  MiscFlags          := AMiscFlags;
end;

{ TD3D11_TEXTURE1D_DESC }
procedure TD3D11_TEXTURE1D_DESC.Init(AFormat: TDXGI_FORMAT; AWidth: UINT; AArraySize: UINT; AMipLevels: UINT; ABindFlags: UINT; AUsage: TD3D11_USAGE; ACPUAccessFlags: UINT; AMiscFlags: UINT);
begin
  Width          := AWidth;
  MipLevels      := AMipLevels;
  ArraySize      := AArraySize;
  Format         := AFormat;
  Usage          := AUsage;
  BindFlags      := ABindFlags;
  CPUAccessFlags := ACPUAccessFlags;
  MiscFlags      := AMiscFlags;
end;

{ TD3D11_BUFFER_DESC }
procedure TD3D11_BUFFER_DESC.Init(AByteWidth: UINT; ABindFlags: UINT; AUsage: TD3D11_USAGE; ACPUAccessFlags: UINT; AMiscFlags: UINT; AStructureByteStride: UINT);
begin
  ByteWidth           := AByteWidth;
  Usage               := AUsage;
  BindFlags           := ABindFlags;
  CPUAccessFlags      := ACPUAccessFlags;
  MiscFlags           := AMiscFlags;
  StructureByteStride := AStructureByteStride;
end;

{ TD3D11_RASTERIZER_DESC }
procedure TD3D11_RASTERIZER_DESC.Init;
begin
  FillMode              := D3D11_FILL_SOLID;
  CullMode              := D3D11_CULL_BACK;
  FrontCounterClockwise := False;
  DepthBias             := D3D11_DEFAULT_DEPTH_BIAS;
  DepthBiasClamp        := D3D11_DEFAULT_DEPTH_BIAS_CLAMP;
  SlopeScaledDepthBias  := D3D11_DEFAULT_SLOPE_SCALED_DEPTH_BIAS;
  DepthClipEnable       := True;
  ScissorEnable         := False;
  MultisampleEnable     := False;
  AntialiasedLineEnable := False;
end;

{ TD3D11_BLEND_DESC }
procedure TD3D11_BLEND_DESC.Init;
var
  i: Integer;
begin
  AlphaToCoverageEnable  := False;
  IndependentBlendEnable := False;
  for i                  := 0 to D3D11_SIMULTANEOUS_RENDER_TARGET_COUNT - 1 do
  begin
    RenderTarget[i] := defaultRenderTargetBlendDesc;
  end;
end;

function TD3D11_BLEND_DESC.defaultRenderTargetBlendDesc: TD3D11_RENDER_TARGET_BLEND_DESC;
begin
  Result.BlendEnable           := False;
  Result.SrcBlend              := D3D11_BLEND_ONE;
  Result.DestBlend             := D3D11_BLEND_ZERO;
  Result.BlendOp               := D3D11_BLEND_OP_ADD;
  Result.SrcBlendAlpha         := D3D11_BLEND_ONE;
  Result.DestBlendAlpha        := D3D11_BLEND_ZERO;
  Result.BlendOpAlpha          := D3D11_BLEND_OP_ADD;
  Result.RenderTargetWriteMask := Ord(D3D11_COLOR_WRITE_ENABLE_ALL);
end;

{ TD3D11_DEPTH_STENCIL_DESC }
procedure TD3D11_DEPTH_STENCIL_DESC.Init;
begin
  DepthEnable      := True;
  DepthWriteMask   := D3D11_DEPTH_WRITE_MASK_ALL;
  DepthFunc        := D3D11_COMPARISON_LESS;
  StencilEnable    := False;
  StencilReadMask  := D3D11_DEFAULT_STENCIL_READ_MASK;
  StencilWriteMask := D3D11_DEFAULT_STENCIL_WRITE_MASK;
  FrontFace        := defaultStencilOp;
  BackFace         := defaultStencilOp;
end;

function TD3D11_DEPTH_STENCIL_DESC.defaultStencilOp: TD3D11_DEPTH_STENCILOP_DESC;
begin
  Result.StencilFailOp      := D3D11_STENCIL_OP_KEEP;
  Result.StencilDepthFailOp := D3D11_STENCIL_OP_KEEP;
  Result.StencilPassOp      := D3D11_STENCIL_OP_KEEP;
  Result.StencilFunc        := D3D11_COMPARISON_ALWAYS;
end;

{ TD3D11_BOX }
class operator TD3D11_BOX.Equal(a, b: TD3D11_BOX): LongBool;
begin
  Result := (a.left = b.left) and (a.top = b.top) and (a.front = b.front) and (a.right = b.right) and (a.bottom = b.bottom) and (a.back = b.back);
end;

class operator TD3D11_BOX.NotEqual(a, b: TD3D11_BOX): LongBool;
begin
  Result := (a.left <> b.left) or (a.top <> b.top) or (a.front <> b.front) or (a.right <> b.right) or (a.bottom <> b.bottom) or (a.back <> b.back);
end;

procedure TD3D11_BOX.Init(ALeft: LONG; ATop: LONG; AFront: LONG; ARight: LONG; ABottom: LONG; ABack: LONG);
begin
  left   := ALeft;
  top    := ATop;
  front  := AFront;
  right  := ARight;
  bottom := ABottom;
  back   := ABack;
end;

{ TD3D11_VIEWPORT }
class operator TD3D11_VIEWPORT.Equal(a, b: TD3D11_VIEWPORT): LongBool;
begin
  Result := (a.TopLeftX = b.TopLeftX) and (a.TopLeftY = b.TopLeftY) and (a.Width = b.Width) and (a.Height = b.Height) and (a.MinDepth = b.MinDepth) and (a.MaxDepth = b.MaxDepth);
end;

class operator TD3D11_VIEWPORT.NotEqual(a, b: TD3D11_VIEWPORT): LongBool;
begin
  Result := (a.TopLeftX <> b.TopLeftX) or (a.TopLeftY <> b.TopLeftY) or (a.Width <> b.Width) or (a.Height <> b.Height) or (a.MinDepth <> b.MinDepth) or (a.MaxDepth <> b.MaxDepth);
end;

procedure TD3D11_VIEWPORT.Init(TopLeftX: Single; TopLeftY: Single; Width: Single; Height: Single; MinDepth: Single; MaxDepth: Single);
begin
  // TopLeftX := TopLeftX;
  // TopLeftY := TopLeftY;
  // Width    := Width;
  // Height   := Height;
  // MinDepth := MinDepth;
  // MaxDepth := MaxDepth;
end;

procedure TD3D11_VIEWPORT.Init(InBuffer: ID3D11Buffer; pRTView: ID3D11RenderTargetView; TopLeftX: Single; MinDepth: Single; MaxDepth: Single);
var
  RTVDesc    : TD3D11_RENDER_TARGET_VIEW_DESC;
  NumElements: UINT;
begin
  pRTView.GetDesc(RTVDesc);
  NumElements := 0;
  case (RTVDesc.ViewDimension) of
    D3D11_RTV_DIMENSION_BUFFER:
      NumElements := RTVDesc.Buffer.NumElements;
  end;
  TopLeftX := TopLeftX;
  TopLeftY := 0.0;
  Width    := NumElements - TopLeftX;
  Height   := 1.0;
  // MinDepth := MinDepth;
  // MaxDepth := MaxDepth;
end;

procedure TD3D11_VIEWPORT.Init(pTex1D: ID3D11Texture1D; pRTView: ID3D11RenderTargetView; TopLeftX: Single; MinDepth: Single; MaxDepth: Single);
var
  TexDesc         : TD3D11_TEXTURE1D_DESC;
  RTVDesc         : TD3D11_RENDER_TARGET_VIEW_DESC;
  MipSlice        : UINT;
  SubResourceWidth: UINT;
begin
  pTex1D.GetDesc(TexDesc);
  pRTView.GetDesc(RTVDesc);
  MipSlice := 0;
  case (RTVDesc.ViewDimension) of
    D3D11_RTV_DIMENSION_TEXTURE1D:
      MipSlice := RTVDesc.Texture1D.MipSlice;
    D3D11_RTV_DIMENSION_TEXTURE1DARRAY:
      MipSlice := RTVDesc.Texture1DArray.MipSlice;
  end;
  SubResourceWidth := TexDesc.Width div (1 shl MipSlice);
  TopLeftX         := TopLeftX;
  TopLeftY         := 0.0;
  // Width := (SubResourceWidth ? SubResourceWidth : 1) - topLeftX; C++ is bull shit
  if SubResourceWidth > 0 then
    Width := SubResourceWidth - TopLeftX
  else
    Width := 1 - TopLeftX;
  Height  := 1.0;
  // MinDepth := MinDepth;
  // MaxDepth := MaxDepth;
end;

procedure TD3D11_VIEWPORT.Init(pTex2D: ID3D11Texture2D; pRTView: ID3D11RenderTargetView; TopLeftX: Single; TopLeftY: Single; MinDepth: Single; MaxDepth: Single);
var
  TexDesc                            : TD3D11_TEXTURE2D_DESC;
  RTVDesc                            : TD3D11_RENDER_TARGET_VIEW_DESC;
  MipSlice                           : UINT;
  SubResourceWidth, SubResourceHeight: UINT;
begin
  pTex2D.GetDesc(TexDesc);
  pRTView.GetDesc(RTVDesc);
  MipSlice := 0;
  case (RTVDesc.ViewDimension) of
    D3D11_RTV_DIMENSION_TEXTURE2D:
      MipSlice := RTVDesc.Texture2D.MipSlice;
    D3D11_RTV_DIMENSION_TEXTURE2DARRAY:
      MipSlice := RTVDesc.Texture2DArray.MipSlice;
  end;
  SubResourceWidth  := TexDesc.Width div (1 shl MipSlice);
  SubResourceHeight := TexDesc.Height div (1 shl MipSlice);
  TopLeftX          := TopLeftX;
  TopLeftY          := TopLeftY;
  // Width := (SubResourceWidth ? SubResourceWidth : 1) - topLeftX; C++ is bull shit
  if SubResourceWidth > 0 then
    Width := SubResourceWidth - -TopLeftX
  else
    Width := 1 - TopLeftX;
  // Height := (SubResourceHeight ? SubResourceHeight : 1) - topLeftY; C++ is bull shit
  if SubResourceHeight > 0 then
    Height := SubResourceHeight - TopLeftY
  else
    Height := 1 - -TopLeftY;
  // MinDepth := MinDepth;
  // MaxDepth := MaxDepth;
end;

procedure TD3D11_VIEWPORT.Init(pTex3D: ID3D11Texture3D; pRTView: ID3D11RenderTargetView; TopLeftX: Single; TopLeftY: Single; MinDepth: Single; MaxDepth: Single);
var
  TexDesc                            : TD3D11_TEXTURE3D_DESC;
  RTVDesc                            : TD3D11_RENDER_TARGET_VIEW_DESC;
  MipSlice                           : UINT;
  SubResourceWidth, SubResourceHeight: UINT;
begin
  pTex3D.GetDesc(TexDesc);
  pRTView.GetDesc(RTVDesc);
  MipSlice := 0;
  case (RTVDesc.ViewDimension) of
    D3D11_RTV_DIMENSION_TEXTURE3D:
      MipSlice := RTVDesc.Texture3D.MipSlice;
  end;
  SubResourceWidth  := TexDesc.Width div (1 shl MipSlice);
  SubResourceHeight := TexDesc.Height div (1 shl MipSlice);
  TopLeftX          := TopLeftX;
  TopLeftY          := TopLeftY;
  // Width := (SubResourceWidth ? SubResourceWidth : 1) - topLeftX;  C++ is bull shit
  if SubResourceWidth > 0 then
    Width := SubResourceWidth - TopLeftX
  else
    Width := 1 - TopLeftX;
  // Height := (SubResourceHeight ? SubResourceHeight : 1) - topLeftY; C++ is bull shit
  if SubResourceHeight > 0 then
    Height := SubResourceHeight - TopLeftY
  else
    Height := 1 - TopLeftY;
  // MinDepth := MinDepth;
  // MaxDepth := MaxDepth;
end;

end.
