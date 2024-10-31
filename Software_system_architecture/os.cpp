#include <stdio.h>
#include "sys.h"
#include "rtos_api.h"
#include "pch.h"

int StartOS(TTaskCall entry, int priority, char* name) {
	// Начальные настройки системы
	printf("StartOS!\n");
	RunningTask = _NULL;
	HeadTask = _NULL;
	FreeTask = 0;
	// Инициализация списка задач
	for (int i = 0; i < MAX_TASK; i++) {
		TaskQueue[i].ref = i + 1;
		TaskQueue[i].state = TASK_SUSPENDED;
	}
	TaskQueue[MAX_TASK - 1].ref = _NULL;
	ActivateTask(entry, priority, name);
	return 0;
}

void ShutdownOS() {
	printf("ShutdownOS!\n");
}