;"***************************************************************************"
; "game : Abyss"
; "file : MACROS.ZIL"
; "auth :   $Author:   DEB  $"
; "date :     $Date:   07 Mar 1989  2:29:28  $"
; "rev  : $Revision:   1.3  $"
; "vers : 1.0"
;"---------------------------------------------------------------------------"
; "Macro definition file"
; "Copyright (C) 1988 Infocom, Inc.  All rights reserved."
;"***************************************************************************"
 
<CONSTANT M-ENTERED 42>
<CONSTANT M-F-LOOK 43>
<CONSTANT M-V-LOOK 44>
<CONSTANT M-B-LOOK 45>
<CONSTANT M-END-LOOK 46>
 
<CONSTANT K-W-YPOS		0>
<CONSTANT K-W-XPOS		1>
<CONSTANT K-W-YSIZE		2>
<CONSTANT K-W-XSIZE		3>
<CONSTANT K-W-YCURPOS	4>
<CONSTANT K-W-XCURPOS	5>
<CONSTANT K-W-LMARG		6>
<CONSTANT K-W-RMARG		7>
<CONSTANT K-W-CRFCN		8>
<CONSTANT K-W-CRCNT		9>
<CONSTANT K-W-HLIGHT		10>
<CONSTANT K-W-COLOR		11>
<CONSTANT K-W-FONT		12>
<CONSTANT K-W-FONTSIZE	13>
<CONSTANT K-W-ATTR		14>
<CONSTANT K-W-MORE		15>
 
<CONSTANT TAB 9>
<CONSTANT LF 10>
<CONSTANT CR 13>
<CONSTANT ESC 27>
<CONSTANT ESCAPE 27>
 
<CONSTANT M-EXIT ,M-LEAVE>
 
<CONSTANT K-S-NOR ,S-TEXT>
<CONSTANT K-S-WIN ,S-WINDOW>
 
<CONSTANT K-H-NRM ,H-NORMAL>
<CONSTANT K-H-INV ,H-INVERSE>
<CONSTANT K-H-BLD ,H-BOLD>
<CONSTANT K-H-ITL ,H-ITALIC>
 
<CONSTANT K-D-SCR-ON  ,D-SCREEN-ON>
<CONSTANT K-D-SCR-OFF ,D-SCREEN-OFF>
<CONSTANT K-D-PRT-ON  ,D-PRINTER-ON>
<CONSTANT K-D-PRT-OFF ,D-PRINTER-OFF>
<CONSTANT K-D-TBL-ON  ,D-TABLE-ON>
<CONSTANT K-D-TBL-OFF ,D-TABLE-OFF>
<CONSTANT K-D-REC-ON  ,D-RECORD-ON>
<CONSTANT K-D-REC-OFF ,D-RECORD-OFF>
 
<DEFMAC ONE? ('TERM)
	<FORM EQUAL? .TERM 1 T>
>
 
<DEFMAC MC-IS? ('OBJ 'FLAG)
	<FORM FSET? .OBJ .FLAG>
>
 
<DEFMAC MC-ISNOT? ('OBJ 'FLAG)
	<FORM NOT <FORM FSET? .OBJ .FLAG>>
>
 
<DEFMAC MC-MAKE ('OBJ 'FLAG)
	<FORM FSET .OBJ .FLAG>
>
 
<DEFMAC MC-UNMAKE ('OBJ 'FLAG)
	<FORM FCLEAR .OBJ .FLAG>
>
 
<DEFMAC MC-T? ('TERM)
	<FORM .TERM>
>
 
<DEFMAC MC-F? ('TERM)
	<FORM NOT .TERM>
>
 
<DEFMAC MC-THIS-WINNER? ()
	<FORM EQUAL? '.CONTEXT ',M-WINNER>
>
 
<DEFMAC MC-CONTEXT? ("ARGS" L)
	<FORM EQUAL? '.CONTEXT !.L>
>
 
<DEFMAC MC-WINNER? ("ARGS" L)
	<FORM EQUAL? ',WINNER !.L>
>
 
<DEFMAC PROB ('BASE)
	<FORM NOT <FORM L? .BASE '<RANDOM 100>>>
>
 
<DEFMAC MC-PROB? ('BASE)
	<FORM PROB .BASE>
>
 
<DEFMAC MC-ABS ('NUM)
	<FORM ABS .NUM>
>
 
<DEFMAC RT-PERFORM ("ARGS" L)
	<FORM PERFORM !.L>
>
 
<DEFMAC RT-ACCESSIBLE? ("ARGS" L)
	<FORM ACCESSIBLE? !.L>
>
 
<DEFMAC RT-VISIBLE? ("ARGS" L)
	<FORM VISIBLE? !.L>
>
 
<DEFMAC MC-VERB? ("ARGS" L)
	<FORM VERB? !.L>
>
 
<DEFMAC MC-VERB-WORD? ("ARGS" L)
	<FORM EQUAL? ',P-PRSA-WORD !.L>
>
 
<DEFMAC VERB-WORD? ("ARGS" L)
	<FORM EQUAL? ',P-PRSA-WORD !.L>
>
 
<DEFMAC MC-PRSO? ("ARGS" L)
	<FORM EQUAL? ',PRSO !.L>
>
 
<DEFMAC MC-PRSI? ("ARGS" L)
	<FORM EQUAL? ',PRSI !.L>
>
 
<DEFMAC MC-HERE? ("ARGS" L)
	<FORM EQUAL? ',HERE !.L>
>
 
<DEFMAC RT-GLOBAL-IN? ("ARGS" L)
	<FORM GLOBAL-IN? !.L>
>
 
<DEFMAC RT-PICK-ONE ("ARGS" L)
	<FORM PICK-ONE !.L>
>
 
<VERSION?
	(ZIP
		<DEFMAC GET/B ('TBL 'PTR)
			<FORM GETB .TBL .PTR>
		>
		<DEFMAC PUT/B ('TBL 'PTR 'OBJ)
			<FORM PUTB .TBL .PTR .OBJ>
		>
		<DEFMAC RMGL-SIZE ('TBL)
			<FORM - <FORM PTSIZE .TBL> 1>
		>
	)
	(T
		<DEFMAC GET/B ('TBL 'PTR)
			<FORM GET .TBL .PTR>
		>
		<DEFMAC PUT/B ('TBL 'PTR 'OBJ)
			<FORM PUT .TBL .PTR .OBJ>
		>
		<DEFMAC RMGL-SIZE ('TBL)
			<FORM - <FORM / <FORM PTSIZE .TBL> 2> 1>
		>
	)
>
 
;<DEFMAC BIT-FLAGS ("TUPLE" FLAGS "AUX" FLAG VAL (I 0) (L ()) (N 0) (B 0))
	<REPEAT ()
		<COND
			(<EMPTY? .FLAGS>
				<COND
					(<G? .N 0>
						<SET L (!.L .B)>
					)
				>
				<RETURN!->
			)
			(T
				<SET FLAG <NTH .FLAGS 1>>
				<COND
					(<TYPE? .FLAG ATOM>
						<SET VAL <>>
					)
					(<AND <TYPE? .FLAG LIST>
							<==? <LENGTH .FLAG> 2>
						>
						<SET VAL <NTH .FLAG 2>>
						<SET FLAG <NTH .FLAG 1>>
					)
					(T
						;"Warning message"
						<WARN!-ZILCH!-PACKAGE!- "Unknown bit flag: " .FLAG>
					)
				>
				<EVAL <FORM CONSTANT .FLAG .I>>
				<COND
					(.VAL
						<SET B <ORB .B <LSH 1 .N>>>
					)
				>
				<SET I <+ .I 1>>
				<COND
					(<G? <SET N <+ .N 1>> 7>
						<SET L (!.L .B)>
						<SET N 0>
						<SET B 0>
					)
				>
				<SET FLAGS <REST .FLAGS>>
			)
		>
	>
 
	<COND
		(<G? <LENGTH .L> 0>
			<EVAL <FORM CONSTANT BIT-FLAG-TBL <FORM TABLE (BYTE) !.L>>>
			<EVAL
				<FORM ROUTINE BIT-FLAG? (FLAG "AUX" N B)
					<FORM SET N <FORM / '.FLAG 8>>
					<FORM SET B <FORM LSH 1 <FORM MOD '.FLAG 8>>>
					<FORM COND
						(<FORM ANDB <FORM GETB ',BIT-FLAG-TBL '.N> '.B>
							<FORM RTRUE>
						)
					>
				>
			>
			<EVAL
				<FORM ROUTINE BIT-FLAG-SET (FLAG "AUX" N B)
					<FORM SET N <FORM / '.FLAG 8>>
					<FORM SET B <FORM LSH 1 <FORM MOD '.FLAG 8>>>
					<FORM PUTB ',BIT-FLAG-TBL '.N
						<FORM ORB <FORM GETB ',BIT-FLAG-TBL '.N> '.B>
					>
				>
			>
			<EVAL
				<FORM ROUTINE BIT-FLAG-CLEAR (FLAG "AUX" N B)
					<FORM SET N <FORM / '.FLAG 8>>
					<FORM SET B <FORM LSH 1 <FORM MOD '.FLAG 8>>>
					<FORM PUTB ',BIT-FLAG-TBL '.N
						<FORM ANDB <FORM GETB ',BIT-FLAG-TBL '.N> <FORM BCOM '.B>>
					>
				>
			>
		)
	>
>
 
;<BIT-FLAGS
	F-SCRUBBERS
	F-HEATERS
>
 
;"***************************************************************************"
; "end of file"
;"***************************************************************************"
 
