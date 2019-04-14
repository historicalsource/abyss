;"***************************************************************************"
; "game : Abyss"
; "file : SUB-BAY.ZIL"
; "auth :   $Author:   DEB  $"
; "date :     $Date:   20 Mar 1989  8:45:40  $"
; "rev  : $Revision:   1.30  $"
; "vers : 1.0"
;"---------------------------------------------------------------------------"
; "Sub bay"
; "Copyright (C) 1988 Infocom, Inc.  All rights reserved."
;"***************************************************************************"
 
;"---------------------------------------------------------------------------"
; "RM-SUB-BAY"
;"---------------------------------------------------------------------------"
 
<ROOM RM-SUB-BAY
	(LOC ROOMS)
	(DESC "sub bay")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM BAY)
	(ADJECTIVE SUB)
	(DOWN TO RM-UNDER-MOONPOOL)
	(FORE TO RM-CORRIDOR)
	(AFT TO RM-GAS-MIX-ROOM)
;	(PORT TO RM-SHOWER-ROOM)
	(GLOBAL LG-WALL RM-UNDER-MOONPOOL RM-CORRIDOR RM-GAS-MIX-ROOM ;RM-SHOWER-ROOM)
	(ACTION RT-RM-SUB-BAY)
>
 
<ROUTINE RT-RM-SUB-BAY ("OPTIONAL" (CONTEXT <>))
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
the ,RM-SUB-BAY ", which seems cavernous compared to the other cramped
compartments aboard Deepcore. It is dominated by the MoonPool, which looks
just like a huge swimming pool, except that it is open to the sea below.|
	Along one edge of the MoonPool is a large dive locker. A door in the port
bulkhead leads to the shower room. Aft is the gas-mix room, and in the fore
wall is the doorway that leads to the corridor.|"
			>
			<RFALSE>
		)
		(<MC-CONTEXT? ,M-BEG>
			<COND
				(<FSET? ,TH-PLASTIC-CARD ,FL-SEEN>
					<COND
						(<FSET? ,CH-COFFEY ,FL-BROKEN>
							<RFALSE>
						)
						(<OR	<GAME-VERB?>
								<VERB? GIVE-SWP>
							>
							<RFALSE>
						)
						(<OR	<NOT <VERB? GIVE>>
								<NOT <MC-PRSO? ,TH-PLASTIC-CARD>>
								<NOT <MC-PRSI? ,CH-COFFEY>>
							>
							<COND
								(<ZERO? ,GL-COFFEY-SHOOT>
									<SETG GL-COFFEY-SHOOT <+ ,GL-COFFEY-SHOOT 1>>
									<TELL
"	Coffey fires a bullet just past your head. \"Next one's for you, drill
boy.\"" CR
									>
								)
								(T
									<TELL
"	Coffey raises his aim until the gun is pointed right between your eyes.
\"Bye, bye, Mr Chips.\" He starts to squeeze the trigger. The last thing you
notice before you die is how perfectly round the end of a gun's barrel is.|"
									>
									<RT-END-OF-GAME>
								)
							>
						)
					>
				)
			>
		)
		(<MC-CONTEXT? ,M-ENTERED>
			<COND
				(<FSET? ,TH-PLASTIC-CARD ,FL-SEEN>
					<COND
						(<NOT ,GL-RETURN2-DONE?>
							; "Return #2 puzzle."
							<MOVE ,TH-DRY-SUIT ,HERE>
							<FCLEAR ,TH-DRY-SUIT ,FL-WORN>
							<MOVE ,CH-CATFISH ,RM-SUB-BAY>
							<MOVE ,CH-COFFEY ,RM-SUB-BAY>
							<SETG GL-RETURN2-DONE? T>
							<TELL
"	You surface in the MoonPool. Catfish grabs your hand and hoists you to
firm ground as easily as if you were a child. He helps you out of your dive
suit and into dry clothes.|
	Suddenly Coffey comes into the room and levels his gun at your chest.
\"I'll take those codes,\" he announces." CR
							>
						)
					>
				)
				(<FSET? ,LG-BUCKLED-DOOR ,FL-OPEN>
					<COND
						(<NOT ,GL-RETURN1-DONE?>
							; "Return #1 puzzle."
							<MOVE ,TH-DRY-SUIT ,HERE>
							<FCLEAR ,TH-DRY-SUIT ,FL-WORN>
							<MOVE ,CH-LINDSEY ,RM-SUB-BAY>
							<MOVE ,CH-COFFEY ,RM-MESS-HALL>
							<MOVE ,CH-CATFISH ,RM-MESS-HALL>
							<FSET ,CH-CATFISH ,FL-ASLEEP>
							<SETG GL-RETURN1-DONE? T>
							<TELL
"	You surface in the MoonPool. Lindsey pulls you out of the water. She
strips you of the cumbersome dive suit, towels you off, and helps you into
dry clothes.|
	Then she says, \"Bud we've got a problem. Coffey caught Catfish trying to
break into the dive locker in the Sub-bay. The asshole knocked Catfish over
the head with the butt of his gun and then dragged him to the mess hall. Now
he's standing over him in the mess hall and claiming that Cat's a Russian
spy. He says as soon at Catfish comes around, he's going to give him a
summary court martial, find him guilty, and shoot him on the spot!\"" CR
							>
						)
					>
				)
			>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
<OBJECT TH-MOON-POOL
	(LOC RM-SUB-BAY)
	(DESC "moon pool")
	(FLAGS FL-CONTAINER FL-OPEN FL-SEARCH FL-WATER)
	(SYNONYM POOL)
	(ADJECTIVE MOON)
	(ACTION RT-TH-MOON-POOL)
>
 
<ROUTINE RT-TH-MOON-POOL ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? ENTER>
			<COND
				(<MC-HERE? ,RM-SUB-BAY>
					<RT-DO-WALK ,P?DOWN>
				)
				(<MC-HERE? ,RM-UNDER-MOONPOOL>
					<RT-DO-WALK ,P?UP>
				)
			>
		)
	>
>
 
;"***************************************************************************"
; "FIRE PUZZLE"
;"***************************************************************************"
 
<OBJECT TH-FIRE
;	(LOC RM-SUB-BAY)
	(DESC "fire")
	(FLAGS FL-CONTAINER FL-OPEN FL-SEARCH)
	(SYNONYM FIRE)
	(ACTION RT-TH-FIRE)
>
 
<ROUTINE RT-TH-FIRE ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXTINGUISH>
			<COND
				(<AND <IN? ,TH-WATER-HOSE ,WINNER>
						<FSET? ,TH-WATER-HOSE ,FL-ON>
					>
					<REMOVE ,TH-FIRE>
					<RT-DEQUEUE ,RT-I-FIRE-1>
					<RT-DEQUEUE ,RT-I-FIRE-2>
					<TELL
"	The water hisses into the wall of flame without appearing to have any
effect. Then, slowly, the intensity of the fire seems to lessen. After a few
moments, the flames die back, and all that remains of the fire are charred
bits of smouldering embers." CR
					>
				)
				(T
					<TELL ,K-HOW-INTEND-MSG CR>
				)
			>
		)
	>
>
 
<ROUTINE RT-I-FIRE-1 ()
	<RT-QUEUE ,RT-I-FIRE-2 <+ ,GL-MOVES 6>>
	<COND
		(<MC-HERE? ,RM-SUB-BAY>
			<TELL
"	The flames reach the wooden locker, and it starts to burn." CR
			>
		)
	>
>
 
<ROUTINE RT-I-FIRE-2 ()
	<TELL
"	Suddenly the dive locker explodes with tremendous fury, ripping a gaping
hole in the roof of the Sub-bay. Seconds later you are engulfed by a wall of
water and you drown.|"
	>
	<RT-END-OF-GAME>
>
 
<OBJECT TH-WATER-HOSE
	(LOC RM-SUB-BAY)
	(DESC "hose")
	(FLAGS FL-CONTAINER FL-OPEN FL-SEARCH FL-TAKEABLE)
	(SYNONYM HOSE)
	(ADJECTIVE FRESH WATER)
	(ACTION RT-TH-WATER-HOSE)
>
 
<ROUTINE RT-TH-WATER-HOSE ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? TURN-ON>
			<RT-TH-NOZZLE>
		)
	>
>
 
<OBJECT TH-NOZZLE
	(LOC TH-WATER-HOSE)
	(DESC "nozzle")
	(SYNONYM NOZZLE)
	(ADJECTIVE HOSE)
	(ACTION RT-TH-NOZZLE)
>
 
<ROUTINE RT-TH-NOZZLE ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? TURN TURN-ON OPEN>
			<COND
				(,GL-WATER-PUMP-ON
					<FSET ,TH-WATER-HOSE ,FL-ON>
					<TELL "	A stream of water leaps from the nozzle." CR>
				)
				(T
					<TELL "	Nothing happens." CR>
				)
			>
		)
	>
>
 
<OBJECT TH-OXYGEN-CYLINDER
	(LOC RM-SUB-BAY)
	(DESC "oxygen cylinder")
	(FLAGS FL-NO-DESC)
	(SYNONYM CYLINDER)
	(ADJECTIVE OXYGEN)
	(ACTION RT-TH-OXYGEN-CYLINDER)
>
 
<ROUTINE RT-TH-OXYGEN-CYLINDER ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
;"***************************************************************************"
; "PEOPLE"
;"***************************************************************************"
 
<OBJECT CH-LINDSEY
	(LOC RM-COMMAND-MODULE)
	(DESC "Lindsey")
	(FLAGS FL-ALIVE FL-FEMALE FL-NO-ARTICLE FL-OPEN FL-PERSON FL-SEARCH)
	(SYNONYM LINDSEY WOMAN PERSON)
>
 
<OBJECT CH-COFFEY
	(LOC RM-CORRIDOR)
	(DESC "Coffey")
	(FLAGS FL-ALIVE FL-NO-ARTICLE FL-NO-DESC FL-OPEN FL-PERSON FL-SEARCH)
	(SYNONYM COFFEY DIVER MAN PERSON)
	(ADJECTIVE NAVY)
	(ACTION RT-CH-COFFEY)
>
 
<ROUTINE RT-CH-COFFEY ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(,NOW-PRSI
			<COND
				(<VERB? GIVE>
					<COND
						(<AND <IN? ,CH-COFFEY ,RM-SUB-BAY>
								<FSET? ,TH-PLASTIC-CARD ,FL-SEEN>
								<MC-PRSO? ,TH-PLASTIC-CARD>
							>
							<MOVE ,TH-PLASTIC-CARD ,CH-COFFEY>
							<REMOVE ,TH-GUN>
							<FSET ,CH-COFFEY ,FL-BROKEN>
							<FSET ,TH-COMPRESSOR ,FL-BROKEN>
							<MOVE ,CH-COFFEY ,RM-COMPRESSION-CHAMBER>
							<SETG OHERE ,HERE>
							<SETG HERE ,RM-GAS-MIX-ROOM>
							<MOVE ,CH-PLAYER ,RM-GAS-MIX-ROOM>
							<TELL
"	Coffey bends over the wiring codes, glancing up occasionally to make sure
you don't try to attack him.|
	Suddenly you notice a strange phenomenon in the MoonPool behind him. Some
water is slowly forming into a shining column and rising above the surrounding
surface. After a few moments, a sort of three-fingered hand forms at the end
of the column. As you stare at in fascination, it slowly, silently, creeps up
behind Coffey, who remains oblivious to its presence.||
 
	[GRAPHIC]||
 
	Suddenly the pseudopod reaches out and snatches the gun from Coffey. He
whips around in time to see the column disappear below the surface of the
water, carrying his gun with it.|
	Something inside Coffey seems to snap. He looks at you wildly and shouts,
\"I know you're behind this, Brigman. I don't know what you want from that
sub, but I'm gonna make sure you never see it again.\" He turns and runs from
the room.|
	You follow Coffey. When he reaches the compressor room, Coffey brandishes
a tool over the compressor. As he sees you enter, he thrusts the tool deep
into the workings of the machine. It screams to a halt with an ear-piercing
shriek. Coffey yells over the noise, \"Up yours, Brigman!\" and dashes out of
the cylinder.|
	He then runs into the compression chamber. Through the open door to the
compression chamber, you can see Coffey tugging at the hatch that leads up to
Cab Three. He is unable to open it because Lindsey has locked it from the
other side." CR
							>
						)
					>
				)
			>
		)
		(<VERB? ASK-ABOUT>
			<COND
				(<MC-PRSI? ,CH-SEALS ;,CH-RUSSIANS>
					<TELL "	\"Goddam bitch killed some of my best men.\"" CR>
				)
				(<MC-PRSI? ,LG-MONTANA>
					<TELL
"	\"I took a quick look at her before I had to come back. They closed the
mid-ships hatch, but it's clear that some of the interior bulkheads are
buckled. We're probably going to need some explosives to move around in there.
There's a gash in her side up near the bow, but the opening isn't big enough
for a man to fit through.\"" CR
					>
				)
				(<MC-PRSI? ,TH-SAFE>
					<COND
						(<NOT <FSET? ,TH-SAFE ,FL-SEEN>>
							<TELL
"	It'll be in his cabin, just forward of the attack center." CR
							>
						)
						(T	;<NOT <FSET? ,TH-SAFE ,FL-OPENED>>
							<TELL
"	I don't know how to open it. Each captain sets his own combination." CR
							>
						)
					;	(T
							; "Bob"
							<TELL
							>
						)
					>
				)
				(<MC-PRSI? ,TH-PLASTIC-CARD ;,TH-WIRING-CODES>
					<COND
						(<NOT <FSET? ,CH-COFFEY ,FL-BROKEN>>	;"Not crazy?"
							<TELL
"	\"Different missiles have different wiring diagrams. When you want to
disarm one, you need the wiring codes to tell you the order to cut the
wires.\"" CR
							>
						)
						(<FSET? ,CH-COFFEY ,FL-ASLEEP>	;"Under nitrogen narcosis"
							<TELL
"	One of mnemonic series:|
Oxford rows great big wide yachts.|
Yankees rarely win over Green Bay.|
Get rid of your wet bananas.|
Go west, young boy, or rot." CR
							>
						)
						(T
							<TELL "	\"I ain't tellin you nothing, pinko.\"" CR>
						)
					>
				)
				(<MC-PRSI? ,TH-FLATBED>
					<TELL
"	\"The goddam bitch just rode it into the trench. I'll get even with her
yet.\"" CR
					>
				)
				(<MC-PRSI? ,TH-MISSILE-TIMER>
					<TELL
"	\"They set it for 12 hours so they'd have enough time to get away and
save their skins. It may be booby-trapped, so we can't risk trying to disable
it. Our only hope is to disarm the MIRV.\"" CR
					>
				)
				(<MC-PRSI? ,TH-MISSILE-ACCESS-KEY>
					<TELL
"	\"There's always a duplicate access key on board somewhere. Usually the
executive officer has it, but it's not as important as the missile firing
key, so sometimes he just hangs it on the wall in the maintenance room so the
technicians can get to it if they need it.\"" CR
					>
				)
				(<FSET? ,CH-COFFEY ,FL-BROKEN>	;"Crazy?"
					<TELL
"	\"Coffey, James G.; Lieutenant U.S. Navy; Serial Number 5894256\"" CR
					>
				)
				(T
					<TELL "	\"I don't know about that.\"" CR>
				)
			>
		)
	>
>
 
<OBJECT CH-ONE-NIGHT
	(LOC RM-CORRIDOR)
	(DESC "One-night")
	(FLAGS FL-ALIVE FL-FEMALE FL-NO-ARTICLE FL-NO-DESC FL-OPEN FL-PERSON FL-SEARCH)
	(SYNONYM NIGHT ONE-NIGHT WOMAN PERSON)
	(ADJECTIVE ONE)
	(ACTION RT-CH-ONE-NIGHT)
>
 
<ROUTINE RT-CH-ONE-NIGHT ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(,NOW-PRSI
			<RFALSE>
		)
		(<VERB? ASK-ABOUT>
			<COND
				(<MC-PRSI? ,TH-UFO>
					<TELL
"	\"I only saw it for a moment. It was big and shiny. But until it started
pulling us into the trench it somehow seemed, well, sort of friendly.\"" CR
					>
				)
			>
		)
	>
>
 
<OBJECT CH-HIPPY
	(LOC RM-CORRIDOR)
	(DESC "Hippy")
	(FLAGS FL-ALIVE FL-NO-ARTICLE FL-NO-DESC FL-OPEN FL-PERSON FL-SEARCH)
	(SYNONYM HIPPY MAN PERSON)
>
 
<OBJECT CH-CATFISH
	(LOC RM-COMMAND-MODULE)
	(DESC "Catfish")
	(FLAGS FL-ALIVE FL-NO-ARTICLE FL-OPEN FL-PERSON FL-SEARCH)
	(SYNONYM CATFISH DEVRIES FISH MAN PERSON)
	(ADJECTIVE CAT)
>
 
<OBJECT CH-SEALS
	(LOC GENERIC-OBJECTS)
	(DESC "SEALs")
	(SYNONYM
		WILLHITE SCHOENICK MONK SEAL SEALS DIVER DIVERS MAN MEN PERSON PEOPLE
	)
	(ADJECTIVE NAVY)
>
 
; "Is the following right?"
<NEW-ADD-WORD "PEOPLE" NOUN <VOC "PERSON"> ,PLURAL-FLAG>
<NEW-ADD-WORD "WOMEN" NOUN <VOC "WOMAN"> ,PLURAL-FLAG>
<NEW-ADD-WORD "MEN" NOUN <VOC "MAN"> ,PLURAL-FLAG>
 
;<NEW-ADD-WORD "FROBS" NOUN <VOC "FROB"> ,PLURAL-FLAG>
 
;"---------------------------------------------------------------------------"
; "TH-DRY-SUIT"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-DRY-SUIT
	(LOC TH-BUD-GEAR-LOCKER)
	(DESC "dry suit")
	(FLAGS FL-CLOTHING FL-CONTAINER FL-OPEN FL-SEARCH FL-TAKEABLE)
	(SYNONYM SUIT)
	(ADJECTIVE DRY)
	(SIZE 5)
	(ACTION RT-TH-DRY-SUIT)
>
 
<ROUTINE RT-TH-DRY-SUIT ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE>
			<TELL
"	It is a custom-made, one-piece dry suit that was designed especially for
you. It zips up the front and includes flippers, a weight belt, and a helmet.
The helmet has two threaded sockets on the side, and the faceplate is"
open ,TH-FACEPLATE "." CR
			>
		)
		(<VERB? WEAR>
			<COND
				(<MC-WINNER? ,CH-PLAYER>
					<RT-MOVE-ALL ,CH-PLAYER ,HERE>	 ;"RT-MOVE-ALL clears FL-WORN."
					<MOVE ,TH-DRY-SUIT ,CH-PLAYER>
					<FSET ,TH-DRY-SUIT ,FL-WORN>
					<TELL
"	You drop everything you were carrying, strip down to your bathing suit,
and step into the dry suit. You pull up the zipper and adjust the weight
belt." CR
					>
				)
				(T
					; "Bob"
					<TELL "	The dry suit won't fit" the ,WINNER "." CR>
				)
			>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "TH-FACEPLATE"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-FACEPLATE
	(LOC TH-DRY-SUIT)
	(DESC "faceplate")
	(FLAGS FL-NO-DESC FL-OPEN FL-OPENABLE FL-TRANSPARENT)
	(SYNONYM FACEPLATE PLATE)
	(ADJECTIVE FACE)
	(ACTION RT-TH-FACEPLATE)
>
 
<ROUTINE RT-TH-FACEPLATE ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE>
			<TELL "	The faceplate is" open ,TH-FACEPLATE "." CR>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "TH-HELMET"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-HELMET
	(LOC TH-DRY-SUIT)
	(DESC "helmet")
	(FLAGS FL-CONTAINER FL-NO-DESC FL-OPEN FL-SEARCH)
	(SYNONYM HELMET)
	(ADJECTIVE DRY SUIT)
	(ACTION RT-TH-HELMET)
>
 
<ROUTINE RT-TH-HELMET ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE>
			<TELL
"	The helmet has two threaded sockets on the side, and the faceplate is"
open ,TH-FACEPLATE "." CR
			>
		)
	>
>
 
<OBJECT TH-HOOK-1
	(LOC RM-SUB-BAY)
	(DESC "hook")
	(FLAGS FL-SURFACE)
	(SYNONYM HOOK)
	(ACTION RT-TH-HOOK-1)
>
 
<ROUTINE RT-TH-HOOK-1 ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
;"---------------------------------------------------------------------------"
; "TH-LIFT-BAG"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-LIFT-BAG
	(LOC TH-HOOK-1)
	(DESC "lift bag")
	(FLAGS FL-SURFACE FL-SEARCH FL-TAKEABLE)
	(SYNONYM BAG)
	(ADJECTIVE LIFT)
	(SIZE 5)
	(ACTION RT-TH-LIFT-BAG)
>
 
; "TH-LIFT-BAG flags:"
; "	FL-LOCKED - Inflated."
; "	FL-BROKEN - Cut & can't be inflated."
 
<GLOBAL GL-LIFT-OBJ <>> ; "The object the lift bag is tied to"
 
<ROUTINE RT-TH-LIFT-BAG ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<AND <VERB? TAKE>
				,GL-LIFT-OBJ
			>
			<COND
				(<FSET? ,GL-LIFT-OBJ ,FL-TAKEABLE>
					; "Pick up lift bag and ,GL-LIFT-OBJ"
				)
				(T
					<TELL "	The lift bag is tied to" the ,GL-LIFT-OBJ "." CR>
				)
			>
		)
		(<AND <VERB? TIE-TO ATTACH>
				<MC-PRSO? ,TH-LIFT-BAG>
			>
			<SETG GL-LIFT-OBJ ,PRSI>
			<SET L <LOC ,PRSI>>
			<COND
				(<EQUAL? .L ,LOCAL-GLOBALS ,GLOBAL-OBJECTS>
					<SET L ,HERE>
				)
			>
			<MOVE ,TH-LIFT-BAG .L>
			<TELL "	You tie the lift bag to" the ,GL-LIFT-OBJ "." CR>
		)
		(<VERB? EXAMINE>
			<COND
				(,GL-LIFT-OBJ
					<TELL "	The lift bag is tied to" the ,GL-LIFT-OBJ "." CR>
				)
				(T
					<TELL "	The lift bag is a">
					<COND
						(<FSET? ,TH-LIFT-BAG ,FL-LOCKED>
							<TELL "n inflated">
						)
						(T
							<TELL " collapsed">
						)
					>
					<TELL " watertight sack ">
					<COND
						(<FSET? ,TH-LIFT-BAG ,FL-BROKEN>
							<TELL "that has been sliced open." CR>
						)
						(T
							<TELL
"with a small nylon loop at the top and two loose ropes hanging down from the
bottom. Attached to the bag is a CO2 cannister that has a red button on it." CR
							>
						)
					>
				)
			>
		)
		(<VERB? INFLATE>
			<TELL ,K-HOW-INTEND-MSG CR>
		)
		(<AND <VERB? CUT>
				<MC-PRSI? ,TH-KNIFE>
			>
			<FSET ,TH-LIFT-BAG ,FL-BROKEN>
			<TELL "	You slice the fabric with your knife,">
			<COND
				(<FSET? ,TH-LIFT-BAG ,FL-LOCKED>
					<TELL " releasing the gas">
					<COND
						(<FSET? ,HERE ,FL-WATER>
							<TELL " in a huge bubble and">
						)
						(T
							<TELL " and">
						)
					>
				)
			>
			<TELL " rendering the bag completely useless.|">
			<COND
				(<AND <FSET? ,TH-LIFT-BAG ,FL-LOCKED>
						<EQUAL? ,LG-MIDSHIP-HATCH ,GL-LIFT-OBJ>
					>
					<FCLEAR ,LG-MIDSHIP-HATCH ,FL-OPEN>
					<TELL "	The hatch slams shut." CR>
				)
				(<IN? ,TH-LIFT-BAG ,CH-PLAYER>
					<COND
						(<AND <FSET? ,HERE ,FL-WATER>
								<FSET? ,HERE ,FL-INDOORS>
							>
							<TELL "	The bag no longer contrains your movements." CR>
						)
					;	(<IN? ,CH-PLAYER ,TH-MOON-POOL>
							<TELL "	You sink below the surface of the water." CR>
						)
					>
				)
			>
			<RTRUE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "TH-CO2-CANNISTER"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-CO2-CANNISTER
	(LOC TH-LIFT-BAG)
	(DESC "CO2 cannister")
	(FLAGS FL-NO-DESC FL-SURFACE FL-SEARCH)
	(SYNONYM CANNISTER)
	(ADJECTIVE CO2 CARBON DIOXIDE)
	(SIZE 5)
	(ACTION RT-TH-CO2-CANNISTER)
>
 
; "TH-CO2-CANNISTER flags:"
; "	FL-BROKEN - Cannister is empty."
 
<ROUTINE RT-TH-CO2-CANNISTER ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE LOOK-ON>
			<TELL "	The cannister has a red button on it." CR>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "TH-RED-BUTTON"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-RED-BUTTON
	(LOC TH-CO2-CANNISTER)
	(DESC "red button")
	(FLAGS FL-NO-DESC)
	(SYNONYM BUTTON)
	(ADJECTIVE RED)
	(ACTION RT-TH-RED-BUTTON)
>
 
; "FLAGS:	FL-BROKEN = the red button has been pushed already."
 
<ROUTINE RT-TH-RED-BUTTON ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE>
			<TELL "	Pretty normal-looking red button." CR>
		)
		(<VERB? PUSH>
			<COND
				(<FSET? ,TH-CO2-CANNISTER ,FL-BROKEN>
					<TELL "	Nothing happens." CR>
				)
				(T
					<FSET ,TH-CO2-CANNISTER, FL-BROKEN>
					<COND
						(<FSET? ,TH-LIFT-BAG ,FL-BROKEN>
							<TELL
"	The gas rushes into the lift bag and out the gash in the fabric"
							>
							<COND
								(<FSET? ,HERE ,FL-WATER>
									<TELL
", rising quickly out of sight in a large bubble"
									>
								)
							>
							<TELL "." CR>
						)
						(T
							<FSET ,TH-LIFT-BAG ,FL-LOCKED>
							<TELL "	The bag inflates like a hot air balloon">
							<COND
								(<IN? ,TH-LIFT-BAG ,CH-PLAYER>
									<COND
										(<FSET? ,HERE ,FL-WATER>
											<COND
												(<MC-HERE? ,RM-UNDER-MOONPOOL>
													<TELL
", pulling you up to the surface of the MoonPool." CR
													>
												;	<MOVE ,CH-PLAYER ,RM-MOONPOOL>
; "DUANE - Prevent the player from swimming down into the water until he
drops the lift bag or cuts it open. 'You sink below the surface of the water.
On the bulkhead nearby you see the hookah nozzles protrude from their housing."
												)
												(<FSET? ,HERE ,FL-INDOORS>
													<TELL
", pulling you up until you hit the ceiling." CR
													>
; "DUANE - Prevent the player from doing anything until he drops the lift bag
or cuts it with his knife. If he cuts the bag, give him the gas escaping msg
and then 'The bag no longer contrains your movements.'"
												)
												(T
													<TELL
". Before you know what's happening, the extra lift starts to pull you
rapidly toward the surface. Your ears pop and you feel excruciating pain
in your elbows and knees. Mercifully, you pass out before suffering the
gruesome death of sudden decompression.|"
													>
													<RT-END-OF-GAME>
												)
											>
										)
										(T
											<TELL "." CR>
										)
									>
								)
								(<EQUAL? ,GL-LIFT-OBJ ,LG-MIDSHIP-HATCH>
									<FSET ,LG-MIDSHIP-HATCH ,FL-OPEN>
									<TELL ". The hatch slowly swings open." CR>
								)
								(<FSET? ,HERE ,FL-WATER>
									<COND
										(<MC-HERE? ,RM-UNDER-MOONPOOL>
										)
										(<FSET? ,HERE ,FL-INDOORS>
										)
										(T
										)
									>
								)
								(T
									<TELL "." CR>
								)
							>
						)
					>
				)
			>
		)
	>
>
 
;"***************************************************************************"
; "OTHER ROOMS"
;"***************************************************************************"
 
;"---------------------------------------------------------------------------"
; "RM-COMPRESSION-CHAMBER"
;"---------------------------------------------------------------------------"
 
<ROOM RM-COMPRESSION-CHAMBER
	(LOC ROOMS)
	(DESC "compression chamber")
	(MENU "chamber")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM CHAMBER)
	(ADJECTIVE COMPRESSION)
	(FORE TO RM-GAS-MIX-ROOM IF LG-CHAMBER-DOOR IS OPEN)
	(UP TO RM-CAB-THREE IF LG-CHAMBER-HATCH IS OPEN)
	(GLOBAL LG-WALL RM-GAS-MIX-ROOM LG-CHAMBER-DOOR LG-CHAMBER-HATCH)
	(ADJACENT <TABLE (BYTE PURE) RM-GAS-MIX-ROOM T>)
	(ACTION RT-RM-COMPRESSION-CHAMBER)
>
 
<ROUTINE RT-RM-COMPRESSION-CHAMBER ("OPTIONAL" (CONTEXT <>))
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
the ,RM-COMPRESSION-CHAMBER ". This is a tiny cylinder constructed from HY-150
Steel, designed to withstand pressures of up to 300 atmospheres, or 10,000
feet below sea-level. Along one wall is a bench that is built like a window
seat. There is a hatch in the ceiling. A door in the fore bulkhead leads out
to the gas-mix room.|"
			>
			<RFALSE>
		)
		(<MC-CONTEXT? ,M-EXIT>
			<COND
				(<RT-IS-QUEUED? ,RT-I-UFO-MESSAGE>
					<RT-DEQUEUE ,RT-I-UFO-MESSAGE>
					<MOVE ,CH-COFFEY ,RM-SUB-BAY>
					<MOVE ,CH-HIPPY ,RM-SUB-BAY>
					<TELL
"	You start to leave, but One-Night plucks at your sleeve and holds you
back. " ,K-UFO-MSG
					>
				)
			>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
<OBJECT LG-CHAMBER-HATCH
	(LOC LOCAL-GLOBALS)
	(DESC "compression chamber hatch")
	(MENU "hatch")
	(FLAGS FL-DOOR FL-OPENABLE)
	(SYNONYM HATCH)
	(ADJECTIVE COMPRESSION CHAMBER)
	(ACTION RT-LG-CHAMBER-HATCH)
>
 
<ROUTINE RT-LG-CHAMBER-HATCH ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? OPEN>
			<COND
				(<FSET? ,LG-CHAMBER-HATCH ,FL-OPEN>
					<RFALSE>
				)
				(<NOT ,GL-CAB-DOCKED?>
					<TELL
"	Since a cab is not docked, the hatch refuses to open." CR
					>
				)
				(<AND <IN? ,CH-COFFEY ,RM-CAB-THREE>
						<FSET? ,CH-COFFEY ,FL-ALIVE>
					>
					<FSET ,LG-CHAMBER-HATCH ,FL-OPEN>
					<RT-DEQUEUE ,RT-I-RETURN-2>
					<RT-DEQUEUE ,RT-I-RETURN-3>
					<RT-DEQUEUE ,RT-I-RETURN-4>
					<RT-QUEUE ,RT-I-UFO-MESSAGE <+ ,GL-MOVES 1>>
					<MOVE ,CH-COFFEY ,RM-COMPRESSION-CHAMBER>
					<MOVE ,CH-HIPPY ,RM-COMPRESSION-CHAMBER>
					<MOVE ,CH-ONE-NIGHT ,RM-COMPRESSION-CHAMBER>
					<TELL
"	You open the hatch and an exhausted Coffey drops into the chamber. He no
longer looks crisp and military. His uniform is ragged and there is a gash in
his right shoulder. He slumps onto the bench. Hippy is next through the hatch.
He hangs briefly by one arm and then lets go. Another pair of legs dangles
from the ceiling, and then One-Night falls to the floor with a loud groan. Her
clothes are soaked, and she is shivering from the cold.||"
					>
					<MARGIN 50 50>
					<TELL
"[GRAPHIC #4: Shot in the compression chamber of the three of them - beat up
and exhausted.]||"
					>
					<MARGIN 0 0>
					<TELL
"	You wait a moment, expecting the other SEALS to come through the hatch,
but no one does. Coffey looks at you angrily. \"Dead,\" he says. They're all
dead.\" He points accusingly at One-Night, \"And it's all "
					>
					<HLIGHT ,K-H-BLD>
					<TELL "her">
					<HLIGHT ,K-H-NRM>
					<TELL
" fault.\" You look at One-Night, but she just shakes her head.|
	Coffey wipes his face with his sleeve. \"By the time we got over to the
Montana, the other submersible had already cleared out. I ordered Flatbed to
check out the stern of the ship while I reconnoitered the bow. But when I
returned to the rendezvous point, no one was there. Then I saw "
					>
					<HLIGHT ,K-H-BLD>
					<TELL "Miss">
					<HLIGHT ,K-H-NRM>
					<TELL
" Standing free-swimming towards the Cab. We brought her in through the hatch,
and she told us some bullshit story about being sucked into the trench in the
wake of a glowing ship and then crashing Flatbed into a wall.\"|
	\"I don't know what really happened, but I do know that this bitch has
killed three of my best men and that she's going to pay for it.\"|
	\"But wait, it gets better. Whoever those bastards in the submersible
were, they've armed one of the MIRVs and attached a timer to it that's set to
go off in 12 hours.\"|
	\"They must have taken the access key from the sub captain's body and
then used it to open up the MIRV. I took a look at that timer. No way we can
disable it safely. Our only hope is to find the duplicate access key. Then we
gotta break into the captain's safe, get the missile wiring codes, and cut the
wires.\"|
	The three of them struggle to their feet and start to leave, but
One-Night catches your eye and signals you to wait." CR
					>
				)
			>
		)
	>
>
 
<ROUTINE RT-I-LEAVE-1 ()
	<RT-QUEUE ,RT-I-LEAVE-2 <+ ,GL-MOVES 1>>
	<MOVE ,CH-ONE-NIGHT ,RM-SUB-BAY>
	<MOVE ,CH-HIPPY ,RM-SUB-BAY>
	<MOVE ,CH-COFFEY ,RM-SUB-BAY>
	<COND
		(<MC-HERE? ,RM-CORRIDOR>
			<TELL
"	One-Night, Hippy, and the SEALs disappear aft into the sub-bay." CR
			>
		)
	>
>
 
<ROUTINE RT-I-LEAVE-2 ()
	<RT-QUEUE ,RT-I-LEAVE-3 <+ ,GL-MOVES 1>>
	<FCLEAR ,CH-ONE-NIGHT ,FL-NO-DESC>
	<MOVE ,CH-ONE-NIGHT ,RM-CAB-THREE>
	<MOVE ,CH-HIPPY ,RM-GAS-MIX-ROOM>
	<MOVE ,CH-COFFEY ,RM-GAS-MIX-ROOM>
	<COND
		(<MC-HERE? ,RM-SUB-BAY>
			<TELL
"	One-Night drops through Flatbed's hatch. Monk and Willhite gather up
their dive gear and follow her, pulling the hatch shut behind them. The big
submersible sinks into the MoonPool and then disappears from sight. Coffey
picks up a case marked \"FSB -- MARK IV,\" puts it in the dive locker, and
pockets the key. Then he follows Hippy and Schoenick into the gas-mix room." CR
			>
		)
	>
>
 
<ROUTINE RT-I-LEAVE-3 ()
	<RT-QUEUE ,RT-I-LEAVE-4 <+ ,GL-MOVES 1>>
	<MOVE ,CH-HIPPY ,RM-COMPRESSION-CHAMBER>
	<MOVE ,CH-COFFEY ,RM-COMPRESSION-CHAMBER>
	<COND
		(<MC-HERE? ,RM-GAS-MIX-ROOM>
			<TELL
"	Hippy, Coffey, and Schoenick enter the compression chamber." CR
			>
		)
	>
>
 
<ROUTINE RT-I-LEAVE-4 ()
	<FCLEAR ,CH-HIPPY ,FL-NO-DESC>
	<FCLEAR ,CH-COFFEY ,FL-NO-DESC>
	<MOVE ,CH-HIPPY ,RM-CAB-THREE>
	<MOVE ,CH-COFFEY ,RM-CAB-THREE>
	<COND
		(<MC-HERE? ,RM-GAS-MIX-ROOM ,RM-COMPRESSION-CHAMBER>
			<TELL TAB>
			<COND
				(<MC-HERE? ,RM-GAS-MIX-ROOM>
					<TELL "Through the ">
					<COND
						(<FSET? ,LG-CHAMBER-DOOR ,FL-OPEN>
							<TELL "door">
						)
						(T
							<TELL "window">
						)
					>
					<TELL " you see ">
				)
			>
			<TELL
"Hippy and the two SEALs climb up into Cab Three and pull the hatch shut
behind them. Moments later you hear a 'clank' as Cab Three pulls away from
Deepcore's hull." CR
			>
		)
	>
>
 
<ROUTINE RT-I-RETURN-1 ()
	<RT-QUEUE ,RT-I-RETURN-2 <+ ,GL-MOVES 10>>
	<SETG GL-CAB-DOCKED? T>
	<FSET ,RM-CAB-THREE ,FL-BROKEN>
	<TELL
"	The intercom buzzes and you hear One-Night's voice: \"This is Cab Three
docking over the compression chamber, boss. The heater's busted and we've got
wounded. Come open the hatch before we freeze to death.\"" CR
	>
>
 
<ROUTINE RT-I-RETURN-2 ()
	<RT-QUEUE ,RT-I-RETURN-3 <+ ,GL-MOVES 10>>
	<TELL
"	The intercom buzzes and you hear One-Night again. \"Better hurry, boss.
I don't know if we're all gonna make it.\"" CR
	>
>
 
<ROUTINE RT-I-RETURN-3 ()
	<RT-QUEUE ,RT-I-RETURN-4 <+ ,GL-MOVES 5>>
	<TELL
"	The intercom buzzes for a moment, and then trails off into silence." CR
	>
>
 
<ROUTINE RT-I-RETURN-4 ()
	; "Kill everyone in the cab"
	<FCLEAR ,CH-COFFEY ,FL-ALIVE>
	<FCLEAR ,CH-HIPPY ,FL-ALIVE>
	<FCLEAR ,CH-ONE-NIGHT ,FL-ALIVE>
	<RFALSE>
>
 
<CONSTANT K-UFO-MSG
"\"I swear it's all true, Bud. I saw...something. It was right in front of us
and then it dived into the trench, pulling us along after it. Then we hit the
side of the trench and I blacked out for a second. When I came to, Flatbed was
spinning out of control into the trench. None of the controls worked. I did
the only thing I could do. I bailed out. But I didn't kill those men...\" her
voice trails off, \"...there was nothing I could do...\"|">
 
<ROUTINE RT-I-UFO-MESSAGE ()
	<MOVE ,CH-COFFEY ,RM-SUB-BAY>
	<MOVE ,CH-HIPPY ,RM-SUB-BAY>
	<TELL
"	When Coffey and Hippy have left, One-Night plucks your sleeve and says,"
,K-UFO-MSG
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-CAB-THREE"
;"---------------------------------------------------------------------------"
 
<ROOM RM-CAB-THREE
	(LOC ROOMS)
	(DESC "Cab three")
	(FLAGS FL-CONTAINER FL-LIGHTED FL-NO-ARTICLE FL-OPEN FL-SEARCH FL-VEHICLE)
	(SYNONYM CAB THREE)
	(ADJECTIVE CAB)
	(DOWN PER RT-OUT-CAB)
	(OUT PER RT-OUT-CAB)
	(ACTION RT-RM-CAB-THREE)
>
 
<GLOBAL GL-CAB-DOCKED? <> <> BYTE>
 
<ROUTINE RT-RM-CAB-THREE ("OPT" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL "	You ">
			<COND
				(<MC-CONTEXT? ,M-LOOK>
					<TELL "are in">
				)
				(T
					<TELL "climb up into">
				)
			>
			<TELL
" Cab Three. It is a small submersible which was designed to shuttle
passengers between the surface and Deepcore.  There is a chair for the pilot
up front, and four jump seats in the back. The only exit is through the hatch
in the floor.|"
			>
			<RFALSE>
		)
		(<MC-CONTEXT? ,M-ENTERED>
			<COND
				(<AND <IN? ,CH-COFFEY ,RM-CAB-THREE>
						<NOT <FSET? ,CH-COFFEY ,FL-ALIVE>>
					>
					<TELL
"	The lifeless bodies of Coffey, One-Night and Hippy gaze at you
accusingly with the wide-eyed stare of the dead." CR
					>
				)
			>
		)
		(<MC-CONTEXT? ,M-BEG>
			<COND
				(<AND <NOT <FSET? ,RM-CAB-THREE ,FL-BROKEN>>
						<IN? ,CH-LINDSEY ,RM-CAB-THREE>
						<VERB? WALK-TO>
						<MC-PRSO? ,LG-MONTANA>
					>
					<SETG GL-CAB-DOCKED? <>>
					<TELL
"\"Right-o.\" Lindsey starts flicking levers and pushing buttons. You feel a
jerk as the cab separates itself from Deepcore, and then watch out the front
viewport as Lindsey maneuvers the Cab along the ocean floor toward the
submarine.|"
					>
					<SETG GL-MOVES <+ ,GL-MOVES 19>>
					<CLOCKER>
					<MOVE ,RM-CAB-THREE ,RM-MISSILE-HATCH>
					<TELL
"	After ten minutes or so, Cab Three passes over the lip of the chasm and
sinks slowly towards the submarine. The submersible settles precariously onto
the curved wall of the Montana." CR
					>
				)
			>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
<ROUTINE RT-OUT-CAB ("OPT" (QUIET <>))
	<COND
		(,GL-CAB-DOCKED?
			<COND
				(<OR	.QUIET
						<FSET? ,LG-CHAMBER-HATCH ,FL-OPEN>
					>
					<RETURN ,RM-COMPRESSION-CHAMBER>
				)
				(T
					<TELL "	The hatch isn't open." CR>
				)
			>
		)
		(T
			<RETURN <LOC ,RM-CAB-THREE>>
		)
	>
>
 
<ROUTINE RT-I-CAB-FIXED ()
	<FCLEAR ,RM-CAB-THREE ,FL-BROKEN>
	<MOVE ,CH-LINDSEY ,RM-CAB-THREE>
	<TELL
"The intercom buzzes. \"This is Lindsey. I'm pleased to report that Cab Three
is ready for action.\"" CR
	>
>
 
<OBJECT TH-CAB-HOOKAH
	(LOC RM-CAB-THREE)
	(DESC "hookah")
	(SYNONYM HOOKAH)
	(ACTION RT-TH-CAB-HOOKAH)
>
 
<ROUTINE RT-TH-CAB-HOOKAH ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? CUT>
			<COND
				(<AND <MC-PRSI? ,TH-KNIFE>
						,GL-FALLING-INTO-TRENCH?
					>
					<RT-DEQUEUE ,RT-I-INTO-TRENCH-1>
					<RT-DEQUEUE ,RT-I-INTO-TRENCH-2>
					<RT-QUEUE ,RT-I-OUT-OF-AIR-1 <+ ,GL-MOVES 1>>
					<REMOVE ,RM-CAB-THREE>
					<MOVE ,CH-LINDSEY ,RM-ALIEN-CHAMBER>
					<TELL
"	You take a deep breath, reach up, and sever the hookah. You begin to rise
back up to the level of the Montana. Glancing down, you see the Cab
disappearing into the inky blackness of the trench. Lindsey hasn't been able
to free herself. She looks up at you as she is being dragged down. She
reaches her hand toward you and her eyes send you a silent plea for help.
Then she disappears into the darkness." CR
					>
				)
			>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-GAS-MIX-ROOM"
;"---------------------------------------------------------------------------"
 
<ROOM RM-GAS-MIX-ROOM
	(LOC ROOMS)
	(DESC "gas mix room")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM ROOM)
	(ADJECTIVE GAS MIX)
	(FORE TO RM-SUB-BAY)
	(AFT TO RM-COMPRESSION-CHAMBER IF LG-CHAMBER-DOOR IS OPEN)
	(GLOBAL LG-WALL RM-SUB-BAY RM-COMPRESSION-CHAMBER LG-CHAMBER-DOOR)
	(ADJACENT <TABLE (BYTE PURE) RM-COMPRESSION-CHAMBER T>)
	(ACTION RT-RM-GAS-MIX-ROOM)
>
 
<ROUTINE RT-RM-GAS-MIX-ROOM ("OPTIONAL" (CONTEXT <>))
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
" a small antechamber between the sub-bay and the compression chamber, which
are fore and aft respectively. On the wall is a small video screen with
a black button below it. The door to the compression chamber is"
open ,LG-CHAMBER-DOOR ".|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
<OBJECT LG-CHAMBER-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "compression chamber door")
	(MENU "door")
	(FLAGS FL-DOOR FL-OPEN FL-OPENABLE)
	(SYNONYM DOOR)
	(ADJECTIVE COMPRESSION CHAMBER)
;	(ACTION RT-LG-CHAMBER-DOOR)
>
 
;<ROUTINE RT-LG-CHAMBER-DOOR ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-SHOWER-ROOM"
;"---------------------------------------------------------------------------"
 
;<ROOM RM-SHOWER-ROOM
	(LOC ROOMS)
	(DESC "shower room")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM ROOM)
	(ADJECTIVE SHOWER)
	(PORT TO RM-SUB-BAY)
	(GLOBAL LG-WALL RM-SUB-BAY)
	(ACTION RT-RM-SHOWER-ROOM)
>
 
;<ROUTINE RT-RM-SHOWER-ROOM ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL
"	The shower room is a tiny compartment just off the MoonPool. There is a
fresh water shower here and a small drain in the middle of the floor. Hooks
line the wall, and there is a small bench bolted to the floor.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-CORRIDOR"
;"---------------------------------------------------------------------------"
 
<ROOM RM-CORRIDOR
	(LOC ROOMS)
	(DESC "corridor")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM CORRIDOR)
	(FORE TO RM-COMMAND-MODULE)
	(AFT TO RM-SUB-BAY)
	(STARBOARD TO RM-LADDER-B2 IF LG-FLOOD-DOOR IS OPEN)
	(PORT TO RM-LADDER-A2)
	(GLOBAL
		LG-FLOOD-DOOR LG-WALL RM-COMMAND-MODULE RM-SUB-BAY RM-LADDER-A2
		RM-LADDER-B2
	)
	(ACTION RT-RM-CORRIDOR)
>
 
<ROUTINE RT-RM-CORRIDOR ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL "	You ">
			<COND
				(<MC-CONTEXT? ,M-LOOK>
					<TELL "are in">
				)
				(T
					<TELL "step out into">
				)
			>
			<TELL
the ,RM-CORRIDOR " that connects Deepcore's port and starboard sides. Towards
the bow is a door that leads to the command module. Aft is the entrance to
the sub-bay. There is a small panel set into the floor below your feet.|"
			>
			<RFALSE>
		)
		(<MC-CONTEXT? ,M-ENTERED>
			<COND
				(<EQUAL? ,GL-PUPPY ,CH-CATFISH>
					<RT-CLEAR-PUPPY>
				)
			>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
<OBJECT TH-PANEL
	(LOC RM-CORRIDOR)
	(DESC "panel")
	(FLAGS FL-SURFACE FL-OPENABLE)
	(SYNONYM PANEL)
	(ACTION RT-TH-PANEL)
>
 
<ROUTINE RT-TH-PANEL ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
;"---------------------------------------------------------------------------"
; "RM-LADDER-A2"
;"---------------------------------------------------------------------------"
 
<ROOM RM-LADDER-A2
	(LOC ROOMS)
	(DESC "ladderwell A")
	(FLAGS FL-INDOORS FL-LIGHTED)
;"Duane - Can we have the letter 'a' as a synonym?"
	(SYNONYM WELL LADDERWELL)
	(ADJECTIVE LADDER PORT LADDERWELL)
	(FORE TO RM-LOUNGE)
	(AFT TO RM-MESS-HALL)
	(STARBOARD TO RM-CORRIDOR)
	(PORT TO RM-ELECTRONICS-SHOP)
	(UP TO RM-LADDER-A3)
	(DOWN TO RM-LADDER-A1)
	(GLOBAL
		LG-WALL RM-LOUNGE RM-MESS-HALL RM-CORRIDOR RM-ELECTRONICS-SHOP
		RM-LADDER-A1 RM-LADDER-A3
	)
	(ACTION RT-RM-LADDER-A2)
>
 
<ROUTINE RT-RM-LADDER-A2 ("OPTIONAL" (CONTEXT <>))
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
" the middle level of ladderwell A. A corridor leads to the starboard side
of Deepcore. A hatch in the port bulkhead opens onto the electronics room.
The lounge is forward, and aft is the mess hall.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-LOUNGE"
;"---------------------------------------------------------------------------"
 
<ROOM RM-LOUNGE
	(LOC ROOMS)
	(DESC "lounge")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM LOUNGE)
	(AFT TO RM-LADDER-A2)
	(GLOBAL LG-WALL RM-LADDER-A2)
	(ACTION RT-RM-LOUNGE)
>
 
<ROUTINE RT-RM-LOUNGE ("OPTIONAL" (CONTEXT <>))
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
" the lounge, which is where most crew members congregate during their time
off. A couch with a curved back fits along the starboard cylinder wall. It
faces a small television that is hooked up to a VCR. The only exit is through
the aft hatchway.|"
			>
			<COND
				(,GL-BATTERY-LEAK
					<TELL
"	You see a stream of water coming from the ceiling. It pours down the
wall and disappears in the room below.|"
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
; "RM-INFIRMARY"
;"---------------------------------------------------------------------------"
 
<ROOM RM-INFIRMARY
	(LOC ROOMS)
	(DESC "infirmary")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM INFIRMARY)
	(PORT TO RM-LADDER-B3)
	(GLOBAL LG-WALL RM-LADDER-B3)
	(ACTION RT-RM-INFIRMARY)
>
 
<ROUTINE RT-RM-INFIRMARY ("OPTIONAL" (CONTEXT <>))
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
			<TELL " the infirmary. The only exit is the door in the port wall.|">
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
 
;"---------------------------------------------------------------------------"
; "RM-MESS-HALL"
;"---------------------------------------------------------------------------"
 
<ROOM RM-MESS-HALL
	(LOC ROOMS)
	(DESC "mess hall")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM HALL)
	(ADJECTIVE MESS)
	(FORE TO RM-LADDER-A2)
	(AFT TO RM-GALLEY)
	(GLOBAL LG-WALL RM-LADDER-A2 RM-GALLEY)
	(ACTION RT-RM-MESS-HALL)
>
 
<GLOBAL GL-CATFISH-SPY-MSG? <> <> BYTE>
 
<ROUTINE RT-RM-MESS-HALL ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL
"	This is Deepcore's mess hall. There is a circular table in the middle
of the room and a few chairs have been stacked against the wall. The forward
exit leads to ladderwell A. The aft exit opens onto the galley.|"
			>
			<RFALSE>
		)
		(<MC-CONTEXT? ,M-ENTERED>
			<COND
				(<AND <IN? ,CH-COFFEY ,RM-MESS-HALL>
						<IN? ,CH-CATFISH ,RM-MESS-HALL>
						<FSET? ,CH-CATFISH ,FL-ASLEEP>
						<NOT ,GL-CATFISH-SPY-MSG?>
					>
					<SETG GL-CATFISH-SPY-MSG? T>
					<TELL
"	Coffey looks up as you enter. \"Oh, there you are Brigman. I'll bet you
didn't know that your favorite boy here is a Russkie, didja?\" He gestures to
Catfish with his gun, and you see that his hand is trembling. \"I caught him
red-handed. And when he wakes up, he's gonna find out how it feels to be both
Red "
					>
					<HLIGHT ,K-H-BLD>
					<TELL "and">
					<HLIGHT ,K-H-NRM>
					<TELL " dead.\"" CR>
				)
			>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-GALLEY"
;"---------------------------------------------------------------------------"
 
<ROOM RM-GALLEY
	(LOC ROOMS)
	(DESC "Stu's galley")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM GALLEY)
	(FORE TO RM-MESS-HALL)
	(AFT TO RM-PANTRY)
	(GLOBAL LG-WALL RM-MESS-HALL RM-PANTRY)
	(ACTION RT-RM-GALLEY)
>
 
<ROUTINE RT-RM-GALLEY ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL
"	This is a fully equipped galley that has everything including the kitchen
sink. You see a microwave, refrigerator, sink, and even a garbage compactor.
You can go both fore and aft from here.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-PANTRY"
;"---------------------------------------------------------------------------"
 
<ROOM RM-PANTRY
	(LOC ROOMS)
	(DESC "pantry")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM PANTRY)
	(FORE TO RM-GALLEY)
	(AFT TO RM-LADDER-D2)
	(GLOBAL LG-WALL RM-GALLEY RM-LADDER-D2)
	(ACTION RT-RM-PANTRY)
>
 
<ROUTINE RT-RM-PANTRY ("OPTIONAL" (CONTEXT <>))
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
" the pantry. The food supplies are stored in the cupboards that line the
walls. There are exits both fore and aft.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
<OBJECT TH-HOOK-2
	(LOC RM-PANTRY)
	(DESC "hook")
	(FLAGS FL-SURFACE)
	(SYNONYM HOOK)
	(ACTION RT-TH-HOOK-2)
>
 
<ROUTINE RT-TH-HOOK-2 ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
;"---------------------------------------------------------------------------"
; "TH-GAME-BAG"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-GAME-BAG
	(LOC TH-HOOK-2)
	(DESC "game bag")
	(FLAGS FL-SURFACE FL-SEARCH FL-TAKEABLE FL-CONTAINER)
	(SYNONYM BAG)
	(ADJECTIVE GAME)
	(SIZE 5)
	(ACTION RT-TH-GAME-BAG)
>
 
<ROUTINE RT-TH-GAME-BAG ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
;"---------------------------------------------------------------------------"
; "RM-WALDORF"
;"---------------------------------------------------------------------------"
 
<ROOM RM-WALDORF
	(LOC ROOMS)
	(DESC "The Waldorf")
	(FLAGS FL-INDOORS FL-LIGHTED FL-NO-ARTICLE)
	(SYNONYM WALDORF)
	(FORE TO RM-LADDER-B2)
	(AFT TO RM-PERSONAL-STORAGE-1)
	(GLOBAL LG-WALL RM-LADDER-B2 RM-PERSONAL-STORAGE-1)
	(ACTION RT-RM-WALDORF)
>
 
<ROUTINE RT-RM-WALDORF ("OPTIONAL" (CONTEXT <>))
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
" The Waldorf, which is what the crew irreverently calls your living
quarters because it is the only stateroom aboard Deepcore that has its own
sink. Rank hath its privileges. The room is in its usual state of chaos.
Your bunk is situated with the head near the forward hatch and the foot next
to the hatch in the aft bulkhead.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
 
;"---------------------------------------------------------------------------"
; "RM-PERSONAL-STORAGE-1"
;"---------------------------------------------------------------------------"
 
<ROOM RM-PERSONAL-STORAGE-1
	(LOC ROOMS)
	(DESC "personal storage")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM STORAGE)
	(ADJECTIVE PERSONAL)
	(FORE TO RM-WALDORF)
	(AFT TO RM-ZOOTOWN)
	(GLOBAL LG-WALL RM-WALDORF RM-ZOOTOWN)
	(ACTION RT-RM-PERSONAL-STORAGE-1)
>
 
<ROUTINE RT-RM-PERSONAL-STORAGE-1 ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL
"	This is a storage room for personal effects. Your locker is on the wall
near the hatch leading forward to your stateroom. The locker belonging to
Hippy is next to the door in the aft bulkhead.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-ZOOTOWN"
;"---------------------------------------------------------------------------"
 
<ROOM RM-ZOOTOWN
	(LOC ROOMS)
	(DESC "Zootown")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM ZOOTOWN)
	(FORE TO RM-PERSONAL-STORAGE-1)
	(AFT TO RM-LADDER-C2)
	(GLOBAL LG-WALL RM-PERSONAL-STORAGE-1 RM-LADDER-C2)
	(ACTION RT-RM-ZOOTOWN)
>
 
<ROUTINE RT-RM-ZOOTOWN ("OPTIONAL" (CONTEXT <>))
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
" Hippy's living quarters, known to the crew as 'Zootown' because of the
succession of unusual pets he has brought aboard Deepcore. Hatches here lead
fore and aft.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
 
;"---------------------------------------------------------------------------"
; "RM-LADDER-C2"
;"---------------------------------------------------------------------------"
 
<ROOM RM-LADDER-C2
	(LOC ROOMS)
	(DESC "ladderwell C")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM WELL LADDERWELL)
	(ADJECTIVE LADDER LADDERWELL)
	(FORE TO RM-ZOOTOWN)
	(UP TO RM-LADDER-C3)
	(DOWN TO RM-LADDER-C1)
	(GLOBAL LG-WALL RM-ZOOTOWN RM-LADDER-C3 RM-LADDER-C1)
	(ACTION RT-RM-LADDER-C2)
>
 
<ROUTINE RT-RM-LADDER-C2 ("OPTIONAL" (CONTEXT <>))
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
" the middle level of ladderwell C. A hatch in the forward bulkhead opens
into Hippy's living quarters. There is a yellow button here, with a sign
underneath it.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "TH-S-BILGE-BUTT"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-S-BILGE-BUTT
	(DESC "button")
	(SYNONYM BUTTON)
	(ADJECTIVE YELLOW)
	(ACTION RT-TH-S-BILGE-BUTT)
>
 
<ROUTINE RT-TH-S-BILGE-BUTT ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
;"---------------------------------------------------------------------------"
; "RM-LADDER-A1"
;"---------------------------------------------------------------------------"
 
<ROOM RM-LADDER-A1
	(LOC ROOMS)
	(DESC "ladder well A")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM WELL LADDERWELL)
	(ADJECTIVE LADDER LADDERWELL)
	(FORE TO RM-PT-BATTERY-ROOM)
	(AFT TO RM-PT-LIFE-SUPPORT)
	(PORT TO RM-LAUNDRY)
	(UP TO RM-LADDER-A2)
	(GLOBAL LG-WALL RM-PT-BATTERY-ROOM RM-PT-LIFE-SUPPORT RM-LAUNDRY RM-LADDER-A2)
	(ACTION RT-RM-LADDER-A1)
>
 
<ROUTINE RT-RM-LADDER-A1 ("OPTIONAL" (CONTEXT <>))
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
" the lowest level of ladderwell A. A hatch in the port bulkhead opens onto
the laundry room. The Port Battery room is just forward of here, and aft is
Port Life Support.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-LAUNDRY"
;"---------------------------------------------------------------------------"
 
<ROOM RM-LAUNDRY
	(LOC ROOMS)
	(DESC "laundry")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM LAUNDRY)
	(STARBOARD TO RM-LADDER-A1)
	(GLOBAL LG-WALL RM-LADDER-A1)
	(ACTION RT-RM-LAUNDRY)
>
 
<ROUTINE RT-RM-LAUNDRY ("OPTIONAL" (CONTEXT <>))
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
" the laundry room. The washer and dryer flank a shelf that contains laundry
supplies. The only exit is the door in the starboard wall.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-PT-LIFE-SUPPORT"
;"---------------------------------------------------------------------------"
 
<ROOM RM-PT-LIFE-SUPPORT
	(LOC ROOMS)
	(DESC "port life support")
	(MENU "life support")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM SUPPORT)
	(ADJECTIVE PORT LIFE)
	(FORE TO RM-LADDER-A1)
	(AFT TO RM-COMPRESSOR-ROOM)
	(GLOBAL LG-WALL RM-LADDER-A1 RM-COMPRESSOR-ROOM)
	(ACTION RT-RM-PT-LIFE-SUPPORT)
>
 
<ROUTINE RT-RM-PT-LIFE-SUPPORT ("OPTIONAL" (CONTEXT <>))
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
" the port life support room. All around you is a jungle of fittings, gauges,
and circuit boards. They control the CO2 scrubbers, dehumidifiers, heaters
and other devices that make life possible 2,000 feet below the surface. Exits
here lead fore and aft.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
 
;"---------------------------------------------------------------------------"
; "RM-COMPRESSOR-ROOM"
;"---------------------------------------------------------------------------"
 
<ROOM RM-COMPRESSOR-ROOM
	(LOC ROOMS)
	(DESC "compressor room")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM ROOM)
	(ADJECTIVE COMPRESSOR)
	(FORE TO RM-PT-LIFE-SUPPORT)
	(AFT TO RM-TRI-MIX-STORAGE)
	(GLOBAL LG-WALL RM-PT-LIFE-SUPPORT RM-TRI-MIX-STORAGE)
	(ACTION RT-RM-COMPRESSOR-ROOM)
>
 
<ROUTINE RT-RM-COMPRESSOR-ROOM ("OPTIONAL" (CONTEXT <>))
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
" the compressor room. You see a dark labyrinth of pipes emanating from
the huge compressor that supplies air to the hookahs. "
			>
			<COND
				(<OR  <FSET? ,TH-COMPRESSOR ,FL-BROKEN>
						<NOT <FSET? ,TH-COMPRESSOR ,FL-ON>>
					>
					<TELL
"The eerie silence makes an unsettling contrast to the normal cacophany in
the cylinder."
					>
				)
				(T
					<TELL
"It's hard to hear yourself think over the roar of the machinery."
					>
				)
			>
			<TELL
" There are hatchways leading out of both the forward and aft bulkheads.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
<OBJECT TH-COMPRESSOR
	(LOC RM-COMPRESSOR-ROOM)
	(DESC "compressor")
	(FLAGS FL-ON)
	(SYNONYM COMPRESSOR)
	(ACTION RT-TH-COMPRESSOR)
>
 
; "TH-COMPRESSOR flags:"
; "	FL-BROKEN = Coffey has permanently munged the compressor."
; "	FL-ON = Compressor is turned on."
 
<ROUTINE RT-TH-COMPRESSOR ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
;"---------------------------------------------------------------------------"
; "RM-LADDER-D1"
;"---------------------------------------------------------------------------"
 
<ROOM RM-LADDER-D1
	(LOC ROOMS)
	(DESC "ladderwell D")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM WELL LADDERWELL)
	(ADJECTIVE LADDER LADDERWELL)
	(FORE TO RM-TRI-MIX-STORAGE)
	(AFT TO RM-TOOL-PUSHER-OFFICE)
	(UP TO RM-LADDER-D2)
	(GLOBAL LG-WALL RM-TRI-MIX-STORAGE RM-TOOL-PUSHER-OFFICE RM-LADDER-D2)
	(ACTION RT-RM-LADDER-D1)
>
 
<ROUTINE RT-RM-LADDER-D1 ("OPTIONAL" (CONTEXT <>))
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
" the lowest level of ladderwell D. A hatch in the forward bulkhead leads to
tri-mix storage, and another leads aft to your office.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-TOOL-PUSHER-OFFICE"
;"---------------------------------------------------------------------------"
 
<ROOM RM-TOOL-PUSHER-OFFICE
	(LOC ROOMS)
	(DESC "tool pusher's office")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM OFFICE)
	(ADJECTIVE TOOL PUSHER)
	(FORE TO RM-LADDER-D1)
	(STARBOARD TO RM-TOOL-ROOM)
	(GLOBAL LG-WALL RM-LADDER-D1 RM-TOOL-ROOM)
	(ACTION RT-RM-TOOL-PUSHER-OFFICE)
>
 
<ROUTINE RT-RM-TOOL-PUSHER-OFFICE ("OPTIONAL" (CONTEXT <>))
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
" your office, a tiny cubicle with stacks of paperwork, tech manuals and
waterstained centerfolds. The hatch in the forward bulkhead leads to
ladderwell D, and the starboard hatch opens onto the tool room.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-DRILL-ROOM"
;"---------------------------------------------------------------------------"
 
<ROOM RM-DRILL-ROOM
	(LOC ROOMS)
	(DESC "drill room")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM ROOM)
	(ADJECTIVE DRILL)
	(PORT TO RM-TOOL-ROOM)
	(GLOBAL LG-WALL RM-TOOL-ROOM)
	(ACTION RT-RM-DRILL-ROOM)
>
 
<ROUTINE RT-RM-DRILL-ROOM ("OPTIONAL" (CONTEXT <>))
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
" the drill room, the working heart of Deepcore. In the center of the room
is the massive turntable that spins the drill string when the rig is
operating. Everything in the room is coated with the pungent, greasy chemical
compound called 'drilling mud.' The only exit is through the hatch in the port
bulkhead.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
 
;"---------------------------------------------------------------------------"
; "RM-LADDER-B1"
;"---------------------------------------------------------------------------"
 
<ROOM RM-LADDER-B1
	(LOC ROOMS)
	(DESC "ladderwell B")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM WELL LADDERWELL)
	(ADJECTIVE LADDER LADDERWELL)
	(FORE TO RM-SB-BATTERY-ROOM)
	(AFT TO RM-SB-LIFE-SUPPORT)
	(STARBOARD TO RM-SB-HEAD)
	(UP TO RM-LADDER-B2)
	(GLOBAL LG-WALL RM-SB-BATTERY-ROOM RM-SB-LIFE-SUPPORT RM-SB-HEAD RM-LADDER-B2)
	(ACTION RT-RM-LADDER-B1)
>
 
<ROUTINE RT-RM-LADDER-B1 ("OPTIONAL" (CONTEXT <>))
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
" the lowest level of ladderwell B. A hatch in the starboard bulkhead opens onto the
starboard head. The starboard battery room is just forward of here, and aft is
starboard life support.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-SB-BATTERY-ROOM"
;"---------------------------------------------------------------------------"
 
<ROOM RM-SB-BATTERY-ROOM
	(LOC ROOMS)
	(DESC "starboard battery room")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM ROOM)
	(ADJECTIVE STARBOARD BATTERY)
	(AFT TO RM-LADDER-B1)
	(GLOBAL LG-WALL RM-LADDER-B1)
	(ACTION RT-RM-SB-BATTERY-ROOM)
>
 
<ROUTINE RT-RM-SB-BATTERY-ROOM ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL
"	This is one of the rooms that contain the huge fuelcells that power
Deepcore. The powercels are surrounded by a wire cage that is festooned with
signs that warn of the dangers of electricity. The fuelcells are humming
ominously - as usual - and an acrid, ozone smell fills the air. The only
exit is through the hatch in the aft bulkhead.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-SB-HEAD"
;"---------------------------------------------------------------------------"
 
<ROOM RM-SB-HEAD
	(LOC ROOMS)
	(DESC "starboard head")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM HEAD)
	(ADJECTIVE STARBOARD)
	(PORT TO RM-LADDER-B1)
	(GLOBAL LG-WALL RM-LADDER-B1)
	(ACTION RT-RM-SB-HEAD)
>
 
<ROUTINE RT-RM-SB-HEAD ("OPTIONAL" (CONTEXT <>))
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
" the starboard head. It is sparingly furnished with a shower, sink, and
chemical toilet. The only exit is in the port bulkhead.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-SB-LIFE-SUPPORT"
;"---------------------------------------------------------------------------"
 
<ROOM RM-SB-LIFE-SUPPORT
	(LOC ROOMS)
	(DESC "starboard life support")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM SUPPORT)
	(ADJECTIVE STARBOARD LIFE)
	(FORE TO RM-LADDER-B1)
	(AFT TO RM-PUMP-ROOM)
	(GLOBAL LG-WALL RM-LADDER-B1 RM-PUMP-ROOM)
	(ACTION RT-RM-SB-LIFE-SUPPORT)
>
 
<ROUTINE RT-RM-SB-LIFE-SUPPORT ("OPTIONAL" (CONTEXT <>))
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
" the starboard life support room. All around you is a jungle of fittings,
gauges, and circuit boards. They control the CO2 scrubbers, dehumidifiers,
heaters and other devices that make life possible 2,000 feet below the
surface. Exits here lead fore and aft.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-PUMP-ROOM"
;"---------------------------------------------------------------------------"
 
<ROOM RM-PUMP-ROOM
	(LOC ROOMS)
	(DESC "pump room")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM ROOM)
	(ADJECTIVE PUMP)
	(FORE TO RM-SB-LIFE-SUPPORT)
	(AFT TO RM-FRESH-WATER-STORAGE)
	(GLOBAL LG-WALL RM-SB-LIFE-SUPPORT RM-FRESH-WATER-STORAGE)
	(ACTION RT-RM-PUMP-ROOM)
>
 
<ROUTINE RT-RM-PUMP-ROOM ("OPTIONAL" (CONTEXT <>))
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
" the pump room. The machinery here controls the fresh water supply all over
Deepcore. You can exit either fore or aft.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-FRESH-WATER-STORAGE"
;"---------------------------------------------------------------------------"
 
<ROOM RM-FRESH-WATER-STORAGE
	(LOC ROOMS)
	(DESC "fresh water storage")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM STORAGE)
	(ADJECTIVE FRESH WATER)
	(FORE TO RM-PUMP-ROOM)
	(AFT TO RM-LADDER-C1)
	(GLOBAL LG-WALL RM-PUMP-ROOM RM-LADDER-C1)
	(ACTION RT-RM-FRESH-WATER-STORAGE)
>
 
<ROUTINE RT-RM-FRESH-WATER-STORAGE ("OPTIONAL" (CONTEXT <>))
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
" fresh water storage, where Deepcore's entire water supply is kept in one
huge tank. There are doors in both the forward and aft walls.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-LADDER-C1"
;"---------------------------------------------------------------------------"
 
<ROOM RM-LADDER-C1
	(LOC ROOMS)
	(DESC "ladderwell C")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM WELL LADDERWELL)
	(ADJECTIVE LADDER LADDERWELL)
	(FORE TO RM-FRESH-WATER-STORAGE)
	(UP TO RM-LADDER-C2)
	(GLOBAL LG-WALL RM-FRESH-WATER-STORAGE RM-LADDER-C2)
	(ACTION RT-RM-LADDER-C1)
>
 
<ROUTINE RT-RM-LADDER-C1 ("OPTIONAL" (CONTEXT <>))
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
" the lowest level of ladderwell C. The only exits are the ladder leading
up and the hatch in the forward wall.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-LADDER-A3"
;"---------------------------------------------------------------------------"
 
<ROOM RM-LADDER-A3
	(LOC ROOMS)
	(DESC "ladderwell A")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM WELL LADDERWELL)
	(ADJECTIVE LADDER LADDERWELL)
	(FORE TO RM-PT-OBS-DECK)
	(AFT TO RM-MOTEL-QUICK)
	(PORT TO RM-PT-HEAD)
	(DOWN TO RM-LADDER-A2)
	(GLOBAL LG-WALL RM-PT-OBS-DECK RM-MOTEL-QUICK RM-PT-HEAD RM-LADDER-A2)
	(ACTION RT-RM-LADDER-A3)
>
 
<ROUTINE RT-RM-LADDER-A3 ("OPTIONAL" (CONTEXT <>))
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
" the uppermost level of ladderwell A. Forward from here is the port
observation deck. The female living quarters are aft. A hatch in the port
bulkhead leads to the port head.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-PT-HEAD"
;"---------------------------------------------------------------------------"
 
<ROOM RM-PT-HEAD
	(LOC ROOMS)
	(DESC "port head")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM HEAD)
	(ADJECTIVE PORT)
	(STARBOARD TO RM-LADDER-A3)
	(GLOBAL LG-WALL RM-LADDER-A3)
	(ACTION RT-RM-PT-HEAD)
>
 
<ROUTINE RT-RM-PT-HEAD ("OPTIONAL" (CONTEXT <>))
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
" the port head. It is sparingly furnished with a shower, sink, and
chemical toilet. The only exit is in the starboard bulkhead.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-MOTEL-QUICK"
;"---------------------------------------------------------------------------"
 
<ROOM RM-MOTEL-QUICK
	(LOC ROOMS)
	(DESC "motel Quick")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM QUICK)
	(ADJECTIVE MOTEL)
	(FORE TO RM-LADDER-A3)
	(AFT TO RM-PERSONAL-STORAGE-2)
	(GLOBAL LG-WALL RM-LADDER-A3 RM-PERSONAL-STORAGE-2)
	(ACTION RT-RM-MOTEL-QUICK)
>
 
<ROUTINE RT-RM-MOTEL-QUICK ("OPTIONAL" (CONTEXT <>))
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
" the female living quarters, nicknamed \"Motel Quick\" by the crew. Exits
hee lead both fore and aft.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-PERSONAL-STORAGE-2"
;"---------------------------------------------------------------------------"
 
<ROOM RM-PERSONAL-STORAGE-2
	(LOC ROOMS)
	(DESC "personal storage")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM STORAGE)
	(ADJECTIVE PERSONAL)
	(FORE TO RM-MOTEL-QUICK)
	(AFT TO RM-SWAMP)
	(GLOBAL LG-WALL RM-MOTEL-QUICK RM-SWAMP)
	(ACTION RT-RM-PERSONAL-STORAGE-2)
>
 
<ROUTINE RT-RM-PERSONAL-STORAGE-2 ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL
"	This is a storage room for personal effects. One-Night's locker is on the
wall near the forward hatch leading to Motel Quick. The locker belonging to
Catfish is next to the door in the aft bulkhead.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-SWAMP"
;"---------------------------------------------------------------------------"
 
<ROOM RM-SWAMP
	(LOC ROOMS)
	(DESC "the Swamp")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM SWAMP)
	(FORE TO RM-PERSONAL-STORAGE-2)
	(AFT TO RM-LADDER-D3)
	(GLOBAL LG-WALL RM-PERSONAL-STORAGE-2 RM-LADDER-D3)
	(ACTION RT-RM-SWAMP)
>
 
<ROUTINE RT-RM-SWAMP ("OPTIONAL" (CONTEXT <>))
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
" the drill crew's living quarters, appropriately nicknamed \"The Swamp.\" The
hatch to ladderwell D is in the aft bulkhead, and there is a door in the
forward bulkhead as well.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-LADDER-D3"
;"---------------------------------------------------------------------------"
 
<ROOM RM-LADDER-D3
	(LOC ROOMS)
	(DESC "ladderwell D")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM WELL LADDERWELL)
	(ADJECTIVE LADDERWELL LADDER)
	(FORE TO RM-SWAMP)
	(DOWN TO RM-LADDER-D2)
	(GLOBAL LG-WALL RM-SWAMP RM-LADDER-D2)
	(ACTION RT-RM-LADDER-D3)
>
 
<ROUTINE RT-RM-LADDER-D3 ("OPTIONAL" (CONTEXT <>))
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
" the highest level of ladderwell D. The only exits are the ladder leading
down and the hatch in the forward bulkhead.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-LADDER-B3"
;"---------------------------------------------------------------------------"
 
<ROOM RM-LADDER-B3
	(LOC ROOMS)
	(DESC "ladderwell B")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM WELL LADDERWELL)
	(ADJECTIVE LADDER LADDERWELL)
	(FORE TO RM-SB-OBS-DECK)
	(AFT TO RM-COMPUTER-CENTER)
	(STARBOARD TO RM-INFIRMARY)
	(DOWN TO RM-LADDER-B2)
	(GLOBAL LG-WALL RM-SB-OBS-DECK RM-COMPUTER-CENTER RM-INFIRMARY RM-LADDER-B2)
	(ACTION RT-RM-LADDER-B3)
>
 
<ROUTINE RT-RM-LADDER-B3 ("OPTIONAL" (CONTEXT <>))
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
" the uppermost level of ladderwell B. Hatchways fore, aft, and starboard
lead to the starboard observation deck, the computer center, and the
infirmary, respectively.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-SB-OBS-DECK"
;"---------------------------------------------------------------------------"
 
<ROOM RM-SB-OBS-DECK
	(LOC ROOMS)
	(DESC "starboard observation deck")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM DECK)
	(ADJECTIVE STARBOARD OBSERVATION)
	(AFT TO RM-LADDER-B3)
	(GLOBAL LG-WALL RM-LADDER-B3)
	(ACTION RT-RM-SB-OBS-DECK)
>
 
<ROUTINE RT-RM-SB-OBS-DECK ("OPTIONAL" (CONTEXT <>))
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
" the starboard observation deck, which has a huge domed plexiglass window
that lets you look out onto the ocean floor. The only exit is in the aft
bulkhead.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-COMPUTER-CENTER"
;"---------------------------------------------------------------------------"
 
<ROOM RM-COMPUTER-CENTER
	(LOC ROOMS)
	(DESC "computer center")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM CENTER)
	(ADJECTIVE COMPUTER)
	(FORE TO RM-LADDER-B3)
	(AFT TO RM-LAB)
	(GLOBAL LG-WALL RM-LADDER-B3 RM-LAB)
	(ACTION RT-RM-COMPUTER-CENTER)
>
 
<ROUTINE RT-RM-COMPUTER-CENTER ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL
"	This is Deepcore's computer center. On the desk is a dumb terminal to
the mainframe aboard the Benthic Explorer on the surface. There is some text
on the screen. Exits here lead fore and aft.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-ELECTRONICS-SHOP"
;"---------------------------------------------------------------------------"
 
<ROOM RM-ELECTRONICS-SHOP
	(LOC ROOMS)
	(DESC "electronics shop")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM SHOP)
	(ADJECTIVE ELECTRONIC)
	(STARBOARD TO RM-LADDER-A2)
	(GLOBAL LG-WALL RM-LADDER-A2)
	(ACTION RT-RM-ELECTRONICS-SHOP)
>
 
<ROUTINE RT-RM-ELECTRONICS-SHOP ("OPTIONAL" (CONTEXT <>))
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
" the electronics shop, which has become Hippy's personal domain. His
workbench backs onto a storage unit that contains hundreds of clear plastic
drawers, which in turn contain thousands of connectors, pins, and other
spare parts. The workbench also has one large central drawer above the
kneehole. The only exit is in the starboard bulkhead.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
<OBJECT TH-ELEC-SHOP-DRAWER
	(LOC RM-ELECTRONICS-SHOP)
	(DESC "center drawer")
	(FLAGS FL-CONTAINER FL-OPENABLE FL-SEARCH)
	(SYNONYM DRAWER)
	(ADJECTIVE CENTER)
	(ACTION RT-TH-ELEC-SHOP-DRAWER)
>
 
<ROUTINE RT-TH-ELEC-SHOP-DRAWER ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
;"---------------------------------------------------------------------------"
; "RM-LAB"
;"---------------------------------------------------------------------------"
 
<ROOM RM-LAB
	(LOC ROOMS)
	(DESC "lab")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM LAB LABORATORY)
	(FORE TO RM-COMPUTER-CENTER)
	(AFT TO RM-TAPE-LIBRARY)
	(GLOBAL LG-WALL RM-COMPUTER-CENTER RM-TAPE-LIBRARY)
	(ACTION RT-RM-LAB)
>
 
<ROUTINE RT-RM-LAB ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL
"	This is Deepcore's biomedical lab. The room is cleaner than most of the
other rooms aboard the habitat, but it has a curious, fishy odor to it. Exits
lead fore and aft.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-TAPE-LIBRARY"
;"---------------------------------------------------------------------------"
 
<ROOM RM-TAPE-LIBRARY
	(LOC ROOMS)
	(DESC "tape library")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM LIBRARY)
	(ADJECTIVE TAPE)
	(FORE TO RM-LAB)
	(AFT TO RM-LADDER-C3)
	(GLOBAL LG-WALL RM-LAB RM-LADDER-C3)
	(ACTION RT-RM-TAPE-LIBRARY)
>
 
<ROUTINE RT-RM-TAPE-LIBRARY ("OPTIONAL" (CONTEXT <>))
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
" Deepcore's tape library. The walls are covered with videotapes that range
in subject matter from the serious to the scatological. You can exit either
forward or aft.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "RM-LADDER-C3"
;"---------------------------------------------------------------------------"
 
<ROOM RM-LADDER-C3
	(LOC ROOMS)
	(DESC "ladderwell C")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM WELL LADDERWELL)
	(ADJECTIVE LADDER LADDERWELL)
	(FORE TO RM-TAPE-LIBRARY)
	(DOWN TO RM-LADDER-C2)
	(GLOBAL LG-WALL RM-TAPE-LIBRARY RM-LADDER-C2)
	(ACTION RT-RM-LADDER-C3)
>
 
<ROUTINE RT-RM-LADDER-C3 ("OPTIONAL" (CONTEXT <>))
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
" the highest level of ladderwell C. You see a hatch in the forward bulkhead
and a ladder leading down.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"***************************************************************************"
; "end of file"
;"***************************************************************************"
 
