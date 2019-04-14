;"***************************************************************************"
; "game : Abyss"
; "file : CRANE.ZIL"
; "auth :   $Author:   DEB  $"
; "date :     $Date:   20 Mar 1989  8:44:26  $"
; "rev  : $Revision:   1.12  $"
; "vers : 1.0"
;"---------------------------------------------------------------------------"
; "Crane crash"
; "Copyright (C) 1988 Infocom, Inc.  All rights reserved."
;"***************************************************************************"
 
;"***************************************************************************"
; "CRANE FALLING."
;"***************************************************************************"
 
<GLOBAL GL-CRANE-FALLING? <> <> BYTE>
<GLOBAL GL-CRANE-DOWN? <> <> BYTE>
 
<ROUTINE RT-I-CRANE-1 ()
	<RT-QUEUE ,RT-I-CRANE-2 <+ ,GL-MOVES 1>>
	<SETG GL-CRANE-FALLING? T>
	<RT-QUEUE ,RT-I-KLAXON <+ ,GL-MOVES 1>>
	<SETG GL-KLAXON-ON T>
	; "Automatic temperature control fails."
	<RT-QUEUE ,RT-I-DEEPCORE-TEMP <+ ,GL-MOVES 1>>
 
	<TELL
"	Suddenly the lights go out and emergency klaxons start blaring. "
	>
	<COND
		(<MC-HERE? ,RM-COMMAND-MODULE>
			<TELL
"The control panel starts flashing wildly. Lindsey takes one look out of the
front viewport, slaps the intercom button, and screams,"
			>
		)
		(T
			<TELL "A second later Lindsey's voice screams over the intercom,">
		)
	>
	<TELL
" \"Emergency! The umbilicus is falling on top of us. It's coiling up on top
of the starboard cylinders. God help us if it's still hooked to the crane.
We've got two minutes before whatever's attached to the other end hits us.
Everybody get the hell out of the starboard cylinders. Repeat. Evacuate the
starboard cylinders immediately.\" Emergency lights flicker on.|"
	>
	<COND
		(<MC-HERE? ,RM-COMMAND-MODULE>
			<MOVE ,CH-CATFISH ,RM-CORRIDOR>
		;	<RT-QUEUE ,RT-I-CATFISH <+ ,GL-MOVES 1>>
			<TELL
"	Catfish says, \"Shit! The arc-welding kit's in one of the starboard
cylinders. If that crane hits us, we're gonna need it for damage control.\"
He tears out of the cylinder." CR
			>
		)
	>
	<RTRUE>
>
 
<ROUTINE RT-I-CRANE-2 ()
	<RT-QUEUE ,RT-I-CRANE-3 <+ ,GL-MOVES 1>>
	<TELL
"	A rasping sound grates against your ears as loops of the umbilicus hit
Deepcore and strafe the starboard cylinders." CR
	>
>
 
<ROUTINE RT-I-CRANE-3 ()
	<RT-QUEUE ,RT-I-CRANE-4 <+ ,GL-MOVES 1>>
	<MOVE ,CH-CATFISH ,RM-LADDER-B2>
	<TELL
"	A grinding crash of metal reverberates throughout Deepcore as some huge
piece of equipment strikes one of the cylinders and bounces off." CR
	>
>
 
<ROUTINE RT-I-CRANE-4 ()
	<RT-QUEUE ,RT-I-CRANE-5 <+ ,GL-MOVES 1>>
	<TELL "	Lindsey">
	<COND
		(<MC-HERE? ,RM-COMMAND-MODULE>
			<TELL " hits the intercom button again and screams,">
		)
		(T
			<TELL "'s voice shrieks over the intercom.">
		)
	>
	<TELL " \"Here it comes! All hands rig for impact!\"" CR>
>
 
<ROUTINE RT-I-CRANE-5 ()
	<SETG GL-CRANE-FALLING? <>>
	<SETG GL-CRANE-DOWN? T>
 
	; "Start fire in sub-bay"
	<MOVE ,TH-FIRE ,RM-SUB-BAY>
	<RT-QUEUE ,RT-I-FIRE-1 <+ ,GL-MOVES 14>>
 
	; "Start leak into port battery room"
	<SETG GL-BATTERY-LEAK T>
	<MOVE ,TH-CRACK ,RM-PT-OBS-DECK> ; "rab"
; "Duane - we may not need gl-battery-leak.  We can test for the loc of
	crack instead."
	<RT-QUEUE ,RT-I-BATTERY-LEAK <+ ,GL-MOVES 1>>
 
	<MOVE ,CH-COFFEY ,RM-COMMAND-MODULE>
	<MOVE ,CH-CATFISH ,RM-DIVE-GEAR-STORAGE>
	<FSET ,CH-CATFISH ,FL-LOCKED>
	<FCLEAR ,LG-DGS-DOOR ,FL-OPEN>
	<MOVE ,CH-HIPPY ,RM-FRESH-WATER-STORAGE>
	<RT-QUEUE ,RT-I-HIPPY-RETURN <+ ,GL-MOVES 30>>
	<COND
		(<MC-HERE? ,RM-DIVE-GEAR-STORAGE>
			<TELL
"	Catfish rushes in, slamming the door behind him. He starts rummaging
around in his locker. \"I've got to find the arc-welder,\" he yells.|"
			>
		)
		(T
			<RT-QUEUE ,RT-I-CATFISH-TRAPPED <+ ,GL-MOVES 4>>
		)
	>
	<TELL
"	The inside of your head explodes as the crane slams into Deepcore with
the impact of a hundred sticks of dynamite. The crane crashes into the
starboard cylinders at an angle, toppling Deepcore almost over onto its side.
You collide with the starboard bulkhead as the floor tilts crazily below your
feet. Then you're thrown to the deck as the crane shears off the top of two
aft cylinders and the rest of the rig crashes back onto the ocean floor with
a shuddering jolt.|"
	>
	<COND
		(<MC-HERE? ,RM-COMMAND-MODULE>
			<TELL
"	Coffey saunters into the command module, looking unconcerned about the
chaos that surrounds him. Lindsey looks up at you and says, \"I know we have
our differences, Bud. But you're the one in command here, and I'll do
whatever you tell me to.\"" CR
			>
		)
		(<MC-HERE? ,RM-DIVE-GEAR-STORAGE>
			<TELL
"	When your head clears you look around and take stock of your situation.
A locker has fallen over, pinning Catfish to the floor. Water is cascading
down into the room from the ceiling above." CR
			>
		)
		(<MC-HERE? ,RM-SUB-BAY>
			<TELL
"	A reserve oxygen cylinder has been knocked loose of its mooring and lies
on the floor. You can hear the hiss of the pure oxygen as it escapes into the
breathing mix. Suddenly, an exposed wire along the wall begins to spark. The
insulation nearby catches fire and the flames start to work their way towards
the wooden dive locker." CR
			>
		)
	;	(<PLAYER-IN-SQUASHED-CYLINDER?>
			<TELL
"	Before you can react, a solid wall of water engulfs you, slamming you up
against the steel wall and knocking you unconscious. Seconds later, you
drown.|"
			>
			<RT-END-OF-GAME>
		)
	>
	<RTRUE>
>
 
<ROUTINE RT-I-HIPPY-RETURN ()
	<MOVE ,CH-HIPPY ,HERE>
	<TELL
"	Hippy stumbles into the room, sopping wet and gasping for air. \"I got
trapped down in Fresh Water Storage,\" he gasps. \"The doors buckled and the
only way out was through the emergency escape hatch in the bottom of the
cylinder. But the wheel was jammed and I couldn't turn it. I had just given
myself up for dead, when suddenly the wheel started turning all by itself! I
was pretty spooked, but I didn't sit around to figure it out. I opened the
hatch and swam over to the MoonPool. But just as I came out of the cylinder,
I saw this...shape...disappear off towards the trench.\"" CR
	>
>
 
;"***************************************************************************"
; "KLAXON STUFF."
;"***************************************************************************"
 
<GLOBAL GL-KLAXON-ON <> <> BYTE>
 
<ROUTINE RT-I-KLAXON ()
	<RT-QUEUE ,RT-I-KLAXON <+ ,GL-MOVES 1>>
	<COND
		(<NOT <FSET? ,HERE ,FL-WATER>>
			<TELL "	The klaxons continue to blare in your ears." CR>
		)
	>
>
 
;"***************************************************************************"
; "FLOODING IN PORT BATTERY ROOM."
;"***************************************************************************"
 
<GLOBAL GL-BATTERY-LEAK <> <> BYTE>
<GLOBAL GL-WATER-LEVEL 0 <> BYTE>
;<GLOBAL GL-WATER-MSG 0 <> BYTE>
 
<ROUTINE RT-I-BATTERY-LEAK ()
	<RT-QUEUE ,RT-I-BATTERY-LEAK <+ ,GL-MOVES 1>>
	<COND
		(<FSET? ,TH-PT-BILGE-BUTTON ,FL-ON>	;,GL-PT-BILGE-ON
			<COND
				(<G? ,GL-WATER-LEVEL 0>
					<DEC GL-WATER-LEVEL>
				)
			>
			<RFALSE>
		)
		(<IGRTR? GL-WATER-LEVEL 19>
			<COND
				(<MC-HERE? ,RM-PT-BATTERY-ROOM>
					<TELL
"	Slowly, the water level rises until it encases the base of the huge
powercels. Suddenly, everything goes dark and you hear all Deepcore's
machinery grind to a halt. You see a few blue flashes below the water level,
and then everything becomes very still. With"
					>
				)
				(<FSET? ,HERE ,FL-WATER>
					<COND
						(<NOT <FSET? ,HERE ,FL-INDOORS>>
							<TELL
"	You glance back at Deepcore and see all the lights flicker out. You
realize immediately that something has shorted out the powercels in the
battery room. You swim back to investigate, emerge into the MoonPool, and try
to make your way down to the battery room. But with"
							>
						)
					>
				)
				(T
					<TELL
"	Suddenly, everything goes dark and you hear all of Deepcore's machinery
grind to a halt. In the eerie silence that follows, you realize that
something has shorted out the powercels in the battery room. With"
					>
				)
			>
			<TELL
" no power to maintain the temperature and the air supply, the end comes much
more quickly than you would have expected.|"
			>
			<RT-END-OF-GAME>
		)
		(<MC-HERE? ,RM-PT-BATTERY-ROOM>
			; "These message need to denote action or change of state, not
				description of current state."
			<TELL "	The pool of water">
			<COND
				(<G? ,GL-WATER-LEVEL 17>
					<TELL
" will reach the battery cases within seconds. If it does, all will be lost." CR
					>
				)
				(<G? ,GL-WATER-LEVEL 10>
					<TELL
" is rising rapidly, and will soon short out the batteries." CR
					>
				)
				(<G? ,GL-WATER-LEVEL 5>
					<TELL
", if it rises much further, will reach the battery cases and short out
Deepcore's sole remaining source of emergency power." CR
					>
				)
				(T
					<TELL
" is approaching the base of the battery cases." CR
					>
				)
			>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-PT-BATTERY-ROOM"
;"---------------------------------------------------------------------------"
 
<ROOM RM-PT-BATTERY-ROOM
	(LOC ROOMS)
	(DESC "port battery room")
	(MENU "battery room")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM ROOM)
	(ADJECTIVE PORT BATTERY)
	(AFT TO RM-LADDER-A1)
	(GLOBAL LG-WALL RM-LADDER-A1)
	(ACTION RT-RM-PT-BATTERY-ROOM)
>
 
<ROUTINE RT-RM-PT-BATTERY-ROOM ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL
"	This is one of the rooms that contain the huge fuelcells that power
Deepcore. The powercels are surrounded by a wire cage that is festooned with
signs that warn of the dangers of electricity. The fuelcells are humming
ominously - as usual - and an acrid, ozone smell fills the air. The only
exit is through the hatch in the aft bulkhead.|"
			>
			<COND
				(,GL-BATTERY-LEAK
					<TELL
"	A stream of water is flowing down the wall from the ceiling "
					>
					<COND
						(<FSET? ,TH-PT-BILGE-BUTTON ,FL-ON>	;,GL-PT-BILGE-ON
							<COND
								(<ZERO? ,GL-WATER-LEVEL>
									<TELL
"but it is sucked up by the pump as soon as it hits the floor."
									>
								)
								(T
									<TELL
"into the pool of water on the floor. The pool looks like it is getting
smaller."
									>
								)
							>
						)
						(<L? ,GL-WATER-LEVEL 6>
							<TELL
"into a pool of water on the floor. As the water rises, it approaches the
base of the battery cases."
							>
						)
						(<L? ,GL-WATER-LEVEL 11>
							<TELL
"into the pool of water. If the water rises much further, it will reach the
battery cases and short out Deepcore's sole remaining source of emergency
power."
							>
						)
						(<L? ,GL-WATER-LEVEL 18>
							<TELL "into the rapidly rising water.">
						)
						(<L? ,GL-WATER-LEVEL 20>
							<TELL
"into the pool of water. The water will reach the battery cases within
seconds. If it does, all will be lost."
							>
						)
						(T
							<TELL "into the rapidly rising water below.">
						)
					>
					<CRLF>
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
; "TH-POWERCEL"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-POWERCEL
	(LOC RM-PT-BATTERY-ROOM)
	(DESC "fuel cell")
	(SYNONYM POWERCEL CELL)
	(ADJECTIVE FUEL POWER)
	(ACTION RT-TH-POWERCEL)
>
 
<ROUTINE RT-TH-POWERCEL ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
;"---------------------------------------------------------------------------"
; "TH-POOL-OF-WATER"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-POOL-OF-WATER
;	(LOC RM-PT-BATTERY-ROOM)
	(DESC "pool")
	(SYNONYM POOL WATER)
	(ADJECTIVE WATER)
	(ACTION RT-TH-POOL-OF-WATER)
>
 
<ROUTINE RT-TH-POOL-OF-WATER ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
;"---------------------------------------------------------------------------"
; "RM-PT-OBS-DECK"
;"---------------------------------------------------------------------------"
 
<ROOM RM-PT-OBS-DECK
	(LOC ROOMS)
	(DESC "port observation deck")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM DECK)
	(ADJECTIVE PORT OBSERVATION)
	(AFT TO RM-LADDER-A3)
	(GLOBAL LG-WALL RM-LADDER-A3)
	(ACTION RT-RM-PT-OBS-DECK)
>
 
<ROUTINE RT-RM-PT-OBS-DECK ("OPTIONAL" (CONTEXT <>))
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
" the port observation deck, which has a huge domed plexiglass window where
the forward bulkhead should be. The only exit is in the aft bulkhead.|"
			>
			<COND
				(,GL-BATTERY-LEAK
					<TELL
"	There is a fair-sized crack in the starboard bulkhead, up near the
ceiling. Water is pouring in through the crack, running down the wall,
and disappearing into the room below.|"
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
; "TH-CRACK"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-CRACK
	(DESC "crack")
	(SYNONYM CRACK)
	(ACTION RT-TH-CRACK)
>
 
<ROUTINE RT-TH-CRACK ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(,NOW-PRSI
			<COND
				(<VERB? PUT>
					<COND
						(<MC-PRSO? ,TH-WELDING-ROD>
							<RT-WELD-CRACK>
						)
					>
				)
			>
		)
		(<VERB? WELD>
			<RT-WELD-CRACK>
		)
	>
>
 
<ROUTINE RT-WELD-CRACK ()
	<COND
		(<AND <RT-META-IN? ,TH-ARC-WELDER ,HERE>
				<IN? ,TH-WELDING-ROD ,TH-RED-CABLE>
			>
			<COND
				(<AND <FSET? ,TH-ARC-WELDER ,FL-ON>
						<EQUAL? <GETP ,TH-BLACK-CABLE ,P?OWNER> ,LG-WALL>
					>
					<REMOVE ,TH-CRACK>
					<SETG GL-BATTERY-LEAK <>>
					<SETG GL-WATER-LEVEL 0>
					<RT-DEQUEUE RT-I-BATTERY-LEAK>
					<FCLEAR ,TH-PT-BILGE-BUTTON ,FL-ON>
					<TELL
"	You hold the rod up to the crack. Sparks immediately start to fly from the
tip of the rod and the end starts to glow. Soon, the softened metal begins to
melt into the crack, and the stream of water gradually disappears." CR
					>
				)
				(T
					<TELL
"	You hold the rod up next to the crack, but nothing happens." CR
					>
				)
			>
		)
		(<VERB? WELD>
			<TELL ,K-HOW-INTEND-MSG CR>
			<RFATAL>
		)
		(T
			<TELL
"	You hold the rod up next to the crack, but nothing happens." CR
			>
		)
	>
>
 
<OBJECT TH-ARC-WELDER
;	(LOC RM-PT-BATTERY-ROOM)
	(DESC "arc welder")
	(FLAGS FL-SEARCH FL-SURFACE FL-TAKEABLE)
	(SYNONYM WELDER ARC-WELDER)
	(ADJECTIVE ARC)
	(ACTION RT-TH-ARC-WELDER)
>
 
<ROUTINE RT-TH-ARC-WELDER ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE>
			<TELL
"	The arc welder is a sturdy black box with red and black cables coming out
of it. The red cable looks like a jumper cable, except that the clamp at the
end is wrapped with thick rubber insulation. The black cable ends in an
suction cup that has an exposed electrode in the center. In addition, it has
an on/off switch and a power cord." CR
			>
		)
		(<VERB? TURN-ON>
			<COND
				(<FSET? ,TH-ARC-WELDER ,FL-ON>
					<RT-ALREADY-MSG "on">
				)
				(<FSET? ,TH-WELDER-CORD ,FL-ON>	;"Is welder plugged in?"
					<FSET ,TH-ARC-WELDER ,FL-ON>
					<TELL "	The machine begins to hum." CR>
				)
				(T
					<TELL "	The welder isn't plugged in." CR>
				)
			>
		)
		(<VERB? TURN-OFF>
			<COND
				(<NOT <FSET? ,TH-ARC-WELDER ,FL-ON>>
					<RT-ALREADY-MSG "off">
				)
				(T
					<FCLEAR ,TH-ARC-WELDER ,FL-ON>
					<TELL "	The machine stops humming." CR>
				)
			>
		)
		(<VERB? PLUG-IN>
			<COND
				(<FSET? ,TH-WELDER-CORD ,FL-ON>
					<RT-ALREADY-MSG "plugged in">
				)
				(T
					<FSET ,TH-WELDER-CORD ,FL-ON>
					<TELL "	You plug the power cord into the wall outlet." CR>
				)
			>
		)
	>
>
 
<OBJECT TH-WELDING-ROD
;	(LOC RM-PT-BATTERY-ROOM)
	(DESC "welding rod")
	(FLAGS FL-TAKEABLE)
	(SYNONYM ROD)
	(ADJECTIVE ARC WELDING)
	(ACTION RT-TH-WELDING-ROD)
>
 
<ROUTINE RT-TH-WELDING-ROD ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE>
			<TELL "	It's a stiff metal rod, about 14 inches long." CR>
		)
	>
>
 
<OBJECT TH-RED-CABLE
	(LOC TH-ARC-WELDER)
	(DESC "red cable")
	(FLAGS FL-CONTAINER FL-NO-DESC FL-OPEN FL-SEARCH)
	(SYNONYM CABLE CLAMP)
	(ADJECTIVE RED RUBBER)
	(ACTION RT-TH-RED-CABLE)
>
 
<ROUTINE RT-TH-RED-CABLE ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(,NOW-PRSI
			<COND
				(<VERB? TAKE-WITH ATTACH PUT-IN>
					<COND
						(<MC-PRSO? ,TH-WELDING-ROD>
							<MOVE ,TH-WELDING-ROD ,TH-RED-CABLE>
							<TELL "	You put the welding rod into the clamp." CR>
						)
					>
				)
			>
		)
		(<VERB? EXAMINE>
			<TELL
"	The red cable looks like a jumper cable, ending in a large insulated
clamp with sharp steel teeth." CR
			>
		)
		(<VERB? ATTACH>
			<COND
				(<MC-PRSI? ,TH-WELDING-ROD>
					<MOVE ,TH-WELDING-ROD ,TH-RED-CABLE>
					<TELL "	You put the welding rod into the clamp." CR>
				)
			>
		)
	>
>
 
<OBJECT TH-BLACK-CABLE
	(LOC TH-ARC-WELDER)
	(DESC "black cable")
	(FLAGS FL-NO-DESC)
	(SYNONYM CABLE CUP ELECTRODE)
	(ADJECTIVE BLACK RUBBER SUCTION)
	(OWNER 0)	;"What electrode is attached to"
	(ACTION RT-TH-BLACK-CABLE)
>
 
<ROUTINE RT-TH-BLACK-CABLE ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(,NOW-PRSI
			<RFALSE>
		)
		(<VERB? EXAMINE>
			<TELL
"	The black cable ends in an suction cup that has an exposed electrode in
the center." CR
			>
		)
		(<VERB? ATTACH>
			<PUTP ,TH-BLACK-CABLE ,P?OWNER ,PRSI>
			<TELL
"	You put the suction cup on" the ,PRSI ", pressing hard to ensure a good
contact for the electrode." CR
			>
		)
	>
>
 
<OBJECT TH-WELDER-SWITCH
	(LOC TH-ARC-WELDER)
	(DESC "power switch")
	(FLAGS FL-NO-DESC)
	(SYNONYM SWITCH PLUG)
	(ADJECTIVE POWER)
	(ACTION RT-TH-WELDER-SWITCH)
>
 
<ROUTINE RT-TH-WELDER-SWITCH ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE>
			<TELL "	The power switch is labelled 'ON' and 'OFF'." CR>
		)
		(<VERB? TURN-ON TURN-OFF>
			<RT-TH-ARC-WELDER>
		)
	>
>
 
<OBJECT TH-WELDER-CORD
	(LOC TH-ARC-WELDER)
	(DESC "power cord")
	(FLAGS FL-NO-DESC)
	(SYNONYM CORD)
	(ADJECTIVE POWER)
	(ACTION RT-TH-WELDER-CORD)
>
 
; "TH-WELDER-CORD flags:"
; "	FL-ON = Cord is plugged into an outlet."
 
<ROUTINE RT-TH-WELDER-CORD ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE>
			<TELL "	The power cord will plug into any wall outlet." CR>
		)
		(<VERB? PLUG-IN>
			<COND
				(<FSET? ,TH-WELDER-CORD ,FL-ON>
					<RT-ALREADY-MSG "plugged in">
				)
				(T
					<FSET ,TH-WELDER-CORD ,FL-ON>
					<TELL "	You plug the power cord into the wall outlet." CR>
				)
			>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-LADDER-D2"
;"---------------------------------------------------------------------------"
 
<ROOM RM-LADDER-D2
	(LOC ROOMS)
	(DESC "ladderwell D")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM WELL LADDERWELL)
	(ADJECTIVE LADDER LADDERWELL)
	(FORE TO RM-PANTRY)
	(UP TO RM-LADDER-D3)
	(DOWN TO RM-LADDER-D1)
	(GLOBAL LG-WALL RM-PANTRY RM-LADDER-D3 RM-LADDER-D1)
	(ACTION RT-RM-LADDER-D2)
>
 
<ROUTINE RT-RM-LADDER-D2 ("OPTIONAL" (CONTEXT <>))
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
" the middle level of ladderwell D. A hatch in the forward bulkhead opens
onto the pantry. There is a yellow button here, with a sign underneath it.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "TH-PT-BILGE-BUTTON"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-PT-BILGE-BUTTON
	(LOC RM-LADDER-D2)
	(DESC "button")
	(SYNONYM BUTTON)
	(ADJECTIVE YELLOW)
	(ACTION RT-TH-PT-BILGE-BUTTON)
>
 
<ROUTINE RT-TH-PT-BILGE-BUTTON ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? READ>
			<TELL "It says, \"Port Bilge Pumps.\"" CR>
		)
		(<VERB? PUSH HIT>
			<TELL "	You press the button and ">
			<COND
				(<FSET? ,TH-PT-BILGE-BUTTON ,FL-ON>
					<FCLEAR ,TH-PT-BILGE-BUTTON ,FL-ON>
					<TELL "the whirring stops." CR>
				)
				(<G? ,GL-WATER-LEVEL 0>
					<FSET ,TH-PT-BILGE-BUTTON ,FL-ON>
					<TELL "hear a distant whirring." CR>
				)
				(T
					<FCLEAR ,TH-PT-BILGE-BUTTON ,FL-ON>
					<TELL
"hear a distant whirring which stops soon after it starts. There must not be
any water in the port bilge." CR
					>
				)
			>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "TH-SB-BILGE-BUTTON"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-SB-BILGE-BUTTON
	(LOC RM-LADDER-C2)
	(DESC "button")
	(SYNONYM BUTTON)
	(ADJECTIVE YELLOW)
	(ACTION RT-TH-SB-BILGE-BUTTON)
>
 
<ROUTINE RT-TH-SB-BILGE-BUTTON ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? READ>
			<TELL "It says, \"Starboard Bilge Pumps.\"" CR>
		)
		(<VERB? PUSH HIT>
			<TELL
"	You press the button and hear a distant whirring which stops soon after it
starts. There must not be any water in the starboard bilge." CR
			>
		)
	>
>
 
;"***************************************************************************"
; "TRAPPED CATFISH."
;"***************************************************************************"
 
<ROUTINE RT-I-CATFISH-TRAPPED ()
	<COND
	;	(<MC-HERE? ,RM-DIVE-GEAR-STORAGE>
		)
		(T
			<TELL
"	The intercom buzzes. Then you hear a weak voice. \"This is Catfish. I'm
trapped under a locker in Dive Gear Storage. The water in here is rising
faster than the Johnstown flood. If one of y'all don't get down here pronto,
I'm gonnna be singin' with the angels.\"" CR
			>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-DIVE-GEAR-STORAGE"
;"---------------------------------------------------------------------------"
 
<ROOM RM-DIVE-GEAR-STORAGE
	(LOC ROOMS)
	(DESC "dive gear storage")
	(MENU "gear storage")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM STORAGE)
	(ADJECTIVE DIVE GEAR)
	(AFT TO RM-LADDER-B2 IF LG-DGS-DOOR IS OPEN)
	(GLOBAL LG-DGS-DOOR LG-WALL RM-LADDER-B2)
	(ACTION RT-RM-DIVE-GEAR-STORAGE)
>
 
<ROUTINE RT-RM-DIVE-GEAR-STORAGE ("OPTIONAL" (CONTEXT <>))
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
" a room that looks like the locker room at the local health club. The walls
are lined with floor-to-ceiling lockers, one for each crew member. Your
locker is the one next to the exit in the aft bulkhead.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
<OBJECT TH-BUD-GEAR-LOCKER
	(LOC RM-DIVE-GEAR-STORAGE)
	(DESC "gear locker")
	(FLAGS FL-CONTAINER FL-OPENABLE FL-SEARCH FL-YOUR)
	(SYNONYM LOCKER)
	(ADJECTIVE BUD GEAR)
	(OWNER CH-PLAYER)
	(SIZE 5)
	(GENERIC RT-GN-LOCKER)
	(ACTION RT-TH-BUD-GEAR-LOCKER)
>
 
<ROUTINE RT-TH-BUD-GEAR-LOCKER ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
<OBJECT TH-BIG-LOCKER
	(LOC RM-DIVE-GEAR-STORAGE)
	(DESC "big locker")
	(FLAGS FL-CONTAINER FL-OPENABLE FL-SEARCH)
	(SYNONYM LOCKER)
	(ADJECTIVE BIG DIVE GEAR)
	(SIZE 5)
	(GENERIC RT-GN-LOCKER)
	(ACTION RT-TH-BIG-LOCKER)
>
 
<ROUTINE RT-TH-BIG-LOCKER ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? MOVE LIFT PUSH PULL>
			<COND
				(<MC-PRSI? <> ,ROOMS ,TH-HANDS>
					<TELL
"	You strain at the locker, but you just don't have enough leverage to move
it." CR
					>
				)
				(<MC-PRSI? ,TH-BARBELL>
					<FCLEAR ,CH-CATFISH ,FL-LOCKED>
					<RT-SET-PUPPY ,CH-CATFISH>
					<TELL
"	Using the bar as a lever, you strain against the weight of the dive
locker. Slowly, it inches up. Just when you realize that the bar is starting
to slip from your grasp, Catfish manages to squirm free and roll out of the
way. The locker crashes back to the floor. Catfish drags himself unsteadily
to his feet and says, \"Thanks a lot, Chief. Nothing seems to be broken.
Let's get the hell out of here.\"" CR
					>
				)
			>
		)
		(<VERB? OPEN>
			<TELL "	The doors are jammed shut." CR>
		)
	>
>
 
<ROUTINE RT-GN-LOCKER (TBL FINDER "AUX" PTR N)
	<SET PTR <REST-TO-SLOT .TBL FIND-RES-OBJ1>>
	<SET N <FIND-RES-COUNT .TBL>>
	<COND
		(<AND <MC-HERE? ,RM-DIVE-GEAR-STORAGE>
				<IN? ,CH-CATFISH ,RM-DIVE-GEAR-STORAGE>
				<INTBL? ,TH-BIG-LOCKER .PTR .N>
			>
			<TELL "[the big locker]|">
			<RETURN ,TH-BIG-LOCKER>
		)
	>
>
 
<OBJECT LG-DGS-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "fore door")
	(FLAGS FL-DOOR FL-OPEN FL-OPENABLE)
	(SYNONYM DOOR)
	(ADJECTIVE FORE DIVE GEAR STORAGE)
	(ACTION RT-LG-DGS-DOOR)
>
 
<ROUTINE RT-LG-DGS-DOOR ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? OPEN>
			<COND
				(<AND <NOT <FSET? ,LG-DGS-DOOR ,FL-OPEN>>
						<FSET? ,CH-CATFISH ,FL-LOCKED>	;"Catfish trapped"
					>
					<FSET ,LG-DGS-DOOR ,FL-OPEN>
					<FCLEAR ,LG-FLOOD-DOOR ,FL-OPEN>
					<SETG OHERE ,HERE>
					<SETG HERE ,RM-DIVE-GEAR-STORAGE>
					<MOVE ,CH-PLAYER ,RM-DIVE-GEAR-STORAGE>
					<TELL
"	You open the door to the cylinder. Inside is a jumbled chaos. Water is
streaming down from the ceiling into an ever-rising pool on the floor.
Catfish is sitting with his back to the wall, up to his chest in water. His
legs are pinned by a huge locker that has fallen over on top of him, and he
is turning blue from the cold.|
	Water gushes out of the chamber when you open the door. It falls to the
level below, triggering the automated flood control door that seals the
starboard side of Deepcore off from the central core. The hydraulic hose
stiffens and the door swings shut.|
	You step into the chamber. The frigid water comes up to your knees.
Catfish looks up at you and grins weakly. \"Howdy, pardner.\"" CR
					>
				;	<RT-DO-WALK ,P?FORE>
				)
			>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-RECREATION-ROOM"
;"---------------------------------------------------------------------------"
 
<ROOM RM-RECREATION-ROOM
	(LOC ROOMS)
	(DESC "recreation room")
	(MENU "rec room")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM ROOM)
	(ADJECTIVE RECREATION REC)
	(PORT TO RM-LADDER-B2)
	(GLOBAL LG-WALL RM-LADDER-B2)
	(ACTION RT-RM-RECREATION-ROOM)
>
 
<ROUTINE RT-RM-RECREATION-ROOM ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL "	You ">
			<COND
				(<MC-CONTEXT? ,M-LOOK>
					<TELL "are in">
				)
				(T
					<TELL "step into">
				)
			>
			<TELL
" the recreation and exercise room. Against the wall is a stationary bicycle.
Next to it is a treadmill. In the middle of the room is a lift bench with a
barbell resting on the stand. The only exit is to port.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "TH-BARBELL"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-BARBELL
	(LOC RM-RECREATION-ROOM)
	(DESC "barbell")
	(FLAGS FL-SURFACE FL-TAKEABLE)
	(SYNONYM BARBELL BAR)
	(ACTION RT-TH-BARBELL)
>
 
<ROUTINE RT-TH-BARBELL ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? TAKE LIFT>
			<COND
				(<IN? ,TH-WEIGHTS ,TH-BARBELL>
					<TELL "	The barbell is too heavy to lift." CR>
				)
			>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "TH-WEIGHTS"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-WEIGHTS
	(LOC TH-BARBELL)
	(DESC "weights")
	(FLAGS FL-TAKEABLE)
	(SYNONYM WEIGHTS)
	(ACTION RT-TH-WEIGHTS)
>
 
<ROUTINE RT-TH-WEIGHTS ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? UNWEAR TAKE>
			<COND
				(<IN? ,TH-WEIGHTS ,TH-BARBELL>
					<MOVE ,TH-WEIGHTS ,HERE>
					<TELL
"	You remove the weights from the barbell and lay them on the floor." CR
					>
				)
			>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "TH-LIFT-BENCH"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-LIFT-BENCH
	(LOC RM-RECREATION-ROOM)
	(DESC "bench")
	(FLAGS FL-SURFACE)
	(SYNONYM BENCH)
	(ADJECTIVE LIFT)
	(ACTION RT-TH-LIFT-BENCH)
>
 
<ROUTINE RT-TH-LIFT-BENCH ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
;"---------------------------------------------------------------------------"
; "TH-TREADMILL"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-TREADMILL
	(LOC RM-RECREATION-ROOM)
	(DESC "treadmill")
	(FLAGS FL-SURFACE)
	(SYNONYM TREADMILL)
	(ACTION RT-TH-TREADMILL)
>
 
<ROUTINE RT-TH-TREADMILL ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
;"---------------------------------------------------------------------------"
; "TH-CYCLE"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-CYCLE
	(LOC RM-RECREATION-ROOM)
	(DESC "cycle")
	(FLAGS FL-SURFACE)
	(SYNONYM CYCLE BICYCLE)
	(ADJECTIVE STATIONARY EXERCISE)
	(ACTION RT-TH-CYCLE)
>
 
<ROUTINE RT-TH-CYCLE ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
;"---------------------------------------------------------------------------"
; "RM-LADDER-B2"
;"---------------------------------------------------------------------------"
 
<ROOM RM-LADDER-B2
	(LOC ROOMS)
	(DESC "ladderwell B")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM WELL LADDERWELL)
	(ADJECTIVE LADDER LADDERWELL)
	(FORE TO RM-DIVE-GEAR-STORAGE IF LG-DGS-DOOR IS OPEN)
	(AFT TO RM-WALDORF)
	(STARBOARD TO RM-RECREATION-ROOM)
	(PORT TO RM-CORRIDOR IF LG-FLOOD-DOOR IS OPEN)
	(UP TO RM-LADDER-B3)
	(DOWN TO RM-LADDER-B1)
	(GLOBAL
		LG-FLOOD-DOOR LG-DGS-DOOR LG-WALL RM-DIVE-GEAR-STORAGE RM-WALDORF
		RM-RECREATION-ROOM RM-CORRIDOR RM-LADDER-B3 RM-LADDER-B1
	)
	(ACTION RT-RM-LADDER-B2)
>
 
<ROUTINE RT-RM-LADDER-B2 ("OPTIONAL" (CONTEXT <>))
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
" the middle level of ladderwell B. A corridor leads to the port side of
Deepcore. A hatch in the starboard bulkhead opens onto the recreation room.
Dive gear storage is forward, and aft is the entrance to your own living
quarters.|"
			>
			<RFALSE>
		)
		(<MC-CONTEXT? ,M-ENTERED>
			<COND
				(<AND <EQUAL? ,GL-PUPPY ,CH-CATFISH>
						<NOT <LOC ,TH-ARC-WELDER>>
					>
				;	<MOVE ,CH-CATFISH ,RM-LADDER-B2>
					<MOVE ,TH-ARC-WELDER ,CH-CATFISH>
					<MOVE ,TH-WELDING-ROD ,CH-CATFISH>
					<TELL
"	Catfish follows you out, holding up the arc-welder triumphantly. \"Dry as
a bone, Boss. It was stowed on a shelf the water hadn't reached yet.\"" CR
					>
				)
			>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "TH-HYDRAULIC-HOSE"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-HYDRAULIC-HOSE
	(LOC RM-LADDER-B2)
	(DESC "hydraulic hose")
	(MENU "hose")
	(SYNONYM HOSE)
	(ADJECTIVE HYDRAULIC)
	(ACTION RT-TH-HYDRAULIC-HOSE)
>
 
; "TH-HYDRAULIC-HOSE flags:"
; "	FL-BROKEN = Hose has been cut open."
 
<ROUTINE RT-TH-HYDRAULIC-HOSE ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? CUT>
			<COND
				(<MC-PRSI? ,TH-KNIFE>
					<COND
						(<FSET? ,TH-HYDRAULIC-HOSE ,FL-BROKEN>
							<RT-ALREADY-MSG "cut">
						)
						(T
							<FSET ,TH-HYDRAULIC-HOSE ,FL-BROKEN>
							<MOVE ,TH-HYDRAULIC-FLUID ,HERE>
							<TELL
"	You cut the hose with the knife. Red fluid pours out onto the floor." CR
							>
						)
					>
				)
			>
		)
	>
>
 
<OBJECT TH-HYDRAULIC-FLUID
	(DESC "hydraulic fluid")
	(MENU "fluid")
	(SYNONYM FLUID)
	(ADJECTIVE HYDRAULIC RED STICKY)
	(ACTION RT-TH-HYDRAULIC-FLUID)
>
 
<ROUTINE RT-TH-HYDRAULIC-FLUID ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
;"---------------------------------------------------------------------------"
; "LG-FLOOD-DOOR"
;"---------------------------------------------------------------------------"
 
<OBJECT LG-FLOOD-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "flood door")
	(FLAGS FL-DOOR FL-OPEN FL-OPENABLE)
	(SYNONYM DOOR)
	(ADJECTIVE AUTOMATIC FLOOD CONTROL)
	(ACTION RT-LG-FLOOD-DOOR)
>
 
<ROUTINE RT-LG-FLOOD-DOOR ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? OPEN>
			<COND
				(<AND <NOT <FSET? ,LG-FLOOD-DOOR ,FL-OPEN>>
						<NOT <FSET? ,TH-HYDRAULIC-HOSE ,FL-BROKEN>>
					>
					<TELL "	The door refuses to budge." CR>
				)
			>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "TH-KNIFE"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-KNIFE
	(LOC CH-PLAYER)
	(DESC "dive knife")
	(FLAGS FL-KNIFE FL-TAKEABLE)
	(SYNONYM KNIFE)
	(ADJECTIVE DIVE)
	(ACTION RT-TH-KNIFE)
>
 
<ROUTINE RT-TH-KNIFE ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
;"***************************************************************************"
; "end of file"
;"***************************************************************************"
 
