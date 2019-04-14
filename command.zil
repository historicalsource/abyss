;"***************************************************************************"
; "game : Abyss"
; "file : COMMAND.ZIL"
; "auth :   $Author:   DEB  $"
; "date :     $Date:   20 Mar 1989  8:43:42  $"
; "rev  : $Revision:   1.9  $"
; "vers : 1.0"
;"---------------------------------------------------------------------------"
; "Miscellaneous"
; "Copyright (C) 1988 Infocom, Inc.  All rights reserved."
;"***************************************************************************"
 
;"---------------------------------------------------------------------------"
; "RM-COMMAND-MODULE"
;"---------------------------------------------------------------------------"
 
<ROOM RM-COMMAND-MODULE
	(LOC ROOMS)
	(DESC "command module")
	(FLAGS FL-INDOORS FL-LIGHTED)
	(SYNONYM MODULE)
	(ADJECTIVE COMMAND)
	(AFT TO RM-CORRIDOR)
	(GLOBAL LG-WALL RM-CORRIDOR)
	(ACTION RT-RM-COMMAND-MODULE)
>
 
<ROUTINE RT-RM-COMMAND-MODULE ("OPTIONAL" (CONTEXT <>))
	<COND
		(<MC-CONTEXT? ,M-F-LOOK ,M-V-LOOK ,M-LOOK>
			<TELL TAB "You ">
			<COND
				(<MC-CONTEXT? ,M-LOOK>
					<TELL "are in">
				)
				(T
					<TELL "enter">
				)
			>
			<TELL
the ,RM-COMMAND-MODULE ", a long narrow cabin like the inside of a Winnebago
packed with instrumentation. At the far end, a chair sits in front of a bank
of monitors. The only exit is in the aft wall." CR
			>
			<RFALSE>
		)
		(<MC-CONTEXT? ,M-BEG>
			<COND
				(<AND <VERB? SIT>
						<MC-PRSO? ,ROOMS>
					>
					<RT-COMMAND-MENU>
				)
			>
		)
		(.CONTEXT
			<RFALSE>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "TH-MONITORS"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-MONITORS
	(LOC RM-COMMAND-MODULE)
	(DESC "monitors")
	(FLAGS FL-NO-DESC)
	(SYNONYM MONITOR MONITORS)
	(ACTION RT-TH-MONITORS)
>
 
<ROUTINE RT-TH-MONITORS ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE>
			<TELL
TAB "The monitors glow with data gathered from all over Deepcore." CR
			>
		)
		(<VERB? SIT>
			<RT-COMMAND-MENU>
		)
	>
>
 
;"---------------------------------------------------------------------------"
; "TH-COMMAND-CHAIR"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-COMMAND-CHAIR
	(LOC RM-COMMAND-MODULE)
	(DESC "chair")
	(FLAGS FL-NO-DESC)
	(SYNONYM CHAIR)
	(ADJECTIVE COMMAND)
	(ACTION RT-TH-COMMAND-CHAIR)
>
 
<ROUTINE RT-TH-COMMAND-CHAIR ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? EXAMINE>
			<TELL
TAB "The chair is right in front of the main control panel." CR
			>
		)
		(<VERB? SIT ENTER>
			<RT-COMMAND-MENU>
		)
	>
>
 
<ROUTINE RT-COMMAND-MENU ("AUX" C L (ON? <>) X1 Y1 X2 Y2)
	<SET X1 1>
	<SET Y1 <L-PIXELS 4>>
	<SET X2 <C-PIXELS 16>>
	<SET Y2 <L-PIXELS 12>>
 
	<MOUSE-LIMIT -1>
 
	<CLEAR -1>
 
	; "Text window"
	<WINPOS 0 <+ 1 <- <LOWCORE VWRD> <* 6 ,GL-FONT-Y>>> 1>
	<WINSIZE 0 <* 6 ,GL-FONT-Y> <LOWCORE HWRD>>
 
	; "Status line -- Already defined."
;	<WINPOS 1 1 1>
;	<WINSIZE 1 ,GL-FONT-Y <LOWCORE HWRD>>
 
	; "Menu window"
	<WINPOS 2 <+ ,GL-FONT-Y 1> 1>
	<WINSIZE 2 <- <LOWCORE VWRD> <* 7 ,GL-FONT-Y>> <LOWCORE HWRD>>
 
	<WINPOS 7 1 1>
	<WINSIZE 7 <LOWCORE VWRD> <LOWCORE HWRD>>
 
	<SETG GL-SL-HERE <>>
 
	<REPEAT ()
		<CLEAR 2>
		<UPDATE-STATUS-LINE>
		<SCREEN 2>
		<CURSET 1 1>
		<TELL "Main menu">
 
		<CCURSET 4 1>
		<TELL "Emergency">
		<CCURSET 4 15>
		<TELL "E">
		<CCURSET 5 1>
		<TELL "ROV">
		<CCURSET 5 15>
		<TELL "R">
		<CCURSET 6 1>
		<TELL "Air">
		<CCURSET 6 15>
		<TELL "A">
		<CCURSET 7 1>
		<TELL "Power">
		<CCURSET 7 15>
		<TELL "P">
		<CCURSET 8 1>
		<TELL "Lights">
		<CCURSET 8 15>
		<TELL "L">
		<CCURSET 9 1>
		<TELL "Life Support">
		<CCURSET 9 15>
		<TELL "S">
		<CCURSET 10 1>
		<TELL "Pump">
		<CCURSET 10 15>
		<TELL "M">
		<CCURSET 11 1>
		<TELL "Exit">
		<CCURSET 11 15>
		<TELL "X">
 
		<REPEAT ()
			<SCREEN 0>
			<SETG GL-INPUT-TIMEOUT <>>
			<SET C <INPUT 1 3 ,RT-STOP-READ>>
			<COND
				(<NOT ,GL-INPUT-TIMEOUT>
					<COND
						(<EQUAL? .C ,K-CLICK1 ,K-CLICK2>
							<COND
								(<MOUSE-INPUT? 2 .X1 .Y1 .X2 .Y2>
									<SET L <PIXELS-L ,GL-MOUSE-Y>>
									<COND
										(<EQUAL? .L 1>
											<SET C !\e>
										)
										(<EQUAL? .L 2>
											<SET C !\r>
										)
										(<EQUAL? .L 3>
											<SET C !\a>
										)
										(<EQUAL? .L 4>
											<SET C !\p>
										)
										(<EQUAL? .L 5>
											<SET C !\l>
										)
										(<EQUAL? .L 6>
											<SET C !\s>
										)
										(<EQUAL? .L 7>
											<SET C !\m>
										)
										(T
											<SET C !\x>
										)
									>
									<RETURN>
								)
								(T
									<SOUND ,S-BEEP>
								)
							>
						)
						(T
							<COND
								(<AND <G=? .C !\A>
										<L=? .C !\Z>
									>
									<SET C <+ .C 32>>		; "Change to lower case"
								)
							>
							<COND
								(<EQUAL? .C !\e !\r !\a !\p !\l !\s !\m !\x>
									<RETURN>
								)
								(T
									<SOUND ,S-BEEP>
								)
							>
						)
					>
				)
				(T
					<SCREEN 2>
					<CCURSET 4 1>
					<COND
						(<SET ON? <NOT .ON?>>
							<HLIGHT ,K-H-INV>
						)
					>
					<TELL "Emergency">
					<HLIGHT ,K-H-NRM>
				)
			>
		>
		<COND
			(<EQUAL? .C !\e>
				<RT-EMERGENCY-MENU>
			)
			(<EQUAL? .C !\r>
				<RT-ROV-MENU>
			)
			(<EQUAL? .C !\a>
				<RT-AIR-MENU>
			)
			(<EQUAL? .C !\p>
				<RT-POWER-MENU>
			)
			(<EQUAL? .C !\l>
				<RT-LIGHT-MENU>
			)
			(<EQUAL? .C !\s>
				<RT-SUPPORT-MENU>
			)
			(<EQUAL? .C !\m>
				<RT-PUMP-MENU>
			)
			(<EQUAL? .C !\x>
				<RETURN>
			)
		>
	>
	<CLEAR -1>
	<INIT-STATUS-LINE>
	<SCREEN 0>
	<TELL TAB "You get up from the command chair." CR>
>
 
<ROUTINE RT-EMERGENCY-MENU ("AUX" X1 Y1 X2 Y2)
	<SET X1 1>
	<SET Y1 <L-PIXELS 4>>
	<SET X2 <C-PIXELS 25>>
	<SET Y2 <L-PIXELS 6>>
 
	<CLEAR 2>
	<UPDATE-STATUS-LINE>
	<SCREEN 2>
	<CURSET 1 1>
	<TELL "Emergency menu">
 
	<CCURSET 4 1>
	<HLIGHT ,K-H-INV>
	<COND
		(,GL-KLAXON-ON
			<TELL "ON ">
		)
		(T
			<TELL "OFF">
		)
	>
	<HLIGHT ,K-H-NRM>
	<CCURSET 4 4>
	<TELL "Emergency klaxons">
	<CCURSET 4 24>
	<TELL "K">
 
	<HLIGHT ,K-H-NRM>
	<CCURSET 5 4>
	<TELL "Exit">
	<CCURSET 5 24>
	<TELL "X">
 
	<REPEAT ()
		<SCREEN 0>
		<SET C <INPUT 1>>
		<COND
			(<EQUAL? .C ,K-CLICK1 ,K-CLICK2>
				<COND
					(<MOUSE-INPUT? 2 .X1 .Y1 .X2 .Y2>
						<SET L <PIXELS-L ,GL-MOUSE-Y>>
						<COND
							(<EQUAL? .L 1>
								<SET C !\k>
							)
							(T
								<SET C !\x>
							)
						>
					)
				>
			)
			(<AND <G=? .C !\A>
					<L=? .C !\Z>
				>
				<SET C <+ .C 32>>		; "Change to lower case"
			)
		>
		<COND
			(<EQUAL? .C !\k>
				<SCREEN 2>
				<CCURSET 4 1>
				<HLIGHT ,K-H-INV>
				<COND
					(<SETG GL-KLAXON-ON <NOT ,GL-KLAXON-ON>>
						<RT-QUEUE ,RT-I-KLAXON <+ ,GL-MOVES 1>>
						<TELL "ON ">
					)
					(T
						<RT-DEQUEUE ,RT-I-KLAXON>
						<TELL "OFF">
					)
				>
				<HLIGHT ,K-H-NRM>
			)
			(<EQUAL? .C !\x>
				<RETURN>
			)
			(T
				<SOUND ,S-BEEP>
			)
		>
	>
	<RTRUE>
>
 
<ROUTINE RT-ROV-MENU ()
	<CLEAR 2>
	<UPDATE-STATUS-LINE>
	<SCREEN 2>
	<CURSET 1 1>
	<TELL "R.O.V. menu">
	<SCREEN 0>
	<INPUT 1>
	<RTRUE>
>
 
<ROUTINE RT-AIR-MENU ()
	<CLEAR 2>
	<UPDATE-STATUS-LINE>
	<SCREEN 2>
	<CURSET 1 1>
	<TELL "Breathing Mix menu">
 
	<CCURSET 4 1>
	<TELL "Oxygen: ">
	<RT-PRINT-FLOAT ,GL-OXYGEN-QTY ,K-OXYGEN-FACTOR>
	<TELL "% - ">
	<RT-GAS-LEVEL-MSG ,GL-OXYGEN-QTY ,K-OXY-LOW-1 ,K-OXY-HIGH-1 ,K-OXY-NOM>
	<TELL "|Carbon dioxide: ">
	<RT-PRINT-FLOAT ,GL-CO2-QTY ,K-CO2-FACTOR>
	<TELL "% - ">
	<RT-GAS-LEVEL-MSG ,GL-CO2-QTY -1 ,K-CO2-HIGH-1 ,K-CO2-NOM>
	<TELL "|Nitrogen: ">
	<RT-PRINT-FLOAT ,GL-NITROGEN-QTY ,K-NITROGEN-FACTOR>
	<TELL "% - ">
	<RT-GAS-LEVEL-MSG ,GL-NITROGEN-QTY ,K-NIT-LOW-1 ,K-NIT-HIGH-1 ,K-NIT-NOM>
	<TELL "|Helium: ">
	<RT-PRINT-FLOAT ,GL-HELIUM-QTY ,K-HELIUM-FACTOR>
	<TELL "%|">
 
	<SCREEN 0>
	<INPUT 1>
	<RTRUE>
>
 
<ROUTINE RT-GAS-LEVEL-MSG (QTY LOW HIGH NOM)
	<COND
		(<L=? .QTY .LOW>
			<TELL "low">
		)
		(<G=? .QTY .HIGH>
			<TELL "high">
		)
		(<EQUAL? .QTY .NOM>
			<TELL "nominal">
		)
		(<L? .QTY .NOM>
			<TELL "less than nominal">
		)
		(T
			<TELL "more than nominal">
		)
	>
>
 
<ROUTINE RT-POWER-MENU ()
	<CLEAR 2>
	<UPDATE-STATUS-LINE>
	<SCREEN 2>
	<CURSET 1 1>
	<TELL "Power menu">
	<SCREEN 0>
	<INPUT 1>
	<RTRUE>
>
 
<ROUTINE RT-LIGHT-MENU ()
	<CLEAR 2>
	<UPDATE-STATUS-LINE>
	<SCREEN 2>
	<CURSET 1 1>
	<TELL "Lighting menu">
	<SCREEN 0>
	<INPUT 1>
	<RTRUE>
>
 
<ROUTINE RT-SUPPORT-MENU ("AUX" X1 Y1 X2 Y2)
	<SET X1 1>
	<SET Y1 <L-PIXELS 4>>
	<SET X2 <C-PIXELS 28>>
	<SET Y2 <L-PIXELS 9>>
 
	<CLEAR 2>
	<UPDATE-STATUS-LINE>
	<SCREEN 2>
	<CURSET 1 1>
	<TELL "Life support menu">
 
	<CCURSET 4 1>
	<HLIGHT ,K-H-INV>
	<COND
		(,GL-SCRUBBERS-ON
			<TELL "ON ">
		)
		(T
			<TELL "OFF">
		)
	>
	<HLIGHT ,K-H-NRM>
	<CCURSET 4 4>
	<TELL "CO2 scrubbers">
	<CCURSET 4 27>
	<TELL "S">
 
	<CCURSET 5 1>
	<HLIGHT ,K-H-INV>
	<COND
		(,GL-HEATERS-ON
			<TELL "ON ">
		)
		(T
			<TELL "OFF">
		)
	>
	<HLIGHT ,K-H-NRM>
	<CCURSET 5 4>
	<TELL "Heaters">
	<CCURSET 5 27>
	<TELL "H">
 
	<CCURSET 6 1>
	<HLIGHT ,K-H-INV>
	<TELL "ON ">
	<HLIGHT ,K-H-NRM>
	<CCURSET 6 4>
	<TELL "Helium de-scramblers">
	<CCURSET 6 27>
	<TELL "D">
 
	<CCURSET 7 1>
	<HLIGHT ,K-H-INV>
	<TELL "ON ">
	<HLIGHT ,K-H-NRM>
	<CCURSET 7 4>
	<TELL "De-humidifiers">
	<CCURSET 7 27>
	<TELL "M">
 
	<HLIGHT ,K-H-NRM>
	<CCURSET 8 4>
	<TELL "Exit">
	<CCURSET 8 27>
	<TELL "X">
 
	<CCURSET 4 50>
	<TELL "Interior temp:">
	<CCURSET 5 50>
	<RT-PRINT-FLOAT ,GL-DEEPCORE-TEMP ,K-TEMP-FACTOR>
	<TELL " deg. F">
 
	<REPEAT ()
		<SCREEN 0>
		<SET C <INPUT 1>>
		<COND
			(<EQUAL? .C ,K-CLICK1 ,K-CLICK2>
				<COND
					(<MOUSE-INPUT? 2 .X1 .Y1 .X2 .Y2>
						<SET L <PIXELS-L ,GL-MOUSE-Y>>
						<COND
							(<EQUAL? .L 1>
								<SET C !\s>
							)
							(<EQUAL? .L 2>
								<SET C !\h>
							)
							(<EQUAL? .L 3>
								<SET C !\d>
							)
							(<EQUAL? .L 4>
								<SET C !\m>
							)
							(T
								<SET C !\x>
							)
						>
					)
				>
			)
			(<AND <G=? .C !\A>
					<L=? .C !\Z>
				>
				<SET C <+ .C 32>>		; "Change to lower case"
			)
		>
		<COND
			(<EQUAL? .C !\s>
				<SETG GL-SCRUBBERS-ON <NOT ,GL-SCRUBBERS-ON>>
				<SCREEN 2>
				<CCURSET 4 1>
				<HLIGHT ,K-H-INV>
				<COND
					(,GL-SCRUBBERS-ON
						<TELL "ON ">
					)
					(T
						<TELL "OFF">
					)
				>
				<HLIGHT ,K-H-NRM>
			)
			(<EQUAL? .C !\h>
				<SETG GL-HEATERS-ON <NOT ,GL-HEATERS-ON>>
				<SCREEN 2>
				<CCURSET 5 1>
				<HLIGHT ,K-H-INV>
				<COND
					(,GL-HEATERS-ON
						<TELL "ON ">
					)
					(T
						<TELL "OFF">
					)
				>
				<HLIGHT ,K-H-NRM>
			)
			(<EQUAL? .C !\d>)
			(<EQUAL? .C !\m>)
			(<EQUAL? .C !\x>
				<RETURN>
			)
			(T
				<SOUND ,S-BEEP>
			)
		>
	>
	<RTRUE>
>
 
;<GLOBAL GL-PT-BILGE-ON <> <> BYTE>
;<GLOBAL GL-SB-BILGE-ON <> <> BYTE>
<GLOBAL GL-WATER-PUMP-ON <> <> BYTE>
 
<ROUTINE RT-PUMP-MENU ("AUX" X1 Y1 X2 Y2)
	<SET X1 1>
	<SET Y1 <L-PIXELS 4>>
	<SET X2 <C-PIXELS 24>>
	<SET Y2 <L-PIXELS 6>>
 
	<CLEAR 2>
	<UPDATE-STATUS-LINE>
	<SCREEN 2>
	<CURSET 1 1>
	<TELL "Pump and compressor menu">
 
	<CCURSET 4 1>
	<HLIGHT ,K-H-INV>
	<COND
		(,GL-WATER-PUMP-ON
			<TELL "ON ">
		)
		(T
			<TELL "OFF">
		)
	>
	<HLIGHT ,K-H-NRM>
	<CCURSET 4 4>
	<TELL "Fresh water pumps">
	<CCURSET 4 23>
	<TELL "P">
 
;	<CCURSET 4 1>
;	<HLIGHT ,K-H-INV>
;	<COND
		(,GL-PT-BILGE-ON
			<TELL "ON ">
		)
		(T
			<TELL "OFF">
		)
	>
;	<HLIGHT ,K-H-NRM>
;	<CCURSET 4 4>
;	<TELL "Port bilge pumps">
;	<CCURSET 4 27>
;	<TELL "P">
 
;	<CCURSET 5 1>
;	<HLIGHT ,K-H-INV>
;	<COND
		(,GL-SB-BILGE-ON
			<TELL "ON ">
		)
		(T
			<TELL "OFF">
		)
	>
;	<HLIGHT ,K-H-NRM>
;	<CCURSET 5 4>
;	<TELL "Starboard bilge pumps">
;	<CCURSET 5 27>
;	<TELL "S">
 
	<HLIGHT ,K-H-NRM>
	<CCURSET 5 4>
	<TELL "Exit">
	<CCURSET 5 23>
	<TELL "X">
 
	<REPEAT ()
		<SCREEN 0>
		<SET C <INPUT 1>>
		<COND
			(<EQUAL? .C ,K-CLICK1 ,K-CLICK2>
				<COND
					(<MOUSE-INPUT? 2 .X1 .Y1 .X2 .Y2>
						<SET L <PIXELS-L ,GL-MOUSE-Y>>
						<COND
							(<EQUAL? .L 1>
								<SET C !\p>
							)
						;	(<EQUAL? .L 2>
								<SET C !\s>
							)
							(T
								<SET C !\x>
							)
						>
					)
				>
			)
			(<AND <G=? .C !\A>
					<L=? .C !\Z>
				>
				<SET C <+ .C 32>>		; "Change to lower case"
			)
		>
		<COND
			(<EQUAL? .C !\p>
				<SCREEN 2>
				<CCURSET 4 1>
				<HLIGHT ,K-H-INV>
				<COND
					(<SETG GL-WATER-PUMP-ON <NOT ,GL-WATER-PUMP-ON>>
						<TELL "ON ">
					)
					(T
						<TELL "OFF">
					)
				>
				<HLIGHT ,K-H-NRM>
			)
		;	(<EQUAL? .C !\s>
				<SCREEN 2>
				<CCURSET 5 1>
				<HLIGHT ,K-H-INV>
				<COND
					(<SETG GL-SB-BILGE-ON <NOT ,GL-SB-BILGE-ON>>
						<TELL "ON ">
					)
					(T
						<TELL "OFF">
					)
				>
				<HLIGHT ,K-H-NRM>
			)
			(<EQUAL? .C !\x>
				<RETURN>
			)
			(T
				<SOUND ,S-BEEP>
			)
		>
	>
	<RTRUE>
>
 
 
;"---------------------------------------------------------------------------"
; "TH-DESCRAMBLER-CONTROL-BOX"
;"---------------------------------------------------------------------------"
 
<OBJECT TH-DESCRAMBLER-CONTROL-BOX
	(LOC TH-BIN)
	(DESC "descrambler control box")
	(MENU "control box")
	(SYNONYM DESCRAMBLER BOX)
	(ADJECTIVE CONTROL DESCRAMBLER)
	(ACTION RT-TH-DESCRAMBLER-CONTROL-BOX)
>
 
<ROUTINE RT-TH-DESCRAMBLER-CONTROL-BOX ("OPT" (CONTEXT <>))
	<RFALSE>
>
 
;"***************************************************************************"
; "end of file"
;"***************************************************************************"
 
