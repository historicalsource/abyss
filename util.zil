;"***************************************************************************"
; "game : Arthur"
; "file : UTIL.ZIL"
; "auth :   $Author:   DEB  $"
; "date :     $Date:   20 Mar 1989  8:44:10  $"
; "revs : $Revision:   1.14  $"
; "vers : 1.0"
;"---------------------------------------------------------------------------"
; "Utility routines"
; "Copyright (C) 1988 Infocom, Inc.  All rights reserved."
;"***************************************************************************"
 
;<ROUTINE RT-COUNT-LINES (FTBL "AUX" (CNT 0))
	<REPEAT (I (PTR .FTBL))
		<COND
			(<ZERO? <SET I <GET .PTR 0>>>
				<RETURN>
			)
			(T
				<INC CNT>
				<SET PTR <REST <REST .PTR 2> .I>>
			)
		>
	>
	<RETURN .CNT>
>
 
;<ROUTINE RT-PRINTF (TBL "AUX" I)
	<REPEAT ()
		<COND
			(<ZERO? <SET I <ZGET .TBL 0>>>
				<RETURN>
			)
			(T
				<SET TBL <ZREST .TBL 2>>
				<PRINTT .TBL .I>
				<CCURGET ,K-WIN-TBL>
				<COND
					(<NOT <EQUAL? <ZGET ,K-WIN-TBL 1> 1>>
						<CRLF>
					)
				>
				<SET TBL <ZREST .TBL .I>>
			)
		>
	>
>
 
;<ROUTINE RT-MAKE-FTBL (TBL WID "AUX" CNT PTR Q N I SP?)
	<COND
		(<L? .WID 0>
			<SET WID <- .WID>>
		)
		(T
			<SET WID </ <WINGET .WID ,K-W-XSIZE> ,GL-FONT-X>>
		)
	>
	<SET CNT <ZGET .TBL 0>>
	<REPEAT ()
		<SET PTR <ZREST .TBL 2>>
		<SET SP? <>>
		<COND
			(<G? .WID .CNT>
				<SET I .CNT>
			)
			(T
				<SET I .WID>
			)
		>
		<COND
			(<SET Q <INTBL? 13 .PTR .I 1>>
				<PUTB .Q 0 !\ >
				<SET SP? T>
				<SET I <- .I <+ <- .Q .PTR> 1>>>
				<SET PTR <ZREST .Q 1>>
			)
			(<L=? .WID .CNT>
				<REPEAT ()
					<COND
						(<NOT <SET Q <INTBL? !\ .PTR .I 1>>>
							<RETURN>
						)
						(T
							<SET SP? T>
							<SET I <- .I <+ <- .Q .PTR> 1>>>
							<SET PTR <ZREST .Q 1>>
						)
					>
				>
			)
		>
		<COND
			(.SP?
				<SET I <- .PTR <ZREST .TBL 2>>>
				<SET .CNT <- .CNT .I>>
				<COPYT .PTR <ZREST .TBL <+ .WID 4>> .CNT>
				<SET N <- .WID .I>>
				<COND
					(<G? .N 0>
						<PUTB .PTR 0 !\ >
						<DEC N>
						<COND
							(<G? .N 0>
								<COPYT .PTR <ZREST .PTR 1> <- .N>>
							)
						>
					)
				>
			)
			(<G? .WID .CNT>
				<SET N <- .WID .CNT>>
				<SET PTR <ZREST .TBL <+ .CNT 2>>>
				<PUTB .PTR 0 !\ >
				<COND
					(<G? .N 1>
						<COPYT .PTR <ZREST .PTR 1> <- .N>>
					)
				>
				<SET CNT 0>
			)
			(T
				<SET .CNT <- .CNT .WID>>
				<SET PTR <ZREST .TBL <+ .WID 2>>>
				<COPYT .PTR <ZREST .PTR 2> .CNT>
			)
		>
		<ZPUT .TBL 0 .WID>
		<SET TBL <ZREST .TBL <+ .WID 2>>>
		<COND
			(<ZERO? .CNT>
				<ZPUT .TBL 0 0>
				<RETURN>
			)
		>
	>
>
 
%<DEBUG-CODE <SYNTAX $STEAL OBJECT (EVERYWHERE) = V-$STEAL>>
%<DEBUG-CODE
	<ROUTINE V-$STEAL ()
		<COND
			(<RT-DO-TAKE ,PRSO T>
				<SETG CLOCK-WAIT T>
				<TELL "[" The+verb ,PRSO "appear" " in your hand.]" CR>
			)
		>
		<RTRUE>
	>
>
 
%<DEBUG-CODE <SYNTAX $GOTO OBJECT (EVERYWHERE) = V-$GOTO>>
%<DEBUG-CODE
	<ROUTINE V-$GOTO ("AUX" (OBJ ,PRSO))
		<SETG CLOCK-WAIT T>
		<REPEAT ()
			<COND
				(<IN? .OBJ ,ROOMS>
					<RT-GOTO .OBJ>
					<RTRUE>
				)
				(<EQUAL? <LOC .OBJ> ,LOCAL-GLOBALS ,GLOBAL-OBJECTS <>>
					<TELL "[" The+verb ,PRSO "are" "n't in a room.]" CR>
					<RTRUE>
				)
				(T
					<SET OBJ <LOC .OBJ>>
				)
			>
		>
	>
>
 
<ROUTINE V-VERSION ()
	<HLIGHT ,K-H-BLD>
	<TELL
"The Abyss|
Copyright (c) 1989 Infocom, Inc. All rights reserved.|"
<GET ,K-MACHINE-NAME-TBL <LOWCORE INTID>> " Interpreter version "
N <LOWCORE (ZVERSION 0)> "." N <LOWCORE INTVR> CR
"Release " N <BAND <LOWCORE ZORKID> *3777*> " / Serial Number "
	>
	<LOWCORE-TABLE SERIAL 6 PRINTC>
	<CRLF>
	<HLIGHT ,K-H-NRM>
>
 
<CONSTANT K-MACHINE-NAME-TBL
	<TABLE (PURE LENGTH)
		"Debugging"
		"Apple IIe"
		"Macintosh"
		"Amiga"
		"Atari ST"
		"IBM"
		"Commodore 128"
		"Commodore 64"
		"Apple IIc"
		"Apple IIgs"
	>
>
 
<VERB-SYNONYM COLOR COLOUR>
<SYNTAX COLOR = V-COLOR>
 
<GLOBAL GL-COLOR-NOTE <> <> BYTE>
<GLOBAL GL-F-COLOR 1 <> BYTE>
<GLOBAL GL-B-COLOR 1 <> BYTE>
 
<ROUTINE V-COLOR ("AUX" S)
	<COND
		(<NOT ,GL-COLOR-NOTE>
			<SETG GL-COLOR-NOTE T>
			<TELL
TAB "Aesthetically, we recommend not changing the standard setting"
			>
			<COND
				(<EQUAL? <LOWCORE INTID> ,MACINTOSH>
					<COND
						(<MAC-II?>	; "Color?"
							<TELL
", and if your Mac II displays only 16 colors, you probably won't get
the color you ask for"
							>
						)
						(T
							<TELL
", and you can have only black on white or white on black"
							>
						)
					>
				)
			>
			<TELL ". Do you still want to go ahead?|">
			<COND
				(<NOT <Y?>>
					<RTRUE>
				)
			>
		)
	>
	<CRLF>
	<REPEAT ()
		<RT-DO-COLOR>
		<TELL
TAB "You should now get " <GET ,K-COLOR-TABLE ,GL-F-COLOR> " text on a "
<GET ,K-COLOR-TABLE ,GL-B-COLOR> " background. Is that what you want?|"
		>
		<COND
			(<Y?>
				<RETURN>
			)
		>
		<COND
			(<AND <EQUAL? <LOWCORE INTID> ,MACINTOSH>
					<NOT <MAC-II?>>	; "Not color?"
				>
				<COND
					(<EQUAL? ,GL-B-COLOR 2>
						<SETG GL-B-COLOR 9>
						<SETG GL-F-COLOR 2>
					)
					(T
						<SETG GL-B-COLOR 2>
						<SETG GL-F-COLOR 9>
					)
				>
				<RETURN>
			)
		>
		<TELL
TAB "Do you want to pick again, or would you like to just go back to the
standard colors? (Type Y to pick again) >"
		>
		<COND
			(<Y? <>>
				<CRLF>
			)
			(T
				<SETG GL-F-COLOR 1>
				<SETG GL-B-COLOR 1>
				<RETURN>
			)
		>
	>
	<SET S 0>
	<REPEAT ()
		<SCREEN .S>
		<COLOR ,GL-F-COLOR ,GL-B-COLOR>
		<COND
			(<IGRTR? S 7>
				<RETURN>
			)
		>
	>
	<V-$REFRESH>
>
 
<ROUTINE RT-DO-COLOR ()
	<COND
		(<AND <EQUAL? <LOWCORE INTID> ,MACINTOSH>
				<NOT <MAC-II?>> ;"b&w Mac"
			>
			<COND
				(<EQUAL? ,GL-B-COLOR 2>
					<SETG GL-B-COLOR 9>
					<SETG GL-F-COLOR 2>
				)
				(T
					<SETG GL-B-COLOR 2>
					<SETG GL-F-COLOR 9>
				)
			>
		)
		(T
			<SETG GL-F-COLOR <RT-PICK-COLOR ,GL-F-COLOR "text" T>>
			<SETG GL-B-COLOR <RT-PICK-COLOR ,GL-B-COLOR "background">>
		)
	>
>
 
<ROUTINE RT-PICK-COLOR (WHICH STRING "OPTIONAL" (SETTING-FG <>) "AUX" CHAR)
	<TELL
"The current " .STRING " color is " <GET ,K-COLOR-TABLE .WHICH> "." CR
	>
	<FONT 4>
	<TELL
"   1 --> WHITE   5 --> YELLOW" CR
"   2 --> BLACK   6 --> BLUE" CR
"   3 --> RED     7 --> MAGENTA" CR
"   4 --> GREEN   8 --> CYAN" CR
	>
	<FONT 1>
	<TELL
"Type a number to select the " .STRING " color you want. >"
	>
	<REPEAT ()
		<COND
		;	(,DEMO-VERSION?
				<SET CHAR <INPUT-DEMO 1>>
			)
			(T
				<SET CHAR <INPUT 1>>
			)
		>
		<SET CHAR <- .CHAR !\0>> ; "convert from ASCII"
		<COND
			(<EQUAL? .CHAR 1> ; "white is really 9, not 1"
				<SET CHAR 9>
			)
		>
		<COND
			(<EQUAL? .CHAR 2 3 4 5 6 7 8 9>
				<COND
					(<AND <NOT .SETTING-FG>
							<EQUAL? .CHAR ,GL-F-COLOR>
						>
						<TELL
CR "You can't make the background the same color as the text. Please pick
another color. >"
						>
					)
					(T
						<RETURN>
					)
				>
			)
			(T
				<TELL CR ,K-TYPE-NUMBER-MSG "8. >">
			)
		>
	>
	<CRLF>
	<CRLF>
	<RETURN .CHAR>
>
 
<CONSTANT K-TYPE-NUMBER-MSG "Please press a number from 1 to ">
 
<CONSTANT K-COLOR-TABLE
	<TABLE (PURE)
		;0 "no change"
		;1 "the standard color"
		;2 "black"
		;3 "red"
		;4 "green"
		;5 "yellow"
		;6 "blue"
		;7 "magenta"
		;8 "cyan"
		;9 "white"
	>
>
 
<ROUTINE MAC-II? ()
	; "Determine if color flag is set."
	<COND
		(<FLAG-ON? ,F-COLOR>
			<RTRUE>
		)
	>
>
 
<ROUTINE Y? ("OPT" (P? T) "AUX" C (1ST? T))
	<REPEAT ()
		<COND
			(.P?
				<TELL "Please press Y or N >">
			)
		>
		<COND
		;	(,DEMO-VERSION?
				<SET C <INPUT-DEMO 1>>
			)
			(T
				<SET C <INPUT 1>>
			)
		>
		<COND
			(<EQUAL? .C !\Y !\N !\y !\n>
				<PRINTC .C>
				<CRLF>
				<COND
					(<EQUAL? .C !\Y !\y>
						<RTRUE>
					)
					(T
						<RFALSE>
					)
				>
			)
			(T
				<SOUND ,S-BEEP>
			)
		>
		<COND
			(.P?
				<CRLF>
			)
		>
	>
>
 
<ROUTINE RT-CHECK-ADJ (DOOR)
	<RFALSE>
;	<COND
		(<EQUAL? .DOOR ,LG-FRONT-DOOR>
			<RT-UPDATE-ADJ ,LG-FRONT-DOOR ,RM-FOYER ,RM-FRONT-PORCH>
		)
	>
>
 
<ROUTINE RT-UPDATE-ADJ (DOOR RM1 RM2 "AUX" TMP1 TMP2)
	<SET TMP2 <GETP .RM1 ,P?ADJACENT>>
	<COND
		(.TMP2
			<COND
				(<SET TMP1 <INTBL? .RM2 <REST .TMP2 1> <GETB .TMP2 0> 1>>
					<PUTB .TMP1 1 <FSET? .DOOR ,FL-OPEN>>
				)
			>
		)
	>
	<SET TMP2 <GETP .RM2 ,P?ADJACENT>>
	<COND
		(.TMP2
			<COND
				(<SET TMP1 <INTBL? .RM1 <REST .TMP2 1> <GETB .TMP2 0> 1>>
					<PUTB .TMP1 1 <FSET? .DOOR ,FL-OPEN>>
				)
			>
		)
	>
>
 
<ROUTINE RT-SCORE-MSG (N "OPT" (NL? T))
	<COND
		(.N
			<SETG GL-SCORE <+ ,GL-SCORE .N>>
			<HLIGHT ,H-BOLD>
			<COND
				(.NL?
					<CRLF>
				)
			>
			<TELL "[You have ">
			<COND
				(<G? .N 0>
					<TELL "earned">
				)
				(T
					<TELL "lost">
				)
			>
			<TELL wn .N " point">
			<COND
				(<NOT <EQUAL? <ABS .N> 1>>
					<TELL "s">
				)
			>
			<TELL ".]">
			<COND
				(.NL?
					<CRLF>
				)
			>
			<HLIGHT ,H-NORMAL>
			<RTRUE>
		)
	>
>
 
<ROUTINE RT-SCORE-OBJ (OBJ "OPT" (NL? T) "AUX" SC)
	<COND
		(<SET SC <GETP .OBJ ,P?SCORE>>
			<RT-SCORE-MSG .SC .NL?>
			<PUTP .OBJ ,P?SCORE 0>
			<RTRUE>
		)
	>
>
 
<GLOBAL GL-SCORE 0 <> BYTE>
 
<ROUTINE V-SCORE ()
	<TELL "You have" wn ,GL-SCORE " point">
	<COND
		(<NOT <EQUAL? <ABS ,GL-SCORE> 1>>
			<TELL "s">
		)
	>
	<TELL "." CR>
>
 
<ROUTINE V-DIAGNOSE ("AUX" (N 0) (1ST? T) TMP OXY CO2 NIT)
	; "Add up the number of messages we need to give."
	<COND
		(<SET TMP
				<OR
					<L=? ,GL-PLAYER-TEMP ,K-TEMP-LOW-1>
					<G=? ,GL-PLAYER-TEMP ,K-TEMP-HIGH-1>
				>
			>
			<SET N <+ .N 1>>
		)
	>
	<COND
		(<SET OXY
				<OR
					<L=? ,GL-OXYGEN-QTY ,K-OXY-LOW-1>
					<G=? ,GL-OXYGEN-QTY ,K-OXY-HIGH-1>
				>
			>
			<SET N <+ .N 1>>
		)
	>
	<COND
		(<SET CO2 <G=? ,GL-CO2-QTY ,K-CO2-HIGH-1>>
			<SET N <+ .N 1>>
		)
	>
	<COND
		(<SET NIT
				<OR
					<L=? ,GL-NITROGEN-QTY ,K-NIT-LOW-1>
					<G=? ,GL-NITROGEN-QTY ,K-NIT-HIGH-1>
				>
			>
			<SET N <+ .N 1>>
		)
	>
 
	<TELL TAB>
	<COND
		(<ZERO? .N>
			<TELL "You feel fine">
		)
		(T
			<COND
				(.TMP
					<SET N <- .N 1>>
					<COND
; "Checking for first phrase not needed since, if we're printing this one,
	it must be first."
					;	(<NOT .1ST?>
							<TELL ", ">
							<COND
								(<ZERO? .N>
									<TELL "and ">
								)
							>
							<SET M 32>
						)
						(T
							<SET 1ST? <>>
						;	<SET M 0>
						)
					>
					<COND
						(<L=? ,GL-PLAYER-TEMP ,K-TEMP-LOW-3>
						;	<TELL C <ORB !\Y .M> "ou're so cold you can hardly move">
							<TELL "You're so cold you can hardly move">
						)
						(<L=? ,GL-PLAYER-TEMP ,K-TEMP-LOW-2>
						;	<TELL C <ORB !\T .M> "he cold is creeping into your bones">
							<TELL "The cold is creeping into your bones">
						)
						(<L=? ,GL-PLAYER-TEMP ,K-TEMP-LOW-1>
						;	<TELL C <ORB !\Y .M> "ou are shivering">
							<TELL "You are shivering">
						)
						(<G=? ,GL-PLAYER-TEMP ,K-TEMP-HIGH-3>
						;	<TELL
C <ORB !\Y .M> "ou're so hot you can hardly move and your breathing is
dangerously fast"
							>
							<TELL
"You're so hot you can hardly move and your breathing is dangerously fast"
							>
						)
						(<G=? ,GL-PLAYER-TEMP ,K-TEMP-HIGH-2>
							<TELL "Your face is red from the heat">
						)
						(<G=? ,GL-PLAYER-TEMP ,K-TEMP-HIGH-1>
						;	<TELL C <ORB !\Y .M> "ou are sweating">
							<TELL "You are sweating">
						)
					>
				)
			>
			<COND
				(.OXY
					<SET N <- .N 1>>
					<COND
						(<NOT .1ST?>
							<TELL ", ">
							<COND
								(<ZERO? .N>
									<TELL "and ">
								)
							>
							<SET M 32>
						)
						(T
							<SET 1ST? <>>
							<SET M 0>
						)
					>
					<COND
						(<L=? ,GL-OXYGEN-QTY ,K-OXY-LOW-3>
							<TELL C <ORB !\Y .M> "our peripheral vision has disappeared">
						)
						(<L=? ,GL-OXYGEN-QTY ,K-OXY-LOW-2>
							<TELL C <ORB !\T .M> "he colors around you seem faded">
						)
						(<L=? ,GL-OXYGEN-QTY ,K-OXY-LOW-1>
							<TELL C <ORB !\Y .M> "ou have a headache">
						)
						(<G=? ,GL-OXYGEN-QTY ,K-OXY-HIGH-3>
							<TELL
C <ORB !\Y .M> "our stomach muscles are tight and you feel an urge to vomit"
							>
						)
						(<G=? ,GL-OXYGEN-QTY ,K-OXY-HIGH-2>
							<TELL C <ORB !\Y .M> "ou feel nauseous">
						)
						(<G=? ,GL-OXYGEN-QTY ,K-OXY-HIGH-1>
							<TELL C <ORB !\Y .M> "ou have a twitch in your lower lip">
						)
					>
				)
			>
			<COND
				(.CO2
					<SET N <- .N 1>>
					<COND
						(<NOT .1ST?>
							<TELL ", ">
							<COND
								(<ZERO? .N>
									<TELL "and ">
								)
							>
							<SET M 32>
						)
						(T
							<SET 1ST? <>>
							<SET M 0>
						)
					>
					<COND
						(<G=? ,GL-CO2-QTY ,K-CO2-HIGH-3>
							<TELL C <ORB !\T .M> "he muscles in your arm are spasming">
						)
						(<G=? ,GL-CO2-QTY ,K-CO2-HIGH-2>
							<TELL C <ORB !\Y .M> "our chest muscles ache">
						)
						(<G=? ,GL-CO2-QTY ,K-CO2-HIGH-1>
							<TELL C <ORB !\Y .M> "ou feel a little short of breath">
						)
					>
				)
			>
			<COND
				(.NIT
					<SET N <- .N 1>>
					<COND
						(<NOT .1ST?>
							<TELL ", ">
							<COND
								(<ZERO? .N>
									<TELL "and ">
								)
							>
							<TELL "y">
						)
						(T
							<SET 1ST? <>>
							<TELL "Y">
						)
					>
					<COND
						(<L=? ,GL-NITROGEN-QTY ,K-NIT-LOW-3>
							<TELL "ou have flashes of sudden irritibility">
						)
						(<L=? ,GL-NITROGEN-QTY ,K-NIT-LOW-2>
							<TELL "our fingertips are shaking badly">
						)
						(<L=? ,GL-NITROGEN-QTY ,K-NIT-LOW-1>
							<TELL "our hands are trembling">
						)
						(<G=? ,GL-NITROGEN-QTY ,K-NIT-HIGH-3>
							<TELL "ou are hallucinating">
						)
						(<G=? ,GL-NITROGEN-QTY ,K-NIT-HIGH-2>
							<TELL "our head is spinning">
						)
						(<G=? ,GL-NITROGEN-QTY ,K-NIT-HIGH-1>
							<TELL "ou feel light-headed">
						)
					>
				)
			>
		)
	>
	<TELL "." CR>
>
 
<ROUTINE RT-WORD-NUMBERS (COUNT "OPT" (1ST? T) "AUX" N)
	<COND
		(.1ST?
			<TELL " ">
			<COND
				(<L? .COUNT 0>
					<TELL "negative ">
					<SET COUNT <- .COUNT>>
				)
			>
		)
	>
	<COND
		(<EQUAL? .COUNT  0> <TELL "zero">)
		(<EQUAL? .COUNT  1> <TELL "one">)
		(<EQUAL? .COUNT  2> <TELL "two">)
		(<EQUAL? .COUNT  3> <TELL "three">)
		(<EQUAL? .COUNT  4> <TELL "four">)
		(<EQUAL? .COUNT  5> <TELL "five">)
		(<EQUAL? .COUNT  6> <TELL "six">)
		(<EQUAL? .COUNT  7> <TELL "seven">)
		(<EQUAL? .COUNT  8> <TELL "eight">)
		(<EQUAL? .COUNT  9> <TELL "nine">)
		(<EQUAL? .COUNT 10> <TELL "ten">)
		(<EQUAL? .COUNT 11> <TELL "eleven">)
		(<EQUAL? .COUNT 12> <TELL "twelve">)
		(<EQUAL? .COUNT 13> <TELL "thirteen">)
		(<EQUAL? .COUNT 14> <TELL "fourteen">)
		(<EQUAL? .COUNT 15> <TELL "fifteen">)
		(<EQUAL? .COUNT 16> <TELL "sixteen">)
		(<EQUAL? .COUNT 17> <TELL "seventeen">)
		(<EQUAL? .COUNT 18> <TELL "eighteen">)
		(<EQUAL? .COUNT 19> <TELL "nineteen">)
		(<EQUAL? .COUNT 20> <TELL "twenty">)
		(<EQUAL? .COUNT 30> <TELL "thirty">)
		(<EQUAL? .COUNT 40> <TELL "forty">)
		(<EQUAL? .COUNT 50> <TELL "fifty">)
		(<EQUAL? .COUNT 60> <TELL "sixty">)
		(<EQUAL? .COUNT 70> <TELL "seventy">)
		(<EQUAL? .COUNT 80> <TELL "eighty">)
		(<EQUAL? .COUNT 90> <TELL "ninety">)
		(<L? .COUNT 100>
			<SET N <MOD .COUNT 10>>
			<RT-WORD-NUMBERS <- .COUNT .N> <>>
			<TELL "-">
			<RT-WORD-NUMBERS .N <>>
		)
		(<L? .COUNT 1000>
			<RT-WORD-NUMBERS </ .COUNT 100> <>>
			<TELL " hundred">
			<COND
				(<G? <MOD .COUNT 100> 0>
					<TELL " and ">
					<RT-WORD-NUMBERS <MOD .COUNT 100> <>>
				)
			>
		)
		(T
			<RT-WORD-NUMBERS </ .COUNT 1000> <>>
			<TELL " thousand">
			<COND
				(<G? <MOD .COUNT 1000> 0>
					<TELL ", ">
					<RT-WORD-NUMBERS <MOD .COUNT 1000> <>>
				)
			>
		)
	>
>
 
<ROUTINE RT-END-OF-GAME ("OPT" (WIN? <>) (REPEAT <>) "AUX" VAL)
	<UPDATE-STATUS-LINE>
	<COND
		(<NOT .REPEAT>
			<TELL TAB "Sorry, but the game is over. ">
		)
	>
	<REPEAT ()
		<COND
			(.REPEAT
			;	<CRLF>
				<TELL TAB>
			)
			(T
				<SET REPEAT T>
			)
		>
		<TELL "Do you want to ">
		<COND
			(,P-CAN-UNDO
				<TELL "Undo, ">
			)
		>
	;	<TELL "Restore, Restart, Quit, or get a Hint ?" CR>
		<TELL "Restore, Restart, or Quit ?|">
		<REPEAT ()
			<TELL ">">
			<VERSION?
				(XZIP
					<PUTB ,P-INBUF 1 0>
				)
				(YZIP
					<PUTB ,P-INBUF 1 0>
				)
			>
			<REPEAT ()
				<SET VAL <ZREAD ,P-INBUF ,P-LEXV>>
				<COND
					(<EQUAL? .VAL 10 13>
						<RETURN>
					)
				;	(T
						<RT-HOT-KEY .VAL>
					)
				>
			>
			<SET VAL <GET ,P-LEXV ,P-LEXSTART>>
			<COND
				(<AND ,P-CAN-UNDO
						<EQUAL? .VAL ,W?UNDO>
					>
					<V-UNDO>
					<RETURN>
				)
				(<EQUAL? .VAL ,W?RESTART>
					<RESTART>
					<RETURN>
				)
				(<EQUAL? .VAL ,W?RESTORE>
					<V-RESTORE>
					<RETURN>
				)
				(<EQUAL? .VAL ,W?QUIT ,W?Q>
					<TELL "Are you sure you want to quit?">
					<COND
						(<YES? T>
							<QUIT>
						)
						(T
							<RETURN>
						)
					>
				)
			;	(<EQUAL? .VAL ,W?HINT>
					<V-HINT>
					<RETURN>
				)
				(T
					<TELL TAB "Please type ">
					<COND
						(,P-CAN-UNDO
							<TELL "UNDO, ">
						)
					>
					<TELL "RESTORE, RESTART, QUIT, or HINT." CR>
				)
			>
		>
	>
>
 
<ROUTINE RT-COMMA-MSG (MORE?)
	<COND
		(.MORE?
			<TELL ",">
		)
		(T
			<TELL " and">
		)
	>
>
 
;<ROUTINE FIND-FLAG-NOT (RM FLAG "AUX" OBJ)
	<SET OBJ <FIRST? .RM>>
	<REPEAT ()
		<COND
			(<NOT .OBJ>
				<RFALSE>
			)
			(<AND <NOT <FSET? .OBJ .FLAG>>
					<NOT <FSET? .OBJ ,FL-INVISIBLE>>
				>
				<RETURN .OBJ>
			)
			(T
				<SET OBJ <NEXT? .OBJ>>
			)
		>
	>
>
 
<ROUTINE FIND-FLAG-LG (RM FLAG "OPTIONAL" (FLAG2 0) "AUX" TBL OBJ (CNT 0) SIZE)
	<COND
		(<SET TBL <GETPT .RM ,P?GLOBAL>>
			<SET SIZE <RMGL-SIZE .TBL>>
			<REPEAT ()
				<SET OBJ <GET/B .TBL .CNT>>
				<COND
					(<AND <FSET? .OBJ .FLAG>
							<NOT <FSET? .OBJ ,FL-INVISIBLE>>
							<OR
								<0? .FLAG2>
								<FSET? .OBJ .FLAG2>
							>
						>
						<RETURN .OBJ>
					)
					(<IGRTR? CNT .SIZE>
						<RFALSE>
					)
				>
			>
		)
	>
>
 
<ROUTINE FIND-FLAG (RM FLAG "OPTIONAL" (NOT1 <>) (NOT2 <>) "AUX" OBJ)
	<SET OBJ <FIRST? .RM>>
	<REPEAT ()
		<COND
			(<NOT .OBJ>
				<RFALSE>
			)
			(<AND <FSET? .OBJ .FLAG>
					<NOT <FSET? .OBJ ,FL-INVISIBLE>>
					<NOT <EQUAL? .OBJ .NOT1 .NOT2>>
				>
				<RETURN .OBJ>
			)
			(T
				<SET OBJ <NEXT? .OBJ>>
			)
		>
	>
>
 
<ROUTINE RT-ALREADY-MSG (OBJ "OPTIONAL" (STR <>))
	<SETG CLOCK-WAIT T>
	<TELL "[" The+verb .OBJ "are" " already">
	<COND
		(.STR
			<TELL " " .STR ".]" CR>
		)
	>
	<RTRUE>
>
 
<ROUTINE RT-META-IN? (OBJ CONT "AUX" L)
	<SET L <LOC .OBJ>>
	<REPEAT ()
		<COND
			(<ZERO? .L>
				<RFALSE>
			)
			(<EQUAL? .L .CONT>
				<RTRUE>
			)
			(T
				<SET L <LOC .L>>
			)
		>
	>
>
 
<ROUTINE NO-NEED ("OPTIONAL" (STR <>) (OBJ <>))
	<COND
		(<NOT .OBJ>
			<SET OBJ ,PRSO>
		)
	>
	<SETG CLOCK-WAIT T>
	<TELL "[" The+verb ,WINNER "do" "n't need to ">
	<COND
		(.STR
			<TELL .STR>
		)
		(T
		;	<VERB-PRINT>
			<PRINTB <PARSE-VERB ,PARSE-RESULT>>
		)
	>
	<COND
		(<EQUAL? .STR "go" ;"drive">
			<TELL " in that " D ,INTDIR>
		)
		(.OBJ
			<TELL the .OBJ>
		)
	>
	<TELL ".]" CR>
>
 
<ROUTINE RT-YOU-CANT-MSG ("OPT" (STR <>) (WHILE <>) (STR1 <>))
	<SETG CLOCK-WAIT T>
	<TELL "[" The ,WINNER " can't ">
	<COND
		(<ZERO? .STR>
		;	<VERB-PRINT>
			<PRINTB <PARSE-VERB ,PARSE-RESULT>>
		)
		(T
			<TELL .STR>
		)
	>
	<COND
		(<EQUAL? .STR "go" ;"drive">
			<TELL " in that " D ,INTDIR>
		)
		(T
			<TELL the ,PRSO>
			<COND
				(.STR1
					<TELL " while">
					<COND
						(.WHILE
							<TELL he+verb .WHILE "are">
						)
						(T
							<TELL he+verb ,PRSO "are">
						)
					>
					<TELL " " .STR1>
				)
			>
		)
	>
	<TELL ".]" CR>
>
 
<ROUTINE HAR-HAR ()
	<SETG CLOCK-WAIT T>
	<TELL "[You can't be serious.]" CR>
>
 
<ROUTINE RT-IMPOSSIBLE-MSG ()
	<SETG CLOCK-WAIT T>
	<TELL "[That's impossible.]" CR>
>
 
<ROUTINE WONT-HELP ()
	<SETG CLOCK-WAIT T>
	<TELL "[That would be a waste of time.]" CR>
>
 
<ROUTINE PICK-ONE (TBL)
	<GET .TBL <RANDOM <GET .TBL 0>>>
>
 
<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" TBL)
	<COND
		(<EQUAL? .OBJ1 .OBJ2>
			<RTRUE>
		)
		(<SET TBL <GETPT .OBJ2 ,P?GLOBAL>>
			<INTBL? .OBJ1 .TBL </ <PTSIZE .TBL> 2>>
		)
	>
>
 
<ROUTINE RT-FIRST-YOU-MSG (STR "OPTIONAL" (OBJ <>) (OBJ2 <>))
	<TELL "[">
	<RT-PRINT-OBJ ,WINNER ,K-ART-THE T .STR>
	<COND
		(.OBJ
			<TELL the .OBJ>
			<COND
				(<AND .OBJ2
						<NOT <IN? .OBJ2 ,ROOMS>>
					>
					<TELL " from" the .OBJ2>
				)
			>
		)
	>
	<TELL " first.]" CR>
>
 
<ROUTINE RT-SEE-INSIDE? (OBJ "OPT" (ONLY-IN <>))
	<COND
	;	(<FSET? .OBJ ,FL-INVISIBLE>
			<RFALSE>		;"for LIT? - PLAYER"
		)
		(<IN? .OBJ ,ROOMS>
			<RTRUE>
		)
		(<FSET? .OBJ ,FL-TRANSPARENT>
			<RTRUE>
		)
		(<FSET? .OBJ ,FL-OPEN>
			<RTRUE>
		)
		(.ONLY-IN
			<RFALSE>
		)
		(<FSET? .OBJ ,FL-SURFACE>
			<RTRUE>
		)
	>
>
 
<ROUTINE RT-SEE-ANYTHING-IN? (CONT "AUX" OBJ)
	<SET OBJ <FIRST? .CONT>>
	<REPEAT ()
		<COND
			(.OBJ
				<COND
					(<AND <NOT <FSET? .OBJ ,FL-INVISIBLE>>
							<NOT <FSET? .OBJ ,FL-NO-DESC>>
							<NOT <EQUAL? .OBJ ,WINNER>>
						>
						<RTRUE>
					)
				>
				<SET OBJ <NEXT? .OBJ>>
			)
			(T
				<RFALSE>
			)
		>
	>
>
 
<ROUTINE RT-MOVE-ALL (FROM "OPT" (TO <>) "AUX" NXT OBJ (CNT 0))
	<SET OBJ <FIRST? .FROM>>
	<REPEAT ()
		<COND
			(<NOT .OBJ>
				<RETURN>
			)
			(T
				<SET NXT <NEXT? .OBJ>>
				<FCLEAR .OBJ ,FL-WORN>
				<COND
					(.TO
						<MOVE .OBJ .TO>
					)
					(T
						<REMOVE .OBJ>
					)
				>
				<INC CNT>
				<SET OBJ .NXT>
			)
		>
	>
	<RETURN .CNT>
>
 
<ROUTINE RT-MOVE-ALL-BUT-WORN (FROM "OPT" (TO <>) "AUX" NXT OBJ (CNT 0))
	<SET OBJ <FIRST? .FROM>>
	<REPEAT ()
		<COND
			(<NOT .OBJ>
				<RETURN>
			)
			(T
				<SET NXT <NEXT? .OBJ>>
				<COND
					(<NOT <FSET? .OBJ ,FL-WORN>>
						<COND
							(.TO
								<MOVE .OBJ .TO>
							)
							(T
								<REMOVE .OBJ>
							)
						>
						<INC CNT>
					)
				>
				<SET OBJ .NXT>
			)
		>
	>
	<RETURN .CNT>
>
 
<ROUTINE RT-MOVE-ALL-WORN (FROM "OPT" (TO <>) "AUX" NXT OBJ (CNT 0))
	<SET OBJ <FIRST? .FROM>>
	<REPEAT ()
		<COND
			(<NOT .OBJ>
				<RETURN>
			)
			(T
				<SET NXT <NEXT? .OBJ>>
				<COND
					(<FSET? .OBJ ,FL-WORN>
						<COND
							(.TO
								<MOVE .OBJ .TO>
							)
							(T
								<REMOVE .OBJ>
							)
						>
						<INC CNT>
					)
				>
				<SET OBJ .NXT>
			)
		>
	>
	<RETURN .CNT>
>
 
<CONSTANT K-NOT-LIKELY-TBL
	<TABLE (PATTERN (BYTE WORD))
		<BYTE 1>
		<TABLE (PURE LENGTH)
			"isn't likely"
			"seems doubtful"
			"seems unlikely"
			"doesn't seem likely"
		>
	>
>
 
<ROUTINE RT-NOT-LIKELY-MSG (OBJ STR)
	<TELL
"It " <RT-PICK-NEXT ,K-NOT-LIKELY-TBL> " that" the .OBJ " " .STR "." CR
	>
>
 
<CONSTANT K-NO-POINT-TBL
	<TABLE (PATTERN (BYTE WORD))
		<BYTE 1>
		<TABLE (PURE LENGTH)
			"not do anything useful"
			"accomplish nothing"
			"have no desirable effect"
			"not be very productive"
			"serve no purpose"
			"be pointless"
		>
	>
>
 
<ROUTINE RT-NO-POINT-MSG (STR OBJ)
	<TELL .STR the .OBJ " would " <RT-PICK-NEXT ,K-NO-POINT-TBL> "." CR>
>
 
<CONSTANT K-UNUSUAL-TBL
	<TABLE (PATTERN (BYTE WORD))
		<BYTE 1>
		<TABLE (PURE LENGTH)
			"unusual"
			"special"
			"interesting"
			"important"
			"of interest"
			"out of the ordinary"
		>
	>
>
 
<ROUTINE RT-PICK-NEXT (TBL "AUX" CNT STR NT)
	<SET CNT <GETB .TBL 0>>
	<SET NT <ZGET <REST .TBL 1> 0>>
	<SET STR <ZGET .NT .CNT>>
	<COND
		(<G? <SET CNT <+ .CNT 1>> <GET .NT 0>>
			<SET CNT 1>
		)
	>
	<PUTB .TBL 0 .CNT>
	<RETURN .STR>
>
 
<CONSTANT K-TOO-DARK-MSG "It's too dark to see.">
<CONSTANT K-TALK-TO-SELF-MSG "[Talking to yourself is a bad sign.]">
 
<ROUTINE RT-NO-RESPONSE-MSG ("OPT" (OBJ <>))
   <COND
      (<NOT .OBJ>
			<SET OBJ ,PRSO>
      )
   >
	<COND
		(<EQUAL? .OBJ ,ROOMS>
			<SET OBJ ,WINNER>
		)
	>
	<COND
		(<AND <EQUAL? .OBJ ,CH-PLAYER>
				<NOT <SET OBJ <FIND-FLAG ,HERE ,FL-PERSON ,CH-PLAYER>>>
			>
			<TELL ,K-TALK-TO-SELF-MSG CR>
		)
		(<FSET? .OBJ ,FL-ASLEEP>
			<TELL The+verb .OBJ "are" " in no condition to respond." CR>
		)
		(T
			<TELL The+verb .OBJ "do" "n't respond." CR>
		)
	>
>
 
<ROUTINE RT-FOOLISH-TO-TALK? ()
	<COND
		(<MC-PRSO? <> ,ROOMS>
			<RFALSE>
		)
		(<NOT <FSET? ,PRSO ,FL-ALIVE>>
			<RT-NO-RESPONSE-MSG>
		)
		(<MC-PRSO? ,CH-PLAYER ,PRSI ,WINNER>
			<RT-WASTE-OF-TIME-MSG>
		)
		(T
			<THIS-IS-IT ,PRSO>
			<RFALSE>
		)
	>
>
 
<ROUTINE RT-WASTE-OF-TIME-MSG ()
	<TELL "[That would be a waste of time.]" CR>
>
 
<CONSTANT K-HOW-INTEND-MSG "[How do you intend to do that?]">
 
%<DEBUG-CODE <SYNTAX $P OBJECT = V-$P>>
%<DEBUG-CODE
	<ROUTINE V-$P ()
		<COND
			(<PICINF ,P-NUMBER ,K-WIN-TBL>
				<COND
					(<ZERO? ,P-NUMBER>
						<TELL "Last picture number is " N <ZGET ,K-WIN-TBL 0> "." CR>
					)
					(T
						<TELL N <ZGET ,K-WIN-TBL 0> "x" N <ZGET ,K-WIN-TBL 1> CR>
					)
				>
			)
			(T
				<TELL "No such picture." CR>
			)
		>
	>
>
 
<ROUTINE RT-CENTER-PIC (N "AUX" X Y)
	<PICINF .N ,K-WIN-TBL>
	<SET Y <+ </ <- <WINGET -3 ,K-W-YSIZE> <ZGET ,K-WIN-TBL 0>> 2> 1>>
	<SET X <+ </ <- <WINGET -3 ,K-W-XSIZE> <ZGET ,K-WIN-TBL 1>> 2> 1>>
	<DISPLAY .N .Y .X>
	<RTRUE>
>
 
%<DEBUG-CODE <SYNTAX $D OBJECT = V-$D>>
%<DEBUG-CODE
	<ROUTINE V-$D ()
		<COND
			(<AND <G? ,P-NUMBER 0>
					<PICINF ,P-NUMBER ,K-WIN-TBL>
				>
				<SCREEN 7>
				<CLEAR 7>
				<RT-CENTER-PIC ,P-NUMBER>
				<INPUT 1>
				<SCREEN 0>
				<V-$REFRESH <>>
			)
			(T
				<TELL "No such picture." CR>
			)
		>
	>
>
 
%<DEBUG-CODE <SYNTAX $SHOW = V-$SHOW>>
%<DEBUG-CODE
	<ROUTINE V-$SHOW ("AUX" P N C)
		<PICINF 0 ,K-WIN-TBL>
		<SET N <ZGET ,K-WIN-TBL 0>>
		<SET P 0>
		<REPEAT ()
			<COND
				(<PICINF .P ,K-WIN-TBL>
					<SCREEN 7>
					<CLEAR 7>
					<CURSET 1 1>
					<TELL
"Picture #" N .P ".  [Q]uit, [+F] to advance, [-B] to back up.|"
					>
					<RT-CENTER-PIC .P>
					<SET C <INPUT 1>>
					<COND
						(<EQUAL? .C !\q !\Q>
							<SCREEN 0>
							<V-$REFRESH <>>
							<RTRUE>
						)
						(<EQUAL? .C !\- !\b !\B>
							<COND
								(<DLESS? P 1>
									<SET P .N>
								)
							>
						)
						(T
							<COND
								(<IGRTR? P .N>
									<SET P 1>
								)
							>
						)
					>
				)
			>
		>
	>
>
 
%<DEBUG-CODE <SYNTAX $W OBJECT = V-$W>>
%<DEBUG-CODE
	<ROUTINE V-$W ("AUX" WIN A TMP)
		<SET WIN ,P-NUMBER>
		<COND
			(<OR	<L? .WIN 0>
					<G? .WIN 7>
				>
				<TELL "No such window." CR>
				<RTRUE>
			)
		>
		<TELL
"#" N .WIN " at " N <WINGET .WIN ,K-W-YPOS> "," N <WINGET .WIN ,K-W-XPOS>
"; size " N <WINGET .WIN ,K-W-YSIZE> "x" N <WINGET .WIN ,K-W-XSIZE>
		>
		<COND
			(<OR	<WINGET .WIN ,K-W-LMARG>
					<WINGET .WIN ,K-W-RMARG>
				>
				<TELL
" ( ->" N <WINGET .WIN ,K-W-LMARG> "," N <WINGET .WIN ,K-W-RMARG> "<- )"
				>
			)
		>
		<COND
			(<SET TMP <WINGET .WIN ,K-W-HLIGHT>>
				<TELL "; HL=" N .TMP>
			)
		>
		<COND
			(<NOT <EQUAL? <SET TMP <WINGET .WIN ,K-W-COLOR>> 257>>
				<TELL "; C=" N <SHIFT .TMP -8> "," N <BAND .TMP 255>>
			)
		>
		<COND
			(<NOT <EQUAL? <SET TMP <WINGET .WIN ,K-W-FONT>> 0>>
				<TELL "; F=" N .TMP>
			)
		>
		<SET TMP <WINGET .WIN ,K-W-FONTSIZE>>
		<TELL "; ">
		<COND
			(<OR	<NOT <EQUAL? <SHIFT .TMP -8> ,GL-FONT-Y>>
					<NOT <EQUAL? <BAND .TMP 255> ,GL-FONT-X>>
				>
				<TELL "*">
			)
		>
		<TELL "FS=" N <SHIFT .TMP -8> "x" N <BAND .TMP 255>>
		<TELL
"; cursor " N <WINGET .WIN ,K-W-YCURPOS> "," N <WINGET .WIN ,K-W-XCURPOS>
"; line " N <WINGET .WIN ,K-W-MORE>
		>
		<COND
			(<AND <SET TMP <WINGET .WIN ,K-W-CRCNT>>
					<WINGET .WIN ,K-W-CRFCN>
				>
				<TELL "; CR=" N .TMP>
			)
		>
		<TELL "; ">
		<SET A <WINGET .WIN ,K-W-ATTR>>
		<COND
			(<ZERO? <BAND .A ,A-WRAP>>
				<TELL "-">
			)
			(T
				<TELL "+">
			)
		>
		<TELL "W,">
		<COND
			(<ZERO? <BAND .A ,A-SCROLL>>
				<TELL "-">
			)
			(T
				<TELL "+">
			)
		>
		<TELL "S,">
		<COND
			(<ZERO? <BAND .A ,A-SCRIPT>>
				<TELL "-">
			)
			(ELSE
				<TELL "+">
			)
		>
		<TELL "P,">
		<COND
			(<ZERO? <BAND .A ,A-BUFFER>>
				<TELL "-">
			)
			(ELSE
				<TELL "+">
			)
		>
		<TELL "B" CR>
	>
>
 
;"***************************************************************************"
; "end of file"
;"***************************************************************************"
 
