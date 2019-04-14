

	.FUNCT	RT-TH-WINDOW-BENCH:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?OPEN,V?LIFT \FALSE
	FSET	TH-WINDOW-BENCH,FL-OPEN
	PRINTR	"	You lift the seat to reveal the red lever underneath."


	.FUNCT	RT-TH-RED-LEVER:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?PULL \?CCL5
	FSET?	LG-CHAMBER-DOOR,FL-OPEN /?CCL8
	FSET?	CH-ALIEN,FL-BROKEN \?CCL8
	PRINTI	"	You pull the lever and feel an immediate jolt as the compression chamber pulls away from Deepcore. Through the porthole, you get a glimpse of the crippled Deepcore as you slowly rise through the water.

  	[GRAPHIC #22]

  	For a long time after that you have no sensation of motion, but then the water through the porthole starts to get lighter as you near the surface.
	Suddenly chamber burst through the surface and sunlight floods through the porthole. You feel the motion of the waves for the first time in weeks as the chamber gently rises and falls. Through the porthole you see the Benthic Explorer steaming towards you.
	Trumpets sound. Fair young maidens cluster round to look at you admiringly. You have won the game."
	CRLF	
	CALL2	RT-END-OF-GAME,TRUE-VALUE
	RSTACK	
?CCL8:	PRINTR	"	Nothing happens."
?CCL5:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"It looks an awful lot like a red lever."

	.ENDI
