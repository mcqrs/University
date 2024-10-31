#define _WIN32_WINNT 0x0400
#include <stdio.h>
#include <string.h>
#include <windows.h>
#include <stdlib.h>
#include <time.h>

HANDLE readPipeOne, writePipeOne, readPipeTwo, writePipeTwo;

SECURITY_ATTRIBUTES pipeSAOne, pipeSATwo;

STARTUPINFO scrStartInfo, filterStartInfo, sinkStartInfo;

PROCESS_INFORMATION scrProcessInfo, filterProcessInfo, sinkProcessInfo;

char path[200];

WCHAR lpCommandLine[200];

int main(int argc, char* argv[])
{
	srand(time(NULL));
	pipeSAOne.nLength = sizeof(SECURITY_ATTRIBUTES);
	pipeSAOne.lpSecurityDescriptor = NULL;
	pipeSAOne.bInheritHandle = TRUE;

	pipeSATwo.nLength = sizeof(SECURITY_ATTRIBUTES);
	pipeSATwo.lpSecurityDescriptor = NULL;
	pipeSATwo.bInheritHandle = TRUE;

	if (!CreatePipe(&readPipeOne, &writePipeOne, &pipeSAOne, 0))
	{
		printf("Can't create PIPE ONE!\n");
		ExitProcess(1);
	}

	if (!CreatePipe(&readPipeTwo, &writePipeTwo, &pipeSATwo, 0))
	{
		printf("Can't create PIPE TWO!\n");
	}

	printf("PIPE ONE: readPipe %d writePipe %d\n", readPipeOne, writePipeOne);
	printf("PIPE TWO: readPipe %d writePipe %d\n", readPipeTwo, writePipeTwo);

	// Create process to write the pipe
	// Make handles inheritable

	printf("Main: creating source process\n");

	memset(&scrStartInfo, 0, sizeof(STARTUPINFO));
	scrStartInfo.cb = sizeof(STARTUPINFO);
	scrStartInfo.hStdInput = GetStdHandle(STD_INPUT_HANDLE);
	scrStartInfo.hStdOutput = writePipeOne;
	scrStartInfo.hStdError = GetStdHandle(STD_ERROR_HANDLE);
	scrStartInfo.dwFlags = STARTF_USESTDHANDLES;

	strcpy_s(path, strlen("C:\\Users\\muhin\\source\\repos\\OS_LAB_5_2A_WRITER\\Debug\\OS_LAB_5_2A_WRITER.exe") + 1,
		"C:\\Users\\muhin\\source\\repos\\OS_LAB_5_2A_WRITER\\Debug\\OS_LAB_5_2A_WRITER.exe");

	for (int i = 0; i < 200; i++)
	{
		lpCommandLine[i] = path[i];
	}

	if (!CreateProcess(NULL, lpCommandLine, NULL, NULL, TRUE, CREATE_NEW_CONSOLE,
		NULL, NULL, &scrStartInfo, &scrProcessInfo))
	{
		printf("Can't create source process\n");
		ExitProcess(1);
	}

	int delay = (rand() % 4 + 1) * 1000;
	printf("\nWRITER to FILTER delay: %d\n", delay);
	Sleep(delay);

	// Create process to filter the pipe
	// Make handles inheritable

	printf("Main: creating filter process\n");

	memset(&filterStartInfo, 0, sizeof(STARTUPINFO));
	filterStartInfo.cb = sizeof(STARTUPINFO);
	filterStartInfo.hStdInput = readPipeOne;
	filterStartInfo.hStdOutput = writePipeTwo;
	filterStartInfo.hStdError = GetStdHandle(STD_ERROR_HANDLE);
	filterStartInfo.dwFlags = STARTF_USESTDHANDLES;

	strcpy_s(path, strlen("C:\\Users\\muhin\\source\\repos\\OS_LAB_5_2A_FILTER\\Debug\\OS_LAB_5_2A_FILTER.exe") + 1,
		"C:\\Users\\muhin\\source\\repos\\OS_LAB_5_2A_FILTER\\Debug\\OS_LAB_5_2A_FILTER.exe");

	for (int i = 0; i < 200; i++)
	{
		lpCommandLine[i] = path[i];
	}

	if (!CreateProcess(NULL, lpCommandLine, NULL, NULL, TRUE, CREATE_NEW_CONSOLE,
		NULL, NULL, &filterStartInfo, &filterProcessInfo))
	{
		printf("Can't create filter process\n");
		ExitProcess(1);
	}

	delay = (rand() % 4 + 1) * 1000;
	printf("\nFILTER to READER delay: %d\n", delay);
	Sleep(delay);

	// Create process to read the pipe
	// Make handles inheritable

	printf("Main: creating sink process\n");

	memset(&sinkStartInfo, 0, sizeof(STARTUPINFO));
	sinkStartInfo.cb = sizeof(STARTUPINFO);
	sinkStartInfo.hStdInput = readPipeTwo;
	sinkStartInfo.hStdOutput = GetStdHandle(STD_OUTPUT_HANDLE);
	sinkStartInfo.hStdError = GetStdHandle(STD_ERROR_HANDLE);
	sinkStartInfo.dwFlags = STARTF_USESTDHANDLES;

	strcpy_s(path, strlen("C:\\Users\\muhin\\source\\repos\\OS_LAB_5_2A_READER\\Debug\\OS_LAB_5_2A_READER.exe") + 1,
		"C:\\Users\\muhin\\source\\repos\\OS_LAB_5_2A_READER\\Debug\\OS_LAB_5_2A_READER.exe");

	for (int i = 0; i < 200; i++)
	{
		lpCommandLine[i] = path[i];
	}

	if (!CreateProcess(NULL, lpCommandLine, NULL, NULL, TRUE, CREATE_NEW_CONSOLE,
		NULL, NULL, &sinkStartInfo, &sinkProcessInfo))
	{
		printf("Can't create sink process\n");
		ExitProcess(1);
	}

	CloseHandle(readPipeOne);
	CloseHandle(writePipeOne);
	CloseHandle(readPipeTwo);
	CloseHandle(writePipeTwo);
}
