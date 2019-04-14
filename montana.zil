;"***************************************************************************"
; "game : Abyss"
; "file : MONTANA.ZIL"
; "auth :   $Author:   DEB  $"
; "date :     $Date:   20 Mar 1989  8:45:22  $"
; "rev  : $Revision:   1.12  $"
; "vers : 1.0"
;"---------------------------------------------------------------------------"
; "U.S.S. Montana"
; "Copyright (C) 1988 Infocom, Inc.  All rights reserved."
;"***************************************************************************"
 
;"---------------------------------------------------------------------------"
; "RM-MIDSHIP-HATCH"
;"---------------------------------------------------------------------------"
 
<ROOM RM-MIDSHIP-HATCH
	(LOC ROOMS)
	(DESC "midship hatch")
	(FLAGS FL-LIGHTED FL-WATER)
;	(SYNONYM )
;	(ADJECTIVE )
	(UP TO RM-TROUGH-LIP)
	(EAST TO RM-TROUGH-LIP)
	(FORE TO RM-MISSILE-HATCH)
	(NORTH TO RM-MISSILE-HATCH)
	(WEST TO RM-ATTACK-CENTER IF LG-MIDSHIP-HATCH IS OPEN)
	(IN TO RM-ATTACK-CENTER IF LG-MIDSHIP-HATCH IS OPEN)
	(DOWN PER RT-TO-TRENCH-BOTTOM)
	(GLOBAL LG-MIDSHIP-HATCH LG-MONTANA LG-TROUGH RM-ATTACK-CENTER)
	(ACTION RT-RM-MIDSHIP-HATCH)
>
 
<ROUTINE RT-RM-MIDSHIP-HATCH ("OPTIONAL" (CONTEXT <>))
	<COND
	;	(<MC-CONTEXT? ,M-F-LOOK>
		)
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL "	You ">
			<COND
				(<MC-CONTEXT? ,M-LOOK>
					<TELL "are at">
				)
				(T
					<TELL "come to">
				)
			>
			<TELL
" the midship hatch of the Montana. The trough wall rises sharply to the east
and the missile hatch is to the fore. Through the hatch is the attack center.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
<OBJECT LG-MIDSHIP-HATCH
	(LOC LOCAL-GLOBALS)
	(DESC "midship hatch")
	(FLAGS FL-DOOR)
	(SYNONYM HATCH)
	(ADJECTIVE MIDSHIP)
	(ACTION RT-LG-MIDSHIP-HATCH)
>
 
<ROUTINE RT-LG-MIDSHIP-HATCH ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE>
			<TELL
"	The hatch is a heavy, circular lid with a handle in the middle. Because
the sub is resting on its side, the hinges are at the top." CR
			>
		)
		(<VERB? OPEN>
			<COND
				(<FSET? ,LG-MIDSHIP-HATCH ,FL-OPEN>
					<RT-ALREADY-MSG ,PRSO "open">
				)
				(T
					<TELL
"	You grab the handle and try to lift the hatch, but only succeed in
pushing yourself down in the water." CR
					>
				)
			>
		)
		(<VERB? CLOSE>
			<COND
				(<NOT <FSET? ,LG-MIDSHIP-HATCH ,FL-OPEN>>
					<RT-ALREADY-MSG ,PRSO "closed">
				)
				(T
					<TELL
"	You can't close the hatch against the buoyancy of the lift bag." CR
					>
				)
			>
		)
	>
>
 
<ROUTINE RT-TO-TRENCH-BOTTOM ("AUX" (QUIET <>))
	<COND
		(.QUIET
			<RETURN ,RM-TRENCH-BOTTOM>
		)
		(<OR	<NOT <IN? ,TH-FBS-SUIT ,CH-PLAYER>>
				<NOT <FSET? ,TH-FBS-SUIT ,FL-WORN>>
			>
			<TELL "	You can't go down that deep with a regular dry suit.|">
			<RFALSE>
		)
		(T
			<RETURN ,RM-TRENCH-BOTTOM>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-MISSILE-HATCH"
;"---------------------------------------------------------------------------"
 
<ROOM RM-MISSILE-HATCH
	(LOC ROOMS)
	(DESC "missile hatch")
	(FLAGS FL-LIGHTED FL-WATER)
	(SYNONYM HATCH)
	(ADJECTIVE MISSILE)
	(FORE TO RM-BOW)
	(AFT TO RM-MIDSHIP-HATCH)
	(GLOBAL ;LG-MISSILE-HATCH LG-MONTANA LG-TROUGH RM-MISSILE-ROOM)
	(ACTION RT-RM-MISSILE-HATCH)
>
 
<ROUTINE RT-RM-MISSILE-HATCH ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL "	You ">
			<COND
				(<MC-CONTEXT? ,M-LOOK>
					<TELL "are at">
				)
				(T
					<TELL "come to">
				)
			>
			<TELL
" the missile hatch of the Montana. To the aft is the midship hatch, and the
bow lies foreward.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;<OBJECT LG-MISSILE-HATCH
	(LOC LOCAL-GLOBALS)
	(DESC "missile hatch")
	(FLAGS FL-DOOR FL-OPENABLE)
	(SYNONYM HATCH)
	(ADJECTIVE MISSILE)
>
 
<OBJECT TH-MISSILE
	(LOC RM-MISSILE-HATCH)
	(DESC "missile")
	(FLAGS FL-NO-DESC FL-SURFACE FL-SEARCH)
	(SYNONYM MISSILE)
	(ACTION RT-TH-MISSILE)
>
 
<ROUTINE RT-TH-MISSILE ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
<OBJECT TH-MISSILE-TIMER
	(LOC TH-MISSILE)
	(DESC "timer")
	(FLAGS FL-NO-DESC)
	(SYNONYM TIMER)
	(ADJECTIVE MISSILE)
	(ACTION RT-TH-MISSILE-TIMER)
>
 
<ROUTINE RT-TH-MISSILE-TIMER ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
<OBJECT TH-MISSILE-PANEL
	(LOC TH-MISSILE)
	(DESC "access panel")
	(FLAGS FL-CONTAINER FL-LOCKED FL-OPENABLE FL-SEARCH)
	(SYNONYM PANEL HATCH PLATE)
	(ADJECTIVE MISSILE ACCESS COVER)
	(ACTION RT-TH-MISSILE-PANEL)
>
 
<ROUTINE RT-TH-MISSILE-PANEL ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
<NEW-ADD-WORD "WIRES" NOUN <VOC "WIRE"> ,PLURAL-FLAG>
 
<GLOBAL GL-WIRE-SEQUENCE 0 <> BYTE>
<GLOBAL GL-WIRES-CUT 0>
 
<OBJECT TH-WIRES
	(LOC TH-MISSILE-PANEL)
	(DESC "wires")
	(FLAGS FL-NO-DESC)
	(SYNONYM WIRES)
	(ACTION RT-TH-WIRES)
>
 
<ROUTINE RT-TH-WIRES ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE>
			<TELL
"	The wires are red, green, orange, yellow, blue, and white." CR
			>
		)
		(<VERB? CUT>
			<TELL "[You must specify which wire you want to cut.]|">
			<RFATAL>
		)
	>
>
 
<OBJECT TH-RED-WIRE
	(LOC TH-MISSILE-PANEL)
	(DESC "red wire")
	(SYNONYM WIRE)
	(ADJECTIVE RED)
	(ACTION RT-TH-WIRE)
>
 
<OBJECT TH-BLUE-WIRE
	(LOC TH-MISSILE-PANEL)
	(DESC "blue wire")
	(SYNONYM WIRE)
	(ADJECTIVE BLUE)
	(ACTION RT-TH-WIRE)
>
 
<OBJECT TH-GREEN-WIRE
	(LOC TH-MISSILE-PANEL)
	(DESC "green wire")
	(SYNONYM WIRE)
	(ADJECTIVE GREEN)
	(ACTION RT-TH-WIRE)
>
 
<OBJECT TH-YELLOW-WIRE
	(LOC TH-MISSILE-PANEL)
	(DESC "yellow wire")
	(SYNONYM WIRE)
	(ADJECTIVE YELLOW)
	(ACTION RT-TH-WIRE)
>
 
<OBJECT TH-ORANGE-WIRE
	(LOC TH-MISSILE-PANEL)
	(DESC "orange wire")
	(SYNONYM WIRE)
	(ADJECTIVE ORANGE)
	(ACTION RT-TH-WIRE)
>
 
<OBJECT TH-WHITE-WIRE
	(LOC TH-MISSILE-PANEL)
	(DESC "white wire")
	(SYNONYM WIRE)
	(ADJECTIVE WHITE)
	(ACTION RT-TH-WIRE)
>
 
<ROUTINE RT-TH-WIRE ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? CUT>
			<COND
				(<MC-PRSI? ,TH-KNIFE>
					<TELL
"The wires are too close together to get the large blade of your knife
between them." CR
					>
				)
				(<MC-PRSI? ,TH-WIRE-CUTTERS>
					<COND
						(<FSET? ,PRSO ,FL-BROKEN>
							<RT-ALREADY-MSG "cut">
						)
						(<RT-CORRECT-WIRE? ,PRSO>
							<FSET ,PRSO ,FL-BROKEN>
							<SETG GL-WIRES-CUT <+ ,GL-WIRES-CUT 1>>
							<COND
								(<EQUAL? ,GL-WIRES-CUT 6>
									<SETG GL-FALLING-INTO-TRENCH? T>
									<RT-QUEUE ,RT-I-INTO-TRENCH-1 <+ ,GL-MOVES 1>>
									<TELL
"	You hold your breath and cut the last wire. Nothing happens. Lindsey
smiles at you and gives you a big thumbs up.|
	Lindsey pats you on the back and then starts to climb back into the Cab.
The sudden imbalance makes it wobble precariously. Suddenly you realize that
it is slipping off the curved side of the sub! Desperately, you make a lunge
for the hatch to try to scramble inside, but it's too late. The Cab is
falling into the trench, and you are going to be dragged along with it." CR
									>
								)
								(T
									<TELL "	You cut" the ,PRSO "." CR>
								)
							>
						)
						(T
							<TELL
"	The explosion is so instantaneous and so massive that you have no
sensation of dying. You simply cease to be.|"
							>
							<RT-END-OF-GAME>
						)
					>
				)
			>
		)
	>
>
 
; "1 - orange, red, green, blue, white, yellow."
; "2 - yellow, red, white, orange, green, blue."
; "3 - green, red, orange, yellow, white, blue."
; "4 - green, white, yellow, blue, orange, red."
 
<ROUTINE RT-CORRECT-WIRE? (WIRE)
	<COND
		(<ZERO? ,GL-WIRE-SEQUENCE>
			<RFALSE>
		)
		(<MC-PRSO? ,TH-RED-WIRE>
			<COND
				(<EQUAL? ,GL-WIRE-SEQUENCE 1 4>
					<COND
						(<FSET? ,TH-ORANGE-WIRE ,FL-BROKEN>
							<RTRUE>
						)
					>
				)
				(<EQUAL? ,GL-WIRE-SEQUENCE 2>
					<COND
						(<FSET? ,TH-YELLOW-WIRE ,FL-BROKEN>
							<RTRUE>
						)
					>
				)
				(<EQUAL? ,GL-WIRE-SEQUENCE 3>
					<COND
						(<FSET? ,TH-GREEN-WIRE ,FL-BROKEN>
							<RTRUE>
						)
					>
				)
			>
		)
		(<MC-PRSO? ,TH-BLUE-WIRE>
			<COND
				(<EQUAL? ,GL-WIRE-SEQUENCE 1 2>
					<COND
						(<FSET? ,TH-GREEN-WIRE ,FL-BROKEN>
							<RTRUE>
						)
					>
				)
				(<EQUAL? ,GL-WIRE-SEQUENCE 3>
					<COND
						(<FSET? ,TH-WHITE-WIRE ,FL-BROKEN>
							<RTRUE>
						)
					>
				)
				(<EQUAL? ,GL-WIRE-SEQUENCE 4>
					<COND
						(<FSET? ,TH-YELLOW-WIRE ,FL-BROKEN>
							<RTRUE>
						)
					>
				)
			>
		)
		(<MC-PRSO? ,TH-GREEN-WIRE>
			<COND
				(<EQUAL? ,GL-WIRE-SEQUENCE 1>
					<COND
						(<FSET? ,TH-RED-WIRE ,FL-BROKEN>
							<RTRUE>
						)
					>
				)
				(<EQUAL? ,GL-WIRE-SEQUENCE 2>
					<COND
						(<FSET? ,TH-ORANGE-WIRE ,FL-BROKEN>
							<RTRUE>
						)
					>
				)
				(T
					<RTRUE>
				)
			>
		)
		(<MC-PRSO? ,TH-YELLOW-WIRE>
			<COND
				(<EQUAL? ,GL-WIRE-SEQUENCE 1 4>
					<COND
						(<FSET? ,TH-WHITE-WIRE ,FL-BROKEN>
							<RTRUE>
						)
					>
				)
				(<EQUAL? ,GL-WIRE-SEQUENCE 2>
					<RTRUE>
				)
				(<EQUAL? ,GL-WIRE-SEQUENCE 3>
					<COND
						(<FSET? ,TH-ORANGE-WIRE ,FL-BROKEN>
							<RTRUE>
						)
					>
				)
			>
		)
		(<MC-PRSO? ,TH-ORANGE-WIRE>
			<COND
				(<EQUAL? ,GL-WIRE-SEQUENCE 1>
					<RTRUE>
				)
				(<EQUAL? ,GL-WIRE-SEQUENCE 2>
					<COND
						(<FSET? ,TH-WHITE-WIRE ,FL-BROKEN>
							<RTRUE>
						)
					>
				)
				(<EQUAL? ,GL-WIRE-SEQUENCE 3>
					<COND
						(<FSET? ,TH-RED-WIRE ,FL-BROKEN>
							<RTRUE>
						)
					>
				)
				(<EQUAL? ,GL-WIRE-SEQUENCE 4>
					<COND
						(<FSET? ,TH-BLUE-WIRE ,FL-BROKEN>
							<RTRUE>
						)
					>
				)
			>
		)
		(<MC-PRSO? ,TH-WHITE-WIRE>
			<COND
				(<EQUAL? ,GL-WIRE-SEQUENCE 1>
					<COND
						(<FSET? ,TH-BLUE-WIRE ,FL-BROKEN>
							<RTRUE>
						)
					>
				)
				(<EQUAL? ,GL-WIRE-SEQUENCE 2>
					<COND
						(<FSET? ,TH-RED-WIRE ,FL-BROKEN>
							<RTRUE>
						)
					>
				)
				(<EQUAL? ,GL-WIRE-SEQUENCE 3>
					<COND
						(<FSET? ,TH-YELLOW-WIRE ,FL-BROKEN>
							<RTRUE>
						)
					>
				)
				(<EQUAL? ,GL-WIRE-SEQUENCE 4>
					<COND
						(<FSET? ,TH-GREEN-WIRE ,FL-BROKEN>
							<RTRUE>
						)
					>
				)
			>
		)
	>
>
 
<OBJECT TH-WIRE-CUTTERS
	(LOC TH-ELEC-SHOP-DRAWER)
	(DESC "wire cutters")
	(FLAGS FL-TAKEABLE FL-KNIFE)
	(SYNONYM CUTTERS)
	(ADJECTIVE WIRE)
	(ACTION RT-TH-WIRE-CUTTERS)
>
 
<ROUTINE RT-TH-WIRE-CUTTERS ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
<GLOBAL GL-FALLING-INTO-TRENCH? <> <> BYTE>
 
<ROUTINE RT-I-INTO-TRENCH-1 ()
	<RT-QUEUE ,RT-I-INTO-TRENCH-2 <+ ,GL-MOVES 1>>
	<TELL
"	The hookah line goes taut and drags you down after the sub. A quick glance
to your right reveals that Lindsey's hookah has caught on the Cab's open
hatch and she is being dragged down too. Your chest begins to tighten under
the additional pressure. If you don't do something quickly, you will die." CR
	>
>
 
<ROUTINE RT-I-INTO-TRENCH-2 ()
	<TELL
"	The cab pulls you deeper and deeper. Suddenly you feel a massive pain in
your chest and you black out. The last thing you see before dying is
Lindsey's hand reaching toward you for help.|"
	>
	<RT-END-OF-GAME>
>
 
<ROUTINE RT-I-OUT-OF-AIR-1 ()
	<RT-QUEUE ,RT-I-OUT-OF-AIR-2 <+ ,GL-MOVES 1>>
	<TELL "	You can't hold your breath much longer." CR>
>
 
<ROUTINE RT-I-OUT-OF-AIR-2 ()
	<MOVE ,CH-PLAYER ,RM-SUB-BAY>
	<MOVE ,TH-DRY-SUIT ,RM-SUB-BAY>
	<FCLEAR ,TH-DRY-SUIT ,FL-WORN>
	<FCLEAR ,TH-DIVE-LOCKER ,FL-LOCKED>
	<FSET ,TH-DIVE-LOCKER ,FL-OPEN>
	<MOVE ,CH-HIPPY ,RM-SUB-BAY>
	<MOVE ,CH-CATFISH ,RM-SUB-BAY>
	<TELL
"	You realize that you can't hold your breath any longer and that you are
going to die. Your chest aches, and you see bright lights dancing before your
eyes. But all you can think of is Lindsey's face as she disappeared into the
trough. Just when you think you are going to pass out, you notice that the
lights seem to be clustering around you, pushing you gently back towards
Deepcore. Unable to hold the air any longer, you expel it and expect to
inhale a mouthful of water. Instead you discover that you can breathe quite
normally.|
	You reach out to touch the lights, but your hand passes right through
them. After a few moments, you relax and enjoy the ride. Soon you find
yourself approaching Deepcore. The lights stay with you until you surface
inside the MoonPool, and then they streak away back toward the trench.|
	Catfish grabs your hand and hoists you to firm ground as easily as if you
were a child. He helps you out of your dive suit and into dry clothes. He
says that he thinks that there is some kind of benevolent alien at the bottom
of the Trench, and that Lindsey's monitoring system shows she is still alive,
down near the bottom of the trench.|
	Hippy comes in and says, \"I think I can open this locker now.\" He holds
an electronic device near the lock, and the locker pops open. Inside it is
the fluid breathing system suit." CR
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-BOW"
;"---------------------------------------------------------------------------"
 
<ROOM RM-BOW
	(LOC ROOMS)
	(DESC "bow")
	(FLAGS FL-LIGHTED FL-WATER)
	(SYNONYM BOW)
	(AFT TO RM-MISSILE-HATCH)
	(WEST TO RM-TORPEDO-ROOM)
	(IN TO RM-TORPEDO-ROOM)
	(GLOBAL LG-MONTANA LG-TROUGH RM-MISSILE-HATCH)
	(ACTION RT-RM-BOW)
>
 
<ROUTINE RT-RM-BOW ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL "	You ">
			<COND
				(<MC-CONTEXT? ,M-LOOK>
					<TELL "are at">
				)
				(T
					<TELL "come to">
				)
			>
			<TELL
" the bow of the Montana. The missile hatch is aft of here.  You see the huge
gash that was the Montana's death wound. When we get graphics into the game
you will only be able to fly the ROV in here. But for now, come on in!|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-TORPEDO-ROOM"
;"---------------------------------------------------------------------------"
 
<ROOM RM-TORPEDO-ROOM
	(LOC ROOMS)
	(DESC "torpedo room")
	(FLAGS FL-INDOORS FL-LIGHTED FL-WATER)
	(SYNONYM ROOM)
	(ADJECTIVE TORPEDO)
	(EAST TO RM-BOW)
	(OUT TO RM-BOW)
	(AFT TO RM-ENGINE-ROOM)
	(GLOBAL LG-WALL LG-MONTANA RM-BOW RM-ENGINE-ROOM)
	(ACTION RT-RM-TORPEDO-ROOM)
>
 
<ROUTINE RT-RM-TORPEDO-ROOM ("OPTIONAL" (CONTEXT <>))
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
" the Montana's torpedo room. Foreward lies the gash in the hull and aft is
the engine room.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-ENGINE-ROOM"
;"---------------------------------------------------------------------------"
 
<ROOM RM-ENGINE-ROOM
	(LOC ROOMS)
	(DESC "engine room")
	(FLAGS FL-INDOORS FL-LIGHTED FL-WATER)
	(SYNONYM ROOM)
	(ADJECTIVE ENGINE)
	(FORE TO RM-TORPEDO-ROOM)
	(AFT TO RM-MISSILE-ROOM)
	(GLOBAL LG-WALL LG-MONTANA RM-TORPEDO-ROOM RM-MISSILE-ROOM)
	(ACTION RT-RM-ENGINE-ROOM)
>
 
<ROUTINE RT-RM-ENGINE-ROOM ("OPTIONAL" (CONTEXT <>))
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
" the engine room of the Montana. The torpedo room is foreward, and aft is
the missile launching room.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-MISSILE-ROOM"
;"---------------------------------------------------------------------------"
 
<ROOM RM-MISSILE-ROOM
	(LOC ROOMS)
	(DESC "missile launching room")
	(FLAGS FL-INDOORS FL-LIGHTED FL-WATER)
	(SYNONYM ROOM)
	(ADJECTIVE MISSILE LAUNCHING)
	(FORE TO RM-ENGINE-ROOM)
	(GLOBAL LG-WALL LG-MONTANA RM-ENGINE-ROOM)
	(ACTION RT-RM-MISSILE-ROOM)
>
 
<ROUTINE RT-RM-MISSILE-ROOM ("OPTIONAL" (CONTEXT <>))
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
" the missile launching room. On the wall hangs the missile access key.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
<OBJECT TH-MISSILE-ACCESS-KEY
	(LOC RM-MISSILE-ROOM)
	(DESC "access key")
	(FLAGS FL-KEY FL-TAKEABLE)
	(SYNONYM KEY)
	(ADJECTIVE MISSILE ACCESS)
	(ACTION RT-TH-MISSILE-ACCESS-KEY)
>
 
<ROUTINE RT-TH-MISSILE-ACCESS-KEY ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
;"---------------------------------------------------------------------------"
; "RM-ATTACK-CENTER"
;"---------------------------------------------------------------------------"
 
<ROOM RM-ATTACK-CENTER
	(LOC ROOMS)
	(DESC "attack center")
	(FLAGS FL-INDOORS FL-LIGHTED FL-WATER)
	(SYNONYM CENTER)
	(ADJECTIVE ATTACK)
	(EAST TO RM-MIDSHIP-HATCH IF LG-MIDSHIP-HATCH IS OPEN)
	(OUT TO RM-MIDSHIP-HATCH IF LG-MIDSHIP-HATCH IS OPEN)
	(AFT TO RM-SONAR-ROOM)
	(GLOBAL LG-MIDSHIP-HATCH LG-WALL LG-MONTANA RM-SONAR-ROOM)
	(ACTION RT-RM-ATTACK-CENTER)
>
 
<ROUTINE RT-RM-ATTACK-CENTER ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK>
			<TELL
"	Cautiously, you swim through the hatch. You pull yourself along by the
rungs on the ladder, and then find yourself in the attack center. Your helmet
light reveals an eerie scene of floating debris and lop-sided high-tech
wreckage. You fight off the disorientation caused by everything being on its
side, and then locate the body of the captain and confirm that the missile
access key has been removed from his neck. Fighting the urge to vomit, you
turn away and see a companionway leading aft." CR
			>
		)
		(<MC-CONTEXT? ,M-V-LOOK ,M-LOOK>
			<TELL "	You ">
			<COND
				(<MC-CONTEXT? ,M-LOOK>
					<TELL "are in">
				)
				(<EQUAL? ,OHERE ,RM-MIDSHIP-HATCH>
					<TELL
"swim through the hatch to the attack center. Aft, you see a companionway
leading into the darkness.|"
					>
				)
				(T
					<TELL
"enter the attack center. Above you is the midship hatch and the sonar shack
lies aft.|"
					>
				)
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-SONAR-ROOM"
;"---------------------------------------------------------------------------"
 
<ROOM RM-SONAR-ROOM
	(LOC ROOMS)
	(DESC "sonar room")
	(FLAGS FL-INDOORS FL-LIGHTED FL-WATER)
	(SYNONYM SHACK)
	(ADJECTIVE SONAR)
	(FORE TO RM-ATTACK-CENTER)
	(AFT TO RM-COMM-ROOM)
	(GLOBAL LG-WALL LG-MONTANA RM-ATTACK-CENTER RM-COMM-ROOM)
	(ACTION RT-RM-SONAR-ROOM)
>
 
<ROUTINE RT-RM-SONAR-ROOM ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK>
			<TELL
"	Slowly, you swim through the doorway and come to the sonar room. The
sonarman is slewed sideways, still strapped into his chair. He stares at the
broken screen through blank eyes.|
	Doors here lead fore and aft." CR
			>
		)
		(<MC-CONTEXT? ,M-V-LOOK ,M-LOOK>
			<TELL "	You ">
			<COND
				(<MC-CONTEXT? ,M-LOOK>
					<TELL "are in">
				)
				(T
					<TELL "enter">
				)
			>
			<TELL " the sonar room. Doors here lead fore and aft.|">
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-COMM-ROOM"
;"---------------------------------------------------------------------------"
 
<ROOM RM-COMM-ROOM
	(LOC ROOMS)
	(DESC "comm room")
	(FLAGS FL-INDOORS FL-LIGHTED FL-WATER)
	(SYNONYM ROOM)
	(ADJECTIVE COMM COMMUNICATIONS)
	(FORE TO RM-SONAR-ROOM)
	(AFT PER RT-THRU-BUCKLED-DOOR)
	(GLOBAL LG-BUCKLED-DOOR LG-WALL LG-MONTANA RM-SONAR-ROOM RM-SUB-CORRIDOR)
	(ACTION RT-RM-COMM-ROOM)
>
 
<ROUTINE RT-RM-COMM-ROOM ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK>
			<TELL
"	You swim into the communications room, which was stacked floor to
ceiling with high-tech equipment. The door in the aft bulkhead has buckled
and looks as if it is jammed shut." CR
			>
		)
		(<MC-CONTEXT? ,M-V-LOOK ,M-LOOK>
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
" the communications room. The sonar shack is to the fore and aft lies a
corridor.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
<ROUTINE RT-THRU-BUCKLED-DOOR ("OPT" (QUIET <>))
	<COND
		(<FSET? ,LG-BUCKLED-DOOR ,FL-OPEN>
			<RETURN ,RM-SUB-CORRIDOR>
		)
		(T
			<COND
				(<NOT .QUIET>
					<TELL
"	You push up against the door. It gives a little, and then refuses to
budge.|"
					>
				)
			>
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "LG-BUCKLED-DOOR"
;"---------------------------------------------------------------------------"
 
<OBJECT LG-BUCKLED-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "door")
	(FLAGS FL-DOOR FL-OPENABLE)
	(SYNONYM DOOR)
	(ADJECTIVE BUCKLED JAMMED)
	(ACTION RT-LG-BUCKLED-DOOR)
>
 
<ROUTINE RT-LG-BUCKLED-DOOR ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE>
			<TELL
"	The door in the aft bulkhead has buckled and looks as if it is jammed
shut." CR
			>
		)
		(<VERB? OPEN PUSH>
			<TELL
"	You push up against the door. It gives a little, and then refuses to
budge.|"
			>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-SUB-CORRIDOR"
;"---------------------------------------------------------------------------"
 
<ROOM RM-SUB-CORRIDOR
	(LOC ROOMS)
	(DESC "corridor")
	(FLAGS FL-INDOORS FL-LIGHTED FL-WATER)
	(SYNONYM CORRIDOR)
	(FORE TO RM-COMM-ROOM)
	(DOWN TO RM-CAPTAINS-ROOM)
	(GLOBAL LG-WALL LG-MONTANA RM-COMM-ROOM RM-CAPTAINS-ROOM)
	(ACTION RT-RM-SUB-CORRIDOR)
>
 
<GLOBAL GL-CORRIDOR-BLOCKED? T <> BYTE>
 
<ROUTINE RT-RM-SUB-CORRIDOR ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK>
			<TELL
"	You enter a corridor that leads into the heart of the submarine. Below
you is an open door leading into a stateroom. Only a few feet beyond the
door, the floor starts to pinch in to meet the ceiling where the corridor has
been crushed like the end of a paper towel roll." CR
			>
		)
		(<MC-CONTEXT? ,M-V-LOOK ,M-LOOK>
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
" a corridor. The comm room is foreward and below you is the captain's
quarters.|">
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-CAPTAINS-ROOM"
;"---------------------------------------------------------------------------"
 
<ROOM RM-CAPTAINS-ROOM
	(LOC ROOMS)
	(DESC "captain's quarters")
	(FLAGS FL-INDOORS FL-LIGHTED FL-WATER)
	(SYNONYM QUARTERS ROOM STATEROOM)
	(ADJECTIVE CAPTAIN STATE)
	(UP TO RM-SUB-CORRIDOR)
	(GLOBAL LG-WALL LG-MONTANA RM-SUB-CORRIDOR)
	(ACTION RT-RM-CAPTAINS-ROOM)
>
 
<ROUTINE RT-RM-CAPTAINS-ROOM ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK>
			<TELL
"	You swim down into the room below you, which turns out to be the
captain's stateroom. The room is curiously untouched by the disaster. Except
for the fact that everything has rotated ninety degrees, it is as neat and
tidy as if it were awaiting an admiral's inspection. The bunk is made.
Interestingly enough, the framed photograph on the wall doesn't seem to have
shifted position, even though the sub is lying on its side." CR
			>
		)
		(<MC-CONTEXT? ,M-V-LOOK ,M-LOOK>
			<TELL "	You ">
			<COND
				(<MC-CONTEXT? ,M-LOOK>
					<TELL "are in">
				)
				(T
					<TELL "enter">
				)
			>
			<TELL " the captain's stateroom. Above you is a corridor.|">
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "TH-PHOTOGRAPH"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-PHOTOGRAPH
	(LOC RM-CAPTAINS-ROOM)
	(DESC "photograph")
	(FLAGS FL-NO-DESC)
	(SYNONYM PHOTOGRAPH PICTURE FRAME)
	(ADJECTIVE FRAMED)
	(ACTION RT-TH-PHOTOGRAPH)
>
 
<ROUTINE RT-TH-PHOTOGRAPH ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE>
			<FSET ,TH-PHOTOGRAPH ,FL-SEEN>
			<TELL
"	The picture is of the same man whose body you saw in the control room.
He is standing with his arm around a woman, and they are both smiling into
the camera. At the bottom is scrawled, \"Twenty years before the mast. June
30, 1989. Love, Helen.\"" CR
			>
		)
		(<VERB? LOOK-BEHIND>
			<COND
				(<FSET? ,TH-SAFE ,FL-SEEN>
					<TELL "	Behind the picture is the wall safe." CR>
				)
				(T
					<FSET ,TH-SAFE ,FL-SEEN>
				;	<FCLEAR ,TH-SAFE ,FL-INVISIBLE>
					<MOVE ,TH-SAFE ,RM-CAPTAINS-ROOM>
					<TELL
"	You push aside the picture and discover a wall safe." CR
					>
				)
			>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "TH-SAFE"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-SAFE
	(LOC RM-CAPTAINS-ROOM)
	(DESC "safe")
	(FLAGS FL-CONTAINER FL-LOCKED FL-NO-DESC FL-OPENABLE FL-SEARCH)
	(SYNONYM SAFE DIAL)
	(ADJECTIVE WALL)
	(ACTION RT-TH-SAFE)
>
 
<GLOBAL GL-SAFE-NUM 0 <> BYTE>
 
<ROUTINE RT-TH-SAFE ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
	;	(<AND <NOT <FSET? ,TH-SAFE ,FL-SEEN>>
				<NOT <EVERYWHERE-VERB? <COND (,NOW-PRSI 2) (T 1)>>>
			>
			<NP-CANT-SEE>
		)
		(<NOUN-USED? ,TH-SAFE ,W?DIAL>
			<COND
				(<VERB? EXAMINE>
					<TELL "	The dial is turned to " N ,GL-SAFE-NUM "." CR>
				)
				(<VERB? TURN>
					<SETG GL-SAFE-NUM <- <RANDOM 101> 1>>
					<TELL "	You spin the dial." CR>
				)
				(<VERB? TURN-TO>
					<COND
						(<MC-PRSI? ,INTNUM>
							<COND
								(<OR	<L? ,P-NUMBER 0>
										<G? ,P-NUMBER 100>
									>
									<TELL
"	The dial can only be turned to numbers between 0 and 100, inclusive." CR
									>
								)
								(T
									<TELL "	You turn the dial to " N ,P-NUMBER ".">
									<COND
										(<FSET? ,TH-SAFE ,FL-OPEN>)
										(<EQUAL? ,P-NUMBER 30>
											<COND
												(<EQUAL? ,GL-SAFE-NUM 6>
													<FSET ,TH-SAFE ,FL-ON>
												)
												(T
													<FCLEAR ,TH-SAFE ,FL-ON>
												)
											>
										)
										(<EQUAL? ,P-NUMBER 69>
											<COND
												(<AND <EQUAL? ,GL-SAFE-NUM 30>
														<FSET? ,TH-SAFE ,FL-ON>
													>
													<FCLEAR ,TH-SAFE ,FL-ON>
													<FCLEAR ,TH-SAFE ,FL-LOCKED>
													<FSET ,TH-SAFE ,FL-OPEN>
													<TELL " The safe door opens.">
													<COND
														(<RT-SEE-ANYTHING-IN? ,TH-SAFE>
															<TELL " Inside you see">
															<RT-PRINT-CONTENTS ,TH-SAFE>
															<TELL ".">
														)
													>
												)
												(T
													<FCLEAR ,TH-SAFE ,FL-ON>
												)
											>
										)
									>
									<SETG GL-SAFE-NUM ,P-NUMBER>
									<CRLF>
								)
							>
						)
					>
				)
			>
		)
		(<VERB? CLOSE>
			<COND
				(<FSET? ,TH-SAFE ,FL-OPEN>
					<FCLEAR ,TH-SAFE ,FL-OPEN>
					<FSET ,TH-SAFE ,FL-LOCKED>
					<SETG GL-SAFE-NUM <- <RANDOM 101> 1>>
					<TELL "	You close the safe and spin the dial." CR>
				)
			>
		)
		(<VERB? EXAMINE>
			<TELL
"	The safe is a combination safe with numbers on the dial from 0 to 100." CR
			>
		)
	>
>
 
<OBJECT TH-PLASTIC-CARD
	(LOC TH-SAFE)
	(DESC "plastic card")
	(FLAGS FL-READABLE FL-TAKEABLE)
	(SYNONYM CARD CODE CODES)
	(ADJECTIVE PLASTIC WIRING)
	(ACTION RT-TH-PLASTIC-CARD)
>
 
<ROUTINE RT-TH-PLASTIC-CARD ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE READ>
			<TELL
"	The card has row after row of meaningless numbers written on it." CR
			>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "TH-PLASTIQUE"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-PLASTIQUE
	(LOC RM-DRILL-ROOM)
	(DESC "plastique")
	(FLAGS FL-SURFACE FL-TAKEABLE FL-SEARCH)
	(SYNONYM PLASTIQUE EXPLOSIVE TAPE)
	(ADJECTIVE PLASTIC)
	(OWNER 0)
	(ACTION RT-TH-PLASTIQUE)
>
 
<ROUTINE RT-TH-PLASTIQUE ("OPT" (CONTEXT <>) "AUX" OBJ V)
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(,NOW-PRSI
			<RFALSE>
		)
		(<VERB? EXAMINE>
			<TELL
"	The plastique is a flat package with some sticky, two-sided tape on the
bottom."
			>
			<COND
				(<IN? ,TH-DETONATOR ,TH-PLASTIQUE>
					<TELL " There is a detonator attached to it.">
				)
			>
			<CRLF>
		)
		(<VERB? ATTACH PUT>
			<COND
				(<MC-PRSI? ,LG-BUCKLED-DOOR>
					<MOVE ,TH-PLASTIQUE ,HERE>
					<PUTP ,TH-PLASTIQUE ,P?OWNER ,LG-BUCKLED-DOOR>
					<TELL "	You stick the plastique to the door." CR>
				)
			>
		)
		(<VERB? TAKE>
			<COND
				(<SET OBJ <GETP ,TH-PLASTIQUE ,P?OWNER>>
					<SET V <ITAKE>>
					<COND
						(<EQUAL? .V ,M-FATAL>
							<RFATAL>
						)
						(.V
							<PUTP ,TH-PLASTIQUE ,P?OWNER <>>
							<TELL "	You remove the plastique from" the .OBJ "." CR>
						)
					>
				)
			>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "TH-DETONATOR"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-DETONATOR
	(LOC RM-DRILL-ROOM)
	(DESC "detonator")
	(FLAGS FL-TAKEABLE)
	(SYNONYM DETONATOR TIMER DIAL SWITCH)
	(ACTION RT-TH-DETONATOR)
>
 
<GLOBAL GL-DETONATOR-TIME 10 <> BYTE>
 
<ROUTINE RT-TH-DETONATOR ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE>
			<COND
				(<NOUN-USED? ,TH-DETONATOR ,W?DIAL ,W?TIMER>
					<TELL "	The dial is set to " N ,GL-DETONATOR-TIME "." CR>
				)
				(<NOUN-USED? ,TH-DETONATOR ,W?SWITCH>
					<TELL "	The switch is ">
					<COND
						(<FSET? ,TH-DETONATOR ,FL-ON>
							<TELL "on">
						)
						(T
							<TELL "off">
						)
					>
					<TELL "." CR>
				)
				(T
					<TELL
"	The detonator is deceptively innocent looking. It has a timer that is
calibrated in units of 5 from 10 to 60. Below the face of the timer is a
single switch." CR
					>
				)
			>
		)
		(<VERB? ATTACH PUT-IN PUT>
			<COND
				(<AND <MC-PRSO? ,TH-DETONATOR>
						<MC-PRSI? ,TH-PLASTIQUE>
					>
					<MOVE ,TH-DETONATOR ,TH-PLASTIQUE>
					<TELL
"	You firmly imbed the prongs of the detonator into the plastique." CR
					>
				)
			>
		)
		(<VERB? TURN-TO>
			<COND
				(<OR	<NOT <MC-PRSI? ,INTNUM>>
						<L? ,P-NUMBER 10>
						<G? ,P-NUMBER 60>
						<NOT <ZERO? <MOD ,P-NUMBER 5>>>
					>
					<TELL
"	The timer can only be set in increments of 5 between the numbers of 10
and 60, inclusive.|"
					>
					<RFATAL>
				)
				(T
					<SETG GL-DETONATOR-TIME ,P-NUMBER>
					<TELL "	You set the dial to " N ,P-NUMBER "." CR>
				)
			>
		)
		(<VERB? LISTEN>
			<COND
				(<FSET? ,TH-DETONATOR ,FL-ON>
					<TELL "	You hear a faint whirring." CR>
				)
			>
		)
		(<VERB? TURN-ON>
			<COND
				(<FSET? ,TH-DETONATOR ,FL-ON>
					<RT-ALREADY-MSG "armed">
				)
				(T
					<FSET ,TH-DETONATOR ,FL-ON>
					<RT-QUEUE ,RT-I-DETONATOR <+ ,GL-MOVES <* ,GL-DETONATOR-TIME 2>>>
					<TELL "	You turn the switch and hear a faint whirr." CR>
				)
			>
		)
		(<VERB? TURN-OFF>
			<COND
				(<NOT <FSET? ,TH-DETONATOR ,FL-ON>>
					<RT-ALREADY-MSG "disarmed">
				)
				(T
					<FCLEAR ,TH-DETONATOR ,FL-ON>
					<RT-DEQUEUE ,RT-I-DETONATOR>
					<SETG GL-DETONATOR-TIME 10>
					<TELL
"	You turn off the detonator. The timer resets itself to ten minutes." CR
					>
				)
			>
		)
	>
>
 
<ROUTINE RT-I-DETONATOR ("OPT" (CONTEXT <>) "AUX" L M)
	<SET L <LOC ,TH-PLASTIQUE>>
	<SET M <META-LOC ,TH-PLASTIQUE>>
	<COND
		(<IN? ,TH-DETONATOR ,TH-PLASTIQUE>
			<REMOVE ,TH-PLASTIQUE>
			<COND
				(<AND <FSET? .M ,FL-WATER>
						<FSET? .M ,FL-INDOORS>
						<FSET? ,HERE ,FL-WATER>
						<FSET? ,HERE ,FL-INDOORS>
					>
					; "Both plastique and player in Montana."
					<COND
						(<MC-HERE? .M>
							<TELL
"	Suddenly you see a bright flash. An enormous shock wave slams into you
and instantly kills you.|"
							>
						)
						(T
							<TELL
"	Suddenly you hear a muffled explosion. Seconds later an enormous shock
wave slams you up against a bulkhead and kills you.|"
							>
						)
					>
					<RT-END-OF-GAME>
				)
				(<AND <EQUAL? .L ,RM-COMM-ROOM>
						<EQUAL? <GETP ,TH-PLASTIQUE ,P?OWNER> ,LG-BUCKLED-DOOR>
					>
					<FSET ,LG-BUCKLED-DOOR ,FL-OPEN>
					<COND
						(<GLOBAL-IN? ,LG-MONTANA ,HERE>	;"Montana visible?"
							<TELL
"	Suddenly you hear a muffled explosion. The Montana seems to rock for a
moment, and then settle back into its former position on the ledge." CR
							>
						)
						(T
							<TELL
"	From far away, you hear a muffled thud. The plastique must have gone off
inside the Montana." CR
							>
						)
					>
				)
				(<FSET? .M ,FL-WATER>
					<COND
						(<FSET? .M ,FL-INDOORS>
							<COND
								(<GLOBAL-IN? ,LG-MONTANA ,HERE>	;"Montana visible?"
									<TELL
"	Suddenly you hear a muffled explosion. The Montana seems to rock for a
moment, and then it slides off the ledge and plummets into the chasm!"
									>
								)
								(T
									<TELL
"	From far away, you hear a muffled thud. The plastique must have gone off
inside the Montana. Unbeknownst to you, the blast jars loose the submarine,
and it falls into the chasm."
									>
								)
							>
							<TELL
" Seconds later, the sub slams against the wall of the chasm, ripping off
the timing device, and igniting the nuclear warhead. Everything nearby is
instantly vaporized, including you.|"
							>
							<RT-END-OF-GAME>
						)
						(T
							<TELL
"	The plastique goes \"BOOM\" in the water." CR
							>
						)
					>
				)
				(T		;"Plastique in Deepcore"
					<COND
						(<NOT <FSET? ,HERE ,FL-WATER>>
							<TELL
"	Suddenly, a huge explosion rips through Deepcore, killing you before you
even have time to figure out what caused it.|"
							>
						)
						(T
							<TELL
"	Suddenly, a huge explosion rips through Deepcore, causing you to lose the
will to live.|"
							>
						)
					>
					<RT-END-OF-GAME>
				)
			>
		)
		(<ACCESSIBLE? ,TH-DETONATOR>
			<FCLEAR ,TH-DETONATOR ,FL-ON>
			<SETG ,GL-DETONATOR-TIME 10>
			<TELL "	The detonator makes a faint 'click'." CR>
		)
	>
>
 
"	Plastique			Player				Result
	Door					Montana				Shock wave. Killed.
	Door					Outside Montana	Montana rocks.	*
	Door					Sea floor			Muffled thud.	*
	Door					Deepcore				Muffled thud.	*
	Montana				Same room			Flash. Killed.
	Montana				Montana				Shock wave. Killed.
	Montana				Outside Montana	Montana slides into trench. Vaporize.
	Montana				Sea floor			Far away muffled thud. Vaporize.
	Montana				Deepcore				Far away muffled thud. Vaporize.
	Outside Montana							?
	Sea floor									?
	Deepcore				Montana				?
	Deepcore				Outside Montana	?
	Deepcore				Sea floor			?
	Deepcore				Deepcore				Player killed."
 
;"***************************************************************************"
; "end of file"
;"***************************************************************************"
 
