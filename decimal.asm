; Note: The signs of mantissa and exponent are the
; same in binary and decimal representation, so
; these routines do not provide the latter. Display
; routines must insert these signs where appropriate.

; Decimal conversion for display (mantissa)
; In:
; DE = floating point number
; Out:
; C = decimal digit (possibly two) before point in binary
; A = two decimal digits after the point in BCD
; Pollutes: F, AF', BC, DE, HL
F2BCD:	LD	H,DECTAB/$100
	LD	L,D
	SLA	L
	LD	C,(HL)
	INC	L
	LD	B,(HL)
	CALL	FMULP
	LD	A,H
	SUB	$38
	LD	B,A
	LD	A,1
	LD	C,0
F2BCDL:	SLA	L
	ADC	A,A
	DDA
	JR	NC,F2BCD0
	INC	C
F2BCD0:	DJNZ	F2BCDL
	RET

; Decimal conversion for display (exponent)
; In: A = binary exponent
; Out: H = decimal exponent
; Pollutes: AF, AF', BC, DE, L
F2E10:	AND	$7F		; mask sign
	SUB	A,$40
	JR	NC,F2E10P	; positive exponent
	NEG
F2E10P:	LD	B,A
	LD	C,77		; $100 * log10(2)
	CALL	MUL8
	RET
