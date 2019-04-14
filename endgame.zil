;"***************************************************************************"
; "game : Abyss"
; "file : ENDGAME.ZIL"
; "auth :   $Author:   DEB  $"
; "date :     $Date:   20 Mar 1989  8:45:00  $"
; "rev  : $Revision:   1.3  $"
; "vers : 1.0"
;"---------------------------------------------------------------------------"
; "Crane crash"
; "Copyright (C) 1988 Infocom, Inc.  All rights reserved."
;"***************************************************************************"
 
;"---------------------------------------------------------------------------"
; "TH-WINDOW-BENCH"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-WINDOW-BENCH
	(LOC RM-COMPRESSION-CHAMBER)
	(DESC "bench")
	(FLAGS FL-CONTAINER FL-OPENABLE FL-SEARCH)
	(SYNONYM BENCH SEAT)
	(ADJECTIVE WINDOW)
	(ACTION RT-TH-WINDOW-BENCH)
>
 
<ROUTINE RT-TH-WINDOW-BENCH ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? LIFT OPEN>
			<FSET ,TH-WINDOW-BENCH ,FL-OPEN>
			<TELL "	You lift the seat to reveal the red lever underneath." CR>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "TH-RED-LEVER"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-RED-LEVER
	(LOC TH-WINDOW-BENCH)
	(DESC "lever")
	(SYNONYM LEVER)
	(ADJECTIVE RED)
	(ACTION RT-TH-RED-LEVER)
>
 
<ROUTINE RT-TH-RED-LEVER ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? PULL>
			<COND
				(<AND <NOT <FSET? ,LG-CHAMBER-DOOR ,FL-OPEN>>
						<FSET? ,CH-ALIEN ,FL-BROKEN>
					>
					<TELL
"	You pull the lever and feel an immediate jolt as the compression chamber
pulls away from Deepcore. Through the porthole, you get a glimpse of
the crippled Deepcore as you slowly rise through the water.||
 
	[GRAPHIC #22]||
 
	For a long time after that you have no sensation of motion, but then the
water through the porthole starts to get lighter as you near the surface.|
	Suddenly chamber burst through the surface and sunlight floods through
the porthole. You feel the motion of the waves for the first time in weeks
as the chamber gently rises and falls. Through the porthole you see the
Benthic Explorer steaming towards you.|
	Trumpets sound. Fair young maidens cluster round to look at you admiringly.
You have won the game." CR
					>
					<RT-END-OF-GAME T>
				)
				(T
					<TELL "	Nothing happens." CR>
				)
			>
		)
		(<VERB? EXAMINE>
			<TELL "It looks an awful lot like a red lever." CR>
		)
	>
>
 
;"***************************************************************************"
; "end of file"
;"***************************************************************************"
 
