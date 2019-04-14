

	.FUNCT	RT-RM-UNDER-MOONPOOL:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTC	TAB
	PRINTI	"You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are"
	JUMP	?CND4
?CCL6:	PRINTI	"arrive"
?CND4:	PRINTI	" under the moonpool.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-OCEAN-NORTH:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTC	TAB
	PRINTI	"You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are on"
	JUMP	?CND4
?CCL6:	PRINTI	"proceed along"
?CND4:	PRINTI	" the ocean floor. Deepcore is to the south.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-OCEAN-SOUTH:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTC	TAB
	PRINTI	"You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are on"
	JUMP	?CND4
?CCL6:	PRINTI	"proceed along"
?CND4:	PRINTI	" the ocean floor. Deepcore is to the north.
"
	RFALSE	
?CCL3:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RM-OCEAN-WEST:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTC	TAB
	PRINTI	"You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are on"
	JUMP	?CND4
?CCL6:	PRINTI	"proceed along"
?CND4:	PRINTI	" the ocean floor. Looking east, you see Deepcore, an island of light in the vast blackness. The crane, now only a mass of twisted metal, hangs crookedly off the starboard cylinders.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-BEG \?CCL8
	EQUAL?	PRSA,V?WALK-TO \FALSE
	EQUAL?	PRSO,LG-MONTANA \FALSE
	CALL2	RT-DO-WALK,P?WEST
	RSTACK	
?CCL8:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-SWIM-TO-FROM-TRENCH:ANY:0:1,QUIET,N
	ZERO?	QUIET \?CND1
	PRINTC	TAB
	PRINTI	"You swim along the ocean floor, pausing every few moments to take your bearings and consult your compass.
"
	ADD	GL-MOVES,43 >GL-MOVES
	ICALL1	CLOCKER
?CND1:	EQUAL?	HERE,RM-OCEAN-WEST /?CTR4
	RETURN	RM-OCEAN-WEST
?CTR4:	RETURN	RM-TROUGH-LIP


	.FUNCT	RT-RM-TROUGH-LIP:ANY:0:1,CONTEXT,N
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTC	TAB
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"You are at"
	JUMP	?CND4
?CCL6:	EQUAL?	OHERE,RM-OCEAN-WEST \?CCL8
	PRINTI	"Eventually, you come to the jagged edge of a chasm that extends to the north and south. Looking down, you see the murky outline of the Montana, perched on a ledge below you.
"
	RFALSE	
?CCL8:	PRINTI	"You come to"
?CND4:	PRINTI	" the lip of the Cayman trough. Just below, you can see the Montana. Deepcore lies east of here.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTERED \?CCL10
	EQUAL?	OHERE,RM-OCEAN-WEST \FALSE
	PRINTC	TAB
	PRINTI	"Automatically, you glance at your watch. The journey over from Deepcore took about twenty two minutes and you have"
	SUB	GL-PLAYER-TEMP,K-TEMP-LOW-4
	DIV	STACK,20 >N
	ICALL2	RT-WORD-NUMBERS,N
	PRINTI	" minute"
	EQUAL?	N,1 /?CND14
	PRINTC	115
?CND14:	PRINTI	" left before hypothermia sets in. A quick calculation reveals that you have "
	SUB	N,22 >N
	LESS?	N,0 \?CCL18
	PRINTI	"insufficient time to make it back to Deepcore.
"
	RTRUE	
?CCL18:	ZERO?	N \?CCL21
	PRINTI	"no time"
	JUMP	?CND19
?CCL21:	PRINTI	"only"
	ICALL2	RT-WORD-NUMBERS,N
	PRINTI	" minute"
	EQUAL?	N,1 /?CND19
	PRINTC	115
?CND19:	PRINTI	" to explore the Montana before you must start back.
"
	RTRUE	
?CCL10:	EQUAL?	CONTEXT,M-BEG \?CCL25
	EQUAL?	PRSA,V?WALK-TO \FALSE
	EQUAL?	PRSO,LG-DEEPCORE \FALSE
	CALL2	RT-DO-WALK,P?EAST
	RSTACK	
?CCL25:	ZERO?	CONTEXT \FALSE
	RFALSE	

	.ENDI
