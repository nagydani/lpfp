; Version for the TRS-80 Model 1 and Model III.
;
; Graphics are done with special graphics characters on the text screen
; for an effective 128 x 48 resolution.  Scaling down the Spectrum
; coordinates means stepping by 2 on the X axis and 4 on the Y.
;
; Suggest zmac to build and trs80gp to emulate.
;	http://48k.ca/zmac.html
;	http://48k.ca/trs80gp.html
;
; zmac trs80-m1.asm
; trs80gp zout\trs80-m1.bds
;

	ORG	$6000

scan:	di
	xor	a

	ld	hl,$3c00
	ld	b,8+2
rowlp:	ld	c,2
collp:	push	hl		; [ screen addr
	ld	e,2
	call	pix
	dec	c
	dec	c
	call	pix
	inc	c
	inc	c
	ld	a,b
	sub	4
	ld	b,a
	call	pix
	dec	c
	dec	c
	call	pix
	inc	c
	inc	c
	ld	a,b
	sub	4
	ld	b,a
	call	pix
	dec	c
	dec	c
	call	pix
	pop	hl		; screen addr ]
	ld	(hl),e
	inc	hl
	ld	a,b
	add	2*4
	ld	b,a
	ld	a,c
	add	3*2
	ld	c,a
	jr	nc,collp

	ld	a,b
	add	3*4
	ld	b,a
	cp	192
	jr	c,rowlp

done:	jr	done

pix:	push	bc		; [ XY
	push	de		; [ bit
	call	trace
	pop	de		; bit ]
	rl	e
	pop	bc		; XY ]
	ret

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
	INCLUDE "../faddsub-fast.asm"
	INCLUDE "../fsquare.asm"
	INCLUDE "../mul8bit.asm"
	INCLUDE "../fint64.asm"
	INCLUDE	"../dot.asm"
; Lookup tables
	INCLUDE "../addtab.asm"
	INCLUDE "../subtab.asm"
	INCLUDE	"../multab.asm"
	INCLUDE	"../divtab.asm"
	INCLUDE "../squaretab.asm"
; Variables
	INCLUDE	"variables.asm"

	end	scan
