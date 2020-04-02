; ----------------------------------------------------------------------------------------------------------------
; Subrutina para la performance de Double Jump (doble salto) original code Jumpdash mismo efecto pero hacia arriba
; ----------------------------------------------------------------------------------------------------------------
Sonic_DoubleJump:
        move.b	($FFFFF603).w,d0	     ; is A pressed? (part 1)
		andi.b	#$40,d0			         ; is A pressed? (part 2)
		beq.w	DoubleJump_End			 ; if not, branch
		tst.b	($FFFFFE2A).w		     ; was jumpdash flag set?
		bne.w	DoubleJump_End			 ; if yes, branch
		move.b	#1,($FFFFFE2A).w	     ; if not, set jumpdash flag
		move.b	#$A0,d0			         ; set jumpdash sound
		jsr	(PlaySound_Special).l	     ; play jumpdash sound
		bclr	#4,$22(a0)		         ; clear double jump flag
		move.w	#$600,d0		         ; set normal jumpdash speed
		btst	#6,$22(a0)		         ; is Sonic underwater?
		beq.s	DJ_Move		             ; if not, branch
		move.w	#$380,d0		         ; set underwater jumpdash speed

DJ_Move: 
        neg.w	d0			             ; if not, negate d0 (for jumping to the right)
		move.w	d0,$12(a0)		         ; move Sonic forward with the selected speed ($10(a0) = Sonic's X-velocity)
		

DoubleJump_End:
		rts				; return      
		
; End of function Sonic_DoubleJump