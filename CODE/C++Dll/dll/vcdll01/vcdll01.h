// ���� ifdef ���Ǵ���ʹ�� DLL �������򵥵�
// ��ı�׼�������� DLL �е������ļ��������������϶���� VCDLL01_EXPORTS
// ���ű���ġ���ʹ�ô� DLL ��
// �κ�������Ŀ�ϲ�Ӧ����˷��š�������Դ�ļ��а������ļ����κ�������Ŀ���Ὣ
// VCDLL01_API ������Ϊ�Ǵ� DLL ����ģ����� DLL ���ô˺궨���
// ������Ϊ�Ǳ������ġ�
#ifdef VCDLL01_EXPORTS
#define VCDLL01_API __declspec(dllexport)
#else
#define VCDLL01_API __declspec(dllimport)
#endif

// �����Ǵ� vcdll01.dll ������
class VCDLL01_API Cvcdll01 {
public:
	Cvcdll01(void);
	// TODO:  �ڴ�������ķ�����
	int MyAdd(int a, int b);
	int MySub(int a, int b);
};

extern VCDLL01_API int nvcdll01;

VCDLL01_API int fnvcdll01(void);
