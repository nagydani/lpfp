; Square of a floating-point number
; In: HL = number to square
; Out: HL = HL * HL
; Pollutes: AF
FSQUARE:LD	A,ROOT2F - $4001
	CP	L
	LD	A,H
	ADC	A,A
	SUB	A,$40
	JR	C,FZERO
	JP	M,FINFTY		; overflow
	LD	H,SQTAB/$100
	LD	L,(HL)
	LD	H,A
	RET

; Square root of a positive floating-point number
FSQRT:	LD	A,H
	SUB	$40
	SRA	A
	LD	H,SQRTAB/$100
	JR	NC,FSQRT1
	INC	H
FSQRT1:	ADD	$40
	LD	L,(HL)
	LD	H,A
	RET
