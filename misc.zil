;"***************************************************************************"
; "game : Abyss"
; "file : MISC.ZIL"
; "auth :   $Author:   DEB  $"
; "date :     $Date:   20 Mar 1989  8:43:32  $"
; "rev  : $Revision:   1.20  $"
; "vers : 1.0"
;"---------------------------------------------------------------------------"
; "Miscellaneous"
; "Copyright (C) 1988 Infocom, Inc.  All rights reserved."
;"***************************************************************************"
 
;"---------------------------------------------------------------------------"
; "CH-PLAYER"
;"---------------------------------------------------------------------------"
 
<OBJECT CH-PLAYER
	(LOC RM-COMMAND-MODULE)
	(DESC "yourself")
	(MENU "me")
	(SYNONYM ME MYSELF SELF BUD BRIGMAN)
	(ADJECTIVE BUD)
	(FLAGS
		FL-ALIVE FL-NO-DESC FL-NO-ARTICLE FL-OPEN FL-PERSON FL-SEARCH FL-SEEN
		FL-TOUCHED
	)
>
 
<CONSTANT ME:OBJECT CH-PLAYER>
 
;"---------------------------------------------------------------------------"
; "Visible/Accessible"
;"---------------------------------------------------------------------------"
 
;<GLOBAL GL-CLOSED-OBJECT:OBJECT <>>		; "Closed object preventing touch."
;<GLOBAL GL-IN-OUT:FLAG <>>					; "T=Inside, <>=Outside"
<GLOBAL GL-LOC-TRAIL:TABLE <ITABLE 8 0>>	; "Temporary table used by RT-SEEABLE? and RT-TOUCHABLE?"
 
<ROUTINE VISIBLE? (OBJ)
	<ACCESSIBLE? .OBJ T>
>
 
<ROUTINE CLOSED? (OBJ "OPT" (VIS? <>) ;(ON? <>))
	<COND
		(<NOT .OBJ>
			<RTRUE>
		)
		(<IN? .OBJ ,ROOMS>
			<RFALSE>
		)
	;	(<AND <FSET? .OBJ ,FL-SURFACE>
				<FSET? .OBJ ,FL-CONTAINER>
				.ON?
			>
			<RFALSE>
		)
		(<FSET? .OBJ ,FL-CONTAINER>
			<COND
				(<FSET? .OBJ ,FL-OPEN>
					<RFALSE>
				)
				(.VIS?
					<COND
						(<FSET? .OBJ ,FL-TRANSPARENT>
							<RFALSE>
						)
					>
				)
			>
		)
		(<OR	<FSET? .OBJ ,FL-SURFACE>
				<FSET? .OBJ ,FL-ALIVE>
				<FSET? .OBJ ,FL-PERSON>
			>
			<RFALSE>
		)
	>
	<RTRUE>
>
 
<ROUTINE ACCESSIBLE? (OBJ "OPTIONAL" (VIS? <>) "AUX" WLOC OLOC (CLSD-PTR <>) PTR (CNT 0) ;(ON? <>) TBL END)
	<COND
		(<NOT .OBJ>
		;	<SETG GL-CLOSED-OBJECT <>>
			<RFALSE>
		)
		(<EQUAL? .OBJ ,ROOMS>
			<RTRUE>
		)
	>
	<SET PTR ,GL-LOC-TRAIL>
	<SET OLOC .OBJ>
	<REPEAT ()
		<PUT .PTR 0 .OLOC>
		<INC CNT>
		<COND
			(<OR	<NOT .OLOC>
					<EQUAL? .OLOC ,WINNER>
					<IN? .OLOC ,ROOMS>
					<IN? .OLOC ,LOCAL-GLOBALS>
					<IN? .OLOC ,GLOBAL-OBJECTS>
					<IN? .OLOC ,GENERIC-OBJECTS>
				>
				<RETURN>
			)
		>
	;	<SET ON? <FSET? .OLOC ,FL-ON>>
		<SET OLOC <LOC .OLOC>>
		<SET PTR <REST .PTR 2>>
		<COND
			(.OLOC
				<COND
					(<CLOSED? .OLOC .VIS? ;.ON?>
					;	<COND
							(<NOT .VIS?>
								<SETG GL-CLOSED-OBJECT .OLOC>
								<SETG GL-IN-OUT T>
							)
						>
						<COND
							(<NOT .CLSD-PTR>
								<SET CLSD-PTR .PTR>
							)
						>
					)
				>
			)
		>
	>
 
	<SET PTR <>>
	<SET WLOC ,WINNER>
	<REPEAT ()
		<COND
			(<NOT .WLOC>
			;	<COND
					(<NOT .VIS?>
						<SETG GL-CLOSED-OBJECT <>>
						<SETG GL-IN-OUT <>>
					)
				>
				<RFALSE>
			)
			(<SET PTR <INTBL? .WLOC ,GL-LOC-TRAIL .CNT>>
				<RETURN>
			)
			(<IN? .WLOC ,ROOMS>
				<RETURN>
			)
		>
		<SET WLOC <LOC .WLOC>>
		<COND
			(.WLOC
				<COND
					(<CLOSED? .WLOC .VIS?>
					;	<COND
							(<NOT .VIS?>
								<SETG GL-CLOSED-OBJECT .WLOC>
								<SETG GL-IN-OUT <>>
							)
						>
						<RFALSE>
					)
				>
			)
		>
	>
 
	<COND
		(.WLOC
			<COND
				(<IN? .WLOC ,ROOMS>
					<COND
						(<NOT .PTR>
							<SET TBL <GETPT .WLOC ,P?GLOBAL>>
							<COND
								(.TBL
									<SET END <REST .TBL <PTSIZE .TBL>>>
									<REPEAT ()
										<COND
											(<G=? .TBL .END>
												<RETURN>
											)
											(<SET PTR <INTBL? <GET .TBL 0> ,GL-LOC-TRAIL .CNT>>
												<RETURN>
											)
										>
										<SET TBL <REST .TBL 2>>
									>
								)
							>
						)
					>
				)
			>
		)
	>
 
	<COND
		(.WLOC
			<COND
				(<IN? .WLOC ,ROOMS>
					<COND
						(<NOT .PTR>
							<SET TBL <FIRST? ,GLOBAL-OBJECTS>>
							<REPEAT ()
								<COND
									(<NOT .TBL>
										<RETURN>
									)
									(<SET PTR <INTBL? .TBL ,GL-LOC-TRAIL .CNT>>
										<RETURN>
									)
								>
								<SET TBL <NEXT? .TBL>>
							>
						)
					>
				)
			>
		)
	>
 
	<COND
		(<NOT .PTR>
			<RFALSE>
		)
		(<AND .CLSD-PTR
				<G? .PTR .CLSD-PTR>
			>
			<RFALSE>
		)
		(T
			<RTRUE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "Print routines"
;"---------------------------------------------------------------------------"
 
<CONSTANT K-ART-A		1>
<CONSTANT K-ART-THE	2>
<CONSTANT K-ART-ANY	3>
<CONSTANT K-ART-HE	4>
<CONSTANT K-ART-HIM	5>
<CONSTANT K-ART-HIS	6>
 
<ROUTINE RT-PRINT-DESC (OBJ)
	<COND
		(<FSET? .OBJ ,FL-HAS-SDESC>
			<APPLY <GETP .OBJ ,P?ACTION> ,M-OBJDESC>
		)
		(T
			<PRINTD .OBJ>
		)
	>
>
 
<ROUTINE RT-PRINT-ARTICLE (OBJ ART CAP? "AUX" (MASK 0))
	<COND
		(<NOT .CAP?>
			<TELL !\ >
			<SET MASK 32>
		)
	>
	<COND
		(<EQUAL? .ART ,K-ART-A>
			<COND
				(<FSET? .OBJ ,FL-YOUR>
					<TELL C <BOR !\Y .MASK> "our">
				)
				(<FSET? .OBJ ,FL-PLURAL>
					<TELL C <BOR !\S .MASK> "ome">
				)
				(T
					<TELL C <BOR !\A .MASK>>
					<COND
						(<FSET? .OBJ ,FL-VOWEL>
							<TELL !\n>
						)
					>
				)
			>
		)
		(<EQUAL? .ART ,K-ART-THE>
			<COND
				(<FSET? .OBJ ,FL-YOUR>
					<TELL C <BOR !\Y .MASK> "our">
				)
				(T
					<TELL C <BOR !\T .MASK> "he">
				)
			>
		)
		(<EQUAL? .ART ,K-ART-ANY>
			<TELL C <BOR !\A .MASK> "ny">
		)
		(<EQUAL? .ART ,K-ART-HE>
			<COND
				(<AND <FSET? .OBJ ,FL-PLURAL>
						<NOT <FSET? .OBJ ,FL-COLLECTIVE>>
					>
					<TELL C <BOR !\T .MASK> "hey">
				)
				(<NOT <FSET? .OBJ ,FL-PERSON>>
					<TELL C <BOR !\I .MASK> !\t>
				)
				(<EQUAL? .OBJ ,CH-PLAYER>
					<TELL C <BOR !\Y .MASK> "ou">
				)
				(<FSET? .OBJ ,FL-FEMALE>
					<TELL C <BOR !\S .MASK> "he">
				)
				(T
					<TELL C <BOR !\H .MASK> !\e>
				)
			>
		)
		(<EQUAL? .ART ,K-ART-HIM>
			<COND
				(<AND <FSET? .OBJ ,FL-PLURAL>
						<NOT <FSET? .OBJ ,FL-COLLECTIVE>>
					>
					<TELL C <BOR !\T .MASK> "hem">
				)
				(<NOT <FSET? .OBJ ,FL-PERSON>>
					<TELL C <BOR !\I .MASK> !\t>
				)
				(<EQUAL? .OBJ ,CH-PLAYER>
					<TELL C <BOR !\Y .MASK> "ou">
				)
				(<FSET? .OBJ ,FL-FEMALE>
					<TELL C <BOR !\H .MASK> "er">
				)
				(T
					<TELL C <BOR !\H .MASK> "im">
				)
			>
		)
		(<EQUAL? .ART ,K-ART-HIS>
			<COND
				(<AND <FSET? .OBJ ,FL-PLURAL>
						<NOT <FSET? .OBJ ,FL-COLLECTIVE>>
					>
					<TELL C <BOR !\T .MASK> "heir">
				)
				(<NOT <FSET? .OBJ ,FL-PERSON>>
					<TELL C <BOR !\I .MASK> "ts">
				)
				(<EQUAL? .OBJ ,CH-PLAYER>
					<TELL C <BOR !\Y .MASK> "our">
				)
				(<FSET? .OBJ ,FL-FEMALE>
					<TELL C <BOR !\H .MASK> "er">
				)
				(T
					<TELL C <BOR !\H .MASK> "is">
				)
			>
		)
	>
>
 
<ROUTINE RT-PRINT-OBJ ("OPT" (O <>) (ART ,K-ART-THE) (CAP? <>) (VERB <>) "AUX" (MASK 0))
	<COND
		(<NOT .O>
			<SET O ,PRSO>
		)
	>
;	<THIS-IS-IT .O>
	<COND
		(<FSET? .O ,FL-HAS-SDESC>
			<APPLY <GETP .O ,P?ACTION> ,M-OBJDESC .ART .CAP?>
		)
		(<EQUAL? .ART ,K-ART-HE ,K-ART-HIM ,K-ART-HIS>
			<FSET .O ,FL-SEEN>
			<RT-PRINT-ARTICLE .O .ART .CAP?>
		)
		(<NOT <FSET? .O ,FL-NO-ARTICLE>>
			<FSET .O ,FL-SEEN>
			<RT-PRINT-ARTICLE .O .ART .CAP?>
			<TELL !\  D .O>
		)
		(T
			<COND
				(<NOT .CAP?>
					<TELL !\ >
					<SET MASK 32>
				)
			>
			<COND
				(<EQUAL? .O ,CH-PLAYER>
					<TELL C <BOR !\Y .MASK> "ou">
				)
				(T
					<TELL D .O>
				)
			>
		)
	>
	<COND
		(.VERB
			<RT-PRINT-VERB .O .VERB>
		)
	>
>
 
<ROUTINE RT-PRINT-VERB (OBJ VERB)
	<TELL !\ >
	<COND
		(<OR	<EQUAL? .OBJ ,CH-PLAYER>
				<AND
					<FSET? .OBJ ,FL-PLURAL>
					<NOT <FSET? .OBJ ,FL-COLLECTIVE>>
				>
			>
			<TELL .VERB>
		)
		(T
			<COND
				(<=? .VERB "are">
					<TELL "is">
				)
				(<=? .VERB "have">
					<TELL "has">
				)
				(<=? .VERB "try">
					<TELL "tries">
				)
				(<=? .VERB "empty">
					<TELL "empties">
				)
				(<=? .VERB "fly">
					<TELL "flies">
				)
				(<=? .VERB "dry">
					<TELL "dries">
				)
				(T
					<TELL .VERB>
					<COND
						(<EQUAL? .VERB "do" "kiss" "push" "miss" "pass" "toss" "touch">
							<TELL !\e>
						)
					>
					<TELL !\s>
				)
			>
		)
	>
>
 
<GLOBAL QCONTEXT:OBJECT <>>
<GLOBAL LIT:OBJECT <>>
<GLOBAL P-IT-OBJECT:OBJECT <>>
<GLOBAL P-THEM-OBJECT:OBJECT <>>
<GLOBAL P-HER-OBJECT:OBJECT <>>
<GLOBAL P-HIM-OBJECT:OBJECT <>>
<GLOBAL P-ONE-NOUN <> ;<VOC "FROB">>
 
<CONSTANT K-DIROUT-TBL <ITABLE 255 (BYTE) 0>>
 
<ROUTINE THIS-IS-IT (OBJ)
	<COND
		(<EQUAL? .OBJ <> ,ROOMS ,NOT-HERE-OBJECT ,CH-PLAYER ,INTDIR ,GLOBAL-HERE>
			<RTRUE>
		)
		(<AND <DIR-VERB?>
				<==? .OBJ ,PRSO>
			>
			<RTRUE>
		)
	>
	<COND
		(<FSET? .OBJ ,FL-PERSON>
			<COND
				(<FSET? .OBJ ,FL-FEMALE>
					<FSET ,HER ,FL-TOUCHED>
					<SETG P-HER-OBJECT .OBJ>
				)
				(T
					<FSET ,HIM ,FL-TOUCHED>
					<SETG P-HIM-OBJECT .OBJ>
				)
			>
		)
		(<AND <FSET? .OBJ ,FL-PLURAL>
				<NOT <FSET? .OBJ ,FL-COLLECTIVE>>
			>
			<FSET ,THEM ,FL-TOUCHED>
			<SETG P-THEM-OBJECT .OBJ>
		)
		(T
			<FSET ,IT ,FL-TOUCHED>	;"to cause pronoun 'it' in output"
			<SETG P-IT-OBJECT .OBJ>
		)
	>
	<RTRUE>
>
 
;<ROUTINE NO-PRONOUN? (OBJ "OPTIONAL" (CAP 0))
	<COND
		(<EQUAL? .OBJ ,PLAYER>
			<RFALSE>
		)
		(<NOT <FSET? .OBJ ,FL-PERSON>>
			<COND
				(<AND <EQUAL? .OBJ ,P-IT-OBJECT>
						<FSET? ,IT ,FL-TOUCHED>
					>
					<RFALSE>
				)
			>
		)
		(<FSET? .OBJ ,FL-FEMALE>
			<COND
				(<AND <EQUAL? .OBJ ,P-HER-OBJECT>
						<FSET? ,HER ,FL-TOUCHED>
					>
					<RFALSE>
				)
			>
		)
		(T
			<COND
				(<AND <EQUAL? .OBJ ,P-HIM-OBJECT>
						<FSET? ,HIM ,FL-TOUCHED>
					>
					<RFALSE>
				)
			>
		)
	>
	<COND
		(<ZERO? .CAP>
			<TELL the .OBJ>
		)
		(<ONE? .CAP>
			<TELL The .OBJ>
		)
	>
	<THIS-IS-IT .OBJ>
	<RTRUE>
>
 
;<ROUTINE VERB-PRINT ("OPTIONAL" (GERUND <>) "AUX" TMP)
	<SET TMP <PARSE-VERB ,PARSE-RESULT>>
	<COND
		(<==? .TMP 0>
			<COND
				(<ZERO? .GERUND>
					<TELL "tell">
					<RTRUE>
				)
				(T
					<TELL "walk">
				)
			>
		)
		(<T? .GERUND>
			<SET TMP <GET .TMP 0>>
			<COND
				(<==? .TMP ,W?L>
					<PRINTB ,W?LOOK>
				)
				(<==? .TMP ,W?X>
					<PRINTB ,W?EXAMINE>
				)
				(<==? .TMP ,W?Z>
					<PRINTB ,W?WAIT>
				)
				(<T? .GERUND>
					<COND
					;	(<==? .TMP ,W?BATHE>
							<TELL "bath">
						)
					;	(<==? .TMP ,W?DIG>
							<TELL "digg">
						)
						(<==? .TMP ,W?GET>
							<TELL "gett">
						)
						(T
							<PRINTB .TMP>
						)
					>
				)
				(T
					<PRINTB .TMP>
				)
			>
		)
		(T
			<WORD-PRINT .TMP>
		)
	>
	<COND
		(<T? .GERUND>
			<TELL "ing?">
		)
	>
>
 
<ROUTINE RT-IN-ON-MSG (OBJ "OPT" (CAP? <>) "AUX" (MASK 0))
	<COND
		(<NOT .CAP?>
			<TELL !\ >
			<SET MASK 32>
		)
	>
	<COND
		(<FSET? .OBJ ,FL-SURFACE>
			<TELL C <BOR !\O .MASK>>
		)
		(T
			<TELL C <BOR !\I .MASK>>
		)
	>
	<TELL !\n>
>
 
<ROUTINE RT-OUT-OFF-MSG (OBJ "OPT" (CAP? <>))
	<COND
		(<OR	<FSET? .OBJ ,FL-SURFACE>
				<FSET? .OBJ ,FL-CONTAINER>
			>
			<COND
				(<NOT .CAP?>
					<TELL " o">
				)
				(T
					<TELL !\O>
				)
			>
			<COND
				(<FSET? .OBJ ,FL-SURFACE>
					<TELL "ff">
				)
				(T
					<TELL "ut">
				)
			>
		)
	>
>
 
<ROUTINE RT-OPEN-MSG ("OPT" (OBJ <>))
	<COND
		(<NOT .OBJ>
			<SET OBJ ,PRSO>
		)
	>
	<TELL !\ >
	<COND
		(<FSET? .OBJ ,FL-OPEN>
			<TELL "open">
		)
		(T
			<TELL "closed">
		)
	>
>
 
<ROUTINE TOUCH-VERB? ()
	<VERB?
	;	ATTACK
	;	BREAK
		CLOSE
	;	CLIMB-DOWN
	;	CLIMB-ON
	;	CLIMB-OVER
	;	CLIMB-UP
	;	CUT
	;	DIG
	;	DRINK
	;	DRINK-FROM
		DROP
	;	EAT
	;	EMPTY
	;	EMPTY-FROM
	;	FILL
	;	GIVE
	;	KNOCK
	;	LOCK
	;	MOVE
		OPEN
		PUT
		PUT-IN
	;	RAISE
	;	RELEASE
	;	RUB
		TAKE
	;	UNLOCK
		WEAR
	;	UNDRESS
		UNWEAR
	>
>
 
;"---------------------------------------------------------------------------"
; "Queue handling"
;"---------------------------------------------------------------------------"
 
<GLOBAL CLOCK-WAIT:FLAG <>>
<GLOBAL GL-CLK-RUN:FLAG <>>
<GLOBAL GL-Q-MAX 0 <> BYTE>
<CONSTANT K-Q-NUM 20>
<CONSTANT K-Q-SIZE <* ,K-Q-NUM 2>>
<GLOBAL GL-Q-TBL <ITABLE ,K-Q-SIZE 0>>
<GLOBAL GL-MOVES 360>	; "3:00:00"
<GLOBAL GL-NEW-TIME 0>
;<GLOBAL GL-QUESTION 0 <> BYTE>
 
<CONSTANT K-TIME-PASSES-MSG "Time passes...|">
 
<ROUTINE CLOCKER ("AUX" NT)
 
;	<SETG GL-DROP-HERE <>>	; "Reset this every turn."
 
;	<COND
		(<EQUAL? ,GL-QUESTION 1>
			<INC GL-QUESTION>
		)
		(<EQUAL? ,GL-QUESTION 2>
			<SETG GL-QUESTION 0>
		)
	>
 
	<COND
		(,CLOCK-WAIT
			<SETG CLOCK-WAIT <>>
			<RFALSE>
		)
	>
	<SET NT ,GL-MOVES>
	<SETG GL-NEW-TIME .NT>
	<REPEAT (RTN TIME ANY? MULT? DIF N (VAL <>))
		<SET RTN <>>
		<SET TIME .NT>
		<SET ANY? <>>
		<SET MULT? <>>
		<REPEAT ((I 0) Z1 Z2)
			<SET Z1 <ZGET ,GL-Q-TBL .I>>
			<SET Z2 <ZGET ,GL-Q-TBL <+ .I 1>>>
			<COND
				(<AND .Z1
						<L=? .Z2 .TIME>
					>
					<COND
						(<AND .RTN
								<EQUAL? .Z2 .TIME>
							>
							<SET MULT? T>
						)
					>
					<SET RTN .Z1>
					<SET TIME .Z2>
					<SET N .I>
					<SET ANY? T>
				)
			>
			<SET I <+ .I 2>>
			<COND
				(<OR	<G=? .I ,K-Q-SIZE>
						<G=? .I ,GL-Q-MAX>
					>
					<RETURN>
				)
			>
		>
		<COND
			(.ANY?
				<SETG GL-MOVES .TIME>
				<COND
					(<NOT <FSET? ,CH-PLAYER ,FL-ASLEEP>>
						<UPDATE-STATUS-LINE>
					)
				>
				<SET DIF <L? .TIME .NT>>
				<PUT ,GL-Q-TBL .N 0>
				<PUT ,GL-Q-TBL <+ .N 1> 0>
				<COND
					(<EQUAL? <+ .N 2> ,GL-Q-MAX>
						<SETG GL-Q-MAX <- ,GL-Q-MAX 2>>
					)
				>
				<SETG GL-CLK-RUN T>
				<COND
					(<APPLY .RTN>
						<SET VAL T>
					)
				>
				<SETG GL-CLK-RUN <>>
				<COND
					(<G? ,GL-MOVES .NT>
						<SETG GL-NEW-TIME ,GL-MOVES>
						<SET NT ,GL-MOVES>
					)
				>
				<COND
					(<AND .VAL
							<NOT .MULT?>
							.DIF
							<VERB? WAIT>
							<NOT <FSET? ,CH-PLAYER ,FL-ASLEEP>>
						>
						<SET VAL <>>
						<TELL CR "Do you want to continue waiting">
						<COND
							(<NOT <YES?>>	; "No -- Stop waiting"
								<SET NT .TIME>
								<RETURN>
							)
							(T
								<TELL ,K-TIME-PASSES-MSG>
							)
						>
					)
				>
			)
			(T
				<RETURN>
			)
		>
	>
	<SETG GL-MOVES .NT>
	<INC GL-MOVES>
 
	<RFALSE>
>
 
<ROUTINE RT-QUEUE (RTN TIME "OPT" (ABS? <>))
;	<COND
		(<AND <NOT ,GL-CLK-RUN>
				<NOT .ABS?>
			>
			<INC TIME>
		)
	>
	<REPEAT ((I 0))
		<COND
			(<ZERO? <GET ,GL-Q-TBL .I>>
				<PUT ,GL-Q-TBL .I .RTN>
				<PUT ,GL-Q-TBL <+ .I 1> .TIME>
				<COND
					(<G? <+ .I 2> ,GL-Q-MAX>
						<SETG GL-Q-MAX <+ .I 2>>
					)
				>
				<RTRUE>
			)
			(<G=? <SET I <+ .I 2>> ,K-Q-SIZE>
				<RFALSE>
			)
		>
	>
>
 
<ROUTINE RT-DEQUEUE (RTN)
	<REPEAT ((I 0))
		<COND
			(<EQUAL? <GET ,GL-Q-TBL .I> .RTN>
				<PUT ,GL-Q-TBL .I 0>
				<PUT ,GL-Q-TBL <+ .I 1> 0>
				<COND
					(<EQUAL? <+ .I 2> ,GL-Q-MAX>
						<SETG GL-Q-MAX <- ,GL-Q-MAX 2>>
					)
				>
				<RTRUE>
			)
			(<OR	<G=? <SET I <+ .I 2>> ,K-Q-SIZE>
					<G=? .I ,GL-Q-MAX>
				>
				<RFALSE>
			)
		>
	>
>
 
<ROUTINE RT-IS-QUEUED? (RTN "AUX" (TIME 0))
	<REPEAT ((I 0))
		<COND
			(<EQUAL? <ZGET ,GL-Q-TBL .I> .RTN>
				<SET TIME <ZGET ,GL-Q-TBL <+ .I 1>>>
				<RETURN>
			)
			(<OR	<G=? <SET I <+ .I 2>> ,K-Q-SIZE>
					<G=? .I ,GL-Q-MAX>
				>
				<RFALSE>
			)
		>
	>
	<RETURN .TIME>
>
 
;"---------------------------------------------------------------------------"
; "YZIP"
;"---------------------------------------------------------------------------"
 
<VERSION?
	(YZIP
		<ROUTINE C-PIXELS (X) <+ <* <- .X 1> ,GL-FONT-X> 1>>
		<ROUTINE L-PIXELS (Y) <+ <* <- .Y 1> ,GL-FONT-Y> 1>>
		<ROUTINE PIXELS-C (X) <+ </ <- .X 1> ,GL-FONT-X> 1>>
		<ROUTINE PIXELS-L (Y) <+ </ <- .Y 1> ,GL-FONT-Y> 1>>
		<ROUTINE CCURSET (Y X "OPT" (W -3)) <CURSET <L-PIXELS .Y> <C-PIXELS .X> .W>>
		<ROUTINE CCURGET (TBL)
			<CURGET .TBL>
			<PUT .TBL 0 <PIXELS-L <GET .TBL 0>>>
			<PUT .TBL 1 <PIXELS-C <GET .TBL 1>>>
			.TBL
		>
		<ROUTINE CSPLIT (Y) <SPLIT <* .Y ,GL-FONT-Y>>>
		<ROUTINE CWINPOS (W Y X) <WINPOS .W <L-PIXELS .Y> <C-PIXELS .X>>>
		<ROUTINE CWINSIZE (W Y X) <WINSIZE .W <* .Y ,GL-FONT-Y> <* .X ,GL-FONT-X>>>
	;	<ROUTINE CMARGIN (L R "OPT" (W -3)) <MARGIN <* .L ,GL-FONT-X> <* .R ,GL-FONT-X> .W>>
	;	<ROUTINE CPICINF (P TBL)
			<PICINF .P .TBL>
			<PUT .TBL 0 </ <GET .TBL 0> ,GL-FONT-Y>>
			<PUT .TBL 1 </ <GET .TBL 1> ,GL-FONT-X>>
		>
	;	<ROUTINE CDISPLAY (P Y X)
			<DISPLAY .P
				<COND (<ZERO? .Y> 0) (ELSE <L-PIXELS .Y>)>
				<COND (<ZERO? .X> 0) (ELSE <C-PIXELS .X>)>
			>
		>
	;	<ROUTINE CDCLEAR (P Y X)
			<DCLEAR .P
				<COND (<ZERO? .Y> 0) (ELSE <L-PIXELS .Y>)>
				<COND (<ZERO? .X> 0) (ELSE <C-PIXELS .X>)>
			>
		>
		<ROUTINE CSCROLL (W "OPT" (Y 1)) <SCROLL .W <* .Y ,GL-FONT-Y>>>
		<ROUTINE RT-SCRIPT-INBUF ("OPT" (BUF ,P-INBUF) "AUX" (CNT 0) N CHR)
			<SET N <GETB .BUF 1>>
			<DIROUT ,D-SCREEN-OFF>
			<SET BUF <REST .BUF>>
			<REPEAT ()
				<COND
					(<IGRTR? CNT .N>
						<RETURN>
					)
					(ELSE
						<SET CHR <GETB .BUF .CNT>>
						<COND
							(<AND <G=? .CHR !\a>
									<L=? .CHR !\z>
								>
								<PRINTC <- .CHR 32>>
							)
							(ELSE
								<PRINTC .CHR>
							)
						>
					)
				>
			>
			<CRLF>
			<DIROUT ,D-SCREEN-ON>
		>
	)
>
 
;"---------------------------------------------------------------------------"
; "GO"
;"---------------------------------------------------------------------------"
 
<GLOBAL GL-SCR-WID:NUMBER 79>
<CONSTANT K-WIN-TBL <TABLE 0 0 0>>
<GLOBAL GL-FONT-X 7 <> BYTE>
<GLOBAL GL-FONT-Y 10 <> BYTE>
<GLOBAL GL-SPACE-WIDTH 0 <> BYTE>
 
<ROUTINE GO ()
	<SETG GL-SCR-WID <LOWCORE SCRH>>
	<COND
		(<L? ,GL-SCR-WID 64>
			<TELL "[The screen is too narrow.]" CR>
			<QUIT>
		)
	>
	<SETG GL-FONT-Y <SHIFT <WINGET 0 ,WFSIZE> -8>>
	<SETG GL-FONT-X <ANDB <WINGET 0 ,WFSIZE> 255>>
 
	; "Determine width of space in pixels."
	<DIROUT ,K-D-TBL-ON ,K-DIROUT-TBL>
	<TELL " ">
	<DIROUT ,K-D-TBL-OFF>
	<SETG GL-SPACE-WIDTH <LOWCORE TWID>>
	<COND
		(<ZERO? ,GL-SPACE-WIDTH>
			<SETG GL-SPACE-WIDTH <LOWCORE HWRD>>
			<SETG GL-SPACE-WIDTH </ ,GL-SPACE-WIDTH <LOWCORE SCRH>>>
		)
	>
 
	<MOUSE-LIMIT -1>
	<CLEAR -1>
	<INIT-STATUS-LINE <>>
	<UPDATE-STATUS-LINE>
	<RT-QUEUE ,RT-I-GAS-MIX ,GL-MOVES>
	<RT-QUEUE ,RT-I-LEAVE-1 ,GL-MOVES>
	<RT-QUEUE ,RT-I-RETURN-1 <+ ,GL-MOVES 90>>
	<RT-QUEUE ,RT-I-CRANE-1 <+ ,GL-MOVES 120>>
	<RT-QUEUE ,RT-I-NITROGEN-LEAK <+ ,GL-MOVES 3>>
;	<RT-QUEUE ,RT-I-RUSSIAN <+ ,GL-MOVES 3>>
	<RT-QUEUE ,RT-I-TEMP ,GL-MOVES>
	<RT-QUEUE ,RT-I-CAB-FIXED <+ ,GL-MOVES 1320>>	; "11 hours later."
	<V-VERSION>
	<TELL CR
"	'Catfish' DeVries runs his eye over the gauges on the wall of Deepcore's
gas-mix room. \"They're done, Bud,\" he says, \"Cooked to a turn.\" He spins
the wheel in the steel door to the compression chamber, and it eases open
with a sigh.|
	A man with a military haircut quickly steps through the door, apparently
undisturbed by the six claustrophobic hours of compression that will enable
him to survive the atmosphere 2,000 feet below the sea's surface. He is
followed by three other men and one very pretty woman.|
	\"Brigman?\" he says to you. \"Coffey. Team leader.\" He gestures to
the others. \"Willhite, Schoenick, Monk. I gather you already know the little
lady.\"|
	Lindsey glares at him. \"Listen, Tarzan,\" she snaps, \"Let's get one
thing straight...\"|
	A nervous voice over the intercom interrupts her. \"Bud? It's Hippy.
I'm in the Control Module and I got something here on the screen you should
take a look at. Pronto.\"|
	You run out through the sub-bay with the others close on your heels.
When you arrive in the Command Module, Hippy is pointing to the ROV screen.
Coffey and the others crowd around behind you, looking over your shoulder.|
	\"It's a small submersible over by the Montana,\" Hippy says. \"I can't
make it out real well, but I saw some divers leaving her just a minute
ago.\"||"
	>
	<MARGIN 50 50>
	<TELL
"[GRAPHIC: A close-up of the ROV screen, with a hint of the controls that
surround it. On the screen is a murky picture of a submersible.]||"
	>
	<MARGIN 0 0>
	<TELL
"	\"Shit!\" Coffey shouts. \"We've got to secure that boat! Monk, take
Willhite and Schoenick and that big rig we saw in the MoonPool. I'll go in
the submersible we came down on. Brigman, I need some drivers.\"|
	One-Night cuts him off. \"I decide who drives what around here, mister.
I'll take your boys over in Flatbed. Hippy will drive you in Cab Three. We
leave in two minutes.\"|
	One-Night and Hippy leave the Command Module, followed by the SEALs.
You are left alone with Lindsey and Catfish.|"
	>
	; "Is there a elegant way to force the interpreter to do a 'more'?"
	<TELL "[MORE]">
	<INPUT 1>
	<CRLF>
	<INIT-STATUS-LINE>
	<CLEAR 6>
	<CURSET <- <WINGET 0 ,K-W-YSIZE> ,GL-FONT-Y> 1>
	<MAIN-LOOP>
	<AGAIN>
>
 
;"***************************************************************************"
; "end of file"
;"***************************************************************************"
 
