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

