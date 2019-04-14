;"***************************************************************************"
; "game : Abyss"
; "file : DEFS2.ZIL"
; "auth :   $Author:   DEB  $"
; "date :     $Date:   16 Dec 1988  3:02:42  $"
; "rev  : $Revision:   1.1  $"
; "vers : 1.0"
;"---------------------------------------------------------------------------"
; "Default substitutions after PDEFS"
; "Copyright (C) 1988 Infocom, Inc.  All rights reserved."
;"***************************************************************************"
 
<INCLUDE "PDEFS" "BASEDEFS" "PBITDEFS">
 
<USE "PMEM">
 
<CONSTANT SEARCH-ADJACENT <ORB ,SEARCH-MUST-HAVE ,SEARCH-MOBY>>
 
<REPLACE-DEFINITION PSEUDO-OBJECTS
	<PUTPROP THINGS PROPSPEC HACK-PSEUDOS>
 
	<DEFINE20 HACK-PSEUDOS (LIST "AUX" (N 0) (CT 0) NL)
		<SET LIST <REST .LIST>>
		<SET LIST
			<MAPF
				,LIST
				<FUNCTION (X)
					<COND
						(<0? .N>
							<SET CT <+ .CT 1>>
							<SET N 1>
							<COND
								(<TYPE? .X ATOM>
									<TABLE (PURE PATTERN (BYTE [REST WORD]))
										1
										<VOC <SPNAME .X> ADJ>
									>
								)
								(<TYPE? .X LIST>
									<EVAL
										<CHTYPE
											(TABLE (PURE PATTERN (BYTE [REST WORD]))
												<LENGTH .X>
												!<MAPF ,LIST
													<FUNCTION (Y)
														<VOC <SPNAME .Y> ADJ>
													>
													.X
												>
											)
											FORM
										>
									>
								)
								(T
									0
								)
							>
						)
						(<1? .N>
							<SET N 2>
							<COND
								(<TYPE? .X ATOM>
									<TABLE (PURE PATTERN (BYTE [REST WORD]))
										1
										<VOC <SPNAME .X> NOUN>
									>
								)
								(<TYPE? .X LIST>
									<EVAL
										<CHTYPE
											(TABLE (PURE PATTERN (BYTE [REST WORD]))
												<LENGTH .X>
												!<MAPF ,LIST
													<FUNCTION (Y)
														<VOC <SPNAME .Y> NOUN>
													>
													.X
												>
											)
											FORM
										>
									>
								)
								(T
									0
								)
							>
						)
						(T
							<SET N 0>
							.X
						)
					>
				>
				.LIST
			>
		>
		(<>
			<EVAL
				<CHTYPE
					(TABLE (PURE PATTERN (BYTE [REST WORD]))
						.CT
						!.LIST
					)
					FORM
				>
			>
		)
	>
 
	<GLOBAL LAST-PSEUDO-LOC:OBJECT <>>
 
	<COND
		(<CHECK-VERSION? ZIP>
			<OBJECT PSEUDO-OBJECT
				(LOC LOCAL-GLOBALS)
				(DESC "pseudo")
				(ACTION 0)
			>
		)
		(T
			<OBJECT PSEUDO-OBJECT
				(LOC LOCAL-GLOBALS)
				(FLAGS FL-HAS-DESCFCN FL-HAS-SDESC FL-NO-ARTICLE)
				(ACTION 0)
			>
		)
	>
 
	<DEFINE TEST-THINGS (RM F "AUX" CT GLBS N)
		<SET GLBS <GETP .RM ,P?THINGS>>
		<SET N <GETB .GLBS 0>>
		<SET GLBS <REST .GLBS>>
 
		;"? maybe use theory from B'cy?"
		<COND
			(<T? <SET CT <FIND-ADJS .F>>>
				<SET CT <ADJS-COUNT .CT>>
			)
		>
		<REPEAT
			(	(NOUN <FIND-NOUN .F>)
				(V <REST-TO-SLOT <FIND-ADJS .F> ADJS-COUNT 1>)
				TTBL
				(MATCH <>)
			)
		;------------
			<COND
				(<AND <SET TTBL <GET .GLBS 1>>
						<INTBL? .NOUN <ZREST .TTBL 1> <GETB .TTBL 0>>
					>
					<COND
						(<ZERO? .CT>
							<SET MATCH T>
						)
						(<SET TTBL <ZGET .GLBS 0>>
							<REPEAT ((I 0))
								<COND
									(<INTBL? <ZGET .V .I> <ZREST .TTBL 1> <GETB .TTBL 0>>
										<SET MATCH T>
										<RETURN>
									)
									(<IGRTR? .I <- .CT 1>>
										<RETURN>
									)
								>
							>
						)
					>
					<COND
						(.MATCH
							<SETG LAST-PSEUDO-LOC .RM>
							<PUTP ,PSEUDO-OBJECT ,P?ACTION <ZGET .GLBS 2>>
							<ADD-OBJECT ,PSEUDO-OBJECT .F>
							<RFALSE>
						)
					>
				)
			>
			<SET GLBS <REST .GLBS 6>>
			<COND
				(<DLESS? .N 1>
					<RFALSE>
				)
			>
		>
	>
>
 
<REPLACE-DEFINITION WHICH-PRINT
	<DEFINE WHICH-PRINT
		(NP "AUX"
			(SR ,ORPHAN-SR)
			(LEN <FIND-RES-COUNT .SR>)
			(SZ <FIND-RES-SIZE .SR>)
			(NS 0)
		)
		<COND
			(<WHICH-LIST? .NP .SR>
				; "Count the number of objects to print (only FL-SEEN)"
				<SET NS 0>
				<REPEAT ((N .LEN) (S .SZ) (VEC <REST-TO-SLOT .SR FIND-RES-OBJ1>))
					<COND
						(<DLESS? N 0>
							<RETURN>
						)
						(<DLESS? S 0>
							<RETURN>
						)
					>
					<COND
						(<FSET? <ZGET .VEC 0> ,FL-SEEN>
							<INC NS>
						)
					>
					<SET VEC <ZREST .VEC 2>>
				>
			)
		>
		<COND
			(<NOT <EQUAL? ,WINNER ,CH-PLAYER>>
				<TELL "[You must specify ">
				<COND
					(<AND <WHICH-LIST? .NP .SR>
							<G? .NS 1>
						>
						<TELL "if">
					)
					(T
						<TELL "which">
						<COND
							(<T? .NP>
							;	<SETG P-ONE-NOUN <NP-NAME .NP>>
								<TELL !\ >
								<NP-PRINT .NP>
							)
						>
					)
				>
			)
			(T
				<TELL "[Which">
				<COND
					(<T? .NP>
					;	<SETG P-ONE-NOUN <NP-NAME .NP>>
						<TELL !\ >
						<NP-PRINT .NP>
					)
				>
				<TELL " do">
			)
		>
		<TELL " you mean">
		<COND
			(<AND <WHICH-LIST? .NP .SR>
					<G? .NS 1>
				>
				<COND
					(<==? ,WINNER ,CH-PLAYER>
						<TELL !\,>
					)
				>
				<REPEAT ((N .LEN) (S .SZ) (VEC <REST-TO-SLOT .SR FIND-RES-OBJ1>) (REM .NS) OBJ)
					<COND
						(<DLESS? N 0>
							<RETURN>
						)
						(<DLESS? S 0>
							<RETURN>
						)
					>
					<COND
						(<FSET? <SET OBJ <ZGET .VEC 0>> ,FL-SEEN>
							<TELL the .OBJ>
							<DEC REM>
							<COND
								(<==? .REM 1>
									<COND
										(<NOT <==? .NS 2>>
											<TELL !\,>
										)
									>
									<TELL " or">
								)
								(<G? .REM 1>
									<TELL !\,>
								)
							>
						)
					>
					<SET VEC <ZREST .VEC 2>>
				>
			)
		>
		<COND
			(<==? ,WINNER ,CH-PLAYER>
				<TELL "?]" CR>
			)
			(T
				<TELL ".]" CR>
			)
		>
	>
>
 
<REPLACE-DEFINITION CANT-FIND-OBJECT
	<DEFINE CANT-FIND-OBJECT (NP SEARCH "AUX" OTHER)
		<COND
			(<EQUAL? .NP ,ORPHAN-NP>
				<NP-CANT-SEE .NP>
			)
			(T
				<TELL "[There isn't anything to ">
				<COND
					(<SET OTHER <PARSE-VERB ,PARSE-RESULT>>
						<PRINT-VOCAB-WORD .OTHER>
					)
					(T
						<TELL "do that to">
					)
				>
				<TELL ".]" CR>
			)
		>
	>
	<DEFINE NP-CANT-SEE ("OPT" (NP <GET-NP>) "AUX" OTHER)
		<COND
			(<OR	<SET OTHER <NP-NAME .NP>>
					<NP-QUANT .NP>	;"for PUT ALL IN CRATE BUT CANDLE"
				>
				<TELL !\[ The ,WINNER " can't see ">
				<COND
					(.OTHER
						<TELL "any ">
						<NP-PRINT .NP>
					)
					(T
						<NP-PRINT .NP T>
					)
				>
				<TELL !\ >
				<COND
					(<AND <SET OTHER <NP-LOC .NP>>
							<OR
								<PMEM-TYPE? .OTHER NOUN-PHRASE>
								<AND
									<PMEM-TYPE? .OTHER LOCATION>
									<SET OTHER <LOCATION-OBJECT .OTHER>>
								>
							>
						>
						<TELL "in" the <NOUN-PHRASE-OBJ1 .OTHER>>
					)
					(T
						<COND
						;	(<ZAPPLY ,MOBY-FIND? .SEARCH>
								<TELL "anyw">
							)
							(T
								<TELL "right ">
							)
						>
						<TELL "here">
					)
				>
				<TELL ".]" CR>
			)
			(T
				<MORE-SPECIFIC>
			)
		>
	>
>
 
<REPLACE-DEFINITION TELL-GWIM-MSG
	<DEFINE TELL-GWIM-MSG ("AUX" WD VB OBJ)
		<SET OBJ <ZGET ,GWIM-MSG 1>>
		<COND
			(<NOT <EQUAL? .OBJ ,TH-HANDS ;,TH-MOUTH>>
				<TELL !\[>
				<COND
					(<SET WD <ZGET ,GWIM-MSG 0>>
						<PRINT-VOCAB-WORD .WD>
						<SET VB <PARSE-VERB ,PARSER-RESULT>>
						<COND
							(<EQUAL? .VB ,W?SIT ,W?LIE>
								<COND
									(<EQUAL? .WD ,W?DOWN>
										<TELL " on">
									)
								>
							)
							(<EQUAL? .VB ,W?GET>
								<COND
									(<EQUAL? .WD ,W?OUT>
										<TELL " of">
									)
								>
							)
						>
					)
				>
				<TELL the <ZGET ,GWIM-MSG 1> !\] CR>
			)
		>
	>
>
 
;"***************************************************************************"
; "end of file"
;"***************************************************************************"
 
