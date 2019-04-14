;"***************************************************************************"
; "game : Abyss"
; "file : VERBS.ZIL"
; "auth :   $Author:   DEB  $"
; "date :     $Date:   20 Mar 1989  8:46:08  $"
; "rev  : $Revision:   1.16  $"
; "vers : 1.0"
;"---------------------------------------------------------------------------"
; "Verbs"
; "Copyright (C) 1988 Infocom, Inc.  All rights reserved."
;"***************************************************************************"
 
<INCLUDE "BASEDEFS">
 
<GLOBAL VERBOSITY 1>
 
;<ROUTINE V-FOO ()
	<TELL "You can't do that." CR>
>
 
<ROUTINE V-DESC-LEVEL ()
	<TELL "[">
	<COND
		(<EQUAL? ,P-PRSA-WORD ,W?SUPER ,W?SUPERBRIEF>
		;	<SETG VERBOSITY 0>
			<TELL "Super brief is not supported">
		)
		(T
			<COND
				(<EQUAL? ,P-PRSA-WORD ,W?BRIEF>
					<SETG VERBOSITY 1>
					<TELL "Brief">
				)
				(T
					<SETG VERBOSITY 2>
					<TELL "Verbose">
				)
			>
			<TELL " descriptions">
		)
	>
	<TELL ".]" CR>
>
 
<ROUTINE V-SCRIPT ()
	<COND
		(<EQUAL? ,P-PRSA-WORD ,W?SCRIPT>
			<DIROUT ,K-D-PRT-ON>
			<TELL "Transcript: Begin" CR>
		)
		(T
			<TELL "Transcript: End" CR>
			<DIROUT ,K-D-PRT-OFF>
		)
	>
	<RTRUE>
>
 
<ROUTINE V-VERIFY ()
	<COND
		(,PRSO
			<COND
				(<AND <EQUAL? ,PRSO ,INTNUM>
						<EQUAL? ,P-NUMBER 105>
					>
					<TELL N ,SERIAL CR>
				)
				(T
					<DONT-UNDERSTAND>
				)
			>
		)
		(T
			<TELL "[Verifying... ">
			<COND
				(<VERIFY>
					<TELL "Correct">
				)
				(T
					<TELL "Error">
				)
			>
			<TELL ".]" CR>
			<RFATAL>
		)
	>
>
 
%<DEBUG-CODE <ROUTINE V-COMMAND () <DIRIN 1> <RTRUE>>>
%<DEBUG-CODE <ROUTINE V-RECORD () <DIROUT ,D-RECORD-ON> <RTRUE>>>
%<DEBUG-CODE <ROUTINE V-UNRECORD () <DIROUT ,D-RECORD-OFF> <RTRUE>>>
 
<ROUTINE V-INVENTORY ()
	<RT-MOVE-ALL-WORN ,WINNER ,PSEUDO-OBJECT>
	<TELL The+verb ,WINNER "are" " holding">
	<COND
		(<NOT <RT-PRINT-CONTENTS ,WINNER T>>
			<TELL " nothing">
		)
	>
	<COND
		(<RT-SEE-ANYTHING-IN? ,PSEUDO-OBJECT>
			<TELL ". " He+verb ,WINNER "are" " wearing">
			<RT-PRINT-CONTENTS ,PSEUDO-OBJECT>
			<RT-MOVE-ALL-WORN ,PSEUDO-OBJECT ,WINNER>
		)
	>
	<TELL "." CR>
>
 
<ROUTINE V-QUIT ("OPT" (ASK? T))
	<COND
		(.ASK?
			<TELL "Are you sure you want to quit?|">
			<COND
				(<Y?>
					<QUIT>
				)
				(T
					<TELL "Continuing..." CR>
				)
			>
		)
		(T
			<QUIT>
		)
	>
>
 
<ROUTINE RT-FAILED-MSG (STR)
	<TELL "[" .STR " failed.]" CR>
>
 
<ROUTINE V-RESTART ()
	<RESTART>
	<RT-FAILED-MSG "Restart">
>
 
<ROUTINE V-SAVE ("AUX" X)
	<PUTB ,G-INBUF 1 0>
	<SETG P-CONT <>> ; "flush anything on input line after SAVE"
	<SET X <SAVE>>
	<COND
		(<OR	<EQUAL? .X 2>
				<FLAG-ON? ,F-REFRESH>
			>
			<COLOR ,GL-F-COLOR ,GL-B-COLOR>
			<V-$REFRESH <EQUAL? .X 2>>
		)
	>
	<COND
		(<ZERO? .X>
			<RT-FAILED-MSG "Save">
		)
		(T
			<TELL "[Okay.]" CR>
		)
	>
	<RFATAL>
>
 
<ROUTINE V-RESTORE ()
	<COND
		(<NOT <RESTORE>>
			<RT-FAILED-MSG "Restore">
			<RFALSE>
		)
	>
>
 
"SUBTITLE - GENERALLY USEFUL ROUTINES & CONSTANTS"
 
<ROUTINE RT-PRINT-CONTENTS (CONT "OPT" (RECUR? <>) (CNT 0) "AUX" OBJ (1ST? T))
	<SET OBJ <FIRST? .CONT>>
	<COND
		(.OBJ
			<REPEAT ()
				<COND
					(<NOT .OBJ>
						<RETURN>
					)
					(<OR	<FSET? .OBJ ,FL-INVISIBLE>
							<FSET? .OBJ ,FL-NO-DESC>
							<EQUAL? .OBJ ,WINNER>
						>
					)
					(T
						<COND
							(.1ST?
								<INC CNT>
								<SET 1ST? <>>
							)
							(T
								<TELL comma <NEXT? .OBJ>>
							)
						>
						<TELL a .OBJ>
						<THIS-IS-IT .OBJ>
						<FSET .OBJ ,FL-SEEN>
					)
				>
				<SET OBJ <NEXT? .OBJ>>
			>
			<COND
				(.RECUR?
					<SET OBJ <FIRST? .CONT>>
					<REPEAT ()
						<COND
							(<NOT .OBJ>
								<RETURN>
							)
							(<OR	<FSET? .OBJ ,FL-INVISIBLE>
									<FSET? .OBJ ,FL-NO-DESC>
									<EQUAL? .OBJ ,WINNER>
								>
							)
							(<OR	<FSET? .OBJ ,FL-SURFACE>
									<AND
										<FSET? .OBJ ,FL-CONTAINER>
										<OR
											<FSET? .OBJ ,FL-OPEN>
											<FSET? .OBJ ,FL-TRANSPARENT>
										>
									>
								>
								<COND
									(<RT-SEE-ANYTHING-IN? .OBJ>
										<TELL ". " In .OBJ the .OBJ the+verb ,WINNER "see">
										<SET CNT <RT-PRINT-CONTENTS .OBJ T .CNT>>
									)
								>
							)
						>
						<SET OBJ <NEXT? .OBJ>>
					>
				)
			>
		)
	>
	.CNT
>
 
<ROUTINE RT-DESCRIBE-OBJECTS ("OPT" (CONT ,HERE) (CNT 0) (LVL 0) "AUX" OBJ NXT (1ST? T) (P-CNT 0) (P-PL? <>))
	<SET OBJ <FIRST? .CONT>>
	<REPEAT ()
		<COND
			(<NOT .OBJ>
				<RETURN>
			)
			(<OR	<FSET? .OBJ ,FL-NO-DESC>
					<FSET? .OBJ ,FL-INVISIBLE>
				>
				<SET OBJ <NEXT? .OBJ>>
				<AGAIN>
			)
			(<FSET? .OBJ ,FL-PERSON>
				<INC P-CNT>
				<SET OBJ <NEXT? .OBJ>>
				<AGAIN>
			)
			(.1ST?
				<COND
					(<G? .CNT 0>
						<TELL " ">
					)
					(T
					;	<CRLF>
						<TELL TAB>
					)
				>
				<SET 1ST? <>>
				<COND
					(<IN? .CONT ,ROOMS>
						<TELL "Y">
					)
					(T
						<TELL In .CONT the .CONT " y">
					)
				>
				<TELL "ou see">
			)
		>
		<TELL a .OBJ>
		<THIS-IS-IT .OBJ>
		<FSET .OBJ ,FL-SEEN>
		<INC CNT>
		<SET OBJ <NEXT? .OBJ>>
		<REPEAT ()
			<COND
				(<NOT .OBJ>
					<RETURN>
				)
				(<FSET? .OBJ ,FL-NO-DESC>)
				(<FSET? .OBJ ,FL-INVISIBLE>)
				(<FSET? .OBJ ,FL-PERSON>
					<INC P-CNT>
				)
				(T
					<RETURN>
				)
			>
			<SET OBJ <NEXT? .OBJ>>
		>
		<COND
			(.OBJ
				<SET NXT <NEXT? .OBJ>>
				<REPEAT ()
					<COND
						(<NOT .NXT>
							<RETURN>
						)
						(<AND <NOT <FSET? .NXT ,FL-NO-DESC>>
								<NOT <FSET? .NXT ,FL-INVISIBLE>>
								<NOT <FSET? .NXT ,FL-PERSON>>
							>
							<RETURN>
						)
					>
					<SET NXT <NEXT? .NXT>>
				>
				<COND
					(<NOT .NXT>
						<TELL " and">
					)
					(T
						<TELL ",">
					)
				>
			)
			(T
				<COND
					(<IN? .CONT ,ROOMS>
						<TELL " here">
					)
				>
				<TELL ".">
			)
		>
	>
	<COND
		(<G? .P-CNT 0>
			<COND
				(<G? .CNT 0>
					<TELL " ">
				)
				(T
				;	<CRLF>
					<TELL TAB>
				)
			>
			<SET CNT <+ .CNT .P-CNT>>
			<COND
				(<G? .P-CNT 1>
					<SET P-PL? T>
				)
			>
			<SET OBJ <FIRST? .CONT>>
			<SET 1ST? T>
			<REPEAT ()
				<COND
					(<OR	<FSET? .OBJ ,FL-NO-DESC>
							<FSET? .OBJ ,FL-INVISIBLE>
						>
					)
					(<FSET? .OBJ ,FL-PERSON>
						<COND
							(.1ST?
								<TELL A .OBJ>
							)
							(T
								<TELL a .OBJ>
							)
						>
						<SET 1ST? <>>
						<COND
							(<FSET? .OBJ ,FL-PLURAL>
								<SET P-PL? T>
							)
						>
						<COND
							(<DLESS? P-CNT 1>
								<COND
									(.P-PL?
										<TELL " are">
									)
									(T
										<TELL " is">
									)
								>
								<TELL " here.">
								<RETURN>
							)
							(<EQUAL? .P-CNT 1>
								<TELL " and">
							)
							(T
								<TELL ",">
							)
						>
					)
				>
				<SET OBJ <NEXT? .OBJ>>
			>
		)
	>
	<SET OBJ <FIRST? .CONT>>
	<REPEAT ()
		<COND
			(<NOT .OBJ>
				<RETURN>
			)
			(<FSET? .OBJ ,FL-INVISIBLE>)
			(<OR	<FSET? .OBJ ,FL-SURFACE>
					<AND
						<FSET? .OBJ ,FL-CONTAINER>
						<FSET? .OBJ ,FL-TRANSPARENT>
					>
				>
				<SET CNT <RT-DESCRIBE-OBJECTS .OBJ .CNT <+ .LVL 1>>>
			)
		>
		<SET OBJ <NEXT? .OBJ>>
	>
	<COND
		(<ZERO? .LVL>
			<COND
				(<G? .CNT 0>
					<CRLF>
				)
			>
		)
	>
	<RETURN .CNT>
>
 
<ROUTINE RT-DESCRIBE-ROOM ("OPT" (LOOK? <>) "AUX" VAL P)
	<COND
		(<ZERO? ,LIT>
			<TELL ,K-TOO-DARK-MSG CR>
			<FSET ,HERE ,FL-TOUCHED>
			<RFALSE>
		)
		(<NOT <EQUAL? ,LIT ,HERE ,CH-PLAYER>>
			<TELL TAB "Light comes from" the ,LIT ".|">
		)
	>
	<COND
		(<SET P <GETP ,HERE ,P?ACTION>>
			<COND
				(.LOOK?
					<SET VAL <APPLY .P ,M-LOOK>>
				)
				(<NOT <FSET? ,HERE ,FL-TOUCHED>>
					<SET VAL <APPLY .P ,M-F-LOOK>>
				)
				(<EQUAL? ,VERBOSITY 2>
					<SET VAL <APPLY .P ,M-V-LOOK>>
				)
				(T
					<SET VAL <APPLY .P ,M-B-LOOK>>
				)
			>
		)
	>
	<FSET ,HERE ,FL-TOUCHED>
	<FSET ,HERE ,FL-SEEN>
	<RETURN <NOT .VAL>>
>
 
"Lengths:"
<CONSTANT REXIT 0>
<CONSTANT UEXIT <VERSION? (ZIP 1) (T 2)>>
	"Uncondl EXIT:	(dir TO rm)		 = rm"
<CONSTANT NEXIT <VERSION? (ZIP 2) (T 3)>>
	"Non EXIT:	(dir ;SORRY string)	 = str-ing"
<CONSTANT FEXIT <VERSION? (ZIP 3) (T 4)>>
	"Fcnl EXIT:	(dir PER rtn)		 = rou-tine, 0"
<CONSTANT CEXIT <VERSION? (ZIP 4) (T 5)>>
	"Condl EXIT:	(dir TO rm IF f)	 = rm, f, str-ing"
<CONSTANT DEXIT <VERSION? (ZIP 5) (T 6)>>
	"Door EXIT:	(dir TO rm IF dr IS OPEN)= rm, dr, str-ing, 0"
 
<CONSTANT NEXITSTR 0>
<CONSTANT FEXITFCN 0>
<CONSTANT CEXITFLAG <VERSION? (ZIP 1) (T 4)>>	"GET/B"
<CONSTANT CEXITSTR 1>		"GET"
<CONSTANT DEXITOBJ 1>		"GET/B"
<CONSTANT DEXITSTR <VERSION? (ZIP 1) (T 2)>>	"GET"
 
<ROUTINE NOT-HOLDING? (OBJ)
	<COND
		(<AND <NOT <IN? .OBJ ,WINNER>>
				<NOT <IN? <LOC .OBJ> ,WINNER>>
			>
			<SETG CLOCK-WAIT T>
			<TELL
"[" He+verb ,WINNER "are" "n't holding" him .OBJ ".]" CR
			>
		)
	>
>
 
<ROUTINE HELD? (OBJ "OPT" (CONT <>) "AUX" L)
	<COND
		(<ZERO? .CONT>
			<SET CONT ,PLAYER>
		)
	>
	<REPEAT ()
		<SET L <LOC .OBJ>>
		<COND
			(<NOT .L>
				<RFALSE>
			)
			(<EQUAL? .L .CONT>
				<RTRUE>
			)
			(<EQUAL? .CONT ,PLAYER ,WINNER>
				<COND
				;	(<EQUAL? .OBJ ,TH-HANDS ,TH-HEAD ,TH-EYES>
						<RTRUE>
					)
					(T
						<SET OBJ .L>
					)
				>
			)
			(<EQUAL? .L ,ROOMS ,GLOBAL-OBJECTS>
				<RFALSE>
			)
			(T
				<SET OBJ .L>
			)
		>
	>
>
 
;<ROUTINE ROOM-CHECK ("AUX" P PA)
	<SET P ,PRSO>
	<COND
		(<EQUAL? .P ,ROOMS>
			<RFALSE>
		)
		(<IN? .P ,ROOMS>
			<COND
				(<EQUAL? ,HERE .P>
					<RFALSE>
				)
				(<NOT <SEE-INTO? .P>>
					<RTRUE>
				)
				(T
					<RFALSE>
				)
			>
		)
		(<EQUAL? <META-LOC .P> ,HERE ,GLOBAL-OBJECTS ,LOCAL-GLOBALS>
			<RFALSE>
		)
		(<NOT <VISIBLE? .P>>
			<NOT-HERE .P>
		)
	>
>
 
<ROUTINE TOO-DARK ()
	<TELL "It's too dark to see." CR>
>
 
;"---------------------------------------------------------------------------"
; "A"
;"---------------------------------------------------------------------------"
 
<ROUTINE V-ASK-ABOUT ()
	<RT-NO-RESPONSE-MSG>
>
 
<ROUTINE V-ATTACH ()
	<TELL The ,WINNER " can't attach" the ,PRSO " to" the ,PRSI "." CR>
>
 
;"---------------------------------------------------------------------------"
; "C"
;"---------------------------------------------------------------------------"
 
<ROUTINE V-CLOSE ()
	<COND
		(<NOT <FSET? ,PRSO ,FL-OPENABLE>>
			<RT-YOU-CANT-MSG>
		)
		(T
			<COND
				(<FSET? ,PRSO ,FL-OPEN>
					<FCLEAR ,PRSO ,FL-OPEN>
					<COND
						(<FSET? ,PRSO ,FL-DOOR>
							<RT-CHECK-ADJ ,PRSO>
						)
					>
					<COND
						(<G? ,P-MULT 1>
							<TELL "Closed">
						)
						(T
							<TELL The+verb ,WINNER "close" the ,PRSO>
						)
					>
					<TELL "." CR>
				)
				(T
					<RT-ALREADY-MSG ,PRSO "closed">
				)
			>
		)
	>
>
 
<ROUTINE V-CUT ()
	<TELL TAB The ,WINNER " can't cut" the ,PRSO " with" the ,PRSI "." CR>
>
 
;"---------------------------------------------------------------------------"
; "D"
;"---------------------------------------------------------------------------"
 
<ROUTINE IDROP ()
	<COND
		(<NOT-HOLDING? ,PRSO>
			<RFALSE>
		)
		(<AND <NOT <IN? ,PRSO ,WINNER>>
				<NOT <FSET? <LOC ,PRSO> ,FL-OPEN>>
			>
			<TELL The+verb <LOC ,PRSO> "are" " closed." CR>
			<RFALSE>
		)
		(T
			<COND
				(<FSET? ,PRSO ,FL-WORN>
					<RT-FIRST-YOU-MSG "take off" ,PRSO>
				)
			>
			<MOVE ,PRSO ,HERE>
			<FCLEAR ,PRSO ,FL-WORN>
			<FCLEAR ,PRSO ,FL-NO-DESC>
			<FCLEAR ,PRSO ,FL-INVISIBLE>
			<RTRUE>
		)
	>
>
 
<ROUTINE V-DROP ("AUX" L)
	<COND
		(<IDROP>
			<COND
				(<G? ,P-MULT 1>
					<TELL "Dropped">
				)
				(T
					<TELL The+verb ,WINNER "drop" the ,PRSO>
					<COND
						(<SET L <FIND-FLAG ,HERE ,FL-VEHICLE ,PRSO>>
							<MOVE ,PRSO .L>
							<TELL in .L "to" the .L>
						)
					>
				)
			>
			<TELL "." CR>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "E"
;"---------------------------------------------------------------------------"
 
<ROUTINE PRE-EMPTY ("AUX" L)
	<COND
		(<AND <NOT <FSET? ,PRSO ,FL-SURFACE>>
				<NOT <FSET? ,PRSO ,FL-CONTAINER>>
			>
			<SET L <LOC ,PRSO>>
			<COND
				(<AND .L
						<OR
							<FSET? .L ,FL-SURFACE>
							<FSET? .L ,FL-CONTAINER>
						>
					>
					<PERFORM ,V?EMPTY .L ,PRSI>
					<RTRUE>
				)
				(T
					<RT-YOU-CANT-MSG>
				)
			>
		)
		(<AND <FSET? ,PRSO ,FL-CONTAINER>
				<NOT <FSET? ,PRSO ,FL-OPEN>>
				<FSET? ,PRSO ,FL-OPENABLE>
			>
			<TELL The+verb ,PRSO "are" "n't open." CR>
		)
		(<NOT <EQUAL? ,PRSI <> ,ROOMS ,TH-HANDS>>
			<COND
				(<AND <NOT <FSET? ,PRSI ,FL-SURFACE>>
						<NOT <FSET? ,PRSI ,FL-CONTAINER>>
					>
					<TELL The ,WINNER " can't empty" the ,PRSO " into" the ,PRSI "." CR>
				)
			>
		)
	>
>
 
<ROUTINE V-EMPTY ()
	<RT-EMPTY-MSG ,PRSO ,PRSI>
>
 
<ROUTINE RT-EMPTY-MSG (CONT "OPT" (DEST <>) "AUX" OBJ NXT X OM)
	<SET OM ,P-MULT>
	<SETG P-MULT 0>
	<SET OBJ <FIRST? .CONT>>
	<REPEAT ()
		<COND
			(<NOT .OBJ>
				<RETURN>
			)
			(<AND	<NOT <FSET? .OBJ ,FL-INVISIBLE>>
					<FSET? .OBJ ,FL-TAKEABLE>
				>
				<INC P-MULT>
			)
		>
		<SET OBJ <NEXT? .OBJ>>
	>
	<COND
		(<ZERO? ,P-MULT>
			<TELL "There is nothing" in ,PRSO the ,PRSO "." CR>
			<SETG P-MULT .OM>
			<RTRUE>
		)
	>
	<SET OBJ <FIRST? .CONT>>
	<COND
		(<EQUAL? .DEST <> ,ROOMS ,TH-GROUND ,GLOBAL-HERE>
			<SET DEST ,HERE>
		)
		(<EQUAL? .DEST ,TH-HANDS>
			<SET DEST ,CH-PLAYER>
		)
	>
	<REPEAT ()
		<COND
			(<MC-F? .OBJ>
				<RETURN>
			)
			(<AND	<NOT <FSET? .OBJ ,FL-INVISIBLE>>
					<FSET? .OBJ ,FL-TAKEABLE>
				>
				<TELL The .OBJ ": ">
				<SET NXT <NEXT? .OBJ>>
				<COND
					(<EQUAL? .DEST ,CH-PLAYER>
						<SET X <RT-PERFORM ,V?TAKE .OBJ ,PRSO>>
						<COND
							(<EQUAL? .X ,M-FATAL>
								<RETURN>
							)
						>
					)
					(<EQUAL? .DEST ,HERE>
						<MOVE .OBJ ,HERE>
						<TELL He+verb .OBJ "land" " on" the ,TH-GROUND " nearby." CR>
					)
					(<RT-ROOM-IN-MSG? .OBJ .DEST>
						T
					)
					(<RT-CHECK-MOVE-MSG? .OBJ .DEST>
						<RETURN>
					)
					(T
						<MOVE .OBJ .DEST>
						<TELL "Done." CR>
					)
				>
				<SET OBJ .NXT>
			)
		>
	>
	<SETG P-MULT .OM>
	<RTRUE>
>
 
<ROUTINE V-EMPTY-FROM ()
	<COND
		(<NOT <IN? ,PRSO ,PRSI>>
			<TELL The+verb ,PRSO "are" "n't" in ,PRSI the ,PRSI "." CR>
		)
		(T
			<PERFORM ,V?EMPTY ,PRSI>
			<RTRUE>
		)
	>
>
 
<ROUTINE V-ENTER ("AUX" VEH DIR RM)
	<COND
		(<MC-PRSO? ,ROOMS>
			<COND
				(<SET VEH <FIND-FLAG ,HERE ,FL-VEHICLE>>
					<COND
						(<IN? ,WINNER .VEH>
							<RT-ALREADY-MSG ,WINNER>
							<TELL in .VEH the .VEH ".]" CR>
						)
						(<OR	<FSET? .VEH ,FL-SURFACE>
								<FSET? .VEH ,FL-OPEN>
							>
							<MOVE ,WINNER .VEH>
							<TELL The+verb ,WINNER "get" in .VEH the .VEH "." CR>
						)
						(<FSET? .VEH ,FL-OPENABLE>
							<TELL The+verb .VEH "are" " closed." CR>
						)
						(T
							<TELL The ,WINNER " can't get" in .VEH the .VEH "." CR>
						)
					>
				)
				(<EQUAL? <RT-DO-WALK ,P?IN> <> ,M-FATAL>
					<SETG CLOCK-WAIT T>
				)
			>
		)
		(<MC-PRSO? ,HERE ,GLOBAL-HERE>
			; "Enter the room you're in"
			<RT-ALREADY-MSG ,WINNER>
			<TELL in ,HERE the ,HERE ".]" CR>
		)
		(<IN? ,PRSO ,ROOMS>
			<COND
				(<AND <SET DIR <RT-FIND-DIR ,PRSO>>
						<RT-DO-WALK .DIR>
					>
				)
				(<FSET? ,PRSO ,FL-AUTO-ENTER>
					<RT-GOTO ,PRSO>
				)
				(T
					<TELL The ,WINNER " can't get there from here." CR>
				)
			>
		)
		(<FSET? ,PRSO ,FL-DOOR>
			<COND
				(<RT-OTHER-SIDE ,PRSO>
					<RT-DO-WALK ,GL-DOOR-DIR>
				)
				(T
					<TELL The+verb ,PRSO "do" "n't seem to go anywhere." CR>
				)
			>
		)
		(<FSET? ,PRSO ,FL-VEHICLE>		; "If it's a vehicle, move winner there."
			<COND
				(<OR	<FSET? ,PRSO ,FL-SURFACE>
						<FSET? ,PRSO ,FL-OPEN>
					>
					<MOVE ,WINNER ,PRSO>
					<TELL The+verb ,WINNER "get" in ,PRSO the ,PRSO "." CR>
				)
				(<FSET? ,PRSO ,FL-OPENABLE>
					<TELL The+verb ,PRSO "are" " closed." CR>
				)
				(T
					<TELL The ,WINNER " can't get" in ,PRSO the ,PRSO "." CR>
				)
			>
		)
		(T
			<RT-IMPOSSIBLE-MSG>
		)
	>
	<RTRUE>
>
 
<ROUTINE V-EXIT ("AUX" VEH L DIR)
	<COND
		(<MC-PRSO? ,ROOMS>
			<SET L <LOC ,WINNER>>
			<COND
				(<IN? .L ,ROOMS>
					<RT-DO-WALK ,P?OUT>
				)
				(<OR	<FSET? .L ,FL-VEHICLE>
						<FSET? .L ,FL-SURFACE>
						<FSET? .L ,FL-CONTAINER>
					>
					<COND
						(<OR	<FSET? .L ,FL-SURFACE>
								<FSET? .L ,FL-OPEN>
							>
							<MOVE ,WINNER <LOC .L>>
							<TELL The+verb ,WINNER "get" out .L " of" the .L "." CR>
						)
						(<FSET? .L ,FL-OPENABLE>
							<TELL The+verb .L "are" " closed." CR>
						)
						(T
							<TELL The ,WINNER " can't get" out .L " of" the .L "." CR>
						)
					>
				)
				(<SET VEH <FIND-FLAG ,HERE ,FL-VEHICLE>>
					<TELL The+verb ,WINNER "are" "n't" in .VEH the .VEH "." CR>
				)
			>
		)
		(<MC-PRSO? ,HERE ,GLOBAL-HERE>
			<RT-DO-WALK ,P?OUT>
		)
		(<IN? ,PRSO ,ROOMS>
			<RT-NOT-IN-ROOM-MSG>
		)
		(<FSET? ,PRSO ,FL-DOOR>
			<COND
				(<RT-OTHER-SIDE ,PRSO>
					<RT-DO-WALK ,GL-DOOR-DIR>
				)
				(T
					<TELL The+verb ,PRSO "do" "n't seem to go anywhere." CR>
				)
			>
		)
		(<OR	<FSET? ,PRSO ,FL-VEHICLE>
				<FSET? ,PRSO ,FL-CONTAINER>
				<FSET? ,PRSO ,FL-SURFACE>
			>
			<COND
				(<IN? ,WINNER ,PRSO>
					<COND
						(<OR	<FSET? ,PRSO ,FL-SURFACE>
								<FSET? ,PRSO ,FL-OPEN>
							>
							<MOVE ,WINNER <LOC <LOC ,WINNER>>>
							<TELL The+verb ,WINNER "get" out ,PRSO " of" the ,PRSO "." CR>
						)
						(<FSET? ,PRSO ,FL-OPENABLE>
							<TELL The+verb ,PRSO "are" " closed." CR>
						)
						(T
							<TELL The ,WINNER " can't get" out ,PRSO " of" the ,PRSO "." CR>
						)
					>
				)
				(T
					<TELL The+verb ,WINNER "are" "n't" in ,PRSO the ,PRSO "." CR>
				)
			>
		)
		(<FSET? <SET L <LOC ,PRSO>> ,FL-CONTAINER>
			<TELL "[from" the .L "]" CR>
			<RT-PERFORM ,V?TAKE ,PRSO>
		)
		(T
			<RT-IMPOSSIBLE-MSG>
		)
	>
	<RTRUE>
>
 
<ROUTINE RT-NOT-IN-ROOM-MSG ()
	<TELL The+verb ,WINNER "are" "n't" in ,PRSO the ,PRSO "." CR>
>
 
<ROUTINE RT-DO-WALK (DIR1 "OPT" (DIR2 <>) (DIR3 <>) "AUX" X)
	<SETG P-WALK-DIR .DIR1>
	<SET X <PERFORM ,V?WALK .DIR1>>
	<COND
		(<AND .DIR2
				<NOT <EQUAL? .X <> ,M-FATAL>>
			>
			<SETG P-WALK-DIR .DIR2>
			<SET X <PERFORM ,V?WALK .DIR2>>
			<COND
				(<AND .DIR3
						<NOT <EQUAL? .X <> ,M-FATAL>>
					>
					<SETG P-WALK-DIR .DIR3>
					<SET X <PERFORM ,V?WALK .DIR3>>
				)
			>
		)
	>
	<RETURN .X>
>
 
;<ROUTINE PRE-EXAMINE ()
	<ROOM-CHECK>
>
 
<ROUTINE V-EXAMINE ()
	<COND
		(<MC-PRSO? ,HERE ,GLOBAL-HERE>
			<PERFORM ,V?LOOK>
		)
		(<MC-PRSO? ,INTDIR>
			<SETG CLOCK-WAIT T>
			<TELL "[If you want to see what's there, go there.]" CR>
		)
		(<FSET? ,PRSO ,FL-DOOR>
			<FSET ,PRSO ,FL-SEEN>
			<TELL The+verb ,PRSO "are" open ,PRSO "." CR>
		)
		(<OR	<FSET? ,PRSO ,FL-CONTAINER>
				<FSET? ,PRSO ,FL-SURFACE>
			>
			<FSET ,PRSO ,FL-SEEN>
			<V-LOOK-IN>
		)
		(T
			<FSET ,PRSO ,FL-SEEN>
			<RT-NOTHING-SPECIAL-MSG>
		)
	>
>
 
<ROUTINE RT-NOTHING-SPECIAL-MSG ()
	<TELL
"You see nothing " <RT-PICK-NEXT ,K-UNUSUAL-TBL> " about" the ,PRSO "." CR
	>
>
 
<CONSTANT YOU-DIDNT-SAY-W "[You didn't say w">
 
<ROUTINE V-EXTINGUISH ()
	<TELL "['Extinguish' currently has no default handling.]|">
	<RFATAL>
>
 
;"---------------------------------------------------------------------------"
; "F"
;"---------------------------------------------------------------------------"
 
<ROUTINE V-FOLLOW ()
	<TELL "['Follow' currently has no default handling.]|">
	<RFATAL>
>
 
;"---------------------------------------------------------------------------"
; "G"
;"---------------------------------------------------------------------------"
 
<ROUTINE V-GIVE ()
	<TELL TAB The+verb ,PRSI "do" "n't seem interested in" the ,PRSO "." CR>
>
 
<ROUTINE V-GIVE-SWP ()
	<PERFORM ,V?GIVE ,PRSI ,PRSO>
	<RTRUE>
>
 
;"---------------------------------------------------------------------------"
; "H"
;"---------------------------------------------------------------------------"
 
<ROUTINE V-HIT ()
	<TELL "['Hit' currently has no default handling.]|">
	<RFATAL>
>
 
;"---------------------------------------------------------------------------"
; "I"
;"---------------------------------------------------------------------------"
 
<ROUTINE V-INFLATE ()
	<TELL ,K-HOW-INTEND-MSG CR>
>
 
;"---------------------------------------------------------------------------"
; "L"
;"---------------------------------------------------------------------------"
 
<ROUTINE V-LIFT ()
	<TELL "['Lift' currently has no default handling.]|">
	<RFATAL>
>
 
<ROUTINE V-LISTEN ()
	<COND
		(<MC-PRSO? <> ,ROOMS>
			<TELL
The+verb ,WINNER "hear" "nothing " <RT-PICK-NEXT ,K-UNUSUAL-TBL> "." CR
			>
		)
		(T
			<TELL The+verb ,PRSO "are" " silent." CR>
		)
	>
>
 
<ROUTINE V-LOCK ()
	<COND
	;	(<EQUAL? ,P-PRSA-WORD ,W?BAR>
			<TELL The ,WINNER " can't bar" the ,PRSO !\. CR>
		)
		(<FSET? ,PRSO ,FL-LOCKED>
			<RT-ALREADY-MSG ,PRSO "locked">
		)
		(<NOT <RT-MATCH-KEY ,PRSO ,PRSI>>
			<TELL The ,WINNER " can't lock" the ,PRSO " with" the ,PRSI !\. CR>
		)
		(T
			<FSET ,PRSO ,FL-LOCKED>
			<COND
				(<FSET? ,PRSO ,FL-OPEN>
					<FCLEAR ,PRSO ,FL-OPEN>
					<COND
						(<FSET? ,PRSO ,FL-DOOR>
							<RT-CHECK-ADJ ,PRSO>
						)
					>
					<TELL
The+verb ,WINNER "close" the ,PRSO " and" verb ,WINNER "lock" him ,PRSO "." CR
					>
				)
				(T
					<RT-LOCK-MSG ,PRSO ,PRSI T>
					<TELL "." CR>
				)
			>
		)
	>
>
 
<ROUTINE V-LOOK ()
	<COND
		(<RT-DESCRIBE-ROOM T>
			<RT-DESCRIBE-OBJECTS>
		)
	>
	<RTRUE>
>
 
<ROUTINE V-LOOK-BEHIND ()
	; "Bob"
	<TELL TAB "You don't see anything " <RT-PICK-NEXT ,K-UNUSUAL-TBL> "." CR>
>
 
<ROUTINE V-LOOK-UNDER ()
	; "Bob"
	<TELL TAB "You don't see anything " <RT-PICK-NEXT ,K-UNUSUAL-TBL> "." CR>
>
 
;<ROUTINE PRE-LOOK-IN ()
	<ROOM-CHECK>
>
 
<ROUTINE V-LOOK-IN ("OPT" (DIR ,P?IN) "AUX" RM)
	<COND
		(<MC-PRSO? ,ROOMS>
			<COND
				(<OR	<FSET? <SET RM ,P-IT-OBJECT> ,FL-CONTAINER>
						<SET RM <FIND-FLAG-LG ,HERE ,FL-OPENABLE>>
					>
					<PERFORM ,PRSA .RM ,PRSI>
					<RTRUE>
				)
			>
		)
	>
	<COND
	;	(<AND <IN? ,PRSO ,ROOMS>
				<OR
					<GLOBAL-IN? ,PRSO ,HERE>
					<SEE-INTO? ,PRSO <>>
				>
			>
			<ROOM-PEEK ,PRSO>
		)
		(<AND <NOT <FSET? ,PRSO ,FL-OPEN>>
				<FSET? ,PRSO ,FL-OPENABLE>
			>
			<TELL The+verb ,PRSO "are" " closed." CR>
		)
		(<AND <OR
					<FSET? ,PRSO ,FL-CONTAINER>
					<FSET? ,PRSO ,FL-SURFACE>
				>
				<RT-SEE-INSIDE? ,PRSO>
			>
		;	<COND
				(<NOT <RT-SEE-INSIDE? ,PRSO>>
					<RT-FIRST-YOU-MSG "open" ,PRSO>
					<FSET ,PRSO ,FL-OPEN>
				)
			>
			<COND
				(<FIRST? ,PRSO>
					<TELL "You can see">
					<RT-PRINT-CONTENTS ,PRSO>
					<TELL in ,PRSO>
					<COND
						(<NOT <FSET? ,PRSO ,FL-SURFACE>>
							<TELL "side">
						)
					>
					<TELL the ,PRSO "." CR>
				)
				(T
					<TELL "There's nothing" in ,PRSO the ,PRSO "." CR>
				)
			>
		)
		(<==? .DIR ,P?IN>
			<RT-YOU-CANT-MSG "look inside">
		)
		(T
			<RT-YOU-CANT-MSG "look outside">
		)
	>
>
 
;<ROUTINE ROOM-PEEK (RM "OPT" (SAFE <>) "AUX" (X <>) OHERE OLIT TXT)
	<COND
		(<EQUAL? .RM ,HERE>
			<V-LOOK>
			<RTRUE>
		)
		(<OR	.SAFE
				<SEE-INTO? .RM>
			>
			<SET OHERE ,HERE>
			<SET OLIT ,LIT>
			<SETG HERE .RM>
			<SETG LIT <LIT?>>
			<TELL "You peer ">
			<COND
				(<FSET? .RM ,FL-SURFACE>
					<TELL "at">
				)
				(T
					<TELL "into">
				)
			>
			<TELL him .RM ":" CR>
			<COND
				(<RT-DESCRIBE-OBJECTS>
					<SET X T>
				)
			;	(<SET TXT <GETP .RM ,P?LDESC>>
					<SET X T>
					<TELL .TXT CR>
				)
			>
			<COND
				(<ZERO? .X>
					<TELL "You can't see anything suspicious." CR>
				)
			>
			<SETG HERE .OHERE>
			<SETG LIT .OLIT>
			<RTRUE>
		)
	>
>
 
;<ROUTINE SEE-INTO? (THERE "OPT" (TELL? T) (IGNORE-DOOR <>)"AUX" P L TBL O)
	<SET P 0>
	<REPEAT ()
		<COND
			(<OR	<0? <SET P <NEXTP ,HERE .P>>>
					<L? .P ,LOW-DIRECTION>
				>
				<COND
					(.TELL?
						<TELL-CANT-FIND>
					)
				>
				<RFALSE>
			)
		>
		<SET TBL <GETPT ,HERE .P>>
		<SET L <PTSIZE .TBL>>
		<COND
			(<==? .L ,UEXIT>
				<COND
					(<==? <GET/B .TBL ,REXIT> .THERE>
						<RTRUE>
					)
				>
			)
			(<==? .L ,DEXIT>
				<COND
					(<==? <GET/B .TBL ,REXIT> .THERE>
						<COND
							(<FSET? <GET/B .TBL ,DEXITOBJ> ,FL-OPEN>
								<RTRUE>
							)
							(<WALK-THRU-DOOR? .TBL <GET/B .TBL ,DEXITOBJ> <>>
								<RTRUE>
							)
							(.IGNORE-DOOR
								<RTRUE>
							)
							(T
								<COND
									(.TELL?
										<SETG CLOCK-WAIT T>
										<TELL "[The door to that room is closed.]" CR>
									)
								>
								<RFALSE>
							)
						>
					)
				>
			)
			(<==? .L ,CEXIT>
				<COND
					(<==? <GET/B .TBL ,REXIT> .THERE>
						<COND
							(<VALUE <GETB .TBL ,CEXITFLAG>>
								<RTRUE>
							)
							(T
								<COND
									(.TELL?
										<TELL-CANT-FIND>
									)
								>
								<RFALSE>
							)
						>
					)
				>
			)
		>
	>
>
 
<ROUTINE TELL-CANT-FIND ()
	<SETG CLOCK-WAIT T>
	<TELL "[That place isn't close enough.]" CR>
>
 
<ROUTINE V-LOOK-ON ()
	<COND
		(<FSET? ,PRSO ,FL-SURFACE>
			<V-LOOK-IN>
		)
		(T
			<TELL "There's no good surface on" the ,PRSO "." CR>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "M"
;"---------------------------------------------------------------------------"
 
<ROUTINE V-MOVE ()
	<TELL "['Move' currently has no default handling.]|">
	<RFATAL>
>
 
;"---------------------------------------------------------------------------"
; "N"
;"---------------------------------------------------------------------------"
 
<ROUTINE V-NO ()
	<TELL "[You seem sure of yourself.]" CR>
	<RFATAL>
>
 
;"---------------------------------------------------------------------------"
; "O"
;"---------------------------------------------------------------------------"
 
<ROUTINE RT-MATCH-KEY (DOOR "OPT" (KEY <>))
	<COND
		(<EQUAL? .DOOR ,TH-STEEL-BOX>
			<COND
				(<EQUAL? .KEY ,TH-STEEL-KEY>
					<RTRUE>
				)
			>
		)
		(<EQUAL? .DOOR ,TH-MISSILE-PANEL>
			<COND
				(<EQUAL? .KEY ,TH-MISSILE-ACCESS-KEY>
					<RTRUE>
				)
			>
		)
	>
>
 
<GLOBAL GL-DOOR-DIR <>>
 
<ROUTINE RT-OTHER-SIDE (DOOR "AUX" (RM <>) L)
	<SET L <LOC ,WINNER>>
	<REPEAT ((P 0) OBJ PT PTS)
		<COND
			(<OR	<ZERO? <SET P <NEXTP .L .P>>>
					<L? .P ,LOW-DIRECTION>
				>
				<RFALSE>
			)
			(<SET PT <GETPT .L .P>>
				<SET PTS <PTSIZE .PT>>
				<COND
					(<AND <==? .PTS ,DEXIT>
							<EQUAL? .DOOR <GET/B .PT ,DEXITOBJ>>
						>
						<SETG GL-DOOR-DIR .P>
						<SET RM <GET/B .PT ,REXIT>>
						<RETURN>
					)
				>
			)
		>
	>
	<RETURN .RM>
>
 
<ROUTINE RT-LOCK-MSG (DOOR KEY LOCK?)
	<TELL
The+verb ,WINNER "put" the .KEY " in the lock and" verb ,WINNER "give" " it a
turn"
	>
	<COND
		(.LOCK?
			<TELL ". " The .DOOR " locks with">
		)
		(T
			<TELL ", and" verb ,WINNER "hear">
		)
	>
	<TELL " a satisfying click">
>
 
<ROUTINE RT-OPEN-DOOR-MSG (DOOR "OPT" (KEY <>) "AUX" RM (LOCK? <>) TMP1 TMP2)
	<COND
		(<FSET? .DOOR ,FL-LOCKED>
			<SET LOCK? T>
			<FCLEAR .DOOR ,FL-LOCKED>
			<RT-LOCK-MSG .DOOR .KEY <>>
			<COND
				(<OR	<FSET? .DOOR ,FL-AUTO-OPEN>
						<VERB? OPEN>
					>
					<FSET .DOOR ,FL-OPEN>
					<COND
						(<FSET? .DOOR ,FL-DOOR>
							<RT-CHECK-ADJ .DOOR>
						)
					>
					<TELL ". " The+verb .DOOR "swing" " open">
				)
			>
		)
		(T
			<FSET .DOOR ,FL-OPEN>
			<COND
				(<FSET? .DOOR ,FL-DOOR>
					<RT-CHECK-ADJ .DOOR>
				)
			>
			<TELL The+verb ,WINNER "open" the .DOOR>
		)
	>
	<COND
		(<FSET? .DOOR ,FL-OPEN>
			<COND
				(<FSET? .DOOR ,FL-DOOR>
					<COND
						(<NOT <SET RM <RT-OTHER-SIDE .DOOR>>>)
						(<FSET? .DOOR ,FL-AUTO-ENTER>
							<TELL " and">
							<COND
								(.LOCK?
									<TELL the ,WINNER>
								)
							>
							<TELL verb ,WINNER "step" " through." CR CR>
							<RT-GOTO .RM>
							<RTRUE>
						)
						(<SET TMP2 <GETP ,HERE ,P?ADJACENT>>
							<COND
								(<SET TMP1 <INTBL? .RM <REST .TMP2 1> <GETB .TMP2 0> 1>>
									<COND
										(<GETB .TMP1 1>
											<COND
												(<RT-SEE-ANYTHING-IN? .RM>
													<TELL " and">
													<COND
														(.LOCK?
															<TELL the ,WINNER>
														)
													>
													<TELL verb ,WINNER "see">
													<RT-PRINT-CONTENTS .RM>
												)
											>
										)
									>
								)
							>
						)
					>
				)
				(<NOT <FSET? .DOOR ,FL-TRANSPARENT>>
					<COND
						(<RT-SEE-ANYTHING-IN? .DOOR>
							<TELL ". Inside you see">
							<RT-PRINT-CONTENTS .DOOR>
						)
					>
				)
			>
		)
	>
	<TELL "." CR>
	<COND
		(<NOT <FSET? .DOOR ,FL-TAKEABLE>>
			<COND
				(<FSET? .DOOR ,FL-OPEN>
					<RT-SCORE-OBJ .DOOR>
				)
			>
		)
	>
>
 
<ROUTINE V-OPEN ("AUX" F STR RM)
	<COND
		(<NOT <FSET? ,PRSO ,FL-OPENABLE>>
			<RT-YOU-CANT-MSG>
		)
		(<FSET? ,PRSO ,FL-OPEN>
			<RT-ALREADY-MSG ,PRSO "open">
		)
		(<AND <NOT ,PRSI>
				<FSET? ,PRSO ,FL-LOCKED>
			>
			<TELL The+verb ,PRSO "are" " locked." CR>
		)
		(<AND ,PRSI
				<NOT <RT-MATCH-KEY ,PRSO ,PRSI>>
			>
			<TELL The ,WINNER " can't open" the ,PRSO " with" the ,PRSI "." CR>
		)
		(T
			<RT-OPEN-DOOR-MSG ,PRSO ,PRSI>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "P"
;"---------------------------------------------------------------------------"
 
<ROUTINE V-PLUG-IN ()
	<TELL TAB The ,WINNER " can't plug in" the ,PRSO "." CR>
>
 
<ROUTINE V-PULL ()
	<TELL "	You pull" the ,PRSO ", but nothing happens." CR>
>
 
<ROUTINE V-PUSH ()
	<TELL "	You push" the ,PRSO ", but nothing happens." CR>
>
 
<ROUTINE PRE-PUT ()
	<COND
	;	(<MC-PRSO? ,HEAD ,HANDS>
			<WONT-HELP>
			<RTRUE>
		)
		(<IN? ,PRSO ,GLOBAL-OBJECTS>
			<NOT-HERE ,PRSO>
			<RTRUE>
		)
		(<MC-PRSI? ,TH-GROUND ,GLOBAL-HERE <>>
			<RFALSE>
		)
		(<IN? ,PRSI ,GLOBAL-OBJECTS>
			<NOT-HERE ,PRSI>
			<RTRUE>
		)
		(<HELD? ,PRSI ,PRSO>
			<RT-YOU-CANT-MSG "put" ,PRSI "in it">
		)
	>
>
 
<ROUTINE V-PUT ()
	<COND
	;	(<FSET? ,PRSI ,FL-PERSON>
			<SETG WINNER ,PRSI>
			<PERFORM ,V?WEAR ,PRSO>
			<RTRUE>
		)
		(<NOT <FSET? ,PRSI ,FL-SURFACE>>
			<TELL "There's no good surface on" the ,PRSI "." CR>
		)
		(T
			<RT-PUT-ON-OR-IN>
		)
	>
>
 
<ROUTINE TELL-FIND-NONE (STR "OPT" (OBJ <>))
	<TELL "You search for " .STR>
	<COND
		(.OBJ
			<TELL a .OBJ>
		)
	>
	<TELL " but find none." CR>
>
 
<ROUTINE PRE-PUT-IN ()
	<COND
		(<MC-PRSI? ,PSEUDO-OBJECT>
			<RETURN <PRE-PUT>>
		)
	;	(<MC-PRSI? ,TH-EYES ,TH-HANDS>
			<WONT-HELP>
			<RFATAL>
		)
		(<FSET? ,PRSI ,FL-READABLE>
			<WONT-HELP>
			<RFATAL>
		)
		(<NOT <FSET? ,PRSI ,FL-CONTAINER>>
			<TELL-FIND-NONE "an opening in" ,PRSI>
			<RFATAL>
		)
	>
	<COND
		(<NOT <FSET? ,PRSI ,FL-OPEN>>
			<COND
				(<FSET? ,PRSI ,FL-OPENABLE>
					<RT-FIRST-YOU-MSG "open" ,PRSI>
					<FSET ,PRSI ,FL-OPEN>
				)
			>
		)
	>
	<PRE-PUT>
>
 
<ROUTINE V-PUT-IN ()
	<COND
		(<NOT <FSET? ,PRSI ,FL-OPEN>>
			<COND
				(<FSET? ,PRSI ,FL-OPENABLE>
					<TELL The+verb ,PRSI "are" " closed">
				)
				(T
					<TELL The ,WINNER " can't open" the ,PRSI>
				)
			>
			<TELL "." CR>
		)
		(T
			<RT-PUT-ON-OR-IN>
		)
	>
>
 
<CONSTANT NOT-ENOUGH-ROOM "There's not enough room.|">
 
<ROUTINE RT-PUT-ON-OR-IN ()
	<COND
		(<ZERO? ,PRSI>
			<RT-YOU-CANT-MSG>
		)
		(<MC-PRSO? ,PRSI>
			<HAR-HAR>
		)
		(<IN? ,PRSO ,PRSI>
			<RT-ALREADY-MSG ,PRSO>
			<TELL in ,PRSI the ,PRSI ".]" CR>
		)
		(<RT-ROOM-IN-MSG? ,PRSO ,PRSI>
			<RTRUE>
		)
		(<AND <NOT <HELD? ,PRSO>>
				<NOT <ITAKE>>
			>
			<RTRUE>
		)
		(T
			<COND
				(<FSET? ,PRSO ,FL-WORN>
					<FCLEAR ,PRSO ,FL-WORN>
					<RT-FIRST-YOU-MSG "take off" ,PRSO>
				)
			>
			<MOVE ,PRSO ,PRSI>
			<FSET ,PRSO ,FL-TOUCHED>
		;	<COND
				(<VERB? PUT>
					<FSET ,PRSO ,FL-ON>
				)
				(T
					<FCLEAR ,PRSO ,FL-ON>
				)
			>
			<COND
				(<AND <FSET? ,PRSI ,FL-PERSON>
						<FSET? ,PRSO ,FL-CLOTHING>
					>
					<FSET ,PRSO ,FL-WORN>
					<TELL The+verb ,WINNER "put" " on" the ,PRSO>
				)
				(<G? ,P-MULT 1>
					<TELL "Done">
				)
				(T
					<TELL The+verb ,WINNER "put" the ,PRSO " ">
					<COND
						(<OR	<FSET? ,PRSI ,FL-SURFACE>
								<FSET? ,PRSI ,FL-PERSON>
							;	<FSET? ,PRSO ,FL-ON>
							>
							<TELL "o">
						)
						(T
							<TELL "i">
						)
					>
					<TELL "nto" the ,PRSI>
				)
			>
			<TELL "." CR>
		)
	>
>
 
<ROUTINE RT-TOTAL-SIZE (OBJ1 "AUX" OBJ (TOTSIZ 0))
	<SET OBJ <FIRST? .OBJ1>>
	<REPEAT ()
		<COND
			(<MC-F? .OBJ>
				<RETURN>
			)
			(<FSET? .OBJ ,FL-WORN>
			)
			(T
				<SET TOTSIZ <+ .TOTSIZ <GETB <GETPT .OBJ ,P?SIZE> ,K-SIZ-SIZ>>>
			)
		>
		<SET OBJ <NEXT? .OBJ>>
	>
	<RETURN .TOTSIZ>
>
 
<ROUTINE RT-OBJ-TOO-LARGE? (OBJ1 OBJ2 "AUX" CAP)
	<SET CAP <GETB <GETPT .OBJ2 ,P?SIZE> ,K-SIZ-CAP>>
	<COND
		(<EQUAL? .CAP ,K-CAP-MAX>
			<RFALSE>
		)
		(<G?	<+ <GETB <GETPT .OBJ1 ,P?SIZE> ,K-SIZ-SIZ>	; "Size"
					<RT-TOTAL-SIZE .OBJ2>
				>
				.CAP
			>
			<RTRUE>
		)
	>
>
 
<ROUTINE RT-ROOM-IN-MSG? (OBJ1 OBJ2)
	<COND
		(<RT-OBJ-TOO-LARGE? .OBJ1 .OBJ2>
			<TELL "There is not enough room" in .OBJ2 the .OBJ2 "." CR>
		)
	>
>
 
<ROUTINE RT-CHECK-MOVE-MSG? (SRC DEST "AUX" PTR OLOC CNT)
	<COND
		(.DEST
			<SET PTR ,GL-LOC-TRAIL>
			<SET OLOC .DEST>
			<REPEAT ()
				<ZPUT .PTR 0 .OLOC>
				<INC CNT>
				<COND
					(<OR	<MC-F? .OLOC>
							<IN? .OLOC ,ROOMS>
							<IN? .OLOC ,LOCAL-GLOBALS>
							<IN? .OLOC ,GLOBAL-OBJECTS>
						>
						<RETURN>
					)
				>
				<SET OLOC <LOC .OLOC>>
				<SET PTR <ZREST .PTR 2>>
				<COND
					(<EQUAL? .OLOC .DEST>
						<RETURN>
					)
				>
			>
			<COND
				(<INTBL? .SRC ,GL-LOC-TRAIL .CNT>
					<TELL
The ,WINNER " can't put" the .SRC in .SRC him .SRC "self, or" in .SRC
"something that is already" in .SRC him .SRC "." CR
					>
					<RTRUE>
				)
			>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "R"
;"---------------------------------------------------------------------------"
 
<ROUTINE V-REACH-BEHIND ()
	<TELL "['Reach behind' currently has no default handling.]|">
	<RFATAL>
>
 
<ROUTINE V-REACH-IN ()
	<TELL "['Reach in' currently has no default handling.]|">
	<RFATAL>
>
 
<ROUTINE V-REACH-UNDER ()
	<TELL "['Reach under' currently has no default handling.]|">
	<RFATAL>
>
 
<ROUTINE V-READ ()
	<TELL "['Read' currently has no default handling.]|">
	<RFATAL>
>
 
;"---------------------------------------------------------------------------"
; "S"
;"---------------------------------------------------------------------------"
 
<ROUTINE V-SHOW ()
	<TELL The+verb ,PRSI "seem" " unimpressed by" the ,PRSO "." CR>
>
 
<ROUTINE V-SHOW-SWP ()
	<PERFORM ,V?SHOW ,PRSI ,PRSO>
>
 
<ROUTINE V-SIT ("AUX" (OBJ ,PRSO))
	<COND
		(<MC-PRSO? ,ROOMS>
			<SET OBJ ,TH-GROUND>
		)
	>
	<RT-NO-POINT-MSG "Sitting on" .OBJ>
>
 
;"---------------------------------------------------------------------------"
; "T"
;"---------------------------------------------------------------------------"
 
<ROUTINE ITAKE ("OPT" (OB <>) (V? T) "AUX" CNT OBJ L)
	<COND
		(<ZERO? .OB>
			<SET OB ,PRSO>
		)
	>
	<SET L <LOC .OB>>
	<COND
		(<OR	<NOT <FSET? .OB ,FL-TAKEABLE>>
			;	<NOT <ACCESSIBLE? .OB>>
			>
			<COND
				(.V?
					<RT-YOU-CANT-MSG "take">
				)
			>
			<RFALSE>
		)
		(<RT-OBJ-TOO-LARGE? .OB ,WINNER>
			<COND
			;	(.FORCED?
					<TELL "As" the+verb ,WINNER "reach" " for" the .OB>
					<SET CNT 0>
					<REPEAT ((1ST? T))
						<COND
							(<NOT <RT-OBJ-TOO-LARGE? .OB ,WINNER>>
								<RETURN>
							)
							(<SET OBJ <FIND-FLAG-NOT ,WINNER ,FL-WORN>>
								<MOVE .OBJ ,HERE>
								<INC CNT>
								<TELL "," the .OBJ>
							)
						>
					>
					<COND
						(<EQUAL? .CNT 1>
							<TELL verb .OBJ "slip">
						)
						(T
							<TELL " slip">
						)
					>
					<TELL " to" the ,TH-GROUND "." CR>
					<RT-DO-TAKE .OB>
				)
				(T
					<COND
						(.V?
							<TELL The+verb ,WINNER "are" " holding too much." CR>
						)
					>
					<RFALSE>
				)
			>
		)
	;	(<AND <G? <SET CNT <CCOUNT ,WINNER>> ,FUMBLE-NUMBER>
				<PROB <* .CNT ,FUMBLE-PROB>>
				<SET OBJ <FIND-FLAG-NOT ,WINNER ,FL-WORN>>
			>
			<TELL
The .OBJ " slips from" his ,WINNER " arms while" he+verb ,WINNER "are"
" taking" the .OB ", and both tumble to" the ,TH-GROUND ". "
The+verb ,WINNER "are" " carrying too many things." CR
			>
			<MOVE .OBJ ,HERE>
			<MOVE .OB ,HERE>
			<RFATAL>
		)
		(T
			<COND
				(<AND <NOT <VERB? TAKE>>
						<NOT <EQUAL? .L ,WINNER>>
					>
					<RT-FIRST-YOU-MSG "take" .OB .L>
				)
			>
			<RT-DO-TAKE .OB>
		)
	>
>
 
<ROUTINE RT-DO-TAKE (OBJ "OPT" (FORCED? <>) "AUX" L)
	<SET L <LOC .OBJ>>
	<MOVE .OBJ ,WINNER>
	<FSET .OBJ ,FL-SEEN>
	<FSET .OBJ ,FL-TOUCHED>
	<FCLEAR .OBJ ,FL-NO-DESC>
	<FCLEAR .OBJ ,FL-INVISIBLE>
	<FCLEAR .OBJ ,FL-WORN>
	<RTRUE>
>
 
<ROUTINE PRE-TAKE ("AUX" L)
	<COND
		(<MC-PRSO? ,TH-HANDS ,YOU>
			<RFALSE>
		)
		(<==? <SET L <LOC ,PRSO>> ,GLOBAL-OBJECTS>
			<NOT-HERE ,PRSO>
		)
		(<RT-META-IN? ,WINNER ,PRSO>
			<RT-ALREADY-MSG ,WINNER>
			<TELL in ,PRSO the ,PRSO ".]" CR>
		)
		(<AND .L
				<OR
					<NOT <FSET? .L ,FL-SURFACE>>
				;	<NOT <FSET? ,PRSO ,FL-ON>>
				>
				<FSET? .L ,FL-OPENABLE>
				<NOT <FSET? .L ,FL-OPEN>>
			>
			<TELL The+verb .L "are" " closed." CR>
			<RTRUE>
		)
		(<VERB? TAKE-WITH>
			<RFALSE>
		)
		(,PRSI
			<COND
				(<EQUAL? ,PRSI .L>
					<SETG PRSI <>>
					<RFALSE>
				)
				(<AND <OR
							<NOT <FSET? .L ,FL-SURFACE>>
						;	<NOT <FSET? ,PRSO ,FL-ON>>
						>
						<FSET? ,PRSI ,FL-OPENABLE>
						<NOT <FSET? ,PRSI ,FL-OPEN>>
					>
					<TELL The+verb ,PRSI "are" " closed." CR>
					<RTRUE>
				)
				(<NOT <==? ,PRSI .L>>
					<COND
						(<FSET? ,PRSI ,FL-PERSON>
							<TELL The+verb ,PRSI "do" "n't have" the ,PRSO>
						)
						(T
							<TELL The+verb ,PRSO "are" "n't" in ,PRSI the ,PRSI>
						)
					>
					<TELL "." CR>
				)
			>
		)
		(T
			<PRE-TAKE-WITH>
		)
	>
>
 
<ROUTINE PRE-TAKE-WITH ("AUX" X)
	<COND
		(<MC-PRSO? ,YOU>
			<RFALSE>
		)
		(<EQUAL? <META-LOC ,PRSO> ,GLOBAL-OBJECTS>
			<COND
				(<AND <NOT <HELD? ,PRSO>>
						<NOT <FSET? ,PRSO ,FL-PERSON>>
					>
					<NOT-HERE ,PRSO>
				)
			>
		)
		(<IN? ,PRSO ,WINNER>
			<RT-ALREADY-MSG ,PLAYER>
			<TELL " holding" the ,PRSO ".]" CR>
		)
		(<AND <FSET? <LOC ,PRSO> ,FL-CONTAINER>
				<OR
					<NOT <FSET? <LOC ,PRSO> ,FL-SURFACE>>
				;	<NOT <FSET? ,PRSO ,FL-ON>>
				>
				<NOT <FSET? <LOC ,PRSO> ,FL-OPEN>>
			>
			<RT-YOU-CANT-MSG "reach">
		)
		(<IN? ,WINNER ,PRSO>
			<SETG CLOCK-WAIT T>
			<TELL "[" The+verb ,WINNER "are" in ,PRSO the ,PRSO ".]" CR>
		)
	>
>
 
<ROUTINE V-TAKE ("AUX" L V)
	<SET L <LOC ,PRSO>>
	<SET V <ITAKE>>
	<COND
		(<EQUAL? .V ,M-FATAL>
			<RFATAL>
		)
		(.V
			<COND
				(<G? ,P-MULT 1>
					<TELL "Taken">
				)
				(T
					<TELL The+verb ,WINNER "take" the ,PRSO>
					<COND
						(<AND <NOT <IN? .L ,ROOMS>>
								<NOT <EQUAL? .L ,GLOBAL-OBJECTS ,LOCAL-GLOBALS>>
							>
							<TELL " from">
							<COND
								(<AND <EQUAL? .L ,PLAYER>
										<NOT <EQUAL? ,WINNER ,PLAYER>>
									>
									<TELL " you">
								)
								(T
									<TELL the .L>
								)
							>
						)
					>
				)
			>
			<TELL "." CR>
		)
	>
>
 
<ROUTINE V-TAKE-WITH ()
	<TELL "['Take with' currently has no default handling.]|">
	<RFATAL>
>
 
<ROUTINE V-TALK-TO ()
	<TELL "['Talk to' currently has no default handling.]|">
	<RFATAL>
>
 
<ROUTINE V-TELL ()
	<COND
		(<EQUAL? ,PRSO ,PLAYER>
			<COND
				(,QCONTEXT
					<SETG QCONTEXT <>>
					<COND
						(,P-CONT
							<SETG WINNER ,PLAYER>
						)
						(T
							<TELL "Okay, you're not talking to anyone else." CR>
						)
					>
				)
				(T
					<WONT-HELP-TO-TALK-TO ,PLAYER>
				;	<SETG QUOTE-FLAG <>>
					<SETG P-CONT <>>
					<RFATAL>
				)
			>
		)
		(<FSET? ,PRSO ,FL-ALIVE>
			<SETG QCONTEXT ,PRSO>
			<COND
				(,P-CONT
					<SETG CLOCK-WAIT T>
					<SETG WINNER ,PRSO>
					<RFALSE>
				)
				(T
					<TELL
The+verb ,PRSO "look" " at you expectantly, as if you seemed to be about to
talk." CR
					>
				)
			>
		)
		(T
			<WONT-HELP-TO-TALK-TO ,PRSO>
		;	<SETG QUOTE-FLAG <>>
			<SETG P-CONT <>>
			<RFATAL>
		)
	>
>
 
<ROUTINE WONT-HELP-TO-TALK-TO (OBJ)
	<TELL "Talking to" the .OBJ " won't help one bit." CR>
>
 
<ROUTINE V-TELL-ABOUT ("AUX" PERSON)
	<COND
		(<MC-PRSO? ,CH-PLAYER>
			<COND
				(<EQUAL? ,WINNER ,CH-PLAYER>
					<COND
						(<OR	<SET PERSON <FIND-FLAG ,HERE ,FL-PERSON ,CH-PLAYER>>
								<SET PERSON <FIND-FLAG ,HERE ,FL-ALIVE ,CH-PLAYER>>
							>
							<PERFORM ,V?ASK-ABOUT .PERSON ,PRSI>
						)
						(T
							<TELL ,K-TALK-TO-SELF-MSG CR>
						)
					>
				)
				(T
					<SET PERSON ,WINNER>
					<SETG WINNER ,CH-PLAYER>
					<PERFORM ,V?ASK-ABOUT .PERSON ,PRSI>
				)
			>
			<RTRUE>
		)
		(<NOT <FSET? ,PRSO ,FL-ALIVE>>
			<TELL The ,WINNER "can't tell anything to" the ,PRSO "." CR>
		)
		(<FSET? ,PRSO ,FL-ASLEEP>
			<TELL
"Talking to" the ,PRSO " in" his ,PRSO " current condition would be a waste
of time." CR
			>
		)
		(T
			<TELL The+verb ,PRSO "shrug" " indifferently." CR>
		)
	>
>
 
<ROUTINE V-THANK ()
	<COND
		(<EQUAL? ,WINNER ,CH-PLAYER>
			<COND
				(<MC-PRSO? ,CH-PLAYER>
					<TELL "Patting yourself on the back won't help." CR>
				)
				(<FSET? ,PRSO ,FL-ASLEEP>
					<TELL
The+verb ,PRSO "is" "n't in any condition to accept your thanks." CR
					>
				)
				(T
					<TELL "\"You're welcome.\"" CR>
				)
			>
		)
		(T
			<RT-FOOLISH-TO-TALK?>
			<RTRUE>
		)
	>
>
 
<ROUTINE V-TIE-TO ()
	<TELL "You can't tie" the ,PRSO " to" the ,PRSI "." CR>
>
 
<ROUTINE V-TURN ()
	<TELL "['Turn' currently has no default handling.]|">
	<RFATAL>
>
 
<ROUTINE V-TURN-OFF ()
	<TELL "['Turn off' currently has no default handling.]|">
	<RFATAL>
>
 
<ROUTINE V-TURN-ON ()
	<TELL "['Turn on' currently has no default handling.]|">
	<RFATAL>
>
 
<ROUTINE V-TURN-TO ()
	<TELL "['Turn to' currently has no default handling.]|">
	<RFATAL>
>
 
;"---------------------------------------------------------------------------"
; "U"
;"---------------------------------------------------------------------------"
 
<ROUTINE V-UNDO ()
	<COND
		(,P-CAN-UNDO
			<SETG GL-SL-HERE <>>
			<COND
				(<ZERO? <IRESTORE>>
					<TELL "[UNDO failed.]" CR>
				)
				(T
					<TELL "[UNDO is not available.]" CR>
				)
			>
			<RTRUE>
		)
	>
>
 
<ROUTINE V-UNLOCK ()
	<COND
	;	(<EQUAL? ,P-PRSA-WORD ,W?UNBAR>
			<TELL The+verb ,PRSO "are" "n't barred." CR>
		)
		(<NOT <FSET? ,PRSO ,FL-OPENABLE>>
			<RT-YOU-CANT-MSG>
		)
		(<FSET? ,PRSO ,FL-OPEN>
			<RT-ALREADY-MSG ,PRSO "open">
		)
		(<NOT <FSET? ,PRSO ,FL-LOCKED>>
			<RT-ALREADY-MSG ,PRSO "unlocked">
		)
		(<NOT <RT-MATCH-KEY ,PRSO ,PRSI>>
			<TELL The ,WINNER " can't unlock" the ,PRSO " with" the ,PRSI !\. CR>
		)
		(T
			<RT-OPEN-DOOR-MSG ,PRSO ,PRSI>
		)
	>
>
 
<ROUTINE V-UNWEAR ()
	<COND
		(<IN? ,PRSO ,WINNER>
			<COND
				(<FSET? ,PRSO ,FL-WORN>
					<FCLEAR ,PRSO ,FL-WORN>
					<TELL The+verb ,WINNER "take" " off" the ,PRSO "." CR>
				)
				(T
					<TELL The+verb ,WINNER "are" "n't wearing" the ,PRSO "." CR>
				)
			>
		)
		(T
			<PERFORM ,V?TAKE ,PRSO>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "W"
;"---------------------------------------------------------------------------"
 
<ROUTINE V-WAIT ("AUX" (N -1) (ABS? <>))
	<COND
		(<NOT ,PRSO>
			<SET N 20>
		)
		(<MC-PRSO? ,INTNUM>
			<COND
				(<G? ,P-NUMBER 0>
					<SET N <* ,P-NUMBER 2>>
				)
			>
		)
		(<MC-PRSO? ,TH-TIME>
			<COND
				(<NOUN-USED? ,PRSO ,W?TURN ,W?TURNS>
					<COND
						(<AND <ADJ-USED? ,PRSO ,W?INT.NUM>
								<G? ,P-NUMBER 0>
							>
							<SET N ,P-NUMBER>
						)
						(T
							<SET N 1>
						)
					>
				)
				(<NOUN-USED? ,PRSO ,W?MIN ,W?MINUTE ,W?MINUTES>
					<COND
						(<AND <ADJ-USED? ,PRSO ,W?INT.NUM>
								<G? ,P-NUMBER 0>
							>
							<SET N <* ,P-NUMBER 2>>
						)
						(T
							<SET N 2>
						)
					>
				)
				(<NOUN-USED? ,PRSO ,W?HOUR ,W?HOURS>
					<COND
						(<AND <ADJ-USED? ,PRSO ,W?INT.NUM>
								<G? ,P-NUMBER 0>
							>
							<SET N <* ,P-NUMBER 120>>
						)
						(T
							<SET N 120>
						)
					>
				)
			>
		)
		(T
			<TELL "[You can't wait for" the ,PRSO ".]|">
			<RFATAL>
		)
	>
	<COND
		(<G? .N 0>
			<SETG GL-MOVES <+ ,GL-MOVES <- .N 1>>>
			<TELL ,K-TIME-PASSES-MSG>
		)
		(.ABS?
			<TELL "[That time has already passed.]|">
			<RFATAL>
		)
		(T
			<TELL "[You can't wait for that.]|">
			<RFATAL>
		)
	>
>
 
<ROUTINE RT-FIND-DIR (RM "OPT" (L <LOC ,WINNER>) "AUX" (P 0) OD)
	<SET OD ,P-WALK-DIR>
	<REPEAT (OBJ PT PTS)
		<COND
			(<OR	<ZERO? <SET P <NEXTP .L .P>>>
					<L? .P ,LOW-DIRECTION>
				>
				<RFALSE>
			)
		>
		<SETG P-WALK-DIR .P>
		<COND
			(<SET PT <GETPT .L .P>>
				<SET PTS <PTSIZE .PT>>
				<COND
					(<EQUAL? .PTS ,UEXIT>
						<COND
							(<EQUAL? .RM <GET/B .PT ,REXIT>>
								<RETURN>
							)
						>
					)
					(<EQUAL? .PTS ,FEXIT>
						<COND
							(<EQUAL? .RM <APPLY <GET .PT ,FEXITFCN> T>>
								<RETURN>
							)
						>
					)
					(<EQUAL? .PTS ,CEXIT>
						<COND
							(<EQUAL? .RM <GET/B .PT ,REXIT>>
								<RETURN>
							)
						>
					)
					(<EQUAL? .PTS ,DEXIT>
						<COND
							(<EQUAL? .RM <GET/B .PT ,REXIT>>
								<COND
									(<SET OBJ <GET/B .PT ,DEXITOBJ>>
										<RETURN>
									)
								>
							)
						>
					)
				>
			)
		>
	>
	<SETG P-WALK-DIR .OD>
	<RETURN .P>
>
 
<ROUTINE RT-FIND-ROOM (DIR "OPT" (L <LOC ,WINNER>) "AUX" OD (RM <>) PT PTS)
	<COND
		(<SET PT <GETPT .L .DIR>>
			<SET PTS <PTSIZE .PT>>
			<COND
				(<EQUAL? .PTS ,UEXIT ,CEXIT ,DEXIT>
					<SET RM <GET/B .PT ,REXIT>>
				)
				(<EQUAL? .PTS ,FEXIT>
					<SET OD ,P-WALK-DIR>
					<SETG P-WALK-DIR .DIR>
					<SET RM <APPLY <GET .PT ,FEXITFCN> T>>
					<SETG P-WALK-DIR .OD>
				)
			>
		)
	>
	<RETURN .RM>
>
 
<GLOBAL GL-PUPPY:OBJECT <>>
 
<ROUTINE RT-SET-PUPPY (OBJ)
	<COND
		(,GL-PUPPY
			<FCLEAR ,GL-PUPPY ,FL-NO-DESC>
		)
	>
	<SETG GL-PUPPY .OBJ>
	<FSET ,GL-PUPPY ,FL-NO-DESC>
>
 
<ROUTINE RT-CLEAR-PUPPY ()
	<COND
		(,GL-PUPPY
			<FCLEAR ,GL-PUPPY ,FL-NO-DESC>
			<SETG GL-PUPPY <>>
		)
	>
	<RTRUE>
>
 
<ROUTINE V-WALK ("AUX" PT PTS STR RM)
	<COND
		(<ZERO? ,P-WALK-DIR>
			<V-WALK-AROUND>
			<RFATAL>
		)
	>
	<COND
		(<SET PT <GETPT <LOC ,WINNER> ,PRSO>>
			<COND
				(<==? <SET PTS <PTSIZE .PT>> ,UEXIT>
					<RT-GOTO <GET/B .PT ,REXIT>>
					<RTRUE>
				)
				(<==? .PTS ,NEXIT>
					<SETG CLOCK-WAIT T>
					<TELL <GET .PT ,NEXITSTR> CR>
					<RFATAL>
				)
				(<==? .PTS ,FEXIT>
					<COND
						(<SET RM <APPLY <GET .PT ,FEXITFCN>>>
							<RT-GOTO .RM>
							<RTRUE>
						)
						(T
							<RFATAL>
						)
					>
				)
				(<==? .PTS ,CEXIT>
					<COND
						(<VALUE <GETB .PT ,CEXITFLAG>>
							<RT-GOTO <GET/B .PT ,REXIT>>
							<RTRUE>
						)
						(<SET STR <GET .PT ,CEXITSTR>>
							<TELL .STR CR>
							<RFATAL>
						)
						(T
							<RT-YOU-CANT-MSG "go">
							<RFATAL>
						)
					>
				)
				(<==? .PTS ,DEXIT>
					<COND
						(<WALK-THRU-DOOR? .PT>
							<RT-GOTO <GET/B .PT ,REXIT>>
							<RTRUE>
						)
						(T
							<RFATAL>
						)
					>
				)
			>
		)
		(<EQUAL? ,PRSO ,P?IN ,P?OUT>
			<V-WALK-AROUND>
		)
		(T
			<RT-YOU-CANT-MSG "go">
			<RFATAL>
		)
	>
>
 
<ROUTINE WALK-THRU-DOOR? (PT "OPT" (OBJ 0) (TELL? T) "AUX" RM)
	<COND
		(<ZERO? .OBJ>
			<SET OBJ <GET/B .PT ,DEXITOBJ>>
		)
	>
	<COND
		(<FSET? .OBJ ,FL-OPEN>
			<RTRUE>
		)
		(<AND .PT
				<SET RM <GET .PT ,DEXITSTR>>
			>
			<COND
				(.TELL?
					<TELL .RM CR>
				)
			>
			<RFALSE>
		)
		(T
			<TELL The+verb .OBJ "are" "n't open." CR>
			<RFALSE>
		)
	>
>
 
<ROUTINE RT-GOTO (RM "OPT" (FORCED? <>))
	<COND
		(<IN? ,WINNER .RM>
			<RT-WALK-WITHIN-ROOM-MSG>
			<RFALSE>
		)
	>
	<COND
		(<APPLY <GETP ,HERE ,P?ACTION> ,M-EXIT>
			<COND
				(<NOT .FORCED?>
					<RFALSE>
				)
			>
		)
	>
	<MOVE ,WINNER .RM>
	<COND
		(<==? ,WINNER ,PLAYER>
			<COND
				(,GL-PUPPY
					<MOVE ,GL-PUPPY .RM>
				)
			>
			<SETG OHERE ,HERE>
			<SETG HERE .RM>
			<RT-ENTER-ROOM>
		)
	>
	<COND
		(,GL-PUPPY
			<TELL TAB The+verb ,GL-PUPPY "follow" " you." CR>
		)
	>
	<RTRUE>
>
 
<ROUTINE RT-ENTER-ROOM ("AUX" VAL CNT TBL)
	<SETG LIT <LIT?>>
	<DIROUT ,D-TABLE-ON ,K-DIROUT-TBL>
	<RT-ROOM-NAME-MSG>
	<DIROUT ,D-TABLE-OFF>
	<SET TBL <ZREST ,K-DIROUT-TBL 2>>
	<SET CNT <ZGET ,K-DIROUT-TBL 0>>
	<COND
		(<G? .CNT 0>
			<REPEAT ((I 0) C)
				<COND
					(<AND <G=? <SET C <GETB .TBL .I>> !\a>
							<L=? .C !\z>
						>
						<PUTB .TBL .I <- .C 32>>
					)
				>
				<COND
					(<IGRTR? I .CNT>
						<RETURN>
					)
				>
			>
		)
	>
	<HLIGHT ,H-BOLD>
	<PRINTT .TBL .CNT>
	<HLIGHT ,H-NORMAL>
	<CRLF>
;	<COND
		(<OR	<EQUAL? ,VERBOSITY 2>
				<AND
					<EQUAL? ,VERBOSITY 1>
					<NOT <FSET? ,HERE ,FL-TOUCHED>>
				>
			>
			<CRLF>
		)
	>
	<APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
	<SET VAL
		<COND
			(<RT-DESCRIBE-ROOM>
				<RT-DESCRIBE-OBJECTS>
			)
		>
	>
	<APPLY <GETP ,HERE ,P?ACTION> ,M-ENTERED>
	.VAL
>
 
<ROUTINE RT-ROOM-NAME-MSG ()
	<COND
		(,LIT
			<TELL D ,HERE>
		)
		(T
			<TELL "darkness">
		)
	>
>
 
<ROUTINE V-WALK-AROUND ()
	<SETG CLOCK-WAIT T>
	<TELL "[" ,K-WHICH-DIR-MSG "]" CR>
	<RFATAL>
>
 
<ROUTINE V-WALK-TO ()
	<TELL "['Walk to' currently has no default handling.]|">
	<RFATAL>
>
 
<CONSTANT K-WHICH-DIR-MSG "Which direction do you want to go in?">
 
<ROUTINE RT-WALK-WITHIN-ROOM-MSG ()
	<NO-NEED "move around within" ,HERE>
>
 
<ROUTINE V-WEAR ()
	<COND
		(<NOT <IN? ,PRSO ,WINNER>>
			<TELL The+verb ,WINNER "do" "n't have" the ,PRSO "." CR>
		)
		(<FSET? ,PRSO ,FL-WORN>
			<RT-ALREADY-MSG ,WINNER>
			<TELL " wearing" the ,PRSO ".]" CR>
		)
		(<FSET? ,PRSO ,FL-CLOTHING>
			<FSET ,PRSO ,FL-WORN>
			<TELL The+verb ,WINNER "put" " on" the ,PRSO "." CR>
		)
		(T
			<RT-YOU-CANT-MSG "put on">
		)
	>
>
 
<ROUTINE V-WELD ()
	<TELL "['Weld' currently has no default handling.]|">
	<RFATAL>
>
 
;"---------------------------------------------------------------------------"
; "Y"
;"---------------------------------------------------------------------------"
 
<ROUTINE V-YES ()
	<TELL "[You seem sure of yourself.]" CR>
	<RFATAL>
>
 
;"***************************************************************************"
; "end of file"
;"***************************************************************************"
 
