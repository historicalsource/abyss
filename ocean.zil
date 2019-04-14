;"***************************************************************************"
; "game : Abyss"
; "file : OCEAN.ZIL"
; "auth :   $Author:   DEB  $"
; "date :     $Date:   20 Mar 1989  8:45:12  $"
; "rev  : $Revision:   1.7  $"
; "vers : 1.0"
;"---------------------------------------------------------------------------"
; "Ocean floor"
; "Copyright (C) 1988 Infocom, Inc.  All rights reserved."
;"***************************************************************************"
 
;"---------------------------------------------------------------------------"
; "RM-UNDER-MOONPOOL"
;"---------------------------------------------------------------------------"
 
<ROOM RM-UNDER-MOONPOOL
	(LOC ROOMS)
	(DESC "under moonpool")
	(FLAGS FL-LIGHTED FL-SURFACE FL-WATER)
;	(SYNONYM MOONPOOL)
;	(ADJECTIVE UNDER)
	(UP TO RM-SUB-BAY)
	(IN TO RM-SUB-BAY)
	(NORTH TO RM-OCEAN-NORTH)
	(WEST TO RM-OCEAN-WEST)
	(SOUTH TO RM-OCEAN-SOUTH)
	(GLOBAL TH-MOON-POOL LG-DEEPCORE RM-SUB-BAY)
	(ACTION RT-RM-UNDER-MOONPOOL)
>
 
<ROUTINE RT-RM-UNDER-MOONPOOL ("OPT" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL TAB "You ">
			<COND
				(<MC-CONTEXT? ,M-LOOK>
					<TELL "are">
				)
				(T
					<TELL "arrive">
				)
			>
			<TELL " under the moonpool.|">
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-OCEAN-NORTH"
;"---------------------------------------------------------------------------"
 
<ROOM RM-OCEAN-NORTH
	(LOC ROOMS)
	(DESC "ocean floor")
	(FLAGS FL-LIGHTED FL-SURFACE FL-WATER)
	(SYNONYM FLOOR OCEAN)
	(ADJECTIVE OCEAN)
	(SOUTH TO RM-UNDER-MOONPOOL)
	(GLOBAL LG-DEEPCORE)
	(ACTION RT-RM-OCEAN-NORTH)
>
 
<ROUTINE RT-RM-OCEAN-NORTH ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL TAB "You ">
			<COND
				(<MC-CONTEXT? ,M-LOOK>
					<TELL "are on">
				)
				(T
					<TELL "proceed along">
				)
			>
			<TELL " the ocean floor. Deepcore is to the south.|">
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-OCEAN-SOUTH"
;"---------------------------------------------------------------------------"
 
<ROOM RM-OCEAN-SOUTH
	(LOC ROOMS)
	(DESC "ocean floor")
	(FLAGS FL-LIGHTED FL-SURFACE FL-WATER)
	(SYNONYM FLOOR OCEAN)
	(ADJECTIVE OCEAN)
	(NORTH TO RM-UNDER-MOONPOOL)
	(GLOBAL LG-DEEPCORE)
	(ACTION RT-RM-OCEAN-SOUTH)
>
 
<ROUTINE RT-RM-OCEAN-SOUTH ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL TAB "You ">
			<COND
				(<MC-CONTEXT? ,M-LOOK>
					<TELL "are on">
				)
				(T
					<TELL "proceed along">
				)
			>
			<TELL " the ocean floor. Deepcore is to the north.|">
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-OCEAN-WEST"
;"---------------------------------------------------------------------------"
 
<ROOM RM-OCEAN-WEST
	(LOC ROOMS)
	(DESC "ocean floor")
	(FLAGS FL-LIGHTED FL-SURFACE FL-WATER)
	(SYNONYM FLOOR OCEAN)
	(ADJECTIVE OCEAN)
	(EAST TO RM-UNDER-MOONPOOL)
	(WEST PER RT-SWIM-TO-FROM-TRENCH)
	(GLOBAL LG-DEEPCORE)
	(ACTION RT-RM-OCEAN-WEST)
>
 
<ROUTINE RT-RM-OCEAN-WEST ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL TAB "You ">
			<COND
				(<MC-CONTEXT? ,M-LOOK>
					<TELL "are on">
				)
				(T
					<TELL "proceed along">
				)
			>
			<TELL
" the ocean floor. Looking east, you see Deepcore, an island of light
in the vast blackness.  The crane, now only a mass of twisted metal, hangs
crookedly off the starboard cylinders.|"
			>
			<RFALSE>
		)
		(<MC-CONTEXT? ,M-BEG>
			<COND
				(<AND <VERB? WALK-TO>
						<MC-PRSO? ,LG-MONTANA>
					>
					<RT-DO-WALK ,P?WEST>
				)
			>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
<ROUTINE RT-SWIM-TO-FROM-TRENCH ("OPT" (QUIET <>) "AUX" N)
	<COND
		(<NOT .QUIET>
			<TELL
TAB "You swim along the ocean floor, pausing every few moments to take your
bearings and consult your compass.|"
			>
			<SETG GL-MOVES <+ ,GL-MOVES 43>>	; "44 moves (22 min) minus one"
			<CLOCKER>
		)
	>
	<COND
		(<MC-HERE? ,RM-OCEAN-WEST>
			<RETURN ,RM-TROUGH-LIP>
		)
		(T
			<RETURN ,RM-OCEAN-WEST>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-TROUGH-LIP"
;"---------------------------------------------------------------------------"
 
<ROOM RM-TROUGH-LIP
	(LOC ROOMS)
	(DESC "trough lip")
	(FLAGS FL-LIGHTED FL-WATER)
	(SYNONYM LIP)
	(ADJECTIVE TROUGH)
	(DOWN TO RM-MIDSHIP-HATCH)
	(WEST TO RM-MIDSHIP-HATCH)
	(EAST PER RT-SWIM-TO-FROM-TRENCH)
	(GLOBAL LG-TROUGH LG-MONTANA LG-DEEPCORE)
	(ACTION RT-RM-TROUGH-LIP)
>
 
<ROUTINE RT-RM-TROUGH-LIP ("OPTIONAL" (CONTEXT <>) "AUX" N)
	<COND
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL TAB>
			<COND
				(<MC-CONTEXT? ,M-LOOK>
					<TELL "You are at">
				)
				(<EQUAL? ,OHERE ,RM-OCEAN-WEST>
					<TELL
"Eventually, you come to the jagged edge of a chasm that extends to the north
and south. Looking down, you see the murky outline of the Montana, perched on
a ledge below you.|"
					>
					<RFALSE>
				)
				(T
					<TELL "You come to">
				)
			>
			<TELL
" the lip of the Cayman trough. Just below, you can see the Montana. Deepcore
lies east of here.|"
			>
			<RFALSE>
		)
		(<MC-CONTEXT? ,M-ENTERED>
			<COND
				(<EQUAL? ,OHERE ,RM-OCEAN-WEST>
					<TELL
TAB "Automatically, you glance at your watch. The journey over from Deepcore
took about twenty two minutes and you have"
					>
					<SET N </ <- ,GL-PLAYER-TEMP ,K-TEMP-LOW-4> 20>>
					<TELL wn .N>
					<TELL " minute">
					<COND
						(<NOT <EQUAL? .N 1>>
							<TELL "s">
						)
					>
					<TELL
" left before hypothermia sets in. A quick calculation reveals that you have "
					>
					<SET N <- .N 22>>
					<COND
						(<L? .N 0>
							<TELL "insufficient time to make it back to Deepcore.|">
						)
						(T
							<COND
								(<ZERO? .N>
									<TELL "no time">
								)
								(T
									<TELL "only" wn .N " minute">
									<COND
										(<NOT <EQUAL? .N 1>>
											<TELL "s">
										)
									>
								)
							>
							<TELL " to explore the Montana before you must start back.|">
						)
					>
				)
			>
		)
		(<MC-CONTEXT? ,M-BEG>
			<COND
				(<AND <VERB? WALK-TO>
						<MC-PRSO? ,LG-DEEPCORE>
					>
					<RT-DO-WALK ,P?EAST>
				)
			>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"***************************************************************************"
; "end of file"
;"***************************************************************************"
 
