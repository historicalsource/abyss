

	.FUNCT	RT-RM-SUB-BAY:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	ICALL	RT-PRINT-OBJ,RM-SUB-BAY,K-ART-THE
	PRINTI	", which seems cavernous compared to the other cramped compartments aboard Deepcore. It is dominated by the MoonPool, which looks just like a huge swimming pool, except that it is open to the sea below.
	Along one edge of the MoonPool is a large dive locker. A door in the port bulkhead leads to the shower room. Aft is the gas-mix room, and in the fore wall is the doorway that leads to the corridor.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-BEG \?CCL8
	FSET?	TH-PLASTIC-CARD,FL-SEEN \FALSE
	FSET?	CH-COFFEY,FL-BROKEN /FALSE
	CALL1	GAME-VERB?
	ZERO?	STACK \FALSE
	EQUAL?	PRSA,V?GIVE-SWP /FALSE
	EQUAL?	PRSA,V?GIVE \?CCL20
	EQUAL?	PRSO,TH-PLASTIC-CARD \?CCL20
	EQUAL?	PRSI,CH-COFFEY /FALSE
?CCL20:	ZERO?	GL-COFFEY-SHOOT \?CCL26
	INC	'GL-COFFEY-SHOOT
	PRINTR	"	Coffey fires a bullet just past your head. ""Next one's for you, drill boy."""
?CCL26:	PRINTI	"	Coffey raises his aim until the gun is pointed right between your eyes. ""Bye, bye, Mr Chips."" He starts to squeeze the trigger. The last thing you notice before you die is how perfectly round the end of a gun's barrel is.
"
	CALL1	RT-END-OF-GAME
	RSTACK	
?CCL8:	EQUAL?	CONTEXT,M-ENTERED \?CCL28
	FSET?	TH-PLASTIC-CARD,FL-SEEN \?CCL31
	ZERO?	GL-RETURN2-DONE? \FALSE
	MOVE	TH-DRY-SUIT,HERE
	FCLEAR	TH-DRY-SUIT,FL-WORN
	MOVE	CH-CATFISH,RM-SUB-BAY
	MOVE	CH-COFFEY,RM-SUB-BAY
	SET	'GL-RETURN2-DONE?,TRUE-VALUE
	PRINTR	"	You surface in the MoonPool. Catfish grabs your hand and hoists you to firm ground as easily as if you were a child. He helps you out of your dive suit and into dry clothes.
	Suddenly Coffey comes into the room and levels his gun at your chest. ""I'll take those codes,"" he announces."
?CCL31:	FSET?	LG-BUCKLED-DOOR,FL-OPEN \FALSE
	ZERO?	GL-RETURN1-DONE? \FALSE
	MOVE	TH-DRY-SUIT,HERE
	FCLEAR	TH-DRY-SUIT,FL-WORN
	MOVE	CH-LINDSEY,RM-SUB-BAY
	MOVE	CH-COFFEY,RM-MESS-HALL
	MOVE	CH-CATFISH,RM-MESS-HALL
	FSET	CH-CATFISH,FL-ASLEEP
	SET	'GL-RETURN1-DONE?,TRUE-VALUE
	PRINTR	"	You surface in the MoonPool. Lindsey pulls you out of the water. She strips you of the cumbersome dive suit, towels you off, and helps you into dry clothes.
	Then she says, ""Bud we've got a problem. Coffey caught Catfish trying to break into the dive locker in the Sub-bay. The asshole knocked Catfish over the head with the butt of his gun and then dragged him to the mess hall. Now he's standing over him in the mess hall and claiming that Cat's a Russian spy. He says as soon at Catfish comes around, he's going to give him a summary court martial, find him guilty, and shoot him on the spot!"""
?CCL28:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-TH-MOON-POOL:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?ENTER \FALSE
	EQUAL?	HERE,RM-SUB-BAY \?CCL8
	CALL2	RT-DO-WALK,P?DOWN
	RSTACK	
?CCL8:	EQUAL?	HERE,RM-UNDER-MOONPOOL \FALSE
	CALL2	RT-DO-WALK,P?UP
	RSTACK	


	.FUNCT	RT-TH-FIRE:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXTINGUISH \FALSE
	IN?	TH-WATER-HOSE,WINNER \?CCL8
	FSET?	TH-WATER-HOSE,FL-ON \?CCL8
	REMOVE	TH-FIRE
	ICALL2	RT-DEQUEUE,RT-I-FIRE-1
	ICALL2	RT-DEQUEUE,RT-I-FIRE-2
	PRINTR	"	The water hisses into the wall of flame without appearing to have any effect. Then, slowly, the intensity of the fire seems to lessen. After a few moments, the flames die back, and all that remains of the fire are charred bits of smouldering embers."
?CCL8:	PRINT	K-HOW-INTEND-MSG
	CRLF	
	RTRUE	


	.FUNCT	RT-I-FIRE-1:ANY:0:0
	ADD	GL-MOVES,6
	ICALL	RT-QUEUE,RT-I-FIRE-2,STACK
	EQUAL?	HERE,RM-SUB-BAY \FALSE
	PRINTR	"	The flames reach the wooden locker, and it starts to burn."


	.FUNCT	RT-I-FIRE-2:ANY:0:0
	PRINTI	"	Suddenly the dive locker explodes with tremendous fury, ripping a gaping hole in the roof of the Sub-bay. Seconds later you are engulfed by a wall of water and you drown.
"
	CALL1	RT-END-OF-GAME
	RSTACK	


	.FUNCT	RT-TH-WATER-HOSE:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?TURN-ON \FALSE
	CALL1	RT-TH-NOZZLE
	RSTACK	


	.FUNCT	RT-TH-NOZZLE:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?OPEN,V?TURN-ON,V?TURN \FALSE
	ZERO?	GL-WATER-PUMP-ON /?CCL8
	FSET	TH-WATER-HOSE,FL-ON
	PRINTR	"	A stream of water leaps from the nozzle."
?CCL8:	PRINTR	"	Nothing happens."


	.FUNCT	RT-TH-OXYGEN-CYLINDER:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-CH-COFFEY:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI /?CCL5
	EQUAL?	PRSA,V?GIVE \FALSE
	IN?	CH-COFFEY,RM-SUB-BAY \FALSE
	FSET?	TH-PLASTIC-CARD,FL-SEEN \FALSE
	EQUAL?	PRSO,TH-PLASTIC-CARD \FALSE
	MOVE	TH-PLASTIC-CARD,CH-COFFEY
	REMOVE	TH-GUN
	FSET	CH-COFFEY,FL-BROKEN
	FSET	TH-COMPRESSOR,FL-BROKEN
	MOVE	CH-COFFEY,RM-COMPRESSION-CHAMBER
	SET	'OHERE,HERE
	SET	'HERE,RM-GAS-MIX-ROOM
	MOVE	CH-PLAYER,RM-GAS-MIX-ROOM
	PRINTR	"	Coffey bends over the wiring codes, glancing up occasionally to make sure you don't try to attack him.
	Suddenly you notice a strange phenomenon in the MoonPool behind him. Some water is slowly forming into a shining column and rising above the surrounding surface. After a few moments, a sort of three-fingered hand forms at the end of the column. As you stare at in fascination, it slowly, silently, creeps up behind Coffey, who remains oblivious to its presence.

  	[GRAPHIC]

  	Suddenly the pseudopod reaches out and snatches the gun from Coffey. He whips around in time to see the column disappear below the surface of the water, carrying his gun with it.
	Something inside Coffey seems to snap. He looks at you wildly and shouts, ""I know you're behind this, Brigman. I don't know what you want from that sub, but I'm gonna make sure you never see it again."" He turns and runs from the room.
	You follow Coffey. When he reaches the compressor room, Coffey brandishes a tool over the compressor. As he sees you enter, he thrusts the tool deep into the workings of the machine. It screams to a halt with an ear-piercing shriek. Coffey yells over the noise, ""Up yours, Brigman!"" and dashes out of the cylinder.
	He then runs into the compression chamber. Through the open door to the compression chamber, you can see Coffey tugging at the hatch that leads up to Cab Three. He is unable to open it because Lindsey has locked it from the other side."
?CCL5:	EQUAL?	PRSA,V?ASK-ABOUT \FALSE
	EQUAL?	PRSI,CH-SEALS \?CCL19
	PRINTR	"	""Goddam bitch killed some of my best men."""
?CCL19:	EQUAL?	PRSI,LG-MONTANA \?CCL21
	PRINTR	"	""I took a quick look at her before I had to come back. They closed the mid-ships hatch, but it's clear that some of the interior bulkheads are buckled. We're probably going to need some explosives to move around in there. There's a gash in her side up near the bow, but the opening isn't big enough for a man to fit through."""
?CCL21:	EQUAL?	PRSI,TH-SAFE \?CCL23
	FSET?	TH-SAFE,FL-SEEN /?CCL26
	PRINTR	"	It'll be in his cabin, just forward of the attack center."
?CCL26:	PRINTR	"	I don't know how to open it. Each captain sets his own combination."
?CCL23:	EQUAL?	PRSI,TH-PLASTIC-CARD \?CCL28
	FSET?	CH-COFFEY,FL-BROKEN /?CCL31
	PRINTR	"	""Different missiles have different wiring diagrams. When you want to disarm one, you need the wiring codes to tell you the order to cut the wires."""
?CCL31:	FSET?	CH-COFFEY,FL-ASLEEP \?CCL33
	PRINTR	"	One of mnemonic series:
Oxford rows great big wide yachts.
Yankees rarely win over Green Bay.
Get rid of your wet bananas.
Go west, young boy, or rot."
?CCL33:	PRINTR	"	""I ain't tellin you nothing, pinko."""
?CCL28:	EQUAL?	PRSI,TH-FLATBED \?CCL35
	PRINTR	"	""The goddam bitch just rode it into the trench. I'll get even with her yet."""
?CCL35:	EQUAL?	PRSI,TH-MISSILE-TIMER \?CCL37
	PRINTR	"	""They set it for 12 hours so they'd have enough time to get away and save their skins. It may be booby-trapped, so we can't risk trying to disable it. Our only hope is to disarm the MIRV."""
?CCL37:	EQUAL?	PRSI,TH-MISSILE-ACCESS-KEY \?CCL39
	PRINTR	"	""There's always a duplicate access key on board somewhere. Usually the executive officer has it, but it's not as important as the missile firing key, so sometimes he just hangs it on the wall in the maintenance room so the technicians can get to it if they need it."""
?CCL39:	FSET?	CH-COFFEY,FL-BROKEN \?CCL41
	PRINTR	"	""Coffey, James G.; Lieutenant U.S. Navy; Serial Number 5894256"""
?CCL41:	PRINTR	"	""I don't know about that."""


	.FUNCT	RT-CH-ONE-NIGHT:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI \FALSE
	EQUAL?	PRSA,V?ASK-ABOUT \FALSE
	EQUAL?	PRSI,TH-UFO \FALSE
	PRINTR	"	""I only saw it for a moment. It was big and shiny. But until it started pulling us into the trench it somehow seemed, well, sort of friendly."""


	.FUNCT	RT-TH-DRY-SUIT:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL5
	PRINTI	"	It is a custom-made, one-piece dry suit that was designed especially for you. It zips up the front and includes flippers, a weight belt, and a helmet. The helmet has two threaded sockets on the side, and the faceplate is"
	ICALL2	RT-OPEN-MSG,TH-FACEPLATE
	PRINTR	"."
?CCL5:	EQUAL?	PRSA,V?WEAR \FALSE
	EQUAL?	WINNER,CH-PLAYER \?CCL10
	ICALL	RT-MOVE-ALL,CH-PLAYER,HERE
	MOVE	TH-DRY-SUIT,CH-PLAYER
	FSET	TH-DRY-SUIT,FL-WORN
	PRINTR	"	You drop everything you were carrying, strip down to your bathing suit, and step into the dry suit. You pull up the zipper and adjust the weight belt."
?CCL10:	PRINTI	"	The dry suit won't fit"
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE
	PRINTR	"."


	.FUNCT	RT-TH-FACEPLATE:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"	The faceplate is"
	ICALL2	RT-OPEN-MSG,TH-FACEPLATE
	PRINTR	"."


	.FUNCT	RT-TH-HELMET:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"	The helmet has two threaded sockets on the side, and the faceplate is"
	ICALL2	RT-OPEN-MSG,TH-FACEPLATE
	PRINTR	"."


	.FUNCT	RT-TH-HOOK-1:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-TH-LIFT-BAG:ANY:0:1,CONTEXT,L
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?TAKE \?CCL5
	ZERO?	GL-LIFT-OBJ /?CCL5
	FSET?	GL-LIFT-OBJ,FL-TAKEABLE /TRUE
	PRINTI	"	The lift bag is tied to"
	ICALL	RT-PRINT-OBJ,GL-LIFT-OBJ,K-ART-THE
	PRINTR	"."
?CCL5:	EQUAL?	PRSA,V?ATTACH,V?TIE-TO \?CCL11
	EQUAL?	PRSO,TH-LIFT-BAG \?CCL11
	SET	'GL-LIFT-OBJ,PRSI
	LOC	PRSI >L
	EQUAL?	L,LOCAL-GLOBALS,GLOBAL-OBJECTS \?CND14
	SET	'L,HERE
?CND14:	MOVE	TH-LIFT-BAG,L
	PRINTI	"	You tie the lift bag to"
	ICALL	RT-PRINT-OBJ,GL-LIFT-OBJ,K-ART-THE
	PRINTR	"."
?CCL11:	EQUAL?	PRSA,V?EXAMINE \?CCL17
	ZERO?	GL-LIFT-OBJ /?CCL20
	PRINTI	"	The lift bag is tied to"
	ICALL	RT-PRINT-OBJ,GL-LIFT-OBJ,K-ART-THE
	PRINTR	"."
?CCL20:	PRINTI	"	The lift bag is a"
	FSET?	TH-LIFT-BAG,FL-LOCKED \?CCL23
	PRINTI	"n inflated"
	JUMP	?CND21
?CCL23:	PRINTI	" collapsed"
?CND21:	PRINTI	" watertight sack "
	FSET?	TH-LIFT-BAG,FL-BROKEN \?CCL26
	PRINTR	"that has been sliced open."
?CCL26:	PRINTR	"with a small nylon loop at the top and two loose ropes hanging down from the bottom. Attached to the bag is a CO2 cannister that has a red button on it."
?CCL17:	EQUAL?	PRSA,V?INFLATE \?CCL28
	PRINT	K-HOW-INTEND-MSG
	CRLF	
	RTRUE	
?CCL28:	EQUAL?	PRSA,V?CUT \FALSE
	EQUAL?	PRSI,TH-KNIFE \FALSE
	FSET	TH-LIFT-BAG,FL-BROKEN
	PRINTI	"	You slice the fabric with your knife,"
	FSET?	TH-LIFT-BAG,FL-LOCKED \?CND33
	PRINTI	" releasing the gas"
	FSET?	HERE,FL-WATER \?CCL37
	PRINTI	" in a huge bubble and"
	JUMP	?CND33
?CCL37:	PRINTI	" and"
?CND33:	PRINTI	" rendering the bag completely useless.
"
	FSET?	TH-LIFT-BAG,FL-LOCKED \?CCL40
	EQUAL?	LG-MIDSHIP-HATCH,GL-LIFT-OBJ \?CCL40
	FCLEAR	LG-MIDSHIP-HATCH,FL-OPEN
	PRINTR	"	The hatch slams shut."
?CCL40:	IN?	TH-LIFT-BAG,CH-PLAYER \TRUE
	FSET?	HERE,FL-WATER \TRUE
	FSET?	HERE,FL-INDOORS \TRUE
	PRINTR	"	The bag no longer contrains your movements."


	.FUNCT	RT-TH-CO2-CANNISTER:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?LOOK-ON,V?EXAMINE \FALSE
	PRINTR	"	The cannister has a red button on it."


	.FUNCT	RT-TH-RED-BUTTON:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL5
	PRINTR	"	Pretty normal-looking red button."
?CCL5:	EQUAL?	PRSA,V?PUSH \FALSE
	FSET?	TH-CO2-CANNISTER,FL-BROKEN \?CCL10
	PRINTR	"	Nothing happens."
?CCL10:	FSET	TH-CO2-CANNISTER,FL-BROKEN
	FSET?	TH-LIFT-BAG,FL-BROKEN \?CCL13
	PRINTI	"	The gas rushes into the lift bag and out the gash in the fabric"
	FSET?	HERE,FL-WATER \?CND14
	PRINTI	", rising quickly out of sight in a large bubble"
?CND14:	PRINTR	"."
?CCL13:	FSET	TH-LIFT-BAG,FL-LOCKED
	PRINTI	"	The bag inflates like a hot air balloon"
	IN?	TH-LIFT-BAG,CH-PLAYER \?CCL18
	FSET?	HERE,FL-WATER \?CCL21
	EQUAL?	HERE,RM-UNDER-MOONPOOL \?CCL24
	PRINTR	", pulling you up to the surface of the MoonPool."
?CCL24:	FSET?	HERE,FL-INDOORS \?CCL26
	PRINTR	", pulling you up until you hit the ceiling."
?CCL26:	PRINTI	". Before you know what's happening, the extra lift starts to pull you rapidly toward the surface. Your ears pop and you feel excruciating pain in your elbows and knees. Mercifully, you pass out before suffering the gruesome death of sudden decompression.
"
	CALL1	RT-END-OF-GAME
	RSTACK	
?CCL21:	PRINTR	"."
?CCL18:	EQUAL?	GL-LIFT-OBJ,LG-MIDSHIP-HATCH \?CCL28
	FSET	LG-MIDSHIP-HATCH,FL-OPEN
	PRINTR	". The hatch slowly swings open."
?CCL28:	FSET?	HERE,FL-WATER \?CCL30
	EQUAL?	HERE,RM-UNDER-MOONPOOL /TRUE
	FSET?	HERE,FL-INDOORS \TRUE
	RTRUE	
?CCL30:	PRINTR	"."


	.FUNCT	RT-RM-COMPRESSION-CHAMBER:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	ICALL	RT-PRINT-OBJ,RM-COMPRESSION-CHAMBER,K-ART-THE
	PRINTI	". This is a tiny cylinder constructed from HY-150 Steel, designed to withstand pressures of up to 300 atmospheres, or 10,000 feet below sea-level. Along one wall is a bench that is built like a window seat. There is a hatch in the ceiling. A door in the fore bulkhead leads out to the gas-mix room.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-EXIT \?CCL8
	CALL2	RT-IS-QUEUED?,RT-I-UFO-MESSAGE
	ZERO?	STACK /FALSE
	ICALL2	RT-DEQUEUE,RT-I-UFO-MESSAGE
	MOVE	CH-COFFEY,RM-SUB-BAY
	MOVE	CH-HIPPY,RM-SUB-BAY
	PRINTI	"	You start to leave, but One-Night plucks at your sleeve and holds you back. "
	PRINT	K-UFO-MSG
	RTRUE	
?CCL8:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-LG-CHAMBER-HATCH:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?OPEN \FALSE
	FSET?	LG-CHAMBER-HATCH,FL-OPEN /FALSE
	ZERO?	GL-CAB-DOCKED? \?CCL10
	PRINTR	"	Since a cab is not docked, the hatch refuses to open."
?CCL10:	IN?	CH-COFFEY,RM-CAB-THREE \FALSE
	FSET?	CH-COFFEY,FL-ALIVE \FALSE
	FSET	LG-CHAMBER-HATCH,FL-OPEN
	ICALL2	RT-DEQUEUE,RT-I-RETURN-2
	ICALL2	RT-DEQUEUE,RT-I-RETURN-3
	ICALL2	RT-DEQUEUE,RT-I-RETURN-4
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-UFO-MESSAGE,STACK
	MOVE	CH-COFFEY,RM-COMPRESSION-CHAMBER
	MOVE	CH-HIPPY,RM-COMPRESSION-CHAMBER
	MOVE	CH-ONE-NIGHT,RM-COMPRESSION-CHAMBER
	PRINTI	"	You open the hatch and an exhausted Coffey drops into the chamber. He no longer looks crisp and military. His uniform is ragged and there is a gash in his right shoulder. He slumps onto the bench. Hippy is next through the hatch. He hangs briefly by one arm and then lets go. Another pair of legs dangles from the ceiling, and then One-Night falls to the floor with a loud groan. Her clothes are soaked, and she is shivering from the cold.

"
	MARGIN	50,50
	PRINTI	"[GRAPHIC #4: Shot in the compression chamber of the three of them - beat up and exhausted.]

"
	MARGIN	0,0
	PRINTI	"	You wait a moment, expecting the other SEALS to come through the hatch, but no one does. Coffey looks at you angrily. ""Dead,"" he says. They're all dead."" He points accusingly at One-Night, ""And it's all "
	HLIGHT	K-H-BLD
	PRINTI	"her"
	HLIGHT	K-H-NRM
	PRINTI	" fault."" You look at One-Night, but she just shakes her head.
	Coffey wipes his face with his sleeve. ""By the time we got over to the Montana, the other submersible had already cleared out. I ordered Flatbed to check out the stern of the ship while I reconnoitered the bow. But when I returned to the rendezvous point, no one was there. Then I saw "
	HLIGHT	K-H-BLD
	PRINTI	"Miss"
	HLIGHT	K-H-NRM
	PRINTR	" Standing free-swimming towards the Cab. We brought her in through the hatch, and she told us some bullshit story about being sucked into the trench in the wake of a glowing ship and then crashing Flatbed into a wall.""
	""I don't know what really happened, but I do know that this bitch has killed three of my best men and that she's going to pay for it.""
	""But wait, it gets better. Whoever those bastards in the submersible were, they've armed one of the MIRVs and attached a timer to it that's set to go off in 12 hours.""
	""They must have taken the access key from the sub captain's body and then used it to open up the MIRV. I took a look at that timer. No way we can disable it safely. Our only hope is to find the duplicate access key. Then we gotta break into the captain's safe, get the missile wiring codes, and cut the wires.""
	The three of them struggle to their feet and start to leave, but One-Night catches your eye and signals you to wait."


	.FUNCT	RT-I-LEAVE-1:ANY:0:0
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-LEAVE-2,STACK
	MOVE	CH-ONE-NIGHT,RM-SUB-BAY
	MOVE	CH-HIPPY,RM-SUB-BAY
	MOVE	CH-COFFEY,RM-SUB-BAY
	EQUAL?	HERE,RM-CORRIDOR \FALSE
	PRINTR	"	One-Night, Hippy, and the SEALs disappear aft into the sub-bay."


	.FUNCT	RT-I-LEAVE-2:ANY:0:0
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-LEAVE-3,STACK
	FCLEAR	CH-ONE-NIGHT,FL-NO-DESC
	MOVE	CH-ONE-NIGHT,RM-CAB-THREE
	MOVE	CH-HIPPY,RM-GAS-MIX-ROOM
	MOVE	CH-COFFEY,RM-GAS-MIX-ROOM
	EQUAL?	HERE,RM-SUB-BAY \FALSE
	PRINTR	"	One-Night drops through Flatbed's hatch. Monk and Willhite gather up their dive gear and follow her, pulling the hatch shut behind them. The big submersible sinks into the MoonPool and then disappears from sight. Coffey picks up a case marked ""FSB -- MARK IV,"" puts it in the dive locker, and pockets the key. Then he follows Hippy and Schoenick into the gas-mix room."


	.FUNCT	RT-I-LEAVE-3:ANY:0:0
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-LEAVE-4,STACK
	MOVE	CH-HIPPY,RM-COMPRESSION-CHAMBER
	MOVE	CH-COFFEY,RM-COMPRESSION-CHAMBER
	EQUAL?	HERE,RM-GAS-MIX-ROOM \FALSE
	PRINTR	"	Hippy, Coffey, and Schoenick enter the compression chamber."


	.FUNCT	RT-I-LEAVE-4:ANY:0:0
	FCLEAR	CH-HIPPY,FL-NO-DESC
	FCLEAR	CH-COFFEY,FL-NO-DESC
	MOVE	CH-HIPPY,RM-CAB-THREE
	MOVE	CH-COFFEY,RM-CAB-THREE
	EQUAL?	HERE,RM-GAS-MIX-ROOM,RM-COMPRESSION-CHAMBER \FALSE
	PRINTC	TAB
	EQUAL?	HERE,RM-GAS-MIX-ROOM \?CND4
	PRINTI	"Through the "
	FSET?	LG-CHAMBER-DOOR,FL-OPEN \?CCL8
	PRINTI	"door"
	JUMP	?CND6
?CCL8:	PRINTI	"window"
?CND6:	PRINTI	" you see "
?CND4:	PRINTR	"Hippy and the two SEALs climb up into Cab Three and pull the hatch shut behind them. Moments later you hear a 'clank' as Cab Three pulls away from Deepcore's hull."


	.FUNCT	RT-I-RETURN-1:ANY:0:0
	ADD	GL-MOVES,10
	ICALL	RT-QUEUE,RT-I-RETURN-2,STACK
	SET	'GL-CAB-DOCKED?,TRUE-VALUE
	FSET	RM-CAB-THREE,FL-BROKEN
	PRINTR	"	The intercom buzzes and you hear One-Night's voice: ""This is Cab Three docking over the compression chamber, boss. The heater's busted and we've got wounded. Come open the hatch before we freeze to death."""


	.FUNCT	RT-I-RETURN-2:ANY:0:0
	ADD	GL-MOVES,10
	ICALL	RT-QUEUE,RT-I-RETURN-3,STACK
	PRINTR	"	The intercom buzzes and you hear One-Night again. ""Better hurry, boss. I don't know if we're all gonna make it."""


	.FUNCT	RT-I-RETURN-3:ANY:0:0
	ADD	GL-MOVES,5
	ICALL	RT-QUEUE,RT-I-RETURN-4,STACK
	PRINTR	"	The intercom buzzes for a moment, and then trails off into silence."


	.FUNCT	RT-I-RETURN-4:ANY:0:0
	FCLEAR	CH-COFFEY,FL-ALIVE
	FCLEAR	CH-HIPPY,FL-ALIVE
	FCLEAR	CH-ONE-NIGHT,FL-ALIVE
	RFALSE	


	.FUNCT	RT-I-UFO-MESSAGE:ANY:0:0
	MOVE	CH-COFFEY,RM-SUB-BAY
	MOVE	CH-HIPPY,RM-SUB-BAY
	PRINTI	"	When Coffey and Hippy have left, One-Night plucks your sleeve and says,"
	PRINT	K-UFO-MSG
	RTRUE	


	.FUNCT	RT-RM-CAB-THREE:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"climb up into"
?CND4:	PRINTI	" Cab Three. It is a small submersible which was designed to shuttle passengers between the surface and Deepcore. There is a chair for the pilot up front, and four jump seats in the back. The only exit is through the hatch in the floor.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTERED \?CCL8
	IN?	CH-COFFEY,RM-CAB-THREE \FALSE
	FSET?	CH-COFFEY,FL-ALIVE /FALSE
	PRINTR	"	The lifeless bodies of Coffey, One-Night and Hippy gaze at you accusingly with the wide-eyed stare of the dead."
?CCL8:	EQUAL?	CONTEXT,M-BEG \?CCL15
	FSET?	RM-CAB-THREE,FL-BROKEN /FALSE
	IN?	CH-LINDSEY,RM-CAB-THREE \FALSE
	EQUAL?	PRSA,V?WALK-TO \FALSE
	EQUAL?	PRSO,LG-MONTANA \FALSE
	SET	'GL-CAB-DOCKED?,FALSE-VALUE
	PRINTI	"""Right-o."" Lindsey starts flicking levers and pushing buttons. You feel a jerk as the cab separates itself from Deepcore, and then watch out the front viewport as Lindsey maneuvers the Cab along the ocean floor toward the submarine.
"
	ADD	GL-MOVES,19 >GL-MOVES
	ICALL1	CLOCKER
	MOVE	RM-CAB-THREE,RM-MISSILE-HATCH
	PRINTR	"	After ten minutes or so, Cab Three passes over the lip of the chasm and sinks slowly towards the submarine. The submersible settles precariously onto the curved wall of the Montana."
?CCL15:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-OUT-CAB:ANY:0:1,QUIET
	ZERO?	GL-CAB-DOCKED? /?CCL3
	ZERO?	QUIET \?CTR5
	FSET?	LG-CHAMBER-HATCH,FL-OPEN \?CCL6
?CTR5:	RETURN	RM-COMPRESSION-CHAMBER
?CCL6:	PRINTR	"	The hatch isn't open."
?CCL3:	LOC	RM-CAB-THREE
	RSTACK	


	.FUNCT	RT-I-CAB-FIXED:ANY:0:0
	FCLEAR	RM-CAB-THREE,FL-BROKEN
	MOVE	CH-LINDSEY,RM-CAB-THREE
	PRINTR	"The intercom buzzes. ""This is Lindsey. I'm pleased to report that Cab Three is ready for action."""


	.FUNCT	RT-TH-CAB-HOOKAH:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?CUT \FALSE
	EQUAL?	PRSI,TH-KNIFE \FALSE
	ZERO?	GL-FALLING-INTO-TRENCH? /FALSE
	ICALL2	RT-DEQUEUE,RT-I-INTO-TRENCH-1
	ICALL2	RT-DEQUEUE,RT-I-INTO-TRENCH-2
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-OUT-OF-AIR-1,STACK
	REMOVE	RM-CAB-THREE
	MOVE	CH-LINDSEY,RM-ALIEN-CHAMBER
	PRINTR	"	You take a deep breath, reach up, and sever the hookah. You begin to rise back up to the level of the Montana. Glancing down, you see the Cab disappearing into the inky blackness of the trench. Lindsey hasn't been able to free herself. She looks up at you as she is being dragged down. She reaches her hand toward you and her eyes send you a silent plea for help. Then she disappears into the darkness."


	.FUNCT	RT-RM-GAS-MIX-ROOM:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" a small antechamber between the sub-bay and the compression chamber, which are fore and aft respectively. On the wall is a small video screen with a black button below it. The door to the compression chamber is"
	ICALL2	RT-OPEN-MSG,LG-CHAMBER-DOOR
	PRINTI	".
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-CORRIDOR:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"step out into"
?CND4:	ICALL	RT-PRINT-OBJ,RM-CORRIDOR,K-ART-THE
	PRINTI	" that connects Deepcore's port and starboard sides. Towards the bow is a door that leads to the command module. Aft is the entrance to the sub-bay. There is a small panel set into the floor below your feet.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTERED \?CCL8
	EQUAL?	GL-PUPPY,CH-CATFISH \FALSE
	CALL1	RT-CLEAR-PUPPY
	RSTACK	
?CCL8:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-TH-PANEL:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-RM-LADDER-A2:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the middle level of ladderwell A. A corridor leads to the starboard side of Deepcore. A hatch in the port bulkhead opens onto the electronics room. The lounge is forward, and aft is the mess hall.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-LOUNGE:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the lounge, which is where most crew members congregate during their time off. A couch with a curved back fits along the starboard cylinder wall. It faces a small television that is hooked up to a VCR. The only exit is through the aft hatchway.
"
	ZERO?	GL-BATTERY-LEAK /FALSE
	PRINTI	"	You see a stream of water coming from the ceiling. It pours down the wall and disappears in the room below.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-INFIRMARY:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the infirmary. The only exit is the door in the port wall.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-MESS-HALL:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	This is Deepcore's mess hall. There is a circular table in the middle of the room and a few chairs have been stacked against the wall. The forward exit leads to ladderwell A. The aft exit opens onto the galley.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTERED \?CCL5
	IN?	CH-COFFEY,RM-MESS-HALL \FALSE
	IN?	CH-CATFISH,RM-MESS-HALL \FALSE
	FSET?	CH-CATFISH,FL-ASLEEP \FALSE
	ZERO?	GL-CATFISH-SPY-MSG? \FALSE
	SET	'GL-CATFISH-SPY-MSG?,TRUE-VALUE
	PRINTI	"	Coffey looks up as you enter. ""Oh, there you are Brigman. I'll bet you didn't know that your favorite boy here is a Russkie, didja?"" He gestures to Catfish with his gun, and you see that his hand is trembling. ""I caught him red-handed. And when he wakes up, he's gonna find out how it feels to be both Red "
	HLIGHT	K-H-BLD
	PRINTI	"and"
	HLIGHT	K-H-NRM
	PRINTR	" dead."""
?CCL5:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-GALLEY:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	This is a fully equipped galley that has everything including the kitchen sink. You see a microwave, refrigerator, sink, and even a garbage compactor. You can go both fore and aft from here.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-PANTRY:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the pantry. The food supplies are stored in the cupboards that line the walls. There are exits both fore and aft.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-TH-HOOK-2:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-TH-GAME-BAG:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-RM-WALDORF:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" The Waldorf, which is what the crew irreverently calls your living quarters because it is the only stateroom aboard Deepcore that has its own sink. Rank hath its privileges. The room is in its usual state of chaos. Your bunk is situated with the head near the forward hatch and the foot next to the hatch in the aft bulkhead.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-PERSONAL-STORAGE-1:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	This is a storage room for personal effects. Your locker is on the wall near the hatch leading forward to your stateroom. The locker belonging to Hippy is next to the door in the aft bulkhead.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-ZOOTOWN:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"step into"
?CND4:	PRINTI	" Hippy's living quarters, known to the crew as 'Zootown' because of the succession of unusual pets he has brought aboard Deepcore. Hatches here lead fore and aft.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-LADDER-C2:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the middle level of ladderwell C. A hatch in the forward bulkhead opens into Hippy's living quarters. There is a yellow button here, with a sign underneath it.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-TH-S-BILGE-BUTT:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-RM-LADDER-A1:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the lowest level of ladderwell A. A hatch in the port bulkhead opens onto the laundry room. The Port Battery room is just forward of here, and aft is Port Life Support.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-LAUNDRY:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the laundry room. The washer and dryer flank a shelf that contains laundry supplies. The only exit is the door in the starboard wall.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-PT-LIFE-SUPPORT:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the port life support room. All around you is a jungle of fittings, gauges, and circuit boards. They control the CO2 scrubbers, dehumidifiers, heaters and other devices that make life possible 2,000 feet below the surface. Exits here lead fore and aft.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-COMPRESSOR-ROOM:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the compressor room. You see a dark labyrinth of pipes emanating from the huge compressor that supplies air to the hookahs. "
	FSET?	TH-COMPRESSOR,FL-BROKEN /?CTR8
	FSET?	TH-COMPRESSOR,FL-ON /?CCL9
?CTR8:	PRINTI	"The eerie silence makes an unsettling contrast to the normal cacophany in the cylinder."
	JUMP	?CND7
?CCL9:	PRINTI	"It's hard to hear yourself think over the roar of the machinery."
?CND7:	PRINTI	" There are hatchways leading out of both the forward and aft bulkheads.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-TH-COMPRESSOR:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-RM-LADDER-D1:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the lowest level of ladderwell D. A hatch in the forward bulkhead leads to tri-mix storage, and another leads aft to your office.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-TOOL-PUSHER-OFFICE:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"step into"
?CND4:	PRINTI	" your office, a tiny cubicle with stacks of paperwork, tech manuals and waterstained centerfolds. The hatch in the forward bulkhead leads to ladderwell D, and the starboard hatch opens onto the tool room.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-DRILL-ROOM:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the drill room, the working heart of Deepcore. In the center of the room is the massive turntable that spins the drill string when the rig is operating. Everything in the room is coated with the pungent, greasy chemical compound called 'drilling mud.' The only exit is through the hatch in the port bulkhead.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-LADDER-B1:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the lowest level of ladderwell B. A hatch in the starboard bulkhead opens onto the starboard head. The starboard battery room is just forward of here, and aft is starboard life support.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-SB-BATTERY-ROOM:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	This is one of the rooms that contain the huge fuelcells that power Deepcore. The powercels are surrounded by a wire cage that is festooned with signs that warn of the dangers of electricity. The fuelcells are humming ominously - as usual - and an acrid, ozone smell fills the air. The only exit is through the hatch in the aft bulkhead.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-SB-HEAD:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the starboard head. It is sparingly furnished with a shower, sink, and chemical toilet. The only exit is in the port bulkhead.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-SB-LIFE-SUPPORT:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the starboard life support room. All around you is a jungle of fittings, gauges, and circuit boards. They control the CO2 scrubbers, dehumidifiers, heaters and other devices that make life possible 2,000 feet below the surface. Exits here lead fore and aft.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-PUMP-ROOM:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the pump room. The machinery here controls the fresh water supply all over Deepcore. You can exit either fore or aft.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-FRESH-WATER-STORAGE:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" fresh water storage, where Deepcore's entire water supply is kept in one huge tank. There are doors in both the forward and aft walls.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-LADDER-C1:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the lowest level of ladderwell C. The only exits are the ladder leading up and the hatch in the forward wall.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-LADDER-A3:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the uppermost level of ladderwell A. Forward from here is the port observation deck. The female living quarters are aft. A hatch in the port bulkhead leads to the port head.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-PT-HEAD:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the port head. It is sparingly furnished with a shower, sink, and chemical toilet. The only exit is in the starboard bulkhead.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-MOTEL-QUICK:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the female living quarters, nicknamed ""Motel Quick"" by the crew. Exits hee lead both fore and aft.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-PERSONAL-STORAGE-2:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	This is a storage room for personal effects. One-Night's locker is on the wall near the forward hatch leading to Motel Quick. The locker belonging to Catfish is next to the door in the aft bulkhead.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-SWAMP:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the drill crew's living quarters, appropriately nicknamed ""The Swamp."" The hatch to ladderwell D is in the aft bulkhead, and there is a door in the forward bulkhead as well.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-LADDER-D3:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the highest level of ladderwell D. The only exits are the ladder leading down and the hatch in the forward bulkhead.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-LADDER-B3:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the uppermost level of ladderwell B. Hatchways fore, aft, and starboard lead to the starboard observation deck, the computer center, and the infirmary, respectively.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-SB-OBS-DECK:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the starboard observation deck, which has a huge domed plexiglass window that lets you look out onto the ocean floor. The only exit is in the aft bulkhead.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-COMPUTER-CENTER:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	This is Deepcore's computer center. On the desk is a dumb terminal to the mainframe aboard the Benthic Explorer on the surface. There is some text on the screen. Exits here lead fore and aft.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-ELECTRONICS-SHOP:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"step into"
?CND4:	PRINTI	" the electronics shop, which has become Hippy's personal domain. His workbench backs onto a storage unit that contains hundreds of clear plastic drawers, which in turn contain thousands of connectors, pins, and other spare parts. The workbench also has one large central drawer above the kneehole. The only exit is in the starboard bulkhead.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-TH-ELEC-SHOP-DRAWER:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-RM-LAB:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	This is Deepcore's biomedical lab. The room is cleaner than most of the other rooms aboard the habitat, but it has a curious, fishy odor to it. Exits lead fore and aft.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-TAPE-LIBRARY:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" Deepcore's tape library. The walls are covered with videotapes that range in subject matter from the serious to the scatological. You can exit either forward or aft.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-LADDER-C3:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the highest level of ladderwell C. You see a hatch in the forward bulkhead and a ladder leading down.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	

	.ENDI
