; Convert unsigned 8-bit integer into floating-point number
; In: A = byte to convert
; Out: DE = floating point representation
; Pollutes: AF
FBYTE:	OR	A
	JR	Z,FBYTE0	; zero converted to positive epsilon
	LD	D,$48
FBYTEL:	RLA
	DEC	D
	JR	NC,FBYTEL
	LD	E,A
	RET
FBYTE0:	LD	D,A
	LD	E,A
	RET

