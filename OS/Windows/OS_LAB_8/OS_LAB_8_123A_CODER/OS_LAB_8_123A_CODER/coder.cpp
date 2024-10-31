#include <iostream>
#include <fstream>
#include <malloc.h>
#include <string>
#include <windows.h>

int main()
{
	LPCWSTR lpszPipeName = L"\\\\.\\pipe\\$MyPipeFirst$";
	char buffer[256];
	HANDLE hNamedPipe = CreateNamedPipe(
		lpszPipeName,
		PIPE_ACCESS_DUPLEX,
		PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT,
		PIPE_UNLIMITED_INSTANCES,
		512, 512, 5000, NULL);
	if (hNamedPipe == INVALID_HANDLE_VALUE)
	{
		std::cerr << "Error" << '\n';
		return -1;
	}
	LPCWSTR lpFileShareName = L"$SpecialNameFirst$";
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
	std::string reverse;
	for (int i = data.size(); i > 0; --i)
	{
		reverse.push_back(data[i - 1]);
	}
	std::cout << reverse;
	DWORD cbWritten = 0;
	if (ConnectNamedPipe(hNamedPipe, NULL) == false)
	{
		CloseHandle(hNamedPipe);
		return -1;
	}
	if (!WriteFile(hNamedPipe, data.c_str(), strlen(data.c_str()) + 1,
		&cbWritten, NULL))
	{
		return -1;
		CloseHandle(hNamedPipe);
	}
	Sleep(10000);
}
