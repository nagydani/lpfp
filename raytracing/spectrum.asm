; This code is ZX Spectrum specific
	ORG	$C000		; Use uncontended memory
SCAN:	EXX
	PUSH	HL
	LD	HL,$5800
LP1:	DEC	HL
	LD	B,8
LP2:	PUSH	BC
	PUSH	HL
	LD	A,L
	ADD	A,A
	ADD	A,A
	ADD	A,A
	ADD	A,B
	DEC	A
	LD	C,A
	LD	A,H
	RRCA
	RRCA
	RRCA
	RRCA
	RR	L
	RRCA
	RR	L
	LD	A,L
	AND	$F8
	LD	L,A
	LD	A,H
	AND	7
	OR	L
	LD	B,A
	CALL	TRACE
	POP	HL
	RR	(HL)
	POP	BC
	DJNZ	LP2
	LD	A,H
	CP	$40
	JR	NC,LP1
	POP	HL
	EXX
	RET

SCENE:
GROUND:	DEFW	BALL1,GROUNDI,GROUNDL,GC
BALL1:	DEFW	BALL2,SPHEREI,SPHEREL,B1C,$3F33,$3E71	; r=0.6, r*r=0.36
BALL2:	DEFW	0,SPHEREI,SPHEREL,B2C,$3D9A,$3B48	; r=0.2, r*r=0.04
POS:	DEFB	3		; 3 positions
GROUNDC:DEFW	$BE33,$3F00,$0000	; -0.3, 0.5, 0
BALL1C:	DEFW	$BF33,$BE33,$4180	; -0.6, -0.3, 3
BALL2C:	DEFW	$3F33,$BF33,$4100	; 0.6, -0.6, 2
LIGHT:	DEFW	0,$C000,0
	INCLUDE	"trace.asm"
	LD	IX,SCENE
	CALL	SCENEI
	RET	NC
	INCLUDE "scene.asm"
	INCLUDE "ground.asm"
	INCLUDE "sphere.asm"
	INCLUDE	"hitray.asm"

; floating point constants
MINF:	EQU	$0000		; Positive epsilon, 2^-64 			5.421e-20
MAXF:	EQU	$7FFF		; Maximal floating point number 2^64-2^55	1.841e+19
ONEF:	EQU	$4000		; One						1.000e+00
ROOT2F:	EQU	$406A		; Square root of 2				1.414e+00
F7F:	EQU	$46FC		; $7F i.e. 127					1.270e+02

; Subroutines
	INCLUDE "../fdivmul.asm"
	INCLUDE "../faddsub.asm"
	INCLUDE "../fsquare.asm"
	INCLUDE "../mul8bit.asm"
	INCLUDE "../fint64.asm"
	INCLUDE	"../dot.asm"
; Lookup tables
	INCLUDE	"../multab.asm"
	INCLUDE	"../divtab.asm"
	INCLUDE "../squaretab.asm"
; Variables
	INCLUDE	"variables.asm"
