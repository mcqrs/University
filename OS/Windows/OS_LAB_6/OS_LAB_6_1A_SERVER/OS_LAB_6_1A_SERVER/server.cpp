#define _WINSOCK_DEPRECATED_NO_WARNINGS
#include <winsock2.h>
#include <stdio.h>
#include <string>
#include <iostream>


int main(int argc, char* argv[])
{
	SOCKET serverSock, newserverSock;

	sockaddr_in serverAddr, clientAddr;
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
		printf("WSA service failed to initialize with error %d \n", WSAGetLastError());
		exit(1);
	};


	/* Initializing socket */
	serverSock = socket(AF_INET, SOCK_STREAM, 0);
	if (serverSock < 0)
	{
		printf("Socket initialization failed with error %d \n", WSAGetLastError());
		exit(1);
	};

	/* Determining host address */
	gethostname(hostName, 64);
	pHostEnt = gethostbyname(hostName);
	if (pHostEnt == NULL)
	{
		printf("Can't get host by name.");
		exit(1);
	};
	printf("Server running on %s \n", hostName);

	/* Binding socket */

	memcpy(&serverAddr.sin_addr, pHostEnt->h_addr, 4);
	serverAddr.sin_port = htons(40842);
	serverAddr.sin_family = AF_INET;

	if (bind(serverSock, (sockaddr*)&serverAddr, addrLen) != 0)
	{
		printf("Bind failed with error %d \n", WSAGetLastError());
		closesocket(serverSock);
		exit(1);
	};

	bool flag = true;
	while (flag) 
	{
		/* Switching socket into listening mode */

		std::cout << "Server is listening...\n";

		if (listen(serverSock, 3))
		{
			printf("Listen failed with error %d \n", WSAGetLastError());
			closesocket(serverSock);
			exit(1);
		};

		/* Accepting connection #1 request */
		newserverSock = accept(serverSock, (sockaddr*)&clientAddr, &addrLen);

		if (newserverSock < 0)
		{
			printf("Accept failed with error %d \n", WSAGetLastError());
			exit(1);

		};

		char answer[100];

		while (true) {
			if ((nbytes = recv(newserverSock, buff, sizeof(buff), 0)) != 0)
			{
				buff[nbytes + 1] = '\0';
				printf("Recive from client \"%s\"\n", buff);
				if (strcmp(buff, "disconnect"))
				{
					std::cin >> answer;
					sprintf_s(buff, strlen(answer) + 1, answer);
					send(newserverSock, buff, strlen(buff), 0);
				}
				else
				{
					std::cout << "Client disconnected!\n";
					closesocket(newserverSock);
					std::cout << "Do you want to stop server?\n";
					std::string choice = "";
					std::cin >> choice;
					if (choice == "yes") 
					{
						flag = false;
						break;
					}
					else
					{
						break;
					}
				}
			}
		}
	}

	WSACleanup();
}
