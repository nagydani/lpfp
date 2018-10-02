; Look at object hit
; Input: HL distance of hitting, IX = object hit
; Pollutes: anything
SCENEL:	LD	E,(IX+4)
	LD	D,(IX+5)
	PUSH	DE
	RET

; Intersection with scenery
; Input: IX = first object in scenery
; Output: CF = true if any object is hit by ray, HL = distance of hitting, IX = object hit
; Pollutes: anything
SCENEI:	LD	HL,0
	LD	(NEAREST),HL
	LD	IX,SCENE
SCLOOP:	LD	L,(IX+2)
	LD	H,(IX+3)
	CALL	JPHL
	JR	NC,NOHITS
	LD	DE,(NEAREST)
	LD	A,E
	OR	D
	JR	Z,HITS
	LD	DE,(DIST)
	OR	A
	SBC	HL,DE		; This is okay, as scaling factor is non-negative
	JR	NC,NOHITS
	ADD	HL,DE
HITS:	LD	(DIST),HL
	LD	(NEAREST),IX
NOHITS:	LD	E,(IX+0)
	LD	D,(IX+1)
	LD	A,D
	OR	E
	JR	Z,HITSC
	PUSH	DE
	POP	IX
	JR	SCLOOP
JPHL:	JP	(HL)
HITSC:	LD	HL,(NEAREST)
	LD	A,H
	OR	L
	RET	Z
	PUSH	HL
	POP	IX
	LD	HL,(DIST)
	SCF
	RET

