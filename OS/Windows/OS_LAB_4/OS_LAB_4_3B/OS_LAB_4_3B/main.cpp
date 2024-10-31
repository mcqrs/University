#include <string.h>
#include <windows.h>
#include <stdio.h>

WCHAR lpCommandLine[200];

char Name[50];
char path[200];
char str[200];

HANDLE hEvent;

SECURITY_ATTRIBUTES SecurityAttributes;

PROCESS_INFORMATION ProcessInf;

STARTUPINFO StartInfo;

int main(int argc, char* argv[])
{
	strcpy_s(Name, "Source");

	SecurityAttributes.bInheritHandle = TRUE;
	SecurityAttributes.lpSecurityDescriptor = NULL;
	SecurityAttributes.nLength = sizeof(SecurityAttributes);

	//printf("Enter path to child process:\n");
	//gets(path);
	strcpy_s(path, "C:\\Users\\muhin\\source\\repos\\OS_LAB_4_1B_CHILD\\Debug");
	strcat_s(path, "\\");

	strcat_s(path, "OS_LAB_4_1B_CHILD.exe");
	strcat_s(path, " ");

	hEvent = CreateEvent(&SecurityAttributes, FALSE, TRUE, NULL);

	_itoa_s((int)hEvent, str, 10);
	strcat_s(path, str);

	memset(&StartInfo, 0, sizeof(StartInfo));
	StartInfo.cb = sizeof(StartInfo);
	//StartInfo.lpTitle="Child";

	for (int i = 0; i < 200; i++)
	{
		lpCommandLine[i] = path[i];
	}

	if (!CreateProcess(NULL, lpCommandLine, NULL, NULL, TRUE, CREATE_NEW_CONSOLE, NULL, NULL,
		&StartInfo, &ProcessInf))
	{
		printf("Could not create child process!\n");
		CloseHandle(hEvent);
		return 0;
	}

	while (TRUE)
	{
		strcpy_s(str, "a");

		WaitForSingleObject(hEvent, INFINITE);

		printf("Hello! My name is %s\n", Name);

		while (strcmp(str, "next"))
		{
			if (!strcmp(str, "exit"))
			{
				SetEvent(hEvent);

				CloseHandle(hEvent);

				return 0;
			}

			gets_s(str);
			printf("User input %s\n", str);
		}

		printf("good buy!\n");
		SetEvent(hEvent);

	}

	return 0;

}
