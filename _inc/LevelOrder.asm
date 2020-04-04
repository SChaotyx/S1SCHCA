; ---------------------------------------------------------------------------
; Level	order array
; ---------------------------------------------------------------------------
LevelOrder:
		; Green Hill Zone
		dc.b id_GHZ, 0	; Act 1
		dc.b id_GHZ, 1	; Act 2
		dc.b id_GHZ, 2	; Act 3

		; Marble Zone
		dc.b id_MZ, 0	; Act 1
		dc.b id_MZ, 1	; Act 2
		dc.b id_MZ, 2	; Act 3

		; Spring yard
		dc.b id_SYZ, 0	; Act 1
		dc.b id_SYZ, 1	; Act 2
		dc.b id_SYZ, 2	; Act 3

		; Labyrinth Zone
		dc.b id_LZ, 0	; Act 1
		dc.b id_LZ, 1	; Act 2
		dc.b id_LZ, 2	; Act 3

		; Star Ligth Zone
		dc.b id_SLZ, 0	; Act 1
		dc.b id_SLZ, 1	; Act 2
		dc.b id_SLZ, 2	; Act 3

		; Scrap Brain Zone
		dc.b id_SBZ, 0	; Act 1
		dc.b id_SBZ, 1	; Act 2
		dc.b id_LZ, 3	; Act 3

		; Final Zone
		dc.b id_SBZ, 2

		even