#define Version	"Spin Version 4.3.0 -- 22 June 2007"
#define Source	"pan_in"

char *TrailFile = Source; /* default */
#if defined(BFS)
#ifndef SAFETY
#define SAFETY
#endif
#ifndef XUSAFE
#define XUSAFE
#endif
#endif
#ifndef uchar
#define uchar	unsigned char
#endif
#ifndef uint
#define uint	unsigned int
#endif
#define DELTA	500
#ifdef MA
#if MA==1
#undef MA
#define MA	100
#endif
#endif
#ifdef W_XPT
#if W_XPT==1
#undef W_XPT
#define W_XPT 1000000
#endif
#endif
#ifndef NFAIR
#define NFAIR	2	/* must be >= 2 */
#endif
#define HAS_CODE
#define MERGED	1
#ifdef NP	/* includes np_ demon */
#define HAS_NP	2
#define VERI	4
#define endclaim	3 /* none */
#endif
#if !defined(NOCLAIM) && !defined NP
#define VERI	3
#define endclaim	endstate3
#endif
typedef struct S_F_MAP {
	char *fnm; int from; int upto;
} S_F_MAP;

#define nstates3	18	/* :never: */
#define nstates_claim	nstates3
#define endstate3	17
short src_ln3 [] = {
	  0, 309, 309, 310, 310, 311, 311, 308, 
	313, 315, 315, 314, 317, 319, 319, 318, 
	321, 321,   0, };
S_F_MAP src_file3 [] = {
	{ "-", 0, 0 },
	{ "pan.___", 1, 17 },
	{ "-", 18, 19 }
};
#define src_claim	src_ln3
uchar reached3 [] = {
	  0,   1,   1,   1,   1,   1,   1,   0, 
	  1,   1,   1,   0,   1,   1,   1,   0, 
	  1,   0,   0, };
#define reached_claim	reached3

#define nstates2	25	/* :init: */
#define endstate2	24
short src_ln2 [] = {
	  0, 273,  54,  55,  56, 276, 278, 279, 
	280, 281, 281, 277, 283, 277, 283, 285, 
	286, 287, 288, 288, 284, 291, 284, 272, 
	292,   0, };
S_F_MAP src_file2 [] = {
	{ "-", 0, 0 },
	{ "pan.___", 1, 24 },
	{ "-", 25, 26 }
};
uchar reached2 [] = {
	  0,   1,   1,   0,   0,   0,   1,   0, 
	  0,   1,   0,   0,   1,   1,   0,   1, 
	  0,   0,   1,   1,   0,   1,   1,   0, 
	  0,   0, };

#define nstates1	135	/* writer */
#define endstate1	134
short src_ln1 [] = {
	  0, 256, 256, 257, 257, 255, 259, 255, 
	 64,  65,  66,  63,  68, 176, 177, 178, 
	179, 182, 182,  96,  97,  98,  99, 100, 
	101, 102, 103,  95, 105, 183, 181, 185, 
	180, 186, 187,  24,  26,  29,  29,  30, 
	 28,  32,  32,  33,  34,  35,  25,  37, 
	 25,  23,  38,  24,  26,  29,  29,  30, 
	 28,  32,  32,  33,  34,  35,  25,  37, 
	 25,  23,  38,  74,  75,  73,  77, 191, 
	260, 261, 262, 263, 264, 265,  64,  65, 
	 66,  63,  68, 208, 209, 212, 214, 217, 
	220, 220, 221, 219, 223, 223, 224, 224, 
	216, 226, 216, 215, 228, 231, 231, 112, 
	113, 114, 115, 116, 111, 118, 110, 119, 
	232, 232, 112, 113, 114, 115, 116, 111, 
	118, 110, 119, 230, 234, 229,  74,  75, 
	 73,  77, 236, 253, 268, 253, 268,   0, };
S_F_MAP src_file1 [] = {
	{ "-", 0, 0 },
	{ "pan.___", 1, 134 },
	{ "-", 135, 136 }
};
uchar reached1 [] = {
	  0,   1,   1,   1,   1,   0,   1,   1, 
	  1,   0,   0,   1,   1,   0,   0,   0, 
	  0,   1,   0,   1,   0,   0,   0,   0, 
	  0,   0,   0,   1,   0,   1,   1,   1, 
	  0,   0,   0,   1,   1,   1,   0,   1, 
	  0,   1,   0,   1,   0,   1,   0,   1, 
	  1,   1,   0,   1,   1,   1,   0,   1, 
	  0,   1,   0,   1,   0,   1,   0,   1, 
	  1,   1,   0,   1,   0,   1,   0,   0, 
	  0,   0,   0,   0,   0,   0,   1,   0, 
	  0,   1,   1,   0,   0,   0,   0,   1, 
	  1,   0,   1,   0,   1,   0,   1,   1, 
	  0,   1,   1,   0,   0,   1,   0,   1, 
	  0,   0,   0,   1,   1,   1,   1,   0, 
	  1,   0,   1,   0,   0,   0,   1,   1, 
	  1,   1,   0,   1,   1,   0,   1,   0, 
	  1,   0,   0,   0,   1,   1,   0,   0, };

#define nstates0	116	/* reader */
#define endstate0	115
short src_ln0 [] = {
	  0,  64,  65,  66,  63,  68, 132, 133, 
	134, 135, 138, 138,  84,  85,  86,  87, 
	 88,  89,  90,  91,  83,  93, 139, 137, 
	141, 136, 142, 143, 147, 149, 152, 155, 
	155, 156, 154, 158, 158, 159, 159, 151, 
	161, 151, 161, 150, 164, 165, 112, 113, 
	114, 115, 116, 111, 118, 110, 119, 167, 
	163, 170,  24,  26,  29,  29,  30,  28, 
	 32,  32,  33,  34,  35,  25,  37,  25, 
	 23,  38,  74,  75,  73,  77, 172, 242, 
	243, 244, 245, 246, 247,  64,  65,  66, 
	 63,  68, 195, 196, 199, 199, 112, 113, 
	114, 115, 116, 111, 118, 110, 119, 200, 
	198, 202, 197,  74,  75,  73,  77, 204, 
	239, 250, 239, 250,   0, };
S_F_MAP src_file0 [] = {
	{ "-", 0, 0 },
	{ "pan.___", 1, 115 },
	{ "-", 116, 117 }
};
uchar reached0 [] = {
	  0,   1,   0,   0,   1,   1,   0,   0, 
	  0,   0,   1,   0,   1,   0,   0,   0, 
	  0,   0,   0,   0,   1,   0,   1,   1, 
	  1,   0,   0,   0,   0,   0,   1,   1, 
	  0,   1,   0,   1,   0,   1,   1,   0, 
	  1,   1,   0,   0,   1,   0,   1,   0, 
	  0,   0,   1,   1,   1,   1,   0,   1, 
	  0,   1,   1,   1,   1,   0,   1,   0, 
	  1,   0,   1,   0,   1,   0,   1,   1, 
	  1,   0,   1,   0,   1,   0,   1,   0, 
	  0,   0,   0,   0,   0,   1,   0,   0, 
	  1,   1,   0,   0,   1,   0,   1,   0, 
	  0,   0,   1,   1,   1,   1,   0,   1, 
	  1,   1,   0,   1,   0,   1,   0,   0, 
	  0,   1,   1,   0,   0, };
struct {
	int tp; short *src;
} src_all[] = {
	{ 3, &src_ln3[0] },
	{ 2, &src_ln2[0] },
	{ 1, &src_ln1[0] },
	{ 0, &src_ln0[0] },
	{ 0, (short *) 0 }
};
short *frm_st0;
struct {
	char *c; char *t;
} code_lookup[] = {
	{ (char *) 0, "" }
};
#define _T5	99
#define _T2	100
#define SYNC	0
#define ASYNC	0

struct Condition { /* user defined type */
	unsigned gate : 1;
	int waiting;
};
struct Monitor { /* user defined type */
	int readers;
	int writers;
	struct Condition OKtoRead;
	struct Condition OKtoWrite;
};
char *procname[] = {
   "reader",
   "writer",
   ":init:",
   ":never:",
   ":np_:",
};

typedef struct P3 { /* :never: */
	unsigned _pid : 8;  /* 0..255 */
	unsigned _t   : 4; /* proctype */
	unsigned _p   : 9; /* state    */
} P3;
#define Air3	(sizeof(P3) - 3)
#define Pinit	((P2 *)this)
typedef struct P2 { /* :init: */
	unsigned _pid : 8;  /* 0..255 */
	unsigned _t   : 4; /* proctype */
	unsigned _p   : 9; /* state    */
	int i;
} P2;
#define Air2	(sizeof(P2) - Offsetof(P2, i) - 1*sizeof(int))
#define Pwriter	((P1 *)this)
typedef struct P1 { /* writer */
	unsigned _pid : 8;  /* 0..255 */
	unsigned _t   : 4; /* proctype */
	unsigned _p   : 9; /* state    */
	int i;
	int countZeros;
	int t;
} P1;
#define Air1	(sizeof(P1) - Offsetof(P1, t) - 1*sizeof(int))
#define Preader	((P0 *)this)
typedef struct P0 { /* reader */
	unsigned _pid : 8;  /* 0..255 */
	unsigned _t   : 4; /* proctype */
	unsigned _p   : 9; /* state    */
	int i;
	int cZeros;
	int p;
} P0;
#define Air0	(sizeof(P0) - Offsetof(P0, p) - 1*sizeof(int))
typedef struct P4 { /* np_ */
	unsigned _pid : 8;  /* 0..255 */
	unsigned _t   : 4; /* proctype */
	unsigned _p   : 9; /* state    */
} P4;
#define Air4	(sizeof(P4) - 3)
#if defined(BFS) && defined(REACH)
#undef REACH
#endif
#ifdef VERI
#define BASE	1
#else
#define BASE	0
#endif
typedef struct Trans {
	short atom;	/* if &2 = atomic trans; if &8 local */
#ifdef HAS_UNLESS
	short escp[HAS_UNLESS];	/* lists the escape states */
	short e_trans;	/* if set, this is an escp-trans */
#endif
	short tpe[2];	/* class of operation (for reduction) */
	short qu[6];	/* for conditional selections: qid's  */
	uchar ty[6];	/* ditto: type's */
#ifdef NIBIS
	short om;	/* completion status of preselects */
#endif
	char *tp;	/* src txt of statement */
	int st;		/* the nextstate */
	int t_id;	/* transition id, unique within proc */
	int forw;	/* index forward transition */
	int back;	/* index return  transition */
	struct Trans *nxt;
} Trans;

#define qptr(x)	(((uchar *)&now)+(int)q_offset[x])
#define pptr(x)	(((uchar *)&now)+(int)proc_offset[x])
extern uchar *Pptr(int);
#define q_sz(x)	(((Q0 *)qptr(x))->Qlen)

#ifndef VECTORSZ
#define VECTORSZ	1024           /* sv   size in bytes */
#endif

#ifdef VERBOSE
#ifndef CHECK
#define CHECK
#endif
#ifndef DEBUG
#define DEBUG
#endif
#endif
#ifdef SAFETY
#ifndef NOFAIR
#define NOFAIR
#endif
#endif
#ifdef NOREDUCE
#ifndef XUSAFE
#define XUSAFE
#endif
#if !defined(SAFETY) && !defined(MA)
#define FULLSTACK
#endif
#else
#ifdef BITSTATE
#ifdef SAFETY && !defined(HASH64)
#define CNTRSTACK
#else
#define FULLSTACK
#endif
#else
#define FULLSTACK
#endif
#endif
#ifdef BITSTATE
#ifndef NOCOMP
#define NOCOMP
#endif
#if !defined(LC) && defined(SC)
#define LC
#endif
#endif
#if defined(COLLAPSE2) || defined(COLLAPSE3) || defined(COLLAPSE4)
/* accept the above for backward compatibility */
#define COLLAPSE
#endif
#ifdef HC
#undef HC
#define HC4
#endif
#ifdef HC0
#define HC	0
#endif
#ifdef HC1
#define HC	1
#endif
#ifdef HC2
#define HC	2
#endif
#ifdef HC3
#define HC	3
#endif
#ifdef HC4
#define HC	4
#endif
#ifdef COLLAPSE
unsigned long ncomps[256+2];
#endif
#define MAXQ   	255
#define MAXPROC	255
#define WS		sizeof(long)   /* word size in bytes */
typedef struct Stack  {	 /* for queues and processes */
#if VECTORSZ>32000
	int o_delta;
	int o_offset;
	int o_skip;
	int o_delqs;
#else
	short o_delta;
	short o_offset;
	short o_skip;
	short o_delqs;
#endif
	short o_boq;
#ifndef XUSAFE
	char *o_name;
#endif
	char *body;
	struct Stack *nxt;
	struct Stack *lst;
} Stack;

typedef struct Svtack { /* for complete state vector */
#if VECTORSZ>32000
	int o_delta;
	int m_delta;
#else
	short o_delta;	 /* current size of frame */
	short m_delta;	 /* maximum size of frame */
#endif
#if SYNC
	short o_boq;
#endif
	char *body;
	struct Svtack *nxt;
	struct Svtack *lst;
} Svtack;

Trans ***trans;	/* 1 ptr per state per proctype */

#if defined(FULLSTACK) || defined(BFS)
struct H_el *Lstate;
#endif
int depthfound = -1;	/* loop detection */
#if VECTORSZ>32000
int proc_offset[MAXPROC];
int q_offset[MAXQ];
#else
short proc_offset[MAXPROC];
short q_offset[MAXQ];
#endif
uchar proc_skip[MAXPROC];
uchar q_skip[MAXQ];
unsigned long  vsize;	/* vector size in bytes */
#ifdef SVDUMP
int vprefix=0, svfd;		/* runtime option -pN */
#endif
char *tprefix = "trail";	/* runtime option -tsuffix */
short boq = -1;		/* blocked_on_queue status */
typedef struct State {
	uchar _nr_pr;
	uchar _nr_qs;
	uchar   _a_t;	/* cycle detection */
#ifndef NOFAIR
	uchar   _cnt[NFAIR];	/* counters, weak fairness */
#endif
#ifndef NOVSZ
#if VECTORSZ<65536
	unsigned short _vsz;
#else
	unsigned long  _vsz;
#endif
#endif
#ifdef HAS_LAST
	uchar  _last;	/* pid executed in last step */
#endif
#ifdef EVENT_TRACE
#if nstates_event<256
	uchar _event;
#else
	unsigned short _event;
#endif
#endif
	unsigned lock : 1;
	uchar wantR[2];
	uchar critR[2];
	int num;
	int waitR[2];
	int waitW[2];
	struct Monitor RW;
	uchar sv[VECTORSZ];
} State;

#define HAS_TRACK	0
/* hidden variable: */	uchar wantW[2];
/* hidden variable: */	uchar critW[2];
/* hidden variable: */	int crR;
/* hidden variable: */	int crW;
int _; /* a predefined write-only variable */

#define FORWARD_MOVES	"pan.m"
#define REVERSE_MOVES	"pan.b"
#define TRANSITIONS	"pan.t"
#define _NP_	4
uchar reached4[3];  /* np_ */
#define nstates4	3 /* np_ */
#define endstate4	2 /* np_ */

#define start4	0 /* np_ */
#define start3	7
#define start_claim	7
#define start2	23
#define start1	131
#define start0	112
#ifdef NP
#define ACCEPT_LAB	1 /* at least 1 in np_ */
#else
#define ACCEPT_LAB	2 /* user-defined accept labels */
#endif
#define PROG_LAB	0 /* progress labels */
uchar *accpstate[5];
uchar *progstate[5];
uchar *reached[5];
uchar *stopstate[5];
uchar *visstate[5];
short *mapstate[5];
#ifdef HAS_CODE
int NrStates[5];
#endif
#define NQS	0
short q_flds[1];
short q_max[1];
typedef struct Q0 {	/* generic q */
	uchar Qlen;	/* q_size */
	uchar _t;
} Q0;

/** function prototypes **/
char *emalloc(unsigned long);
char *Malloc(unsigned long);
int Boundcheck(int, int, int, int, Trans *);
int addqueue(int, int);
/* int atoi(char *); */
/* int abort(void); */
int close(int);
int delproc(int, int);
int endstate(void);
int hstore(char *, int);
#ifdef MA
int gstore(char *, int, uchar);
#endif
int q_cond(short, Trans *);
int q_full(int);
int q_len(int);
int q_zero(int);
int qrecv(int, int, int, int);
int unsend(int);
/* void *sbrk(int); */
void Uerror(char *);
void assert(int, char *, int, int, Trans *);
void c_chandump(int);
void c_globals(void);
void c_locals(int, int);
void checkcycles(void);
void crack(int, int, Trans *, short *);
void d_hash(uchar *, int);
void s_hash(uchar *, int);
void r_hash(uchar *, int);
void delq(int);
void do_reach(void);
void pan_exit(int);
void exit(int);
void hinit(void);
void imed(Trans *, int, int, int);
void new_state(void);
void p_restor(int);
void putpeg(int, int);
void putrail(void);
void q_restor(void);
void retrans(int, int, int, short *, uchar *);
void settable(void);
void setq_claim(int, int, char *, int, char *);
void sv_restor(void);
void sv_save(void);
void tagtable(int, int, int, short *, uchar *);
void uerror(char *);
void unrecv(int, int, int, int, int);
void usage(FILE *);
void wrap_stats(void);
#if defined(FULLSTACK) && defined(BITSTATE)
int  onstack_now(void);
void onstack_init(void);
void onstack_put(void);
void onstack_zap(void);
#endif
#ifndef XUSAFE
int q_S_check(int, int);
int q_R_check(int, int);
uchar q_claim[MAXQ+1];
char *q_name[MAXQ+1];
char *p_name[MAXPROC+1];
#endif
void qsend(int, int);
#define Addproc(x)	addproc(x, 0)
#define LOCAL	1
#define Q_FULL_F	2
#define Q_EMPT_F	3
#define Q_EMPT_T	4
#define Q_FULL_T	5
#define TIMEOUT_F	6
#define GLOBAL	7
#define BAD	8
#define ALPHA_F	9
#define NTRANS	101
#ifdef PEG
long peg[NTRANS];
#endif
