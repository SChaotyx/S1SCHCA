; ---------------------------------------------------------------------------
; Subroutine allowing Sonic to jump
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_Jump:				; XREF: Obj01_MdNormal; Obj01_MdRoll
		move.b	($FFFFF603).w,d0
		andi.b	#$70,d0		; is A,	B or C pressed?
		beq.w	locret_1348E	; if not, branch
		moveq	#0,d0
		move.b	$26(a0),d0
		addi.b	#$80,d0
		bsr.w	sub_14D48
		cmpi.w	#6,d1
		blt.w	locret_1348E
		move.w	#$680,d2
		btst	#6,$22(a0)
		beq.s	loc_1341C
		move.w	#$380,d2

loc_1341C:
		moveq	#0,d0
		move.b	$26(a0),d0
		subi.b	#$40,d0
		jsr	(CalcSine).l
		muls.w	d2,d1
		asr.l	#8,d1
		add.w	d1,$10(a0)	; make Sonic jump
		muls.w	d2,d0
		asr.l	#8,d0
		add.w	d0,$12(a0)	; make Sonic jump
		bset	#1,$22(a0)
		bclr	#5,$22(a0)
		addq.l	#4,sp
		move.b	#1,$3C(a0)
		clr.b	$38(a0)
		move.w	#$A0,d0
		jsr	(PlaySound_Special).l ;	play jumping sound
		move.b	#$13,$16(a0)
		move.b	#9,$17(a0)
		btst	#2,$22(a0)
		bne.s	loc_13490
		move.b	#$E,$16(a0)
		move.b	#7,$17(a0)
		move.b	#2,$1C(a0)	; use "jumping"	animation
		bset	#2,$22(a0)
		addq.w	#5,$C(a0)

locret_1348E:
		rts	
; ===========================================================================

loc_13490:
		bset	#4,$22(a0)
		rts	
; End of function Sonic_Jump