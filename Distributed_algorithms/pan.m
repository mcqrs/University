#define rand	pan_rand
#if defined(HAS_CODE) && defined(VERBOSE)
	printf("Pr: %d Tr: %d\n", II, t->forw);
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* PROC :never: */
	case 3: /* STATE 1 - line 309 "pan.___" - [((!(critR[1])&&wantR[1]))] (0:0:0 - 1) */
		
#if defined(VERI) && !defined(NP)
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim reached state %d (line %d)\n",
					depth, frm_st0[t->forw], src_claim[1]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
		reached[3][1] = 1;
		if (!(( !(((int)now.critR[1]))&&((int)now.wantR[1]))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 4: /* STATE 3 - line 310 "pan.___" - [((!(critR[0])&&wantR[0]))] (0:0:0 - 1) */
		
#if defined(VERI) && !defined(NP)
		{	static int reported3 = 0;
			if (verbose && !reported3)
			{	printf("depth %d: Claim reached state %d (line %d)\n",
					depth, frm_st0[t->forw], src_claim[3]);
				reported3 = 1;
				fflush(stdout);
		}	}
#endif
		reached[3][3] = 1;
		if (!(( !(((int)now.critR[0]))&&((int)now.wantR[0]))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 5: /* STATE 9 - line 315 "pan.___" - [(!(critR[1]))] (0:0:0 - 1) */
		
#if defined(VERI) && !defined(NP)
		{	static int reported9 = 0;
			if (verbose && !reported9)
			{	printf("depth %d: Claim reached state %d (line %d)\n",
					depth, frm_st0[t->forw], src_claim[9]);
				reported9 = 1;
				fflush(stdout);
		}	}
#endif
		reached[3][9] = 1;
		if (!( !(((int)now.critR[1]))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 6: /* STATE 13 - line 319 "pan.___" - [(!(critR[0]))] (0:0:0 - 1) */
		
#if defined(VERI) && !defined(NP)
		{	static int reported13 = 0;
			if (verbose && !reported13)
			{	printf("depth %d: Claim reached state %d (line %d)\n",
					depth, frm_st0[t->forw], src_claim[13]);
				reported13 = 1;
				fflush(stdout);
		}	}
#endif
		reached[3][13] = 1;
		if (!( !(((int)now.critR[0]))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 7: /* STATE 17 - line 321 "pan.___" - [-end-] (0:0:0 - 1) */
		
#if defined(VERI) && !defined(NP)
		{	static int reported17 = 0;
			if (verbose && !reported17)
			{	printf("depth %d: Claim reached state %d (line %d)\n",
					depth, frm_st0[t->forw], src_claim[17]);
				reported17 = 1;
				fflush(stdout);
		}	}
#endif
		reached[3][17] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC :init: */
	case 8: /* STATE 1 - line 273 "pan.___" - [lock = 0] (0:0:1 - 1) */
		IfNotBlocked
		reached[2][1] = 1;
		(trpt+1)->bup.oval = ((int)now.lock);
		now.lock = 0;
#ifdef VAR_RANGES
		logval("lock", ((int)now.lock));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 9: /* STATE 2 - line 54 "pan.___" - [RW.readers = 0] (0:11:3 - 1) */
		IfNotBlocked
		reached[2][2] = 1;
		(trpt+1)->bup.ovals = grab_ints(3);
		(trpt+1)->bup.ovals[0] = now.RW.readers;
		now.RW.readers = 0;
#ifdef VAR_RANGES
		logval("RW.readers", now.RW.readers);
#endif
		;
		/* merge: RW.writers = 0(11, 3, 11) */
		reached[2][3] = 1;
		(trpt+1)->bup.ovals[1] = now.RW.writers;
		now.RW.writers = 0;
#ifdef VAR_RANGES
		logval("RW.writers", now.RW.writers);
#endif
		;
		/* merge: i = 0(11, 5, 11) */
		reached[2][5] = 1;
		(trpt+1)->bup.ovals[2] = ((P2 *)this)->i;
		((P2 *)this)->i = 0;
#ifdef VAR_RANGES
		logval(":init::i", ((P2 *)this)->i);
#endif
		;
		/* merge: .(goto)(0, 12, 11) */
		reached[2][12] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 10: /* STATE 6 - line 278 "pan.___" - [((i<2))] (0:0:0 - 1) */
		IfNotBlocked
		reached[2][6] = 1;
		if (!((((P2 *)this)->i<2)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 11: /* STATE 7 - line 279 "pan.___" - [(run reader(i))] (11:0:1 - 1) */
		IfNotBlocked
		reached[2][7] = 1;
		if (!(addproc(0, ((P2 *)this)->i)))
			continue;
		/* merge: i = (i+1)(0, 8, 11) */
		reached[2][8] = 1;
		(trpt+1)->bup.oval = ((P2 *)this)->i;
		((P2 *)this)->i = (((P2 *)this)->i+1);
#ifdef VAR_RANGES
		logval(":init::i", ((P2 *)this)->i);
#endif
		;
		/* merge: .(goto)(0, 12, 11) */
		reached[2][12] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 12: /* STATE 14 - line 283 "pan.___" - [i = 0] (0:20:1 - 3) */
		IfNotBlocked
		reached[2][14] = 1;
		(trpt+1)->bup.oval = ((P2 *)this)->i;
		((P2 *)this)->i = 0;
#ifdef VAR_RANGES
		logval(":init::i", ((P2 *)this)->i);
#endif
		;
		/* merge: .(goto)(0, 21, 20) */
		reached[2][21] = 1;
		;
		_m = 3; goto P999; /* 1 */
/* STATE 15 - line 285 "pan.___" - [((i<2))] (0:0 - 1) same as 10 (0:0 - 1) */
	case 13: /* STATE 16 - line 286 "pan.___" - [(run writer(i))] (20:0:1 - 1) */
		IfNotBlocked
		reached[2][16] = 1;
		if (!(addproc(1, ((P2 *)this)->i)))
			continue;
		/* merge: i = (i+1)(0, 17, 20) */
		reached[2][17] = 1;
		(trpt+1)->bup.oval = ((P2 *)this)->i;
		((P2 *)this)->i = (((P2 *)this)->i+1);
#ifdef VAR_RANGES
		logval(":init::i", ((P2 *)this)->i);
#endif
		;
		/* merge: .(goto)(0, 21, 20) */
		reached[2][21] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 14: /* STATE 24 - line 292 "pan.___" - [-end-] (0:0:0 - 1) */
		IfNotBlocked
		reached[2][24] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC writer */
	case 15: /* STATE 8 - line 64 "pan.___" - [(!(lock))] (13:0:1 - 1) */
		IfNotBlocked
		reached[1][8] = 1;
		if (!( !(((int)now.lock))))
			continue;
		/* merge: lock = 1(13, 9, 13) */
		reached[1][9] = 1;
		(trpt+1)->bup.oval = ((int)now.lock);
		now.lock = 1;
#ifdef VAR_RANGES
		logval("lock", ((int)now.lock));
#endif
		;
		/* merge: printf('MSC: enterMon()\\n')(13, 10, 13) */
		reached[1][10] = 1;
		Printf("MSC: enterMon()\n");
		_m = 3; goto P999; /* 2 */
	case 16: /* STATE 13 - line 176 "pan.___" - [wantW[i] = 1] (0:0:1 - 1) */
		IfNotBlocked
		reached[1][13] = 1;
		(trpt+1)->bup.oval = ((int)wantW[ Index(((P1 *)this)->i, 2) ]);
		wantW[ Index(((P1 *)this)->i, 2) ] = 1;
#ifdef VAR_RANGES
		logval("wantW[writer:i]", ((int)wantW[ Index(((P1 *)this)->i, 2) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 17: /* STATE 14 - line 177 "pan.___" - [wantW[i] = 0] (0:0:1 - 1) */
		IfNotBlocked
		reached[1][14] = 1;
		(trpt+1)->bup.oval = ((int)wantW[ Index(((P1 *)this)->i, 2) ]);
		wantW[ Index(((P1 *)this)->i, 2) ] = 0;
#ifdef VAR_RANGES
		logval("wantW[writer:i]", ((int)wantW[ Index(((P1 *)this)->i, 2) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 18: /* STATE 15 - line 178 "pan.___" - [printf('MSC: startWrite\\n')] (0:0:0 - 1) */
		IfNotBlocked
		reached[1][15] = 1;
		Printf("MSC: startWrite\n");
		_m = 3; goto P999; /* 0 */
	case 19: /* STATE 16 - line 179 "pan.___" - [waitW[i] = (RW.OKtoWrite.waiting+RW.OKtoRead.waiting)] (0:0:1 - 1) */
		IfNotBlocked
		reached[1][16] = 1;
		(trpt+1)->bup.oval = now.waitW[ Index(((P1 *)this)->i, 2) ];
		now.waitW[ Index(((P1 *)this)->i, 2) ] = (now.RW.OKtoWrite.waiting+now.RW.OKtoRead.waiting);
#ifdef VAR_RANGES
		logval("waitW[writer:i]", now.waitW[ Index(((P1 *)this)->i, 2) ]);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 20: /* STATE 17 - line 182 "pan.___" - [(((RW.writers!=0)||(RW.readers!=0)))] (28:0:0 - 1) */
		IfNotBlocked
		reached[1][17] = 1;
		if (!(((now.RW.writers!=0)||(now.RW.readers!=0))))
			continue;
		/* merge: printf('MSC: wait(OKtoWrite)\\n')(0, 18, 28) */
		reached[1][18] = 1;
		Printf("MSC: wait(OKtoWrite)\n");
		_m = 3; goto P999; /* 1 */
	case 21: /* STATE 19 - line 96 "pan.___" - [RW.OKtoWrite.waiting = (RW.OKtoWrite.waiting+1)] (0:21:2 - 1) */
		IfNotBlocked
		reached[1][19] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = now.RW.OKtoWrite.waiting;
		now.RW.OKtoWrite.waiting = (now.RW.OKtoWrite.waiting+1);
#ifdef VAR_RANGES
		logval("RW.OKtoWrite.waiting", now.RW.OKtoWrite.waiting);
#endif
		;
		/* merge: lock = 0(21, 20, 21) */
		reached[1][20] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.lock);
		now.lock = 0;
#ifdef VAR_RANGES
		logval("lock", ((int)now.lock));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 22: /* STATE 21 - line 98 "pan.___" - [(!(waitW[i]))] (23:0:0 - 1) */
		IfNotBlocked
		reached[1][21] = 1;
		if (!( !(now.waitW[ Index(((P1 *)this)->i, 2) ])))
			continue;
		/* merge: printf('MSC: my turn! wait for gate\\n')(0, 22, 23) */
		reached[1][22] = 1;
		Printf("MSC: my turn! wait for gate\n");
		_m = 3; goto P999; /* 1 */
	case 23: /* STATE 23 - line 100 "pan.___" - [(RW.OKtoWrite.gate)] (34:0:2 - 1) */
		IfNotBlocked
		reached[1][23] = 1;
		if (!(((int)now.RW.OKtoWrite.gate)))
			continue;
		/* merge: RW.OKtoWrite.gate = 0(34, 24, 34) */
		reached[1][24] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)now.RW.OKtoWrite.gate);
		now.RW.OKtoWrite.gate = 0;
#ifdef VAR_RANGES
		logval("RW.OKtoWrite.gate", ((int)now.RW.OKtoWrite.gate));
#endif
		;
		/* merge: RW.OKtoWrite.waiting = (RW.OKtoWrite.waiting-1)(34, 25, 34) */
		reached[1][25] = 1;
		(trpt+1)->bup.ovals[1] = now.RW.OKtoWrite.waiting;
		now.RW.OKtoWrite.waiting = (now.RW.OKtoWrite.waiting-1);
#ifdef VAR_RANGES
		logval("RW.OKtoWrite.waiting", now.RW.OKtoWrite.waiting);
#endif
		;
		/* merge: printf('MSC: received gate\\n')(34, 26, 34) */
		reached[1][26] = 1;
		Printf("MSC: received gate\n");
		/* merge: .(goto)(34, 31, 34) */
		reached[1][31] = 1;
		;
		/* merge: printf('MSC: go write\\n')(34, 33, 34) */
		reached[1][33] = 1;
		Printf("MSC: go write\n");
		_m = 3; goto P999; /* 5 */
	case 24: /* STATE 31 - line 185 "pan.___" - [.(goto)] (0:34:0 - 2) */
		IfNotBlocked
		reached[1][31] = 1;
		;
		/* merge: printf('MSC: go write\\n')(34, 33, 34) */
		reached[1][33] = 1;
		Printf("MSC: go write\n");
		_m = 3; goto P999; /* 1 */
	case 25: /* STATE 34 - line 187 "pan.___" - [RW.writers = (RW.writers+1)] (0:0:1 - 1) */
		IfNotBlocked
		reached[1][34] = 1;
		(trpt+1)->bup.oval = now.RW.writers;
		now.RW.writers = (now.RW.writers+1);
#ifdef VAR_RANGES
		logval("RW.writers", now.RW.writers);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 26: /* STATE 35 - line 24 "pan.___" - [num = 0] (0:0:1 - 1) */
		IfNotBlocked
		reached[1][35] = 1;
		(trpt+1)->bup.oval = now.num;
		now.num = 0;
#ifdef VAR_RANGES
		logval("num", now.num);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 27: /* STATE 36 - line 26 "pan.___" - [((num<2))] (0:0:0 - 1) */
		IfNotBlocked
		reached[1][36] = 1;
		if (!((now.num<2)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 28: /* STATE 37 - line 29 "pan.___" - [((waitR[num]>0))] (46:0:2 - 1) */
		IfNotBlocked
		reached[1][37] = 1;
		if (!((now.waitR[ Index(now.num, 2) ]>0)))
			continue;
		/* merge: waitR[num] = (waitR[num]-1)(46, 38, 46) */
		reached[1][38] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = now.waitR[ Index(now.num, 2) ];
		now.waitR[ Index(now.num, 2) ] = (now.waitR[ Index(now.num, 2) ]-1);
#ifdef VAR_RANGES
		logval("waitR[num]", now.waitR[ Index(now.num, 2) ]);
#endif
		;
		/* merge: .(goto)(46, 41, 46) */
		reached[1][41] = 1;
		;
		/* merge: num = (num+1)(46, 42, 46) */
		reached[1][42] = 1;
		(trpt+1)->bup.ovals[1] = now.num;
		now.num = (now.num+1);
#ifdef VAR_RANGES
		logval("num", now.num);
#endif
		;
		/* merge: .(goto)(0, 47, 46) */
		reached[1][47] = 1;
		;
		_m = 3; goto P999; /* 4 */
	case 29: /* STATE 42 - line 32 "pan.___" - [num = (num+1)] (0:46:1 - 3) */
		IfNotBlocked
		reached[1][42] = 1;
		(trpt+1)->bup.oval = now.num;
		now.num = (now.num+1);
#ifdef VAR_RANGES
		logval("num", now.num);
#endif
		;
		/* merge: .(goto)(0, 47, 46) */
		reached[1][47] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 30: /* STATE 44 - line 34 "pan.___" - [printf('MSC: [array]--\\n')] (0:48:0 - 1) */
		IfNotBlocked
		reached[1][44] = 1;
		Printf("MSC: [array]--\n");
		/* merge: goto :b5(48, 45, 48) */
		reached[1][45] = 1;
		;
		_m = 3; goto P999; /* 1 */
/* STATE 51 - line 24 "pan.___" - [num = 0] (0:0 - 1) same as 26 (0:0 - 1) */
/* STATE 52 - line 26 "pan.___" - [((num<2))] (0:0 - 1) same as 27 (0:0 - 1) */
	case 31: /* STATE 53 - line 29 "pan.___" - [((waitW[num]>0))] (62:0:2 - 1) */
		IfNotBlocked
		reached[1][53] = 1;
		if (!((now.waitW[ Index(now.num, 2) ]>0)))
			continue;
		/* merge: waitW[num] = (waitW[num]-1)(62, 54, 62) */
		reached[1][54] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = now.waitW[ Index(now.num, 2) ];
		now.waitW[ Index(now.num, 2) ] = (now.waitW[ Index(now.num, 2) ]-1);
#ifdef VAR_RANGES
		logval("waitW[num]", now.waitW[ Index(now.num, 2) ]);
#endif
		;
		/* merge: .(goto)(62, 57, 62) */
		reached[1][57] = 1;
		;
		/* merge: num = (num+1)(62, 58, 62) */
		reached[1][58] = 1;
		(trpt+1)->bup.ovals[1] = now.num;
		now.num = (now.num+1);
#ifdef VAR_RANGES
		logval("num", now.num);
#endif
		;
		/* merge: .(goto)(0, 63, 62) */
		reached[1][63] = 1;
		;
		_m = 3; goto P999; /* 4 */
	case 32: /* STATE 58 - line 32 "pan.___" - [num = (num+1)] (0:62:1 - 3) */
		IfNotBlocked
		reached[1][58] = 1;
		(trpt+1)->bup.oval = now.num;
		now.num = (now.num+1);
#ifdef VAR_RANGES
		logval("num", now.num);
#endif
		;
		/* merge: .(goto)(0, 63, 62) */
		reached[1][63] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 33: /* STATE 60 - line 34 "pan.___" - [printf('MSC: [array]--\\n')] (0:64:0 - 1) */
		IfNotBlocked
		reached[1][60] = 1;
		Printf("MSC: [array]--\n");
		/* merge: goto :b6(64, 61, 64) */
		reached[1][61] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 34: /* STATE 67 - line 74 "pan.___" - [lock = 0] (0:73:1 - 1) */
		IfNotBlocked
		reached[1][67] = 1;
		(trpt+1)->bup.oval = ((int)now.lock);
		now.lock = 0;
#ifdef VAR_RANGES
		logval("lock", ((int)now.lock));
#endif
		;
		/* merge: printf('MSC: leaveMon()\\n')(73, 68, 73) */
		reached[1][68] = 1;
		Printf("MSC: leaveMon()\n");
		/* merge: printf('MSC: ==CS== begin\\n')(73, 72, 73) */
		reached[1][72] = 1;
		Printf("MSC: ==CS== begin\n");
		_m = 3; goto P999; /* 2 */
	case 35: /* STATE 73 - line 261 "pan.___" - [critW[i] = 1] (0:0:1 - 1) */
		IfNotBlocked
		reached[1][73] = 1;
		(trpt+1)->bup.oval = ((int)critW[ Index(((P1 *)this)->i, 2) ]);
		critW[ Index(((P1 *)this)->i, 2) ] = 1;
#ifdef VAR_RANGES
		logval("critW[writer:i]", ((int)critW[ Index(((P1 *)this)->i, 2) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 36: /* STATE 74 - line 262 "pan.___" - [crW = (crW+1)] (0:0:1 - 1) */
		IfNotBlocked
		reached[1][74] = 1;
		(trpt+1)->bup.oval = crW;
		crW = (crW+1);
#ifdef VAR_RANGES
		logval("crW", crW);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 37: /* STATE 75 - line 263 "pan.___" - [crW = (crW-1)] (0:0:1 - 1) */
		IfNotBlocked
		reached[1][75] = 1;
		(trpt+1)->bup.oval = crW;
		crW = (crW-1);
#ifdef VAR_RANGES
		logval("crW", crW);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 38: /* STATE 76 - line 264 "pan.___" - [critW[i] = 0] (0:0:1 - 1) */
		IfNotBlocked
		reached[1][76] = 1;
		(trpt+1)->bup.oval = ((int)critW[ Index(((P1 *)this)->i, 2) ]);
		critW[ Index(((P1 *)this)->i, 2) ] = 0;
#ifdef VAR_RANGES
		logval("critW[writer:i]", ((int)critW[ Index(((P1 *)this)->i, 2) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 39: /* STATE 77 - line 265 "pan.___" - [printf('MSC: ==CS== end\\n')] (0:0:0 - 1) */
		IfNotBlocked
		reached[1][77] = 1;
		Printf("MSC: ==CS== end\n");
		_m = 3; goto P999; /* 0 */
	case 40: /* STATE 78 - line 64 "pan.___" - [(!(lock))] (84:0:1 - 1) */
		IfNotBlocked
		reached[1][78] = 1;
		if (!( !(((int)now.lock))))
			continue;
		/* merge: lock = 1(84, 79, 84) */
		reached[1][79] = 1;
		(trpt+1)->bup.oval = ((int)now.lock);
		now.lock = 1;
#ifdef VAR_RANGES
		logval("lock", ((int)now.lock));
#endif
		;
		/* merge: printf('MSC: enterMon()\\n')(84, 80, 84) */
		reached[1][80] = 1;
		Printf("MSC: enterMon()\n");
		/* merge: printf('MSC: EndWrite\\n')(84, 83, 84) */
		reached[1][83] = 1;
		Printf("MSC: EndWrite\n");
		_m = 3; goto P999; /* 3 */
	case 41: /* STATE 84 - line 209 "pan.___" - [RW.writers = (RW.writers-1)] (0:0:1 - 1) */
		IfNotBlocked
		reached[1][84] = 1;
		(trpt+1)->bup.oval = now.RW.writers;
		now.RW.writers = (now.RW.writers-1);
#ifdef VAR_RANGES
		logval("RW.writers", now.RW.writers);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 42: /* STATE 85 - line 212 "pan.___" - [countZeros = 0] (0:99:2 - 1) */
		IfNotBlocked
		reached[1][85] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((P1 *)this)->countZeros;
		((P1 *)this)->countZeros = 0;
#ifdef VAR_RANGES
		logval("writer:countZeros", ((P1 *)this)->countZeros);
#endif
		;
		/* merge: t = 0(99, 86, 99) */
		reached[1][86] = 1;
		(trpt+1)->bup.ovals[1] = ((P1 *)this)->t;
		((P1 *)this)->t = 0;
#ifdef VAR_RANGES
		logval("writer:t", ((P1 *)this)->t);
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 43: /* STATE 87 - line 217 "pan.___" - [((t<2))] (0:0:0 - 1) */
		IfNotBlocked
		reached[1][87] = 1;
		if (!((((P1 *)this)->t<2)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 44: /* STATE 88 - line 220 "pan.___" - [((waitR[t]==0))] (96:0:2 - 1) */
		IfNotBlocked
		reached[1][88] = 1;
		if (!((now.waitR[ Index(((P1 *)this)->t, 2) ]==0)))
			continue;
		/* merge: countZeros = (countZeros+1)(96, 89, 96) */
		reached[1][89] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((P1 *)this)->countZeros;
		((P1 *)this)->countZeros = (((P1 *)this)->countZeros+1);
#ifdef VAR_RANGES
		logval("writer:countZeros", ((P1 *)this)->countZeros);
#endif
		;
		/* merge: .(goto)(96, 92, 96) */
		reached[1][92] = 1;
		;
		/* merge: t = (t+1)(96, 93, 96) */
		reached[1][93] = 1;
		(trpt+1)->bup.ovals[1] = ((P1 *)this)->t;
		((P1 *)this)->t = (((P1 *)this)->t+1);
#ifdef VAR_RANGES
		logval("writer:t", ((P1 *)this)->t);
#endif
		;
		/* merge: .(goto)(0, 97, 96) */
		reached[1][97] = 1;
		;
		_m = 3; goto P999; /* 4 */
	case 45: /* STATE 93 - line 223 "pan.___" - [t = (t+1)] (0:96:1 - 3) */
		IfNotBlocked
		reached[1][93] = 1;
		(trpt+1)->bup.oval = ((P1 *)this)->t;
		((P1 *)this)->t = (((P1 *)this)->t+1);
#ifdef VAR_RANGES
		logval("writer:t", ((P1 *)this)->t);
#endif
		;
		/* merge: .(goto)(0, 97, 96) */
		reached[1][97] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 46: /* STATE 100 - line 228 "pan.___" - [printf('MSC: %d > %d - %d \\n',countZeros,2,RW.OKtoRead.waiting)] (0:0:0 - 1) */
		IfNotBlocked
		reached[1][100] = 1;
		Printf("MSC: %d > %d - %d \n", ((P1 *)this)->countZeros, 2, now.RW.OKtoRead.waiting);
		_m = 3; goto P999; /* 0 */
	case 47: /* STATE 101 - line 231 "pan.___" - [((countZeros>(2-RW.OKtoRead.waiting)))] (111:0:1 - 1) */
		IfNotBlocked
		reached[1][101] = 1;
		if (!((((P1 *)this)->countZeros>(2-now.RW.OKtoRead.waiting))))
			continue;
		/* dead 1: countZeros */  (trpt+1)->bup.oval = ((P1 *)this)->countZeros;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P1 *)this)->countZeros = 0;
		/* merge: printf('MSC: signal(OKtoRead)\\n')(0, 102, 111) */
		reached[1][102] = 1;
		Printf("MSC: signal(OKtoRead)\n");
		_m = 3; goto P999; /* 1 */
	case 48: /* STATE 103 - line 112 "pan.___" - [((RW.OKtoRead.waiting>0))] (105:0:1 - 1) */
		IfNotBlocked
		reached[1][103] = 1;
		if (!((now.RW.OKtoRead.waiting>0)))
			continue;
		/* merge: RW.OKtoRead.gate = 1(0, 104, 105) */
		reached[1][104] = 1;
		(trpt+1)->bup.oval = ((int)now.RW.OKtoRead.gate);
		now.RW.OKtoRead.gate = 1;
#ifdef VAR_RANGES
		logval("RW.OKtoRead.gate", ((int)now.RW.OKtoRead.gate));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 49: /* STATE 105 - line 114 "pan.___" - [(!(lock))] (129:0:1 - 1) */
		IfNotBlocked
		reached[1][105] = 1;
		if (!( !(((int)now.lock))))
			continue;
		/* merge: lock = 1(129, 106, 129) */
		reached[1][106] = 1;
		(trpt+1)->bup.oval = ((int)now.lock);
		now.lock = 1;
#ifdef VAR_RANGES
		logval("lock", ((int)now.lock));
#endif
		;
		/* merge: .(goto)(129, 109, 129) */
		reached[1][109] = 1;
		;
		/* merge: .(goto)(129, 124, 129) */
		reached[1][124] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 50: /* STATE 109 - line 118 "pan.___" - [.(goto)] (0:129:0 - 2) */
		IfNotBlocked
		reached[1][109] = 1;
		;
		/* merge: .(goto)(129, 124, 129) */
		reached[1][124] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 51: /* STATE 124 - line 234 "pan.___" - [.(goto)] (0:129:0 - 2) */
		IfNotBlocked
		reached[1][124] = 1;
		;
		_m = 3; goto P999; /* 0 */
	case 52: /* STATE 113 - line 232 "pan.___" - [printf('MSC: signal(OKtoWrite)\\n')] (0:0:0 - 1) */
		IfNotBlocked
		reached[1][113] = 1;
		Printf("MSC: signal(OKtoWrite)\n");
		_m = 3; goto P999; /* 0 */
	case 53: /* STATE 114 - line 112 "pan.___" - [((RW.OKtoWrite.waiting>0))] (116:0:1 - 1) */
		IfNotBlocked
		reached[1][114] = 1;
		if (!((now.RW.OKtoWrite.waiting>0)))
			continue;
		/* merge: RW.OKtoWrite.gate = 1(0, 115, 116) */
		reached[1][115] = 1;
		(trpt+1)->bup.oval = ((int)now.RW.OKtoWrite.gate);
		now.RW.OKtoWrite.gate = 1;
#ifdef VAR_RANGES
		logval("RW.OKtoWrite.gate", ((int)now.RW.OKtoWrite.gate));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 54: /* STATE 116 - line 114 "pan.___" - [(!(lock))] (129:0:1 - 1) */
		IfNotBlocked
		reached[1][116] = 1;
		if (!( !(((int)now.lock))))
			continue;
		/* merge: lock = 1(129, 117, 129) */
		reached[1][117] = 1;
		(trpt+1)->bup.oval = ((int)now.lock);
		now.lock = 1;
#ifdef VAR_RANGES
		logval("lock", ((int)now.lock));
#endif
		;
		/* merge: .(goto)(129, 120, 129) */
		reached[1][120] = 1;
		;
		/* merge: .(goto)(129, 124, 129) */
		reached[1][124] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 55: /* STATE 120 - line 118 "pan.___" - [.(goto)] (0:129:0 - 2) */
		IfNotBlocked
		reached[1][120] = 1;
		;
		/* merge: .(goto)(129, 124, 129) */
		reached[1][124] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 56: /* STATE 126 - line 74 "pan.___" - [lock = 0] (0:131:1 - 1) */
		IfNotBlocked
		reached[1][126] = 1;
		(trpt+1)->bup.oval = ((int)now.lock);
		now.lock = 0;
#ifdef VAR_RANGES
		logval("lock", ((int)now.lock));
#endif
		;
		/* merge: printf('MSC: leaveMon()\\n')(131, 127, 131) */
		reached[1][127] = 1;
		Printf("MSC: leaveMon()\n");
		/* merge: .(goto)(0, 132, 131) */
		reached[1][132] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 57: /* STATE 134 - line 268 "pan.___" - [-end-] (0:0:0 - 1) */
		IfNotBlocked
		reached[1][134] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC reader */
	case 58: /* STATE 1 - line 64 "pan.___" - [(!(lock))] (6:0:1 - 1) */
		IfNotBlocked
		reached[0][1] = 1;
		if (!( !(((int)now.lock))))
			continue;
		/* merge: lock = 1(6, 2, 6) */
		reached[0][2] = 1;
		(trpt+1)->bup.oval = ((int)now.lock);
		now.lock = 1;
#ifdef VAR_RANGES
		logval("lock", ((int)now.lock));
#endif
		;
		/* merge: printf('MSC: enterMon()\\n')(6, 3, 6) */
		reached[0][3] = 1;
		Printf("MSC: enterMon()\n");
		_m = 3; goto P999; /* 2 */
	case 59: /* STATE 6 - line 132 "pan.___" - [wantR[i] = 1] (0:0:1 - 1) */
		IfNotBlocked
		reached[0][6] = 1;
		(trpt+1)->bup.oval = ((int)now.wantR[ Index(((P0 *)this)->i, 2) ]);
		now.wantR[ Index(((P0 *)this)->i, 2) ] = 1;
#ifdef VAR_RANGES
		logval("wantR[reader:i]", ((int)now.wantR[ Index(((P0 *)this)->i, 2) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 60: /* STATE 7 - line 133 "pan.___" - [wantR[i] = 0] (0:0:1 - 1) */
		IfNotBlocked
		reached[0][7] = 1;
		(trpt+1)->bup.oval = ((int)now.wantR[ Index(((P0 *)this)->i, 2) ]);
		now.wantR[ Index(((P0 *)this)->i, 2) ] = 0;
#ifdef VAR_RANGES
		logval("wantR[reader:i]", ((int)now.wantR[ Index(((P0 *)this)->i, 2) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 61: /* STATE 8 - line 134 "pan.___" - [printf('MSC: startRead\\n')] (0:0:0 - 1) */
		IfNotBlocked
		reached[0][8] = 1;
		Printf("MSC: startRead\n");
		_m = 3; goto P999; /* 0 */
	case 62: /* STATE 9 - line 135 "pan.___" - [waitR[i] = RW.OKtoWrite.waiting] (0:0:1 - 1) */
		IfNotBlocked
		reached[0][9] = 1;
		(trpt+1)->bup.oval = now.waitR[ Index(((P0 *)this)->i, 2) ];
		now.waitR[ Index(((P0 *)this)->i, 2) ] = now.RW.OKtoWrite.waiting;
#ifdef VAR_RANGES
		logval("waitR[reader:i]", now.waitR[ Index(((P0 *)this)->i, 2) ]);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 63: /* STATE 10 - line 138 "pan.___" - [(((RW.writers!=0)||!((RW.OKtoWrite.waiting==0))))] (21:0:0 - 1) */
		IfNotBlocked
		reached[0][10] = 1;
		if (!(((now.RW.writers!=0)|| !((now.RW.OKtoWrite.waiting==0)))))
			continue;
		/* merge: printf('MSC: wait(OKtoRead)\\n')(0, 11, 21) */
		reached[0][11] = 1;
		Printf("MSC: wait(OKtoRead)\n");
		_m = 3; goto P999; /* 1 */
	case 64: /* STATE 12 - line 84 "pan.___" - [RW.OKtoRead.waiting = (RW.OKtoRead.waiting+1)] (0:14:2 - 1) */
		IfNotBlocked
		reached[0][12] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = now.RW.OKtoRead.waiting;
		now.RW.OKtoRead.waiting = (now.RW.OKtoRead.waiting+1);
#ifdef VAR_RANGES
		logval("RW.OKtoRead.waiting", now.RW.OKtoRead.waiting);
#endif
		;
		/* merge: lock = 0(14, 13, 14) */
		reached[0][13] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.lock);
		now.lock = 0;
#ifdef VAR_RANGES
		logval("lock", ((int)now.lock));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 65: /* STATE 14 - line 86 "pan.___" - [(!(waitR[i]))] (16:0:0 - 1) */
		IfNotBlocked
		reached[0][14] = 1;
		if (!( !(now.waitR[ Index(((P0 *)this)->i, 2) ])))
			continue;
		/* merge: printf('MSC: my turn! wait for gate\\n')(0, 15, 16) */
		reached[0][15] = 1;
		Printf("MSC: my turn! wait for gate\n");
		_m = 3; goto P999; /* 1 */
	case 66: /* STATE 16 - line 88 "pan.___" - [(RW.OKtoRead.gate)] (27:0:2 - 1) */
		IfNotBlocked
		reached[0][16] = 1;
		if (!(((int)now.RW.OKtoRead.gate)))
			continue;
		/* merge: RW.OKtoRead.gate = 0(27, 17, 27) */
		reached[0][17] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)now.RW.OKtoRead.gate);
		now.RW.OKtoRead.gate = 0;
#ifdef VAR_RANGES
		logval("RW.OKtoRead.gate", ((int)now.RW.OKtoRead.gate));
#endif
		;
		/* merge: RW.OKtoRead.waiting = (RW.OKtoRead.waiting-1)(27, 18, 27) */
		reached[0][18] = 1;
		(trpt+1)->bup.ovals[1] = now.RW.OKtoRead.waiting;
		now.RW.OKtoRead.waiting = (now.RW.OKtoRead.waiting-1);
#ifdef VAR_RANGES
		logval("RW.OKtoRead.waiting", now.RW.OKtoRead.waiting);
#endif
		;
		/* merge: printf('MSC: received gate\\n')(27, 19, 27) */
		reached[0][19] = 1;
		Printf("MSC: received gate\n");
		/* merge: .(goto)(27, 24, 27) */
		reached[0][24] = 1;
		;
		/* merge: printf('MSC: go read\\n')(27, 26, 27) */
		reached[0][26] = 1;
		Printf("MSC: go read\n");
		_m = 3; goto P999; /* 5 */
	case 67: /* STATE 24 - line 141 "pan.___" - [.(goto)] (0:27:0 - 2) */
		IfNotBlocked
		reached[0][24] = 1;
		;
		/* merge: printf('MSC: go read\\n')(27, 26, 27) */
		reached[0][26] = 1;
		Printf("MSC: go read\n");
		_m = 3; goto P999; /* 1 */
	case 68: /* STATE 27 - line 143 "pan.___" - [RW.readers = (RW.readers+1)] (0:0:1 - 1) */
		IfNotBlocked
		reached[0][27] = 1;
		(trpt+1)->bup.oval = now.RW.readers;
		now.RW.readers = (now.RW.readers+1);
#ifdef VAR_RANGES
		logval("RW.readers", now.RW.readers);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 69: /* STATE 28 - line 147 "pan.___" - [cZeros = 0] (0:43:2 - 1) */
		IfNotBlocked
		reached[0][28] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((P0 *)this)->cZeros;
		((P0 *)this)->cZeros = 0;
#ifdef VAR_RANGES
		logval("reader:cZeros", ((P0 *)this)->cZeros);
#endif
		;
		/* merge: p = 0(43, 29, 43) */
		reached[0][29] = 1;
		(trpt+1)->bup.ovals[1] = ((P0 *)this)->p;
		((P0 *)this)->p = 0;
#ifdef VAR_RANGES
		logval("reader:p", ((P0 *)this)->p);
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 70: /* STATE 30 - line 152 "pan.___" - [((p<2))] (0:0:0 - 1) */
		IfNotBlocked
		reached[0][30] = 1;
		if (!((((P0 *)this)->p<2)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 71: /* STATE 31 - line 155 "pan.___" - [((waitR[p]==0))] (39:0:2 - 1) */
		IfNotBlocked
		reached[0][31] = 1;
		if (!((now.waitR[ Index(((P0 *)this)->p, 2) ]==0)))
			continue;
		/* merge: cZeros = (cZeros+1)(39, 32, 39) */
		reached[0][32] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((P0 *)this)->cZeros;
		((P0 *)this)->cZeros = (((P0 *)this)->cZeros+1);
#ifdef VAR_RANGES
		logval("reader:cZeros", ((P0 *)this)->cZeros);
#endif
		;
		/* merge: .(goto)(39, 35, 39) */
		reached[0][35] = 1;
		;
		/* merge: p = (p+1)(39, 36, 39) */
		reached[0][36] = 1;
		(trpt+1)->bup.ovals[1] = ((P0 *)this)->p;
		((P0 *)this)->p = (((P0 *)this)->p+1);
#ifdef VAR_RANGES
		logval("reader:p", ((P0 *)this)->p);
#endif
		;
		/* merge: .(goto)(0, 40, 39) */
		reached[0][40] = 1;
		;
		_m = 3; goto P999; /* 4 */
	case 72: /* STATE 36 - line 158 "pan.___" - [p = (p+1)] (0:39:1 - 3) */
		IfNotBlocked
		reached[0][36] = 1;
		(trpt+1)->bup.oval = ((P0 *)this)->p;
		((P0 *)this)->p = (((P0 *)this)->p+1);
#ifdef VAR_RANGES
		logval("reader:p", ((P0 *)this)->p);
#endif
		;
		/* merge: .(goto)(0, 40, 39) */
		reached[0][40] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 73: /* STATE 42 - line 161 "pan.___" - [printf('MSC: %d-(%d-%d) > 0?\\n',cZeros,2,RW.OKtoRead.waiting)] (0:0:0 - 1) */
		IfNotBlocked
		reached[0][42] = 1;
		Printf("MSC: %d-(%d-%d) > 0?\n", ((P0 *)this)->cZeros, 2, now.RW.OKtoRead.waiting);
		_m = 3; goto P999; /* 0 */
	case 74: /* STATE 44 - line 164 "pan.___" - [(((cZeros-(2-RW.OKtoRead.waiting))>0))] (0:0:1 - 1) */
		IfNotBlocked
		reached[0][44] = 1;
		if (!(((((P0 *)this)->cZeros-(2-now.RW.OKtoRead.waiting))>0)))
			continue;
		/* dead 1: cZeros */  (trpt+1)->bup.oval = ((P0 *)this)->cZeros;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P0 *)this)->cZeros = 0;
		_m = 3; goto P999; /* 0 */
	case 75: /* STATE 45 - line 165 "pan.___" - [printf('MSC: signal(OKtoRead)\\n')] (0:0:0 - 1) */
		IfNotBlocked
		reached[0][45] = 1;
		Printf("MSC: signal(OKtoRead)\n");
		_m = 3; goto P999; /* 0 */
	case 76: /* STATE 46 - line 112 "pan.___" - [((RW.OKtoRead.waiting>0))] (48:0:1 - 1) */
		IfNotBlocked
		reached[0][46] = 1;
		if (!((now.RW.OKtoRead.waiting>0)))
			continue;
		/* merge: RW.OKtoRead.gate = 1(0, 47, 48) */
		reached[0][47] = 1;
		(trpt+1)->bup.oval = ((int)now.RW.OKtoRead.gate);
		now.RW.OKtoRead.gate = 1;
#ifdef VAR_RANGES
		logval("RW.OKtoRead.gate", ((int)now.RW.OKtoRead.gate));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 77: /* STATE 48 - line 114 "pan.___" - [(!(lock))] (73:0:1 - 1) */
		IfNotBlocked
		reached[0][48] = 1;
		if (!( !(((int)now.lock))))
			continue;
		/* merge: lock = 1(73, 49, 73) */
		reached[0][49] = 1;
		(trpt+1)->bup.oval = ((int)now.lock);
		now.lock = 1;
#ifdef VAR_RANGES
		logval("lock", ((int)now.lock));
#endif
		;
		/* merge: .(goto)(73, 52, 73) */
		reached[0][52] = 1;
		;
		/* merge: .(goto)(0, 57, 73) */
		reached[0][57] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 78: /* STATE 52 - line 118 "pan.___" - [.(goto)] (0:73:0 - 2) */
		IfNotBlocked
		reached[0][52] = 1;
		;
		/* merge: .(goto)(0, 57, 73) */
		reached[0][57] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 79: /* STATE 58 - line 24 "pan.___" - [num = 0] (0:0:1 - 1) */
		IfNotBlocked
		reached[0][58] = 1;
		(trpt+1)->bup.oval = now.num;
		now.num = 0;
#ifdef VAR_RANGES
		logval("num", now.num);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 80: /* STATE 59 - line 26 "pan.___" - [((num<2))] (0:0:0 - 1) */
		IfNotBlocked
		reached[0][59] = 1;
		if (!((now.num<2)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 81: /* STATE 60 - line 29 "pan.___" - [((waitW[num]>0))] (69:0:2 - 1) */
		IfNotBlocked
		reached[0][60] = 1;
		if (!((now.waitW[ Index(now.num, 2) ]>0)))
			continue;
		/* merge: waitW[num] = (waitW[num]-1)(69, 61, 69) */
		reached[0][61] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = now.waitW[ Index(now.num, 2) ];
		now.waitW[ Index(now.num, 2) ] = (now.waitW[ Index(now.num, 2) ]-1);
#ifdef VAR_RANGES
		logval("waitW[num]", now.waitW[ Index(now.num, 2) ]);
#endif
		;
		/* merge: .(goto)(69, 64, 69) */
		reached[0][64] = 1;
		;
		/* merge: num = (num+1)(69, 65, 69) */
		reached[0][65] = 1;
		(trpt+1)->bup.ovals[1] = now.num;
		now.num = (now.num+1);
#ifdef VAR_RANGES
		logval("num", now.num);
#endif
		;
		/* merge: .(goto)(0, 70, 69) */
		reached[0][70] = 1;
		;
		_m = 3; goto P999; /* 4 */
	case 82: /* STATE 65 - line 32 "pan.___" - [num = (num+1)] (0:69:1 - 3) */
		IfNotBlocked
		reached[0][65] = 1;
		(trpt+1)->bup.oval = now.num;
		now.num = (now.num+1);
#ifdef VAR_RANGES
		logval("num", now.num);
#endif
		;
		/* merge: .(goto)(0, 70, 69) */
		reached[0][70] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 83: /* STATE 67 - line 34 "pan.___" - [printf('MSC: [array]--\\n')] (0:71:0 - 1) */
		IfNotBlocked
		reached[0][67] = 1;
		Printf("MSC: [array]--\n");
		/* merge: goto :b2(71, 68, 71) */
		reached[0][68] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 84: /* STATE 74 - line 74 "pan.___" - [lock = 0] (0:80:1 - 1) */
		IfNotBlocked
		reached[0][74] = 1;
		(trpt+1)->bup.oval = ((int)now.lock);
		now.lock = 0;
#ifdef VAR_RANGES
		logval("lock", ((int)now.lock));
#endif
		;
		/* merge: printf('MSC: leaveMon()\\n')(80, 75, 80) */
		reached[0][75] = 1;
		Printf("MSC: leaveMon()\n");
		/* merge: printf('MSC: ==CS== begin\\n')(80, 79, 80) */
		reached[0][79] = 1;
		Printf("MSC: ==CS== begin\n");
		_m = 3; goto P999; /* 2 */
	case 85: /* STATE 80 - line 243 "pan.___" - [critR[i] = 1] (0:0:1 - 1) */
		IfNotBlocked
		reached[0][80] = 1;
		(trpt+1)->bup.oval = ((int)now.critR[ Index(((P0 *)this)->i, 2) ]);
		now.critR[ Index(((P0 *)this)->i, 2) ] = 1;
#ifdef VAR_RANGES
		logval("critR[reader:i]", ((int)now.critR[ Index(((P0 *)this)->i, 2) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 86: /* STATE 81 - line 244 "pan.___" - [crR = (crR+1)] (0:0:1 - 1) */
		IfNotBlocked
		reached[0][81] = 1;
		(trpt+1)->bup.oval = crR;
		crR = (crR+1);
#ifdef VAR_RANGES
		logval("crR", crR);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 87: /* STATE 82 - line 245 "pan.___" - [crR = (crR-1)] (0:0:1 - 1) */
		IfNotBlocked
		reached[0][82] = 1;
		(trpt+1)->bup.oval = crR;
		crR = (crR-1);
#ifdef VAR_RANGES
		logval("crR", crR);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 88: /* STATE 83 - line 246 "pan.___" - [critR[i] = 0] (0:0:1 - 1) */
		IfNotBlocked
		reached[0][83] = 1;
		(trpt+1)->bup.oval = ((int)now.critR[ Index(((P0 *)this)->i, 2) ]);
		now.critR[ Index(((P0 *)this)->i, 2) ] = 0;
#ifdef VAR_RANGES
		logval("critR[reader:i]", ((int)now.critR[ Index(((P0 *)this)->i, 2) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 89: /* STATE 84 - line 247 "pan.___" - [printf('MSC: ==CS== end\\n')] (0:0:0 - 1) */
		IfNotBlocked
		reached[0][84] = 1;
		Printf("MSC: ==CS== end\n");
		_m = 3; goto P999; /* 0 */
	case 90: /* STATE 85 - line 64 "pan.___" - [(!(lock))] (91:0:1 - 1) */
		IfNotBlocked
		reached[0][85] = 1;
		if (!( !(((int)now.lock))))
			continue;
		/* merge: lock = 1(91, 86, 91) */
		reached[0][86] = 1;
		(trpt+1)->bup.oval = ((int)now.lock);
		now.lock = 1;
#ifdef VAR_RANGES
		logval("lock", ((int)now.lock));
#endif
		;
		/* merge: printf('MSC: enterMon()\\n')(91, 87, 91) */
		reached[0][87] = 1;
		Printf("MSC: enterMon()\n");
		/* merge: printf('MSC: EndRead\\n')(91, 90, 91) */
		reached[0][90] = 1;
		Printf("MSC: EndRead\n");
		_m = 3; goto P999; /* 3 */
	case 91: /* STATE 91 - line 196 "pan.___" - [RW.readers = (RW.readers-1)] (0:0:1 - 1) */
		IfNotBlocked
		reached[0][91] = 1;
		(trpt+1)->bup.oval = now.RW.readers;
		now.RW.readers = (now.RW.readers-1);
#ifdef VAR_RANGES
		logval("RW.readers", now.RW.readers);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 92: /* STATE 92 - line 199 "pan.___" - [((RW.readers==0))] (102:0:0 - 1) */
		IfNotBlocked
		reached[0][92] = 1;
		if (!((now.RW.readers==0)))
			continue;
		/* merge: printf('MSC: signal(OKtoWrite)\\n')(0, 93, 102) */
		reached[0][93] = 1;
		Printf("MSC: signal(OKtoWrite)\n");
		_m = 3; goto P999; /* 1 */
	case 93: /* STATE 94 - line 112 "pan.___" - [((RW.OKtoWrite.waiting>0))] (96:0:1 - 1) */
		IfNotBlocked
		reached[0][94] = 1;
		if (!((now.RW.OKtoWrite.waiting>0)))
			continue;
		/* merge: RW.OKtoWrite.gate = 1(0, 95, 96) */
		reached[0][95] = 1;
		(trpt+1)->bup.oval = ((int)now.RW.OKtoWrite.gate);
		now.RW.OKtoWrite.gate = 1;
#ifdef VAR_RANGES
		logval("RW.OKtoWrite.gate", ((int)now.RW.OKtoWrite.gate));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 94: /* STATE 96 - line 114 "pan.___" - [(!(lock))] (110:0:1 - 1) */
		IfNotBlocked
		reached[0][96] = 1;
		if (!( !(((int)now.lock))))
			continue;
		/* merge: lock = 1(110, 97, 110) */
		reached[0][97] = 1;
		(trpt+1)->bup.oval = ((int)now.lock);
		now.lock = 1;
#ifdef VAR_RANGES
		logval("lock", ((int)now.lock));
#endif
		;
		/* merge: .(goto)(110, 100, 110) */
		reached[0][100] = 1;
		;
		/* merge: .(goto)(110, 105, 110) */
		reached[0][105] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 95: /* STATE 100 - line 118 "pan.___" - [.(goto)] (0:110:0 - 2) */
		IfNotBlocked
		reached[0][100] = 1;
		;
		/* merge: .(goto)(110, 105, 110) */
		reached[0][105] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 96: /* STATE 105 - line 202 "pan.___" - [.(goto)] (0:110:0 - 2) */
		IfNotBlocked
		reached[0][105] = 1;
		;
		_m = 3; goto P999; /* 0 */
	case 97: /* STATE 107 - line 74 "pan.___" - [lock = 0] (0:112:1 - 1) */
		IfNotBlocked
		reached[0][107] = 1;
		(trpt+1)->bup.oval = ((int)now.lock);
		now.lock = 0;
#ifdef VAR_RANGES
		logval("lock", ((int)now.lock));
#endif
		;
		/* merge: printf('MSC: leaveMon()\\n')(112, 108, 112) */
		reached[0][108] = 1;
		Printf("MSC: leaveMon()\n");
		/* merge: .(goto)(0, 113, 112) */
		reached[0][113] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 98: /* STATE 115 - line 250 "pan.___" - [-end-] (0:0:0 - 1) */
		IfNotBlocked
		reached[0][115] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

