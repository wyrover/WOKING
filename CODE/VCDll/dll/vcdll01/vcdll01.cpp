// vcdll01.cpp : ���� DLL Ӧ�ó���ĵ���������
//

#include "stdafx.h"
#include "vcdll01.h"


// ���ǵ���������һ��ʾ��
VCDLL01_API int nvcdll01=0;

// ���ǵ���������һ��ʾ����
VCDLL01_API int fnvcdll01(void)
{
    return 42;
}

// �����ѵ�����Ĺ��캯����
// �й��ඨ�����Ϣ������� vcdll01.h
Cvcdll01::Cvcdll01()
{
    return;
}


int Cvcdll01::MyAdd(int a, int b)
{
	return a + b;
}


int Cvcdll01::MySub(int a, int b)
{
	return a - b;
}
