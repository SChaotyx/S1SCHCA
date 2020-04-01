; Chaotyx Code is Starting
; -------------------------------------------------------------------------------------
; Subrutina Para la performance de Super Peel Out (codigo basado en Spindash de Sonic 2)
; Version: 1.8 ------------------------------------------------------------------------
; -------------------------------------------------------------------------------------

; ||||||||||||||| S U B R U T I N A |||||||||||||||||||||||||||||||||||||||||||||||||||

Sonic_SuperPeelOut:
	    tst.b	($FFFFFFDA).w        ; Sonic Esta en estado de SpeelOut
	    bne.s	Sonic_CheckSpeelOut  ; Afirmativo
	    cmpi.b	#7,$1C(a0)
	    bne.s	Return_PeelOut
	    move.b	($FFFFF603).w,d0	     ; read controller
	    andi.b	#$70,d0			         ; pressing A/B/C ?
	    beq.w	Return_PeelOut
	    beq.w   SpeelOutAnimUW
	    move.b	#$20,$1C(a0)
	    move.w	#$D1,d0			        ; Original Spindash Sound
		beq.w   SpeelDustUW
	    move.b	#2,($FFFFD1DC).w	    ; Set Spindash dust animation
	    jsr	(PlaySound_Special).l	; play Spindash Sound
	    addq.l	#4,sp
	    move.b	#1,($FFFFFFDA).w

SpeelOutAnimUW:                      ; Cambia la animacion super peel Out si esta bajo agua
	    btst	#6,$22(a0)		    ; is Sonic underwater?
	    beq.s	Return_PeelOut		; if not, branch
	    move.b	#$21,$1C(a0)		; set "SonAni_SpeelOutUW" Animation Underwater
SpeelDustUW:
        btst	#6,$22(a0)		    ; is Sonic underwater?
	    beq.s	Return_PeelOut		; if not, branch
	    move.b	#0,($FFFFD1DC).w

Return_PeelOut:
	    rts

Sonic_CheckSpeelOut:
	    move.b	($FFFFF602).w,d0	; read controller
	    btst	#0,d0			    ; check Up button
	    bne.w	SpeelOut_ResetScr
	    move.b	#$13,$16(a0)
	    move.b	#7,$17(a0)
	    move.b	#$1,$1C(a0)		    ; Usar Animacion "SonAni_Run"
	    addq.w	#5,$C(a0)		    ; $C(a0) is Y coordinate
	    move.b	#0,($FFFFFFDA).w
	    btst   	#6,$22(a0)			; is sonic Underwater?
	    bne.s	SpeelOut_SpeedsUW		; if no, branch

SpeelOut_Speeds:
		cmpi.b	#24,$1B(a0)
		ble.s   Cancel_SpeelOut
		cmpi.b	#36,$1B(a0)
		ble.s   @speed3
		cmpi.b	#52,$1B(a0)
		ble.s   @speed2
		cmpi.b	#60,$1B(a0)
		ble.s	@speed1
		rts
	@speed1:	
		move.w	#$C00,$14(a0)		; Get Normal Super Peel Out Speed
		bsr.s Loc_SpeelOut2
		rts
	@speed2:
		move.w	#$700,$14(a0)		; Get Reduced Super Peel Out Speed
		bsr.s Loc_SpeelOut2
		rts
	@speed3:
		move.w	#$500,$14(a0)		; Get Minimal Super Peel Out Speed
		bsr.s Loc_SpeelOut2
		rts
		
SpeelOut_SpeedsUW:
		cmpi.b	#24,$1B(a0)
		ble.s   Cancel_SpeelOut
		cmpi.b	#36,$1B(a0)
		ble.s   @speed2
		cmpi.b	#52,$1B(a0)
		ble.s   @speed1
		rts
	@speed1:
	    move.w	#$600,$14(a0)		; Get Normal UW Super Peel Out Speed
		bsr.s Loc_SpeelOut2
		rts
	@speed2:
	    move.w	#$400,$14(a0)		; Get Reduced UW Super Peel Out Speed
		bsr.s Loc_SpeelOut2
		rts
		 
Cancel_SpeelOut:
		rts

Loc_SpeelOut2:
		move.w	$14(a0),d0		; get inertia
		subi.w	#$800,d0		; subtract $800
		add.w	d0,d0			; double it
		andi.w	#$1F00,d0		; mask it against $1F00
		neg.w	d0			    ; negate it
		addi.w	#$2000,d0		; add $2000
		move.w	d0,($FFFFC904).w	; move to $C904
	    btst	#0,$22(a0)		; is sonic facing right?
	    beq.s	SpeelOut_Done    ; if not, branch
	    neg.w	$14(a0)			; negate inertia

SpeelOut_Done:
	    move.w	#$BC,d0			         ; Sonido Liberacion de Super Peel Out
	    clr.b	($FFFFD1DC).w	         ; Clear Dust Flag
	    jsr	(PlaySound_Special).l	 ; play it!

SpeelOut_ResetScr:
	    addq.l	#4,sp
	    cmpi.w	#$60,($FFFFF73E).w
	    beq.s	loc_1AD8CK
	    bhs.s	ScreenReset
	    addq.w	#4,($FFFFF73E).w

ScreenReset:
	    subq.w	#2,($FFFFF73E).w

loc_1AD8CK:
	    bsr.w	Sonic_LevelBound
	    bsr.w	Sonic_AnglePos
	    rts
; Fin de la Subrutina Super Peelout
; Chaotyx Code Finished