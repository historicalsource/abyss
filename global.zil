;"***************************************************************************"
; "game : Abyss"
; "file : GLOBAL.ZIL"
; "auth :   $Author:   DEB  $"
; "date :     $Date:   13 Mar 1989 19:20:32  $"
; "rev  : $Revision:   1.6  $"
; "vers : 1.0"
;"---------------------------------------------------------------------------"
; "Global objects"
; "Copyright (C) 1988 Infocom, Inc.  All rights reserved."
;"***************************************************************************"
 
<GLOBAL HERE:OBJECT RM-SUB-BAY <> BYTE>
<GLOBAL OHERE:OBJECT <> <> BYTE>
 
<OBJECT ROOMS
	(DESC "that")
	(FLAGS FL-NO-ARTICLE)
>
 
<OBJECT GLOBAL-OBJECTS
	(DESC "GO")
;	(FDESC 0)
	(GENERIC 0)
	(GLOBAL 0)
	(OWNER 0)
;	(TEXT 0)
	(THINGS 0)
	(CAPACITY 0)
	(SCORE 0)
	(FLAGS
		FL-ALIVE				;  1
		FL-ASLEEP			;  2
		FL-AUTO-ENTER		;  3
		FL-AUTO-OPEN		;  4
		FL-BODY-PART		;  5
		FL-BROKEN			;  6
		FL-BURNABLE			;  7
		FL-BY-HAND			;  8
		FL-CLOTHING			;  9
		FL-COLLECTIVE		; 10
		FL-CONTAINER		; 11
		FL-DOOR				; 12
		FL-FEMALE			; 13
		FL-HAS-LDESC		; 14
		FL-HAS-SDESC		; 15
		FL-INDOORS			; 16
		FL-INVISIBLE		; 17
		FL-KEY				; 18
		FL-KNIFE				; 19
		FL-LAMP				; 20
		FL-LIGHTED			; 21
		FL-LOCKED			; 22
		FL-NO-ALL			; 23
		FL-NO-ARTICLE		; 24
		FL-NO-DESC			; 25
		FL-ON					; 26
		FL-OPEN				; 27
		FL-OPENABLE			; 28
		FL-PERSON			; 29
		FL-PLURAL			; 30
		FL-READABLE			; 31
	;	FL-ROOMS				; 32
		FL-SEARCH			; 33
		FL-SEEN				; 34
		FL-SURFACE			; 35
		FL-TAKEABLE			; 36
		FL-TOOL				; 37
		FL-TOUCHED			; 38
		FL-TRANSPARENT		; 39
		FL-TRY-TAKE			; 40
		FL-VEHICLE			; 41
		FL-VOWEL				; 42
		FL-WATER				; 43
		FL-WEAPON			; 44
		FL-WORN				; 45
		FL-YOUR				; 46
	;	FL-FLAG-47			; 47
	;	FL-FLAG-48			; 48
	)
>
 
<OBJECT LOCAL-GLOBALS
	(LOC GLOBAL-OBJECTS)
	(DESC "LG")
	(SYNONYM L.G)
	(FLAGS FL-NO-ARTICLE)
>
 
<OBJECT GLOBAL-HERE
	(LOC GLOBAL-OBJECTS)
	(DESC "here")
	(FLAGS FL-NO-ARTICLE)
	(SYNONYM HERE PLACE ROOM AREA)
	(ACTION RT-GLOBAL-HERE)
>
 
<ROUTINE RT-GLOBAL-HERE ("OPT" (CONTEXT <>) "AUX" P)
	<COND
		(,HERE
			<COND
				(<SET P <GETP ,HERE ,P?ACTION>>
					<APPLY .P .CONTEXT>
				)
			>
		)
	>
>
 
<OBJECT IT
	(LOC GLOBAL-OBJECTS)
	(DESC "it")
	(SYNONYM IT THIS)
	(FLAGS FL-NO-ARTICLE FL-VOWEL)
>
 
<OBJECT THEM
	(LOC GLOBAL-OBJECTS)
	(DESC "them")
	(SYNONYM THEM)
	(FLAGS FL-NO-ARTICLE FL-PLURAL)
>
 
<OBJECT INTNUM
	(LOC GLOBAL-OBJECTS)
	(DESC "number")
	(SYNONYM INT.NUM)
>
 
<OBJECT YOU
	(LOC GLOBAL-OBJECTS)
	(DESC "you")
	(SYNONYM YOU YOURSELF)
	(ACTION RT-YOU)
>
 
<ROUTINE RT-YOU ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(,NOW-PRSI
			<PERFORM ,PRSA ,PRSO ,WINNER>
		)
		(T
			<PERFORM ,PRSA ,WINNER ,PRSI>
		)
	>
>
 
<OBJECT HER
	(LOC GLOBAL-OBJECTS)
	(DESC "her")
	(SYNONYM HER)
	(FLAGS FL-NO-ARTICLE)
>
 
<OBJECT HIM
	(LOC GLOBAL-OBJECTS)
	(DESC "him")
	(SYNONYM HIM)
	(FLAGS FL-NO-ARTICLE)
>
 
;"---------------------------------------------------------------------------"
; "TH-HUMAN-BODY"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-HUMAN-BODY
	(LOC GLOBAL-OBJECTS)
	(FLAGS FL-HAS-SDESC FL-NO-ARTICLE)
	(SYNONYM
		BODY
		SKIN
		ARM ARMS
		HAND HANDS
		LEG LEGS
		ANKLE ANKLES
		FOOT FEET
		HEAD
		HAIR
		EYE EYES
		EAR EARS
		NOSE
		FACE
		CHEEK CHEEKS
		LIP LIPS
		MOUTH
		NECK
		SHOULDER SHOULDERS
		CHEST
		TORSO
		BACK
		WAIST
	)
	(ADJECTIVE LEFT RIGHT)
	(OWNER K-BODY-OWNER-TBL)
	(GENERIC RT-GN-BODY)
	(ACTION RT-TH-HUMAN-BODY)
>
 
<CONSTANT K-BODY-OWNER-TBL
	<TABLE (PURE LENGTH)
		CH-COFFEY
		CH-LINDSEY
	>
>
 
<CONSTANT K-NO-REFER-MSG "[You don't need to refer to ">
 
<ROUTINE RT-TH-HUMAN-BODY ("OPT" (CONTEXT <>) "AUX" TMP (PERSON <>))
	<COND
		(<MC-CONTEXT? ,M-OBJDESC>
			<TELL "their body">
		)
		(.CONTEXT
			<RFALSE>
		)
		(T
			<COND
				(<SET TMP <NP-ADJS <GET-NP>>>
					<SET PERSON <ADJS-POSS .TMP>>
				)
			>
			<COND
				(<AND .PERSON
						<NOT <VISIBLE? .PERSON>>
					>
					<NP-CANT-SEE>
				)
				(T
					<TELL ,K-NO-REFER-MSG>
					<COND
					;	(<EQUAL? .PERSON>
							<TELL "that">
						)
						(T
							<TELL "any">
						)
					>
					<TELL " part of">
					<COND
						(.PERSON
							<TELL the .PERSON !\'>
							<COND
								(<OR	<NOT <FSET? .PERSON ,FL-PLURAL>>
										<FSET? .PERSON ,FL-COLLECTIVE>
									>
									<TELL !\s>
								)
							>
						)
						(T
							<TELL " their">
						)
					>
					<TELL " body.]" CR>
				)
			>
			<RFATAL>
		)
	>
>
 
<ROUTINE RT-GN-BODY (TBL FINDER "AUX" (PART <>))
	<REPEAT (
			(PTR <REST-TO-SLOT .TBL FIND-RES-OBJ1>)
			(N <FIND-RES-COUNT .TBL>)
		)
		<COND
			(<DLESS? N 0>
				<RFALSE>
			)
			(<NOT <SET PART <ZGET .PTR 0>>>)
			(<FSET? .PART ,FL-YOUR>
				<RETURN>
			)
			(<EQUAL? .PART ,TH-PLAYER-BODY>
				<RETURN>
			)
			(<NOT <EQUAL? .PART ,TH-HUMAN-BODY>>
				<RETURN>
			)
		>
		<SET PTR <ZREST .PTR 2>>
	>
	<RETURN .PART>
>
 
;"---------------------------------------------------------------------------"
; "TH-PLAYER-BODY"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-PLAYER-BODY
	(LOC GLOBAL-OBJECTS)
	(DESC "body")
	(FLAGS FL-BODY-PART FL-YOUR)
	(SYNONYM
		BODY
		SKIN
		ARM ARMS
		ANKLE ANKLES
		FOOT FEET
		HAIR
		EYE EYES
		EAR EARS
		NOSE
		FACE
		CHEEK CHEEKS
		LIP LIPS
		TONGUE
		NECK
		SHOULDER SHOULDERS
		CHEST
		TORSO
		BACK
		WAIST
	)
	(ADJECTIVE LEFT RIGHT)
	(OWNER CH-PLAYER)
	(GENERIC RT-GN-BODY)
	(ACTION RT-TH-PLAYER-BODY)
>
 
<ROUTINE RT-TH-PLAYER-BODY ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(T
			<TELL ,K-NO-REFER-MSG "that part of your body.]" CR>
			<RFATAL>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "TH-HEAD"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-HEAD
	(LOC GLOBAL-OBJECTS)
	(DESC "head")
	(FLAGS FL-BODY-PART FL-YOUR)
	(SYNONYM HEAD)
	(OWNER CH-PLAYER)
	(GENERIC RT-GN-BODY)
>
 
;"---------------------------------------------------------------------------"
; "TH-HANDS"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-HANDS
	(LOC GLOBAL-OBJECTS)
	(DESC "hands")
	(FLAGS FL-BODY-PART FL-BY-HAND FL-PLURAL FL-TOOL FL-WEAPON FL-YOUR)
	(SYNONYM HAND HANDS)
	(ADJECTIVE LEFT RIGHT)
	(OWNER CH-PLAYER)
	(GENERIC RT-GN-BODY)
>
 
;"---------------------------------------------------------------------------"
; "TH-GROUND"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-GROUND
	(LOC GLOBAL-OBJECTS)
	(SYNONYM GROUND FLOOR)
	(FLAGS FL-HAS-SDESC FL-SEARCH FL-SURFACE)
	(ACTION RT-TH-GROUND)
>
 
<ROUTINE RT-TH-GROUND ("OPT" (CONTEXT <>) (ART <>) (CAP? <>))
	<COND
		(<MC-CONTEXT? ,M-OBJDESC>
			<COND
				(.ART
					<RT-PRINT-ARTICLE ,TH-GROUND .ART .CAP?>
				)
			>
			<COND
				(<EQUAL? .ART <> ,K-ART-THE ,K-ART-A ,K-ART-ANY>
					<COND
						(.ART
							<TELL !\ >
						)
					>
					<COND
						(<FSET? ,HERE ,FL-INDOORS>
							<TELL "floor">
						)
						(T
							<TELL "ground">
						)
					>
				)
			>
		)
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE LOOK-ON>
			<COND
				(<RT-SEE-ANYTHING-IN? ,HERE>
					<TELL "You see">
					<RT-PRINT-CONTENTS ,HERE>
					<TELL " on" the ,TH-GROUND !\. CR>
				)
			>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "TH-SKY"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-SKY
	(LOC GLOBAL-OBJECTS)
	(SYNONYM SKY CEILING)
	(FLAGS FL-HAS-SDESC)
	(ACTION RT-TH-SKY)
>
 
<ROUTINE RT-TH-SKY ("OPT" (CONTEXT <>) (ART <>) (CAP? <>) "AUX" RM)
	<COND
		(<MC-CONTEXT? ,M-OBJDESC>
			<COND
				(.ART
					<RT-PRINT-ARTICLE ,TH-SKY .ART .CAP?>
				)
			>
			<COND
				(<EQUAL? .ART <> ,K-ART-THE ,K-ART-A ,K-ART-ANY>
					<COND
						(.ART
							<TELL !\ >
						)
					>
					<COND
						(<FSET? ,HERE ,FL-INDOORS>
							<TELL "ceiling">
						)
						(T
							<TELL "sky">
						)
					>
				)
			>
		)
		(.CONTEXT
			<RFALSE>
		)
		(<NOT <EVERYWHERE-VERB? <COND (,NOW-PRSI 2) (T 1)>>>
			<COND
				(<FSET? ,HERE ,FL-INDOORS>
					<COND
						(<NOUN-USED? ,TH-SKY ,W?SKY>
							<NP-CANT-SEE>
						)
					>
				)
				(T
					<COND
						(<NOUN-USED? ,TH-SKY ,W?CEILING>
							<NP-CANT-SEE>
						)
					>
				)
			>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "TH-TIME"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-TIME
	(LOC GENERIC-OBJECTS)
	(DESC "time")
	(SYNONYM TURN TURNS MINUTE MINUTES MIN HOUR HOURS)
	(ADJECTIVE INT.NUM)
>
 
;"---------------------------------------------------------------------------"
; "LG-WALL"
;"---------------------------------------------------------------------------"
 
<OBJECT LG-WALL
	(LOC LOCAL-GLOBALS)
	(DESC "wall")
	(SYNONYM WALL WALLS BULKHEAD)
	(ADJECTIVE FORE AFT PORT STARBOARD)
>
 
;"---------------------------------------------------------------------------"
; "TH-FLATBED"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-FLATBED
	(LOC GENERIC-OBJECTS)
	(DESC "Flatbed")
	(FLAGS FL-NO-ARTICLE)
	(SYNONYM FLATBED)
>
 
;"---------------------------------------------------------------------------"
; "TH-UFO"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-UFO
	(LOC GENERIC-OBJECTS)
	(DESC "UFO")
	(SYNONYM UFO)
>
 
;"---------------------------------------------------------------------------"
; "LG-DEEPCORE"
;"---------------------------------------------------------------------------"
 
<OBJECT LG-DEEPCORE
	(LOC LOCAL-GLOBALS)
	(DESC "Deepcore")
	(SYNONYM DEEPCORE)
	(ACTION RT-LG-DEEPCORE)
>
 
<ROUTINE RT-LG-DEEPCORE ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE>
			<TELL "It looks like Deepcore." CR>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "LG-TROUGH"
;"---------------------------------------------------------------------------"
 
<OBJECT LG-TROUGH
	(LOC LOCAL-GLOBALS)
	(DESC "Cayman trough")
	(SYNONYM TROUGH)
	(ACTION RT-LG-TROUGH)
>
 
<ROUTINE RT-LG-TROUGH ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE>
			<TELL "It looks like the Cayman trough." CR>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "LG-MONTANA"
;"---------------------------------------------------------------------------"
 
<OBJECT LG-MONTANA
	(LOC LOCAL-GLOBALS)
	(DESC "Montana")
	(SYNONYM MONTANA SUBMARINE SUB)
	(ADJECTIVE NAVY USS OHIO CLASS)
	(ACTION RT-LG-MONTANA)
>
 
<ROUTINE RT-LG-MONTANA ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE>
			<TELL "It looks like the Montana." CR>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "LG-OUTLET"
;"---------------------------------------------------------------------------"
 
<OBJECT LG-OUTLET
	(LOC LOCAL-GLOBALS)
	(DESC "outlet")
	(SYNONYM OUTLET SOCKET)
	(ADJECTIVE WALL ELECTRICAL)
>
 
;"***************************************************************************"
; "end of file"
;"***************************************************************************"
 
