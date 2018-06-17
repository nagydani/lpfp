; Subtract two floating-point numbers
; In: HL,DE numbers to subtract, no restrictions
; Out: HL = difference HL - DE
; Pollutes: AF,AF',BC,DE
FSUB:	LD	A,D
	XOR	$80
	LD	D,A	; DE = -DE
	; continue with FADD

; Add two floating-point numbers
; In: HL,DE numbers to add, no restrictions
; Out: HL = sum HL + DE
; Pollutes: AF,AF',BC,DE
FADD:	LD	B,H
	LD	C,D
	LD	A,B
	XOR	C
	ADD	A,A
	EX	AF,AF'
	RES	7,H
	RES	7,D
	CALL	FCPP
	JR	NC,FADDNS	; no swap
	EX	DE,HL
	LD	B,C
FADDNS:	EX	AF,AF'
	JR	C,FADDS
	CALL	FADDP
	JR	FADDHB
FADDS:	CALL	FSUBP
FADDHB:	LD	A,B
	AND	$80
	OR	H
	LD	H,A
	RET

; Compare two positive floating point numbers
; In: HL,DE numbers to compare
; Out: C flag if DE>HL, Z flag if DE=HL
; Pollutes: A
FCPP:	LD	A,H
	CP	D
	RET	NZ
	LD	A,L
	CP	E
	RET

; Add two positive floating-point numbers
; In: HL,DE numbers to add, HL >= DE
; Out: HL = sum HL + DE
; Pollutes: AF,DE
FADDP:	LD	A,H
	SUB	D
	JR	Z,FADD0		; same magnitude, cleared C flag
	CP	9
	JR	C,FADDL		; magnitude too different, just return the bigger number
	RET
FADDL0:	AND	A
FADDL:	RR	E
	DEC	A
	JR	NZ,FADDL0
	LD	A,L
	ADC	A,E		; rounding
	LD	L,A
	RET	NC
	SRL	A
FADD1:	ADC	A,0		; rounding
	LD	L,A
	INC	H
	BIT	7,H		; check overflow
	RET	Z
FINFTY:	LD	HL,MAXF		; positive maxfloat
	RET
FADD0:	LD	A,L
	ADD	A,E
	RRA
	JR	FADD1

; Subtract two positive floating-point numbers
; In: HL,DE numbers to subtract, HL >= DE
; Out: HL = difference HL - DE
; Pollutes: AF,DE
FSUBP:	LD	A,H
	SUB	D
	JR	Z,FSUB0		; same magnitude, cleared C flag
	CP	9
	RET	NC		; magnitude too different, just return the bigger number
FSUBL:	RR	E
	DEC	A
	JR	NZ,FSUBL
	LD	A,L
	SBC	A,E		; rounding
	LD	L,A
	JR	C,FSUBL2
	RET
FSUB0:	LD	A,L
	SUB	A,E
	JR	Z,FZERO
FSUBL2:	DEC	H
	BIT	7,H
	JR	NZ,FZERO
	ADD	A,A
	JR	NC,FSUBL2
	LD	L,A
	RET
