;"***************************************************************************"
; "game : Abyss"
; "file : GAS-MIX.ZIL"
; "auth :   $Author:   DEB  $"
; "date :     $Date:   20 Mar 1989  8:44:46  $"
; "rev  : $Revision:   1.11  $"
; "vers : 1.0"
;"---------------------------------------------------------------------------"
; "Default substitutions"
; "Copyright (C) 1988 Infocom, Inc.  All rights reserved."
;"***************************************************************************"
 
<GLOBAL GL-OXYGEN-QTY 3400>
<GLOBAL GL-OXYGEN-MSG 3400>
<CONSTANT K-OXYGEN-FACTOR -4>
<CONSTANT K-OXY-LOW-4 850>
<CONSTANT K-OXY-LOW-3 1133>
<CONSTANT K-OXY-LOW-2 1417>
<CONSTANT K-OXY-LOW-1 1700>
<CONSTANT K-OXY-NOM 3400>
<CONSTANT K-OXY-HIGH-1 20400>
<CONSTANT K-OXY-HIGH-2 23800>
<CONSTANT K-OXY-HIGH-3 27200>
<CONSTANT K-OXY-HIGH-4 30600>
 
<GLOBAL GL-CO2-QTY 536>
<GLOBAL GL-CO2-MSG 536>
<CONSTANT K-CO2-FACTOR -6>
<CONSTANT K-CO2-NOM 536>
<CONSTANT K-CO2-HIGH-1 22725>
<CONSTANT K-CO2-HIGH-2 25971>
<CONSTANT K-CO2-HIGH-3 29218>
<CONSTANT K-CO2-HIGH-4 32464>
 
<GLOBAL GL-NITROGEN-QTY 1267>
<GLOBAL GL-NITROGEN-MSG 1267>
<CONSTANT K-NITROGEN-FACTOR -3>
<CONSTANT K-NIT-LOW-4 211>
<CONSTANT K-NIT-LOW-3 253>
<CONSTANT K-NIT-LOW-2 317>
<CONSTANT K-NIT-LOW-1 422>
<CONSTANT K-NIT-NOM 1267>
<CONSTANT K-NIT-HIGH-1 3802>
<CONSTANT K-NIT-HIGH-2 5070>
<CONSTANT K-NIT-HIGH-3 6337>
<CONSTANT K-NIT-HIGH-4 7605>
 
<GLOBAL GL-HELIUM-QTY 9839>
<CONSTANT K-HELIUM-FACTOR -2>
<CONSTANT K-HEL-NOM 9839>
 
<GLOBAL GL-SCRUBBERS-ON <> <> BYTE>
 
<SYNTAX $SCRUB = V-$SCRUB>
 
<ROUTINE V-$SCRUB ()
	<TELL "[CO2 scrubbers ">
	<COND
		(<SETG GL-SCRUBBERS-ON <NOT ,GL-SCRUBBERS-ON>>
			<TELL "on">
		)
		(T
			<TELL "off">
		)
	>
	<TELL ".]|">
	<RFATAL>
>
 
<SYNTAX $AIR = V-$AIR>
 
<ROUTINE V-$AIR ()
	<SETG GL-OXYGEN-QTY ,K-OXY-NOM>
	<SETG GL-OXYGEN-MSG ,K-OXY-NOM>
	<SETG GL-CO2-QTY ,K-CO2-NOM>
	<SETG GL-CO2-MSG ,K-CO2-NOM>
	<SETG GL-NITROGEN-QTY ,K-NIT-NOM>
	<SETG GL-NITROGEN-MSG ,K-NIT-NOM>
	<SETG GL-HELIUM-QTY ,K-HEL-NOM>
	<TELL "[Breathing mix returned to nominal.]|">
	<RFATAL>
>
 
<ROUTINE RT-NUM-DIGITS (N)
	<SET N <ABS .N>>
	<COND
		(<L? .N 10>
			<RETURN 1>
		)
		(<L? .N 100>
			<RETURN 2>
		)
		(<L? .N 1000>
			<RETURN 3>
		)
		(<L? .N 10000>
			<RETURN 4>
		)
		(T
			<RETURN 5>
		)
	>
>
 
<ROUTINE RT-PRINT-FLOAT (F E "OPT" (D -1) "AUX" N M)
	<COND
		(<L? .E 0>
			<SET N <- <RT-NUM-DIGITS .F>>>
			<COND
				(<L=? .E .N>
					<TELL "0.">
					<REPEAT ()
						<COND
							(<L? .E .N>
								<TELL !\0>
								<INC E>
							)
							(T
								<RETURN>
							)
						>
					>
					<TELL N .F>
				)
				(T
					<COND
						(<EQUAL? <- .N> 5>
							<SET M 10000>
						)
						(<EQUAL? <- .N> 4>
							<SET M 1000>
						)
						(<EQUAL? <- .N> 3>
							<SET M 100>
						)
						(<EQUAL? <- .N> 2>
							<SET M 10>
						)
						(T
							<SET M 1>
						)
					>
					<REPEAT ()
						<TELL N <MOD </ .F .M> 10>>
						<INC N>
						<COND
							(<EQUAL? .E .N>
								<TELL !\.>
							)
						>
						<SET M </ .M 10>>
						<COND
							(<EQUAL? .M 0>
								<RETURN>
							)
						>
					>
				)
			>
		)
		(T
			<TELL N .F>
			<SET N 0>
			<REPEAT ()
				<COND
					(<L? .N .E>
						<TELL !\0>
						<INC N>
					)
					(T
						<RETURN>
					)
				>
			>
		)
	>
>
 
<ROUTINE RT-NITROGEN-MSG ()
	<COND
		(<G? ,GL-NITROGEN-QTY ,GL-NITROGEN-MSG>
			; "Nitrogen going up"
			<COND
				(<G=? ,GL-NITROGEN-QTY ,K-NIT-HIGH-4>
					<COND
						(T ;<L? ,GL-NITROGEN-MSG ,K-NIT-HIGH-4>
							<SETG GL-NITROGEN-MSG ,GL-NITROGEN-QTY>
							<TELL
"	The high nitrogen level finally overcomes you and you fall to the floor,
unconscious.|"
							>
							<RT-END-OF-GAME>
						)
					>
				)
				(<G=? ,GL-NITROGEN-QTY ,K-NIT-HIGH-3>
					<COND
						(<L? ,GL-NITROGEN-MSG ,K-NIT-HIGH-3>
							<SETG GL-NITROGEN-MSG ,GL-NITROGEN-QTY>
							<TELL "	You are beginning to hallucinate." CR>
						)
					>
				)
				(<G=? ,GL-NITROGEN-QTY ,K-NIT-HIGH-2>
					<COND
						(<L? ,GL-NITROGEN-MSG ,K-NIT-HIGH-2>
							<SETG GL-NITROGEN-MSG ,GL-NITROGEN-QTY>
							<TELL "	Your head is beginning to spin." CR>
						)
					>
				)
				(<G=? ,GL-NITROGEN-QTY ,K-NIT-HIGH-1>
					<COND
						(<L? ,GL-NITROGEN-MSG ,K-NIT-HIGH-1>
							<SETG GL-NITROGEN-MSG ,GL-NITROGEN-QTY>
							<TELL "	You are beginning to feel light-headed." CR>
						)
					>
				)
				(<G? ,GL-NITROGEN-QTY ,K-NIT-LOW-1>
					<COND
						(<L=? ,GL-NITROGEN-MSG ,K-NIT-LOW-1>
							<SETG GL-NITROGEN-MSG ,GL-NITROGEN-QTY>
							<TELL
"	Your hands stop trembling. The nitrogen level must be back to normal." CR
							>
						)
					>
				)
				(<G? ,GL-NITROGEN-QTY ,K-NIT-LOW-2>
					<COND
						(<L=? ,GL-NITROGEN-MSG ,K-NIT-LOW-2 ;317>
							<SETG GL-NITROGEN-MSG ,GL-NITROGEN-QTY>
							<TELL
"	Most of the trembling in your hands has disappeared." CR
							>
						)
					>
				)
				(<G? ,GL-NITROGEN-QTY ,K-NIT-LOW-3>
					<COND
						(<L=? ,GL-NITROGEN-MSG ,K-NIT-LOW-3 ;253>
							<SETG GL-NITROGEN-MSG ,GL-NITROGEN-QTY>
							<TELL
"	The flashes of irritibility cease, but your fingertips are still
trembling." CR
							>
						)
					>
				)
			>
		)
		(<L? ,GL-NITROGEN-QTY ,GL-NITROGEN-MSG>
			; "Nitrogen going down"
			<COND
				(<L=? ,GL-NITROGEN-QTY ,K-NIT-LOW-4>
					<COND
						(T ;<G? ,GL-NITROGEN-MSG ,K-NIT-LOW-4>
							<SETG GL-NITROGEN-MSG ,GL-NITROGEN-QTY>
							<TELL
"	You slump to the floor, a victim of High Pressure Nervous Syndrome.|"
							>
							<RT-END-OF-GAME>
						)
					>
				)
				(<L=? ,GL-NITROGEN-QTY ,K-NIT-LOW-3>
					<COND
						(<G? ,GL-NITROGEN-MSG ,K-NIT-LOW-3>
							<SETG GL-NITROGEN-MSG ,GL-NITROGEN-QTY>
							<TELL
"	You begin to have flashes of sudden irritibility." CR
							>
						)
					>
				)
				(<L=? ,GL-NITROGEN-QTY ,K-NIT-LOW-2>
					<COND
						(<G? ,GL-NITROGEN-MSG ,K-NIT-LOW-2>
							<SETG GL-NITROGEN-MSG ,GL-NITROGEN-QTY>
							<TELL
"	The trembling in your fingertips gets worse." CR
							>
						)
					>
				)
				(<L=? ,GL-NITROGEN-QTY ,K-NIT-LOW-1>
					<COND
						(<G? ,GL-NITROGEN-MSG ,K-NIT-LOW-1>
							<SETG GL-NITROGEN-MSG ,GL-NITROGEN-QTY>
							<TELL "	Your hands begin to tremble." CR>
						)
					>
				)
				(<L? ,GL-NITROGEN-QTY ,K-NIT-HIGH-1>
					<COND
						(<G=? ,GL-NITROGEN-MSG ,K-NIT-HIGH-1>
							<SETG GL-NITROGEN-MSG ,GL-NITROGEN-QTY>
							<TELL
"	You no longer feel dizzy. The nitrogen level must be back to normal." CR
							>
						)
					>
				)
				(<L? ,GL-NITROGEN-QTY ,K-NIT-HIGH-2>
					<COND
						(<G=? ,GL-NITROGEN-MSG ,K-NIT-HIGH-2>
							<SETG GL-NITROGEN-MSG ,GL-NITROGEN-QTY>
							<TELL
"	Your head stops spinning, but you still feel dizzy." CR
							>
						)
					>
				)
				(<L? ,GL-NITROGEN-QTY ,K-NIT-HIGH-3>
					<COND
						(<G=? ,GL-NITROGEN-MSG ,K-NIT-HIGH-3>
							<SETG GL-NITROGEN-MSG ,GL-NITROGEN-QTY>
							<TELL
"	The hallucinations fade, but your head is still spinning." CR
							>
						)
					>
				)
			>
		)
	>
>
 
<ROUTINE RT-OXYGEN-MSG ()
	<COND
		(<G? ,GL-OXYGEN-QTY ,GL-OXYGEN-MSG>
			; "Oxygen going up"
			<COND
				(<G=? ,GL-OXYGEN-QTY ,K-OXY-HIGH-4>
					<COND
						(T ;<L? ,GL-OXYGEN-MSG ,K-OXY-HIGH-4>
							<SETG GL-OXYGEN-MSG ,GL-OXYGEN-QTY>
							<TELL
"	The high oxygen level finally overcomes you. You go into convulsions, fall
to the floor, and pass out.|"
							>
							<RT-END-OF-GAME>
						)
					>
				)
				(<G=? ,GL-OXYGEN-QTY ,K-OXY-HIGH-3>
					<COND
						(<L? ,GL-OXYGEN-MSG ,K-OXY-HIGH-3>
							<SETG GL-OXYGEN-MSG ,GL-OXYGEN-QTY>
							<TELL
"	Suddenly, your stomach muscles tighten up and you fight off the urge to
vomit." CR
							>
						)
					>
				)
				(<G=? ,GL-OXYGEN-QTY ,K-OXY-HIGH-2>
					<COND
						(<L? ,GL-OXYGEN-MSG ,K-OXY-HIGH-2>
							<SETG GL-OXYGEN-MSG ,GL-OXYGEN-QTY>
							<TELL "	You begin to feel nauseous." CR>
						)
					>
				)
				(<G=? ,GL-OXYGEN-QTY ,K-OXY-HIGH-1>
					<COND
						(<L? ,GL-OXYGEN-MSG ,K-OXY-HIGH-1>
							<SETG GL-OXYGEN-MSG ,GL-OXYGEN-QTY>
							<TELL "	Suddenly, you feel a twitch in your lower lip." CR>
						)
					>
				)
				(<G? ,GL-OXYGEN-QTY ,K-OXY-LOW-1>
					<COND
						(<L=? ,GL-OXYGEN-MSG ,K-OXY-LOW-1>
							<SETG GL-OXYGEN-MSG ,GL-OXYGEN-QTY>
							<TELL
"	Your headache disappears. The oxygen level must be back to normal." CR
							>
						)
					>
				)
				(<G? ,GL-OXYGEN-QTY ,K-OXY-LOW-2>
					<COND
						(<L=? ,GL-OXYGEN-MSG ,K-OXY-LOW-2>
							<SETG GL-OXYGEN-MSG ,GL-OXYGEN-QTY>
							<TELL
"	You begin to see colors again, but you still have a mild headache." CR
							>
						)
					>
				)
				(<G? ,GL-OXYGEN-QTY ,K-OXY-LOW-3>
					<COND
						(<L=? ,GL-OXYGEN-MSG ,K-OXY-LOW-3>
							<SETG GL-OXYGEN-MSG ,GL-OXYGEN-QTY>
							<TELL "	Your tunnel vision begins to fade." CR>
						)
					>
				)
			>
		)
		(<L? ,GL-OXYGEN-QTY ,GL-OXYGEN-MSG>
			; "Oxygen going down"
			<COND
				(<L=? ,GL-OXYGEN-QTY ,K-OXY-LOW-4>
					<COND
						(T ;<G? ,GL-OXYGEN-MSG ,K-OXY-LOW-4>
							<SETG GL-OXYGEN-MSG ,GL-OXYGEN-QTY>
							<TELL "	You collapse, a victim of oxygen starvation.|">
							<RT-END-OF-GAME>
						)
					>
				)
				(<L=? ,GL-OXYGEN-QTY ,K-OXY-LOW-3>
					<COND
						(<G? ,GL-OXYGEN-MSG ,K-OXY-LOW-3>
							<SETG GL-OXYGEN-MSG ,GL-OXYGEN-QTY>
							<TELL
"	You notice that your peripheral vision is beginning to disappear." CR
							>
						)
					>
				)
				(<L=? ,GL-OXYGEN-QTY ,K-OXY-LOW-2>
					<COND
						(<G? ,GL-OXYGEN-MSG ,K-OXY-LOW-2>
							<SETG GL-OXYGEN-MSG ,GL-OXYGEN-QTY>
							<TELL "	The colors around you seem to fade." CR>
						)
					>
				)
				(<L=? ,GL-OXYGEN-QTY ,K-OXY-LOW-1>
					<COND
						(<G? ,GL-OXYGEN-MSG ,K-OXY-LOW-1>
							<SETG GL-OXYGEN-MSG ,GL-OXYGEN-QTY>
							<TELL "	Your head begins to ache." CR>
						)
					>
				)
				(<L? ,GL-OXYGEN-QTY ,K-OXY-HIGH-1>
					<COND
						(<G=? ,GL-OXYGEN-MSG ,K-OXY-HIGH-1>
							<SETG GL-OXYGEN-MSG ,GL-OXYGEN-QTY>
							<TELL
"	You lip stops twitching. The oxygen level must be back to normal." CR
							>
						)
					>
				)
				(<L? ,GL-OXYGEN-QTY ,K-OXY-HIGH-2>
					<COND
						(<G=? ,GL-OXYGEN-MSG ,K-OXY-HIGH-2>
							<SETG GL-OXYGEN-MSG ,GL-OXYGEN-QTY>
							<TELL
"	You no longer feel nauseous, but your lip still twitches occasionally." CR
							>
						)
					>
				)
				(<L? ,GL-OXYGEN-QTY ,K-OXY-HIGH-3>
					<COND
						(<G=? ,GL-OXYGEN-MSG ,K-OXY-HIGH-3>
							<SETG GL-OXYGEN-MSG ,GL-OXYGEN-QTY>
							<TELL
"	The tension in your stomach disappears, but you still feel slightly
nauseous." CR
							>
						)
					>
				)
			>
		)
	>
>
 
<ROUTINE RT-CO2-MSG ()
	<COND
		(<G? ,GL-CO2-QTY ,GL-CO2-MSG>
			; "Carbon Dioxide going up"
			<COND
				(<G=? ,GL-CO2-QTY ,K-CO2-HIGH-4>
					<COND
						(T ;<L? ,GL-CO2-MSG ,K-CO2-HIGH-4>
							<SETG GL-CO2-MSG ,GL-CO2-QTY>
							<TELL "	You pass out from carbon dioxide poisoning.|">
							<RT-END-OF-GAME>
						)
					>
				)
				(<G=? ,GL-CO2-QTY ,K-CO2-HIGH-3>
					<COND
						(<L? ,GL-CO2-MSG ,K-CO2-HIGH-3>
							<SETG GL-CO2-MSG ,GL-CO2-QTY>
							<TELL
"	Suddenly the muscles in your arm begin to spasm." CR
							>
						)
					>
				)
				(<G=? ,GL-CO2-QTY ,K-CO2-HIGH-2>
					<COND
						(<L? ,GL-CO2-MSG ,K-CO2-HIGH-2>
							<SETG GL-CO2-MSG ,GL-CO2-QTY>
							<TELL "	Your chest muscles are beginning to ache." CR>
						)
					>
				)
				(<G=? ,GL-CO2-QTY ,K-CO2-HIGH-1>
					<COND
						(<L? ,GL-CO2-MSG ,K-CO2-HIGH-1>
							<SETG GL-CO2-MSG ,GL-CO2-QTY>
							<TELL "	You begin to feel a little short of breath." CR>
						)
					>
				)
			>
		)
		(<L? ,GL-CO2-QTY ,GL-CO2-MSG>
			; "Carbon Dioxide going down"
			<COND
				(<L? ,GL-CO2-QTY ,K-CO2-HIGH-1>
					<COND
						(<G=? ,GL-CO2-MSG ,K-CO2-HIGH-1>
							<SETG GL-CO2-MSG ,GL-CO2-QTY>
							<TELL
"	You begin to breathe more easily. The carbon dioxide level must have
returned to normal." CR
							>
						)
					>
				)
				(<L? ,GL-CO2-QTY ,K-CO2-HIGH-2>
					<COND
						(<G=? ,GL-CO2-MSG ,K-CO2-HIGH-2>
							<SETG GL-CO2-MSG ,GL-CO2-QTY>
							<TELL
"	Your chest muscles feel better, but you are still short of breath." CR
							>
						)
					>
				)
				(<L? ,GL-CO2-QTY ,K-CO2-HIGH-3>
					<COND
						(<G=? ,GL-CO2-MSG ,K-CO2-HIGH-3>
							<SETG GL-CO2-MSG ,GL-CO2-QTY>
							<TELL
"	The spasms in your arm have stopped, but your chest muscles still ache." CR
							>
						)
					>
				)
			>
		)
	>
>
 
<ROUTINE RT-I-GAS-MIX ()
	<RT-QUEUE ,RT-I-GAS-MIX <+ ,GL-MOVES 1>>
	<SETG GL-OXYGEN-QTY <- ,GL-OXYGEN-QTY 4>>
	<COND
		(<L? ,GL-OXYGEN-QTY 0>
			<SETG GL-OXYGEN-QTY 0>
		)
	>
	<COND
		(,GL-SCRUBBERS-ON
			<SETG GL-CO2-QTY <- ,GL-CO2-QTY 340>>
			<COND
				(<L? ,GL-CO2-QTY 0>
					<SETG GL-CO2-QTY 0>
				)
			>
		)
		(T
			<SETG GL-CO2-QTY <+ ,GL-CO2-QTY 340>>
		)
	>
	<COND
		(<OR	<RT-OXYGEN-MSG>
				<RT-CO2-MSG>
			>
			<RTRUE>
		)
	>
>
 
<GLOBAL GL-HEATERS-ON <> <> BYTE>
 
<SYNTAX $HEAT = V-$HEAT>
 
<ROUTINE V-$HEAT ()
	<TELL "[Heaters ">
	<COND
		(<SETG GL-HEATERS-ON <NOT ,GL-HEATERS-ON>>
			<TELL "on">
		)
		(T
			<TELL "off">
		)
	>
	<TELL ".]|">
	<RFATAL>
>
 
<CONSTANT K-AMBIENT-TEMP 3400>
 
<GLOBAL GL-DEEPCORE-TEMP 9000>
 
<GLOBAL GL-PLAYER-TEMP 9860>	; "98.6 deg F"
<GLOBAL GL-TEMP-MSG 9860>
<CONSTANT K-TEMP-FACTOR -2>
<CONSTANT K-TEMP-LOW-4 8600>
<CONSTANT K-TEMP-LOW-3 9100>
<CONSTANT K-TEMP-LOW-2 9300>
<CONSTANT K-TEMP-LOW-1 9500>
<CONSTANT K-TEMP-NOM 9860>
<CONSTANT K-TEMP-HIGH-1 10000>
<CONSTANT K-TEMP-HIGH-2 10500>
<CONSTANT K-TEMP-HIGH-3 11000>
<CONSTANT K-TEMP-HIGH-4 11500>
 
<OBJECT TH-THERMOMETER
	(LOC CH-PLAYER)
	(DESC "thermometer")
	(FLAGS FL-READABLE FL-TAKEABLE)
	(SYNONYM THERMOMETER)
	(ACTION RT-TH-THERMOMETER)
>
 
<ROUTINE RT-TH-THERMOMETER ("OPT" (CONTEXT <>))
	<COND
		(.CONTEXT
			<RFALSE>
		)
		(<VERB? READ EXAMINE>
			<TELL "	The thermometer says your core temperature is ">
			<RT-PRINT-FLOAT ,GL-PLAYER-TEMP ,K-TEMP-FACTOR>
			<TELL " degrees Fahrenheit." CR>
		)
	>
>
 
<ROUTINE RT-TEMP-MSG ()
	<COND
		(<L? ,GL-PLAYER-TEMP ,GL-TEMP-MSG>
			; "Temperature going down."
			<COND
				(<L=? ,GL-PLAYER-TEMP ,K-TEMP-LOW-4>
					<COND
						(T ;<G? ,GL-TEMP-MSG ,K-TEMP-LOW-4>
							<SETG GL-TEMP-MSG ,GL-PLAYER-TEMP>
							<TELL "	The cold finally overpowers you and you pass out.|">
							<RT-END-OF-GAME>
						)
					>
				)
				(<L=? ,GL-PLAYER-TEMP ,K-TEMP-LOW-3>
					<COND
						(<G? ,GL-TEMP-MSG ,K-TEMP-LOW-3>
							<SETG GL-TEMP-MSG ,GL-PLAYER-TEMP>
							<TELL "	You're so cold you can hardly move." CR>
						)
					>
				)
				(<L=? ,GL-PLAYER-TEMP ,K-TEMP-LOW-2>
					<COND
						(<G? ,GL-TEMP-MSG ,K-TEMP-LOW-2>
							<SETG GL-TEMP-MSG ,GL-PLAYER-TEMP>
							<TELL "	The cold begins to creep into your bones." CR>
						)
					>
				)
				(<L=? ,GL-PLAYER-TEMP ,K-TEMP-LOW-1>
					<COND
						(<G? ,GL-TEMP-MSG ,K-TEMP-LOW-1>
							<SETG GL-TEMP-MSG ,GL-PLAYER-TEMP>
							<TELL "	You begin to shiver." CR>
						)
					>
				)
				(<L? ,GL-PLAYER-TEMP ,K-TEMP-HIGH-1>
					<COND
						(<G=? ,GL-TEMP-MSG ,K-TEMP-HIGH-1>
							<SETG GL-TEMP-MSG ,GL-PLAYER-TEMP>
							<TELL
"	You stop sweating. Your body temperature must have returned to normal." CR
							>
						)
					>
				)
				(<L? ,GL-PLAYER-TEMP ,K-TEMP-HIGH-2>
					<COND
						(<G=? ,GL-TEMP-MSG ,K-TEMP-HIGH-2>
							<SETG GL-TEMP-MSG ,GL-PLAYER-TEMP>
							<TELL
"	Your face is no longer flushed, but you are still sweating." CR
							>
						)
					>
				)
				(<L? ,GL-PLAYER-TEMP ,K-TEMP-HIGH-3>
					<COND
						(<G=? ,GL-TEMP-MSG ,K-TEMP-HIGH-3>
							<SETG GL-TEMP-MSG ,GL-PLAYER-TEMP>
							<TELL
"	Your breathing returns to normal, but your face is still red." CR
							>
						)
					>
				)
			>
		)
		(<G? ,GL-PLAYER-TEMP ,GL-TEMP-MSG>
			; "Temperature going up."
			<COND
				(<G=? ,GL-PLAYER-TEMP ,K-TEMP-HIGH-4>
					<COND
						(T ;<L? ,GL-TEMP-MSG ,K-TEMP-HIGH-4>
							<SETG GL-TEMP-MSG ,GL-PLAYER-TEMP>
							<TELL "	The heat becomes overpowering and you collapse.|">
							<RT-END-OF-GAME>
						)
					>
				)
				(<G=? ,GL-PLAYER-TEMP ,K-TEMP-HIGH-3>
					<COND
						(<L? ,GL-TEMP-MSG ,K-TEMP-HIGH-3>
							<SETG GL-TEMP-MSG ,GL-PLAYER-TEMP>
							<TELL
"	You're so hot you can hardly move. Your breathing speeds up dangerously." CR
							>
						)
					>
				)
				(<G=? ,GL-PLAYER-TEMP ,K-TEMP-HIGH-2>
					<COND
						(<L? ,GL-TEMP-MSG ,K-TEMP-HIGH-2>
							<SETG GL-TEMP-MSG ,GL-PLAYER-TEMP>
							<TELL "	Your face turns red from the heat." CR>
						)
					>
				)
				(<G=? ,GL-PLAYER-TEMP ,K-TEMP-HIGH-1>
					<COND
						(<L? ,GL-TEMP-MSG ,K-TEMP-HIGH-1>
							<SETG GL-TEMP-MSG ,GL-PLAYER-TEMP>
							<TELL "	You feel uncomfortably hot and begin to sweat." CR>
						)
					>
				)
				(<G? ,GL-PLAYER-TEMP ,K-TEMP-LOW-1>
					<COND
						(<L=? ,GL-TEMP-MSG ,K-TEMP-LOW-1>
							<SETG GL-TEMP-MSG ,GL-PLAYER-TEMP>
							<TELL
"	You stop shivering. Your body temperature must be back to normal." CR
							>
						)
					>
				)
				(<G? ,GL-PLAYER-TEMP ,K-TEMP-LOW-2>
					<COND
						(<L=? ,GL-TEMP-MSG ,K-TEMP-LOW-2>
							<SETG GL-TEMP-MSG ,GL-PLAYER-TEMP>
							<TELL
"	Your hands and feet tingle as they begin to warm up." CR
							>
						)
					>
				)
				(<G? ,GL-PLAYER-TEMP ,K-TEMP-LOW-3>
					<COND
						(<L=? ,GL-TEMP-MSG ,K-TEMP-LOW-3>
							<SETG GL-TEMP-MSG ,GL-PLAYER-TEMP>
							<TELL "	You're beginning to thaw out." CR>
						)
					>
				)
			>
		)
	>
>
 
<ROUTINE RT-I-DEEPCORE-TEMP ()
	<RT-QUEUE ,RT-I-DEEPCORE-TEMP <+ ,GL-MOVES 1>>
	<COND
		(,GL-HEATERS-ON
			<SETG GL-DEEPCORE-TEMP <+ ,GL-DEEPCORE-TEMP 5>>
		)
		(T
			<SETG GL-DEEPCORE-TEMP <- ,GL-DEEPCORE-TEMP 5>>
		)
	>
	<RFALSE>
>
 
<ROUTINE RT-I-TEMP ("AUX" L D1 D2)
	<SET L <LOC ,CH-PLAYER>>
	<RT-QUEUE ,RT-I-TEMP <+ ,GL-MOVES 1>>
	<COND
		(<FSET? .L ,FL-WATER>
			<COND
				(<OR	<AND
							<IN? ,TH-FBS-SUIT ,CH-PLAYER>
							<FSET? ,TH-FBS-SUIT ,FL-WORN>
						>
						<AND
							<IN? ,TH-DRY-SUIT ,CH-PLAYER>
							<FSET? ,TH-DRY-SUIT ,FL-WORN>
						>
					>
					<SETG GL-PLAYER-TEMP <- ,GL-PLAYER-TEMP 10>>
				)
				(T
					<SETG GL-PLAYER-TEMP <- ,GL-PLAYER-TEMP 500>>
				)
			>
		)
		(<AND <L? ,GL-PLAYER-TEMP ,K-TEMP-NOM>
				<G? ,GL-DEEPCORE-TEMP <- ,GL-PLAYER-TEMP 860>>
			>
			<SET D1 <- ,GL-DEEPCORE-TEMP <- ,GL-PLAYER-TEMP 860>>>
			<SET D2 <- ,K-TEMP-NOM ,GL-PLAYER-TEMP>>
			<COND
				(<AND <L=? .D2 .D1>
						<L=? .D2 5>
					>
					<SETG GL-PLAYER-TEMP ,K-TEMP-NOM>
				)
				(<G=? .D1 5>
					<SETG GL-PLAYER-TEMP <+ ,GL-PLAYER-TEMP 5>>
				)
				(T
					<SETG GL-PLAYER-TEMP <+ ,GL-PLAYER-TEMP .D1>>
				)
			>
		)
		(<AND <G? ,GL-PLAYER-TEMP ,K-TEMP-NOM>
				<L? ,GL-DEEPCORE-TEMP <- ,GL-PLAYER-TEMP 860>>
			>
			<SET D1 <- <- ,GL-PLAYER-TEMP 860> ,GL-DEEPCORE-TEMP>>
			<SET D2 <- ,GL-PLAYER-TEMP ,K-TEMP-NOM>>
			<COND
				(<AND <L=? .D2 .D1>
						<L=? .D2 5>
					>
					<SETG GL-PLAYER-TEMP ,K-TEMP-NOM>
				)
				(<G=? .D1 5>
					<SETG GL-PLAYER-TEMP <- ,GL-PLAYER-TEMP 5>>
				)
				(T
					<SETG GL-PLAYER-TEMP <- ,GL-PLAYER-TEMP .D1>>
				)
			>
		)
		(<G? ,GL-DEEPCORE-TEMP <+ ,GL-PLAYER-TEMP 600>>		;"+6 deg."
			<SETG GL-PLAYER-TEMP <+ ,GL-PLAYER-TEMP 5>>
		)
		(<L? ,GL-DEEPCORE-TEMP <- ,GL-PLAYER-TEMP 1200>>	;"-12 deg."
			<SETG GL-PLAYER-TEMP <- ,GL-PLAYER-TEMP 5>>
		)
	>
	<RT-TEMP-MSG>
>
 
;"***************************************************************************"
; "end of file"
;"***************************************************************************"
 
