;"***************************************************************************"
; "game : Abyss"
; "file : STOPPER.ZIL"
; "auth :   $Author:   DEB  $"
; "date :     $Date:   20 Mar 1989  8:45:06  $"
; "rev  : $Revision:   1.7  $"
; "vers : 1.0"
;"---------------------------------------------------------------------------"
; "Sub bay"
; "Copyright (C) 1988 Infocom, Inc.  All rights reserved."
;"***************************************************************************"
 
;"---------------------------------------------------------------------------"
; "RM-TRI-MIX-STORAGE"
;"---------------------------------------------------------------------------"
 
; "Duane - we need generic routines in this room to always pick the
	nitrogen tank, nitrogen base, nitrogen k-valve, and nitrogen stopper
	when the player makes an ambiguous reference."
 
<ROOM RM-TRI-MIX-STORAGE
	(LOC ROOMS)
	(DESC "tri-mix storage")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM STORAGE)
	(ADJECTIVE TRI MIX TRI-MIX)
	(FORE TO RM-COMPRESSOR-ROOM)
	(AFT TO RM-LADDER-D1)
	(GLOBAL LG-WALL RM-COMPRESSOR-ROOM RM-LADDER-D1)
	(ACTION RT-RM-TRI-MIX-STORAGE)
>
 
<CONSTANT K-HISS-MSG
"	You hear a loud hissing coming from somewhere in the room.|">
 
<ROUTINE RT-RM-TRI-MIX-STORAGE ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL "	You ">
			<COND
				(<MC-CONTEXT? ,M-LOOK>
					<TELL "are in">
				)
				(T
					<TELL "enter">
				)
			>
			<TELL
" the tri-mix storage room. There are three huge steel tanks here, each
welded to a sturdy base that sits about an inch off the floor.  The tanks
look like giant beer kegs and this similarity is heightened by the k-valves
on the front that look like beer taps. Exits here lead fore and aft.|"
			>
			<RFALSE>
		)
		(<MC-CONTEXT? ,M-ENTERED>
			<COND
				(,GL-NITROGEN-LEAK?
					<TELL ,K-HISS-MSG>
				)
			>
		)
		(<MC-CONTEXT? ,M-BEG>
			<COND
				(<AND <VERB? LISTEN>
						<MC-PRSO? ,ROOMS>
						,GL-NITROGEN-LEAK?
					>
					<TELL ,K-HISS-MSG>
				)
			>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
<NEW-ADD-WORD "TANKS" NOUN <VOC "TANK"> ,PLURAL-FLAG>
 
<GLOBAL GL-NITROGEN-LEAK? <> <> BYTE>
 
<CONSTANT K-GAS-TANK-MSG
"	It is a huge cylinder that looks like a giant capsule. It is supported
by four legs that are welded to a steel base to provide stability. The base
is raised up off the floor by about an inch.|
	On the front of the tank is a k-valve that looks a little like a beer
tap.">
 
;"---------------------------------------------------------------------------"
; "NITROGEN STUFF"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-NITROGEN-TANK
	(LOC RM-TRI-MIX-STORAGE)
	(DESC "nitrogen tank")
	(FLAGS FL-NO-DESC FL-SURFACE FL-SEARCH)
	(SYNONYM TANK BASE)
	(ADJECTIVE NITROGEN STORAGE)
	(GENERIC RT-GN-TANK)
	(ACTION RT-TH-NITROGEN-TANK)
>
 
<ROUTINE RT-TH-NITROGEN-TANK ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? LISTEN>
			<COND
				(,GL-NITROGEN-LEAK?
					<TELL ,K-HISS-MSG>
				)
				(T
					<TELL "You don't hear anything unusual." CR>
				)
			>
		)
		(<VERB? EXAMINE>
			<COND
				(<NOUN-USED? ,TH-NITROGEN-TANK ,W?BASE>
					<TELL "The base is raised up off the floor by about an inch." CR>
				)
				(T
					<TELL ,K-GAS-TANK-MSG>
					<COND
						(,GL-NITROGEN-LEAK?
							<TELL " The hissing sound seems to be coming from here.">
						)
					>
					<CRLF>
				)
			>
		)
		(<VERB? LOOK-UNDER>
			<COND
				(<EQUAL? <GETP ,TH-NIT-STOPPER ,P?OWNER> ,TH-NITROGEN-TANK>
					<FSET ,TH-NIT-STOPPER ,FL-SEEN>
					<FCLEAR ,TH-NIT-STOPPER ,FL-INVISIBLE>
					<TELL
"	You lie down on the floor and peer under the base of the tank. Back out of
reach you see the steel gleam of the stopper. It must have rolled there after
working itself loose from the k-valve." CR
					>
				)
			>
		)
		(<VERB? REACH-UNDER>
			<COND
				(<EQUAL? <GETP ,TH-NIT-STOPPER ,P?OWNER> ,TH-NITROGEN-TANK>
					<COND
						(<MC-PRSI? ,TH-MAGNET>
							<RT-GET-STOPPER>
						)
						(<MC-PRSI? <> ,ROOMS ,TH-HANDS>
							<TELL "	You can't quite reach the stopper." CR>
						)
					>
				)
			>
		)
	>
>
 
<OBJECT TH-NIT-VALVE
	(LOC TH-NITROGEN-TANK)
	(DESC "nitrogen valve")
	(FLAGS FL-CONTAINER FL-NO-DESC FL-ON FL-OPEN FL-SEARCH)
	(SYNONYM VALVE K-VALVE)
	(ADJECTIVE NITROGEN K)
	(GENERIC RT-GN-VALVE)
	(ACTION RT-TH-NIT-VALVE)
>
 
; "TH-NIT-VALVE flags:"
; "	FL-ON = Valve is open. (Can't use FL-OPEN because it's a container.)"
 
<ROUTINE RT-TH-NIT-VALVE ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(,NOW-PRSI
			<COND
				(<VERB? PUT-IN ATTACH>
					<COND
						(<MC-PRSO? ,TH-NIT-STOPPER>
							<MOVE ,TH-NIT-STOPPER ,TH-NIT-VALVE>
							<TELL
"	You screw the stopper into the k-valve. The valve is still hissing." CR
							>
						)
					>
				)
			>
		)
		(<VERB? LISTEN>
			<COND
				(<NOT <IN? ,TH-NIT-STOPPER ,TH-NIT-VALVE>>
					<TELL ,K-HISS-MSG>
				)
				(T
					<TELL "	You don't hear anything unusual." CR>
				)
			>
		)
		(<VERB? EXAMINE>
			<TELL
"	The k-valve is a small device that controls the flow of the nitrogen."
			>
			<COND
				(<NOT <IN? ,TH-NIT-STOPPER ,TH-NIT-VALVE>>
					<TELL " The valve's stopper seems to be missing">
					<COND
						(,GL-NITROGEN-LEAK?
							<TELL
", and the hissing sound is definitely coming from here"
							>
						)
					>
				)
			>
			<TELL "." CR>
		)
		(<VERB? OPEN>
			<COND
				(<FSET? ,TH-NIT-VALVE ,FL-ON>
					<RT-ALREADY-MSG "open">
				)
				(<IN? ,TH-NIT-STOPPER ,TH-NIT-VALVE>
					<TELL
"	You decide not to open the valve, since that might cause problems." CR
					>
				)
				(T
					<TELL "	The stopper is missing, so the valve can't be opened." CR>
				)
			>
		)
		(<VERB? CLOSE>
			<COND
				(<NOT <FSET? ,TH-NIT-VALVE ,FL-ON>>
					<RT-ALREADY-MSG "closed">
				)
				(<IN? ,TH-NIT-STOPPER ,TH-NIT-VALVE>
					<FCLEAR ,TH-NIT-VALVE ,FL-ON>
					<SETG GL-NITROGEN-LEAK? <>>
					<RT-DEQUEUE ,RT-I-NITROGEN-LEAK>
					<TELL "	You close the k-valve. The hissing stops." CR>
				)
				(T
					<TELL "	The stopper is missing, so the valve can't be closed." CR>
				)
			>
		)
	>
>
 
<OBJECT TH-NIT-STOPPER
	(LOC RM-TRI-MIX-STORAGE)
	(DESC "nitrogen stopper")
	(FLAGS FL-INVISIBLE FL-NO-DESC FL-TAKEABLE)
	(SYNONYM STOPPER)
	(ADJECTIVE NITROGEN)
	(OWNER TH-NITROGEN-TANK)	;"Under nitrogen tank"
	(GENERIC RT-GN-STOPPER)
	(ACTION RT-TH-NIT-STOPPER)
>
 
; "Duane:  We need a place to put the stopper when it is under the base
of the Nitrogen Tank.  I'll leave it to you to figure that out."
 
<ROUTINE RT-TH-NIT-STOPPER ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
	;	(<AND <NOT <FSET? ,TH-NIT-STOPPER ,FL-SEEN>>
				<NOT <EVERYWHERE-VERB? <COND (,NOW-PRSI 2) (T 1)>>>
			>
			<NP-CANT-SEE>
		)
		(<VERB? TAKE>
			<COND
				(<EQUAL? <GETP ,TH-NIT-STOPPER ,P?OWNER> ,TH-NITROGEN-TANK>
					<TELL "	You can't quite reach the stopper." CR>
				)
			>
		)
		(<VERB? TAKE-WITH>
			<COND
				(<EQUAL? <GETP ,TH-NIT-STOPPER ,P?OWNER> ,TH-NITROGEN-TANK>
					<COND
						(<MC-PRSI? ,TH-MAGNET>
							<RT-GET-STOPPER>
						)
					>
				)
			>
		)
	>
>
 
<ROUTINE RT-GET-STOPPER ()
	<MOVE ,TH-NIT-STOPPER ,TH-MAGNET>
	<PUTP ,TH-NIT-STOPPER ,P?OWNER <>>
	<TELL
"	You slide the magnet under the base and hear a satisfying 'click.' When
you pull it out again, the stopper is stuck to the end." CR
	>
>
 
<GLOBAL GL-N-LOOP 0 <> BYTE>
 
<ROUTINE RT-I-NITROGEN-LEAK ()
	<COND
		(T	;<NOT <IGRTR? GL-N-LOOP 82>>
			<SETG GL-NITROGEN-LEAK? T>
			<RT-QUEUE ,RT-I-NITROGEN-LEAK <+ ,GL-MOVES 1>>
			<COND
				(<L? ,GL-NITROGEN-QTY ,K-NIT-HIGH-1>
					<SETG GL-NITROGEN-QTY ,K-NIT-HIGH-1>
				)
				(T
					<SETG GL-NITROGEN-QTY <+ ,GL-NITROGEN-QTY 47>>
				)
			>
			<RT-NITROGEN-MSG>
		)
	;	(T
			<SETG GL-NITROGEN-QTY ,K-NIT-NOM>
			<SETG GL-NITROGEN-LEAK? <>>
			<RFALSE>
		)
	>
>
 
;<OBJECT TH-NIT-BASE
	(LOC RM-TRI-MIX-STORAGE)
	(DESC "nitrogen tank base")
	(SYNONYM BASE)
	(ADJECTIVE NITROGEN TANK)
	(ACTION RT-TH-NIT-BASE)
>
 
<ROUTINE RT-TH-NIT-BASE ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
;"---------------------------------------------------------------------------"
; "TH-OXYGEN-TANK"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-OXYGEN-TANK
	(LOC RM-TRI-MIX-STORAGE)
	(DESC "oxygen tank")
	(FLAGS FL-NO-DESC FL-SURFACE FL-SEARCH)
	(SYNONYM TANK BASE)
	(ADJECTIVE OXYGEN STORAGE)
	(GENERIC RT-GN-TANK)
	(ACTION RT-TH-OXYGEN-TANK)
>
 
<ROUTINE RT-TH-OXYGEN-TANK ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE>
			<TELL ,K-GAS-TANK-MSG CR>
		)
	>
>
 
<OBJECT TH-OXY-VALVE
	(LOC TH-OXYGEN-TANK)
	(DESC "oxygen valve")
	(FLAGS FL-CONTAINER FL-NO-DESC FL-OPEN FL-SEARCH)
	(SYNONYM VALVE K-VALVE)
	(ADJECTIVE OXYGEN K)
	(GENERIC RT-GN-VALVE)
	(ACTION RT-TH-OXY-VALVE)
>
 
<ROUTINE RT-TH-OXY-VALVE ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
<OBJECT TH-OXY-STOPPER
	(LOC TH-OXY-VALVE)
	(DESC "oxygen stopper")
	(FLAGS FL-NO-DESC FL-TRY-TAKE)
	(SYNONYM STOPPER)
	(ADJECTIVE OXYGEN)
	(GENERIC RT-GN-STOPPER)
	(ACTION RT-TH-OXY-STOPPER)
>
 
<ROUTINE RT-TH-OXY-STOPPER ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
;<OBJECT TH-OXY-BASE
	(LOC RM-TRI-MIX-STORAGE)
	(DESC "oxygen tank base")
	(SYNONYM BASE)
	(ADJECTIVE OXYGEN TANK)
	(ACTION RT-TH-OXY-BASE)
>
 
<ROUTINE RT-TH-OXY-BASE ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
;"---------------------------------------------------------------------------"
; "TH-HELIUM-TANK"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-HELIUM-TANK
	(LOC RM-TRI-MIX-STORAGE)
	(DESC "helium tank")
	(FLAGS FL-NO-DESC FL-SURFACE FL-SEARCH)
	(SYNONYM TANK BASE)
	(ADJECTIVE HELIUM STORAGE)
	(GENERIC RT-GN-TANK)
	(ACTION RT-TH-HELIUM-TANK)
>
 
<ROUTINE RT-TH-HELIUM-TANK ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE>
			<TELL ,K-GAS-TANK-MSG CR>
		)
	>
>
 
<OBJECT TH-HEL-VALVE
	(LOC TH-HELIUM-TANK)
	(DESC "helium valve")
	(FLAGS FL-CONTAINER FL-NO-DESC FL-OPEN FL-SEARCH)
	(SYNONYM VALVE K-VALVE)
	(ADJECTIVE HELIUM K)
	(GENERIC RT-GN-VALVE)
	(ACTION RT-TH-HEL-VALVE)
>
 
<ROUTINE RT-TH-HEL-VALVE ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
<OBJECT TH-HEL-STOPPER
	(LOC TH-HEL-VALVE)
	(DESC "helium stopper")
	(FLAGS FL-NO-DESC FL-TRY-TAKE)
	(SYNONYM STOPPER)
	(ADJECTIVE HELIUM)
	(GENERIC RT-GN-STOPPER)
	(ACTION RT-TH-HEL-STOPPER)
>
 
<ROUTINE RT-TH-HEL-STOPPER ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
;<OBJECT TH-HEL-BASE
	(LOC RM-TRI-MIX-STORAGE)
	(DESC "helium tank base")
	(SYNONYM BASE)
	(ADJECTIVE HELIUM TANK)
	(ACTION RT-TH-HEL-BASE)
>
 
<ROUTINE RT-TH-HEL-BASE ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
<ROUTINE RT-GN-TANK (TBL FINDER "AUX" PTR N)
	<SET PTR <REST-TO-SLOT .TBL FIND-RES-OBJ1>>
	<SET N <FIND-RES-COUNT .TBL>>
	<COND
		(<INTBL? ,TH-NITROGEN-TANK .PTR .N>
			<TELL "[the nitrogen tank]|">
			<RETURN ,TH-NITROGEN-TANK>
		)
	>
>
 
<ROUTINE RT-GN-VALVE (TBL FINDER "AUX" PTR N)
	<SET PTR <REST-TO-SLOT .TBL FIND-RES-OBJ1>>
	<SET N <FIND-RES-COUNT .TBL>>
	<COND
		(<INTBL? ,TH-NIT-VALVE .PTR .N>
			<TELL "[the nitrogen k-valve]|">
			<RETURN ,TH-NIT-VALVE>
		)
	>
>
 
<ROUTINE RT-GN-STOPPER (TBL FINDER "AUX" PTR N)
	<SET PTR <REST-TO-SLOT .TBL FIND-RES-OBJ1>>
	<SET N <FIND-RES-COUNT .TBL>>
	<COND
		(<INTBL? ,TH-NIT-STOPPER .PTR .N>
			<TELL "[the nitrogen stopper]|">
			<RETURN ,TH-NIT-STOPPER>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-TOOL-ROOM"
;"---------------------------------------------------------------------------"
 
<ROOM RM-TOOL-ROOM
	(LOC ROOMS)
	(DESC "tool room")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM ROOM)
	(ADJECTIVE TOOL)
	(STARBOARD TO RM-DRILL-ROOM)
	(PORT TO RM-TOOL-PUSHER-OFFICE)
	(GLOBAL LG-WALL RM-DRILL-ROOM RM-TOOL-PUSHER-OFFICE)
	(ACTION RT-RM-TOOL-ROOM)
>
 
<ROUTINE RT-RM-TOOL-ROOM ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL "	You ">
			<COND
				(<MC-CONTEXT? ,M-LOOK>
					<TELL "are in">
				)
				(T
					<TELL "enter">
				)
			>
			<TELL
" the tool room, which lies between your office on the port side and the
drill room to starboard. Bins here contain the various specialized tools
of your trade.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "TH-BIN"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-BIN
	(LOC RM-TOOL-ROOM)
	(DESC "bin")
	(SYNONYM BIN BINS)
	(FLAGS FL-CONTAINER FL-NO-DESC FL-OPENABLE FL-SEARCH)
	(SIZE 5 CAPACITY 5)
	(ACTION RT-TH-BIN)
>
 
<ROUTINE RT-TH-BIN ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
;"---------------------------------------------------------------------------"
; "TH-MAGNET"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-MAGNET
	(LOC TH-BIN)
	(DESC "probe")
	(FLAGS FL-SURFACE FL-SEARCH FL-TAKEABLE)
	(SYNONYM MAGNET PROBE)
	(ADJECTIVE MAGNETIC)
	(ACTION RT-TH-MAGNET)
>
 
<ROUTINE RT-TH-MAGNET ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
 
 
;"---------------------------------------------------------------------------"
; "DELETED RUSSIAN STUFF"
;"---------------------------------------------------------------------------"
 
;<OBJECT CH-RUSSIAN
	(LOC RM-TRI-MIX-STORAGE)
	(DESC "Russian")
	(FLAGS FL-ALIVE FL-OPEN FL-PERSON FL-SEARCH)
	(SYNONYM RUSSIAN INTRUDER SABOTEUR DIVER BOY MAN PERSON)
	(ADJECTIVE RUSSIAN NAVY)
>
 
;<GLOBAL GL-RUSSIAN-CNT 0 <> BYTE>
 
;<ROUTINE RT-I-RUSSIAN ("AUX" L (RM <>))
	<SET L <LOC ,CH-RUSSIAN>>
	<COND
		(<EQUAL? .L ,RM-LADDER-A2>
			<SET RM ,RM-CORRIDOR>
		)
		(<EQUAL? .L ,RM-CORRIDOR>
			<SET RM ,RM-SUB-BAY>
			<SETG GL-RUSSIAN-CNT 0>
		)
		(<EQUAL? .L ,RM-SUB-BAY>
			<COND
				(<IGRTR? GL-RUSSIAN-CNT 1>
					<REMOVE ,CH-RUSSIAN>
					<COND
						(<MC-HERE? .L>
						)
					>
				)
			>
		)
		(<EQUAL? .L ,RM-LADDER-A1 ,RM-LADDER-A3>
			<SET RM ,RM-LADDER-A2>
		)
		(<EQUAL? .L ,RM-LADDER-D1 ,RM-LADDER-D3>
			<SET RM ,RM-LADDER-D2>
		)
		(T
			<SET RM <RT-FIND-ROOM ,P?FORE .L>>
		)
	>
	<COND
		(.RM
			<RT-QUEUE ,RT-I-RUSSIAN <+ ,GL-MOVES 1>>
			<COND
				(<SET P <FIND-FLAG .RM ,FL-PERSON>>
					<COND
						(<EQUAL? .P ,CH-PLAYER>
							<TELL
"Suddenly, a stranger in a black dry-suit comes into the room. Before you can
react, he blurts out an exclamation in what sounds like Russian, and then he
whirls and runs back the way he came. As he turns, you notice the glint of a
shiny metal object in his hand." CR
							>
						)
						(T
						;	<TELL
							>
						)
					>
				)
				(T
					<MOVE ,CH-RUSSIAN .RM>
					<RFALSE>
				)
			>
		)
	>
>
