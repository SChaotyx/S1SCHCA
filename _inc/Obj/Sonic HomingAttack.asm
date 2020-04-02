; ---------------------------------------------------------------------------
; Subroutine Sonic_Homingattack
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

Sonic_Homingattack:
;      cmpi.b   #6,($FFFFFE57).w    ; comprobar sonic ha obtenido todas las esmeraldas
;	  beq.w    HomingAmove		   ; de ser asi habilitar homing attack ilimitado
;	  tst.b	   ($FFFFFFF1).w	   ; is demo mode on
;	  beq.s	   HA_Chkinvistars
;	  jmp	   HomingAmove
;HA_Chkinvistars:
;      tst.b	   ($FFFFFE2D).w       ; Comprobrar si sonic es invensible
;	  beq.w	   HA_ChkShield		   ; si no  lo es pasar a la siguiente Comprobacion
;	  jmp      HomingAmove         ; de ser asi habilitar homing attack
;HA_ChkShield:
;      tst.b	   ($FFFFFE2C).w       ; Comprobrar si sonic Ha Obtenido Escudo
;	  beq.w    Sonic_HA_rts		   ; si no lo es anular Homing attack
;HomingAmove:
      move.b   ($FFFFF603).w,d1   ; read controller
      andi.b   #$30,d1            ; is A, B r C pressed?
      beq.w    Sonic_HA_rts       ; if not, branch
      lea      ($FFFFD800).w,a1   ; start at the first level object RAM
	  bne.w    HA_enemylist
	  tst.b    ($FFFFFFD1).w      ; is Sonic chasing some object?
      bne.w    HA_Move            ; if yes, chase him
	  
; ---------------------------------------------------------------------------

HA_enemylist:
      tst.b   (a1)            ; is a Null object
      beq.s   HA_nextobject   ; if yes, branch
	  cmpi.b   #5,$20(a1)     ; is not an enemy object? (spring, explosion, platform, collected ring, flame thrower (SBZ), among others) 
      bcs.w   HA_nextobject   ; if yes, branch 
      cmpi.b   #$E,$20(a1)    ; is some enemy of the list above?
      bls.s   HA_calcdistance ; if yes, branch
      cmpi.b   #$46,$20(a1)   ; is the monitor? 
      beq.s   HA_calcdistance ; if yes, branch 
      cmpi.b   #$CC,$20(a1)   ; is Yadrin enemy (SYZ) 
      beq.s   HA_calcdistance ; if yes, branch 

HA_nextobject:
      adda.w  #$40,a1         ; jump to next object RAM entry
      cmpa.w  #$F000,a1      ; already tested all object RAM entry?
      blt.s   HA_enemylist   ; if not, return to enemy list
      rts

; ---------------------------------------------------------------------------

HA_calcdistance:   ; distance calculator
      move.w  8(a1),d1   ; move the object x-position to d1
      move.w  $C(a1),d2   ; move the object y-position to d2
      sub.w   8(a0),d1   ; sub sonic x-position of object x-position
      sub.w   $C(a0),d2   ; sub sonic y-position of object y-position
; ---------------------------------------------------------------------------

; test if the Sonic is facing the object
      btst    #0,$22(a0)   ; is sonic facing left?
      beq.s   HA_faceleft   ; if yes, branch
      cmpi.w  #8,d1      ; is distance of Sonic, less than 8 pixels of the object?
      blt.s   HA_calcdistance2   ; if yes, branch
      bra.s   HA_nextobject

HA_faceleft:
      cmpi.w  #-8,d1      ; is distance of Sonic, greater than -8 pixels of the object?
      bgt.s   HA_calcdistance2   ; if yes, branch
      bra.s   HA_nextobject
; end of test

; ---------------------------------------------------------------------------

HA_calcdistance2:      ; continuation of distance calculator
	  muls.w  d1,d1   ; horizontal distance squared
      muls.w  d2,d2   ; vertical distance squared
      add.l   d2,d1   ; add vertical distance to horizontal distance
      cmp.l   #16384,d1      ; is distance of Sonic, greater than or equal 128 pixels of the object? (128^2=16384 // $80^2=$4000)
      bge.s   HA_nextobject   ; if yes, don't execute the homing attack
	  move.w   #$BC,d0            ; set homing attack sound 
      jsr   (PlaySound).l         ; play homing attack sound
	  bclr   #4,$22(a0)         ; clear "uncontrolled jump" flag
	  move.b   #30,($FFFFFFD1).w   ; number of frames Sonic can chasing the object
      move.l   a1,($FFFFFFD2).w   ; save the object address that Sonic is chasing

; ---------------------------------------------------------------------------

HA_Move:
; Recalculating the distance between the Sonic and the object (d1 = x distance / d2 = y distance)
      move.w  8(a1),d1   ; move the object x-position to d1
      move.w  $C(a1),d2   ; move the object y-position to d2
      sub.w   8(a0),d1   ; sub sonic x-position of object x-position
      sub.w   $C(a0),d2   ; sub sonic y-position of object y-position
      movea.l   ($FFFFFFD2).w,a1   ; load the object address that Sonic is chasing
      subi.b   #1,($FFFFFFD1).w   ; sub 1 of frames counter
      tst.b   ($FFFFFFD1).w      ; the time to the Sonic chasing some object is over?
      beq.w   Sonic_HA_rts      ; if yes, don't make the Homing Attack
      jsr      (CalcAngle).l   ; calculates the angle
      jsr      (CalcSine).l   ; calculates the sine and the cosine
      muls.w  #$C,d1         ; multiply cosine by $C
      move.w  d1,$10(a0)      ; move d1 to X-velocity
      muls.w  #$C,d0         ; multiply sine by $C
      move.w  d0,$12(a0)      ; move d0 to Y-velocity
; ---------------------------------------------------------------------------

; Recalculating the distance between the Sonic and the object (d1 = x distance / d2 = y distance)
      move.w  8(a1),d1   ; move the object x-position to d1
      move.w  $C(a1),d2   ; move the object y-position to d2
      sub.w   8(a0),d1   ; sub sonic x-position of object x-position
      sub.w   $C(a0),d2   ; sub sonic y-position of object y-position
Sonic_HA_rts:
      rts                  ; return
; Command of Homingattack end here