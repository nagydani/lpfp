; Raytracer
; Input: B = y coordinate from top, C = x coordinate from left
; Output: flag C = light

; Start ray
TRACE:	PUSH	BC
	LD	A,C
	CALL	FBYTE
	LD	HL,$C700	; -128
	CALL	FADD
	LD	(DX),HL
	POP	BC
	LD	A,B
	CALL	FBYTE
	LD	HL,$C680	; -96
	CALL	FADD
	LD	(DY),HL
	LD	HL,$482C	; +300
	LD	(DZ),HL
	LD	HL,DX
	LD	B,3
	CALL	FLEN
	LD	(DD),HL
	CALL	FSQRT
	LD	(DL),HL
	LD	A,(POS)
	LD	HL,GROUNDC
	LD	DE,GC
POSL:	LD	BC,6
	LDIR
	DEC	A
	JR	NZ,POSL
	LD	(BOUNCE),A
TRACEL:	LD	HL,BOUNCE
	DEC	(HL)
	RET	Z
