; Convert 3D FP vector to octahedral map index
; Input: (BC,DE,HL) = 3D vector
; Output: A = octahedral map index
; Pollutes: F, AF',BC, BC', DE, DE', HL, HL'
V3D2O:	PUSH	HL
	PUSH	DE
	PUSH	BC
	RES	7,H
	RES	7,D
	CALL	FADDP
	LD	E,C
	LD	D,B
	RES	7,D
	CALL	FADDP
	POP	BC
	PUSH	HL
	CALL	FDIV
	EXX
	POP	HL
	POP	BC
	CALL	FDIV
	; Convert HL to lower nibble in A, leave HL intact
	LD	A,H
	AND	$7F
	SUB	$3D
	JR	NC,V3D2O0	; Too small, round to zero
	XOR	A
	JR	V3D2O2
V3D2O0:	CP	3
	JR	C,V3D2O1	; 1 or more
	LD	A,7
	JR	V3D2O2
V3D2O1:	INC	A
	LD	B,A
	LD	A,L
	AND	$F0
	INC	A
V3D2OL1:RLCA	;RRA
	DJNZ	V3D2OL1
	AND	$F	;$F0
	RRA			; Because there is no 0-step DJNZ
V3D2O2:	PUSH	AF
	EXX
	; Convert HL to upper nibble in A leave HL intact
	LD	A,H
	AND	$7F
	SUB	$3D
	JR	NC,V3D2O3	; Too small, round to zero
	XOR	A
	JR	V3D2O5
V3D2O3:	SUB	3
	JR	C,V3D2O4	; 1 or more
	LD	A,$70
	JR	V3D2O5
V3D2O4:	NEG
	INC	A
	LD	B,A
	LD	A,L
	AND	$F0
	SCF
V3D2OL2:RRA
	DJNZ	V3D2OL2
	AND	$F0
V3D2O5: POP	BC
	OR	B
	XOR	$88
	POP	BC
	BIT	7,B
	JR	Z,V3D2OU
	XOR	$77
	RLCA
	RLCA
	RLCA
	RLCA
V3D2OU:	BIT	7,H
	JR	Z,V3D2ON
	XOR	$F0
V3D2ON:	EXX
	BIT	7,H
	RET	Z
	XOR	$F
	RET
