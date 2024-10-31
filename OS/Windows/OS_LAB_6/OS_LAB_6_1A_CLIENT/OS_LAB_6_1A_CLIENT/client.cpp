#define _WINSOCK_DEPRECATED_NO_WARNINGS
#include <winsock2.h>
#include <stdio.h>
#include <stdlib.h>
#include <iostream>

int main(int argc, char* argv[])
{
	SOCKET clientSock;

	sockaddr_in serverAddr;
	struct hostent* pHostEnt;
	char hostName[64];
	int addrLen = sizeof(serverAddr);
	int nbytes;
	char buff[256];

	WORD versionRequested;
	WSADATA wsaData;


	WORD version = MAKEWORD(2, 2);

	if (WSAStartup(version, &wsaData))
	{
		printf("WSA service failed to initialize");
		printf("with error %d \n", WSAGetLastError());
		//exit(1);
	};


	/* Initializing socket */
	//clientSock=socket(AF_INET,SOCK_STREAM,0);

	clientSock = socket(AF_INET, SOCK_STREAM, 0);

	if (clientSock < 0)
	{
		printf("Socket initialization failed \n");
		//	exit(1);
	};

	/* Determining host address */
	if (argc == 2)
		strcpy_s(hostName, strlen(argv[1]) + 1, argv[1]);
	else
		gethostname(hostName, 64);
	printf("%s\n", hostName);

	pHostEnt = gethostbyname(hostName);
	if (pHostEnt == NULL)
	{
		printf("Can't get host by name.");
		//		exit(1);
	};
	printf("Client running on %s \n", hostName);

	/* Connecting socket */

	memcpy(&serverAddr.sin_addr, pHostEnt->h_addr, 4);
	serverAddr.sin_port = htons(40842);
	serverAddr.sin_family = AF_INET;
	if (connect(clientSock, (sockaddr*)&serverAddr, addrLen) != 0)
	{
		printf("Connect error. %d\n", WSAGetLastError());
		closesocket(clientSock);
		//		exit(1);
	};

	sprintf_s(buff, strlen("Hi from client") + 1, "Hi from client");

	send(clientSock, buff, strlen(buff) + 1, 0);

	char answer[100];

	while (true) {
		if ((nbytes = recv(clientSock, buff, sizeof(buff), 0)) < 0)
		{
			printf("Client error recieve %d!\n", nbytes);
			//		exit(1);
		}

		buff[nbytes] = 0;
		printf("Recieve from server \"%s\"\n", buff);
		std::cin >> answer;
		if (strcmp(answer, "disconnect")) {
			sprintf_s(buff, strlen(answer) + 1, answer);
			send(clientSock, buff, strlen(buff) + 1, 0);
		}
		else {
			sprintf_s(buff, strlen(answer) + 1, answer);
			send(clientSock, buff, strlen(buff) + 1, 0);
			closesocket(clientSock);
			break;
		}
	}

	WSACleanup();

}
