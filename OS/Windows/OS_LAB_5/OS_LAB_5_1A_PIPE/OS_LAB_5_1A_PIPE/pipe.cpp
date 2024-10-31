#define _WIN32_WINNT 0x0400
#include <stdio.h>
#include <string.h>
#include <windows.h>

HANDLE readPipe, writePipe;

SECURITY_ATTRIBUTES pipeSA;

STARTUPINFO scrStartInfo, sinkStartInfo;

PROCESS_INFORMATION scrProcessInfo, sinkProcessInfo;

//HANDLE hSaveStdout;

//char saveStdout[20];
char path[200];

WCHAR lpCommandLine[200];

int main(int argc, char *argv[])
{
	pipeSA.nLength=sizeof(SECURITY_ATTRIBUTES);
	pipeSA.lpSecurityDescriptor=NULL;
	pipeSA.bInheritHandle=TRUE;

	if(!CreatePipe(&readPipe,&writePipe,&pipeSA,0))
	{
		printf("Cann't create PIPE\n");
		ExitProcess(1);
	}

	printf("readPipe %d writePipe %d\n",readPipe,writePipe);
	
	// Create process to write the pipe
	// Make handles inheritable

	printf("Main: creating source process\n");

	memset(&scrStartInfo,0,sizeof(STARTUPINFO));
	scrStartInfo.cb=sizeof(STARTUPINFO);
	scrStartInfo.hStdInput=GetStdHandle(STD_INPUT_HANDLE);
	scrStartInfo.hStdOutput=writePipe;
	scrStartInfo.hStdError=GetStdHandle(STD_ERROR_HANDLE);
	scrStartInfo.dwFlags=STARTF_USESTDHANDLES;

	strcpy_s(path,strlen("C:\\Users\\muhin\\source\\repos\\OS_LAB_5_1A_W_PIPE\\Debug\\OS_LAB_5_1A_W_PIPE.exe")+1,
		"C:\\Users\\muhin\\source\\repos\\OS_LAB_5_1A_W_PIPE\\Debug\\OS_LAB_5_1A_W_PIPE.exe");

	for (int i = 0; i < 200; i++) 
	{
		lpCommandLine[i] = path[i];
	}

	if(!CreateProcess(NULL, lpCommandLine, NULL, NULL, TRUE, CREATE_NEW_CONSOLE,
			NULL, NULL, &scrStartInfo, &scrProcessInfo))
	{
		printf("Can't create source process\n");
		ExitProcess(1);
	}

	Sleep(1000);

	// Create process to read the pipe
	// Make handles inheritable

	printf("Main: creating sink process\n");

	memset(&sinkStartInfo,0,sizeof(STARTUPINFO));
	sinkStartInfo.cb=sizeof(STARTUPINFO);
	sinkStartInfo.hStdInput=readPipe;
	sinkStartInfo.hStdOutput=GetStdHandle(STD_OUTPUT_HANDLE);
	sinkStartInfo.hStdError=GetStdHandle(STD_ERROR_HANDLE);
	sinkStartInfo.dwFlags=STARTF_USESTDHANDLES;

	strcpy_s(path, strlen("C:\\Users\\muhin\\source\\repos\\OS_LAB_5_1A_R_PIPE\\Debug\\OS_LAB_5_1A_R_PIPE.exe") + 1,
		"C:\\Users\\muhin\\source\\repos\\OS_LAB_5_1A_R_PIPE\\Debug\\OS_LAB_5_1A_R_PIPE.exe");

	for (int i = 0; i < 200; i++)
	{
		lpCommandLine[i] = path[i];
	}

	if(!CreateProcess(NULL, lpCommandLine, NULL, NULL, TRUE, CREATE_NEW_CONSOLE,
			NULL, NULL, &sinkStartInfo, &sinkProcessInfo))
	{
		printf("Can't create sink process\n");
		ExitProcess(1);
	}

	CloseHandle(readPipe);
	CloseHandle(writePipe);

}
