; Look at a sphere
; Input: HL = scale factor of D to surface
; Output: CF color
; Pollutes: anything except IX
SPHEREL:EX	DE,HL
	CALL	SCALED
	CALL	SCALEDL
	CALL	HITRAY
	LD	L,(IX+6)
	LD	H,(IX+7)
	PUSH	HL	; *-N
	LD	DE,DX
	LD	A,3
	CALL	FDOT	; -N*D
	INC	H	; -2N*D
	LD	C,L
	LD	B,H
	LD	L,(IX+10)
	LD	H,(IX+11)
	CALL	FDIV	; -2N*D/NN
	EX	(SP),HL	; -L stacked, *PX = -*NX retrieved
	LD	C,(HL)
	INC	HL
	LD	B,(HL)
	INC	HL
	EX	(SP),HL	; -L restored, pointer stacked
	EX	DE,HL
	PUSH	DE	; -L stacked
	CALL	FMUL	; -L * -NX
	EX	DE,HL
	LD	HL,(DX)
	CALL	FSUB
	LD	(DX),HL
	POP	HL	; -L restored
	EX	(SP),HL	; -L stacked, pointer retrieved
	LD	C,(HL)
	INC	HL
	LD	B,(HL)
	INC	HL
	EX	(SP),HL	; -L restored, pointer stacked
	EX	DE,HL
	PUSH	DE	; -L stacked
	CALL	FMUL
	EX	DE,HL
	LD	HL,(DY)
	CALL	FSUB
	LD	(DY),HL
	POP	HL	; -L restored
	EX	(SP),HL	; -L stacked, pointer restored
	LD	C,(HL)
	INC	HL
	LD	B,(HL)
	POP	DE	; -L restored
	CALL	FMUL
	EX	DE,HL
	LD	HL,(DZ)
	CALL	FSUB
	LD	(DZ),HL
	JP	TRACEL

; Sphere intersection
; Output: CF = true if ray intersects sphere, HL = scale factor of D vector
; Pollutes: anything except IX
SPHEREI:LD	HL,(DX)
	PUSH	HL
	LD	HL,(DY)
	PUSH	HL
	LD	HL,(DZ)
	PUSH	HL	; save D
	LD	L,(IX+6)
	LD	H,(IX+7)
	LD	DE,PX
	PUSH	DE
	LD	BC,6
	LDIR
	POP	HL
	LD	DE,DX
	LD	A,3
	CALL	FDOT	; D * P
	AND	A
	BIT	7,H
	JR	NZ,RESTD	; sphere behind us
	LD	C,L
	LD	B,H
	LD	HL,(DD)
	CALL	FDIV
	PUSH	HL	; save P * D / DD
	EX	DE,HL
	CALL	SCALED
	LD	HL,(DX)
	LD	DE,(PX)
	CALL	FSUB
	CALL	FSQUARE
	PUSH	HL
	LD	HL,(DY)
	LD	DE,(PY)
	CALL	FSUB
	CALL	FSQUARE
	POP	DE
	CALL	FADDP
	PUSH	HL
	LD	HL,(DZ)
	LD	DE,(PZ)
	CALL	FSUB
	CALL	FSQUARE
	POP	DE
	CALL	FADDP
	LD	E,(IX+10)
	LD	D,(IX+11)
	OR	A
	SBC	HL,DE
	JR	C,SPHEREH
RESTD2:	POP	HL
	JR	RESTD
SPHEREH:ADD	HL,DE
	CALL	FSQRT	; CL
	LD	E,(IX+8)
	LD	D,(IX+9)
	EX	DE,HL
	CALL	FSQDIF
	CALL	FSQRT
	LD	C,L
	LD	B,H
	LD	HL,(DL)
	CALL	FDIV
	POP	DE	; P * D / DD
	EX	DE,HL
	CALL	FSUBP
	SCF
RESTD:	POP	DE
	LD	(DZ),DE
	POP	DE
	LD	(DY),DE
	POP	DE
	LD	(DX),DE
	RET
