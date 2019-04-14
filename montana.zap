

	.FUNCT	RT-RM-MIDSHIP-HATCH:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are at"
	JUMP	?CND4
?CCL6:	PRINTI	"come to"
?CND4:	PRINTI	" the midship hatch of the Montana. The trough wall rises sharply to the east and the missile hatch is to the fore. Through the hatch is the attack center.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-LG-MIDSHIP-HATCH:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL5
	PRINTR	"	The hatch is a heavy, circular lid with a handle in the middle. Because the sub is resting on its side, the hinges are at the top."
?CCL5:	EQUAL?	PRSA,V?OPEN \?CCL7
	FSET?	LG-MIDSHIP-HATCH,FL-OPEN \?CCL10
	CALL	RT-ALREADY-MSG,PRSO,STR?93
	RSTACK	
?CCL10:	PRINTR	"	You grab the handle and try to lift the hatch, but only succeed in pushing yourself down in the water."
?CCL7:	EQUAL?	PRSA,V?CLOSE \FALSE
	FSET?	LG-MIDSHIP-HATCH,FL-OPEN /?CCL15
	CALL	RT-ALREADY-MSG,PRSO,STR?79
	RSTACK	
?CCL15:	PRINTR	"	You can't close the hatch against the buoyancy of the lift bag."


	.FUNCT	RT-TO-TRENCH-BOTTOM:ANY:0:0,QUIET
	ZERO?	QUIET /?CCL3
	RETURN	RM-TRENCH-BOTTOM
?CCL3:	IN?	TH-FBS-SUIT,CH-PLAYER \?CTR4
	FSET?	TH-FBS-SUIT,FL-WORN /?CCL5
?CTR4:	PRINTI	"	You can't go down that deep with a regular dry suit.
"
	RFALSE	
?CCL5:	RETURN	RM-TRENCH-BOTTOM


	.FUNCT	RT-RM-MISSILE-HATCH:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are at"
	JUMP	?CND4
?CCL6:	PRINTI	"come to"
?CND4:	PRINTI	" the missile hatch of the Montana. To the aft is the midship hatch, and the bow lies foreward.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-TH-MISSILE:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-TH-MISSILE-TIMER:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-TH-MISSILE-PANEL:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-TH-WIRES:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL5
	PRINTR	"	The wires are red, green, orange, yellow, blue, and white."
?CCL5:	EQUAL?	PRSA,V?CUT \FALSE
	PRINTI	"[You must specify which wire you want to cut.]
"
	RETURN	2


	.FUNCT	RT-TH-WIRE:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?CUT \FALSE
	EQUAL?	PRSI,TH-KNIFE \?CCL8
	PRINTR	"The wires are too close together to get the large blade of your knife between them."
?CCL8:	EQUAL?	PRSI,TH-WIRE-CUTTERS \FALSE
	FSET?	PRSO,FL-BROKEN \?CCL13
	CALL2	RT-ALREADY-MSG,STR?126
	RSTACK	
?CCL13:	CALL2	RT-CORRECT-WIRE?,PRSO
	ZERO?	STACK /?CCL15
	FSET	PRSO,FL-BROKEN
	INC	'GL-WIRES-CUT
	EQUAL?	GL-WIRES-CUT,6 \?CCL18
	SET	'GL-FALLING-INTO-TRENCH?,TRUE-VALUE
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-INTO-TRENCH-1,STACK
	PRINTR	"	You hold your breath and cut the last wire. Nothing happens. Lindsey smiles at you and gives you a big thumbs up.
	Lindsey pats you on the back and then starts to climb back into the Cab. The sudden imbalance makes it wobble precariously. Suddenly you realize that it is slipping off the curved side of the sub! Desperately, you make a lunge for the hatch to try to scramble inside, but it's too late. The Cab is falling into the trench, and you are going to be dragged along with it."
?CCL18:	PRINTI	"	You cut"
	ICALL	RT-PRINT-OBJ,PRSO,K-ART-THE
	PRINTR	"."
?CCL15:	PRINTI	"	The explosion is so instantaneous and so massive that you have no sensation of dying. You simply cease to be.
"
	CALL1	RT-END-OF-GAME
	RSTACK	


	.FUNCT	RT-CORRECT-WIRE?:ANY:1:1,WIRE
	ZERO?	GL-WIRE-SEQUENCE /FALSE
	EQUAL?	PRSO,TH-RED-WIRE \?CCL5
	EQUAL?	GL-WIRE-SEQUENCE,1,4 \?CCL8
	FSET?	TH-ORANGE-WIRE,FL-BROKEN /TRUE
	RFALSE	
?CCL8:	EQUAL?	GL-WIRE-SEQUENCE,2 \?CCL13
	FSET?	TH-YELLOW-WIRE,FL-BROKEN /TRUE
	RFALSE	
?CCL13:	EQUAL?	GL-WIRE-SEQUENCE,3 \FALSE
	FSET?	TH-GREEN-WIRE,FL-BROKEN /TRUE
	RFALSE	
?CCL5:	EQUAL?	PRSO,TH-BLUE-WIRE \?CCL23
	EQUAL?	GL-WIRE-SEQUENCE,1,2 \?CCL26
	FSET?	TH-GREEN-WIRE,FL-BROKEN /TRUE
	RFALSE	
?CCL26:	EQUAL?	GL-WIRE-SEQUENCE,3 \?CCL31
	FSET?	TH-WHITE-WIRE,FL-BROKEN /TRUE
	RFALSE	
?CCL31:	EQUAL?	GL-WIRE-SEQUENCE,4 \FALSE
	FSET?	TH-YELLOW-WIRE,FL-BROKEN /TRUE
	RFALSE	
?CCL23:	EQUAL?	PRSO,TH-GREEN-WIRE \?CCL41
	EQUAL?	GL-WIRE-SEQUENCE,1 \?CCL44
	FSET?	TH-RED-WIRE,FL-BROKEN /TRUE
	RFALSE	
?CCL44:	EQUAL?	GL-WIRE-SEQUENCE,2 \TRUE
	FSET?	TH-ORANGE-WIRE,FL-BROKEN /TRUE
	RFALSE	
?CCL41:	EQUAL?	PRSO,TH-YELLOW-WIRE \?CCL54
	EQUAL?	GL-WIRE-SEQUENCE,1,4 \?CCL57
	FSET?	TH-WHITE-WIRE,FL-BROKEN /TRUE
	RFALSE	
?CCL57:	EQUAL?	GL-WIRE-SEQUENCE,2 /TRUE
	EQUAL?	GL-WIRE-SEQUENCE,3 \FALSE
	FSET?	TH-ORANGE-WIRE,FL-BROKEN /TRUE
	RFALSE	
?CCL54:	EQUAL?	PRSO,TH-ORANGE-WIRE \?CCL69
	EQUAL?	GL-WIRE-SEQUENCE,1 /TRUE
	EQUAL?	GL-WIRE-SEQUENCE,2 \?CCL74
	FSET?	TH-WHITE-WIRE,FL-BROKEN /TRUE
	RFALSE	
?CCL74:	EQUAL?	GL-WIRE-SEQUENCE,3 \?CCL79
	FSET?	TH-RED-WIRE,FL-BROKEN /TRUE
	RFALSE	
?CCL79:	EQUAL?	GL-WIRE-SEQUENCE,4 \FALSE
	FSET?	TH-BLUE-WIRE,FL-BROKEN /TRUE
	RFALSE	
?CCL69:	EQUAL?	PRSO,TH-WHITE-WIRE \FALSE
	EQUAL?	GL-WIRE-SEQUENCE,1 \?CCL92
	FSET?	TH-BLUE-WIRE,FL-BROKEN /TRUE
	RFALSE	
?CCL92:	EQUAL?	GL-WIRE-SEQUENCE,2 \?CCL97
	FSET?	TH-RED-WIRE,FL-BROKEN /TRUE
	RFALSE	
?CCL97:	EQUAL?	GL-WIRE-SEQUENCE,3 \?CCL102
	FSET?	TH-YELLOW-WIRE,FL-BROKEN /TRUE
	RFALSE	
?CCL102:	EQUAL?	GL-WIRE-SEQUENCE,4 \FALSE
	FSET?	TH-GREEN-WIRE,FL-BROKEN /TRUE
	RFALSE	


	.FUNCT	RT-TH-WIRE-CUTTERS:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-I-INTO-TRENCH-1:ANY:0:0
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-INTO-TRENCH-2,STACK
	PRINTR	"	The hookah line goes taut and drags you down after the sub. A quick glance to your right reveals that Lindsey's hookah has caught on the Cab's open hatch and she is being dragged down too. Your chest begins to tighten under the additional pressure. If you don't do something quickly, you will die."


	.FUNCT	RT-I-INTO-TRENCH-2:ANY:0:0
	PRINTI	"	The cab pulls you deeper and deeper. Suddenly you feel a massive pain in your chest and you black out. The last thing you see before dying is Lindsey's hand reaching toward you for help.
"
	CALL1	RT-END-OF-GAME
	RSTACK	


	.FUNCT	RT-I-OUT-OF-AIR-1:ANY:0:0
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-OUT-OF-AIR-2,STACK
	PRINTR	"	You can't hold your breath much longer."


	.FUNCT	RT-I-OUT-OF-AIR-2:ANY:0:0
	MOVE	CH-PLAYER,RM-SUB-BAY
	MOVE	TH-DRY-SUIT,RM-SUB-BAY
	FCLEAR	TH-DRY-SUIT,FL-WORN
	FCLEAR	TH-DIVE-LOCKER,FL-LOCKED
	FSET	TH-DIVE-LOCKER,FL-OPEN
	MOVE	CH-HIPPY,RM-SUB-BAY
	MOVE	CH-CATFISH,RM-SUB-BAY
	PRINTR	"	You realize that you can't hold your breath any longer and that you are going to die. Your chest aches, and you see bright lights dancing before your eyes. But all you can think of is Lindsey's face as she disappeared into the trough. Just when you think you are going to pass out, you notice that the lights seem to be clustering around you, pushing you gently back towards Deepcore. Unable to hold the air any longer, you expel it and expect to inhale a mouthful of water. Instead you discover that you can breathe quite normally.
	You reach out to touch the lights, but your hand passes right through them. After a few moments, you relax and enjoy the ride. Soon you find yourself approaching Deepcore. The lights stay with you until you surface inside the MoonPool, and then they streak away back toward the trench.
	Catfish grabs your hand and hoists you to firm ground as easily as if you were a child. He helps you out of your dive suit and into dry clothes. He says that he thinks that there is some kind of benevolent alien at the bottom of the Trench, and that Lindsey's monitoring system shows she is still alive, down near the bottom of the trench.
	Hippy comes in and says, ""I think I can open this locker now."" He holds an electronic device near the lock, and the locker pops open. Inside it is the fluid breathing system suit."


	.FUNCT	RT-RM-BOW:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are at"
	JUMP	?CND4
?CCL6:	PRINTI	"come to"
?CND4:	PRINTI	" the bow of the Montana. The missile hatch is aft of here. You see the huge gash that was the Montana's death wound. When we get graphics into the game you will only be able to fly the ROV in here. But for now, come on in!
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-TORPEDO-ROOM:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the Montana's torpedo room. Foreward lies the gash in the hull and aft is the engine room.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-ENGINE-ROOM:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the engine room of the Montana. The torpedo room is foreward, and aft is the missile launching room.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-MISSILE-ROOM:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the missile launching room. On the wall hangs the missile access key.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-TH-MISSILE-ACCESS-KEY:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-RM-ATTACK-CENTER:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK \?CCL3
	PRINTR	"	Cautiously, you swim through the hatch. You pull yourself along by the rungs on the ladder, and then find yourself in the attack center. Your helmet light reveals an eerie scene of floating debris and lop-sided high-tech wreckage. You fight off the disorientation caused by everything being on its side, and then locate the body of the captain and confirm that the missile access key has been removed from his neck. Fighting the urge to vomit, you turn away and see a companionway leading aft."
?CCL3:	EQUAL?	CONTEXT,M-V-LOOK,M-LOOK \?CCL5
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL8
	PRINTI	"are in"
	RFALSE	
?CCL8:	EQUAL?	OHERE,RM-MIDSHIP-HATCH \?CCL10
	PRINTI	"swim through the hatch to the attack center. Aft, you see a companionway leading into the darkness.
"
	RFALSE	
?CCL10:	PRINTI	"enter the attack center. Above you is the midship hatch and the sonar shack lies aft.
"
	RFALSE	
?CCL5:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-SONAR-ROOM:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK \?CCL3
	PRINTR	"	Slowly, you swim through the doorway and come to the sonar room. The sonarman is slewed sideways, still strapped into his chair. He stares at the broken screen through blank eyes.
	Doors here lead fore and aft."
?CCL3:	EQUAL?	CONTEXT,M-V-LOOK,M-LOOK \?CCL5
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL8
	PRINTI	"are in"
	JUMP	?CND6
?CCL8:	PRINTI	"enter"
?CND6:	PRINTI	" the sonar room. Doors here lead fore and aft.
"
	RFALSE	
?CCL5:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-COMM-ROOM:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK \?CCL3
	PRINTR	"	You swim into the communications room, which was stacked floor to ceiling with high-tech equipment. The door in the aft bulkhead has buckled and looks as if it is jammed shut."
?CCL3:	EQUAL?	CONTEXT,M-V-LOOK,M-LOOK \?CCL5
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL8
	PRINTI	"are in"
	JUMP	?CND6
?CCL8:	PRINTI	"enter"
?CND6:	PRINTI	" the communications room. The sonar shack is to the fore and aft lies a corridor.
"
	RFALSE	
?CCL5:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-THRU-BUCKLED-DOOR:ANY:0:1,QUIET
	FSET?	LG-BUCKLED-DOOR,FL-OPEN \?CCL3
	RETURN	RM-SUB-CORRIDOR
?CCL3:	ZERO?	QUIET \FALSE
	PRINTI	"	You push up against the door. It gives a little, and then refuses to budge.
"
	RFALSE	


	.FUNCT	RT-LG-BUCKLED-DOOR:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL5
	PRINTR	"	The door in the aft bulkhead has buckled and looks as if it is jammed shut."
?CCL5:	EQUAL?	PRSA,V?PUSH,V?OPEN \FALSE
	PRINTI	"	You push up against the door. It gives a little, and then refuses to budge.
"
	RTRUE	


	.FUNCT	RT-RM-SUB-CORRIDOR:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK \?CCL3
	PRINTR	"	You enter a corridor that leads into the heart of the submarine. Below you is an open door leading into a stateroom. Only a few feet beyond the door, the floor starts to pinch in to meet the ceiling where the corridor has been crushed like the end of a paper towel roll."
?CCL3:	EQUAL?	CONTEXT,M-V-LOOK,M-LOOK \?CCL5
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL8
	PRINTI	"are in"
	JUMP	?CND6
?CCL8:	PRINTI	"enter"
?CND6:	PRINTI	" a corridor. The comm room is foreward and below you is the captain's quarters.
"
	RFALSE	
?CCL5:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-CAPTAINS-ROOM:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK \?CCL3
	PRINTR	"	You swim down into the room below you, which turns out to be the captain's stateroom. The room is curiously untouched by the disaster. Except for the fact that everything has rotated ninety degrees, it is as neat and tidy as if it were awaiting an admiral's inspection. The bunk is made. Interestingly enough, the framed photograph on the wall doesn't seem to have shifted position, even though the sub is lying on its side."
?CCL3:	EQUAL?	CONTEXT,M-V-LOOK,M-LOOK \?CCL5
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL8
	PRINTI	"are in"
	JUMP	?CND6
?CCL8:	PRINTI	"enter"
?CND6:	PRINTI	" the captain's stateroom. Above you is a corridor.
"
	RFALSE	
?CCL5:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-TH-PHOTOGRAPH:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL5
	FSET	TH-PHOTOGRAPH,FL-SEEN
	PRINTR	"	The picture is of the same man whose body you saw in the control room. He is standing with his arm around a woman, and they are both smiling into the camera. At the bottom is scrawled, ""Twenty years before the mast. June 30, 1989. Love, Helen."""
?CCL5:	EQUAL?	PRSA,V?LOOK-BEHIND \FALSE
	FSET?	TH-SAFE,FL-SEEN \?CCL10
	PRINTR	"	Behind the picture is the wall safe."
?CCL10:	FSET	TH-SAFE,FL-SEEN
	MOVE	TH-SAFE,RM-CAPTAINS-ROOM
	PRINTR	"	You push aside the picture and discover a wall safe."


	.FUNCT	RT-TH-SAFE:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	CALL	NOUN-USED?,TH-SAFE,W?DIAL
	ZERO?	STACK /?CCL5
	EQUAL?	PRSA,V?EXAMINE \?CCL8
	PRINTI	"	The dial is turned to "
	PRINTN	GL-SAFE-NUM
	PRINTR	"."
?CCL8:	EQUAL?	PRSA,V?TURN \?CCL10
	RANDOM	101
	SUB	STACK,1 >GL-SAFE-NUM
	PRINTR	"	You spin the dial."
?CCL10:	EQUAL?	PRSA,V?TURN-TO \FALSE
	EQUAL?	PRSI,INTNUM \FALSE
	LESS?	P-NUMBER,0 /?CTR17
	GRTR?	P-NUMBER,100 \?CCL18
?CTR17:	PRINTR	"	The dial can only be turned to numbers between 0 and 100, inclusive."
?CCL18:	PRINTI	"	You turn the dial to "
	PRINTN	P-NUMBER
	PRINTC	46
	FSET?	TH-SAFE,FL-OPEN /?CND21
	EQUAL?	P-NUMBER,30 \?CCL24
	EQUAL?	GL-SAFE-NUM,6 \?CCL27
	FSET	TH-SAFE,FL-ON
	JUMP	?CND21
?CCL27:	FCLEAR	TH-SAFE,FL-ON
	JUMP	?CND21
?CCL24:	EQUAL?	P-NUMBER,69 \?CND21
	EQUAL?	GL-SAFE-NUM,30 \?CCL31
	FSET?	TH-SAFE,FL-ON \?CCL31
	FCLEAR	TH-SAFE,FL-ON
	FCLEAR	TH-SAFE,FL-LOCKED
	FSET	TH-SAFE,FL-OPEN
	PRINTI	" The safe door opens."
	CALL2	RT-SEE-ANYTHING-IN?,TH-SAFE
	ZERO?	STACK /?CND21
	PRINTI	" Inside you see"
	ICALL2	RT-PRINT-CONTENTS,TH-SAFE
	PRINTC	46
	JUMP	?CND21
?CCL31:	FCLEAR	TH-SAFE,FL-ON
?CND21:	SET	'GL-SAFE-NUM,P-NUMBER
	CRLF	
	RTRUE	
?CCL5:	EQUAL?	PRSA,V?CLOSE \?CCL37
	FSET?	TH-SAFE,FL-OPEN \FALSE
	FCLEAR	TH-SAFE,FL-OPEN
	FSET	TH-SAFE,FL-LOCKED
	RANDOM	101
	SUB	STACK,1 >GL-SAFE-NUM
	PRINTR	"	You close the safe and spin the dial."
?CCL37:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"	The safe is a combination safe with numbers on the dial from 0 to 100."


	.FUNCT	RT-TH-PLASTIC-CARD:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?READ,V?EXAMINE \FALSE
	PRINTR	"	The card has row after row of meaningless numbers written on it."


	.FUNCT	RT-TH-PLASTIQUE:ANY:0:1,CONTEXT,OBJ,V
	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL7
	PRINTI	"	The plastique is a flat package with some sticky, two-sided tape on the bottom."
	IN?	TH-DETONATOR,TH-PLASTIQUE \?CND8
	PRINTR	" There is a detonator attached to it."
?CND8:	CRLF	
	RTRUE	
?CCL7:	EQUAL?	PRSA,V?PUT,V?ATTACH \?CCL11
	EQUAL?	PRSI,LG-BUCKLED-DOOR \FALSE
	MOVE	TH-PLASTIQUE,HERE
	PUTP	TH-PLASTIQUE,P?OWNER,LG-BUCKLED-DOOR
	PRINTR	"	You stick the plastique to the door."
?CCL11:	EQUAL?	PRSA,V?TAKE \FALSE
	GETP	TH-PLASTIQUE,P?OWNER >OBJ
	ZERO?	OBJ /FALSE
	CALL1	ITAKE >V
	EQUAL?	V,M-FATAL \?CCL22
	RETURN	2
?CCL22:	ZERO?	V /FALSE
	PUTP	TH-PLASTIQUE,P?OWNER,FALSE-VALUE
	PRINTI	"	You remove the plastique from"
	ICALL	RT-PRINT-OBJ,OBJ,K-ART-THE
	PRINTR	"."


	.FUNCT	RT-TH-DETONATOR:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL5
	CALL	NOUN-USED?,TH-DETONATOR,W?DIAL,W?TIMER
	ZERO?	STACK /?CCL8
	PRINTI	"	The dial is set to "
	PRINTN	GL-DETONATOR-TIME
	PRINTR	"."
?CCL8:	CALL	NOUN-USED?,TH-DETONATOR,W?SWITCH
	ZERO?	STACK /?CCL10
	PRINTI	"	The switch is "
	FSET?	TH-DETONATOR,FL-ON \?CCL13
	PRINTI	"on"
	JUMP	?CND11
?CCL13:	PRINTI	"off"
?CND11:	PRINTR	"."
?CCL10:	PRINTR	"	The detonator is deceptively innocent looking. It has a timer that is calibrated in units of 5 from 10 to 60. Below the face of the timer is a single switch."
?CCL5:	EQUAL?	PRSA,V?PUT,V?PUT-IN,V?ATTACH \?CCL15
	EQUAL?	PRSO,TH-DETONATOR \FALSE
	EQUAL?	PRSI,TH-PLASTIQUE \FALSE
	MOVE	TH-DETONATOR,TH-PLASTIQUE
	PRINTR	"	You firmly imbed the prongs of the detonator into the plastique."
?CCL15:	EQUAL?	PRSA,V?TURN-TO \?CCL22
	EQUAL?	PRSI,INTNUM \?CTR24
	LESS?	P-NUMBER,10 /?CTR24
	GRTR?	P-NUMBER,60 /?CTR24
	MOD	P-NUMBER,5
	ZERO?	STACK /?CCL25
?CTR24:	PRINTI	"	The timer can only be set in increments of 5 between the numbers of 10 and 60, inclusive.
"
	RETURN	2
?CCL25:	SET	'GL-DETONATOR-TIME,P-NUMBER
	PRINTI	"	You set the dial to "
	PRINTN	P-NUMBER
	PRINTR	"."
?CCL22:	EQUAL?	PRSA,V?LISTEN \?CCL33
	FSET?	TH-DETONATOR,FL-ON \FALSE
	PRINTR	"	You hear a faint whirring."
?CCL33:	EQUAL?	PRSA,V?TURN-ON \?CCL38
	FSET?	TH-DETONATOR,FL-ON \?CCL41
	CALL2	RT-ALREADY-MSG,STR?127
	RSTACK	
?CCL41:	FSET	TH-DETONATOR,FL-ON
	MUL	GL-DETONATOR-TIME,2
	ADD	GL-MOVES,STACK
	ICALL	RT-QUEUE,RT-I-DETONATOR,STACK
	PRINTR	"	You turn the switch and hear a faint whirr."
?CCL38:	EQUAL?	PRSA,V?TURN-OFF \FALSE
	FSET?	TH-DETONATOR,FL-ON /?CCL46
	CALL2	RT-ALREADY-MSG,STR?128
	RSTACK	
?CCL46:	FCLEAR	TH-DETONATOR,FL-ON
	ICALL2	RT-DEQUEUE,RT-I-DETONATOR
	SET	'GL-DETONATOR-TIME,10
	PRINTR	"	You turn off the detonator. The timer resets itself to ten minutes."


	.FUNCT	RT-I-DETONATOR:ANY:0:1,CONTEXT,L,M
	LOC	TH-PLASTIQUE >L
	CALL2	META-LOC,TH-PLASTIQUE >M
	IN?	TH-DETONATOR,TH-PLASTIQUE \?CCL3
	REMOVE	TH-PLASTIQUE
	FSET?	M,FL-WATER \?CCL6
	FSET?	M,FL-INDOORS \?CCL6
	FSET?	HERE,FL-WATER \?CCL6
	FSET?	HERE,FL-INDOORS \?CCL6
	EQUAL?	HERE,M \?CCL13
	PRINTI	"	Suddenly you see a bright flash. An enormous shock wave slams into you and instantly kills you.
"
	JUMP	?CND11
?CCL13:	PRINTI	"	Suddenly you hear a muffled explosion. Seconds later an enormous shock wave slams you up against a bulkhead and kills you.
"
?CND11:	CALL1	RT-END-OF-GAME
	RSTACK	
?CCL6:	EQUAL?	L,RM-COMM-ROOM \?CCL15
	GETP	TH-PLASTIQUE,P?OWNER
	EQUAL?	STACK,LG-BUCKLED-DOOR \?CCL15
	FSET	LG-BUCKLED-DOOR,FL-OPEN
	CALL	GLOBAL-IN?,LG-MONTANA,HERE
	ZERO?	STACK /?CCL20
	PRINTR	"	Suddenly you hear a muffled explosion. The Montana seems to rock for a moment, and then settle back into its former position on the ledge."
?CCL20:	PRINTR	"	From far away, you hear a muffled thud. The plastique must have gone off inside the Montana."
?CCL15:	FSET?	M,FL-WATER \?CCL22
	FSET?	M,FL-INDOORS \?CCL25
	CALL	GLOBAL-IN?,LG-MONTANA,HERE
	ZERO?	STACK /?CCL28
	PRINTI	"	Suddenly you hear a muffled explosion. The Montana seems to rock for a moment, and then it slides off the ledge and plummets into the chasm!"
	JUMP	?CND26
?CCL28:	PRINTI	"	From far away, you hear a muffled thud. The plastique must have gone off inside the Montana. Unbeknownst to you, the blast jars loose the submarine, and it falls into the chasm."
?CND26:	PRINTI	" Seconds later, the sub slams against the wall of the chasm, ripping off the timing device, and igniting the nuclear warhead. Everything nearby is instantly vaporized, including you.
"
	CALL1	RT-END-OF-GAME
	RSTACK	
?CCL25:	PRINTR	"	The plastique goes ""BOOM"" in the water."
?CCL22:	FSET?	HERE,FL-WATER /?CCL31
	PRINTI	"	Suddenly, a huge explosion rips through Deepcore, killing you before you even have time to figure out what caused it.
"
	JUMP	?CND29
?CCL31:	PRINTI	"	Suddenly, a huge explosion rips through Deepcore, causing you to lose the will to live.
"
?CND29:	CALL1	RT-END-OF-GAME
	RSTACK	
?CCL3:	CALL2	ACCESSIBLE?,TH-DETONATOR
	ZERO?	STACK /FALSE
	FCLEAR	TH-DETONATOR,FL-ON
	SET	GL-DETONATOR-TIME,10
	PRINTR	"	The detonator makes a faint 'click'."

	.ENDI
