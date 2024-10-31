#define nWriters 3      /*количество процессов-писателей*/
#define nReaders 3      /*количество процессов-читателей*/

//LTL formuls

/*Инвариант. Если читатель читает, то никто не пишет. Не более одного писателя в критической секции. Если писатель пишет, то никто не читает.   */
#define mutex1 {[]((crR >= 1 -> crW == 0) && (crW <= 1) && (crW == 1 -> crR == 0))} 

/*Проверка на взаимоисключающий доступ*/
#define mutex2 {[]((RW.readers >= 1 -> RW.writers == 0) && (RW.writers <= 1) && (RW.writers == 1 -> RW.readers == 0))}

/*Проверка свободы от голодания для читателей*/
#define starvR {[](wantR[0] -> <>critR[0]) && [](wantR[1] -> <>critR[1]) && [](wantR[2] -> <>critR[2])}

/*Проверка свободы от голодания для писателей*/
#define starvW {[](wantW[0] -> <>critW[0]) && [](wantW[1] -> <>critW[1]) && [](wantW[2] -> <>critW[2])}


#define emptyC(C) (C.waiting == 0)

typedef Condition {
    bool gate;
    int waiting;
}

typedef Monitor {
    int readers;    /*количество читателей в критической секции */
    int writers;    /*количество писателей в критической секции */
    Condition OKtoRead;     /*условная переменная для блокировки читателей до тех пор пока не будет "можно читать" */
    Condition OKtoWrite;    /*условная переменная для блокировки писателей до тех пор пока не будет "можно писать" */
}


inline initMon(M, r, w) {
    M.readers = r;
    M.writers = w;
}

/*Вызов функции enterMon() позволяет процессу убедиться, что он может походить, 
сразу же снять это право у других процессов, благодаря флагу блокировки lock. 
Благодаря этой функции мы уверены, что никакой другой процесс не будет сейчас 
делать ход.  */
inline enterMon(){
atomic{
    !lock;
    lock = true;
}
}

/*После того, как функция завершилась, флаг lock снимается, что позволяет 
другим процессам запускать свои функции. */
inline leaveMon(){
    lock = false;
}


/*В функции waitC(С) мы блокируем процесс, добавляя его в очередь(канал) командой C.waiting++, 
совобождаем монитор и затем ждем разблокировки процесса. */
inline waitC(C){
atomic {
    C.waiting++;
    lock = false;
    C.gate;
    C.gate = false;
    C.waiting--;
}
}

/*В функции signalC(С) мы проверяем пуст ли канал. Если канал не пустой, 
то разблокируем процесс и затем ждем возможность зайти в монитор*/
inline signalC(C) {
atomic {
    if
    ::(C.waiting > 0) ->
        C.gate = true;
        !lock;
        lock = true;
    ::else;
    fi;
}
}


Monitor RW;
bool lock = false;
bool wantR[nReaders], wantW[nWriters], critR[nReaders], critW[nWriters];
int crR = 0, crW = 0;


inline StartRead() {
    enterMon();
    atomic{
        if
        :: (RW.writers != 0 || !emptyC(RW.OKtoWrite)) -> waitC(RW.OKtoRead);
        ::else;
        fi;
    }
    RW.readers++;
    signalC(RW.OKtoRead);
    leaveMon();
}

inline StartWrite() {
    enterMon();
    atomic{
    if
    :: (RW.writers != 0 || RW.readers != 0) -> waitC(RW.OKtoWrite);
    :: else;
    fi;
    }
    RW.writers++;
    leaveMon();
}

inline EndRead() {
    enterMon();
    RW.readers--;
    atomic{
    if
    :: (RW.readers == 0) -> signalC(RW.OKtoWrite);
    :: else;
    fi;
    }
    leaveMon();
}

inline EndWrite() {
    enterMon();
    RW.writers--;
    atomic{
        if
        :: (emptyC(RW.OKtoRead)) -> signalC(RW.OKtoWrite);
        :: else ->  signalC(RW.OKtoRead);
        fi;
    }
    leaveMon();
}

proctype reader (int i){
do
    ::
    wantR[i] = true;
    StartRead();
    critR[i] = true;
    crR++;
    crR--;
    critR[i] = false;
    EndRead();
    wantR[i] = false;
od;
}

proctype writer (int i){
do
    ::
    wantW[i] = true;
    StartWrite();
    critW[i] = true;
    crW++;
    crW--;
    critW[i] = false;
    EndWrite();
    wantW[i] = false;
od;
}


init {
atomic {
    lock = false;
    initMon(RW, 0, 0);
    int i;
do
:: i<3 ->
run writer(i);
run reader(i);
i = i+1;
:: else -> break;
od 
}
}
/**/

