

	.FUNCT	RT-RM-TRENCH-BOTTOM:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"arrive at"
?CND4:	PRINTI	" the bottom of the trench. You are next to a huge alien ship that will be much more vividly described in later versions of this game. Once we hook up the graphics, on the side of the ship you will see a picture of a panel with a series of dots on it. For now, let's just say there's a purple button that you have to push in order to get inside the ship.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-TH-PURPLE-BUTTON:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL5
	PRINTR	"	Pretty normal-looking button, considering it's purple."
?CCL5:	EQUAL?	PRSA,V?PUSH \FALSE
	MOVE	CH-PLAYER,RM-ALIEN-CHAMBER
	PRINTR	"	The door swings open and you enter the Alien ship. You walk down a long, luminescent corridor and eventually come to a large room. Lindsey is sitting in the middle of the floor, her tear-stained face looking up at some large TV screens on the wall. You walk toward her. She silently stretches out her hand to take yours, and then motions you to look at the screens. You do so and quickly realize why she's been crying.
	Up on the screen you see pictures of incredible destruction. Major cities all over the world are being inundated by water. In some places, the flooding is complete. In others it has just begun. But all over the planet, water is rising up to wipe out humanity in the flood that Noah was promised would never come.
	One of the Alien creatures materializes at your side and explains why they are doing what they are doing. He bears a strong resemblance to Don Rubin. ""Soon there will be a puzzle here,"" he says. ""Otherwise, Bob will write it when he gets back from vacation. Until that time, simply push the fuschia button over there on the wall. Doing so will save the world and return you to Deepcore. Not a bad deal, if you ask me."""


	.FUNCT	RT-RM-ALIEN-CHAMBER:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"	You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are in"
	JUMP	?CND4
?CCL6:	PRINTI	"arrive at"
?CND4:	PRINTI	" the alien chamber. There is a fuschia button on the wall.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-TH-FUSCHIA-BUTTON:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL5
	PRINTR	"	Pretty normal-looking button, considering it's fuschia."
?CCL5:	EQUAL?	PRSA,V?PUSH \FALSE
	MOVE	CH-PLAYER,RM-SUB-BAY
	MOVE	CH-LINDSEY,RM-SUB-BAY
	FSET	CH-ALIEN,FL-BROKEN
	PRINTR	"	A flash of lighting. A clap of thunder. And suddenly you and Lindsey are back in the Sub-bay."

	.ENDI
