#include <windows.h>
#include <fstream>
#include <string>
#include <iostream>

int main(int argc, char* argv[])
{
	LPCWSTR lpFileShareName = L"$SpecialNameSecond$";
	HANDLE hFileMapping = OpenFileMapping(
		FILE_MAP_READ | FILE_MAP_WRITE, FALSE, lpFileShareName);
	LPVOID lpFileMap = MapViewOfFile(hFileMapping,
		FILE_MAP_ALL_ACCESS, 0, 0, 0);
	Sleep(2000);
	int i = 0;
	while (((PSTR)lpFileMap)[i] != '\0') {
		++i;
	}
	auto size = i;
	i = 0;
	std::string data;
	while (i <= size) {
		data.push_back(((PSTR)lpFileMap)[i]);
		++i;
	}
	std::cout << data << std::endl;
	std::ofstream out("output.txt");
	out << data;
}
