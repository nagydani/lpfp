; Look at the ground
; Input: HL = scale factor of D to surface
; Output: CF color
; Pollutes: anything except IX
GROUNDL:EX	DE,HL
	CALL	SCALED
	CALL	HITRAY
	LD	IX,BALL1
SHADOWS:LD	L,(IX+6)
	LD	H,(IX+7)
	LD	E,(HL)
	INC	HL
	LD	D,(HL)
	INC	HL
	INC	HL
	INC	HL
	EX	DE,HL
	CALL	FSQUARE
	PUSH	HL
	EX	DE,HL
	LD	E,(HL)
	INC	HL
	LD	D,(HL)
	EX	DE,HL
	CALL	FSQUARE
	POP	DE
	CALL	FADDP
	LD	E,(IX+10)
	LD	D,(IX+11)
	OR	A
	SBC	HL,DE
	CCF
	RET	NC
	LD	E,(IX+0)
	LD	D,(IX+1)
	PUSH	DE
	POP	IX
	LD	A,E
	OR	D
	JR	NZ,SHADOWS
GROUNDX:LD	HL,(GC)
	CALL	GRL0
	PUSH	AF
	LD	HL,(GC+4)
	CALL	GRL0
	POP	BC
	XOR	B
	RRCA
	RET

GRL0:	LD	A,H
	CP	$3F
	JR	C,GRL1
	ADD	A
	JR	NC,GRL1
	CP	$7D
	CCF
GRL1:	SBC	A,A
	RET

; Ground intersection
; Output: CF = true if ray intersects ground, HL = scale factor of D vector
; Pollutes: anything except IX
GROUNDI:LD	L,(IX+6)
	LD	H,(IX+7)
	INC	HL
	INC	HL
	LD	C,(HL)
	INC	HL
	LD	B,(HL)
	LD	HL,(DY)
	LD	A,B
	OR	H
	ADD	A,A
	CCF
	RET	NC
	CALL	FDIV
	SCF
	RET
