; Square norm of a vector
; Input: B = dimensions, HL = pointer to vector
; Output: HL = square norm
; Pollutes: AF, DE
FLEN:	LD	E,(HL)
	INC	HL
	LD	D,(HL)
	EX	DE,HL
	CALL	FSQUARE
	DJNZ	FLEN1
	RET
FLEN1:	PUSH	HL
	EX	DE,HL
	INC	HL
	CALL	FLEN
	EX	DE,HL
	POP	HL
	JP	FADDP

; Scalar multiplication of two vectors
; Input: A = dimensions, HL,DE = pointers to vectors
; Output: BC = dot product,
; Pollutes: HL,DE,AF,AF'
FDOT:	PUSH	AF
	LD	C,(HL)
	INC	HL
	LD	B,(HL)
	PUSH	HL
	EX	DE,HL
	LD	E,(HL)
	INC	HL
	LD	D,(HL)
	PUSH	HL
	CALL	FMUL
	LD	C,L
	LD	B,H
	POP	DE
	POP	HL
	POP	AF
	DEC	A
	RET	Z
	INC	HL
	INC	DE
	PUSH	BC
	CALL	FDOT
	LD	L,C
	LD	H,B
	POP	DE
	CALL	FADD
	LD	C,L
	LD	B,H
	RET
