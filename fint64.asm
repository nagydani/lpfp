; Convert unsigned 8-bit integer into floating-point number
; In: A = byte to convert
; Out: DE = floating point representation
; Pollutes: AF
FBYTE:	OR	A
	JR	Z,FBYTE0	; zero converted to positive epsilon
	LD	D,$48
FBYTEL:	RLA
	DEC	D
	JR	NC,FBYTEL
	LD	E,A
	RET
FBYTE0:	LD	D,A
	LD	E,A
	RET

; Convert positive floating-point number to 64 bit LSB-first integer (always possible)
; The target array must be cleared before calling
; In: DE - floating point number, HL - pointer to integer (not crossing 256-byte boundaries)
; Out: Non-zero bytes of integer array updated
; Pollutes: AF, BC
INT64:	LD	A,D
	SUB	$48
	JR	C,INT64H	; there is a fractional part
	RRA
	RRA
	RRA
	AND	$1F
	ADD	L
	LD	L,A
	LD	A,D
	AND	7
	LD	C,E
	LD	B,1
	JR	Z,INT648	; exponent multiple of 8
INT64L:	RL	C
	RL	B
	DEC	A
	JR	NZ,INT64L
INT648:	LD	(HL),C
	INC	L
	LD	(HL),B
	RET
INT64H:	CP	-8
	RET	C		; smaller than 1
	JR	Z,INT641	; one
	LD	C,E
	SCF
INT64R:	RR	C
	AND	A
	INC	A
	JR	NZ,INT64R
	LD	(HL),C
	RET
INT641:	LD	(HL),1
	RET

; Convert 64 bit LSB-first integer to floating-point number
; In: HL pointing to MSB
; Out: BC = floating point representation
; Pollutes: AF,AF',HL
INT64F:	LD	A,$7F
	EX	AF,AF'
	XOR	A
	LD	B,8
INT64FL:OR	(HL)
	JR	NZ,INT64F0
	DEC	L
	EX	AF,AF'
	SUB	A,8
	EX	AF,AF'
	DJNZ	INT64FL
	LD	BC,0
	RET
INT64F0:DJNZ	INT64F2
INT64FB:ADD	A,A
	JR	C,INT64F1
	EX	AF,AF'
	DEC	A
	EX	AF,AF'
	JR	INT64FB		; use JP for speed
INT64F2:DEC	L
	LD	C,(HL)
INT64FD:RL	C
	RLA
	JR	C,INT64F1
	EX	AF,AF'
	DEC	A
	EX	AF,AF'
	JR	INT64FD		; use JP for speed
INT64F1:LD	C,A
	EX	AF,AF'
	LD	B,A
	RET

; Calculate the remainder of a 64 bit LSB-first integer
; after division by a floating point number
; In: HL pointing to byte AFTER the MSB of the number, DE divisor
; Out: array containing the remainder
; Pollutes: AF,AF',C,E,HL
MOD64:	LD	A,$40
	EX	AF,AF'
MOD64N:	DEC	L
	LD	A,E
	LD	E,0
	SCF
	EX	AF,AF'
MOD64L:	DEC	A
	CP	$48
	JR	C,MOD648	; too small, last 8 bits
	EX	AF,AF'
	RRA
	RR	E
	OR	A
	JR	Z,MOD64N
	CP	(HL)
	JR	NC,MOD64S
	JR	NZ,MOD64S
	DEC	L
	LD	C,A
	LD	A,(HL)
	SUB	E
	LD	(HL),A
	INC	L
MOD64C:	LD	A,(HL)
	SUB	C
	LD	(HL),A
	LD	A,C
MOD64S:	EX	AF,AF'
	CP	D
	JR	NZ,MOD64L
	RET
MOD648:	EX	AF,AF'
	RRA
	OR	A
	JR	Z,MOD64N
	CP	(HL)
	JR	NC,MOD64S
	JR	NZ,MOD64S
	LD	C,A
	JR	MOD64C
