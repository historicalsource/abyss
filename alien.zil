;"***************************************************************************"
; "game : Abyss"
; "file : ALIEN.ZIL"
; "auth :   $Author:   DEB  $"
; "date :     $Date:   18 Mar 1989 14:02:54  $"
; "rev  : $Revision:   1.2  $"
; "vers : 1.0"
;"---------------------------------------------------------------------------"
; "Crane crash"
; "Copyright (C) 1988 Infocom, Inc.  All rights reserved."
;"***************************************************************************"
 
;"---------------------------------------------------------------------------"
; "RM-TRENCH-BOTTOM"
;"---------------------------------------------------------------------------"
 
<ROOM RM-TRENCH-BOTTOM
	(LOC ROOMS)
	(DESC "bottom of trench")
	(FLAGS FL-WATER FL-LIGHTED)
	(SYNONYM TRENCH BOTTOM)
	(ADJECTIVE FOOT TRENCH)
	(IN TO RM-ALIEN-CHAMBER)
	(UP TO RM-MIDSHIP-HATCH)
	(ACTION RT-RM-TRENCH-BOTTOM)
>
 
<ROUTINE RT-RM-TRENCH-BOTTOM ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL "	You ">
			<COND
				(<MC-CONTEXT? ,M-LOOK>
					<TELL "are in">
				)
				(T
					<TELL "arrive at">
				)
			>
			<TELL
" the bottom of the trench. You are next to a huge alien ship that will be
much more vividly described in later versions of this game. Once we hook up
the graphics, on the side of the ship you will see a picture of a panel with
a series of dots on it. For now, let's just say there's a purple button that
you have to push in order to get inside the ship.|"
			>
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
 
;"---------------------------------------------------------------------------"
; "TH-PURPLE-BUTTON"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-PURPLE-BUTTON
	(LOC TH-ALIEN-SHIP)
	(DESC "purple button")
	(FLAGS FL-NO-DESC)
	(SYNONYM BUTTON)
	(ADJECTIVE PURPLE)
	(ACTION RT-TH-PURPLE-BUTTON)
>
 
<ROUTINE RT-TH-PURPLE-BUTTON ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE>
			<TELL "	Pretty normal-looking button, considering it's purple." CR>
		)
		(<VERB? PUSH>
			<MOVE ,CH-PLAYER ,RM-ALIEN-CHAMBER>
			<TELL
"	The door swings open and you enter the Alien ship. You walk down a long,
luminescent corridor and eventually come to a large room. Lindsey is sitting
in the middle of the floor, her tear-stained face looking up at some large TV
screens on the wall. You walk toward her. She silently stretches out her hand
to take yours, and then motions you to look at the screens. You do so and
quickly realize why she's been crying.|
	Up on the screen you see pictures of incredible destruction. Major cities
all over the world are being inundated by water. In some places, the flooding
is complete. In others it has just begun. But all over the planet, water is
rising up to wipe out humanity in the flood that Noah was promised would
never come.|
	One of the Alien creatures materializes at your side and explains why they
are doing what they are doing. He bears a strong resemblance to Don Rubin.
\"Soon there will be a puzzle here,\" he says. \"Otherwise, Bob will write it
when he gets back from vacation. Until that time, simply push the fuschia
button over there on the wall. Doing so will save the world and return you to
Deepcore. Not a bad deal, if you ask me.\"" CR
			>
		)
	>
>
 
<OBJECT TH-ALIEN-SHIP
	(LOC RM-TRENCH-BOTTOM)
	(DESC "alien ship")
	(FLAGS FL-SEARCH FL-SURFACE)
	(SYNONYM SHIP)
	(ADJECTIVE ALIEN)
>
 
;"---------------------------------------------------------------------------"
; "RM-ALIEN-CHAMBER"
;"---------------------------------------------------------------------------"
 
<ROOM RM-ALIEN-CHAMBER
	(LOC ROOMS)
	(DESC "alien chamber")
	(FLAGS FL-WATER FL-INSIDE FL-LIGHTED)
	(SYNONYM CHAMBER)
	(ADJECTIVE ALIEN)
	(ACTION RT-RM-ALIEN-CHAMBER)
>
 
<ROUTINE RT-RM-ALIEN-CHAMBER ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL "	You ">
			<COND
				(<MC-CONTEXT? ,M-LOOK>
					<TELL "are in">
				)
				(T
					<TELL "arrive at">
				)
			>
			<TELL " the alien chamber. There is a fuschia button on the wall.|">
			<RFALSE>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "TH-FUSCHIA-BUTTON"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-FUSCHIA-BUTTON
	(LOC RM-ALIEN-CHAMBER)
	(DESC "fuschia button")
	(FLAGS FL-NO-DESC)
	(SYNONYM BUTTON)
	(ADJECTIVE FUSCHIA)
	(ACTION RT-TH-FUSCHIA-BUTTON)
>
 
<ROUTINE RT-TH-FUSCHIA-BUTTON ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE>
			<TELL "	Pretty normal-looking button, considering it's fuschia." CR>
		)
		(<VERB? PUSH>
			<MOVE ,CH-PLAYER ,RM-SUB-BAY>
			<MOVE ,CH-LINDSEY ,RM-SUB-BAY>
			<FSET ,CH-ALIEN ,FL-BROKEN>
			<TELL
"	A flash of lighting. A clap of thunder. And suddenly you and Lindsey are
back in the Sub-bay." CR
			>
		)
	>
>
 
<OBJECT CH-ALIEN
	(LOC RM-ALIEN-CHAMBER)
	(DESC "alien")
	(FLAGS FL-ALIVE FL-OPEN FL-PERSON FL-SEARCH)
	(SYNONYM ALIEN)
>
 
;"***************************************************************************"
; "end of file"
;"***************************************************************************"
 
