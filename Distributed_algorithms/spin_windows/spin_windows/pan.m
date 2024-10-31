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

		 /* PROC :init: */
	case 3: /* STATE 1 - line 31 "pan_in" - [i = 0] (0:12:3 - 1) */
		IfNotBlocked
		reached[3][1] = 1;
		(trpt+1)->bup.ovals = grab_ints(3);
		(trpt+1)->bup.ovals[0] = now.i;
		now.i = 0;
#ifdef VAR_RANGES
		logval("i", now.i);
#endif
		;
		/* merge: j = 0(12, 2, 12) */
		reached[3][2] = 1;
		(trpt+1)->bup.ovals[1] = now.j;
		now.j = 0;
#ifdef VAR_RANGES
		logval("j", now.j);
#endif
		;
		/* merge: mj = 0(12, 3, 12) */
		reached[3][3] = 1;
		(trpt+1)->bup.ovals[2] = ((P3 *)this)->mj;
		((P3 *)this)->mj = 0;
#ifdef VAR_RANGES
		logval(":init::mj", ((P3 *)this)->mj);
#endif
		;
		/* merge: .(goto)(0, 13, 12) */
		reached[3][13] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 4: /* STATE 4 - line 33 "pan_in" - [((j<(10-1)))] (51:0:1 - 1) */
		IfNotBlocked
		reached[3][4] = 1;
		if (!((now.j<(10-1))))
			continue;
		/* merge: mj = j(51, 5, 51) */
		reached[3][5] = 1;
		(trpt+1)->bup.oval = ((P3 *)this)->mj;
		((P3 *)this)->mj = now.j;
#ifdef VAR_RANGES
		logval(":init::mj", ((P3 *)this)->mj);
#endif
		;
		/* merge: goto :b3(51, 6, 51) */
		reached[3][6] = 1;
		;
		/* merge: printf('MSC:  magic value %d \\n',mj)(51, 15, 51) */
		reached[3][15] = 1;
		Printf("MSC:  magic value %d \n", ((P3 *)this)->mj);
		/* merge: printf('MSC: A\\n')(51, 17, 51) */
		reached[3][17] = 1;
		Printf("MSC: A\n");
		_m = 3; goto P999; /* 4 */
	case 5: /* STATE 7 - line 34 "pan_in" - [((j<(10-1)))] (12:0:1 - 1) */
		IfNotBlocked
		reached[3][7] = 1;
		if (!((now.j<(10-1))))
			continue;
		/* merge: j = (j+1)(0, 8, 12) */
		reached[3][8] = 1;
		(trpt+1)->bup.oval = now.j;
		now.j = (now.j+1);
#ifdef VAR_RANGES
		logval("j", now.j);
#endif
		;
		/* merge: .(goto)(0, 13, 12) */
		reached[3][13] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 6: /* STATE 10 - line 35 "pan_in" - [mj = j] (0:51:1 - 1) */
		IfNotBlocked
		reached[3][10] = 1;
		(trpt+1)->bup.oval = ((P3 *)this)->mj;
		((P3 *)this)->mj = now.j;
#ifdef VAR_RANGES
		logval(":init::mj", ((P3 *)this)->mj);
#endif
		;
		/* merge: goto :b3(51, 11, 51) */
		reached[3][11] = 1;
		;
		/* merge: printf('MSC:  magic value %d \\n',mj)(51, 15, 51) */
		reached[3][15] = 1;
		Printf("MSC:  magic value %d \n", ((P3 *)this)->mj);
		/* merge: printf('MSC: A\\n')(51, 17, 51) */
		reached[3][17] = 1;
		Printf("MSC: A\n");
		_m = 3; goto P999; /* 3 */
	case 7: /* STATE 15 - line 38 "pan_in" - [printf('MSC:  magic value %d \\n',mj)] (0:51:0 - 5) */
		IfNotBlocked
		reached[3][15] = 1;
		Printf("MSC:  magic value %d \n", ((P3 *)this)->mj);
		/* merge: printf('MSC: A\\n')(51, 17, 51) */
		reached[3][17] = 1;
		Printf("MSC: A\n");
		_m = 3; goto P999; /* 1 */
	case 8: /* STATE 18 - line 12 "pan_in" - [i = 0] (0:48:2 - 1) */
		IfNotBlocked
		reached[3][18] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = now.i;
		now.i = 0;
#ifdef VAR_RANGES
		logval("i", now.i);
#endif
		;
		/* merge: j = 0(48, 19, 48) */
		reached[3][19] = 1;
		(trpt+1)->bup.ovals[1] = now.j;
		now.j = 0;
#ifdef VAR_RANGES
		logval("j", now.j);
#endif
		;
		/* merge: .(goto)(0, 49, 48) */
		reached[3][49] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 9: /* STATE 20 - line 14 "pan_in" - [(((i==(5-1))&&(j<mj)))] (86:0:1 - 1) */
		IfNotBlocked
		reached[3][20] = 1;
		if (!(((now.i==(5-1))&&(now.j<((P3 *)this)->mj))))
			continue;
		/* merge: a[i] = mj(86, 21, 86) */
		reached[3][21] = 1;
		(trpt+1)->bup.oval = now.a[ Index(now.i, 5) ];
		now.a[ Index(now.i, 5) ] = ((P3 *)this)->mj;
#ifdef VAR_RANGES
		logval("a[i]", now.a[ Index(now.i, 5) ]);
#endif
		;
		/* merge: goto :b4(86, 22, 86) */
		reached[3][22] = 1;
		;
		/* merge: printf('MSC: B\\n')(86, 52, 86) */
		reached[3][52] = 1;
		Printf("MSC: B\n");
		_m = 3; goto P999; /* 3 */
	case 10: /* STATE 23 - line 15 "pan_in" - [((i==5))] (86:0:0 - 1) */
		IfNotBlocked
		reached[3][23] = 1;
		if (!((now.i==5)))
			continue;
		/* merge: goto :b4(86, 24, 86) */
		reached[3][24] = 1;
		;
		/* merge: printf('MSC: B\\n')(86, 52, 86) */
		reached[3][52] = 1;
		Printf("MSC: B\n");
		_m = 3; goto P999; /* 2 */
	case 11: /* STATE 26 - line 18 "pan_in" - [((j!=mj))] (0:0:0 - 1) */
		IfNotBlocked
		reached[3][26] = 1;
		if (!((now.j!=((P3 *)this)->mj)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 12: /* STATE 27 - line 20 "pan_in" - [(((i<5)&&(j<(10-5))))] (48:0:3 - 1) */
		IfNotBlocked
		reached[3][27] = 1;
		if (!(((now.i<5)&&(now.j<(10-5)))))
			continue;
		/* merge: a[i] = j(48, 28, 48) */
		reached[3][28] = 1;
		(trpt+1)->bup.ovals = grab_ints(3);
		(trpt+1)->bup.ovals[0] = now.a[ Index(now.i, 5) ];
		now.a[ Index(now.i, 5) ] = now.j;
#ifdef VAR_RANGES
		logval("a[i]", now.a[ Index(now.i, 5) ]);
#endif
		;
		/* merge: printf('MSC: %d %d\\n',i,a[i])(48, 29, 48) */
		reached[3][29] = 1;
		Printf("MSC: %d %d\n", now.i, now.a[ Index(now.i, 5) ]);
		/* merge: i = (i+1)(48, 30, 48) */
		reached[3][30] = 1;
		(trpt+1)->bup.ovals[1] = now.i;
		now.i = (now.i+1);
#ifdef VAR_RANGES
		logval("i", now.i);
#endif
		;
		/* merge: j = (j+1)(48, 31, 48) */
		reached[3][31] = 1;
		(trpt+1)->bup.ovals[2] = now.j;
		now.j = (now.j+1);
#ifdef VAR_RANGES
		logval("j", now.j);
#endif
		;
		/* merge: .(goto)(0, 40, 48) */
		reached[3][40] = 1;
		;
		/* merge: .(goto)(0, 47, 48) */
		reached[3][47] = 1;
		;
		/* merge: .(goto)(0, 49, 48) */
		reached[3][49] = 1;
		;
		_m = 3; goto P999; /* 7 */
	case 13: /* STATE 32 - line 21 "pan_in" - [(((i<5)&&(j<(10-5))))] (48:0:1 - 1) */
		IfNotBlocked
		reached[3][32] = 1;
		if (!(((now.i<5)&&(now.j<(10-5)))))
			continue;
		/* merge: j = (j+1)(0, 33, 48) */
		reached[3][33] = 1;
		(trpt+1)->bup.oval = now.j;
		now.j = (now.j+1);
#ifdef VAR_RANGES
		logval("j", now.j);
#endif
		;
		/* merge: .(goto)(0, 40, 48) */
		reached[3][40] = 1;
		;
		/* merge: .(goto)(0, 47, 48) */
		reached[3][47] = 1;
		;
		/* merge: .(goto)(0, 49, 48) */
		reached[3][49] = 1;
		;
		_m = 3; goto P999; /* 4 */
	case 14: /* STATE 35 - line 22 "pan_in" - [a[i] = j] (0:48:3 - 1) */
		IfNotBlocked
		reached[3][35] = 1;
		(trpt+1)->bup.ovals = grab_ints(3);
		(trpt+1)->bup.ovals[0] = now.a[ Index(now.i, 5) ];
		now.a[ Index(now.i, 5) ] = now.j;
#ifdef VAR_RANGES
		logval("a[i]", now.a[ Index(now.i, 5) ]);
#endif
		;
		/* merge: printf('MSC: %d %d\\n',i,a[i])(48, 36, 48) */
		reached[3][36] = 1;
		Printf("MSC: %d %d\n", now.i, now.a[ Index(now.i, 5) ]);
		/* merge: i = (i+1)(48, 37, 48) */
		reached[3][37] = 1;
		(trpt+1)->bup.ovals[1] = now.i;
		now.i = (now.i+1);
#ifdef VAR_RANGES
		logval("i", now.i);
#endif
		;
		/* merge: j = (j+1)(48, 38, 48) */
		reached[3][38] = 1;
		(trpt+1)->bup.ovals[2] = now.j;
		now.j = (now.j+1);
#ifdef VAR_RANGES
		logval("j", now.j);
#endif
		;
		/* merge: .(goto)(0, 40, 48) */
		reached[3][40] = 1;
		;
		/* merge: .(goto)(0, 47, 48) */
		reached[3][47] = 1;
		;
		/* merge: .(goto)(0, 49, 48) */
		reached[3][49] = 1;
		;
		_m = 3; goto P999; /* 6 */
	case 15: /* STATE 41 - line 24 "pan_in" - [((j==mj))] (48:0:3 - 1) */
		IfNotBlocked
		reached[3][41] = 1;
		if (!((now.j==((P3 *)this)->mj)))
			continue;
		/* merge: a[i] = mj(48, 42, 48) */
		reached[3][42] = 1;
		(trpt+1)->bup.ovals = grab_ints(3);
		(trpt+1)->bup.ovals[0] = now.a[ Index(now.i, 5) ];
		now.a[ Index(now.i, 5) ] = ((P3 *)this)->mj;
#ifdef VAR_RANGES
		logval("a[i]", now.a[ Index(now.i, 5) ]);
#endif
		;
		/* merge: printf('MSC: %d %d\\n',i,a[i])(48, 43, 48) */
		reached[3][43] = 1;
		Printf("MSC: %d %d\n", now.i, now.a[ Index(now.i, 5) ]);
		/* merge: i = (i+1)(48, 44, 48) */
		reached[3][44] = 1;
		(trpt+1)->bup.ovals[1] = now.i;
		now.i = (now.i+1);
#ifdef VAR_RANGES
		logval("i", now.i);
#endif
		;
		/* merge: j = (j+1)(48, 45, 48) */
		reached[3][45] = 1;
		(trpt+1)->bup.ovals[2] = now.j;
		now.j = (now.j+1);
#ifdef VAR_RANGES
		logval("j", now.j);
#endif
		;
		/* merge: .(goto)(0, 47, 48) */
		reached[3][47] = 1;
		;
		/* merge: .(goto)(0, 49, 48) */
		reached[3][49] = 1;
		;
		_m = 3; goto P999; /* 6 */
	case 16: /* STATE 52 - line 109 "pan_in" - [printf('MSC: B\\n')] (0:86:0 - 5) */
		IfNotBlocked
		reached[3][52] = 1;
		Printf("MSC: B\n");
		_m = 3; goto P999; /* 0 */
	case 17: /* STATE 53 - line 12 "pan_in" - [i = 0] (0:83:2 - 1) */
		IfNotBlocked
		reached[3][53] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = now.i;
		now.i = 0;
#ifdef VAR_RANGES
		logval("i", now.i);
#endif
		;
		/* merge: j = 0(83, 54, 83) */
		reached[3][54] = 1;
		(trpt+1)->bup.ovals[1] = now.j;
		now.j = 0;
#ifdef VAR_RANGES
		logval("j", now.j);
#endif
		;
		/* merge: .(goto)(0, 84, 83) */
		reached[3][84] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 18: /* STATE 55 - line 14 "pan_in" - [(((i==(5-1))&&(j<mj)))] (121:0:1 - 1) */
		IfNotBlocked
		reached[3][55] = 1;
		if (!(((now.i==(5-1))&&(now.j<((P3 *)this)->mj))))
			continue;
		/* merge: b[i] = mj(121, 56, 121) */
		reached[3][56] = 1;
		(trpt+1)->bup.oval = now.b[ Index(now.i, 5) ];
		now.b[ Index(now.i, 5) ] = ((P3 *)this)->mj;
#ifdef VAR_RANGES
		logval("b[i]", now.b[ Index(now.i, 5) ]);
#endif
		;
		/* merge: goto :b5(121, 57, 121) */
		reached[3][57] = 1;
		;
		/* merge: printf('MSC: C\\n')(121, 87, 121) */
		reached[3][87] = 1;
		Printf("MSC: C\n");
		_m = 3; goto P999; /* 3 */
	case 19: /* STATE 58 - line 15 "pan_in" - [((i==5))] (121:0:0 - 1) */
		IfNotBlocked
		reached[3][58] = 1;
		if (!((now.i==5)))
			continue;
		/* merge: goto :b5(121, 59, 121) */
		reached[3][59] = 1;
		;
		/* merge: printf('MSC: C\\n')(121, 87, 121) */
		reached[3][87] = 1;
		Printf("MSC: C\n");
		_m = 3; goto P999; /* 2 */
/* STATE 61 - line 18 "pan_in" - [((j!=mj))] (0:0 - 1) same as 11 (0:0 - 1) */
	case 20: /* STATE 62 - line 20 "pan_in" - [(((i<5)&&(j<(10-5))))] (83:0:3 - 1) */
		IfNotBlocked
		reached[3][62] = 1;
		if (!(((now.i<5)&&(now.j<(10-5)))))
			continue;
		/* merge: b[i] = j(83, 63, 83) */
		reached[3][63] = 1;
		(trpt+1)->bup.ovals = grab_ints(3);
		(trpt+1)->bup.ovals[0] = now.b[ Index(now.i, 5) ];
		now.b[ Index(now.i, 5) ] = now.j;
#ifdef VAR_RANGES
		logval("b[i]", now.b[ Index(now.i, 5) ]);
#endif
		;
		/* merge: printf('MSC: %d %d\\n',i,b[i])(83, 64, 83) */
		reached[3][64] = 1;
		Printf("MSC: %d %d\n", now.i, now.b[ Index(now.i, 5) ]);
		/* merge: i = (i+1)(83, 65, 83) */
		reached[3][65] = 1;
		(trpt+1)->bup.ovals[1] = now.i;
		now.i = (now.i+1);
#ifdef VAR_RANGES
		logval("i", now.i);
#endif
		;
		/* merge: j = (j+1)(83, 66, 83) */
		reached[3][66] = 1;
		(trpt+1)->bup.ovals[2] = now.j;
		now.j = (now.j+1);
#ifdef VAR_RANGES
		logval("j", now.j);
#endif
		;
		/* merge: .(goto)(0, 75, 83) */
		reached[3][75] = 1;
		;
		/* merge: .(goto)(0, 82, 83) */
		reached[3][82] = 1;
		;
		/* merge: .(goto)(0, 84, 83) */
		reached[3][84] = 1;
		;
		_m = 3; goto P999; /* 7 */
	case 21: /* STATE 67 - line 21 "pan_in" - [(((i<5)&&(j<(10-5))))] (83:0:1 - 1) */
		IfNotBlocked
		reached[3][67] = 1;
		if (!(((now.i<5)&&(now.j<(10-5)))))
			continue;
		/* merge: j = (j+1)(0, 68, 83) */
		reached[3][68] = 1;
		(trpt+1)->bup.oval = now.j;
		now.j = (now.j+1);
#ifdef VAR_RANGES
		logval("j", now.j);
#endif
		;
		/* merge: .(goto)(0, 75, 83) */
		reached[3][75] = 1;
		;
		/* merge: .(goto)(0, 82, 83) */
		reached[3][82] = 1;
		;
		/* merge: .(goto)(0, 84, 83) */
		reached[3][84] = 1;
		;
		_m = 3; goto P999; /* 4 */
	case 22: /* STATE 70 - line 22 "pan_in" - [b[i] = j] (0:83:3 - 1) */
		IfNotBlocked
		reached[3][70] = 1;
		(trpt+1)->bup.ovals = grab_ints(3);
		(trpt+1)->bup.ovals[0] = now.b[ Index(now.i, 5) ];
		now.b[ Index(now.i, 5) ] = now.j;
#ifdef VAR_RANGES
		logval("b[i]", now.b[ Index(now.i, 5) ]);
#endif
		;
		/* merge: printf('MSC: %d %d\\n',i,b[i])(83, 71, 83) */
		reached[3][71] = 1;
		Printf("MSC: %d %d\n", now.i, now.b[ Index(now.i, 5) ]);
		/* merge: i = (i+1)(83, 72, 83) */
		reached[3][72] = 1;
		(trpt+1)->bup.ovals[1] = now.i;
		now.i = (now.i+1);
#ifdef VAR_RANGES
		logval("i", now.i);
#endif
		;
		/* merge: j = (j+1)(83, 73, 83) */
		reached[3][73] = 1;
		(trpt+1)->bup.ovals[2] = now.j;
		now.j = (now.j+1);
#ifdef VAR_RANGES
		logval("j", now.j);
#endif
		;
		/* merge: .(goto)(0, 75, 83) */
		reached[3][75] = 1;
		;
		/* merge: .(goto)(0, 82, 83) */
		reached[3][82] = 1;
		;
		/* merge: .(goto)(0, 84, 83) */
		reached[3][84] = 1;
		;
		_m = 3; goto P999; /* 6 */
	case 23: /* STATE 76 - line 24 "pan_in" - [((j==mj))] (83:0:3 - 1) */
		IfNotBlocked
		reached[3][76] = 1;
		if (!((now.j==((P3 *)this)->mj)))
			continue;
		/* merge: b[i] = mj(83, 77, 83) */
		reached[3][77] = 1;
		(trpt+1)->bup.ovals = grab_ints(3);
		(trpt+1)->bup.ovals[0] = now.b[ Index(now.i, 5) ];
		now.b[ Index(now.i, 5) ] = ((P3 *)this)->mj;
#ifdef VAR_RANGES
		logval("b[i]", now.b[ Index(now.i, 5) ]);
#endif
		;
		/* merge: printf('MSC: %d %d\\n',i,b[i])(83, 78, 83) */
		reached[3][78] = 1;
		Printf("MSC: %d %d\n", now.i, now.b[ Index(now.i, 5) ]);
		/* merge: i = (i+1)(83, 79, 83) */
		reached[3][79] = 1;
		(trpt+1)->bup.ovals[1] = now.i;
		now.i = (now.i+1);
#ifdef VAR_RANGES
		logval("i", now.i);
#endif
		;
		/* merge: j = (j+1)(83, 80, 83) */
		reached[3][80] = 1;
		(trpt+1)->bup.ovals[2] = now.j;
		now.j = (now.j+1);
#ifdef VAR_RANGES
		logval("j", now.j);
#endif
		;
		/* merge: .(goto)(0, 82, 83) */
		reached[3][82] = 1;
		;
		/* merge: .(goto)(0, 84, 83) */
		reached[3][84] = 1;
		;
		_m = 3; goto P999; /* 6 */
	case 24: /* STATE 87 - line 111 "pan_in" - [printf('MSC: C\\n')] (0:121:0 - 5) */
		IfNotBlocked
		reached[3][87] = 1;
		Printf("MSC: C\n");
		_m = 3; goto P999; /* 0 */
	case 25: /* STATE 88 - line 12 "pan_in" - [i = 0] (0:118:2 - 1) */
		IfNotBlocked
		reached[3][88] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = now.i;
		now.i = 0;
#ifdef VAR_RANGES
		logval("i", now.i);
#endif
		;
		/* merge: j = 0(118, 89, 118) */
		reached[3][89] = 1;
		(trpt+1)->bup.ovals[1] = now.j;
		now.j = 0;
#ifdef VAR_RANGES
		logval("j", now.j);
#endif
		;
		/* merge: .(goto)(0, 119, 118) */
		reached[3][119] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 26: /* STATE 90 - line 14 "pan_in" - [(((i==(5-1))&&(j<mj)))] (122:0:1 - 1) */
		IfNotBlocked
		reached[3][90] = 1;
		if (!(((now.i==(5-1))&&(now.j<((P3 *)this)->mj))))
			continue;
		/* merge: c[i] = mj(0, 91, 122) */
		reached[3][91] = 1;
		(trpt+1)->bup.oval = now.c[ Index(now.i, 5) ];
		now.c[ Index(now.i, 5) ] = ((P3 *)this)->mj;
#ifdef VAR_RANGES
		logval("c[i]", now.c[ Index(now.i, 5) ]);
#endif
		;
		/* merge: goto :b6(0, 92, 122) */
		reached[3][92] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 27: /* STATE 93 - line 15 "pan_in" - [((i==5))] (0:0:0 - 1) */
		IfNotBlocked
		reached[3][93] = 1;
		if (!((now.i==5)))
			continue;
		_m = 3; goto P999; /* 0 */
/* STATE 96 - line 18 "pan_in" - [((j!=mj))] (0:0 - 1) same as 11 (0:0 - 1) */
	case 28: /* STATE 97 - line 20 "pan_in" - [(((i<5)&&(j<(10-5))))] (118:0:3 - 1) */
		IfNotBlocked
		reached[3][97] = 1;
		if (!(((now.i<5)&&(now.j<(10-5)))))
			continue;
		/* merge: c[i] = j(118, 98, 118) */
		reached[3][98] = 1;
		(trpt+1)->bup.ovals = grab_ints(3);
		(trpt+1)->bup.ovals[0] = now.c[ Index(now.i, 5) ];
		now.c[ Index(now.i, 5) ] = now.j;
#ifdef VAR_RANGES
		logval("c[i]", now.c[ Index(now.i, 5) ]);
#endif
		;
		/* merge: printf('MSC: %d %d\\n',i,c[i])(118, 99, 118) */
		reached[3][99] = 1;
		Printf("MSC: %d %d\n", now.i, now.c[ Index(now.i, 5) ]);
		/* merge: i = (i+1)(118, 100, 118) */
		reached[3][100] = 1;
		(trpt+1)->bup.ovals[1] = now.i;
		now.i = (now.i+1);
#ifdef VAR_RANGES
		logval("i", now.i);
#endif
		;
		/* merge: j = (j+1)(118, 101, 118) */
		reached[3][101] = 1;
		(trpt+1)->bup.ovals[2] = now.j;
		now.j = (now.j+1);
#ifdef VAR_RANGES
		logval("j", now.j);
#endif
		;
		/* merge: .(goto)(0, 110, 118) */
		reached[3][110] = 1;
		;
		/* merge: .(goto)(0, 117, 118) */
		reached[3][117] = 1;
		;
		/* merge: .(goto)(0, 119, 118) */
		reached[3][119] = 1;
		;
		_m = 3; goto P999; /* 7 */
	case 29: /* STATE 102 - line 21 "pan_in" - [(((i<5)&&(j<(10-5))))] (118:0:1 - 1) */
		IfNotBlocked
		reached[3][102] = 1;
		if (!(((now.i<5)&&(now.j<(10-5)))))
			continue;
		/* merge: j = (j+1)(0, 103, 118) */
		reached[3][103] = 1;
		(trpt+1)->bup.oval = now.j;
		now.j = (now.j+1);
#ifdef VAR_RANGES
		logval("j", now.j);
#endif
		;
		/* merge: .(goto)(0, 110, 118) */
		reached[3][110] = 1;
		;
		/* merge: .(goto)(0, 117, 118) */
		reached[3][117] = 1;
		;
		/* merge: .(goto)(0, 119, 118) */
		reached[3][119] = 1;
		;
		_m = 3; goto P999; /* 4 */
	case 30: /* STATE 105 - line 22 "pan_in" - [c[i] = j] (0:118:3 - 1) */
		IfNotBlocked
		reached[3][105] = 1;
		(trpt+1)->bup.ovals = grab_ints(3);
		(trpt+1)->bup.ovals[0] = now.c[ Index(now.i, 5) ];
		now.c[ Index(now.i, 5) ] = now.j;
#ifdef VAR_RANGES
		logval("c[i]", now.c[ Index(now.i, 5) ]);
#endif
		;
		/* merge: printf('MSC: %d %d\\n',i,c[i])(118, 106, 118) */
		reached[3][106] = 1;
		Printf("MSC: %d %d\n", now.i, now.c[ Index(now.i, 5) ]);
		/* merge: i = (i+1)(118, 107, 118) */
		reached[3][107] = 1;
		(trpt+1)->bup.ovals[1] = now.i;
		now.i = (now.i+1);
#ifdef VAR_RANGES
		logval("i", now.i);
#endif
		;
		/* merge: j = (j+1)(118, 108, 118) */
		reached[3][108] = 1;
		(trpt+1)->bup.ovals[2] = now.j;
		now.j = (now.j+1);
#ifdef VAR_RANGES
		logval("j", now.j);
#endif
		;
		/* merge: .(goto)(0, 110, 118) */
		reached[3][110] = 1;
		;
		/* merge: .(goto)(0, 117, 118) */
		reached[3][117] = 1;
		;
		/* merge: .(goto)(0, 119, 118) */
		reached[3][119] = 1;
		;
		_m = 3; goto P999; /* 6 */
	case 31: /* STATE 111 - line 24 "pan_in" - [((j==mj))] (118:0:3 - 1) */
		IfNotBlocked
		reached[3][111] = 1;
		if (!((now.j==((P3 *)this)->mj)))
			continue;
		/* merge: c[i] = mj(118, 112, 118) */
		reached[3][112] = 1;
		(trpt+1)->bup.ovals = grab_ints(3);
		(trpt+1)->bup.ovals[0] = now.c[ Index(now.i, 5) ];
		now.c[ Index(now.i, 5) ] = ((P3 *)this)->mj;
#ifdef VAR_RANGES
		logval("c[i]", now.c[ Index(now.i, 5) ]);
#endif
		;
		/* merge: printf('MSC: %d %d\\n',i,c[i])(118, 113, 118) */
		reached[3][113] = 1;
		Printf("MSC: %d %d\n", now.i, now.c[ Index(now.i, 5) ]);
		/* merge: i = (i+1)(118, 114, 118) */
		reached[3][114] = 1;
		(trpt+1)->bup.ovals[1] = now.i;
		now.i = (now.i+1);
#ifdef VAR_RANGES
		logval("i", now.i);
#endif
		;
		/* merge: j = (j+1)(118, 115, 118) */
		reached[3][115] = 1;
		(trpt+1)->bup.ovals[2] = now.j;
		now.j = (now.j+1);
#ifdef VAR_RANGES
		logval("j", now.j);
#endif
		;
		/* merge: .(goto)(0, 117, 118) */
		reached[3][117] = 1;
		;
		/* merge: .(goto)(0, 119, 118) */
		reached[3][119] = 1;
		;
		_m = 3; goto P999; /* 6 */
	case 32: /* STATE 122 - line 114 "pan_in" - [(run welfarecrook1())] (0:0:0 - 5) */
		IfNotBlocked
		reached[3][122] = 1;
		if (!(addproc(0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 33: /* STATE 123 - line 115 "pan_in" - [(run welfarecrook2())] (0:0:0 - 1) */
		IfNotBlocked
		reached[3][123] = 1;
		if (!(addproc(1)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 34: /* STATE 124 - line 116 "pan_in" - [(run welfarecrook3())] (0:0:0 - 1) */
		IfNotBlocked
		reached[3][124] = 1;
		if (!(addproc(2)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 35: /* STATE 126 - line 118 "pan_in" - [-end-] (0:0:0 - 1) */
		IfNotBlocked
		reached[3][126] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC welfarecrook3 */
	case 36: /* STATE 1 - line 86 "pan_in" - [(((terminate1&&terminate2)&&terminate3))] (0:0:0 - 1) */
		IfNotBlocked
		reached[2][1] = 1;
		if (!(((((int)now.terminate1)&&((int)now.terminate2))&&((int)now.terminate3))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 37: /* STATE 4 - line 89 "pan_in" - [(terminate3)] (0:0:0 - 1) */
		IfNotBlocked
		reached[2][4] = 1;
		if (!(((int)now.terminate3)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 38: /* STATE 5 - line 89 "pan_in" - [k = (k+1)] (0:0:1 - 1) */
		IfNotBlocked
		reached[2][5] = 1;
		(trpt+1)->bup.oval = now.k;
		now.k = (now.k+1);
#ifdef VAR_RANGES
		logval("k", now.k);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 39: /* STATE 6 - line 89 "pan_in" - [terminate3 = 0] (0:0:1 - 1) */
		IfNotBlocked
		reached[2][6] = 1;
		(trpt+1)->bup.oval = ((int)now.terminate3);
		now.terminate3 = 0;
#ifdef VAR_RANGES
		logval("terminate3", ((int)now.terminate3));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 40: /* STATE 11 - line 93 "pan_in" - [((c[k]<a[i]))] (0:0:0 - 1) */
		IfNotBlocked
		reached[2][11] = 1;
		if (!((now.c[ Index(now.k, 5) ]<now.a[ Index(now.i, 5) ])))
			continue;
		_m = 3; goto P999; /* 0 */
/* STATE 12 - line 93 "pan_in" - [k = (k+1)] (0:0 - 1) same as 38 (0:0 - 1) */
	case 41: /* STATE 13 - line 94 "pan_in" - [((c[k]==a[i]))] (0:0:0 - 1) */
		IfNotBlocked
		reached[2][13] = 1;
		if (!((now.c[ Index(now.k, 5) ]==now.a[ Index(now.i, 5) ])))
			continue;
		_m = 3; goto P999; /* 0 */
	case 42: /* STATE 14 - line 94 "pan_in" - [terminate3 = 1] (0:0:1 - 1) */
		IfNotBlocked
		reached[2][14] = 1;
		(trpt+1)->bup.oval = ((int)now.terminate3);
		now.terminate3 = 1;
#ifdef VAR_RANGES
		logval("terminate3", ((int)now.terminate3));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 43: /* STATE 20 - line 97 "pan_in" - [printf('MSC: %d %d %d\\n',a[i],b[j],c[k])] (0:0:0 - 3) */
		IfNotBlocked
		reached[2][20] = 1;
		Printf("MSC: %d %d %d\n", now.a[ Index(now.i, 5) ], now.b[ Index(now.j, 5) ], now.c[ Index(now.k, 5) ]);
		_m = 3; goto P999; /* 0 */
	case 44: /* STATE 21 - line 98 "pan_in" - [-end-] (0:0:0 - 1) */
		IfNotBlocked
		reached[2][21] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC welfarecrook2 */
	case 45: /* STATE 1 - line 68 "pan_in" - [(((terminate1&&terminate2)&&terminate3))] (0:0:0 - 1) */
		IfNotBlocked
		reached[1][1] = 1;
		if (!(((((int)now.terminate1)&&((int)now.terminate2))&&((int)now.terminate3))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 46: /* STATE 4 - line 71 "pan_in" - [(terminate2)] (0:0:0 - 1) */
		IfNotBlocked
		reached[1][4] = 1;
		if (!(((int)now.terminate2)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 47: /* STATE 5 - line 71 "pan_in" - [j = (j+1)] (0:0:1 - 1) */
		IfNotBlocked
		reached[1][5] = 1;
		(trpt+1)->bup.oval = now.j;
		now.j = (now.j+1);
#ifdef VAR_RANGES
		logval("j", now.j);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 48: /* STATE 6 - line 71 "pan_in" - [terminate2 = 0] (0:0:1 - 1) */
		IfNotBlocked
		reached[1][6] = 1;
		(trpt+1)->bup.oval = ((int)now.terminate2);
		now.terminate2 = 0;
#ifdef VAR_RANGES
		logval("terminate2", ((int)now.terminate2));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 49: /* STATE 11 - line 75 "pan_in" - [((b[j]<c[k]))] (0:0:0 - 1) */
		IfNotBlocked
		reached[1][11] = 1;
		if (!((now.b[ Index(now.j, 5) ]<now.c[ Index(now.k, 5) ])))
			continue;
		_m = 3; goto P999; /* 0 */
/* STATE 12 - line 75 "pan_in" - [j = (j+1)] (0:0 - 1) same as 47 (0:0 - 1) */
	case 50: /* STATE 13 - line 76 "pan_in" - [((b[j]==c[k]))] (0:0:0 - 1) */
		IfNotBlocked
		reached[1][13] = 1;
		if (!((now.b[ Index(now.j, 5) ]==now.c[ Index(now.k, 5) ])))
			continue;
		_m = 3; goto P999; /* 0 */
	case 51: /* STATE 14 - line 76 "pan_in" - [terminate2 = 1] (0:0:1 - 1) */
		IfNotBlocked
		reached[1][14] = 1;
		(trpt+1)->bup.oval = ((int)now.terminate2);
		now.terminate2 = 1;
#ifdef VAR_RANGES
		logval("terminate2", ((int)now.terminate2));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 52: /* STATE 20 - line 79 "pan_in" - [printf('MSC: %d %d %d\\n',a[i],b[j],c[k])] (0:0:0 - 3) */
		IfNotBlocked
		reached[1][20] = 1;
		Printf("MSC: %d %d %d\n", now.a[ Index(now.i, 5) ], now.b[ Index(now.j, 5) ], now.c[ Index(now.k, 5) ]);
		_m = 3; goto P999; /* 0 */
	case 53: /* STATE 21 - line 80 "pan_in" - [-end-] (0:0:0 - 1) */
		IfNotBlocked
		reached[1][21] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC welfarecrook1 */
	case 54: /* STATE 1 - line 49 "pan_in" - [(((terminate1&&terminate2)&&terminate3))] (0:0:0 - 1) */
		IfNotBlocked
		reached[0][1] = 1;
		if (!(((((int)now.terminate1)&&((int)now.terminate2))&&((int)now.terminate3))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 55: /* STATE 4 - line 52 "pan_in" - [(terminate1)] (0:0:0 - 1) */
		IfNotBlocked
		reached[0][4] = 1;
		if (!(((int)now.terminate1)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 56: /* STATE 5 - line 52 "pan_in" - [i = (i+1)] (0:0:1 - 1) */
		IfNotBlocked
		reached[0][5] = 1;
		(trpt+1)->bup.oval = now.i;
		now.i = (now.i+1);
#ifdef VAR_RANGES
		logval("i", now.i);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 57: /* STATE 6 - line 52 "pan_in" - [terminate1 = 0] (0:0:1 - 1) */
		IfNotBlocked
		reached[0][6] = 1;
		(trpt+1)->bup.oval = ((int)now.terminate1);
		now.terminate1 = 0;
#ifdef VAR_RANGES
		logval("terminate1", ((int)now.terminate1));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 58: /* STATE 11 - line 56 "pan_in" - [((a[i]<b[j]))] (0:0:0 - 1) */
		IfNotBlocked
		reached[0][11] = 1;
		if (!((now.a[ Index(now.i, 5) ]<now.b[ Index(now.j, 5) ])))
			continue;
		_m = 3; goto P999; /* 0 */
/* STATE 12 - line 56 "pan_in" - [i = (i+1)] (0:0 - 1) same as 56 (0:0 - 1) */
	case 59: /* STATE 13 - line 57 "pan_in" - [((a[i]==b[j]))] (0:0:0 - 1) */
		IfNotBlocked
		reached[0][13] = 1;
		if (!((now.a[ Index(now.i, 5) ]==now.b[ Index(now.j, 5) ])))
			continue;
		_m = 3; goto P999; /* 0 */
	case 60: /* STATE 14 - line 57 "pan_in" - [terminate1 = 1] (0:0:1 - 1) */
		IfNotBlocked
		reached[0][14] = 1;
		(trpt+1)->bup.oval = ((int)now.terminate1);
		now.terminate1 = 1;
#ifdef VAR_RANGES
		logval("terminate1", ((int)now.terminate1));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 61: /* STATE 20 - line 60 "pan_in" - [printf('MSC: %d %d %d\\n',a[i],b[j],c[k])] (0:0:0 - 3) */
		IfNotBlocked
		reached[0][20] = 1;
		Printf("MSC: %d %d %d\n", now.a[ Index(now.i, 5) ], now.b[ Index(now.j, 5) ], now.c[ Index(now.k, 5) ]);
		_m = 3; goto P999; /* 0 */
	case 62: /* STATE 21 - line 61 "pan_in" - [-end-] (0:0:0 - 1) */
		IfNotBlocked
		reached[0][21] = 1;
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

