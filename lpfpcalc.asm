; Low-Precision Floating-Point Arithmetics
; (C) 2018 ePoint Systems, Daniel A. Nagy
;
; Numbers are represented in 16 bits as follows:
; bits 0..7	mantissa bits -8..-1, mantissa bit 0 is always 1, not represented
; bits 8..14	exponent bits 0..6, representing shifts in the 2^-64..2^+63 range
; bit 15	sign  0 for positive, 1 for negative
;
; Notes:
; For positive numbers, the ordering is the same as that of integer interpretation.
; No special values such as 0, Inf, NaN.

; floating point constants
MINF:	EQU	$0000		; Positive epsilon, 2^-64 			5.421e-20
MAXF:	EQU	$7FFF		; Maximal floating point number 2^64-2^55	1.841e+19
ONEF:	EQU	$4000		; One						1.000e+00
ROOT2F:	EQU	$406A		; Square root of 2				1.414e+00

; Subroutines
	INCLUDE "fdivmul.asm"
	INCLUDE "faddsub.asm"
	INCLUDE "fsquare.asm"
	INCLUDE "mul8bit.asm"
	INCLUDE "fint64.asm"
	INCLUDE	"decimal.asm"
; Lookup tables
	INCLUDE	"multab.asm"
	INCLUDE	"divtab.asm"
	INCLUDE "squaretab.asm"
	INCLUDE	"dectab.asm"
