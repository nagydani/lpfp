	INCLUDE	"align.asm"
; Mantissas of squares
SQTAB:	DEFB	$00,$02,$04,$06,$08,$0A,$0C,$0E
	DEFB	$10,$12,$14,$16,$19,$1B,$1D,$1F
	DEFB	$21,$23,$25,$27,$2A,$2C,$2E,$30
	DEFB	$32,$34,$37,$39,$3B,$3D,$40,$42
	DEFB	$44,$46,$49,$4B,$4D,$4F,$52,$54
	DEFB	$56,$59,$5B,$5D,$60,$62,$64,$67
	DEFB	$69,$6B,$6E,$70,$73,$75,$77,$7A
	DEFB	$7C,$7F,$81,$84,$86,$89,$8B,$8E
	DEFB	$90,$93,$95,$98,$9A,$9D,$9F,$A2
	DEFB	$A4,$A7,$A9,$AC,$AF,$B1,$B4,$B6
	DEFB	$B9,$BC,$BE,$C1,$C4,$C6,$C9,$CC
	DEFB	$CE,$D1,$D4,$D6,$D9,$DC,$DF,$E1
	DEFB	$E4,$E7,$EA,$EC,$EF,$F2,$F5,$F7
	DEFB	$FA,$FD
; Squares from $6A, mantissa of sqrt(2)
	DEFB	$00,$01,$03,$04,$06,$07
	DEFB	$09,$0A,$0B,$0D,$0E,$10,$11,$13
	DEFB	$14,$16,$17,$19,$1A,$1C,$1D,$1F
	DEFB	$20,$22,$23,$25,$26,$28,$29,$2B
	DEFB	$2C,$2E,$2F,$31,$32,$34,$35,$37
	DEFB	$39,$3A,$3C,$3D,$3F,$40,$42,$44
	DEFB	$45,$47,$48,$4A,$4C,$4D,$4F,$50
	DEFB	$52,$54,$55,$57,$59,$5A,$5C,$5D
	DEFB	$5F,$61,$62,$64,$66,$67,$69,$6B
	DEFB	$6D,$6E,$70,$72,$73,$75,$77,$78
	DEFB	$7A,$7C,$7E,$7F,$81,$83,$85,$86
	DEFB	$88,$8A,$8C,$8D,$8F,$91,$93,$94
	DEFB	$96,$98,$9A,$9B,$9D,$9F,$A1,$A3
	DEFB	$A5,$A6,$A8,$AA,$AC,$AE,$AF,$B1
	DEFB	$B3,$B5,$B7,$B9,$BB,$BC,$BE,$C0
	DEFB	$C2,$C4,$C6,$C8,$CA,$CB,$CD,$CF
	DEFB	$D1,$D3,$D5,$D7,$D9,$DB,$DD,$DF
	DEFB	$E1,$E2,$E4,$E6,$E8,$EA,$EC,$EE
	DEFB	$F0,$F2,$F4,$F6,$F8,$FA,$FC,$FE

; Mantissas of square roots
SQRTAB:	DEFB	$00,$00,$01,$01,$02,$02,$03,$03
	DEFB	$04,$04,$05,$05,$06,$06,$07,$07
	DEFB	$08,$08,$09,$09,$0A,$0A,$0B,$0B
	DEFB	$0C,$0C,$0D,$0D,$0E,$0E,$0F,$0F
	DEFB	$10,$10,$10,$11,$11,$12,$12,$13
	DEFB	$13,$14,$14,$15,$15,$16,$16,$17
	DEFB	$17,$17,$18,$18,$19,$19,$1A,$1A
	DEFB	$1B,$1B,$1C,$1C,$1C,$1D,$1D,$1E
	DEFB	$1E,$1F,$1F,$20,$20,$20,$21,$21
	DEFB	$22,$22,$23,$23,$24,$24,$24,$25
	DEFB	$25,$26,$26,$27,$27,$27,$28,$28
	DEFB	$29,$29,$2A,$2A,$2A,$2B,$2B,$2C
	DEFB	$2C,$2D,$2D,$2D,$2E,$2E,$2F,$2F
	DEFB	$30,$30,$30,$31,$31,$32,$32,$33
	DEFB	$33,$33,$34,$34,$35,$35,$35,$36
	DEFB	$36,$37,$37,$37,$38,$38,$39,$39
	DEFB	$3A,$3A,$3A,$3B,$3B,$3C,$3C,$3C
	DEFB	$3D,$3D,$3E,$3E,$3E,$3F,$3F,$40
	DEFB	$40,$40,$41,$41,$42,$42,$42,$43
	DEFB	$43,$44,$44,$44,$45,$45,$46,$46
	DEFB	$46,$47,$47,$48,$48,$48,$49,$49
	DEFB	$49,$4A,$4A,$4B,$4B,$4B,$4C,$4C
	DEFB	$4D,$4D,$4D,$4E,$4E,$4E,$4F,$4F
	DEFB	$50,$50,$50,$51,$51,$52,$52,$52
	DEFB	$53,$53,$53,$54,$54,$55,$55,$55
	DEFB	$56,$56,$56,$57,$57,$58,$58,$58
	DEFB	$59,$59,$59,$5A,$5A,$5B,$5B,$5B
	DEFB	$5C,$5C,$5C,$5D,$5D,$5D,$5E,$5E
	DEFB	$5F,$5F,$5F,$60,$60,$60,$61,$61
	DEFB	$61,$62,$62,$63,$63,$63,$64,$64
	DEFB	$64,$65,$65,$65,$66,$66,$66,$67
	DEFB	$67,$68,$68,$68,$69,$69,$69,$6A
	DEFB	$6A,$6B,$6B,$6C,$6D,$6E,$6E,$6F
	DEFB	$70,$70,$71,$72,$72,$73,$74,$74
	DEFB	$75,$76,$77,$77,$78,$79,$79,$7A
	DEFB	$7B,$7B,$7C,$7D,$7D,$7E,$7F,$7F
	DEFB	$80,$81,$81,$82,$83,$83,$84,$85
	DEFB	$85,$86,$87,$87,$88,$89,$89,$8A
	DEFB	$8B,$8B,$8C,$8C,$8D,$8E,$8E,$8F
	DEFB	$90,$90,$91,$92,$92,$93,$94,$94
	DEFB	$95,$95,$96,$97,$97,$98,$99,$99
	DEFB	$9A,$9A,$9B,$9C,$9C,$9D,$9E,$9E
	DEFB	$9F,$9F,$A0,$A1,$A1,$A2,$A2,$A3
	DEFB	$A4,$A4,$A5,$A6,$A6,$A7,$A7,$A8
	DEFB	$A9,$A9,$AA,$AA,$AB,$AC,$AC,$AD
	DEFB	$AD,$AE,$AF,$AF,$B0,$B0,$B1,$B1
	DEFB	$B2,$B3,$B3,$B4,$B4,$B5,$B6,$B6
	DEFB	$B7,$B7,$B8,$B9,$B9,$BA,$BA,$BB
	DEFB	$BB,$BC,$BD,$BD,$BE,$BE,$BF,$BF
	DEFB	$C0,$C1,$C1,$C2,$C2,$C3,$C3,$C4
	DEFB	$C5,$C5,$C6,$C6,$C7,$C7,$C8,$C8
	DEFB	$C9,$CA,$CA,$CB,$CB,$CC,$CC,$CD
	DEFB	$CE,$CE,$CF,$CF,$D0,$D0,$D1,$D1
	DEFB	$D2,$D2,$D3,$D4,$D4,$D5,$D5,$D6
	DEFB	$D6,$D7,$D7,$D8,$D8,$D9,$DA,$DA
	DEFB	$DB,$DB,$DC,$DC,$DD,$DD,$DE,$DE
	DEFB	$DF,$DF,$E0,$E1,$E1,$E2,$E2,$E3
	DEFB	$E3,$E4,$E4,$E5,$E5,$E6,$E6,$E7
	DEFB	$E7,$E8,$E8,$E9,$EA,$EA,$EB,$EB
	DEFB	$EC,$EC,$ED,$ED,$EE,$EE,$EF,$EF
	DEFB	$F0,$F0,$F1,$F1,$F2,$F2,$F3,$F3
	DEFB	$F4,$F4,$F5,$F5,$F6,$F6,$F7,$F7
	DEFB	$F8,$F8,$F9,$F9,$FA,$FA,$FB,$FB
	DEFB	$FC,$FC,$FD,$FD,$FE,$FE,$FF,$FF
