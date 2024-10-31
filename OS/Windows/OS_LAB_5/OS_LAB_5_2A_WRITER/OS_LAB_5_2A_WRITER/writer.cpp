#include <stdio.h>
#include <windows.h>

#define BUFSIZE 50

char chBuf[BUFSIZE];

int main(int argc, char* argv[])
{
	DWORD dwRead, dwWritten;

	HANDLE hStdout, hInputFile;

	printf("Hello I am writer!\n");

	hStdout = GetStdHandle(STD_OUTPUT_HANDLE); //PIPE!!!

	if ((hStdout == INVALID_HANDLE_VALUE))
		ExitProcess(1);

	hInputFile = CreateFile(L"C:\\Users\\muhin\\source\\repos\\OS_LAB_5_2A_WRITER\\OS_LAB_5_2A_WRITER\\input.txt",
		GENERIC_READ, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_READONLY, NULL);

	while (TRUE)
	{
		if (!ReadFile(hInputFile, chBuf, BUFSIZE, &dwRead, NULL))
		{
			printf("Can'not read from file\n");
			ExitProcess(0);
		}

		printf("In buffer %s\n", chBuf);

		Sleep(5000);

		if (!WriteFile(hStdout, chBuf, dwRead, &dwWritten, NULL))
		{
			printf("Can'not write to pipe\n");
			ExitProcess(0);
		}

	}
}
