Sound_D1toDF:				; XREF: Sound_ChkValue
		tst.b	$27(a6)
		bne.w	loc_722C6
		tst.b	4(a6)
		bne.w	loc_722C6
		tst.b	$24(a6)
		bne.w	loc_722C6
		movea.l	(Go_SoundIndex).l,a0
		subi.b	#$A1,d7
		bra SoundEffects_Common