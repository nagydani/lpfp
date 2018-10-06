; Version for the TRS-80 Model 4 with hires graphics board.
;
; With the hires board the Model 4 is capable of 640 x 240 but this largely
; copies the Spectrum routine rendering at 256 x 240 and then doubling
; the pixels horizontally to correct the pixel aspect ratio.
;
; Need to do the full 640 pixels across and adjust the scene to better
; fix in the new viewport.
;
; Suggest zmac to build and trs80gp to emulate.
;	http://48k.ca/zmac.html
;	http://48k.ca/trs80gp.html
;
; zmac trs80-m4.asm
; trs80gp -m4c zout\trs80-m4.bds
;

	ORG	$6000

scan:	di
	xor	a
	out	($84),a
	out	($8d),a
	out	($8c),a
	ld	a,$b3		; X++ on write
	out	($83),a

	ld	b,239
rowlp:	ld	a,b
	out	($81),a
	ld	a,(80-64)/2
	out	($80),a
	ld	c,0

collp:	ld	e,1
bitlp:	push	de
	push	bc
	call	trace
	pop	bc
	inc	c
	pop	de
	rl	e
	rl	e
	jr	nc,bitlp

	ld	a,e
	srl	a
	or	e
	out	($82),a
	dec	c
	inc	c
	jr	nz,collp
	djnz	rowlp

done:	jr	done

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
