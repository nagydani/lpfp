; 8 bit unsigned integer multiplication
; In: B,C multiplicands
; Out: HL product
; Pollutes: AF,AF',BC,DE
MUL8:	LD	H,MULTAB/$100
	LD	A,B
	ADD	A,C
	RRA
	LD	L,A
	LD	E,(HL)
	INC	H
	LD	D,(HL)	; DE=((B+C)/2)^2
	PUSH	DE
	LD	A,B
	SUB	A,C
	JR	NC,NOSWAP
	NEG
	LD	C,B
	AND	A
NOSWAP:	RRA
	LD	L,A
	EX	AF,AF'	; save carry
	LD	D,(HL)
	DEC	H
	LD	E,(HL)	; DE=((B-C)/2)^2
	POP	HL
	AND	A
	SBC	HL,DE
	EX	AF,AF'	; load carry
	RET	NC
	LD	B,0
	ADD	HL,BC
	RET
