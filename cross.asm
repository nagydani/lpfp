; Cross product of two 3D vectors
; In: IX,IY pointers to two multiplicands, HL pointer to result
; Out: HL=HL+5, BC=Cx, DE=Cz
; Pollutes: AF, AF'
FCROSS:	PUSH	HL		; target address
	LD	C,(IX+4)
	LD	B,(IX+5)
	LD	E,(IY+2)
	LD	D,(IY+3)
	CALL	FMUL		; Az * By
	PUSH	HL
	LD	C,(IX+2)
	LD	B,(IX+3)
	LD	E,(IY+4)
	LD	D,(IY+5)
	CALL	FMUL		; Ay * Bz
	POP	DE
	CALL	FSUB		; Ay * Bz - Az * By
	PUSH	HL		; Cx

	LD	C,(IX+0)
	LD	B,(IX+1)
	LD	E,(IY+4)
	LD	D,(IY+5)
	CALL	FMUL		; Ax * Bz
	PUSH	HL
	LD	C,(IX+4)
	LD	B,(IX+5)
	LD	E,(IY+0)
	LD	D,(IY+1)
	CALL	FMUL		; Az * Bx
	POP	DE
	CALL	FSUB		; Az * Bx - Ax * Bz
	PUSH	HL		; Cy

	LD	C,(IX+2)
	LD	B,(IX+3)
	LD	E,(IY+0)
	LD	D,(IY+1)
	CALL	FMUL		; Ay * Bx
	PUSH	HL
	LD	C,(IX+0)
	LD	B,(IX+1)
	LD	E,(IY+2)
	LD	D,(IY+3)
	CALL	FMUL		; Ax * By
	POP	DE
	CALL	FSUB		; Ax * By - Ay * Bx

	POP	DE		; Cy
	POP	BC		; Cx
	EX	(SP),HL	; Cz
	LD	(HL),C
	INC	HL
	LD	(HL),B
	INC	HL
	LD	(HL),E
	INC	HL
	LD	(HL),D
	POP	DE
	LD	(HL),E
	INC	HL
	LD	(HL),D
	RET
