#include <cv.h>
#include <cvaux.h>
#include <cxcore.h>
#include <highgui.h>
#include <stdio.h>
#include "PerfTimer.h"


void basic_invert(const IplImage* src, IplImage* dst)
{
	int i=0;
	for (;i!=src->imageSize; i++)
		dst->imageData[i]=~((uchar)src->imageData[i]);
}

void optimized_invert(const IplImage* src, IplImage* dst)
{
	const uchar* src1=(const uchar*)src->imageData;
	uchar* dst1=(uchar*)dst->imageData;
	const int step1=src->widthStep;
	const int width=src->width;
	int height=src->height;
	const int numCh=src->nChannels;

	// for all rows
	for( ; height--; src1 += step1, dst1 += step1 )
    {
        int i = 0;

		// if proper row pointer
        if( (((size_t)src1 | (size_t)dst1) & 3) == 0 )
        {
			// unroll 4x
            for( ; i <= step1 - 16; i += 16 )
            {
				const int* src1i=(const int*)(src1+i);
				int* dst1i=(int*)(dst1+i);
                int t0 = ~(src1i)[0];
                int t1 = ~(src1i)[1];
				int t2 = ~(src1i)[2];
				int t3 = ~(src1i)[3];

				dst1i[0]=t0;
				dst1i[1]=t1;
				dst1i[2]=t2;
				dst1i[3]=t3;
            }

			// now treat remaining pixels per row, not divisible by 16
            for( ; i <= step1 - 4; i += 4 )
            {
                int t = ~*(const int*)(src1+i);
                *(int*)(dst1+i) = t;
            }
        }

		// now treat remaining pixels per row, not divisible by 4
        for( ; i < step1; i++ )
        {
            int t = ~((const uchar*)src1)[i];
            dst1[i] = (uchar)t;
        }
    }
}


// To correctly process, the image should have (width % 16 ==0) 
void optimized_invert_sse2(const IplImage* src, IplImage* dst)
{
	// no difference between char* and unsigned int* if we do
	// bitwise operations! That's an elegant trick!
	const int* xi=(const int*)src->imageData;
	int* yi=(int*)dst->imageData;
	
	// divide by 4. Defines how many times we will iterate.
	const int len=src->imageSize>>6;

	// 255 - pixel is the new inverted value.
	// prepare the constant mask. Allocation is done with 8 ints to
	// make it aligned better.
	__declspec(align(32)) int mask[4]={0xffffffff,0xffffffff,0xffffffff,0xffffffff};

	__asm
	{
		// store 255s to XMM7
		movdqa xmm7,mask

		// mov xi to source register
		mov esi, xi

		// mov yi to destination register
		mov edi, yi

		// loop parameters
		mov ecx, len

Traverse:
		// unroll the loop 4 times. 4th unroll is a half one. (as much as XMM's can hold)

		// load 3 pixels
		movdqa xmm0,[esi]
		movdqa xmm1,[esi+16]
		movdqa xmm2,[esi+32]
		movdqa xmm3,[esi+48]

		// 255- pixel for 3 pixels
		pandn  xmm0, xmm7
		pandn  xmm1, xmm7
		pandn  xmm2, xmm7
		pandn  xmm3, xmm7

		// output the computed content
		movdqa [edi], xmm0
		movdqa [edi+16], xmm1
		movdqa [edi+32], xmm2
		movdqa [edi+48], xmm3

		// traverse array
		add esi,64
		add edi, 64

		// move on
		loop Traverse;
	}
}


int main()
{
	IplImage* x=cvLoadImage("C:\\Data\\Waterfall.jpg");
	IplImage* y=cvCreateImage(cvGetSize(x),8,x->nChannels);
	IplImage* z=cvCreateImage(cvGetSize(x),8,x->nChannels);
	IplImage* t=cvCreateImage(cvGetSize(x),8,x->nChannels);

	int w=1024;
	int h=768;

	CPerfTimer pt1, pt2,pt3;
	pt1.Start();
	basic_invert(x,y);
	pt1.Stop();

	pt2.Start();
	optimized_invert_sse2(x,t);
	pt2.Stop();

	pt3.Start();
	optimized_invert(x,z);
	pt3.Stop();

	printf("Basic Inversion Timing : %f ms\n",pt1.Elapsedms());
	printf("Optimized Inversion using SSE2 Timing : %f ms\n",pt2.Elapsedms());
	printf("Optimized Inversion Timing : %f ms\n",pt3.Elapsedms());

	cvNamedWindow("a");
	cvNamedWindow("b");
	cvNamedWindow("c");
	cvShowImage("a",y);
	cvShowImage("b",z);
	cvShowImage("c",t);
	cvWaitKey(0);

	return 0;
}

