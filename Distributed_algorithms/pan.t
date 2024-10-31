#ifdef PEG
struct T_SRC {
	char *fl; int ln;
} T_SRC[NTRANS];

void
tr_2_src(int m, char *file, int ln)
{	T_SRC[m].fl = file;
	T_SRC[m].ln = ln;
}

void
putpeg(int n, int m)
{	printf("%5d	trans %4d ", m, n);
	printf("file %s line %3d\n",
		T_SRC[n].fl, T_SRC[n].ln);
}
#endif

void
settable(void)
{	Trans *T;
	Trans *settr(int, int, int, int, int, char *, int, int, int);

	trans = (Trans ***) emalloc(5*sizeof(Trans **));

	/* proctype 3: :never: */

	trans[3] = (Trans **) emalloc(18*sizeof(Trans *));

	T = trans[3][7] = settr(279,0,0,0,0,"IF", 0, 2, 0);
	T = T->nxt	= settr(279,0,1,0,0,"IF", 0, 2, 0);
	T = T->nxt	= settr(279,0,3,0,0,"IF", 0, 2, 0);
	    T->nxt	= settr(279,0,5,0,0,"IF", 0, 2, 0);
	trans[3][1]	= settr(273,0,11,3,0,"((!(critR[1])&&wantR[1]))", 1, 2, 0);
	trans[3][2]	= settr(274,0,11,1,0,"goto accept_S5", 0, 2, 0);
	trans[3][8]	= settr(280,0,11,1,0,".(goto)", 0, 2, 0);
	trans[3][3]	= settr(275,0,15,4,0,"((!(critR[0])&&wantR[0]))", 1, 2, 0);
	trans[3][4]	= settr(276,0,15,1,0,"goto accept_S10", 0, 2, 0);
	trans[3][5]	= settr(277,0,7,1,0,"(1)", 0, 2, 0);
	trans[3][6]	= settr(278,0,7,1,0,"goto T0_init", 0, 2, 0);
	T = trans[3][11] = settr(283,0,0,0,0,"IF", 0, 2, 0);
	    T->nxt	= settr(283,0,9,0,0,"IF", 0, 2, 0);
	trans[3][9]	= settr(281,0,11,5,0,"(!(critR[1]))", 1, 2, 0);
	trans[3][10]	= settr(282,0,11,1,0,"goto accept_S5", 0, 2, 0);
	trans[3][12]	= settr(284,0,15,1,0,".(goto)", 0, 2, 0);
	T = trans[3][15] = settr(287,0,0,0,0,"IF", 0, 2, 0);
	    T->nxt	= settr(287,0,13,0,0,"IF", 0, 2, 0);
	trans[3][13]	= settr(285,0,15,6,0,"(!(critR[0]))", 1, 2, 0);
	trans[3][14]	= settr(286,0,15,1,0,"goto accept_S10", 0, 2, 0);
	trans[3][16]	= settr(288,0,17,1,0,".(goto)", 0, 2, 0);
	trans[3][17]	= settr(289,0,0,7,7,"-end-", 0, 3500, 0);

	/* proctype 2: :init: */

	trans[2] = (Trans **) emalloc(25*sizeof(Trans *));

	T = trans[ 2][23] = settr(271,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(271,2,1,0,0,"ATOMIC", 1, 2, 0);
	trans[2][1]	= settr(249,2,4,8,8,"lock = 0", 1, 2, 0);
	T = trans[ 2][4] = settr(252,0,0,0,0,"sub-sequence", 1, 2, 0);
	T->nxt	= settr(252,0,2,0,0,"sub-sequence", 1, 2, 0);
	trans[2][2]	= settr(250,2,11,9,9,"RW.readers = 0", 1, 2, 0); /* m: 3 -> 0,11 */
	reached2[3] = 1;
	trans[2][3]	= settr(0,0,0,0,0,"RW.writers = 0",0,0,0);
	trans[2][5]	= settr(0,0,0,0,0,"i = 0",0,0,0);
	trans[2][12]	= settr(260,2,11,1,0,".(goto)", 1, 2, 0);
	T = trans[2][11] = settr(259,2,0,0,0,"DO", 1, 2, 0);
	T = T->nxt	= settr(259,2,6,0,0,"DO", 1, 2, 0);
	    T->nxt	= settr(259,2,9,0,0,"DO", 1, 2, 0);
	trans[2][6]	= settr(254,2,7,10,0,"((i<2))", 1, 2, 0);
	trans[2][7]	= settr(255,2,11,11,11,"(run reader(i))", 1, 2, 0); /* m: 8 -> 11,0 */
	reached2[8] = 1;
	trans[2][8]	= settr(0,0,0,0,0,"i = (i+1)",0,0,0);
	trans[2][9]	= settr(257,2,14,2,0,"else", 1, 2, 0);
	trans[2][10]	= settr(258,2,14,1,0,"goto :b8", 1, 2, 0); /* m: 14 -> 0,20 */
	reached2[14] = 1;
	trans[2][13]	= settr(261,2,14,1,0,"break", 1, 2, 0);
	trans[2][14]	= settr(262,2,20,12,12,"i = 0", 1, 2, 0);
	trans[2][21]	= settr(269,2,20,1,0,".(goto)", 1, 2, 0);
	T = trans[2][20] = settr(268,2,0,0,0,"DO", 1, 2, 0);
	T = T->nxt	= settr(268,2,15,0,0,"DO", 1, 2, 0);
	    T->nxt	= settr(268,2,18,0,0,"DO", 1, 2, 0);
	trans[2][15]	= /* c */ settr(263,2,16,10,0,"((i<2))", 1, 2, 0);
	trans[2][16]	= settr(264,2,20,13,13,"(run writer(i))", 1, 2, 0); /* m: 17 -> 20,0 */
	reached2[17] = 1;
	trans[2][17]	= settr(0,0,0,0,0,"i = (i+1)",0,0,0);
	trans[2][18]	= settr(266,2,19,2,0,"else", 1, 2, 0);
	trans[2][19]	= settr(267,2,22,1,0,"goto :b9", 1, 2, 0);
	trans[2][22]	= settr(270,0,24,1,0,"break", 1, 2, 0);
	trans[2][24]	= settr(272,0,0,14,14,"-end-", 0, 3500, 0);

	/* proctype 1: writer */

	trans[1] = (Trans **) emalloc(135*sizeof(Trans *));

	trans[1][132]	= settr(246,0,131,1,0,".(goto)", 0, 2, 0);
	T = trans[1][131] = settr(245,0,0,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(245,0,5,0,0,"DO", 0, 2, 0);
	trans[1][6]	= settr(120,0,5,1,0,".(goto)", 0, 2, 0);
	T = trans[1][5] = settr(119,0,0,0,0,"DO", 0, 2, 0);
	T = T->nxt	= settr(119,0,1,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(119,0,3,0,0,"DO", 0, 2, 0);
	trans[1][1]	= settr(115,0,71,1,0,"(1)", 0, 2, 0);
	trans[1][2]	= settr(116,0,71,1,0,"goto :b4", 0, 2, 0);
	trans[1][3]	= settr(117,0,4,1,0,"(1)", 0, 2, 0);
	trans[1][4]	= settr(118,0,5,1,0,"(1)", 0, 2, 0);
	trans[1][7]	= settr(121,0,71,1,0,"break", 0, 2, 0);
	T = trans[ 1][71] = settr(185,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(185,0,12,0,0,"sub-sequence", 0, 2, 0);
	T = trans[ 1][12] = settr(126,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(126,0,11,0,0,"sub-sequence", 0, 2, 0);
	T = trans[ 1][11] = settr(125,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(125,2,8,0,0,"ATOMIC", 1, 2, 0);
	trans[1][8]	= settr(122,4,13,15,15,"(!(lock))", 1, 2, 0); /* m: 9 -> 13,0 */
	reached1[9] = 1;
	trans[1][9]	= settr(0,0,0,0,0,"lock = 1",0,0,0);
	trans[1][10]	= settr(0,0,0,0,0,"printf('MSC: enterMon()\\n')",0,0,0);
	trans[1][13]	= settr(127,0,14,16,16,"wantW[i] = 1", 1, 2, 0);
	trans[1][14]	= settr(128,0,15,17,17,"wantW[i] = 0", 1, 2, 0);
	trans[1][15]	= settr(129,0,16,18,0,"printf('MSC: startWrite\\n')", 0, 2, 0);
	trans[1][16]	= settr(130,0,32,19,19,"waitW[i] = (RW.OKtoWrite.waiting+RW.OKtoRead.waiting)", 1, 2, 0);
	T = trans[ 1][32] = settr(146,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(146,2,30,0,0,"ATOMIC", 1, 2, 0);
	T = trans[1][30] = settr(144,2,0,0,0,"IF", 1, 2, 0);
	T = T->nxt	= settr(144,2,17,0,0,"IF", 1, 2, 0);
	    T->nxt	= settr(144,2,29,0,0,"IF", 1, 2, 0);
	trans[1][17]	= settr(131,2,28,20,20,"(((RW.writers!=0)||(RW.readers!=0)))", 1, 2, 0); /* m: 18 -> 28,0 */
	reached1[18] = 1;
	trans[1][18]	= settr(0,0,0,0,0,"printf('MSC: wait(OKtoWrite)\\n')",0,0,0);
	T = trans[ 1][28] = settr(142,0,0,0,0,"sub-sequence", 1, 2, 0);
	T->nxt	= settr(142,0,27,0,0,"sub-sequence", 1, 2, 0);
	T = trans[ 1][27] = settr(141,0,0,0,0,"sub-sequence", 1, 2, 0);
	T->nxt	= settr(141,0,19,0,0,"sub-sequence", 1, 2, 0);
	trans[1][19]	= settr(133,2,21,21,21,"RW.OKtoWrite.waiting = (RW.OKtoWrite.waiting+1)", 1, 2, 0); /* m: 20 -> 0,21 */
	reached1[20] = 1;
	trans[1][20]	= settr(0,0,0,0,0,"lock = 0",0,0,0);
	trans[1][21]	= settr(135,2,23,22,22,"(!(waitW[i]))", 1, 2, 0); /* m: 22 -> 23,0 */
	reached1[22] = 1;
	trans[1][22]	= settr(0,0,0,0,0,"printf('MSC: my turn! wait for gate\\n')",0,0,0);
	trans[1][23]	= settr(137,0,34,23,23,"(RW.OKtoWrite.gate)", 1, 2, 0); /* m: 24 -> 34,0 */
	reached1[24] = 1;
	trans[1][24]	= settr(0,0,0,0,0,"RW.OKtoWrite.gate = 0",0,0,0);
	trans[1][25]	= settr(0,0,0,0,0,"RW.OKtoWrite.waiting = (RW.OKtoWrite.waiting-1)",0,0,0);
	trans[1][26]	= settr(0,0,0,0,0,"printf('MSC: received gate\\n')",0,0,0);
	trans[1][31]	= settr(145,0,34,24,24,".(goto)", 1, 2, 0); /* m: 33 -> 0,34 */
	reached1[33] = 1;
	trans[1][29]	= settr(143,2,31,2,0,"else", 1, 2, 0);
	trans[1][33]	= settr(0,0,0,0,0,"printf('MSC: go write\\n')",0,0,0);
	trans[1][34]	= settr(148,0,50,25,25,"RW.writers = (RW.writers+1)", 1, 2, 0);
	T = trans[ 1][50] = settr(164,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(164,0,49,0,0,"sub-sequence", 0, 2, 0);
	T = trans[ 1][49] = settr(163,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(163,2,35,0,0,"ATOMIC", 1, 2, 0);
	trans[1][35]	= settr(149,2,46,26,26,"num = 0", 1, 2, 0);
	trans[1][47]	= settr(161,2,46,1,0,".(goto)", 1, 2, 0);
	T = trans[1][46] = settr(160,2,0,0,0,"DO", 1, 2, 0);
	T = T->nxt	= settr(160,2,36,0,0,"DO", 1, 2, 0);
	    T->nxt	= settr(160,2,43,0,0,"DO", 1, 2, 0);
	trans[1][36]	= settr(150,2,40,27,0,"((num<2))", 1, 2, 0);
	T = trans[1][40] = settr(154,2,0,0,0,"IF", 1, 2, 0);
	T = T->nxt	= settr(154,2,37,0,0,"IF", 1, 2, 0);
	    T->nxt	= settr(154,2,39,0,0,"IF", 1, 2, 0);
	trans[1][37]	= settr(151,2,46,28,28,"((waitR[num]>0))", 1, 2, 0); /* m: 38 -> 46,0 */
	reached1[38] = 1;
	trans[1][38]	= settr(0,0,0,0,0,"waitR[num] = (waitR[num]-1)",0,0,0);
	trans[1][41]	= settr(155,2,42,1,0,".(goto)", 1, 2, 0); /* m: 42 -> 0,46 */
	reached1[42] = 1;
	trans[1][39]	= settr(153,2,42,2,0,"else", 1, 2, 0);
	trans[1][42]	= settr(156,2,46,29,29,"num = (num+1)", 1, 2, 0);
	trans[1][43]	= settr(157,2,44,2,0,"else", 1, 2, 0);
	trans[1][44]	= settr(158,2,48,30,30,"printf('MSC: [array]--\\n')", 1, 2, 0); /* m: 45 -> 0,48 */
	reached1[45] = 1;
	trans[1][45]	= settr(159,2,48,1,0,"goto :b5", 1, 2, 0);
	trans[1][48]	= settr(162,0,66,1,0,"break", 1, 2, 0);
	T = trans[ 1][66] = settr(180,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(180,0,65,0,0,"sub-sequence", 0, 2, 0);
	T = trans[ 1][65] = settr(179,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(179,2,51,0,0,"ATOMIC", 1, 2, 0);
	trans[1][51]	= /* c */ settr(165,2,62,26,26,"num = 0", 1, 2, 0);
	trans[1][63]	= settr(177,2,62,1,0,".(goto)", 1, 2, 0);
	T = trans[1][62] = settr(176,2,0,0,0,"DO", 1, 2, 0);
	T = T->nxt	= settr(176,2,52,0,0,"DO", 1, 2, 0);
	    T->nxt	= settr(176,2,59,0,0,"DO", 1, 2, 0);
	trans[1][52]	= /* c */ settr(166,2,56,27,0,"((num<2))", 1, 2, 0);
	T = trans[1][56] = settr(170,2,0,0,0,"IF", 1, 2, 0);
	T = T->nxt	= settr(170,2,53,0,0,"IF", 1, 2, 0);
	    T->nxt	= settr(170,2,55,0,0,"IF", 1, 2, 0);
	trans[1][53]	= settr(167,2,62,31,31,"((waitW[num]>0))", 1, 2, 0); /* m: 54 -> 62,0 */
	reached1[54] = 1;
	trans[1][54]	= settr(0,0,0,0,0,"waitW[num] = (waitW[num]-1)",0,0,0);
	trans[1][57]	= settr(171,2,58,1,0,".(goto)", 1, 2, 0); /* m: 58 -> 0,62 */
	reached1[58] = 1;
	trans[1][55]	= settr(169,2,58,2,0,"else", 1, 2, 0);
	trans[1][58]	= settr(172,2,62,32,32,"num = (num+1)", 1, 2, 0);
	trans[1][59]	= settr(173,2,60,2,0,"else", 1, 2, 0);
	trans[1][60]	= settr(174,2,64,33,33,"printf('MSC: [array]--\\n')", 1, 2, 0); /* m: 61 -> 0,64 */
	reached1[61] = 1;
	trans[1][61]	= settr(175,2,64,1,0,"goto :b6", 1, 2, 0);
	trans[1][64]	= settr(178,0,70,1,0,"break", 1, 2, 0);
	T = trans[ 1][70] = settr(184,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(184,0,69,0,0,"sub-sequence", 0, 2, 0);
	T = trans[ 1][69] = settr(183,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(183,2,67,0,0,"ATOMIC", 1, 2, 0);
	trans[1][67]	= settr(181,0,73,34,34,"lock = 0", 1, 2, 0); /* m: 68 -> 0,73 */
	reached1[68] = 1;
	trans[1][68]	= settr(0,0,0,0,0,"printf('MSC: leaveMon()\\n')",0,0,0);
	trans[1][72]	= settr(0,0,0,0,0,"printf('MSC: ==CS== begin\\n')",0,0,0);
	trans[1][73]	= settr(187,0,74,35,35,"critW[i] = 1", 1, 2, 0);
	trans[1][74]	= settr(188,0,75,36,36,"crW = (crW+1)", 1, 2, 0);
	trans[1][75]	= settr(189,0,76,37,37,"crW = (crW-1)", 1, 2, 0);
	trans[1][76]	= settr(190,0,77,38,38,"critW[i] = 0", 1, 2, 0);
	trans[1][77]	= settr(191,0,130,39,0,"printf('MSC: ==CS== end\\n')", 0, 2, 0);
	T = trans[ 1][130] = settr(244,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(244,0,82,0,0,"sub-sequence", 0, 2, 0);
	T = trans[ 1][82] = settr(196,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(196,0,81,0,0,"sub-sequence", 0, 2, 0);
	T = trans[ 1][81] = settr(195,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(195,2,78,0,0,"ATOMIC", 1, 2, 0);
	trans[1][78]	= settr(192,0,84,40,40,"(!(lock))", 1, 2, 0); /* m: 79 -> 84,0 */
	reached1[79] = 1;
	trans[1][79]	= settr(0,0,0,0,0,"lock = 1",0,0,0);
	trans[1][80]	= settr(0,0,0,0,0,"printf('MSC: enterMon()\\n')",0,0,0);
	trans[1][83]	= settr(0,0,0,0,0,"printf('MSC: EndWrite\\n')",0,0,0);
	trans[1][84]	= settr(198,0,85,41,41,"RW.writers = (RW.writers-1)", 1, 2, 0);
	trans[1][85]	= settr(199,0,99,42,42,"countZeros = 0", 0, 2, 0); /* m: 86 -> 0,99 */
	reached1[86] = 1;
	trans[1][86]	= settr(0,0,0,0,0,"t = 0",0,0,0);
	T = trans[ 1][99] = settr(213,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(213,2,96,0,0,"ATOMIC", 1, 2, 0);
	trans[1][97]	= settr(211,2,96,1,0,".(goto)", 1, 2, 0);
	T = trans[1][96] = settr(210,2,0,0,0,"DO", 1, 2, 0);
	T = T->nxt	= settr(210,2,87,0,0,"DO", 1, 2, 0);
	    T->nxt	= settr(210,2,94,0,0,"DO", 1, 2, 0);
	trans[1][87]	= settr(201,2,91,43,0,"((t<2))", 1, 2, 0);
	T = trans[1][91] = settr(205,2,0,0,0,"IF", 1, 2, 0);
	T = T->nxt	= settr(205,2,88,0,0,"IF", 1, 2, 0);
	    T->nxt	= settr(205,2,90,0,0,"IF", 1, 2, 0);
	trans[1][88]	= settr(202,2,96,44,44,"((waitR[t]==0))", 1, 2, 0); /* m: 89 -> 96,0 */
	reached1[89] = 1;
	trans[1][89]	= settr(0,0,0,0,0,"countZeros = (countZeros+1)",0,0,0);
	trans[1][92]	= settr(206,2,93,1,0,".(goto)", 1, 2, 0); /* m: 93 -> 0,96 */
	reached1[93] = 1;
	trans[1][90]	= settr(204,2,93,2,0,"else", 1, 2, 0);
	trans[1][93]	= settr(207,2,96,45,45,"t = (t+1)", 1, 2, 0);
	trans[1][94]	= settr(208,2,95,2,0,"else", 1, 2, 0);
	trans[1][95]	= settr(209,2,98,1,0,"goto :b7", 1, 2, 0);
	trans[1][98]	= settr(212,0,100,1,0,"break", 1, 2, 0);
	trans[1][100]	= settr(214,0,125,46,0,"printf('MSC: %d > %d - %d \\n',countZeros,2,RW.OKtoRead.waiting)", 1, 2, 0);
	T = trans[ 1][125] = settr(239,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(239,2,123,0,0,"ATOMIC", 1, 2, 0);
	T = trans[1][123] = settr(237,2,0,0,0,"IF", 1, 2, 0);
	T = T->nxt	= settr(237,2,101,0,0,"IF", 1, 2, 0);
	    T->nxt	= settr(237,2,112,0,0,"IF", 1, 2, 0);
	trans[1][101]	= settr(215,2,111,47,47,"((countZeros>(2-RW.OKtoRead.waiting)))", 1, 2, 0); /* m: 102 -> 111,0 */
	reached1[102] = 1;
	trans[1][102]	= settr(0,0,0,0,0,"printf('MSC: signal(OKtoRead)\\n')",0,0,0);
	T = trans[ 1][111] = settr(225,0,0,0,0,"sub-sequence", 1, 2, 0);
	T->nxt	= settr(225,0,110,0,0,"sub-sequence", 1, 2, 0);
	T = trans[ 1][110] = settr(224,0,0,0,0,"sub-sequence", 1, 2, 0);
	T->nxt	= settr(224,0,108,0,0,"sub-sequence", 1, 2, 0);
	T = trans[1][108] = settr(222,2,0,0,0,"IF", 1, 2, 0);
	T = T->nxt	= settr(222,2,103,0,0,"IF", 1, 2, 0);
	    T->nxt	= settr(222,2,107,0,0,"IF", 1, 2, 0);
	trans[1][103]	= settr(217,2,105,48,48,"((RW.OKtoRead.waiting>0))", 1, 2, 0); /* m: 104 -> 105,0 */
	reached1[104] = 1;
	trans[1][104]	= settr(0,0,0,0,0,"RW.OKtoRead.gate = 1",0,0,0);
	trans[1][105]	= settr(219,4,129,49,49,"(!(lock))", 1, 2, 0); /* m: 106 -> 129,0 */
	reached1[106] = 1;
	trans[1][106]	= settr(0,0,0,0,0,"lock = 1",0,0,0);
	trans[1][109]	= settr(223,4,129,50,50,".(goto)", 1, 2, 0); /* m: 124 -> 0,129 */
	reached1[124] = 1;
	trans[1][107]	= settr(221,2,109,2,0,"else", 1, 2, 0);
	trans[1][124]	= settr(238,0,129,51,51,".(goto)", 1, 2, 0);
	trans[1][112]	= settr(226,2,113,2,0,"else", 1, 2, 0);
	trans[1][113]	= settr(227,2,122,52,0,"printf('MSC: signal(OKtoWrite)\\n')", 1, 2, 0);
	T = trans[ 1][122] = settr(236,0,0,0,0,"sub-sequence", 1, 2, 0);
	T->nxt	= settr(236,0,121,0,0,"sub-sequence", 1, 2, 0);
	T = trans[ 1][121] = settr(235,0,0,0,0,"sub-sequence", 1, 2, 0);
	T->nxt	= settr(235,0,119,0,0,"sub-sequence", 1, 2, 0);
	T = trans[1][119] = settr(233,2,0,0,0,"IF", 1, 2, 0);
	T = T->nxt	= settr(233,2,114,0,0,"IF", 1, 2, 0);
	    T->nxt	= settr(233,2,118,0,0,"IF", 1, 2, 0);
	trans[1][114]	= settr(228,2,116,53,53,"((RW.OKtoWrite.waiting>0))", 1, 2, 0); /* m: 115 -> 116,0 */
	reached1[115] = 1;
	trans[1][115]	= settr(0,0,0,0,0,"RW.OKtoWrite.gate = 1",0,0,0);
	trans[1][116]	= settr(230,4,129,54,54,"(!(lock))", 1, 2, 0); /* m: 117 -> 129,0 */
	reached1[117] = 1;
	trans[1][117]	= settr(0,0,0,0,0,"lock = 1",0,0,0);
	trans[1][120]	= settr(234,4,129,55,55,".(goto)", 1, 2, 0); /* m: 124 -> 0,129 */
	reached1[124] = 1;
	trans[1][118]	= settr(232,2,120,2,0,"else", 1, 2, 0);
	T = trans[ 1][129] = settr(243,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(243,0,128,0,0,"sub-sequence", 0, 2, 0);
	T = trans[ 1][128] = settr(242,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(242,2,126,0,0,"ATOMIC", 1, 2, 0);
	trans[1][126]	= settr(240,0,131,56,56,"lock = 0", 1, 2, 0); /* m: 127 -> 0,131 */
	reached1[127] = 1;
	trans[1][127]	= settr(0,0,0,0,0,"printf('MSC: leaveMon()\\n')",0,0,0);
	trans[1][133]	= settr(247,0,134,1,0,"break", 0, 2, 0);
	trans[1][134]	= settr(248,0,0,57,57,"-end-", 0, 3500, 0);

	/* proctype 0: reader */

	trans[0] = (Trans **) emalloc(116*sizeof(Trans *));

	trans[0][113]	= settr(112,0,112,1,0,".(goto)", 0, 2, 0);
	T = trans[0][112] = settr(111,0,0,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(111,0,78,0,0,"DO", 0, 2, 0);
	T = trans[ 0][78] = settr(77,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(77,0,5,0,0,"sub-sequence", 0, 2, 0);
	T = trans[ 0][5] = settr(4,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(4,0,4,0,0,"sub-sequence", 0, 2, 0);
	T = trans[ 0][4] = settr(3,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(3,2,1,0,0,"ATOMIC", 1, 2, 0);
	trans[0][1]	= settr(0,4,6,58,58,"(!(lock))", 1, 2, 0); /* m: 2 -> 6,0 */
	reached0[2] = 1;
	trans[0][2]	= settr(0,0,0,0,0,"lock = 1",0,0,0);
	trans[0][3]	= settr(0,0,0,0,0,"printf('MSC: enterMon()\\n')",0,0,0);
	trans[0][6]	= settr(5,0,7,59,59,"wantR[i] = 1", 1, 2, 0);
	trans[0][7]	= settr(6,0,8,60,60,"wantR[i] = 0", 1, 2, 0);
	trans[0][8]	= settr(7,0,9,61,0,"printf('MSC: startRead\\n')", 0, 2, 0);
	trans[0][9]	= settr(8,0,25,62,62,"waitR[i] = RW.OKtoWrite.waiting", 1, 2, 0);
	T = trans[ 0][25] = settr(24,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(24,2,23,0,0,"ATOMIC", 1, 2, 0);
	T = trans[0][23] = settr(22,2,0,0,0,"IF", 1, 2, 0);
	T = T->nxt	= settr(22,2,10,0,0,"IF", 1, 2, 0);
	    T->nxt	= settr(22,2,22,0,0,"IF", 1, 2, 0);
	trans[0][10]	= settr(9,2,21,63,63,"(((RW.writers!=0)||!((RW.OKtoWrite.waiting==0))))", 1, 2, 0); /* m: 11 -> 21,0 */
	reached0[11] = 1;
	trans[0][11]	= settr(0,0,0,0,0,"printf('MSC: wait(OKtoRead)\\n')",0,0,0);
	T = trans[ 0][21] = settr(20,0,0,0,0,"sub-sequence", 1, 2, 0);
	T->nxt	= settr(20,0,20,0,0,"sub-sequence", 1, 2, 0);
	T = trans[ 0][20] = settr(19,0,0,0,0,"sub-sequence", 1, 2, 0);
	T->nxt	= settr(19,0,12,0,0,"sub-sequence", 1, 2, 0);
	trans[0][12]	= settr(11,2,14,64,64,"RW.OKtoRead.waiting = (RW.OKtoRead.waiting+1)", 1, 2, 0); /* m: 13 -> 0,14 */
	reached0[13] = 1;
	trans[0][13]	= settr(0,0,0,0,0,"lock = 0",0,0,0);
	trans[0][14]	= settr(13,2,16,65,65,"(!(waitR[i]))", 1, 2, 0); /* m: 15 -> 16,0 */
	reached0[15] = 1;
	trans[0][15]	= settr(0,0,0,0,0,"printf('MSC: my turn! wait for gate\\n')",0,0,0);
	trans[0][16]	= settr(15,0,27,66,66,"(RW.OKtoRead.gate)", 1, 2, 0); /* m: 17 -> 27,0 */
	reached0[17] = 1;
	trans[0][17]	= settr(0,0,0,0,0,"RW.OKtoRead.gate = 0",0,0,0);
	trans[0][18]	= settr(0,0,0,0,0,"RW.OKtoRead.waiting = (RW.OKtoRead.waiting-1)",0,0,0);
	trans[0][19]	= settr(0,0,0,0,0,"printf('MSC: received gate\\n')",0,0,0);
	trans[0][24]	= settr(23,0,27,67,67,".(goto)", 1, 2, 0); /* m: 26 -> 0,27 */
	reached0[26] = 1;
	trans[0][22]	= settr(21,2,24,2,0,"else", 1, 2, 0);
	trans[0][26]	= settr(0,0,0,0,0,"printf('MSC: go read\\n')",0,0,0);
	trans[0][27]	= settr(26,0,28,68,68,"RW.readers = (RW.readers+1)", 1, 2, 0);
	trans[0][28]	= settr(27,0,43,69,69,"cZeros = 0", 0, 2, 0); /* m: 29 -> 0,43 */
	reached0[29] = 1;
	trans[0][29]	= settr(0,0,0,0,0,"p = 0",0,0,0);
	T = trans[ 0][43] = settr(42,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(42,2,39,0,0,"ATOMIC", 1, 2, 0);
	trans[0][40]	= settr(39,2,39,1,0,".(goto)", 1, 2, 0);
	T = trans[0][39] = settr(38,2,0,0,0,"DO", 1, 2, 0);
	T = T->nxt	= settr(38,2,30,0,0,"DO", 1, 2, 0);
	    T->nxt	= settr(38,2,37,0,0,"DO", 1, 2, 0);
	trans[0][30]	= settr(29,2,34,70,0,"((p<2))", 1, 2, 0);
	T = trans[0][34] = settr(33,2,0,0,0,"IF", 1, 2, 0);
	T = T->nxt	= settr(33,2,31,0,0,"IF", 1, 2, 0);
	    T->nxt	= settr(33,2,33,0,0,"IF", 1, 2, 0);
	trans[0][31]	= settr(30,2,39,71,71,"((waitR[p]==0))", 1, 2, 0); /* m: 32 -> 39,0 */
	reached0[32] = 1;
	trans[0][32]	= settr(0,0,0,0,0,"cZeros = (cZeros+1)",0,0,0);
	trans[0][35]	= settr(34,2,36,1,0,".(goto)", 1, 2, 0); /* m: 36 -> 0,39 */
	reached0[36] = 1;
	trans[0][33]	= settr(32,2,36,2,0,"else", 1, 2, 0);
	trans[0][36]	= settr(35,2,39,72,72,"p = (p+1)", 1, 2, 0);
	trans[0][37]	= settr(36,2,41,2,0,"else", 1, 2, 0);
	trans[0][38]	= settr(37,2,41,1,0,"goto :b1", 1, 2, 0);
	trans[0][41]	= settr(40,2,42,1,0,"break", 1, 2, 0);
	trans[0][42]	= settr(41,0,56,73,0,"printf('MSC: %d-(%d-%d) > 0?\\n',cZeros,2,RW.OKtoRead.waiting)", 1, 2, 0);
	T = trans[0][56] = settr(55,0,0,0,0,"IF", 0, 2, 0);
	T = T->nxt	= settr(55,0,44,0,0,"IF", 0, 2, 0);
	    T->nxt	= settr(55,0,55,0,0,"IF", 0, 2, 0);
	trans[0][44]	= settr(43,0,45,74,74,"(((cZeros-(2-RW.OKtoRead.waiting))>0))", 1, 2, 0);
	trans[0][45]	= settr(44,0,54,75,0,"printf('MSC: signal(OKtoRead)\\n')", 0, 2, 0);
	T = trans[ 0][54] = settr(53,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(53,0,53,0,0,"sub-sequence", 0, 2, 0);
	T = trans[ 0][53] = settr(52,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(52,2,51,0,0,"ATOMIC", 1, 2, 0);
	T = trans[0][51] = settr(50,2,0,0,0,"IF", 1, 2, 0);
	T = T->nxt	= settr(50,2,46,0,0,"IF", 1, 2, 0);
	    T->nxt	= settr(50,2,50,0,0,"IF", 1, 2, 0);
	trans[0][46]	= settr(45,2,48,76,76,"((RW.OKtoRead.waiting>0))", 1, 2, 0); /* m: 47 -> 48,0 */
	reached0[47] = 1;
	trans[0][47]	= settr(0,0,0,0,0,"RW.OKtoRead.gate = 1",0,0,0);
	trans[0][48]	= settr(47,0,73,77,77,"(!(lock))", 1, 2, 0); /* m: 49 -> 73,0 */
	reached0[49] = 1;
	trans[0][49]	= settr(0,0,0,0,0,"lock = 1",0,0,0);
	trans[0][52]	= settr(51,0,73,78,78,".(goto)", 1, 2, 0);
	trans[0][50]	= settr(49,2,52,2,0,"else", 1, 2, 0);
	trans[0][57]	= settr(56,0,73,1,0,".(goto)", 0, 2, 0);
	trans[0][55]	= settr(54,0,73,2,0,"else", 0, 2, 0);
	T = trans[ 0][73] = settr(72,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(72,0,72,0,0,"sub-sequence", 0, 2, 0);
	T = trans[ 0][72] = settr(71,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(71,2,58,0,0,"ATOMIC", 1, 2, 0);
	trans[0][58]	= settr(57,2,69,79,79,"num = 0", 1, 2, 0);
	trans[0][70]	= settr(69,2,69,1,0,".(goto)", 1, 2, 0);
	T = trans[0][69] = settr(68,2,0,0,0,"DO", 1, 2, 0);
	T = T->nxt	= settr(68,2,59,0,0,"DO", 1, 2, 0);
	    T->nxt	= settr(68,2,66,0,0,"DO", 1, 2, 0);
	trans[0][59]	= settr(58,2,63,80,0,"((num<2))", 1, 2, 0);
	T = trans[0][63] = settr(62,2,0,0,0,"IF", 1, 2, 0);
	T = T->nxt	= settr(62,2,60,0,0,"IF", 1, 2, 0);
	    T->nxt	= settr(62,2,62,0,0,"IF", 1, 2, 0);
	trans[0][60]	= settr(59,2,69,81,81,"((waitW[num]>0))", 1, 2, 0); /* m: 61 -> 69,0 */
	reached0[61] = 1;
	trans[0][61]	= settr(0,0,0,0,0,"waitW[num] = (waitW[num]-1)",0,0,0);
	trans[0][64]	= settr(63,2,65,1,0,".(goto)", 1, 2, 0); /* m: 65 -> 0,69 */
	reached0[65] = 1;
	trans[0][62]	= settr(61,2,65,2,0,"else", 1, 2, 0);
	trans[0][65]	= settr(64,2,69,82,82,"num = (num+1)", 1, 2, 0);
	trans[0][66]	= settr(65,2,67,2,0,"else", 1, 2, 0);
	trans[0][67]	= settr(66,2,71,83,83,"printf('MSC: [array]--\\n')", 1, 2, 0); /* m: 68 -> 0,71 */
	reached0[68] = 1;
	trans[0][68]	= settr(67,2,71,1,0,"goto :b2", 1, 2, 0);
	trans[0][71]	= settr(70,0,77,1,0,"break", 1, 2, 0);
	T = trans[ 0][77] = settr(76,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(76,0,76,0,0,"sub-sequence", 0, 2, 0);
	T = trans[ 0][76] = settr(75,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(75,2,74,0,0,"ATOMIC", 1, 2, 0);
	trans[0][74]	= settr(73,0,80,84,84,"lock = 0", 1, 2, 0); /* m: 75 -> 0,80 */
	reached0[75] = 1;
	trans[0][75]	= settr(0,0,0,0,0,"printf('MSC: leaveMon()\\n')",0,0,0);
	trans[0][79]	= settr(0,0,0,0,0,"printf('MSC: ==CS== begin\\n')",0,0,0);
	trans[0][80]	= settr(79,0,81,85,85,"critR[i] = 1", 1, 2, 0);
	trans[0][81]	= settr(80,0,82,86,86,"crR = (crR+1)", 1, 2, 0);
	trans[0][82]	= settr(81,0,83,87,87,"crR = (crR-1)", 1, 2, 0);
	trans[0][83]	= settr(82,0,84,88,88,"critR[i] = 0", 1, 2, 0);
	trans[0][84]	= settr(83,0,111,89,0,"printf('MSC: ==CS== end\\n')", 0, 2, 0);
	T = trans[ 0][111] = settr(110,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(110,0,89,0,0,"sub-sequence", 0, 2, 0);
	T = trans[ 0][89] = settr(88,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(88,0,88,0,0,"sub-sequence", 0, 2, 0);
	T = trans[ 0][88] = settr(87,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(87,2,85,0,0,"ATOMIC", 1, 2, 0);
	trans[0][85]	= settr(84,0,91,90,90,"(!(lock))", 1, 2, 0); /* m: 86 -> 91,0 */
	reached0[86] = 1;
	trans[0][86]	= settr(0,0,0,0,0,"lock = 1",0,0,0);
	trans[0][87]	= settr(0,0,0,0,0,"printf('MSC: enterMon()\\n')",0,0,0);
	trans[0][90]	= settr(0,0,0,0,0,"printf('MSC: EndRead\\n')",0,0,0);
	trans[0][91]	= settr(90,0,106,91,91,"RW.readers = (RW.readers-1)", 1, 2, 0);
	T = trans[ 0][106] = settr(105,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(105,2,104,0,0,"ATOMIC", 1, 2, 0);
	T = trans[0][104] = settr(103,2,0,0,0,"IF", 1, 2, 0);
	T = T->nxt	= settr(103,2,92,0,0,"IF", 1, 2, 0);
	    T->nxt	= settr(103,2,103,0,0,"IF", 1, 2, 0);
	trans[0][92]	= settr(91,2,102,92,92,"((RW.readers==0))", 1, 2, 0); /* m: 93 -> 102,0 */
	reached0[93] = 1;
	trans[0][93]	= settr(0,0,0,0,0,"printf('MSC: signal(OKtoWrite)\\n')",0,0,0);
	T = trans[ 0][102] = settr(101,0,0,0,0,"sub-sequence", 1, 2, 0);
	T->nxt	= settr(101,0,101,0,0,"sub-sequence", 1, 2, 0);
	T = trans[ 0][101] = settr(100,0,0,0,0,"sub-sequence", 1, 2, 0);
	T->nxt	= settr(100,0,99,0,0,"sub-sequence", 1, 2, 0);
	T = trans[0][99] = settr(98,2,0,0,0,"IF", 1, 2, 0);
	T = T->nxt	= settr(98,2,94,0,0,"IF", 1, 2, 0);
	    T->nxt	= settr(98,2,98,0,0,"IF", 1, 2, 0);
	trans[0][94]	= settr(93,2,96,93,93,"((RW.OKtoWrite.waiting>0))", 1, 2, 0); /* m: 95 -> 96,0 */
	reached0[95] = 1;
	trans[0][95]	= settr(0,0,0,0,0,"RW.OKtoWrite.gate = 1",0,0,0);
	trans[0][96]	= settr(95,4,110,94,94,"(!(lock))", 1, 2, 0); /* m: 97 -> 110,0 */
	reached0[97] = 1;
	trans[0][97]	= settr(0,0,0,0,0,"lock = 1",0,0,0);
	trans[0][100]	= settr(99,4,110,95,95,".(goto)", 1, 2, 0); /* m: 105 -> 0,110 */
	reached0[105] = 1;
	trans[0][98]	= settr(97,2,100,2,0,"else", 1, 2, 0);
	trans[0][105]	= settr(104,0,110,96,96,".(goto)", 1, 2, 0);
	trans[0][103]	= settr(102,2,105,2,0,"else", 1, 2, 0);
	T = trans[ 0][110] = settr(109,0,0,0,0,"sub-sequence", 0, 2, 0);
	T->nxt	= settr(109,0,109,0,0,"sub-sequence", 0, 2, 0);
	T = trans[ 0][109] = settr(108,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(108,2,107,0,0,"ATOMIC", 1, 2, 0);
	trans[0][107]	= settr(106,0,112,97,97,"lock = 0", 1, 2, 0); /* m: 108 -> 0,112 */
	reached0[108] = 1;
	trans[0][108]	= settr(0,0,0,0,0,"printf('MSC: leaveMon()\\n')",0,0,0);
	trans[0][114]	= settr(113,0,115,1,0,"break", 0, 2, 0);
	trans[0][115]	= settr(114,0,0,98,98,"-end-", 0, 3500, 0);
	/* np_ demon: */
	trans[_NP_] = (Trans **) emalloc(2*sizeof(Trans *));
	T = trans[_NP_][0] = settr(9997,0,1,_T5,0,"(np_)", 1,2,0);
	    T->nxt	  = settr(9998,0,0,_T2,0,"(1)",   0,2,0);
	T = trans[_NP_][1] = settr(9999,0,1,_T5,0,"(np_)", 1,2,0);
}

Trans *
settr(	int t_id, int a, int b, int c, int d,
	char *t, int g, int tpe0, int tpe1)
{	Trans *tmp = (Trans *) emalloc(sizeof(Trans));

	tmp->atom  = a&(6|32);	/* only (2|8|32) have meaning */
	if (!g) tmp->atom |= 8;	/* no global references */
	tmp->st    = b;
	tmp->tpe[0] = tpe0;
	tmp->tpe[1] = tpe1;
	tmp->tp    = t;
	tmp->t_id  = t_id;
	tmp->forw  = c;
	tmp->back  = d;
	return tmp;
}

Trans *
cpytr(Trans *a)
{	Trans *tmp = (Trans *) emalloc(sizeof(Trans));

	int i;
	tmp->atom  = a->atom;
	tmp->st    = a->st;
#ifdef HAS_UNLESS
	tmp->e_trans = a->e_trans;
	for (i = 0; i < HAS_UNLESS; i++)
		tmp->escp[i] = a->escp[i];
#endif
	tmp->tpe[0] = a->tpe[0];
	tmp->tpe[1] = a->tpe[1];
	for (i = 0; i < 6; i++)
	{	tmp->qu[i] = a->qu[i];
		tmp->ty[i] = a->ty[i];
	}
	tmp->tp    = (char *) emalloc(strlen(a->tp)+1);
	strcpy(tmp->tp, a->tp);
	tmp->t_id  = a->t_id;
	tmp->forw  = a->forw;
	tmp->back  = a->back;
	return tmp;
}

#ifndef NOREDUCE
int
srinc_set(int n)
{	if (n <= 2) return LOCAL;
	if (n <= 2+  DELTA) return Q_FULL_F; /* 's' or nfull  */
	if (n <= 2+2*DELTA) return Q_EMPT_F; /* 'r' or nempty */
	if (n <= 2+3*DELTA) return Q_EMPT_T; /* empty */
	if (n <= 2+4*DELTA) return Q_FULL_T; /* full  */
	if (n ==   5*DELTA) return GLOBAL;
	if (n ==   6*DELTA) return TIMEOUT_F;
	if (n ==   7*DELTA) return ALPHA_F;
	Uerror("cannot happen srinc_class");
	return BAD;
}
int
srunc(int n, int m)
{	switch(m) {
	case Q_FULL_F: return n-2;
	case Q_EMPT_F: return n-2-DELTA;
	case Q_EMPT_T: return n-2-2*DELTA;
	case Q_FULL_T: return n-2-3*DELTA;
	case ALPHA_F:
	case TIMEOUT_F: return 257; /* non-zero, and > MAXQ */
	}
	Uerror("cannot happen srunc");
	return 0;
}
#endif
int cnt;
#ifdef HAS_UNLESS
int
isthere(Trans *a, int b)
{	Trans *t;
	for (t = a; t; t = t->nxt)
		if (t->t_id == b)
			return 1;
	return 0;
}
#endif
#ifndef NOREDUCE
int
mark_safety(Trans *t) /* for conditional safety */
{	int g = 0, i, j, k;

	if (!t) return 0;
	if (t->qu[0])
		return (t->qu[1])?2:1;	/* marked */

	for (i = 0; i < 2; i++)
	{	j = srinc_set(t->tpe[i]);
		if (j >= GLOBAL && j != ALPHA_F)
			return -1;
		if (j != LOCAL)
		{	k = srunc(t->tpe[i], j);
			if (g == 0
			||  t->qu[0] != k
			||  t->ty[0] != j)
			{	t->qu[g] = k;
				t->ty[g] = j;
				g++;
	}	}	}
	return g;
}
#endif
void
retrans(int n, int m, int is, short srcln[], uchar reach[])
	/* process n, with m states, is=initial state */
{	Trans *T0, *T1, *T2, *T3;
	int i, k;
#ifndef NOREDUCE
	int g, h, j, aa;
#endif
#ifdef HAS_UNLESS
	int p;
#endif
	if (state_tables >= 4)
	{	printf("STEP 1 proctype %s\n", 
			procname[n]);
		for (i = 1; i < m; i++)
		for (T0 = trans[n][i]; T0; T0 = T0->nxt)
			crack(n, i, T0, srcln);
		return;
	}
	do {
		for (i = 1, cnt = 0; i < m; i++)
		{	T2 = trans[n][i];
			T1 = T2?T2->nxt:(Trans *)0;
/* prescan: */		for (T0 = T1; T0; T0 = T0->nxt)
/* choice in choice */	{	if (T0->st && trans[n][T0->st]
				&&  trans[n][T0->st]->nxt)
					break;
			}
#if 0
		if (T0)
		printf("\tstate %d / %d: choice in choice\n",
		i, T0->st);
#endif
			if (T0)
			for (T0 = T1; T0; T0 = T0->nxt)
			{	T3 = trans[n][T0->st];
				if (!T3->nxt)
				{	T2->nxt = cpytr(T0);
					T2 = T2->nxt;
					imed(T2, T0->st, n, i);
					continue;
				}
				do {	T3 = T3->nxt;
					T2->nxt = cpytr(T3);
					T2 = T2->nxt;
					imed(T2, T0->st, n, i);
				} while (T3->nxt);
				cnt++;
			}
		}
	} while (cnt);
	if (state_tables >= 3)
	{	printf("STEP 2 proctype %s\n", 
			procname[n]);
		for (i = 1; i < m; i++)
		for (T0 = trans[n][i]; T0; T0 = T0->nxt)
			crack(n, i, T0, srcln);
		return;
	}
	for (i = 1; i < m; i++)
	{	if (trans[n][i] && trans[n][i]->nxt) /* optimize */
		{	T1 = trans[n][i]->nxt;
#if 0
			printf("\t\tpull %d (%d) to %d\n",
			T1->st, T1->forw, i);
#endif
			if (!trans[n][T1->st]) continue;
			T0 = cpytr(trans[n][T1->st]);
			trans[n][i] = T0;
			reach[T1->st] = 1;
			imed(T0, T1->st, n, i);
			for (T1 = T1->nxt; T1; T1 = T1->nxt)
			{
#if 0
			printf("\t\tpull %d (%d) to %d\n",
				T1->st, T1->forw, i);
#endif
				if (!trans[n][T1->st]) continue;
				T0->nxt = cpytr(trans[n][T1->st]);
				T0 = T0->nxt;
				reach[T1->st] = 1;
				imed(T0, T1->st, n, i);
	}	}	}
	if (state_tables >= 2)
	{	printf("STEP 3 proctype %s\n", 
			procname[n]);
		for (i = 1; i < m; i++)
		for (T0 = trans[n][i]; T0; T0 = T0->nxt)
			crack(n, i, T0, srcln);
		return;
	}
#ifdef HAS_UNLESS
	for (i = 1; i < m; i++)
	{	if (!trans[n][i]) continue;
		/* check for each state i if an
		 * escape to some state p is defined
		 * if so, copy and mark p's transitions
		 * and prepend them to the transition-
		 * list of state i
		 */
 if (!like_java) /* the default */
 {		for (T0 = trans[n][i]; T0; T0 = T0->nxt)
		for (k = HAS_UNLESS-1; k >= 0; k--)
		{	if (p = T0->escp[k])
			for (T1 = trans[n][p]; T1; T1 = T1->nxt)
			{	if (isthere(trans[n][i], T1->t_id))
					continue;
				T2 = cpytr(T1);
				T2->e_trans = p;
				T2->nxt = trans[n][i];
				trans[n][i] = T2;
		}	}
 } else /* outermost unless checked first */
 {		Trans *T4;
		T4 = T3 = (Trans *) 0;
		for (T0 = trans[n][i]; T0; T0 = T0->nxt)
		for (k = HAS_UNLESS-1; k >= 0; k--)
		{	if (p = T0->escp[k])
			for (T1 = trans[n][p]; T1; T1 = T1->nxt)
			{	if (isthere(trans[n][i], T1->t_id))
					continue;
				T2 = cpytr(T1);
				T2->nxt = (Trans *) 0;
				T2->e_trans = p;
				if (T3)	T3->nxt = T2;
				else	T4 = T2;
				T3 = T2;
		}	}
		if (T4)
		{	T3->nxt = trans[n][i];
			trans[n][i] = T4;
		}
 }
	}
#endif
#ifndef NOREDUCE
	for (i = 1; i < m; i++)
	{
		if (a_cycles)
		{ /* moves through these states are visible */
#if PROG_LAB>0 && defined(HAS_NP)
			if (progstate[n][i])
				goto degrade;
			for (T1 = trans[n][i]; T1; T1 = T1->nxt)
				if (progstate[n][T1->st])
					goto degrade;
#endif
			if (accpstate[n][i] || visstate[n][i])
				goto degrade;
			for (T1 = trans[n][i]; T1; T1 = T1->nxt)
				if (accpstate[n][T1->st])
					goto degrade;
		}
		T1 = trans[n][i];
		if (!T1) continue;
		g = mark_safety(T1);	/* V3.3.1 */
		if (g < 0) goto degrade; /* global */
		/* check if mixing of guards preserves reduction */
		if (T1->nxt)
		{	k = 0;
			for (T0 = T1; T0; T0 = T0->nxt)
			{	if (!(T0->atom&8))
					goto degrade;
				for (aa = 0; aa < 2; aa++)
				{	j = srinc_set(T0->tpe[aa]);
					if (j >= GLOBAL && j != ALPHA_F)
						goto degrade;
					if (T0->tpe[aa]
					&&  T0->tpe[aa]
					!=  T1->tpe[0])
						k = 1;
			}	}
			/* g = 0;	V3.3.1 */
			if (k)	/* non-uniform selection */
			for (T0 = T1; T0; T0 = T0->nxt)
			for (aa = 0; aa < 2; aa++)
			{	j = srinc_set(T0->tpe[aa]);
				if (j != LOCAL)
				{	k = srunc(T0->tpe[aa], j);
					for (h = 0; h < 6; h++)
						if (T1->qu[h] == k
						&&  T1->ty[h] == j)
							break;
					if (h >= 6)
					{	T1->qu[g%6] = k;
						T1->ty[g%6] = j;
						g++;
			}	}	}
			if (g > 6)
			{	T1->qu[0] = 0;	/* turn it off */
				printf("pan: warning, line %d, ",
					srcln[i]);
			 	printf("too many stmnt types (%d)",
					g);
			  	printf(" in selection\n");
			  goto degrade;
			}
		}
		/* mark all options global if >=1 is global */
		for (T1 = trans[n][i]; T1; T1 = T1->nxt)
			if (!(T1->atom&8)) break;
		if (T1)
degrade:	for (T1 = trans[n][i]; T1; T1 = T1->nxt)
			T1->atom &= ~8;	/* mark as unsafe */
		/* can only mix 'r's or 's's if on same chan */
		/* and not mixed with other local operations */
		T1 = trans[n][i];
		if (!T1 || T1->qu[0]) continue;
		j = T1->tpe[0];
		if (T1->nxt && T1->atom&8)
		{ if (j == 5*DELTA)
		  {	printf("warning: line %d ", srcln[i]);
			printf("mixed condition ");
			printf("(defeats reduction)\n");
			goto degrade;
		  }
		  for (T0 = T1; T0; T0 = T0->nxt)
		  for (aa = 0; aa < 2; aa++)
		  if  (T0->tpe[aa] && T0->tpe[aa] != j)
		  {	printf("warning: line %d ", srcln[i]);
			printf("[%d-%d] mixed %stion ",
				T0->tpe[aa], j, 
				(j==5*DELTA)?"condi":"selec");
			printf("(defeats reduction)\n");
			printf("	'%s' <-> '%s'\n",
				T1->tp, T0->tp);
			goto degrade;
		} }
	}
#endif
	for (i = 1; i < m; i++)
	{	T2 = trans[n][i];
		if (!T2
		||  T2->nxt
		||  strncmp(T2->tp, ".(goto)", 7)
		||  !stopstate[n][i])
			continue;
		stopstate[n][T2->st] = 1;
	}
	if (state_tables)
	{	printf("proctype ");
		if (!strcmp(procname[n], ":init:"))
			printf("init\n");
		else
			printf("%s\n", procname[n]);
		for (i = 1; i < m; i++)
			reach[i] = 1;
		tagtable(n, m, is, srcln, reach);
	} else
	for (i = 1; i < m; i++)
	{	int nrelse;
		if (strcmp(procname[n], ":never:") != 0)
		{	for (T0 = trans[n][i]; T0; T0 = T0->nxt)
			{	if (T0->st == i
				&& strcmp(T0->tp, "(1)") == 0)
				{	printf("error: proctype '%s' ",
						procname[n]);
		  			printf("line %d, state %d: has un",
						srcln[i], i);
					printf("conditional self-loop\n");
					pan_exit(1);
		}	}	}
		nrelse = 0;
		for (T0 = trans[n][i]; T0; T0 = T0->nxt)
		{	if (strcmp(T0->tp, "else") == 0)
				nrelse++;
		}
		if (nrelse > 1)
		{	printf("error: proctype '%s' state",
				procname[n]);
		  	printf(" %d, inherits %d", i, nrelse);
		  	printf(" 'else' stmnts\n");
			pan_exit(1);
	}	}
	if (!state_tables && strcmp(procname[n], ":never:") == 0)
	{	int h = 0;
		for (i = 1; i < m; i++)
		for (T0 = trans[n][i]; T0; T0 = T0->nxt)
			if (T0->forw > h) h = T0->forw;
		h++;
		frm_st0 = (short *) emalloc(h * sizeof(short));
		for (i = 1; i < m; i++)
		for (T0 = trans[n][i]; T0; T0 = T0->nxt)
			frm_st0[T0->forw] = i;
	}
}
void
imed(Trans *T, int v, int n, int j)	/* set intermediate state */
{	progstate[n][T->st] |= progstate[n][v];
	accpstate[n][T->st] |= accpstate[n][v];
	stopstate[n][T->st] |= stopstate[n][v];
	mapstate[n][j] = T->st;
}
void
tagtable(int n, int m, int is, short srcln[], uchar reach[])
{	Trans *z;

	if (is >= m || !trans[n][is]
	||  is <= 0 || reach[is] == 0)
		return;
	reach[is] = 0;
	if (state_tables)
	for (z = trans[n][is]; z; z = z->nxt)
		crack(n, is, z, srcln);
	for (z = trans[n][is]; z; z = z->nxt)
	{
#ifdef HAS_UNLESS
		int i, j;
#endif
		tagtable(n, m, z->st, srcln, reach);
#ifdef HAS_UNLESS
		for (i = 0; i < HAS_UNLESS; i++)
		{	j = trans[n][is]->escp[i];
			if (!j) break;
			tagtable(n, m, j, srcln, reach);
		}
#endif
	}
}
void
crack(int n, int j, Trans *z, short srcln[])
{	int i;

	if (!z) return;
	printf("	state %3d -(tr %3d)-> state %3d  ",
		j, z->forw, z->st);
	printf("[id %3d tp %3d", z->t_id, z->tpe[0]);
	if (z->tpe[1]) printf(",%d", z->tpe[1]);
#ifdef HAS_UNLESS
	if (z->e_trans)
		printf(" org %3d", z->e_trans);
	else if (state_tables >= 2)
	for (i = 0; i < HAS_UNLESS; i++)
	{	if (!z->escp[i]) break;
		printf(" esc %d", z->escp[i]);
	}
#endif
	printf("]");
	printf(" [%s%s%s%s%s] line %d => ",
		z->atom&6?"A":z->atom&32?"D":"-",
		accpstate[n][j]?"a" :"-",
		stopstate[n][j]?"e" : "-",
		progstate[n][j]?"p" : "-",
		z->atom & 8 ?"L":"G",
		srcln[j]);
	for (i = 0; z->tp[i]; i++)
		if (z->tp[i] == '\n')
			printf("\\n");
		else
			putchar(z->tp[i]);
	if (z->qu[0])
	{	printf("\t[");
		for (i = 0; i < 6; i++)
			if (z->qu[i])
				printf("(%d,%d)",
				z->qu[i], z->ty[i]);
		printf("]");
	}
	printf("\n");
	fflush(stdout);
}

#ifdef VAR_RANGES
#define BYTESIZE	32	/* 2^8 : 2^3 = 256:8 = 32 */

typedef struct Vr_Ptr {
	char	*nm;
	uchar	vals[BYTESIZE];
	struct Vr_Ptr *nxt;
} Vr_Ptr;
Vr_Ptr *ranges = (Vr_Ptr *) 0;

void
logval(char *s, int v)
{	Vr_Ptr *tmp;

	if (v<0 || v > 255) return;
	for (tmp = ranges; tmp; tmp = tmp->nxt)
		if (!strcmp(tmp->nm, s))
			goto found;
	tmp = (Vr_Ptr *) emalloc(sizeof(Vr_Ptr));
	tmp->nxt = ranges;
	ranges = tmp;
	tmp->nm = s;
found:
	tmp->vals[(v)/8] |= 1<<((v)%8);
}

void
dumpval(uchar X[], int range)
{	int w, x, i, j = -1;

	for (w = i = 0; w < range; w++)
	for (x = 0; x < 8; x++, i++)
	{
from:		if ((X[w] & (1<<x)))
		{	printf("%d", i);
			j = i;
			goto upto;
	}	}
	return;
	for (w = 0; w < range; w++)
	for (x = 0; x < 8; x++, i++)
	{
upto:		if (!(X[w] & (1<<x)))
		{	if (i-1 == j)
				printf(", ");
			else
				printf("-%d, ", i-1);
			goto from;
	}	}
	if (j >= 0 && j != 255)
		printf("-255");
}

void
dumpranges(void)
{	Vr_Ptr *tmp;
	printf("\nValues assigned within ");
	printf("interval [0..255]:\n");
	for (tmp = ranges; tmp; tmp = tmp->nxt)
	{	printf("\t%s\t: ", tmp->nm);
		dumpval(tmp->vals, BYTESIZE);
		printf("\n");
	}
}
#endif
