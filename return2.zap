

	.FUNCT	RT-TH-GUN:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-TH-FBS-SUIT:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-TH-DIVE-LOCKER:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?LIFT,V?PULL /?CCL5
	EQUAL?	PRSA,V?PUSH,V?MOVE,V?TAKE \FALSE
?CCL5:	PRINTR	"	The dive locker is securely anchored to the floor."


	.FUNCT	RT-TH-ELECTRONIC-LOCK:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-TH-DEVICE:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	V-$NITROGEN:ANY:0:0
	EQUAL?	HERE,RM-GAS-MIX-ROOM \?CCL3
	FSET?	LG-CHAMBER-DOOR,FL-OPEN \?CCL6
	PRINTI	"[The compression chamber door must be closed.]
"
	RETURN	2
?CCL6:	ZERO?	GL-WIRE-SEQUENCE \?CND9
	RANDOM	4 >GL-WIRE-SEQUENCE
?CND9:	PRINTI	"	Coffey begins to babble incoherently. You can hear him say, """
	EQUAL?	GL-WIRE-SEQUENCE,1 \?CCL13
	PRINTR	"Oxford rows great big wide yachts."""
?CCL13:	EQUAL?	GL-WIRE-SEQUENCE,2 \?CCL15
	PRINTR	"Yankees rarely win over Green Bay."""
?CCL15:	EQUAL?	GL-WIRE-SEQUENCE,3 \?CCL17
	PRINTR	"Get rid of your wet bananas."""
?CCL17:	EQUAL?	GL-WIRE-SEQUENCE,4 \FALSE
	PRINTR	"Go west, young boy, or rot."""
?CCL3:	PRINTI	"[You must be in the gas mix room to use $NITROGEN.]
"
	RETURN	2

	.ENDI
