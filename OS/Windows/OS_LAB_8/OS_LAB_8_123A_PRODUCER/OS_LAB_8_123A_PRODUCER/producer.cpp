#include <iostream>
#include <fstream>
#include <malloc.h>
#include <string>
#include <windows.h>

int main()
{
	std::ifstream fin("input.txt");

	LPCWSTR lpFileShareName = L"$SpecialNameFirst$";
	HANDLE hFileMapping = CreateFileMapping((HANDLE)0xFFFFFFFF, NULL, PAGE_READWRITE, 0, 100, lpFileShareName);
	if (hFileMapping == nullptr) 
	{
		std::cerr << "Error" << '\n';
		return -1;
	}

	LPVOID lpFileMap = MapViewOfFile(hFileMapping, FILE_MAP_ALL_ACCESS, 0, 0, 0);
	if (lpFileMap == nullptr) 
	{
		std::cerr << "Error" << '\n';
		return -1;
	}

	DWORD cbWritten = 0;
	std::string input;
	int start = 0;
	while (!fin.eof()) 
	{
		fin >> input;
		std::cout << input;
		input.push_back('\n');
		for (int i = 0; i < input.size(); ++i) {
			((PSTR)lpFileMap)[start + i] = input[i];
		}
		start += input.size();
	}
	Sleep(10000);
}
