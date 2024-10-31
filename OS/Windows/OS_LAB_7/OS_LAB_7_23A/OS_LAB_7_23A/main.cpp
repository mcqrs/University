#define _CRT_SECURE_NO_WARNINGS
#include <windows.h>
#include <stdlib.h>
#include <stdio.h>

#define RESERVE 1
#define COMMIT 2
#define DECOMMIT 3
#define RESET 4
#define RELEASE 5
#define LOCK 6
#define UNLOCK 7

DWORD OpCode, Size, Access;
LPVOID Block;

bool CheckOpCode(DWORD OpCode);
bool CheckAccess(DWORD Access);
void SetAccess(DWORD Access);
DWORD WINAPI Monitor(PVOID Param);

int main()
{
	SYSTEM_INFO systemInfo;
	GetSystemInfo(&systemInfo);

	printf("Page size: %d \n", systemInfo.dwPageSize);
	printf("Processor type: %d\n", systemInfo.dwProcessorType);
	printf("Number of processors: %d\n", systemInfo.dwNumberOfProcessors);

	FILE* input = fopen("input.txt", "r");

	SECURITY_ATTRIBUTES sa;
	sa.bInheritHandle = FALSE;
	sa.lpSecurityDescriptor = NULL;
	sa.nLength = sizeof(sa);

	HANDLE f_end = CreateEvent(&sa, TRUE, FALSE, NULL);
	HANDLE monitor = CreateThread(&sa, 0, Monitor, NULL, NULL, NULL);

	char str[1024];
	while (!feof(input))
	{
		Block = 0;
		OpCode = 0;
		Size = 4096;
		Access = 0;
		fgets(str, 1024, input);
		sscanf(str, "%ld %ld %ld", &Block, &OpCode, &Access);
		if (!(CheckAccess(Access) && CheckOpCode(OpCode)))
		{
			printf("Error in read data!");
		}
		else
		{
			SetAccess(Access);
			Sleep(500);
			switch (OpCode)
			{
			case RESERVE:
				VirtualAlloc(Block, Size, MEM_RESERVE, Access);
				break;
			case COMMIT:
				VirtualAlloc(Block, Size, MEM_COMMIT, Access);
				break;
			case DECOMMIT:
				VirtualFree(Block, Size, MEM_DECOMMIT);
				break;
			case RESET:
				VirtualAlloc(Block, Size, MEM_RESET, Access);
				break;
			case RELEASE:
				VirtualFree(Block, 0, MEM_RELEASE);
				break;
			case LOCK:
				VirtualLock(Block, Size);
				break;
			case UNLOCK:
				VirtualUnlock(Block, Size);
				break;
			}
			SetEvent(f_end);
		}
	}
	fclose(input);
	Sleep(1000);
	return 0;
}

bool CheckOpCode(DWORD OpCode)
{
	if (OpCode < 1 || OpCode > 7)
	{
		printf("Error! Wrong operation code!");
		return false;
	}
	return true;
}

bool CheckAccess(DWORD Access)
{
	if (Access < 1 || Access > 5)
	{
		printf("Error! Wrong access code!");
		return false;
	}
	return true;
}

void SetAccess(DWORD Access)
{
	switch (Access)
	{
	case 1:	Access = PAGE_READONLY;
		break;
	case 2:	Access = PAGE_READWRITE;
		break;
	case 3:	Access = PAGE_EXECUTE;
		break;
	case 4:	Access = PAGE_EXECUTE_READ;
		break;
	case 5:	Access = PAGE_EXECUTE_READWRITE;
		break;
	}
	return;
}

DWORD WINAPI Monitor(PVOID Param)
{
	FILE* output = fopen("output.txt", "wt");
	MEMORYSTATUS ms;
	while (1)
	{
		printf("Monitoring system...\n");
		Sleep(500);
		GlobalMemoryStatus(&ms);
		fprintf(output, "Memory load: %ld\n", ms.dwMemoryLoad);
		fprintf(output, "Physical memory: %ld\n", ms.dwAvailPhys);
		fprintf(output, "Virtual memory: %ld\n", ms.dwAvailVirtual);
		fprintf(output, "Page File: %ld\n", ms.dwAvailPageFile);
		fprintf(output, "Time: %ld\n", GetTickCount());
		fprintf(output, "\n");
	}
	fclose(output);
	return 0;
}
