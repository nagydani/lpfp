; Add two positive floating-point numbers
; In: HL,DE numbers to add
; Out: HL = sum HL + DE
; Pollutes: AF,DE
FADDP:	LD	A,H
	SUB	D
	JR	NC,FADDPL
	EX	DE,HL
	NEG
FADDPL:	JR	Z,FADD0	; same magnitude
	CP	10
	RET	NC	; magnitude too different, just return the bigger number
	ADD	A,ADDTAB/$100 - 1
	LD	D,A
	LD	A,(DE)
	OR	A
	JR	Z,FADD2
	ADD	A,L
	LD	L,A
	RET	NC
	SRL	A
FADD1:	ADC	A,0
	LD	L,A
	INC	H
	BIT	7,H	; check overflow
	RET	Z
FINFTY:	LD	HL,MAXF	; positive maxfloat
	RET
FADD2:	LD	E,A
FADD0:	LD	A,L
	ADD	A,E
	RRA
	JR	FADD1


; Round towards zero
; In: HL any floating-point number
; Out: HL same number rounded towards zero
; Pollutes: AF,B
FINT:	LD	A,H
	AND	$7F
	SUB	$40
	JR	C,FZERO	; Completely fractional
FINT2:	SUB	8
	RET	NC	; Already integer
	NEG
	AND	7
	JR	Z,FINT0
	LD	B,A
	LD	A,$FF
FINTL:	ADD	A,A
	DJNZ	FINTL
	AND	L
FINT0:	LD	L,A
	RET
FZERO:	LD	HL,MINF
	RET

; Fractional part, remainder after division by 1
; In: HL any floating-point number
; Out: HL fractional part, with sign intact
; Pollutes: AF,AF',BC,DE
FRAC:	LD	A,H
	AND	$7F
	SUB	$40
	RET	C	; Pure fraction
	PUSH	HL
	CALL	FINT2
	EX	DE,HL
	POP	HL
	JR	FSUB

; Remainder after division
; In: BC dividend, HL modulus
; Out: HL remainder
; Pollutes: AF,AF',BC,DE
FMOD:	PUSH	BC	; Stack: dividend
	PUSH	HL	; Stack: dividend, modulus
	CALL	FDIV
	CALL	FINT	; integer ratio
	EX	DE,HL	; DE = int(BC/HL)
	POP	BC	; Stack: dividend; BC = modulus
	CALL	FMUL	; Stack: dividend
	EX	DE,HL
	POP	HL
	; continue with FSUB

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

; Subtract two positive floating-point numbers
; In: HL,DE numbers to subtract, HL >= DE
; Out: HL = difference HL - DE
; Pollutes: AF,DE
FSUBP:	LD	A,H
	SUB	D
	JR	Z,FSUB0		; same magnitude, cleared C flag
	CP	10
	RET	NC		; magnitude too different, just return the bigger number
	ADD	A,ADDTAB/$100 - 1
	LD	D,A
	LD	A,(DE)
	OR	A
	JR	Z,FSUB2
	LD	E,A
	LD	A,L
	SUB	A,E
	LD	L,A
	RET	NC
FSUB2:	LD	A,L
	OR	A
	JR	Z,FZERO3
FSUBL2:	LD	D,H
	LD	H,SUBTAB/$100 + 1
	LD	A,(HL)
	DEC	H
	LD	L,(HL)
	ADD	A,D
	JR	NC,FZERO2	; underflow
	LD	H,A
	RET
FSUB0:	LD	A,L
	SUB	A,E
	LD	L,A
	JR	NZ,FSUBL2
FZERO3:	LD	H,L
	RET

; Return epsilon
FZERO2:	LD	HL,MINF
	RET
