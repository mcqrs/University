#include <windows.h>
#include <fstream>
#include <string>
#include <iostream>

int main(int argc, char* argv[])
{
	HANDLE pipe = CreateFile(
		L"\\\\.\\pipe\\$MyPipeFirst$", GENERIC_READ | GENERIC_WRITE,
		0, NULL, OPEN_EXISTING, 0, NULL);
	if (pipe == NULL)
	{
		std::cerr << "Error";
		exit(-1);
	}
	char szBuf[256];
	DWORD  cbRead = 0;
	LPCWSTR lpFileShareName = L"$SpecialNameSecond$";
	HANDLE hFileMapping = CreateFileMapping((HANDLE)0xFFFFFFFF,
		NULL, PAGE_READWRITE, 0, 100, lpFileShareName);
	if (hFileMapping == nullptr) {
		std::cerr << "Error" << '\n';
		return -1;
	}
	LPVOID lpFileMap = MapViewOfFile(hFileMapping,
		FILE_MAP_ALL_ACCESS, 0, 0, 0);
	if (lpFileMap == nullptr) {
		std::cerr << "Error" << '\n';
		return -1;
	}
	DWORD cbWritten = 0;
	int start = 0;
	std::string outcome;
	Sleep(100);
	if (ReadFile(pipe, szBuf, 256, &cbRead, NULL))
	{
		outcome = szBuf;
		std::cout << outcome;
		std::cout.flush();
	}
	for (int i = 0; i < outcome.size(); ++i) {
		((PSTR)lpFileMap)[i] = outcome[i];
	}
	Sleep(10000);
}