#define nWriters 2      /*количество процессов-писателей*/
#define nReaders 2      /*количество процессов-читателей*/

//LTL formuls

/*Инвариант. Если читатель читает, то никто не пишет. Не более одного писателя в критической секции. Если писатель пишет, то никто не читает.   */
#define mutex1 { []((crR >= 1 -> crW == 0) && (crW <= 1) && (crW == 1 -> crR == 0)) } 

/*Проверка на взаимоисключающий доступ*/
#define mutex2 {[]((RW.readers >= 1 -> RW.writers == 0) && (RW.writers <= 1) && (RW.writers == 1 -> RW.readers == 0))}

/*Проверка свободы от голодания для читателей*/
#define starvR {[](wantR[0] -> <>critR[0]) && [](wantR[1] -> <>critR[1]) && [](wantR[2] -> <>critR[2])}

/*Проверка свободы от голодания для писателей*/
#define starvW {[](wantW[0] -> <>critW[0]) && [](wantW[1] -> <>critW[1]) && [](wantW[2] -> <>critW[2])}


#define emptyC(C) (C.waiting == 0)

int num;
inline decrementArray(ArrayName, max){
    atomic{
    num = 0;
    do
        :: num < max -> 
            /*printf("MSC: num=%d\n", num);*/ 
            if
            :: ArrayName[num] > 0 -> ArrayName[num]--;
            :: else;
            fi;
            num++;
        :: else -> 
            printf("MSC: [array]--\n");
            break;
    od
    }
}

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
    printf("MSC: enterMon()\n");
}
}

/*После того, как функция завершилась, флаг lock снимается, что позволяет 
другим процессам запускать свои функции. */
inline leaveMon(){
atomic{
    lock = false;
    printf("MSC: leaveMon()\n");
}
}


/*В функции waitC(С) мы блокируем процесс, добавляя его в очередь(канал) командой C.waiting++, 
совобождаем монитор и затем ждем разблокировки процесса. */
inline wait_OKtoRead(i){
atomic {
    RW.OKtoRead.waiting++;
    lock = false;
    !waitR[i]; /**waitR[i]==0 */
    printf("MSC: my turn! wait for gate\n");
    RW.OKtoRead.gate;
    RW.OKtoRead.gate = false;
    RW.OKtoRead.waiting--;
    printf("MSC: received gate\n");
}
}
inline wait_OktoWrite(i){
atomic {
    RW.OKtoWrite.waiting++;
    lock = false;
    !waitW[i]; /**waitW[i]==0; */
    printf("MSC: my turn! wait for gate\n");
    RW.OKtoWrite.gate;
    RW.OKtoWrite.gate = false;
    RW.OKtoWrite.waiting--;
    printf("MSC: received gate\n");
}
}

/*В функции signalC(С) мы проверяем пуст ли канал. Если канал не пустой, 
то разблокируем процесс и затем ждем возможность зайти в монитор. */
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
int waitR[nReaders]; //количество ожидающих писателей перед i-тым читателем
int waitW[nWriters]; //общее количество процессов перед i-тым писателем
int crR = 0, crW = 0;


inline StartRead() {
    enterMon();
    printf("MSC: startRead\n");
    waitR[i] = RW.OKtoWrite.waiting;
    atomic{
        if
        :: (RW.writers != 0 || !emptyC(RW.OKtoWrite)) -> printf("MSC: wait(OKtoRead)\n"); wait_OKtoRead(i);
        ::else;
        fi;
    }
    printf("MSC: go read\n");
    RW.readers++;
    
    /**Сигнал получают только читатели у которых подошла очередь, т.е. waitR[i]==0 кроме нас*/
    int cZeros;
    cZeros = 0;
    int p;
    p = 0;
    atomic{
    do
        :: p < nReaders ->
            /*printf("MSC: p=%d\n", p); */
            if
            :: waitR[p] == 0 -> cZeros++;
            :: else;
            fi;
            p++;
        :: else -> break;
    od;
    printf("MSC: %d-(%d-%d) > 0?\n", cZeros, nReaders, RW.OKtoRead.waiting);
    }
    if
    :: (cZeros - (nReaders - RW.OKtoRead.waiting) > 0) -> 
        printf("MSC: signal(OKtoRead)\n");
        signalC(RW.OKtoRead);
    :: else;
    fi;

    decrementArray(waitW, nWriters);
    leaveMon();
}

inline StartWrite() {
    enterMon();
    printf("MSC: startWrite\n");
    waitW[i] = RW.OKtoWrite.waiting + RW.OKtoRead.waiting;
    atomic{
    if
    :: (RW.writers != 0 || RW.readers != 0) -> printf("MSC: wait(OKtoWrite)\n"); wait_OktoWrite(i);
    :: else;
    fi;
    }
    printf("MSC: go write\n");
    RW.writers++;
    decrementArray(waitR, nReaders);
    decrementArray(waitW, nWriters);
    leaveMon();
}

inline EndRead() {
    enterMon();
    printf("MSC: EndRead\n");
    RW.readers--;
    atomic{
    if
    :: (RW.readers == 0) -> printf("MSC: signal(OKtoWrite)\n"); signalC(RW.OKtoWrite);
    :: else;
    fi;
    }
    leaveMon();
}

inline EndWrite() {
    enterMon();
    printf("MSC: EndWrite\n");
    RW.writers--;

    int countZeros;
    countZeros = 0;
    int t;
    t = 0;
    atomic{
    do
        :: t < nReaders ->
            /*printf("MSC: t=%d\n", t); */
            if
            :: waitR[t] == 0 -> countZeros++;
            :: else;
            fi;
            t++;
        :: else -> break;
    od;
    }

    printf("MSC: %d > %d - %d \n", countZeros, nReaders, RW.OKtoRead.waiting);
    atomic{
        if
        :: (countZeros > nReaders - RW.OKtoRead.waiting) -> printf("MSC: signal(OKtoRead)\n"); signalC(RW.OKtoRead);
        :: else ->  printf("MSC: signal(OKtoWrite)\n"); signalC(RW.OKtoWrite);
        fi;
    }
    leaveMon();
}

proctype reader (int i){ 
    do
    ::
    wantR[i] = true;
    StartRead();
    printf("MSC: ==CS== begin\n");
    critR[i] = true;
    crR++;
    crR--;
    critR[i] = false;
    printf("MSC: ==CS== end\n");
    EndRead();
    wantR[i] = false;
    od;
}

proctype writer (int i){
do
    ::
    wantW[i] = true;
    StartWrite();
    printf("MSC: ==CS== begin\n");
    critW[i] = true;
    crW++;
    crW--;
    critW[i] = false;
    printf("MSC: ==CS== end\n");
    EndWrite();
    wantW[i] = false;
od;
}


init {
atomic {
    lock = false;
    initMon(RW, 0, 0);
    int i;
    i = 0;
    do
    :: i < nReaders ->
            run reader(i);
            i = i+1;
    :: else -> break;
    od;
    i = 0;
    do
    :: i < nWriters ->
            run writer(i);
            i = i+1;
    :: else -> break;
    od;

}
}
