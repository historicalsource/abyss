

	.FUNCT	RT-TH-CATFISH-LOCKER:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-TH-STEEL-BOX:ANY:0:1,CONTEXT
	RFALSE	


	.FUNCT	RT-TH-CLUE-PAPER:ANY:0:1,CONTEXT
	EQUAL?	PRSA,V?READ \FALSE
	PRINTR	"On the paper are written the words, ""IN HER DRY BED."""


	.FUNCT	RT-TH-STEEL-KEY:ANY:0:1,CONTEXT,V
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?TAKE \FALSE
	GETP	TH-STEEL-KEY,P?OWNER
	EQUAL?	STACK,TH-DRYER \FALSE
	CALL1	ITAKE >V
	EQUAL?	V,M-FATAL \?CCL11
	RETURN	2
?CCL11:	ZERO?	V /FALSE
	PUTP	TH-STEEL-KEY,P?OWNER,FALSE-VALUE
	PRINTR	"	You peel the key off the back of the dryer."


	.FUNCT	RT-TH-DRYER:ANY:0:1,CONTEXT
	EQUAL?	PRSA,V?REACH-BEHIND,V?LOOK-BEHIND \FALSE
	GETP	TH-STEEL-KEY,P?OWNER
	EQUAL?	STACK,TH-DRYER \FALSE
	MOVE	TH-STEEL-KEY,RM-LAUNDRY
	ICALL2	THIS-IS-IT,TH-STEEL-KEY
	PRINTR	"	Taped to the back of the dryer is a small steel key."


	.FUNCT	RT-TH-PASSPORT:ANY:0:1,CONTEXT
	EQUAL?	PRSA,V?SHOW \FALSE
	EQUAL?	PRSI,CH-COFFEY \FALSE
	FSET?	CH-CATFISH,FL-ASLEEP \FALSE
	PRINTR	"	Coffey glances at the passport and shrugs with contempt. ""Big deal. These things are a dime a dozen. Any spy would have one."""


	.FUNCT	RT-TH-DISCHARGE:ANY:0:1,CONTEXT
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTR	"	It's an honorable discharge from the United States Marine Corps."
?CCL3:	EQUAL?	PRSA,V?SHOW \FALSE
	EQUAL?	PRSI,CH-COFFEY \FALSE
	FSET?	CH-CATFISH,FL-ASLEEP \FALSE
	FCLEAR	CH-CATFISH,FL-ASLEEP
	PRINTR	"	Coffey peers at the document carefully. ""This thing's an original, and I know the forms are kept locked up tighter than Fort Knox. It's even signed by Commander McMahon himself. I suppose it could have been forged, but I guess I was wrong all along.""
	He turns Catfish over and slaps him on the face a couple of times to bring him around. When Catfish has regained a semblence of consciousness, Coffey says, ""I'm sorry, fella. I guess I got carried away.""
	Catfish drags himself to his feet and says groggily, ""Don't mention it. Maybe I can do the same for you some day."""

	.ENDI
