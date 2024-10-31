#define _WINSOCK_DEPRECATED_NO_WARNINGS
#define _CRT_SECURE_NO_WARNINGS
#include <winsock2.h>
#include <iostream>

SOCKET connections[100];
HANDLE connectionsHandle[100];
int clientsId = 0;

// Handler for client messages
void ClientHandler(int index) {
	char msg[256];
	char clientId[20];
	char messageToSend[512]{};

	// Write clientId
	sprintf(clientId, "%d", index);

	while (true) {

		// Read new message from client
		recv(connections[index], msg, sizeof(msg), NULL);

		// If client isn't disconnecting - build and send message,
        // else - build and send to others that client disconnected 
		if (strcmp(msg, "disconnect")) 
		{
			std::cout << "Client #" << index << ": sended message \"" << msg << "\"\n";
			for (int i = 0; i < clientsId; i++) {

				// Not to send a message to yourself 
				if (i == index) {
					continue;
				}

				// Build message to send on chat
				strcat(messageToSend, "Client #");
				strcat(messageToSend, clientId);
				strcat(messageToSend, ": ");
				strcat(messageToSend, msg);

				// Send message to other clients in for cycle
				send(connections[i], messageToSend, sizeof(messageToSend), NULL);

				messageToSend[0] = '\0';
			}
		}
		else 
		{
			std::cout << "Client #" << index << ": disconnected!\n";
			msg[0] = '\0';
			strcpy(msg, "disconnected!");
			for (int i = 0; i < clientsId; i++) {

				// Not to send a message to yourself 
				if (i == index) {
					continue;
				}

				// Build message to send on chat
				strcat(messageToSend, "Client #");
				strcat(messageToSend, clientId);
				strcat(messageToSend, ": ");
				strcat(messageToSend, msg);

				// Send message to other clients in for cycle
				send(connections[i], messageToSend, sizeof(messageToSend), NULL);

				messageToSend[0] = '\0';
			}

			break;
		}
	}
}

int main(int argc, char* argv[]) {
	
	// WSAStartup
	WSAData wsaData;
	WORD DLLVersion = MAKEWORD(2, 1);
	if (WSAStartup(DLLVersion, &wsaData) != 0) {
		std::cout << "Error" << std::endl;
		exit(1);
	}

	// SOCKADDR_IN
	SOCKADDR_IN addr;
	int sizeofaddr = sizeof(addr);
	addr.sin_addr.s_addr = inet_addr("127.0.0.1");
	addr.sin_port = htons(1111);
	addr.sin_family = AF_INET;

	// Socket for listening 
	SOCKET listenSocket = socket(AF_INET, SOCK_STREAM, NULL);
	bind(listenSocket, (SOCKADDR*)&addr, sizeof(addr));
	// Listening...
	std::cout << "Server is listening...\n";
	listen(listenSocket, SOMAXCONN);

	// Socket for new connection client
	SOCKET newSocket;
	for (int i = 0; i < 100; i++) {
		// Accept connection
		newSocket = accept(listenSocket, (SOCKADDR*)&addr, &sizeofaddr);

		if (newSocket == 0) {
			std::cout << "Error #2\n";
		}
		else {
			// Client connected
			std::cout << "Client #" << i << " Connected!\n";
			char msg[256] = "Hello! Welcome to chat Client #";
			char clientId[20];
			sprintf(clientId, "%d", clientsId);
			char other[2] = "!";

			// Build message for client: msg + id + other
			strcat(msg, clientId);
			strcat(msg, other);
			send(newSocket, msg, sizeof(msg), NULL);

			// Add new connection to sockets
			connections[i] = newSocket;
			clientsId++;

			// New Thread with client handler to send messages
			connectionsHandle[i] = CreateThread(NULL, NULL, (LPTHREAD_START_ROUTINE)ClientHandler, (LPVOID)(i), NULL, NULL);

			// Close Handle when client disconnected
			CloseHandle(connectionsHandle[i]);
		}
	}

	// WSA Cleanup
	WSACleanup();

	return 0;
}
