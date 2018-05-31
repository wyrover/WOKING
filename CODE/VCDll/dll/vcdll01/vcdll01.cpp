// vcdll01.cpp : 定义 DLL 应用程序的导出函数。
//

#include "stdafx.h"
#include "vcdll01.h"


// 这是导出变量的一个示例
VCDLL01_API int nvcdll01=0;

// 这是导出函数的一个示例。
VCDLL01_API int fnvcdll01(void)
{
    return 42;
}

// 这是已导出类的构造函数。
// 有关类定义的信息，请参阅 vcdll01.h
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
