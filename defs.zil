;"***************************************************************************"
; "game : Abyss"
; "file : DEFS.ZIL"
; "auth :   $Author:   DEB  $"
; "date :     $Date:   20 Mar 1989  8:43:52  $"
; "rev  : $Revision:   1.28  $"
; "vers : 1.0"
;"---------------------------------------------------------------------------"
; "Default substitutions"
; "Copyright (C) 1988 Infocom, Inc.  All rights reserved."
;"***************************************************************************"
 
<INCLUDE "BASEDEFS" "PBITDEFS" "SYMBOLS">
 
<COMPILATION-FLAG P-PS-COMMA T>
<COMPILATION-FLAG P-PS-QUOTE T>
<COMPILATION-FLAG P-DEBUGGING-PARSER T>
 
<TERMINALS
	VERB NOUN ADJ ADV QUANT MISCWORD DIR TOBE QWORD CANDO COMMA PARTICLE PREP
	ASKWORD ;PRONOUN QUOTE
>
 
<ADD-TELL-TOKENS
	D *						<RT-PRINT-DESC .X>
	a *						<RT-PRINT-OBJ .X ,K-ART-A>
	A *						<RT-PRINT-OBJ .X ,K-ART-A T>
	a+verb *	*:STRING		<RT-PRINT-OBJ .X ,K-ART-A <> .Y>
	A+verb *	*:STRING		<RT-PRINT-OBJ .X ,K-ART-A T .Y>
	any *						<RT-PRINT-OBJ .X ,K-ART-ANY>
	Any *						<RT-PRINT-OBJ .X ,K-ART-ANY T>
	the *						<RT-PRINT-OBJ .X ,K-ART-THE>
	the+verb * *:STRING	<RT-PRINT-OBJ .X ,K-ART-THE <> .Y>
	The *						<RT-PRINT-OBJ .X ,K-ART-THE T>
	The+verb * *:STRING	<RT-PRINT-OBJ .X ,K-ART-THE T .Y>
	he *						<RT-PRINT-OBJ .X ,K-ART-HE>
	he+verb * *:STRING	<RT-PRINT-OBJ .X ,K-ART-HE <> .Y>
	He *						<RT-PRINT-OBJ .X ,K-ART-HE T>
	He+verb * *:STRING	<RT-PRINT-OBJ .X ,K-ART-HE T .Y>
	him *						<RT-PRINT-OBJ .X ,K-ART-HIM>
	his *						<RT-PRINT-OBJ .X ,K-ART-HIS>
	His *						<RT-PRINT-OBJ .X ,K-ART-HIS T>
	verb * *:STRING		<RT-PRINT-VERB .X .Y>
	in *						<RT-IN-ON-MSG .X>
	In *						<RT-IN-ON-MSG .X T>
	out *						<RT-OUT-OFF-MSG .X>
	Out *						<RT-OUT-OFF-MSG .X T>
	vw							<PRINTB ,P-PRSA-WORD>
	open *					<RT-OPEN-MSG .X>
	wn *						<RT-WORD-NUMBERS .X>
	comma *					<RT-COMMA-MSG .X>
	TAB						<PRINTC ,TAB>
>
 
<PROPDEF SIZE <>
	(SIZE S:FIX "OPT" CAPACITY C:FIX = 2
		(K-SIZ-SIZ <BYTE .S>)
		(K-SIZ-CAP <BYTE .C>)
	)
	(CAPACITY C:FIX "OPT" SIZE S:FIX = 2
		(K-SIZ-SIZ <BYTE .S>)
		(K-SIZ-CAP <BYTE .C>)
	)
>
<CONSTANT K-CAP-MAX 255>
 
<CONSTANT K-UP		129>
<CONSTANT K-DOWN	130>
<CONSTANT K-LEFT	131>
<CONSTANT K-RIGHT	132>
<CONSTANT K-F1		133>
<CONSTANT K-F2		134>
<CONSTANT K-F3		135>
<CONSTANT K-F4		136>
<CONSTANT K-F5		137>
<CONSTANT K-F6		138>
<CONSTANT K-F7		139>
<CONSTANT K-F8		140>
<CONSTANT K-F9		141>
<CONSTANT K-F10	142>
<CONSTANT K-F11	143>
<CONSTANT K-F12	144>
<CONSTANT K-CLICK1	254>
<CONSTANT K-CLICK2	253>
 
<CONSTANT TCHARS
	<TABLE (KERNEL BYTE)
		!\ 
		K-UP
		K-DOWN
		K-LEFT
		K-RIGHT
		K-F1
		K-F2
		K-F3
		K-F4
		K-F5
		K-F6
		K-F7
		K-F8
		K-F9
		K-F10
		K-F11
		K-F12
		K-CLICK1
		K-CLICK2
		0
	>
>
 
<REPLACE-DEFINITION DIR-VERB-PRSI?
	<CONSTANT DIR-VERB-PRSI? <>>
; "The following is surrounded by quotes so that the atoms PARSE-ACTION and
	NOUN-PHRASE-OBJ1 do not get defined."
; "<DEFINE DIR-VERB-PRSI? (NP)
		<AND
			<EQUAL? <PARSE-ACTION ,PARSE-RESULT>
				,V?MOVE-DIR ,V?RIDE-DIR ,V?ROLL-DIR ,V?SET-DIR
			>
			<NOT <EQUAL? <NOUN-PHRASE-OBJ1 .NP> ,INTDIR ,LEFT-RIGHT>>
		>
	>"
>
 
<REPLACE-DEFINITION COLLECTIVE-VERB?
	<CONSTANT COLLECTIVE-VERB? <>>
>
 
<REPLACE-DEFINITION NO-M-WINNER-VERB?
	<CONSTANT NO-M-WINNER-VERB-TABLE
		<PLTABLE V?TELL-ABOUT ;V?GIVE-SWP ;V?SHOW-SWP ;V?RUB-SWP ;V?PUT-ON-SWP>
	>
	<ROUTINE NO-M-WINNER-VERB? ()
		<COND
			(<INTBL? ,PRSA <ZREST ,NO-M-WINNER-VERB-TABLE 2>
					<ZGET ,NO-M-WINNER-VERB-TABLE 0>
				>
				<RTRUE>
			)
		>
	>
>
 
<REPLACE-DEFINITION SPEAKING-VERB?
	<ROUTINE SPEAKING-VERB? ()
		<EQUAL? ,PRSA
			,V?ASK-ABOUT
		;	,V?ASK-FOR
		;	,V?CALL
		;	,V?GOODBYE
		;	,V?HELLO
		;	,V?SAY
			,V?TALK-TO
			,V?TELL
			,V?TELL-ABOUT
		;	,V?THANK
		>
	>
>
 
<REPLACE-DEFINITION CONTBIT		<CONSTANT CONTBIT			FL-CONTAINER>>
<REPLACE-DEFINITION FEMALE			<CONSTANT FEMALE			FL-FEMALE>>
<REPLACE-DEFINITION INVISIBLE		<CONSTANT INVISIBLE		FL-INVISIBLE>>
<REPLACE-DEFINITION NARTICLEBIT	<CONSTANT NARTICLEBIT	FL-NO-ARTICLE>>
<REPLACE-DEFINITION ONBIT			<CONSTANT ONBIT			FL-LIGHTED>>
<REPLACE-DEFINITION OPENBIT		<CONSTANT OPENBIT			FL-OPEN>>
<REPLACE-DEFINITION PERSONBIT		<CONSTANT PERSONBIT		FL-PERSON>>
<REPLACE-DEFINITION PLURAL			<CONSTANT PLURAL			FL-PLURAL>>
<REPLACE-DEFINITION ROOMSBIT		<CONSTANT ROOMSBIT		FL-ROOMS>>
<REPLACE-DEFINITION SEARCHBIT		<CONSTANT SEARCHBIT		FL-SEARCH>>
<REPLACE-DEFINITION SURFACEBIT	<CONSTANT SURFACEBIT		FL-SURFACE>>
<REPLACE-DEFINITION TAKEBIT		<CONSTANT TAKEBIT			FL-TAKEABLE>>
<REPLACE-DEFINITION TOUCHBIT		<CONSTANT TOUCHBIT		FL-TOUCHED>>
<REPLACE-DEFINITION TRANSBIT		<CONSTANT TRANSBIT		FL-TRANSPARENT>>
<REPLACE-DEFINITION TRYTAKEBIT	<CONSTANT TRYTAKEBIT		FL-TRY-TAKE>>
 
<REPLACE-DEFINITION PLAYER <CONSTANT PLAYER CH-PLAYER>>
 
<REPLACE-DEFINITION GAME-VERB?
	<ROUTINE GAME-VERB? ()
		%<DEBUG-CODE
			<COND
				(<EQUAL? ,PRSA ,V?COMMAND ,V?RECORD ,V?UNRECORD>
					<RTRUE>
				)
			>
		>
		<COND
			(<EQUAL? ,PRSA
,V?QUIT ,V?RESTART ,V?RESTORE ,V?SAVE ,V?SCRIPT ,V?VERIFY ,V?DESC-LEVEL
,V?$REFRESH ,V?VERSION ,V?DIAGNOSE
				>
				<RTRUE>
			)
		>
	>
>
 
<REPLACE-DEFINITION ITAKE-CHECK
	<ROUTINE ITAKE-CHECK (OBJ BITS "AUX" (TAKEN <>) V)
		<COND
			(<AND <NOT <HELD? .OBJ ,WINNER>>
					<NOT <EQUAL? .OBJ ,TH-HANDS ,ROOMS>>
				>
				<COND
					(<FSET? .OBJ ,FL-TRY-TAKE>
						T
					)
					(<NOT <RT-META-IN? .OBJ ,WINNER>>
						T
					)
					(<RT-META-IN? ,WINNER .OBJ>
						T
					)
				;	(<NOT <EQUAL? ,WINNER ,CH-PLAYER>>
						<SET TAKEN T>
					)
					(<BTST .BITS ,SEARCH-DO-TAKE>
						<SET V <ITAKE .OBJ <>>>
						<COND
							(<AND .V
									<NOT <EQUAL? .V ,M-FATAL>>
								>
								<SET TAKEN T>
							)
						>
					)
				>
				<COND
					(<AND <NOT .TAKEN>
							<BTST .BITS ,SEARCH-MUST-HAVE>
						>
						<THIS-IS-IT .OBJ>
						<TELL !\[ The+verb ,WINNER "are" "n't holding" the .OBJ ".]" CR>
					)
				>
			)
		>
	>
>
 
<REPLACE-DEFINITION NOT-HERE-VERB?
	<ROUTINE NOT-HERE-VERB? (V)
		<RFALSE>
	>
>
 
<REPLACE-DEFINITION QCONTEXT-CHECK
	<ROUTINE QCONTEXT-CHECK (PER "AUX" WHO)
		<COND
			(<OR	<AND
						<EQUAL? ,PRSA ;,V?SHOW ,V?TELL-ABOUT>
						<EQUAL? .PER ,PLAYER>
					>
				;	<AND
						<EQUAL? ,PRSA ,V?HELLO ,V?GOODBYE>
						<EQUAL? .PER <> ,ROOMS>
					>
				>
				<COND
					(<SET WHO <FIND-A-WINNER ,HERE>>
						<SETG QCONTEXT .WHO>
					)
				>
				<COND
					(<AND <QCONTEXT-GOOD?>
							<EQUAL? ,WINNER ,PLAYER> ;"? more?"
						>
						<SETG WINNER ,QCONTEXT>
						<TELL-SAID-TO ,QCONTEXT>
						<RTRUE>
					)
				>
			)
		>
	>
>
 
<REPLACE-DEFINITION TELL-SAID-TO
	<DEFINE TELL-SAID-TO (PER)
		<TELL "[said to" the .PER !\] CR>
	>
>
 
<REPLACE-DEFINITION FIND-A-WINNER
	<DEFINE FIND-A-WINNER ACT ("OPT" (RM ,HERE) "AUX" (WHO <>))
		<COND
			(<AND ,QCONTEXT
					<IN? ,QCONTEXT .RM>
				>
				,QCONTEXT
			)
			(<SET WHO <FIND-FLAG ,HERE ,FL-PERSON ,CH-PLAYER>>
				<RETURN .WHO .ACT>
			)
			(<SET WHO <FIND-FLAG ,HERE ,FL-ALIVE ,CH-PLAYER>>
				<RETURN .WHO .ACT>
			)
			(T
				<RETURN <> .ACT>
			)
		>
	>
>
 
<REPLACE-DEFINITION VERB-ALL-TEST
	<ROUTINE VERB-ALL-TEST (O I "AUX" L)
		<SET L <LOC .O>>
		<COND
			(<FSET? .O ,FL-NO-ALL>
				<RFALSE>
			)
			(<EQUAL? ,PRSA ,V?DROP ;,V?THROW ;,V?THROW-OVER ;,V?GIVE>
				<COND
					(<FSET? .O ,FL-WORN>
						<RFALSE>
					)
					(<EQUAL? .L ,WINNER>
						<RTRUE>
					)
					(T
						<RFALSE>
					)
				>
			)
			(<EQUAL? ,PRSA ,V?PUT ,V?PUT-IN>
				<COND
					(<EQUAL? .O .I>
						<RFALSE>
					)
					(<FSET? .O ,FL-WORN>
						<RFALSE>
					)
					(<NOT <IN? .O .I>>
						<RTRUE>
					)
					(T
						<RFALSE>
					)
				>
			)
			(<EQUAL? ,PRSA ,V?TAKE>
				<COND
					(<RT-META-IN? ,WINNER .O>
						<RFALSE>
					)
					(<IN? .O ,WINNER>
						<RFALSE>
					)
					(<AND <NOT .I>
							<RT-META-IN? .O ,WINNER>
						>
						<RFALSE>
					)
					(<FSET? .O ,FL-WORN>
						<RFALSE>
					)
					(<NOT <FSET? .O ,FL-TAKEABLE>>
						<RFALSE>
					)
					(<AND .I <NOT <EQUAL? .L .I>>>
						<RFALSE>
					)
					(<EQUAL? .L ,HERE>
						<RTRUE>
					)
					(<OR	<FSET? .L ,FL-PERSON>
							<FSET? .L ,FL-SURFACE>
						>
						<RTRUE>
					)
					(<AND <FSET? .L ,FL-CONTAINER>
							<FSET? .L ,FL-OPEN>
						>
						<RTRUE>
					)
					(T
						<RFALSE>
					)
				>
			)
			(<NOT <ZERO? .I>>
				<COND
					(<NOT <EQUAL? .O .I>>
						<RTRUE>
					)
					(T
						<RFALSE>
					)
				>
			)
			(T
				<RTRUE>
			)
		>
	>
>
 
<REPLACE-DEFINITION NOT-HERE
	<ROUTINE NOT-HERE (OBJ "OPT" (CLOCK <>))
		<COND
			(<ZERO? .CLOCK>
				<SETG CLOCK-WAIT T>
				<TELL !\[>
			)
		>
		<TELL The+verb .OBJ "are" "n't ">
		<COND
			(<VISIBLE? .OBJ>
				<TELL "close enough">
				<COND
					(<SPEAKING-VERB?>
						<TELL " to hear you">
					)
				>
			)
			(T
				<TELL "here">
			)
		>
		<TELL !\.>
		<THIS-IS-IT .OBJ>
		<COND
			(<ZERO? .CLOCK>
				<TELL !\]>
			)
		>
		<CRLF>
	>
>
 
<REPLACE-DEFINITION ASKING-VERB-WORD?
	<ADD-WORD ASK ASKWORD>
	<ADD-WORD ORDER ASKWORD>
	<ADD-WORD TELL ASKWORD>
>
 
<REPLACE-DEFINITION CAPITAL-NOUN?
	<DEFINE CAPITAL-NOUN? (NAM)
		<EQUAL? .NAM ,W?COFFEY ,W?LINDSEY>
	>
>
 
<REPLACE-DEFINITION YES?
	<CONSTANT YES-INBUF <ITABLE 19 (BYTE LENGTH) 0>>
	<CONSTANT YES-LEXV  <ITABLE 3 (LEXV) 0 0>>
 
	<DEFINE YES? ("OPT" (NO-Q <>) "AUX" WORD VAL)
		<COND
			(<NOT .NO-Q>
				<TELL !\?>
			)
		>
		<REPEAT ()
			<TELL CR "Please answer YES or NO >">
			<VERSION?
				(XZIP
					<PUTB ,YES-INBUF 1 0>
				)
				(YZIP
					<PUTB ,YES-INBUF 1 0>
				)
			>
			<REPEAT ()
				<SET VAL <ZREAD ,YES-INBUF ,YES-LEXV>>
				<COND
					(<EQUAL? .VAL 10 13>
						<RETURN>
					)
				>
			>
			<VERSION?
				(YZIP
					<RT-SCRIPT-INBUF ,YES-INBUF>
				)
			>
			<COND
				(<AND <NOT <0? <GETB ,YES-LEXV ,P-LEXWORDS>>>
						<SET WORD <ZGET ,YES-LEXV ,P-LEXSTART>>
					>
					<COND
						(<COMPARE-WORD-TYPES
								<WORD-CLASSIFICATION-NUMBER .WORD>
								<GET-CLASSIFICATION VERB>
							>
							<SET VAL <WORD-VERB-STUFF .WORD>>
						)
						(T
							<SET VAL <>>
						)
					>
					<COND
						(<OR	<EQUAL? .VAL ,ACT?YES>
								<EQUAL? .WORD ,W?Y>
							>
							<SET VAL T>
							<RETURN>
						)
						(<OR	<EQUAL? .VAL ,ACT?NO>
								<EQUAL? .WORD ,W?N>
							>
							<SET VAL <>>
							<RETURN>
						)
						(<EQUAL? .VAL ,ACT?RESTART>
							<V-RESTART>
						)
						(<EQUAL? .VAL ,ACT?RESTORE>
							<V-RESTORE>
						)
						(<EQUAL? .VAL ,ACT?QUIT>
							<V-QUIT>
						)
					>
				)
			>
		;	<TELL "[Please type YES or NO.]">
		>
		.VAL
	>
>
 
<REPLACE-DEFINITION SEE-VERB?
	<ROUTINE SEE-VERB? ()
		<EQUAL? ,PRSA
,V?EXAMINE ,V?LOOK ,V?LOOK-IN ,V?LOOK-ON ;",V?LOOK-UP ,V?LOOK-DOWN
,V?LOOK-UNDER ,V?READ"
		>
	>
>
 
<REPLACE-DEFINITION OWNERS
	<CONSTANT OWNERS
		<TABLE (PURE LENGTH)
			CH-PLAYER
			CH-COFFEY
			CH-LINDSEY
		>
	>
>
 
<REPLACE-DEFINITION REFRESH
	<ROUTINE V-$REFRESH ("OPT" (LOOK? T))
		<LOWCORE FLAGS <BAND <LOWCORE FLAGS> <BCOM 4>>>
		<CLEAR -1>
		<INIT-STATUS-LINE>
		<COND
			(.LOOK?
				<V-LOOK>
			)
		>
		<RTRUE>
	>
>
 
<REPLACE-DEFINITION STATUS-LINE
	<CONSTANT K-PICTURE-TBL
		<TABLE (PURE BYTE LENGTH)
4 7 10 11 12 13 14 15 16 18 20 21 22 23 24 26 27 28 29 30 31 32 33 34 36 37
38 39 40 42 43 44 46 47 48 49 50 52 55 56 58 60 61 62 63 65 66 67 69 70 71 72
73 74 75 76 77 78 81 86 89 101 102 157
		>
	>
 
	<DEFINE INIT-STATUS-LINE ("OPT" (PW? T) "AUX" CW Y Y1 N)
		<SET N <- <LOWCORE VWRD> ,GL-FONT-Y>>
 
		<COND
			(.PW?		; "Picture/Text window"
				; "Text window"
				<WINPOS 0 <+ 1 </ .N 2> ,GL-FONT-Y> <+ 1 <* 27 ,GL-FONT-X>>>
				<WINSIZE 0 </ <+ .N 1> 2> <- <LOWCORE HWRD> <* 27 ,GL-FONT-X>>>
				; "Picture window"
				<WINPOS 6 <+ 1 ,GL-FONT-Y> <+ 1 <* 27 ,GL-FONT-X>>>
				<WINSIZE 6 </ .N 2> <- <LOWCORE HWRD> <* 27 ,GL-FONT-X>>>
			)
			(T			; "Text window"
				; "Text window"
				<WINPOS 0 <+ 1 ,GL-FONT-Y> <+ 1 <* 27 ,GL-FONT-X>>>
				<WINSIZE 0
					<- <LOWCORE VWRD> ,GL-FONT-Y>
					<- <LOWCORE HWRD> <* 27 ,GL-FONT-X>>
				>
				<WINPOS 6 1 1>
				<WINSIZE 6 0 0>
			)
		>
 
		; "Status line"
		<WINPOS 1 1 1>
		<WINSIZE 1 ,GL-FONT-Y <LOWCORE HWRD>>
 
		; "Mouse window"
		<WINPOS 2 <+ <- <LOWCORE VWRD> ,GL-FONT-Y> 1> 1>
		<WINSIZE 2 ,GL-FONT-Y <LOWCORE HWRD>>
 
		; "Verb/Prep window"
		<WINPOS 3 <+ 1 <* 3 ,GL-FONT-Y>> 1>
		<WINSIZE 3 <- <LOWCORE VWRD> <* 3 ,GL-FONT-Y>> <* 10 ,GL-FONT-X>>
 
		; "Noun window"
		<WINPOS 4 <+ 1 <* 3 ,GL-FONT-Y>> <+ 1 <* 11 ,GL-FONT-X>>>
		<WINSIZE 4 <- <LOWCORE VWRD> <* 3 ,GL-FONT-Y>> <* 15 ,GL-FONT-X>>
 
		; "Mouse button window"
		<WINPOS 5 <+ ,GL-FONT-Y 1> 1>
		<WINSIZE 5 <* 2 ,GL-FONT-Y> <* 27 ,GL-FONT-X>>
 
		<WINPOS 7 1 1>
		<WINSIZE 7 <LOWCORE VWRD> <LOWCORE HWRD>>
 
		; "Menu dividers"
		<SCREEN 7>
		<HLIGHT ,K-H-INV>
		<SET Y <WINGET 3 ,K-W-YPOS>>
		<SET Y1 <- <+ .Y <WINGET 3 ,K-W-YSIZE>> 1>>
		<REPEAT ()
			<CURSET .Y <C-PIXELS 11>>
			<TELL !\ >
			<CURSET .Y <C-PIXELS 27>>
			<TELL !\ >
			<COND
				(<G? <SET Y <+ .Y ,GL-FONT-Y>> .Y1>
					<RETURN>
				)
			>
		>
		<HLIGHT ,K-H-NRM>
 
		; "Picture"
	;	<CLEAR 6>
	;	<SCREEN 6>
	;	<RT-CENTER-PIC
			<GETB ,K-PICTURE-TBL <RANDOM <GETB ,K-PICTURE-TBL 0>>>
		>
 
		; "Mouse buttons"
		<SCREEN 5>
		<SET N </ <WINGET 5 ,K-W-XSIZE> ,GL-SPACE-WIDTH>>
		<PUTB ,K-DIROUT-TBL 0 !\ >
		<COPYT ,K-DIROUT-TBL <ZREST ,K-DIROUT-TBL 1> <- .N>>
		<CURSET 1 1>
		<HLIGHT ,K-H-INV>
		<PRINTT ,K-DIROUT-TBL .N>
		<CURSET 1 1>
		<TELL "EXECUTE">
		<CCURSET 1 13>
		<TELL "DELETE">
		<CCURSET 2 1>
		<PRINTT ,K-DIROUT-TBL .N>
		<CCURSET 2 1>
		<TELL "UP">
		<CCURSET 2 7>
		<TELL "DN">
		<CCURSET 2 13>
		<TELL "UP">
		<CCURSET 2 24>
		<TELL "DN">
		<HLIGHT ,K-H-NRM>
 
		; "Status line"
		<SCREEN 1>
		<CURSET 1 1>
		<SET N </ <WINGET 1 ,K-W-XSIZE> ,GL-SPACE-WIDTH>>
		<PUTB ,K-DIROUT-TBL 0 !\ >
		<COPYT ,K-DIROUT-TBL <ZREST ,K-DIROUT-TBL 1> <- .N>>
		<HLIGHT ,H-INVERSE>
		<PRINTT ,K-DIROUT-TBL .N>
		<HLIGHT ,H-NORMAL>
 
		<SCREEN 0>
		<SETG GL-SL-HERE <>>
		<RTRUE>
	>
 
	<GLOBAL GL-SL-HERE:OBJECT <> <> BYTE>
 
	<DEFINE UPDATE-STATUS-LINE ("AUX" C CW N ;D H M S)
		<SCREEN 1>
		<HLIGHT ,K-H-INV>
		<COND
			(<NOT <EQUAL? ,HERE ,GL-SL-HERE>>
				; "Picture"
			;	<COND
					(<G? <WINGET 6 ,K-W-YSIZE> 0>
						<CLEAR 6>
						<SCREEN 6>
						<RT-CENTER-PIC
							<GETB ,K-PICTURE-TBL <RANDOM <GETB ,K-PICTURE-TBL 0>>>
						>
						<SCREEN 1>
						<HLIGHT ,K-H-INV>
					)
				>
 
				<SETG GL-SL-HERE ,HERE>
				<CURSET 1 1>
 
				<SET N
					</ <- <WINGET 1 ,K-W-XSIZE>
							<WINGET 1 ,K-W-XCURPOS>
						>
						,GL-SPACE-WIDTH
					>
				>
				<PUTB ,K-DIROUT-TBL 0 !\ >
				<COPYT ,K-DIROUT-TBL <ZREST ,K-DIROUT-TBL 1> <- .N>>
				<PRINTT ,K-DIROUT-TBL .N>
				<CURSET 1 1>
 
				<DIROUT ,K-D-TBL-ON ,K-DIROUT-TBL>
				<TELL D ,HERE>
				<DIROUT ,K-D-TBL-OFF>
				<SET C <GETB ,K-DIROUT-TBL 2>>
				<COND
					(<AND <G=? .C !\a>
							<L=? .C !\z>
						>
						<PUTB ,K-DIROUT-TBL 2 <- .C 32>>
					)
				>
				<PRINTT <ZREST ,K-DIROUT-TBL 2> <ZGET ,K-DIROUT-TBL 0>>
			)
		>
		<CURSET 1 <+ <- <WINGET 1 ,K-W-XSIZE> <* 9 ,GL-FONT-X>> 1>>
		<SET N
			</ <- <WINGET 1 ,K-W-XSIZE>
					<WINGET 1 ,K-W-XCURPOS>
				>
				,GL-SPACE-WIDTH
			>
		>
		<PUTB ,K-DIROUT-TBL 0 !\ >
		<COPYT ,K-DIROUT-TBL <ZREST ,K-DIROUT-TBL 1> <- .N>>
		<PRINTT ,K-DIROUT-TBL .N>
 
		<SET N <MOD ,GL-MOVES 2880>>
	;	<SET D </ ,GL-MOVES 2880>>
		<SET H <MOD </ .N 120> 24>>
		<SET M <MOD </ .N 2> 60>>
		<SET S <* <MOD .N 2> 30>>
		<DIROUT ,K-D-TBL-ON ,K-DIROUT-TBL>
		<COND
			(<L? .H 10>
				<TELL "0">
			)
		>
		<TELL N .H ":">
		<COND
			(<L? .M 10>
				<TELL "0">
			)
		>
		<TELL N .M ":">
		<COND
			(<L? .S 10>
				<TELL "0">
			)
		>
		<TELL N .S>
		<DIROUT ,K-D-TBL-OFF>
		<CURSET 1 <+ <- <WINGET 1 ,K-W-XSIZE> ;<* 9 ,GL-FONT-X> <LOWCORE TWID>> 1>>
		<PRINTT <ZREST ,K-DIROUT-TBL 2> <ZGET ,K-DIROUT-TBL 0>>
		  <HLIGHT ,K-H-NRM>
		<SCREEN 0>
		<RTRUE>
	>
>
 
<REPLACE-DEFINITION READ-INPUT
	<GLOBAL DEMO-VERSION? <> <> BYTE>
 
;	<CONSTANT K-INDOOR-DIR-TBL
		<TABLE (PURE LENGTH)
			<PLTABLE W?FORE> <PLTABLE W?AFT> <PLTABLE W?PORT>
			<PLTABLE W?STARBOARD> <PLTABLE W?UP> <PLTABLE W?DOWN> <PLTABLE W?IN>
			<PLTABLE W?OUT>
		>
	>
;	<CONSTANT K-OUTDOOR-DIR-TBL
		<TABLE (PURE LENGTH)
			<PLTABLE W?NORTH> <PLTABLE W?SOUTH> <PLTABLE W?EAST>
			<PLTABLE W?WEST> <PLTABLE W?UP> <PLTABLE W?DOWN> <PLTABLE W?IN>
			<PLTABLE W?OUT>
		>
	>
;	<CONSTANT K-SPECIAL-VERB-TBL
		<TABLE (PURE LENGTH)
			;<PLTABLE W?COLOR> <PLTABLE W?QUIT> <PLTABLE W?RESTORE>
			<PLTABLE W?RESTART> <PLTABLE W?SAVE> <PLTABLE W?UNDO>
		>
	>
;	<CONSTANT K-COMMON-VERB-TBL
		<TABLE (PURE LENGTH)
			<PLTABLE W?TAKE> <PLTABLE W?DROP> <PLTABLE W?PUT> <PLTABLE W?OPEN>
			<PLTABLE W?CLOSE> <PLTABLE W?EXAMINE> <PLTABLE W?LOOK>
			<PLTABLE W?INVENTORY>
		>
	>
	<CONSTANT K-DEFAULT-VERB-TBL
		<TABLE (PURE LENGTH)
			<PLTABLE W?FORE> <PLTABLE W?AFT> <PLTABLE W?PORT>
			<PLTABLE W?STARBOARD> <PLTABLE W?NORTH> <PLTABLE W?SOUTH>
			<PLTABLE W?EAST> <PLTABLE W?WEST> <PLTABLE W?UP> <PLTABLE W?DOWN>
			<PLTABLE W?IN> <PLTABLE W?OUT> <>
 
			<PLTABLE W?TAKE> <PLTABLE W?DROP> <PLTABLE W?PUT> <PLTABLE W?OPEN>
			<PLTABLE W?CLOSE> <PLTABLE W?EXAMINE> <PLTABLE W?LOOK>
			<PLTABLE W?INVENTORY> <>
 
			;<PLTABLE W?COLOR> <PLTABLE W?QUIT> <PLTABLE W?RESTORE>
			<PLTABLE W?RESTART> <PLTABLE W?SAVE> <PLTABLE W?UNDO> <>
 
			<PLTABLE W?ASK>
			<PLTABLE W?ATTACH>
			<PLTABLE W?CLOSE>
			<PLTABLE W?DROP>
			<PLTABLE W?EMPTY>
			<PLTABLE W?ENTER>
			<PLTABLE W?EXAMINE>
			<PLTABLE W?EXIT>
			<PLTABLE W?FOLLOW>
			<PLTABLE W?GET>
			<PLTABLE W?GET W?IN>
			<PLTABLE W?GET W?OFF>
			<PLTABLE W?GET W?OUT W?OF>
			<PLTABLE W?HOLD>
			<PLTABLE W?INVENTORY>
			<PLTABLE W?JUMP W?IN>
			<PLTABLE W?JUMP W?OUT W?OF>
			<PLTABLE W?LISTEN>
			<PLTABLE W?LISTEN W?TO>
			<PLTABLE W?LOOK>
			<PLTABLE W?LOOK W?AT>
			<PLTABLE W?LOOK W?IN>
			<PLTABLE W?LOOK W?ON>
			<PLTABLE W?LOOK W?OVER>
			<PLTABLE W?OPEN>
			<PLTABLE W?OPEN W?UP>
			<PLTABLE W?PUT>
			<PLTABLE W?PUT W?AWAY>
			<PLTABLE W?PUT W?DOWN>
			<PLTABLE W?PUT W?ON>
			<PLTABLE W?REMOVE>
			<PLTABLE W?SET>
			<PLTABLE W?SIT W?AT>
			<PLTABLE W?SIT W?DOWN>
			<PLTABLE W?SIT W?IN>
			<PLTABLE W?SIT W?ON>
			<PLTABLE W?SWIM>
			<PLTABLE W?SWIM W?TO>
			<PLTABLE W?SWITCH W?OFF>
			<PLTABLE W?SWITCH W?ON>
			<PLTABLE W?TAKE>
			<PLTABLE W?TAKE W?OFF>
			<PLTABLE W?TAKE W?OUT>
			<PLTABLE W?TAKE W?UP>
			<PLTABLE W?TELL>
			<PLTABLE W?THANK>
			<PLTABLE W?THROW>
			<PLTABLE W?THROW W?AWAY>
			<PLTABLE W?TURN>
			<PLTABLE W?TURN W?OFF>
			<PLTABLE W?TURN W?ON>
			<PLTABLE W?WAIT>
			<PLTABLE W?WAIT W?FOR>
			<PLTABLE W?WALK>
			<PLTABLE W?WALK W?TO>
			<PLTABLE W?WEAR>
		>
	>
 
	<ROUTINE RT-PRINT-MENU (MN "AUX" N L TBL (W <+ 3 .MN>))
		<SCREEN .W>
		<CLEAR .W>
		<CURSET 1 1>
		<SET TBL <ZGET ,K-MENU-TBL .MN>>
		<SET N <GETB ,K-FIRST-ENTRY-TBL .MN>>
		<SET L <- <+ .N </ <WINGET -3 ,K-W-YSIZE> ,GL-FONT-Y>> 1>>
		<COND
			(<L? <ZGET .TBL 0> .L>
				<SET L <ZGET .TBL 0>>
			)
		>
		<REPEAT ()
			<COND
				(<G? .N .L>
					<RETURN>
				)
				(T
					<RT-PRINT-MENU-ENTRY .MN .N>
					<CRLF>
					<INC N>
				)
			>
		>
	>
	<ROUTINE RT-PRINT-MENU-ENTRY (MN N "AUX" L ITEM TBL W T)
		<COND
			(<AND <SET TBL <ZGET ,K-MENU-TBL .MN>>
					<SET ITEM <ZGET .TBL .N>>
				>
				<SET T <GETB ,K-MENU-TBL-TYPE .MN>>
				<COND
					(<EQUAL? .T ,K-MENU-ONE-WORD>
						<PRINTB .ITEM>
					)
					(<EQUAL? .T ,K-MENU-MANY-WORD>
						<SET L <ZGET .ITEM 0>>
						<SET ITEM <ZREST .ITEM 2>>
						<REPEAT ()
							<COND
								(<DLESS? L 0>
									<RETURN>
								)
								(T
									<COND
										(<SET W <ZGET .ITEM 0>>
											<PRINTB .W>
										)
										(T
											<TELL "~">
										)
									>
									<COND
										(<G? .L 0>
											<TELL " ">
										)
									>
									<SET ITEM <ZREST .ITEM 2>>
								)
							>
						>
					)
					(<EQUAL? .T ,K-MENU-OBJECT>
						<COND
							(<EQUAL? .ITEM <+ ,LAST-OBJECT 1>>
								<TELL "all">
							)
							(<SET W <GETP .ITEM ,P?MENU>>
								<TELL .W>
							)
							(T
								<TELL D .ITEM>
							)
						>
					)
				>
			)
		>
	>
	<ROUTINE RT-HLIGHT-MENU (MN L "OPT" (ON? T) "AUX" Y TBL N)
		<SCREEN <+ 3 .MN>>
		<SET Y <+ <- .L <GETB ,K-FIRST-ENTRY-TBL .MN>> 1>>
		<CURSET <L-PIXELS .Y> 1>
		<COND
			(.ON?
				<HLIGHT ,K-H-INV>
			)
		>
		<RT-PRINT-MENU-ENTRY .MN .L>
		<COND
			(.ON?
				<SET N
					</ <- <WINGET -3 ,K-W-XSIZE>
							<WINGET -3 ,K-W-XCURPOS>
						>
						,GL-SPACE-WIDTH
					>
				>
				<PUTB ,K-DIROUT-TBL 0 !\ >
				<COPYT ,K-DIROUT-TBL <ZREST ,K-DIROUT-TBL 1> <- .N>>
				<PRINTT ,K-DIROUT-TBL .N>
				<HLIGHT ,K-H-NRM>
			)
			(T
				<ERASE 1>
			)
		>
		<RTRUE>
	>
	<ROUTINE RT-GET-PREPS (ACT TBL "OPT" (PREP -1) "AUX" PTR L M N P)
		<COND
			(<EQUAL? .PREP -1>
				<SET L 1>
			)
			(T
				<SET L 3>
			)
		>
		<REPEAT ()
			<COND
				(<EQUAL? .L 1>
					<SET PTR <VERB-ONE .ACT>>
				)
				(T
					<SET PTR <VERB-TWO .ACT>>
				)
			>
			<COND
				(.PTR
					<SET M <ZGET .PTR 0>>
					<SET PTR <ZREST .PTR 2>>
					<SET N <ZGET .TBL 0>>
					<REPEAT ()
						<COND
							(<DLESS? M 0>
								<RETURN>
							)
							(T
								<COND
									(<EQUAL? .PREP -1>
										<SET P <ZGET .PTR 1>>
									)
									(T
										<SET P <ZGET .PTR 3>>
									)
								>
								<COND
									(.P
										<COND
											(<OR	<EQUAL? .PREP -1>
													<EQUAL? .PREP <ZGET .PTR 1>>
												>
												<COND
													(<NOT <INTBL? .P <ZREST .TBL 2> .N>>
													;	<PRINTB .P>
													;	<CRLF>
														<INC N>
														<ZPUT .TBL .N .P>
														<ZPUT .TBL 0 .N>
													)
												>
											)
										>
									)
								>
								<COND
									(<EQUAL? .L 1>
										<SET PTR <ZREST .PTR 6>>
									)
									(T
										<SET PTR <ZREST .PTR 10>>
									)
								>
							)
						>
					>
				)
			>
			<COND
				(<EQUAL? .L 1>
					<SET L 3>
				)
				(T
					<RETURN>
				)
			>
		>
	>
;	<ROUTINE RT-GET-VERBS (ACT TBL P1 "OPT" (P2 -1) "AUX" L V (V1 -1) PTR M N)
		<COND
			(<EQUAL? .P2 -1>
				<SET L 1>
			)
			(T
				<SET L 3>
			)
		>
		<REPEAT ()
			<COND
				(<EQUAL? .L 1>
					<SET PTR <VERB-ONE .ACT>>
				)
				(T
					<SET PTR <VERB-TWO .ACT>>
				)
			>
			<COND
				(.PTR
					<SET M <ZGET .PTR 0>>
					<SET PTR <ZREST .PTR 2>>
					<SET N <ZGET .TBL 0>>
					<REPEAT ()
						<COND
							(<DLESS? M 0>
								<RETURN>
							)
							(T
								<COND
									(<EQUAL? <ZGET .PTR 1> .P1>
										<COND
											(<OR	<EQUAL? .P2 -1>
													<EQUAL? .P2 <ZGET .PTR 3>>
												>
												<SET V <ZGET .PTR 0>>
												<COND
													(<NOT <EQUAL? .V1 .V>>
														<COND
															(<EQUAL? .V1 -1>
																<SET V1 .V>
															)
															(T
																<SET V1 <>>
															)
														>
													)
												>
												<COND
													(<NOT <INTBL? .V <ZREST .TBL 2> .N>>
														<INC N>
														<ZPUT .TBL .N .V>
														<ZPUT .TBL 0 .N>
													)
												>
											)
										>
									)
								>
								<COND
									(<EQUAL? .L 1>
										<SET PTR <ZREST .PTR 6>>
									)
									(T
										<SET PTR <ZREST .PTR 10>>
									)
								>
							)
						>
					>
				)
			>
			<COND
				(<EQUAL? .L 1>
					<SET L 3>
				)
				(T
					<RETURN>
				)
			>
		>
		<COND
			(<NOT <EQUAL? .V1 -1>>
				<RETURN .V1>
			)
		>
	>
 
	<ROUTINE RT-GET-OBJS (TBL "OPT" (CONT ,HERE) (SEARCH ,SEARCH-ALL) "AUX" OBJ N PTR ADD?)
		<SET OBJ <FIRST? .CONT>>
		<REPEAT ()
			<COND
				(<NOT .OBJ>
					<RETURN>
				)
			;	(<EQUAL? .OBJ ,LOCAL-GLOBALS>)
				(<NOT <FSET? .OBJ ,FL-INVISIBLE>>
					<COND
						(<IN? .CONT ,ROOMS>
							<SET ADD? <ANDB .SEARCH ,SEARCH-ON-GROUND>>
						)
						(<EQUAL? .CONT ,CH-PLAYER ;,WINNER>
							<SET ADD? <ANDB .SEARCH ,SEARCH-HELD>>
						)
						(T
							<SET ADD? T>
						)
					>
					<COND
						(.ADD?
							<SET N <+ <ZGET .TBL 0> 1>>
							<ZPUT .TBL .N .OBJ>
							<ZPUT .TBL 0 .N>
						)
					>
					<COND
						(<OR	<AND
									<IN? .CONT ,ROOMS>
									<ANDB .SEARCH ,SEARCH-OFF-GROUND>
								>
								<AND
									<EQUAL? .CONT ,CH-PLAYER ;,WINNER>
									<ANDB .SEARCH ,SEARCH-POCKETS>
								>
							>
							<COND
								(<NOT <CLOSED? .OBJ>>
									<RT-GET-OBJS .TBL .OBJ .SEARCH>
								)
							>
						)
					>
				)
			>
			<SET OBJ <NEXT? .OBJ>>
		>
	>
;	<ROUTINE RT-WORD-CONVERT (THING "OPT" (STRING? <>) "AUX" L PTR P Q C)
		<DIROUT ,K-D-TBL-ON ,K-DIROUT-TBL>
		<COND
			(.STRING?
				<TELL .THING>
			)
			(T
				<TELL D .THING>
			)
		>
		<TELL " junk">
		<DIROUT ,K-D-TBL-OFF>
		<SET L <ZGET ,K-DIROUT-TBL 0>>
	;	<PRINTT <ZREST ,K-DIROUT-TBL 2> .L>
	;	<CRLF>
		<PUTB ,K-DIROUT-TBL 0 .L>
		<PUTB ,K-DIROUT-TBL 1 .L>
 
		; "Place to store LEX output"
		<SET PTR <ZREST ,K-DIROUT-TBL <+ 2 .L>>>
 
		; "Make string lower case"
		<SET P <ZREST ,K-DIROUT-TBL 2>>
		<REPEAT ()
			<COND
				(<DLESS? L 0>
					<RETURN>
				)
				(<AND <G=? <SET C <GETB .P 0>> !\A>
						<L=? .C !\Z>
					>
					<PUTB .P 0 <+ .C 32>>
				)
			>
			<SET P <ZREST .P 1>>
		>
 
		<COPYT 0 .PTR 34>
		<PUTB .PTR 0 8>
		<LEX ,K-DIROUT-TBL .PTR>
		<SET L <- <GETB .PTR 1> 1>>	; "Hack - extra word"
		<SET PTR <ZREST .PTR 2>>
		<SET P <RT-GET-MEM .L>>
		<SET Q .P>
		<ZPUT .P 0 .L>
		<SET P <ZREST .P 2>>
		<REPEAT ()
			<COND
				(<DLESS? L 0>
					<RETURN>
				)
				(T
					<ZPUT .P 0 <ZGET .PTR 0>>
				;	<PRINTB <ZGET .PTR 0>>
				;	<COND
						(<G? .L 0>
							<TELL !\ >
						)
					>
					<SET PTR <ZREST .PTR 4>>
					<SET P <ZREST .P 2>>
				)
			>
		>
	;	<CRLF>
		<RETURN .Q>
	>
	<ROUTINE RT-DO-OBJECTS ("OPT" (SEARCH <ORB ,SEARCH-ALL ,SEARCH-MANY>) "AUX" PTR I N OBJ STR)
		<COND
			(<BAND .SEARCH ,SEARCH-MANY>
				<ZPUT ,K-OBJECT-TBL 1 <+ ,LAST-OBJECT 1> ;<RT-WORD-CONVERT "all" T>>
				<ZPUT ,K-OBJECT-TBL 0 1>
			)
		>
		<RT-GET-OBJS ,K-OBJECT-TBL ,HERE .SEARCH>
 
		; "Get local global objects"
		<SET PTR <GETPT ,HERE ,P?GLOBAL>>
		<SET N </ <PTSIZE .PTR> 2>>
		<REPEAT ()
			<COND
				(<DLESS? N 0>
					<RETURN>
				)
				(T
					<SET I <+ <ZGET ,K-OBJECT-TBL 0> 1>>
					<ZPUT ,K-OBJECT-TBL .I <ZGET .PTR 0>>
					<ZPUT ,K-OBJECT-TBL 0 .I>
					<SET PTR <ZREST .PTR 2>>
				)
			>
		>
 
	;	<RT-GET-OBJS ,K-OBJECT-TBL ,GLOBAL-OBJECTS 0>
	;	<SET N 1>
	;	<REPEAT ()
			<COND
				(<IGRTR? N <ZGET ,K-OBJECT-TBL 0>>
					<RETURN>
				)
				(T
					<SET OBJ <ZGET ,K-OBJECT-TBL .N>>
					<COND
						(<EQUAL? .OBJ ,CH-PLAYER>
							<SET PTR <RT-WORD-CONVERT "me" T>>
						)
						(<SET STR <GETP .OBJ ,P?MENU>>
							<SET PTR <RT-WORD-CONVERT .STR T>>
						)
						(T
							<SET PTR <RT-WORD-CONVERT .OBJ>>
						)
					>
					<ZPUT ,K-OBJECT-TBL .N .PTR>
				)
			>
		>
		<RETURN ,K-OBJECT-TBL>
	>
 
;	<ROUTINE RT-SETUP-MENUS (S "AUX" ACT PTR M N V)
		<COND
			(<EQUAL? .S 0 1>
			)
			(<EQUAL? .S 2>
				<SET ACT <WORD-SEMANTIC-STUFF ,GL-INPUT-VERB>>
				<SET PTR ,K-JUNK-TBL>
 
				; "Make prep table"
				<ZPUT .PTR 0 0>
				<RT-GET-PREPS .ACT .PTR>
				<SETG GL-PREP-TBL .PTR>
				<SET PTR <ZREST .PTR <* <+ <ZGET .PTR 0> 1> 2>>>
 
				; "Check verbs"
				<ZPUT .PTR 0 0>
				<SET V <RT-GET-VERBS .ACT .PTR ,GL-INPUT-PREP1>>
				<SCREEN 0>
				<COND
					(<EQUAL? .V ,V?TAKE>
						<TELL "Verb: take" CR>
					)
					(<EQUAL? .V ,V?DROP>
						<TELL "Verb: drop" CR>
					)
				>
				<SCREEN 2>
 
				; "Update menus"
				<ZPUT ,K-MENU-TBL 0 ,GL-PREP-TBL>
				<PUTB ,K-FIRST-ENTRY-TBL 0 1>
				<PUTB ,K-MENU-TBL-TYPE 0 ,K-MENU-ONE-WORD>
				<RT-PRINT-MENU 0>
			;	<SET TBL <>>
			;	<SET S? T>
			)
		>
	>
 
	<ROUTINE RT-GET-MEM (N "AUX" PTR)
		<SET PTR ,GL-FREE-PTR>
		<SETG GL-FREE-PTR <ZREST ,GL-FREE-PTR <* 2 <+ .N 1>>>>
		<ZPUT .PTR 0 .N>
		<RETURN .PTR>
	>
	<ROUTINE RT-FREE-MEM (PTR "OPT" (N -1) P L)
		<COND
			(<L? .N 0>
				<SET N <ZGET .PTR 0>>
			)
		>
		<SET L <* 2 <+ .N 1>>>
		<SET P <ZREST .PTR .L>>
		<COPYT .P .PTR <- ,GL-FREE-PTR .P>>
		<SETG GL-FREE-PTR <BACK ,GL-FREE-PTR .L>>
	>
 
	<GLOBAL GL-INPUT-TIMEOUT <> <> BYTE>
	<ROUTINE RT-STOP-READ ()
		<SETG GL-INPUT-TIMEOUT T>
		<RTRUE>
	>
 
	<CONSTANT K-FIRST-ENTRY-TBL <TABLE (BYTE) 1 1>>
	<CONSTANT K-MENU-ONE-WORD 0>
	<CONSTANT K-MENU-MANY-WORD 1>
	<CONSTANT K-MENU-OBJECT 2>
	<CONSTANT K-MENU-TBL-TYPE <TABLE (BYTE) 1 1>>
	<CONSTANT K-MENU-TBL <TABLE 0 0>>
	<GLOBAL GL-MENU-NUM 0 <> BYTE>
	<CONSTANT K-ITEM-TBL <ITABLE 60 0>>
	<GLOBAL GL-ITEM-NUM 0 <> BYTE>
	<GLOBAL GL-INPUT-STATE 0 <> BYTE>
	<GLOBAL GL-INPUT-WINNER CH-PLAYER>
	<GLOBAL GL-INPUT-VERB <>>
	<GLOBAL GL-INPUT-PREP1 <>>
	<GLOBAL GL-INPUT-PREP2 <>>
	<CONSTANT K-JUNK-TBL <ITABLE 256 0>>
	<GLOBAL GL-FREE-PTR ,K-JUNK-TBL>
	<CONSTANT K-OBJECT-TBL <ITABLE 50 0>>
	<GLOBAL GL-VERB-TBL ,K-DEFAULT-VERB-TBL>
	<GLOBAL GL-PREP-TBL <>>
	<GLOBAL GL-NOUN-TBL <>>
 
	<GLOBAL GL-MOUSE-X:NUMBER 0>
	<GLOBAL GL-MOUSE-Y:NUMBER 0>
 
	<ROUTINE MOUSE-INPUT? ("OPT" W X1 Y1 X2 Y2 "AUX" N)
		<SETG GL-MOUSE-X <LOWCORE MSLOCX>>
		<SETG GL-MOUSE-Y <LOWCORE MSLOCY>>
		<COND
			(<NOT <ASSIGNED? W>>
				<RTRUE>
			)
			(<NOT <ASSIGNED? X1>>
				<COND
					(<EQUAL? .W -1>
						<RTRUE>
					)
					(T
						<SET X1 <WINGET .W ,K-W-XPOS>>
						<SET Y1 <WINGET .W ,K-W-YPOS>>
						<SET X2 <- <+ .X1 <WINGET .W ,K-W-XSIZE>> 1>>
						<SET Y2 <- <+ .Y1 <WINGET .W ,K-W-YSIZE>> 1>>
						<COND
							(<AND <NOT <L? ,GL-MOUSE-X .X1>>
									<NOT <G? ,GL-MOUSE-X .X2>>
									<NOT <L? ,GL-MOUSE-Y .Y1>>
									<NOT <G? ,GL-MOUSE-Y .Y2>>
								>
								<SETG GL-MOUSE-X <+ <- ,GL-MOUSE-X .X1> 1>>
								<SETG GL-MOUSE-Y <+ <- ,GL-MOUSE-Y .Y1> 1>>
								<RTRUE>
							)
						>
					)
				>
			)
			(T
				<COND
					(<NOT <EQUAL? .W -1>>
						<SET N <- <WINGET .W ,K-W-XPOS> 1>>
						<SET X1 <+ .X1 .N>>
						<SET X2 <+ .X2 .N>>
						<SET N <- <WINGET .W ,K-W-YPOS> 1>>
						<SET Y1 <+ .Y1 .N>>
						<SET Y2 <+ .Y2 .N>>
					)
				>
				<COND
					(<AND <NOT <L? ,GL-MOUSE-X .X1>>
							<NOT <G? ,GL-MOUSE-X .X2>>
							<NOT <L? ,GL-MOUSE-Y .Y1>>
							<NOT <G? ,GL-MOUSE-Y .Y2>>
						>
						<SETG GL-MOUSE-X <+ <- ,GL-MOUSE-X .X1> 1>>
						<SETG GL-MOUSE-Y <+ <- ,GL-MOUSE-Y .Y1> 1>>
						<RTRUE>
					)
				>
			)
		>
	>
 
	<DEFINE READ-INPUT ("AUX" C L M N (TBL <>) ACT S? Y X W ;F ;B)
		<MOUSE-LIMIT -1>
		<SETG GL-FREE-PTR ,K-JUNK-TBL>
		<SETG GL-VERB-TBL ,K-DEFAULT-VERB-TBL>
		<SETG GL-PREP-TBL <>>
		<SETG GL-NOUN-TBL <RT-DO-OBJECTS>>
		<PUTB ,K-FIRST-ENTRY-TBL 0 1>
		<PUTB ,K-FIRST-ENTRY-TBL 1 1>
		<PUTB ,K-MENU-TBL-TYPE 0 ,K-MENU-MANY-WORD>
		<PUTB ,K-MENU-TBL-TYPE 1 ,K-MENU-OBJECT>
		<ZPUT ,K-MENU-TBL 0 ,GL-VERB-TBL>
		<ZPUT ,K-MENU-TBL 1 ,GL-NOUN-TBL>
		<SETG GL-INPUT-WINNER ,CH-PLAYER>
		<SETG GL-INPUT-VERB <>>
		<SETG GL-INPUT-PREP1 <>>
		<SETG GL-INPUT-PREP2 <>>
		<SETG GL-MENU-NUM 0>
		<SETG GL-ITEM-NUM 0>
		<SETG GL-INPUT-STATE 0>
 
		<RT-PRINT-MENU 0>
		<RT-PRINT-MENU 1>
 
		<SET TBL <ZGET ,K-MENU-TBL ,GL-MENU-NUM>>
		<SET L 1>
 
		<SCREEN 0>
		<WINATTR 0 ,A-BUFFER ,O-CLEAR>
		<SET Y <WINGET 0 ,K-W-YCURPOS>>
		<TELL !\>>
		<PUTB ,P-INBUF 1 0>
		<REPEAT ()
			<SET S? <>>
			<RT-HLIGHT-MENU ,GL-MENU-NUM .L>
			<SCREEN 0>
 
			<SET C <ZREAD ,P-INBUF ,P-LEXV>>
			<SET N <GETB ,P-INBUF 1>>
			<COND
				(<EQUAL? .C ,K-CLICK1 ,K-CLICK2>
					<SET W 3>
					<REPEAT ()
						<COND
							(<MOUSE-INPUT? .W>
								<RETURN>
							)
							(<IGRTR? W 5>
								<SET W -1>
								<RETURN>
							)
						>
					>
 
					<COND
						(<EQUAL? .W 3 4>
							; "Made selection from verb/prep window"
							; "Made selection from object window"
							<SET W <- .W 3>>
							<SET M
								<+ </ <- ,GL-MOUSE-Y 1> ,GL-FONT-Y>
									<GETB ,K-FIRST-ENTRY-TBL .W>
								>
							>
							<COND
								(<OR	<NOT <EQUAL? .L .M>>
										<NOT <EQUAL? ,GL-MENU-NUM .W>>
									>
									<COND
										(<L=? .M <ZGET <ZGET ,K-MENU-TBL .W> 0>>
											<RT-HLIGHT-MENU ,GL-MENU-NUM .L <>>
											<RT-HLIGHT-MENU .W .M>
										)
										(T
											<SOUND ,S-BEEP>
											<AGAIN>
										)
									>
								)
							>
							<SETG GL-MENU-NUM .W>
							<SET TBL <ZGET ,K-MENU-TBL ,GL-MENU-NUM>>
							<SET L .M>
							<SET C ,K-F1>
						)
						(<EQUAL? .W 5>
							; "Made selection from button window"
							<SET Y <PIXELS-L ,GL-MOUSE-Y>>
							<SET X <PIXELS-C ,GL-MOUSE-X>>
							<COND
								(<EQUAL? .Y 1>
									<COND
										(<L? .X 13>
											<SET C ,CR>
											<CRLF>
										)
										(T
											<SET C ,K-F2>
										)
									>
								)
								(T
									<COND
										(<L? .X 4>
											<SET C ,K-F3>
											<SET W 0>
										)
										(<AND <G=? .X 7>
												<L? .X 10>
											>
											<SET C ,K-F4>
											<SET W 0>
										)
										(<AND <G=? .X 13>
												<L? .X 16>
											>
											<SET C ,K-F3>
											<SET W 1>
										)
										(<AND <G=? .X 24>
												<L? .X 27>
											>
											<SET C ,K-F4>
											<SET W 1>
										)
										(T
											<SOUND ,S-BEEP>
											<AGAIN>
										)
									>
									<COND
										(<NOT <EQUAL? ,GL-MENU-NUM .W>>
											<SET M <ZGET ,K-MENU-TBL .W>>
											<COND
												(<G? <ZGET .M 0> 0>
													<RT-HLIGHT-MENU ,GL-MENU-NUM .L <>>
													<SET TBL .M>
													<SET L <GETB ,K-FIRST-ENTRY-TBL .W>>
													<SETG GL-MENU-NUM .W>
													<COND
														(<G? .L <ZGET .TBL 0>>
															<SET L <ZGET .TBL 0>>
														)
														(<NOT <ZGET .TBL .L>>
															<INC L>
														)
													>
												)
												(T
													<SOUND ,S-BEEP>
													<AGAIN>
												)
											>
										)
									>
								)
							>
						)
						(T
							<SOUND ,S-BEEP>
							<AGAIN>
						)
					>
				)
			>
			<SCREEN 0>
			<COND
				(<EQUAL? .C ,CR ,LF>
					<RETURN>
				)
				(<EQUAL? .C !\ >
					<PUTB <ZREST ,P-INBUF 2> .N !\ >
					<TELL !\ >
					<INC N>
					<PUTB ,P-INBUF 1 .N>
				)
				(<EQUAL? .C ,K-F1>	; "Paste"
					<COND
						(<AND .TBL
								<G? <ZGET .TBL 0> 0>
							>
							<DIROUT ,K-D-TBL-ON ,K-DIROUT-TBL>
							<RT-PRINT-MENU-ENTRY ,GL-MENU-NUM .L>
							<DIROUT ,K-D-TBL-OFF>
							<SET M <ZGET ,K-DIROUT-TBL 0>>
							<ZPUT ,K-ITEM-TBL ,GL-ITEM-NUM <ORB .N <SHIFT ,GL-INPUT-STATE 8>>>
							<COND
								(<AND <G? .N 0>
										<NOT <EQUAL? <GETB <ZREST ,P-INBUF 2> <- .N 1>> !\ >>
									>
									<PUTB <ZREST ,P-INBUF 2> .N !\ >
									<TELL !\ >
									<INC N>
								)
							>
							<COPYT <ZREST ,K-DIROUT-TBL 2> <ZREST ,P-INBUF <+ 2 .N>> .M>
							<PRINTT <ZREST ,K-DIROUT-TBL 2> .M>
							<SET N <+ .N .M>>
							<COND
								(<AND <EQUAL? ,GL-INPUT-STATE 0>
										<EQUAL? ,GL-MENU-NUM 1>
									>
									<PUTB <ZREST ,P-INBUF 2> .N !\,>
									<TELL !\,>
									<INC N>
								)
								(<AND <EQUAL? ,GL-INPUT-STATE 0 1>
										<EQUAL? ,GL-MENU-NUM 0>
										<BTST
											<WORD-CLASSIFICATION-NUMBER <ZGET <ZGET .TBL .L> 1>>
											<GET-CLASSIFICATION DIR>
										>
									>
									<PUTB <ZREST ,P-INBUF 2> .N !\.>
									<TELL !\.>
									<INC N>
								)
							>
							<PUTB <ZREST ,P-INBUF 2> .N !\ >
							<TELL !\ >
							<INC N>
							<PUTB ,P-INBUF 1 .N>
							<LEX ,P-INBUF ,P-LEXV>
							<INC GL-ITEM-NUM>
 
							<INPUT 1 1 ,RT-STOP-READ>	; "IBM Hack to flush buffer."
 
							<COND
								(<AND <EQUAL? ,GL-INPUT-STATE 0 1>
										<EQUAL? ,GL-MENU-NUM 0>
									>
									<SETG GL-INPUT-VERB <ZGET <ZGET .TBL .L> 1>>
									<COND
										(<BTST
												<WORD-CLASSIFICATION-NUMBER ,GL-INPUT-VERB>
												<GET-CLASSIFICATION DIR>
											>
											; "Player entered direction"
											<SETG GL-INPUT-STATE 0>
											<COND
												(<EQUAL? <GETB ,K-FIRST-ENTRY-TBL 0> 1>
													<RT-HLIGHT-MENU ,GL-MENU-NUM .L <>>
												)
												(T
													<PUTB ,K-FIRST-ENTRY-TBL 1 1>
													<RT-PRINT-MENU ,GL-MENU-NUM>
												)
											>
											<SET L 1>
										)
										(T
											; "Player entered verb"
											<SETG GL-INPUT-STATE 2>
 
											<SET M <ZGET .TBL .L>>
											<COND
												(<G? <ZGET .M 0> 1>
													<SETG GL-INPUT-PREP1 <ZGET .M 2>>
												)
											>
											<SET ACT <WORD-SEMANTIC-STUFF ,GL-INPUT-VERB>>
											<COND
												(,GL-PREP-TBL
													<RT-FREE-MEM ,GL-PREP-TBL>
												)
											>
											; "Make prep table"
											<SETG GL-PREP-TBL ,GL-FREE-PTR>
											<ZPUT ,GL-PREP-TBL 0 0>
											<RT-GET-PREPS .ACT ,GL-PREP-TBL>
											<SETG GL-FREE-PTR
												<ZREST
													,GL-FREE-PTR
													<* <+ <ZGET ,GL-PREP-TBL 0> 1> 2>
												>
											>
 
											; "Check verbs"
										;	<ZPUT .PTR 0 0>
										;	<SET V <RT-GET-VERBS .ACT .PTR ,GL-INPUT-PREP1>>
										;	<SCREEN 0>
										;	<COND
												(<EQUAL? .V ,V?TAKE>
													<TELL "Verb: take" CR>
												)
												(<EQUAL? .V ,V?DROP>
													<TELL "Verb: drop" CR>
												)
												(<EQUAL? .V ,V?OPEN>
													<TELL "Verb: open" CR>
												)
												(<EQUAL? .V ,V?CLOSE>
													<TELL "Verb: close" CR>
												)
											>
 
										;	<SETG GL-NOUN-TBL <RT-DO-OBJECTS>>
 
										;	<SCREEN 2>
 
											; "Update menus"
											<ZPUT ,K-MENU-TBL 0 ,GL-PREP-TBL>
											<PUTB ,K-FIRST-ENTRY-TBL 0 1>
											<PUTB ,K-MENU-TBL-TYPE 0 ,K-MENU-ONE-WORD>
											<RT-PRINT-MENU 0>
 
										;	<ZPUT ,K-MENU-TBL 1 ,GL-NOUN-TBL>
										;	<PUTB ,K-FIRST-ENTRY-TBL 1 1>
										;	<PUTB ,K-MENU-TBL-TYPE 1 ,K-MENU-OBJECT>
										;	<RT-PRINT-MENU 1>
 
											<SET TBL <>>
											<COND
												(<G? <ZGET ,GL-NOUN-TBL 0> 0>
													<SET S? T>
												)
											>
										)
									>
								)
								(<EQUAL? ,GL-INPUT-STATE 0>
									<COND
										(<EQUAL? ,GL-MENU-NUM 1>
										;	<SETG GL-INPUT-WINNER ,CH-PLAYER ;"Who?">
											<SETG GL-INPUT-STATE 1>
											<SET S? T>
										)
									>
								)
								(<EQUAL? ,GL-INPUT-STATE 2>
									<COND
										(<OR	<EQUAL? ,GL-MENU-NUM 1>
												<AND
													<EQUAL? ,GL-MENU-NUM 0>
													<NOT ,GL-INPUT-PREP1>
												>
											>
											; "Player entered first obj/first prep"
											<COND
												(<EQUAL? ,GL-MENU-NUM 1>
													<INC GL-INPUT-STATE>
												)
												(T
													<SETG GL-INPUT-PREP1 <ZGET .TBL .L>>
													<COND
														(<EQUAL? <GETB ,K-MENU-TBL-TYPE ,GL-MENU-NUM> ,K-MENU-MANY-WORD>
															<SETG GL-INPUT-PREP1 <ZGET ,GL-INPUT-PREP1 1>>
														)
													>
												)
											>
											<COND
												(,GL-PREP-TBL
													<RT-FREE-MEM ,GL-PREP-TBL>
												)
											>
											<SETG GL-PREP-TBL ,GL-FREE-PTR>
											<ZPUT ,GL-PREP-TBL 0 0>
											<RT-GET-PREPS <WORD-SEMANTIC-STUFF ,GL-INPUT-VERB> ,GL-PREP-TBL ,GL-INPUT-PREP1>
											<SETG GL-FREE-PTR
												<ZREST
													,GL-FREE-PTR
													<* <+ <ZGET ,GL-PREP-TBL 0> 1> 2>
												>
											>
											<ZPUT ,K-MENU-TBL 0 ,GL-PREP-TBL>
											<PUTB ,K-FIRST-ENTRY-TBL 0 1>
											<PUTB ,K-MENU-TBL-TYPE 0 ,K-MENU-ONE-WORD>
											<RT-PRINT-MENU 0>
											<SET S? T>
										)
									>
								)
								(<EQUAL? ,GL-INPUT-STATE 3>
									<COND
										(<EQUAL? ,GL-MENU-NUM 0>
											; "Player entered second prep"
											<INC GL-INPUT-STATE>
											<SET S? T>
										)
									>
								)
							>
						)
						(T
							<SOUND ,S-BEEP>
						)
					>
				)
				(<EQUAL? .C ,K-F2>	; "Erase/Backup"
					<COND
						(<G? ,GL-ITEM-NUM 0>
							<DEC GL-ITEM-NUM>
							<SET N <ZGET ,K-ITEM-TBL ,GL-ITEM-NUM>>
							<SET M <SHIFT .N -8>>
							<SET N <BAND .N 255>>
							<PUTB ,P-INBUF 1 .N>
							<CURGET ,K-WIN-TBL>
							<CURSET <ZGET ,K-WIN-TBL 0> 1>
							<ERASE 1>
							<TELL !\>>
							<PRINTT <ZREST ,P-INBUF 2> .N>
							<COND
								(<NOT <EQUAL? ,GL-INPUT-STATE .M>>
									; "Update menus"
									<COND
										(<EQUAL? .M 0 1>
										;	<COND
												(<EQUAL? .M 0>
													<SETG ,GL-INPUT-WINNER ,CH-PLAYER ;"Who?">
												)
											>
											<PUTB ,K-FIRST-ENTRY-TBL 0 1>
											<PUTB ,K-FIRST-ENTRY-TBL 1 1>
											<PUTB ,K-MENU-TBL-TYPE 0 ,K-MENU-MANY-WORD>
											<PUTB ,K-MENU-TBL-TYPE 1 ,K-MENU-OBJECT>
											<ZPUT ,K-MENU-TBL 0 ,GL-VERB-TBL>
											<ZPUT ,K-MENU-TBL 1 ,GL-NOUN-TBL>
											<SETG GL-MENU-NUM 0>
										)
										(<EQUAL? .M 2 3 4>
											<COND
												(,GL-PREP-TBL
													<RT-FREE-MEM ,GL-PREP-TBL>
												)
											>
											<SETG GL-PREP-TBL ,GL-FREE-PTR>
											<ZPUT ,GL-PREP-TBL 0 0>
											<SET ACT <WORD-SEMANTIC-STUFF ,GL-INPUT-VERB>>
											<COND
												(<EQUAL? .M 2>
													<RT-GET-PREPS .ACT ,GL-PREP-TBL>
												)
												(T
													<RT-GET-PREPS .ACT ,GL-PREP-TBL ,GL-INPUT-PREP1>
												)
											>
											<SETG GL-FREE-PTR
												<ZREST
													,GL-FREE-PTR
													<* <+ <ZGET ,GL-PREP-TBL 0> 1> 2>
												>
											>
											<PUTB ,K-FIRST-ENTRY-TBL 0 1>
											<PUTB ,K-FIRST-ENTRY-TBL 1 1>
											<PUTB ,K-MENU-TBL-TYPE 0 ,K-MENU-ONE-WORD>
											<PUTB ,K-MENU-TBL-TYPE 1 ,K-MENU-OBJECT>
											<ZPUT ,K-MENU-TBL 0 ,GL-PREP-TBL>
											<ZPUT ,K-MENU-TBL 1 ,GL-NOUN-TBL>
											<COND
												(<EQUAL? .M 3>
													<SETG GL-MENU-NUM 0>
												)
												(T
													<SETG GL-MENU-NUM 1>
												)
											>
										)
									>
									<RT-PRINT-MENU 0>
									<RT-PRINT-MENU 1>
									<SETG GL-INPUT-STATE .M>
								)
							>
							<SET TBL <ZGET ,K-MENU-TBL ,GL-MENU-NUM>>
							<SET L 1>
						)
						(T
							<SOUND ,S-BEEP>
						)
					>
				)
				(<EQUAL? .C ,K-F3>	; "Page up"
					<SCREEN <+ 3 ,GL-MENU-NUM>>
					<SET M <GETB ,K-FIRST-ENTRY-TBL ,GL-MENU-NUM>>
					<SET N </ <WINGET -3 ,K-W-YSIZE> ,GL-FONT-Y>>
					<COND
						(<G? .M 1>
							<COND
								(<L? <- .M .N> 1>
									<PUTB ,K-FIRST-ENTRY-TBL ,GL-MENU-NUM 1>
									<COND
										(<G? .L .N>
											<SET L <- .L .N>>
										)
									>
								)
								(T
									<PUTB ,K-FIRST-ENTRY-TBL ,GL-MENU-NUM <- .M .N>>
									<SET L <- .L .N>>
								)
							>
							<COND
								(<L? .L 1>
									<SET L 1>
								)
								(<NOT <ZGET .TBL .L>>
									<DEC L>
								)
							>
							<RT-PRINT-MENU ,GL-MENU-NUM>
						)
						(<G? .L 1>
							<RT-HLIGHT-MENU ,GL-MENU-NUM .L <>>
							<SET L 1>
						)
						(T
							<SOUND ,S-BEEP>
						)
					>
				)
				(<EQUAL? .C ,K-F4>	; "Page down"
					<SCREEN <+ 3 ,GL-MENU-NUM>>
					<SET M <GETB ,K-FIRST-ENTRY-TBL ,GL-MENU-NUM>>
					<SET N </ <WINGET -3 ,K-W-YSIZE> ,GL-FONT-Y>>
					<COND
						(<L? .M <ZGET .TBL 0>>
							<COND
								(<G? <+ .M .N> <ZGET .TBL 0>>
									<PUTB ,K-FIRST-ENTRY-TBL ,GL-MENU-NUM <ZGET .TBL 0>>
									<SET L <ZGET .TBL 0>>
								)
								(T
									<PUTB ,K-FIRST-ENTRY-TBL ,GL-MENU-NUM <+ .M .N>>
									<SET L <+ .L .N>>
								)
							>
							<COND
								(<G? .L <ZGET .TBL 0>>
									<SET L <ZGET .TBL 0>>
								)
								(<NOT <ZGET .TBL .L>>
									<INC L>
								)
							>
							<RT-PRINT-MENU ,GL-MENU-NUM>
						)
						(T
							<SOUND ,S-BEEP>
						)
					>
				)
				(<EQUAL? .C ,K-UP>
					<COND
						(<G? .L 1>
							<RT-HLIGHT-MENU ,GL-MENU-NUM .L <>>
							<SET M <GETB ,K-FIRST-ENTRY-TBL ,GL-MENU-NUM>>
							<SET N </ <WINGET -3 ,K-W-YSIZE> ,GL-FONT-Y>>
							<REPEAT ()
								<COND
									(<EQUAL? .L .M>
										<SCROLL -3 <- ,GL-FONT-Y>>
										<DEC M>
										<PUTB ,K-FIRST-ENTRY-TBL ,GL-MENU-NUM .M>
									)
								>
								<COND
									(<DLESS? L 2>
										<RETURN>
									)
									(<ZGET .TBL .L>
										<RETURN>
									)
								>
							>
						)
						(T
							<SOUND ,S-BEEP>
						)
					>
				)
				(<EQUAL? .C ,K-DOWN>
					<COND
						(<L? .L <ZGET .TBL 0>>
							<RT-HLIGHT-MENU ,GL-MENU-NUM .L <>>
							<SET M <GETB ,K-FIRST-ENTRY-TBL ,GL-MENU-NUM>>
							<SET N </ <WINGET -3 ,K-W-YSIZE> ,GL-FONT-Y>>
							<REPEAT ()
								<COND
									(<IGRTR? L <- <ZGET .TBL 0> 1>>
										<RETURN>
									)
								>
								<COND
									(<EQUAL? .L <+ .M .N>>
										<SCROLL -3 ,GL-FONT-Y>
										<INC M>
										<PUTB ,K-FIRST-ENTRY-TBL ,GL-MENU-NUM .M>
									)
								>
								<COND
									(<ZGET .TBL .L>
										<RETURN>
									)
								>
							>
						)
						(T
							<SOUND ,S-BEEP>
						)
					>
				)
				(<EQUAL? .C ,K-LEFT ,K-RIGHT>
					<SET M <MOD <+ ,GL-MENU-NUM 1> 2>>
					<SET N <ZGET ,K-MENU-TBL .M>>
					<COND
						(<G? <ZGET .N 0> 0>
							<RT-HLIGHT-MENU ,GL-MENU-NUM .L <>>
							<SET TBL .N>
							<SET L
								<+ <- .L <GETB ,K-FIRST-ENTRY-TBL ,GL-MENU-NUM>>
									<GETB ,K-FIRST-ENTRY-TBL .M>
								>
							>
							<SETG GL-MENU-NUM .M>
							<COND
								(<G? .L <ZGET .TBL 0>>
									<SET L <ZGET .TBL 0>>
								)
								(<NOT <ZGET .TBL .L>>
									<INC L>
								)
							>
						)
						(T
							<SOUND ,S-BEEP>
						)
					>
				)
			>
			<COND
				(.S?
					<SET M <MOD <+ ,GL-MENU-NUM 1> 2>>
					<COND
						(<G? <ZGET <ZGET ,K-MENU-TBL .M> 0> 0>
							<COND
								(.TBL
									<RT-HLIGHT-MENU ,GL-MENU-NUM .L <>>
								)
							>
							<SETG GL-MENU-NUM .M>
							<COND
								(<NOT <EQUAL? <GETB ,K-FIRST-ENTRY-TBL ,GL-MENU-NUM> 1>>
									<PUTB ,K-FIRST-ENTRY-TBL ,GL-MENU-NUM 1>
									<RT-PRINT-MENU ,GL-MENU-NUM>
								)
							>
							<SET TBL <ZGET ,K-MENU-TBL ,GL-MENU-NUM>>
							<SET L 1>
						)
					>
				)
			>
		>
		<VERSION?
			(YZIP
				<RT-SCRIPT-INBUF>
			)
		>
		<SCREEN 0>
		<WINATTR 0 ,A-BUFFER ,O-SET>
		<RETURN .C>
	>
>
 
<DELAY-DEFINITION PRSO-VERB?>
<DELAY-DEFINITION PRSI-VERB?>
 
<DIRECTIONS	FORE STARBOARD AFT PORT NORTH SOUTH EAST WEST UP DOWN IN OUT>
 
<OBJECT INTDIR
	(LOC GLOBAL-OBJECTS)
	(DESC "direction")
	(SYNONYM FORE STARBOARD AFT PORT NORTH SOUTH EAST WEST)
>
 
;"***************************************************************************"
; "end of file"
;"***************************************************************************"
 
