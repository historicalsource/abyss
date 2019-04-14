;"***************************************************************************"
; "game : Abyss"
; "file : ABYSS.ZIL"
; "auth :   $Author:   RAB  $"
; "date :     $Date:   16 Mar 1989 17:36:40  $"
; "rev  : $Revision:   1.9  $"
; "vers : 1.0"
;"---------------------------------------------------------------------------"
; "Compile/Load file"
; "Copyright (C) 1988 Infocom, Inc.  All rights reserved."
;"***************************************************************************"
 
<SETG ZDEBUGGING? T>
<DEFINE DEBUG-CODE ('X "OPTIONAL" ('Y T))
	<COND
		(,ZDEBUGGING?
			.X
		)
		(ELSE
			.Y
		)
	>
>
 
<SETG NEW-PARSER? T>
<FREQUENT-WORDS?>
<LONG-WORDS?>
<ZIP-OPTIONS UNDO COLOR MOUSE>
<ORDER-OBJECTS? ROOMS-FIRST>
<NEVER-ZAP-TO-SOURCE-DIRECTORY?>
 
<VERSION YZIP>
 
<IFFLAG
	(IN-ZILCH
		<PRINC "Compiling">
	)
	(T
		<PRINC "Loading">
	)
>
 
<PRINC ": Abyss by Challenge, Inc.
">
 
ON!-INITIAL	"for DEBUGR"
OFF!-INITIAL
ENABLE!-INITIAL
DISABLE!-INITIAL
 
<SET REDEFINE T>
 
<COMPILATION-FLAG P-BE-VERB T>
 
;<SETG L-SEARCH-PATH (["~PARSER" ""] !,L-SEARCH-PATH)>
 
<INSERT-FILE "DEFS">
 
<XFLOAD ;"~PARSER/" "PARSER.REST">
 
<INSERT-FILE "MACROS">
<INSERT-FILE "MISC">
<INSERT-FILE "GAS-MIX">
<INSERT-FILE "SYNTAX">
<INSERT-FILE "VERBS">
<IF-P-BE-VERB!- <INSERT-FILE "BE">>
<INSERT-FILE "SUB-BAY">
<INSERT-FILE "COMMAND">
<INSERT-FILE "MONTANA">
<INSERT-FILE "RETURN1">
<INSERT-FILE "RETURN2">
<INSERT-FILE "OCEAN">
<INSERT-FILE "CRANE">
<INSERT-FILE "GLOBAL">
<INSERT-FILE "UTIL">
<INSERT-FILE "STOPPER">
<INSERT-FILE "ALIEN">
<INSERT-FILE "ENDGAME">
 
;"***************************************************************************"
; "end of file"
;"***************************************************************************"
 
