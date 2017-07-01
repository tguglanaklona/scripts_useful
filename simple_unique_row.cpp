#include "stdafx.h"
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <iostream>
#include <algorithm>

bool is_digits(const std::string &str)
{
    return str.find_first_not_of("0123456789") == std::string::npos;
}

int _tmain(int argc, _TCHAR* argv[])
{
	std::ifstream infile("../row_file.txt");
	std::string line;
	std::vector<std::string> uvector;
	std::vector<std::string> cpyvector;
	while (std::getline(infile, line))
	{
		if (is_digits(line)){
			uvector.push_back(line);
			cpyvector.push_back(line);
		}
	}

	std::sort(uvector.begin(), uvector.end());
	uvector.erase(std::unique(uvector.begin(), uvector.end()), uvector.end());

	std::vector<std::string>::iterator it;
	std::ofstream outfile("../_OneMonthNum_unique.txt");
	for (it=uvector.begin(); it!=uvector.end(); ++it){
		outfile << *it << ' ' << std::count(cpyvector.begin(), cpyvector.end(), *it) << '\n';
	}

	std::cout<<uvector.size();
	//std::cin>>line;
	return 0;
}
