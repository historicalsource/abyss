;"***************************************************************************"
; "game : Abyss"
; "file : RETURN2.ZIL"
; "auth :   $Author:   DEB  $"
; "date :     $Date:   20 Mar 1989  8:44:38  $"
; "rev  : $Revision:   1.2  $"
; "vers : 1.0"
;"---------------------------------------------------------------------------"
; "Second return to Deepcore"
; "Copyright (C) 1988 Infocom, Inc.  All rights reserved."
;"***************************************************************************"
 
<GLOBAL GL-RETURN2-DONE? <> <> BYTE>
<GLOBAL GL-COFFEY-SHOOT 0 <> BYTE>
 
<OBJECT TH-GUN
	(LOC CH-COFFEY)
	(DESC "gun")
	(FLAGS FL-TAKEABLE)
	(SYNONYM GUN PISTOL)
	(OWNER CH-COFFEY)
	(SIZE 5)
	(ACTION RT-TH-GUN)
>
 
<ROUTINE RT-TH-GUN ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
<OBJECT TH-FBS-SUIT
	(LOC TH-DIVE-LOCKER)
	(DESC "FBS suit")
	(FLAGS FL-CLOTHING FL-TAKEABLE)
	(SYNONYM SUIT)
	(ADJECTIVE FBS FLUID BREATHING SYSTEM)
	(SIZE 5)
	(ACTION RT-TH-FBS-SUIT)
>
 
<ROUTINE RT-TH-FBS-SUIT ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
<OBJECT TH-DIVE-LOCKER
	(LOC RM-SUB-BAY)
	(DESC "dive locker")
	(FLAGS FL-CONTAINER FL-LOCKED FL-OPENABLE FL-SEARCH FL-TRY-TAKE)
	(SYNONYM LOCKER)
	(ADJECTIVE DIVE)
	(SIZE 5)
	(ACTION RT-TH-DIVE-LOCKER)
>
 
<ROUTINE RT-TH-DIVE-LOCKER ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? TAKE MOVE PUSH PULL LIFT>
			<TELL "	The dive locker is securely anchored to the floor." CR>
		)
	>
>
 
<OBJECT TH-ELECTRONIC-LOCK
	(LOC TH-DIVE-LOCKER)
	(DESC "lock")
	(SYNONYM LOCK)
	(ADJECTIVE ELECTRONIC)
	(SIZE 5)
	(ACTION RT-TH-ELECTRONIC-LOCK)
>
 
<ROUTINE RT-TH-ELECTRONIC-LOCK ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
<OBJECT TH-DEVICE
	(LOC CH-HIPPY)
	(DESC "device")
	(SYNONYM DEVICE)
	(ADJECTIVE REMOTE ELECTRONIC)
	(OWNER CH-HIPPY)
	(SIZE 5)
	(ACTION RT-TH-DEVICE)
>
 
<ROUTINE RT-TH-DEVICE ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
; "Cheat verb for causing narcosis for Coffey."
<SYNTAX $NITROGEN = V-$NITROGEN>
<ROUTINE V-$NITROGEN ()
	<COND
		(<MC-HERE? ,RM-GAS-MIX-ROOM>
			<COND
				(<FSET? ,LG-CHAMBER-DOOR ,FL-OPEN>
					<TELL "[The compression chamber door must be closed.]|">
					<RFATAL>
				)
				(T
					<COND
						(<ZERO? ,GL-WIRE-SEQUENCE>
							<SETG GL-WIRE-SEQUENCE <RANDOM 4>>
						)
					>
					<TELL
"	Coffey begins to babble incoherently. You can hear him say, \""
					>
					<COND
						(<EQUAL? ,GL-WIRE-SEQUENCE 1>
							<TELL "Oxford rows great big wide yachts.\"" CR>
						)
						(<EQUAL? ,GL-WIRE-SEQUENCE 2>
							<TELL "Yankees rarely win over Green Bay.\"" CR>
						)
						(<EQUAL? ,GL-WIRE-SEQUENCE 3>
							<TELL "Get rid of your wet bananas.\"" CR>
						)
						(<EQUAL? ,GL-WIRE-SEQUENCE 4>
							<TELL "Go west, young boy, or rot.\"" CR>
						)
					>
				)
			>
		)
		(T
			<TELL "[You must be in the gas mix room to use $NITROGEN.]|">
			<RFATAL>
		)
	>
>
 
;"***************************************************************************"
; "end of file"
;"***************************************************************************"
 
