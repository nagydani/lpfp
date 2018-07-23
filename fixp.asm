; Convert floating point between -1.0 and +1.0 to signed integer between -127 and 127
; WARNING!!! Bounds not checked, does wreak havoc for out of bounds input.
; Input: DE = floating point number in the -1.0 .. +1.0 range
; Output: A = signed integer
; Pollutes: F,AF',BC,DE,HL
FFIX:	LD	BC,F7F
	CALL	FMUL
	LD	A,H
	ADD	A,A
	EX	AF,AF'	; Save sign to F'
	RES	7,H
	LD	A,$47
	SUB	H
	CP	8
	JR	NC,FFIX0
	LD	B,A
	LD	A,L
	SCF
FFIXL:	RRA
	OR	A
	DJNZ	FFIXL
	RRA
	ADC	A,B	; Proper rounding
	EX	AF,AF'
	JR	NC,FFIXP
	EX	AF,AF'
	NEG
	RET
FFIZP:	EX	AF,AF'
	RET
FFIX0:	XOR	A
	RET

; Convert floating point array as above
; In: HL = floating point array, DE = fixed point array, B = array size
; Pollutes: AF,AF',B,BC',DE,DE',HL,HL'
FFIXA:	LD	A,(HL)
	INC	HL
	EX	AF,AF'
	LD	A,(HL)
	INC	HL
	EXX
	LD	D,A
	EX	AF,AF'
	LD	E,A
	CALL	FFIX
	EXX
	LD	(DE),A
	INC	DE
	DJNZ	FFIXA
	RET

; Multiply two signed integers to be interpreted as above
; In: D,E = multiplicands
; Out: A = product
; Pollutes: F, HL
MULFIX:	LD	H,SIGSQRT/256
	LD	A,E
	ADD	A,D
	JP	PO,MULFIX1
	LD	L,A
	LD	A,(HL)
	LD	L,E
	SUB	A,(HL)
	LD	L,D
	SUB	A,(HL)
	RET
MULFIX1:LD	A,E
	SUB	A,D
	LD	L,A
	LD	A,(HL)
	NEG
	LD	L,E
	ADD	A,(HL)
	LD	L,D
	ADD	A,(HL)
	RET


