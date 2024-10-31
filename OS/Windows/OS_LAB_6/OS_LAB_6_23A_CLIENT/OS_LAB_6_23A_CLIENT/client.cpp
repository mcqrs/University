#define _WINSOCK_DEPRECATED_NO_WARNINGS
#include <winsock2.h>
#include <iostream>

SOCKET connection;
HANDLE clientHandle;

// Handler for client messages
void ClientHandler() {
	char msg[256];
	while (true) {

		// Read new message from server
		recv(connection, msg, sizeof(msg), NULL);
		if (strcmp(msg, "")) 
		{
			std::cout << msg << "\n";
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

	// Connecting socket
	connection = socket(AF_INET, SOCK_STREAM, NULL);
	if (connect(connection, (SOCKADDR*)&addr, sizeof(addr)) != 0) {
		std::cout << "Error: failed connect to server.\n";
		return 1;
	}
	std::cout << "Connected!\n";

	// New Thread with client handler to read messages
	clientHandle = CreateThread(NULL, NULL, (LPTHREAD_START_ROUTINE)ClientHandler, NULL, NULL, NULL);

	char message[256];
	while (true) {
		// Read message from concole
		std::cin.getline(message, sizeof(message));

		// Send message to server
		send(connection, message, sizeof(message), NULL);
		// If client want to disconnect - close handle and exit thread
		if (!strcmp(message, "disconnect"))
		{
			CloseHandle(clientHandle);
			break;
		}
		Sleep(10);
	}

	return 0;
}
