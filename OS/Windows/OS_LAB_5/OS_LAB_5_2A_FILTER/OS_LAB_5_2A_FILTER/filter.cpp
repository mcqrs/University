#include <stdio.h>
#include <windows.h>
#include <cctype>

#define BUFSIZE 50


int main(int argc, char* argv[])
{

	char chBuf[BUFSIZE];

	DWORD dwRead, dwWritten;

	HANDLE hStdin, hStdout;

	printf("Hello! I am filter!\n");

	Sleep(1000);

	hStdin = GetStdHandle(STD_INPUT_HANDLE);
	hStdout = GetStdHandle(STD_OUTPUT_HANDLE);

	if ((hStdin == INVALID_HANDLE_VALUE))
		ExitProcess(1);

	if ((hStdout == INVALID_HANDLE_VALUE))
		ExitProcess(1);

	for (;;)
	{
		for (int i = 0; i < 50; i++) chBuf[i] = '\0';

		if (!ReadFile(hStdin, chBuf, BUFSIZE, &dwRead, NULL))
		{
			printf("Can'not read\n");
			break;
		}

		for (int i = 0; i < 50; i++) 
		{
			if (isupper(chBuf[i]))
			{
				chBuf[i] = tolower(chBuf[i]);
			}
			else
			{
				chBuf[i] = toupper(chBuf[i]);
			}
		}

		printf("\nIn buffer %s\n", chBuf);

		Sleep(1000);

		if (!WriteFile(hStdout, chBuf, dwRead, &dwWritten, NULL))
		{
			printf("Can'not Write %d\n", GetLastError());
			break;
		}
	}
}
