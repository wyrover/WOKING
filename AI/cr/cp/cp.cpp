// cp.cpp : 定义 DLL 应用程序的导出函数。
//

#include "stdafx.h"
#include "cp.h"
#include "Pipeline.h"
using namespace pr;

CP_API char* LoadCarImage(const char* strCarFileName)
{
	pr::PipelinePR prc("./model/cascade.xml",
		"./model/HorizonalFinemapping.prototxt", "./model/HorizonalFinemapping.caffemodel",
		"./model/Segmentation.prototxt", "./model/Segmentation.caffemodel",
		"./model/CharacterRecognization.prototxt", "./model/CharacterRecognization.caffemodel"
	);

	cv::String CarList;
	cv::Mat image = cv::imread(strCarFileName);
	std::vector<pr::PlateInfo> res = prc.RunPiplineAsImage(image);
	for (auto st:res)
	{
		if (st.confidence > 0.1)
		{
			CarList = CarList + " " + st.getPlateName();
		}
	}

	return (char*)CarList.c_str();
}
