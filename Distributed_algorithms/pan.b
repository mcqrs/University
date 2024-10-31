	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC :never: */
;
		;
		;
		;
		;
		;
		;
		;
		
	case 7: /* STATE 17 */
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC :init: */

	case 8: /* STATE 1 */
		;
		now.lock = trpt->bup.oval;
		;
		goto R999;

	case 9: /* STATE 5 */
		;
		((P2 *)this)->i = trpt->bup.ovals[2];
		now.RW.writers = trpt->bup.ovals[1];
		now.RW.readers = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 3);
		goto R999;
;
		;
		
	case 11: /* STATE 8 */
		;
		((P2 *)this)->i = trpt->bup.oval;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 12: /* STATE 14 */
		;
		((P2 *)this)->i = trpt->bup.oval;
		;
		goto R999;

	case 13: /* STATE 17 */
		;
		((P2 *)this)->i = trpt->bup.oval;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 14: /* STATE 24 */
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC writer */

	case 15: /* STATE 9 */
		;
		now.lock = trpt->bup.oval;
		;
		goto R999;

	case 16: /* STATE 13 */
		;
		wantW[ Index(((P1 *)this)->i, 2) ] = trpt->bup.oval;
		;
		goto R999;

	case 17: /* STATE 14 */
		;
		wantW[ Index(((P1 *)this)->i, 2) ] = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 19: /* STATE 16 */
		;
		now.waitW[ Index(((P1 *)this)->i, 2) ] = trpt->bup.oval;
		;
		goto R999;
;
		
	case 20: /* STATE 17 */
		goto R999;

	case 21: /* STATE 20 */
		;
		now.lock = trpt->bup.ovals[1];
		now.RW.OKtoWrite.waiting = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		
	case 22: /* STATE 21 */
		goto R999;

	case 23: /* STATE 25 */
		;
		now.RW.OKtoWrite.waiting = trpt->bup.ovals[1];
		now.RW.OKtoWrite.gate = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		
	case 24: /* STATE 31 */
		goto R999;

	case 25: /* STATE 34 */
		;
		now.RW.writers = trpt->bup.oval;
		;
		goto R999;

	case 26: /* STATE 35 */
		;
		now.num = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 28: /* STATE 42 */
		;
		now.num = trpt->bup.ovals[1];
		now.waitR[ Index(now.num, 2) ] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 29: /* STATE 42 */
		;
		now.num = trpt->bup.oval;
		;
		goto R999;
;
		
	case 30: /* STATE 44 */
		goto R999;

	case 31: /* STATE 58 */
		;
		now.num = trpt->bup.ovals[1];
		now.waitW[ Index(now.num, 2) ] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 32: /* STATE 58 */
		;
		now.num = trpt->bup.oval;
		;
		goto R999;
;
		
	case 33: /* STATE 60 */
		goto R999;

	case 34: /* STATE 67 */
		;
		now.lock = trpt->bup.oval;
		;
		goto R999;

	case 35: /* STATE 73 */
		;
		critW[ Index(((P1 *)this)->i, 2) ] = trpt->bup.oval;
		;
		goto R999;

	case 36: /* STATE 74 */
		;
		crW = trpt->bup.oval;
		;
		goto R999;

	case 37: /* STATE 75 */
		;
		crW = trpt->bup.oval;
		;
		goto R999;

	case 38: /* STATE 76 */
		;
		critW[ Index(((P1 *)this)->i, 2) ] = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 40: /* STATE 79 */
		;
		now.lock = trpt->bup.oval;
		;
		goto R999;

	case 41: /* STATE 84 */
		;
		now.RW.writers = trpt->bup.oval;
		;
		goto R999;

	case 42: /* STATE 86 */
		;
		((P1 *)this)->t = trpt->bup.ovals[1];
		((P1 *)this)->countZeros = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		;
		
	case 44: /* STATE 93 */
		;
		((P1 *)this)->t = trpt->bup.ovals[1];
		((P1 *)this)->countZeros = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 45: /* STATE 93 */
		;
		((P1 *)this)->t = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 47: /* STATE 101 */
		;
	/* 0 */	((P1 *)this)->countZeros = trpt->bup.oval;
		;
		;
		goto R999;

	case 48: /* STATE 104 */
		;
		now.RW.OKtoRead.gate = trpt->bup.oval;
		;
		goto R999;

	case 49: /* STATE 106 */
		;
		now.lock = trpt->bup.oval;
		;
		goto R999;
;
		
	case 50: /* STATE 109 */
		goto R999;
;
		
	case 51: /* STATE 124 */
		goto R999;
;
		;
		
	case 53: /* STATE 115 */
		;
		now.RW.OKtoWrite.gate = trpt->bup.oval;
		;
		goto R999;

	case 54: /* STATE 117 */
		;
		now.lock = trpt->bup.oval;
		;
		goto R999;
;
		
	case 55: /* STATE 120 */
		goto R999;

	case 56: /* STATE 126 */
		;
		now.lock = trpt->bup.oval;
		;
		goto R999;

	case 57: /* STATE 134 */
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC reader */

	case 58: /* STATE 2 */
		;
		now.lock = trpt->bup.oval;
		;
		goto R999;

	case 59: /* STATE 6 */
		;
		now.wantR[ Index(((P0 *)this)->i, 2) ] = trpt->bup.oval;
		;
		goto R999;

	case 60: /* STATE 7 */
		;
		now.wantR[ Index(((P0 *)this)->i, 2) ] = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 62: /* STATE 9 */
		;
		now.waitR[ Index(((P0 *)this)->i, 2) ] = trpt->bup.oval;
		;
		goto R999;
;
		
	case 63: /* STATE 10 */
		goto R999;

	case 64: /* STATE 13 */
		;
		now.lock = trpt->bup.ovals[1];
		now.RW.OKtoRead.waiting = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		
	case 65: /* STATE 14 */
		goto R999;

	case 66: /* STATE 18 */
		;
		now.RW.OKtoRead.waiting = trpt->bup.ovals[1];
		now.RW.OKtoRead.gate = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		
	case 67: /* STATE 24 */
		goto R999;

	case 68: /* STATE 27 */
		;
		now.RW.readers = trpt->bup.oval;
		;
		goto R999;

	case 69: /* STATE 29 */
		;
		((P0 *)this)->p = trpt->bup.ovals[1];
		((P0 *)this)->cZeros = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		;
		
	case 71: /* STATE 36 */
		;
		((P0 *)this)->p = trpt->bup.ovals[1];
		((P0 *)this)->cZeros = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 72: /* STATE 36 */
		;
		((P0 *)this)->p = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 74: /* STATE 44 */
		;
	/* 0 */	((P0 *)this)->cZeros = trpt->bup.oval;
		;
		;
		goto R999;
;
		;
		
	case 76: /* STATE 47 */
		;
		now.RW.OKtoRead.gate = trpt->bup.oval;
		;
		goto R999;

	case 77: /* STATE 49 */
		;
		now.lock = trpt->bup.oval;
		;
		goto R999;
;
		
	case 78: /* STATE 52 */
		goto R999;

	case 79: /* STATE 58 */
		;
		now.num = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 81: /* STATE 65 */
		;
		now.num = trpt->bup.ovals[1];
		now.waitW[ Index(now.num, 2) ] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 82: /* STATE 65 */
		;
		now.num = trpt->bup.oval;
		;
		goto R999;
;
		
	case 83: /* STATE 67 */
		goto R999;

	case 84: /* STATE 74 */
		;
		now.lock = trpt->bup.oval;
		;
		goto R999;

	case 85: /* STATE 80 */
		;
		now.critR[ Index(((P0 *)this)->i, 2) ] = trpt->bup.oval;
		;
		goto R999;

	case 86: /* STATE 81 */
		;
		crR = trpt->bup.oval;
		;
		goto R999;

	case 87: /* STATE 82 */
		;
		crR = trpt->bup.oval;
		;
		goto R999;

	case 88: /* STATE 83 */
		;
		now.critR[ Index(((P0 *)this)->i, 2) ] = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 90: /* STATE 86 */
		;
		now.lock = trpt->bup.oval;
		;
		goto R999;

	case 91: /* STATE 91 */
		;
		now.RW.readers = trpt->bup.oval;
		;
		goto R999;
;
		
	case 92: /* STATE 92 */
		goto R999;

	case 93: /* STATE 95 */
		;
		now.RW.OKtoWrite.gate = trpt->bup.oval;
		;
		goto R999;

	case 94: /* STATE 97 */
		;
		now.lock = trpt->bup.oval;
		;
		goto R999;
;
		
	case 95: /* STATE 100 */
		goto R999;
;
		
	case 96: /* STATE 105 */
		goto R999;

	case 97: /* STATE 107 */
		;
		now.lock = trpt->bup.oval;
		;
		goto R999;

	case 98: /* STATE 115 */
		;
		p_restor(II);
		;
		;
		goto R999;
	}

