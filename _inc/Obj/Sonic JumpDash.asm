; ---------------------------------------------------------------------------
; Subroutine to perform a Jumpdash
; ---------------------------------------------------------------------------

Sonic_JumpDash:
;        cmpi.b	#6,($FFFFFE57).w    ; sonic ha obtenido todas las esmeraldas?
;		beq.w   jumpdashmove		; de ser asi jumpdash ilimitado
;		tst.b	($FFFFFFF1).w		; is demo mode on?
;		beq.s	JD_ChkInvistars		; if not, branch
;		jmp	JumpdashMove			; jump to JumpdashMove
;JD_ChkInvistars:
;        tst.b	($FFFFFE2D).w       ; Comprobrar si sonic es invensible
;		beq.w	JD_ChkShield		; if not, branch
;		jmp	JumpdashMove		    ; jump to JumpdashMove
;JD_ChkShield:
;        tst.b	($FFFFFE2C).w       ; Comprobrar si sonic Ha Obtenido Escudo
;		beq.w	JD_End				; if not, branch
;JumpdashMove:      
		move.b	($FFFFF603).w,d0	; is ABC pressed? (part 1)
		andi.b	#$30,d0			; is ABC pressed? (part 2)
		beq.w	JD_End			; if not, branch
		tst.b	($FFFFFFEB).w		; was jumpdash flag set?
		bne.w	JD_End			; if yes, branch
		move.b	#1,($FFFFFFEB).w	; if not, set jumpdash flag
		move.b	#$BC,d0			; set jumpdash sound
		jsr	(PlaySound_Special).l	; play jumpdash sound
		bclr	#4,$22(a0)		; clear double jump flag
		move.w	#$A00,d0		; set normal jumpdash speed
		tst.b	($FFFFFE2E).w		; do you have speed shoes?
		beq.s	JD_ChkUW		; if not, branch
		move.w	#$B00,d0		; set speed shoes jumpdash speed

JD_ChkUW:
		btst	#6,$22(a0)		; is Sonic underwater?
		beq.s	JD_ChkDirection		; if not, branch
		move.w	#$600,d0		; set underwater jumpdash speed

JD_ChkDirection:
		btst	#0,$22(a0)		; is sonic facing left?
		beq.s	JD_Move			; if yes, branch
		neg.w	d0			; if not, negate d0 (for jumping to the right)

JD_Move:
		move.w	d0,$10(a0)		; move Sonic forward with the selected speed ($10(a0) = Sonic's X-velocity)
		clr.w	$12(a0)			; clear Sonic's Y-velocity to move sonic directly down

JD_End:
		rts				; return
; End of function Sonic_JumpDash