// Test.cpp : 定义 DLL 应用程序的导出函数。
//

#include "stdafx.h"
#include "Test.h"


// 这是导出变量的一个示例
TEST_API int nTest=0;

// 这是导出函数的一个示例。
TEST_API int fnTest(void)
{
	::MessageBoxA(0, (LPCSTR)"C dll export function", (LPCSTR)"fnTest", 64);
	CTest::CTest();
    return 42;
}

// 这是已导出类的构造函数。
// 有关类定义的信息，请参阅 Test.h
CTest::CTest()
{
	::MessageBoxA(0, (LPCSTR)"C++ dll export function", (LPCSTR)"CTest::CTest()", 64);
    return;
}

int CTest::MyAdd(int a, int b)
{
	return a + b;
}