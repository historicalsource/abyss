

	.FUNCT	RT-I-CRANE-1:ANY:0:0
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-CRANE-2,STACK
	SET	'GL-CRANE-FALLING?,TRUE-VALUE
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-KLAXON,STACK
	SET	'GL-KLAXON-ON,TRUE-VALUE
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-DEEPCORE-TEMP,STACK
	PRINTI	"	Suddenly the lights go out and emergency klaxons start blaring. "
	EQUAL?	HERE,RM-COMMAND-MODULE \?CCL3
	PRINTI	"The control panel starts flashing wildly. Lindsey takes one look out of the front viewport, slaps the intercom button, and screams,"
	JUMP	?CND1
?CCL3:	PRINTI	"A second later Lindsey's voice screams over the intercom,"
?CND1:	PRINTI	" ""Emergency! The umbilicus is falling on top of us. It's coiling up on top of the starboard cylinders. God help us if it's still hooked to the crane. We've got two minutes before whatever's attached to the other end hits us. Everybody get the hell out of the starboard cylinders. Repeat. Evacuate the starboard cylinders immediately."" Emergency lights flicker on.
"
	EQUAL?	HERE,RM-COMMAND-MODULE \TRUE
	MOVE	CH-CATFISH,RM-CORRIDOR
	PRINTR	"	Catfish says, ""Shit! The arc-welding kit's in one of the starboard cylinders. If that crane hits us, we're gonna need it for damage control."" He tears out of the cylinder."


	.FUNCT	RT-I-CRANE-2:ANY:0:0
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-CRANE-3,STACK
	PRINTR	"	A rasping sound grates against your ears as loops of the umbilicus hit Deepcore and strafe the starboard cylinders."


	.FUNCT	RT-I-CRANE-3:ANY:0:0
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-CRANE-4,STACK
	MOVE	CH-CATFISH,RM-LADDER-B2
	PRINTR	"	A grinding crash of metal reverberates throughout Deepcore as some huge piece of equipment strikes one of the cylinders and bounces off."


	.FUNCT	RT-I-CRANE-4:ANY:0:0
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-CRANE-5,STACK
	PRINTI	"	Lindsey"
	EQUAL?	HERE,RM-COMMAND-MODULE \?CCL3
	PRINTI	" hits the intercom button again and screams,"
	JUMP	?CND1
?CCL3:	PRINTI	"'s voice shrieks over the intercom."
?CND1:	PRINTR	" ""Here it comes! All hands rig for impact!"""


	.FUNCT	RT-I-CRANE-5:ANY:0:0
	SET	'GL-CRANE-FALLING?,FALSE-VALUE
	SET	'GL-CRANE-DOWN?,TRUE-VALUE
	MOVE	TH-FIRE,RM-SUB-BAY
	ADD	GL-MOVES,14
	ICALL	RT-QUEUE,RT-I-FIRE-1,STACK
	SET	'GL-BATTERY-LEAK,TRUE-VALUE
	MOVE	TH-CRACK,RM-PT-OBS-DECK
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-BATTERY-LEAK,STACK
	MOVE	CH-COFFEY,RM-COMMAND-MODULE
	MOVE	CH-CATFISH,RM-DIVE-GEAR-STORAGE
	FSET	CH-CATFISH,FL-LOCKED
	FCLEAR	LG-DGS-DOOR,FL-OPEN
	MOVE	CH-HIPPY,RM-FRESH-WATER-STORAGE
	ADD	GL-MOVES,30
	ICALL	RT-QUEUE,RT-I-HIPPY-RETURN,STACK
	EQUAL?	HERE,RM-DIVE-GEAR-STORAGE \?CCL3
	PRINTI	"	Catfish rushes in, slamming the door behind him. He starts rummaging around in his locker. ""I've got to find the arc-welder,"" he yells.
"
	JUMP	?CND1
?CCL3:	ADD	GL-MOVES,4
	ICALL	RT-QUEUE,RT-I-CATFISH-TRAPPED,STACK
?CND1:	PRINTI	"	The inside of your head explodes as the crane slams into Deepcore with the impact of a hundred sticks of dynamite. The crane crashes into the starboard cylinders at an angle, toppling Deepcore almost over onto its side. You collide with the starboard bulkhead as the floor tilts crazily below your feet. Then you're thrown to the deck as the crane shears off the top of two aft cylinders and the rest of the rig crashes back onto the ocean floor with a shuddering jolt.
"
	EQUAL?	HERE,RM-COMMAND-MODULE \?CCL6
	PRINTR	"	Coffey saunters into the command module, looking unconcerned about the chaos that surrounds him. Lindsey looks up at you and says, ""I know we have our differences, Bud. But you're the one in command here, and I'll do whatever you tell me to."""
?CCL6:	EQUAL?	HERE,RM-DIVE-GEAR-STORAGE \?CCL8
	PRINTR	"	When your head clears you look around and take stock of your situation. A locker has fallen over, pinning Catfish to the floor. Water is cascading down into the room from the ceiling above."
?CCL8:	EQUAL?	HERE,RM-SUB-BAY \TRUE
	PRINTR	"	A reserve oxygen cylinder has been knocked loose of its mooring and lies on the floor. You can hear the hiss of the pure oxygen as it escapes into the breathing mix. Suddenly, an exposed wire along the wall begins to spark. The insulation nearby catches fire and the flames start to work their way towards the wooden dive locker."


	.FUNCT	RT-I-HIPPY-RETURN:ANY:0:0
	MOVE	CH-HIPPY,HERE
	PRINTR	"	Hippy stumbles into the room, sopping wet and gasping for air. ""I got trapped down in Fresh Water Storage,"" he gasps. ""The doors buckled and the only way out was through the emergency escape hatch in the bottom of the cylinder. But the wheel was jammed and I couldn't turn it. I had just given myself up for dead, when suddenly the wheel started turning all by itself! I was pretty spooked, but I didn't sit around to figure it out. I opened the hatch and swam over to the MoonPool. But just as I came out of the cylinder, I saw this...shape...disappear off towards the trench."""


	.FUNCT	RT-I-KLAXON:ANY:0:0
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-KLAXON,STACK
	FSET?	HERE,FL-WATER /FALSE
	PRINTR	"	The klaxons continue to blare in your ears."


	.FUNCT	RT-I-BATTERY-LEAK:ANY:0:0
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-BATTERY-LEAK,STACK
	FSET?	TH-PT-BILGE-BUTTON,FL-ON \?CCL3
	GRTR?	GL-WATER-LEVEL,0 \FALSE
	DEC	'GL-WATER-LEVEL
	RFALSE	
?CCL3:	IGRTR?	'GL-WATER-LEVEL,19 \?CCL7
	EQUAL?	HERE,RM-PT-BATTERY-ROOM \?CCL10
	PRINTI	"	Slowly, the water level rises until it encases the base of the huge powercels. Suddenly, everything goes dark and you hear all Deepcore's machinery grind to a halt. You see a few blue flashes below the water level, and then everything becomes very still. With"
	JUMP	?CND8
?CCL10:	FSET?	HERE,FL-WATER \?CCL12
	FSET?	HERE,FL-INDOORS /?CND8
	PRINTI	"	You glance back at Deepcore and see all the lights flicker out. You realize immediately that something has shorted out the powercels in the battery room. You swim back to investigate, emerge into the MoonPool, and try to make your way down to the battery room. But with"
	JUMP	?CND8
?CCL12:	PRINTI	"	Suddenly, everything goes dark and you hear all of Deepcore's machinery grind to a halt. In the eerie silence that follows, you realize that something has shorted out the powercels in the battery room. With"
?CND8:	PRINTI	" no power to maintain the temperature and the air supply, the end comes much more quickly than you would have expected.
"
	CALL1	RT-END-OF-GAME
	RSTACK	
?CCL7:	EQUAL?	HERE,RM-PT-BATTERY-ROOM \FALSE
	PRINTI	"	The pool of water"
	GRTR?	GL-WATER-LEVEL,17 \?CCL19
	PRINTR	" will reach the battery cases within seconds. If it does, all will be lost."
?CCL19:	GRTR?	GL-WATER-LEVEL,10 \?CCL21
	PRINTR	" is rising rapidly, and will soon short out the batteries."
?CCL21:	GRTR?	GL-WATER-LEVEL,5 \?CCL23
	PRINTR	", if it rises much further, will reach the battery cases and short out Deepcore's sole remaining source of emergency power."
?CCL23:	PRINTR	" is approaching the base of the battery cases."


	.FUNCT	RT-RM-PT-BATTERY-ROOM:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	This is one of the rooms that contain the huge fuelcells that power Deepcore. The powercels are surrounded by a wire cage that is festooned with signs that warn of the dangers of electricity. The fuelcells are humming ominously - as usual - and an acrid, ozone smell fills the air. The only exit is through the hatch in the aft bulkhead.
"
	ZERO?	GL-BATTERY-LEAK /FALSE
	PRINTI	"	A stream of water is flowing down the wall from the ceiling "
	FSET?	TH-PT-BILGE-BUTTON,FL-ON \?CCL8
	ZERO?	GL-WATER-LEVEL \?CCL11
	PRINTI	"but it is sucked up by the pump as soon as it hits the floor."
	JUMP	?CND6
?CCL11:	PRINTI	"into the pool of water on the floor. The pool looks like it is getting smaller."
	JUMP	?CND6
?CCL8:	LESS?	GL-WATER-LEVEL,6 \?CCL13
	PRINTI	"into a pool of water on the floor. As the water rises, it approaches the base of the battery cases."
	JUMP	?CND6
?CCL13:	LESS?	GL-WATER-LEVEL,11 \?CCL15
	PRINTI	"into the pool of water. If the water rises much further, it will reach the battery cases and short out Deepcore's sole remaining source of emergency power."
	JUMP	?CND6
?CCL15:	LESS?	GL-WATER-LEVEL,18 \?CCL17
	PRINTI	"into the rapidly rising water."
	JUMP	?CND6
?CCL17:	LESS?	GL-WATER-LEVEL,20 \?CCL19
	PRINTI	"into the pool of water. The water will reach the battery cases within seconds. If it does, all will be lost."
	JUMP	?CND6
?CCL19:	PRINTI	"into the rapidly rising water below."
?CND6:	CRLF	
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-TH-POWERCEL:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-TH-POOL-OF-WATER:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-RM-PT-OBS-DECK:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the port observation deck, which has a huge domed plexiglass window where the forward bulkhead should be. The only exit is in the aft bulkhead.
"
	ZERO?	GL-BATTERY-LEAK /FALSE
	PRINTI	"	There is a fair-sized crack in the starboard bulkhead, up near the ceiling. Water is pouring in through the crack, running down the wall, and disappearing into the room below.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-TH-CRACK:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI /?CCL5
	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSO,TH-WELDING-ROD \FALSE
	CALL1	RT-WELD-CRACK
	RSTACK	
?CCL5:	EQUAL?	PRSA,V?WELD \FALSE
	CALL1	RT-WELD-CRACK
	RSTACK	


	.FUNCT	RT-WELD-CRACK:ANY:0:0
	CALL	RT-META-IN?,TH-ARC-WELDER,HERE
	ZERO?	STACK /?CCL3
	IN?	TH-WELDING-ROD,TH-RED-CABLE \?CCL3
	FSET?	TH-ARC-WELDER,FL-ON \?CCL8
	GETP	TH-BLACK-CABLE,P?OWNER
	EQUAL?	STACK,LG-WALL \?CCL8
	REMOVE	TH-CRACK
	SET	'GL-BATTERY-LEAK,FALSE-VALUE
	SET	'GL-WATER-LEVEL,0
	ICALL2	RT-DEQUEUE,RT-I-BATTERY-LEAK
	FCLEAR	TH-PT-BILGE-BUTTON,FL-ON
	PRINTR	"	You hold the rod up to the crack. Sparks immediately start to fly from the tip of the rod and the end starts to glow. Soon, the softened metal begins to melt into the crack, and the stream of water gradually disappears."
?CCL8:	PRINTR	"	You hold the rod up next to the crack, but nothing happens."
?CCL3:	EQUAL?	PRSA,V?WELD \?CCL12
	PRINT	K-HOW-INTEND-MSG
	CRLF	
	RETURN	2
?CCL12:	PRINTR	"	You hold the rod up next to the crack, but nothing happens."


	.FUNCT	RT-TH-ARC-WELDER:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL5
	PRINTR	"	The arc welder is a sturdy black box with red and black cables coming out of it. The red cable looks like a jumper cable, except that the clamp at the end is wrapped with thick rubber insulation. The black cable ends in an suction cup that has an exposed electrode in the center. In addition, it has an on/off switch and a power cord."
?CCL5:	EQUAL?	PRSA,V?TURN-ON \?CCL7
	FSET?	TH-ARC-WELDER,FL-ON \?CCL10
	CALL2	RT-ALREADY-MSG,STR?130
	RSTACK	
?CCL10:	FSET?	TH-WELDER-CORD,FL-ON \?CCL12
	FSET	TH-ARC-WELDER,FL-ON
	PRINTR	"	The machine begins to hum."
?CCL12:	PRINTR	"	The welder isn't plugged in."
?CCL7:	EQUAL?	PRSA,V?TURN-OFF \?CCL14
	FSET?	TH-ARC-WELDER,FL-ON /?CCL17
	CALL2	RT-ALREADY-MSG,STR?131
	RSTACK	
?CCL17:	FCLEAR	TH-ARC-WELDER,FL-ON
	PRINTR	"	The machine stops humming."
?CCL14:	EQUAL?	PRSA,V?PLUG-IN \FALSE
	FSET?	TH-WELDER-CORD,FL-ON \?CCL22
	CALL2	RT-ALREADY-MSG,STR?132
	RSTACK	
?CCL22:	FSET	TH-WELDER-CORD,FL-ON
	PRINTR	"	You plug the power cord into the wall outlet."


	.FUNCT	RT-TH-WELDING-ROD:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"	It's a stiff metal rod, about 14 inches long."


	.FUNCT	RT-TH-RED-CABLE:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI /?CCL5
	EQUAL?	PRSA,V?PUT-IN,V?ATTACH,V?TAKE-WITH \FALSE
	EQUAL?	PRSO,TH-WELDING-ROD \FALSE
	MOVE	TH-WELDING-ROD,TH-RED-CABLE
	PRINTR	"	You put the welding rod into the clamp."
?CCL5:	EQUAL?	PRSA,V?EXAMINE \?CCL13
	PRINTR	"	The red cable looks like a jumper cable, ending in a large insulated clamp with sharp steel teeth."
?CCL13:	EQUAL?	PRSA,V?ATTACH \FALSE
	EQUAL?	PRSI,TH-WELDING-ROD \FALSE
	MOVE	TH-WELDING-ROD,TH-RED-CABLE
	PRINTR	"	You put the welding rod into the clamp."


	.FUNCT	RT-TH-BLACK-CABLE:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL7
	PRINTR	"	The black cable ends in an suction cup that has an exposed electrode in the center."
?CCL7:	EQUAL?	PRSA,V?ATTACH \FALSE
	PUTP	TH-BLACK-CABLE,P?OWNER,PRSI
	PRINTI	"	You put the suction cup on"
	ICALL	RT-PRINT-OBJ,PRSI,K-ART-THE
	PRINTR	", pressing hard to ensure a good contact for the electrode."


	.FUNCT	RT-TH-WELDER-SWITCH:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL5
	PRINTR	"	The power switch is labelled 'ON' and 'OFF'."
?CCL5:	EQUAL?	PRSA,V?TURN-OFF,V?TURN-ON \FALSE
	CALL1	RT-TH-ARC-WELDER
	RSTACK	


	.FUNCT	RT-TH-WELDER-CORD:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL5
	PRINTR	"	The power cord will plug into any wall outlet."
?CCL5:	EQUAL?	PRSA,V?PLUG-IN \FALSE
	FSET?	TH-WELDER-CORD,FL-ON \?CCL10
	CALL2	RT-ALREADY-MSG,STR?132
	RSTACK	
?CCL10:	FSET	TH-WELDER-CORD,FL-ON
	PRINTR	"	You plug the power cord into the wall outlet."


	.FUNCT	RT-RM-LADDER-D2:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the middle level of ladderwell D. A hatch in the forward bulkhead opens onto the pantry. There is a yellow button here, with a sign underneath it.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-TH-PT-BILGE-BUTTON:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?READ \?CCL5
	PRINTR	"It says, ""Port Bilge Pumps."""
?CCL5:	EQUAL?	PRSA,V?HIT,V?PUSH \FALSE
	PRINTI	"	You press the button and "
	FSET?	TH-PT-BILGE-BUTTON,FL-ON \?CCL10
	FCLEAR	TH-PT-BILGE-BUTTON,FL-ON
	PRINTR	"the whirring stops."
?CCL10:	GRTR?	GL-WATER-LEVEL,0 \?CCL12
	FSET	TH-PT-BILGE-BUTTON,FL-ON
	PRINTR	"hear a distant whirring."
?CCL12:	FCLEAR	TH-PT-BILGE-BUTTON,FL-ON
	PRINTR	"hear a distant whirring which stops soon after it starts. There must not be any water in the port bilge."


	.FUNCT	RT-TH-SB-BILGE-BUTTON:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?READ \?CCL5
	PRINTR	"It says, ""Starboard Bilge Pumps."""
?CCL5:	EQUAL?	PRSA,V?HIT,V?PUSH \FALSE
	PRINTR	"	You press the button and hear a distant whirring which stops soon after it starts. There must not be any water in the starboard bilge."


	.FUNCT	RT-I-CATFISH-TRAPPED:ANY:0:0
	PRINTR	"	The intercom buzzes. Then you hear a weak voice. ""This is Catfish. I'm trapped under a locker in Dive Gear Storage. The water in here is rising faster than the Johnstown flood. If one of y'all don't get down here pronto, I'm gonnna be singin' with the angels."""


	.FUNCT	RT-RM-DIVE-GEAR-STORAGE:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" a room that looks like the locker room at the local health club. The walls are lined with floor-to-ceiling lockers, one for each crew member. Your locker is the one next to the exit in the aft bulkhead.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-TH-BUD-GEAR-LOCKER:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-TH-BIG-LOCKER:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?PULL /?CTR4
	EQUAL?	PRSA,V?PUSH,V?LIFT,V?MOVE \?CCL5
?CTR4:	EQUAL?	PRSI,FALSE-VALUE,ROOMS,TH-HANDS \?CCL10
	PRINTR	"	You strain at the locker, but you just don't have enough leverage to move it."
?CCL10:	EQUAL?	PRSI,TH-BARBELL \FALSE
	FCLEAR	CH-CATFISH,FL-LOCKED
	ICALL2	RT-SET-PUPPY,CH-CATFISH
	PRINTR	"	Using the bar as a lever, you strain against the weight of the dive locker. Slowly, it inches up. Just when you realize that the bar is starting to slip from your grasp, Catfish manages to squirm free and roll out of the way. The locker crashes back to the floor. Catfish drags himself unsteadily to his feet and says, ""Thanks a lot, Chief. Nothing seems to be broken. Let's get the hell out of here."""
?CCL5:	EQUAL?	PRSA,V?OPEN \FALSE
	PRINTR	"	The doors are jammed shut."


	.FUNCT	RT-GN-LOCKER:ANY:2:2,TBL,FINDER,PTR,N
	ADD	TBL,8 >PTR
	GET	TBL,1 >N
	EQUAL?	HERE,RM-DIVE-GEAR-STORAGE \FALSE
	IN?	CH-CATFISH,RM-DIVE-GEAR-STORAGE \FALSE
	INTBL?	TH-BIG-LOCKER,PTR,N \FALSE
	PRINTI	"[the big locker]
"
	RETURN	TH-BIG-LOCKER


	.FUNCT	RT-LG-DGS-DOOR:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?OPEN \FALSE
	FSET?	LG-DGS-DOOR,FL-OPEN /FALSE
	FSET?	CH-CATFISH,FL-LOCKED \FALSE
	FSET	LG-DGS-DOOR,FL-OPEN
	FCLEAR	LG-FLOOD-DOOR,FL-OPEN
	SET	'OHERE,HERE
	SET	'HERE,RM-DIVE-GEAR-STORAGE
	MOVE	CH-PLAYER,RM-DIVE-GEAR-STORAGE
	PRINTR	"	You open the door to the cylinder. Inside is a jumbled chaos. Water is streaming down from the ceiling into an ever-rising pool on the floor. Catfish is sitting with his back to the wall, up to his chest in water. His legs are pinned by a huge locker that has fallen over on top of him, and he is turning blue from the cold.
	Water gushes out of the chamber when you open the door. It falls to the level below, triggering the automated flood control door that seals the starboard side of Deepcore off from the central core. The hydraulic hose stiffens and the door swings shut.
	You step into the chamber. The frigid water comes up to your knees. Catfish looks up at you and grins weakly. ""Howdy, pardner."""


	.FUNCT	RT-RM-RECREATION-ROOM:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"step into"
?CND4:	PRINTI	" the recreation and exercise room. Against the wall is a stationary bicycle. Next to it is a treadmill. In the middle of the room is a lift bench with a barbell resting on the stand. The only exit is to port.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-TH-BARBELL:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?LIFT,V?TAKE \FALSE
	IN?	TH-WEIGHTS,TH-BARBELL \FALSE
	PRINTR	"	The barbell is too heavy to lift."


	.FUNCT	RT-TH-WEIGHTS:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?TAKE,V?UNWEAR \FALSE
	IN?	TH-WEIGHTS,TH-BARBELL \FALSE
	MOVE	TH-WEIGHTS,HERE
	PRINTR	"	You remove the weights from the barbell and lay them on the floor."


	.FUNCT	RT-TH-LIFT-BENCH:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-TH-TREADMILL:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-TH-CYCLE:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-RM-LADDER-B2:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"enter"
?CND4:	PRINTI	" the middle level of ladderwell B. A corridor leads to the port side of Deepcore. A hatch in the starboard bulkhead opens onto the recreation room. Dive gear storage is forward, and aft is the entrance to your own living quarters.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTERED \?CCL8
	EQUAL?	GL-PUPPY,CH-CATFISH \FALSE
	LOC	TH-ARC-WELDER
	ZERO?	STACK \FALSE
	MOVE	TH-ARC-WELDER,CH-CATFISH
	MOVE	TH-WELDING-ROD,CH-CATFISH
	PRINTR	"	Catfish follows you out, holding up the arc-welder triumphantly. ""Dry as a bone, Boss. It was stowed on a shelf the water hadn't reached yet."""
?CCL8:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-TH-HYDRAULIC-HOSE:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?CUT \FALSE
	EQUAL?	PRSI,TH-KNIFE \FALSE
	FSET?	TH-HYDRAULIC-HOSE,FL-BROKEN \?CCL11
	CALL2	RT-ALREADY-MSG,STR?126
	RSTACK	
?CCL11:	FSET	TH-HYDRAULIC-HOSE,FL-BROKEN
	MOVE	TH-HYDRAULIC-FLUID,HERE
	PRINTR	"	You cut the hose with the knife. Red fluid pours out onto the floor."


	.FUNCT	RT-TH-HYDRAULIC-FLUID:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-LG-FLOOD-DOOR:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?OPEN \FALSE
	FSET?	LG-FLOOD-DOOR,FL-OPEN /FALSE
	FSET?	TH-HYDRAULIC-HOSE,FL-BROKEN /FALSE
	PRINTR	"	The door refuses to budge."


	.FUNCT	RT-TH-KNIFE:ANY:0:1,CONTEXT
	RFALSE	

	.ENDI
