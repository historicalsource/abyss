;"***************************************************************************"
; "game : Abyss"
; "file : RETURN1.ZIL"
; "auth :   $Author:   DEB  $"
; "date :     $Date:   20 Mar 1989  8:45:16  $"
; "rev  : $Revision:   1.3  $"
; "vers : 1.0"
;"---------------------------------------------------------------------------"
; "First return to Deepcore"
; "Copyright (C) 1988 Infocom, Inc.  All rights reserved."
;"***************************************************************************"
 
<GLOBAL GL-RETURN1-DONE? <> <> BYTE>
 
<OBJECT TH-CATFISH-LOCKER
	(LOC RM-PERSONAL-STORAGE-2)
	(DESC "locker")
	(FLAGS FL-SEARCH FL-TAKEABLE FL-CONTAINER FL-OPENABLE)
	(SYNONYM LOCKER)
	(ADJECTIVE CATFISH)
	(SIZE 5)
	(ACTION RT-TH-CATFISH-LOCKER)
>
 
<ROUTINE RT-TH-CATFISH-LOCKER ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
<OBJECT TH-STEEL-BOX
	(LOC TH-CATFISH-LOCKER)
	(DESC "box")
	(FLAGS FL-SEARCH FL-TAKEABLE FL-CONTAINER FL-OPENABLE FL-LOCKED)
	(SYNONYM BOX)
	(ADJECTIVE STEEL CATFISH)
	(SIZE 5)
	(ACTION RT-TH-STEEL-BOX)
>
 
<ROUTINE RT-TH-STEEL-BOX ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
<OBJECT TH-CLUE-PAPER
	(LOC TH-CATFISH-LOCKER ;TH-STEEL-BOX)
	(DESC "paper")
	(FLAGS FL-TAKEABLE FL-READABLE)
	(SYNONYM PAPER)
	(SIZE 5)
	(ACTION RT-TH-CLUE-PAPER)
>
 
<ROUTINE RT-TH-CLUE-PAPER ("OPT" (CONTEXT <>))
	<COND
		(<VERB? READ>
			<TELL "On the paper are written the words, \"IN HER DRY BED.\"" CR>
		)
	>
>
 
<OBJECT TH-STEEL-KEY
	(DESC "steel key")
	(FLAGS FL-KEY FL-SEARCH FL-TAKEABLE)
	(SYNONYM KEY)
	(ADJECTIVE STEEL)
	(OWNER TH-DRYER)
	(SIZE 5)
	(ACTION RT-TH-STEEL-KEY)
>
 
<ROUTINE RT-TH-STEEL-KEY ("OPT" (CONTEXT <>) "AUX" V)
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? TAKE>
			<COND
				(<EQUAL? <GETP ,TH-STEEL-KEY ,P?OWNER> ,TH-DRYER>
					<SET V <ITAKE>>
					<COND
						(<EQUAL? .V ,M-FATAL>
							<RFATAL>
						)
						(.V
							<PUTP ,TH-STEEL-KEY ,P?OWNER <>>
							<TELL "	You peel the key off the back of the dryer." CR>
						)
					>
				)
			>
		)
	>
>
 
<OBJECT TH-DRYER
	(LOC RM-LAUNDRY)
	(DESC "dryer")
	(FLAGS FL-CONTAINER FL-OPENABLE FL-SEARCH FL-TAKEABLE)
	(SYNONYM DRYER)
	(SIZE 5)
	(ACTION RT-TH-DRYER)
>
 
<ROUTINE RT-TH-DRYER ("OPT" (CONTEXT <>))
	<COND
		(<VERB? LOOK-BEHIND REACH-BEHIND>
			<COND
				(<EQUAL? <GETP ,TH-STEEL-KEY ,P?OWNER> ,TH-DRYER>
				;	<FCLEAR ,TH-STEEL-KEY ,FL-INVISIBLE>
					<MOVE ,TH-STEEL-KEY ,RM-LAUNDRY>
					<THIS-IS-IT ,TH-STEEL-KEY>
					<TELL "	Taped to the back of the dryer is a small steel key." CR>
				)
			>
		)
	>
>
 
<OBJECT TH-PASSPORT
	(LOC TH-STEEL-BOX)
	(DESC "passport")
	(FLAGS FL-SEARCH FL-TAKEABLE)
	(SYNONYM PASSPORT)
	(ADJECTIVE CATFISH)
	(SIZE 5)
	(ACTION RT-TH-PASSPORT)
>
 
<ROUTINE RT-TH-PASSPORT ("OPT" (CONTEXT <>))
	<COND
		(<AND <VERB? SHOW>
				<MC-PRSI? ,CH-COFFEY>
				<FSET? ,CH-CATFISH ,FL-ASLEEP>
			>
			<TELL
"	Coffey glances at the passport and shrugs with contempt. \"Big deal.
These things are a dime a dozen. Any spy would have one.\"" CR
			>
		)
	>
>
 
<OBJECT TH-DISCHARGE
	(LOC TH-STEEL-BOX)
	(DESC "discharge")
	(FLAGS FL-SEARCH FL-TAKEABLE)
	(SYNONYM DISCHARGE)
	(ADJECTIVE CATFISH MILITARY MARINE MARINES HONORABLE PAPERS)
	(OWNER CH-CATFISH)
	(SIZE 5)
	(ACTION RT-TH-DISCHARGE)
>
 
<ROUTINE RT-TH-DISCHARGE ("OPT" (CONTEXT <>))
	<COND
		(<VERB? EXAMINE>
			<TELL
"	It's an honorable discharge from the United States Marine Corps." CR
			>
		)
		(<AND <VERB? SHOW>
				<MC-PRSI? ,CH-COFFEY>
				<FSET? ,CH-CATFISH ,FL-ASLEEP>
			>
			<FCLEAR ,CH-CATFISH ,FL-ASLEEP>
			<TELL
"	Coffey peers at the document carefully. \"This thing's an original, and
I know the forms are kept locked up tighter than Fort Knox. It's even
signed by Commander McMahon himself. I suppose it could have been
forged, but I guess I was wrong all along.\"|
	He turns Catfish over and slaps him on the face a couple of times to
bring him around. When Catfish has regained a semblence of consciousness,
Coffey says, \"I'm sorry, fella. I guess I got carried away.\"|
	Catfish drags himself to his feet and says groggily, \"Don't mention it.
Maybe I can do the same for you some day.\"" CR
			>
		)
	>
>
 
;"***************************************************************************"
; "end of file"
;"***************************************************************************"
 
