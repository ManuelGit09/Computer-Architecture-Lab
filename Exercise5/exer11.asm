; ============================================================
; Exer11.asm - Machine Problem 1: Resistor Color Code
; Resistor drawing (brown-black-orange-gold = 10K ohm +/-5%) and the 0-9 color code chart.
;
; Uses INT 10h (video services):
;   AH=06h  scroll/clear window  -> paints a colored rectangle
;           (CH,CL)=top-left row,col  (DH,DL)=bottom-right row,col
;           BH = attribute = (background * 16) + foreground
;   AH=02h  set cursor position  -> DH=row, DL=column, BH=page 0
;   AX=1003h BL=0 -> background bit 7 = intensity (16 bg colors)
; and INT 21h AH=09h to print '$'-terminated strings (the text
; takes the color attribute of the rectangle it is printed on).
; Screen = 80 columns (0-79) x 25 rows (0-24).
; See Exer11_graph.png for the coordinate drawing.
; ============================================================

.MODEL SMALL
.STACK 100h

; ---- paint a rectangle: FILLBOX row1,col1,row2,col2,attribute ----
FILLBOX MACRO bRow1,bCol1,bRow2,bCol2,bClr
    MOV  AX, 0600h          ; AH=06h scroll window, AL=0 -> clear it
    MOV  BH, bClr
    MOV  CH, bRow1
    MOV  CL, bCol1
    MOV  DH, bRow2
    MOV  DL, bCol2
    INT  10h
ENDM

; ---- print a string at a position: TEXTAT row,col,string ----
TEXTAT MACRO pRow,pCol,pMsg
    MOV  AH, 02h            ; set cursor position
    MOV  BH, 00h
    MOV  DH, pRow
    MOV  DL, pCol
    INT  10h
    MOV  AH, 09h            ; display string
    MOV  DX, OFFSET pMsg
    INT  21h
ENDM

.DATA
    m01  DB 'RESISTOR COLOR CODE CHART','$'
    m02  DB 'BROWN','$'
    m03  DB 'BLACK','$'
    m04  DB 'ORANGE','$'
    m05  DB 'GOLD','$'
    m06  DB '1','$'
    m07  DB '0','$'
    m08  DB 'x1K','$'
    m09  DB '5%','$'
    m10  DB '10K OHM +/-5%','$'
    m11  DB 'DIGIT','$'
    m12  DB 'COLOR','$'
    m13  DB 'MULTIPLIER','$'
    m14  DB '0','$'
    m15  DB 'BLACK','$'
    m16  DB 'x1','$'
    m17  DB '1','$'
    m18  DB 'BROWN','$'
    m19  DB 'x10','$'
    m20  DB '2','$'
    m21  DB 'RED','$'
    m22  DB 'x100','$'
    m23  DB '3','$'
    m24  DB 'ORANGE','$'
    m25  DB 'x1,000 (1K)','$'
    m26  DB '4','$'
    m27  DB 'YELLOW','$'
    m28  DB 'x10,000 (10K)','$'
    m29  DB '5','$'
    m30  DB 'GREEN','$'
    m31  DB 'x100,000 (100K)','$'
    m32  DB '6','$'
    m33  DB 'BLUE','$'
    m34  DB 'x1,000,000 (1M)','$'
    m35  DB '7','$'
    m36  DB 'VIOLET','$'
    m37  DB 'x10,000,000 (10M)','$'
    m38  DB '8','$'
    m39  DB 'GRAY','$'
    m40  DB 'x100,000,000','$'
    m41  DB '9','$'
    m42  DB 'WHITE','$'
    m43  DB 'x1,000,000,000','$'
    m44  DB 'BROWN-BLACK-ORANGE-GOLD = 10K OHM +/-5%','$'

.CODE
START:
    MOV  AX, @DATA
    MOV  DS, AX

    MOV  AX, 1003h          ; bit 7 = intensity (not blink)
    MOV  BL, 00h
    INT  10h

    ; ---- screen background: white on black ----
    FILLBOX 0,0,24,79,0Fh

    ; Title bar: rows 0-2, cols 0-79, bg BLUE / fg WHITE
    FILLBOX 0,0,2,79,1Fh
    ; text "RESISTOR COLOR CODE CHART" at row 1, col 27
    TEXTAT  1,27,m01
    ; Left lead: rows 6-6, cols 8-17, bg LT.GRAY / fg LT.GRAY
    FILLBOX 6,8,6,17,77h
    ; Right lead: rows 6-6, cols 62-71, bg LT.GRAY / fg LT.GRAY
    FILLBOX 6,62,6,71,77h
    ; Resistor body: rows 4-8, cols 18-61, bg LT.CYAN / fg LT.CYAN
    FILLBOX 4,18,8,61,0BBh
    ; Band 1 BROWN: rows 4-8, cols 24-26, bg BROWN / fg BROWN
    FILLBOX 4,24,8,26,66h
    ; Band 2 BLACK: rows 4-8, cols 31-33, bg BLACK / fg BLACK
    FILLBOX 4,31,8,33,00h
    ; Band 3 ORANGE: rows 4-8, cols 38-40, bg LT.RED / fg LT.RED
    FILLBOX 4,38,8,40,0CCh
    ; Band 4 GOLD (tolerance): rows 4-8, cols 52-54, bg YELLOW / fg YELLOW
    FILLBOX 4,52,8,54,0EEh
    ; text "BROWN" at row 3, col 23
    TEXTAT  3,23,m02
    ; text "BLACK" at row 3, col 30
    TEXTAT  3,30,m03
    ; text "ORANGE" at row 3, col 36
    TEXTAT  3,36,m04
    ; text "GOLD" at row 3, col 51
    TEXTAT  3,51,m05
    ; text "1" at row 9, col 25
    TEXTAT  9,25,m06
    ; text "0" at row 9, col 32
    TEXTAT  9,32,m07
    ; text "x1K" at row 9, col 38
    TEXTAT  9,38,m08
    ; text "5%" at row 9, col 52
    TEXTAT  9,52,m09
    ; text "10K OHM +/-5%" at row 10, col 33
    TEXTAT  10,33,m10
    ; Chart backdrop: rows 11-22, cols 9-70, bg DK.GRAY / fg WHITE
    FILLBOX 11,9,22,70,8Fh
    ; text "DIGIT" at row 11, col 14
    TEXTAT  11,14,m11
    ; text "COLOR" at row 11, col 22
    TEXTAT  11,22,m12
    ; text "MULTIPLIER" at row 11, col 48
    TEXTAT  11,48,m13
    ; Digit 0 BLACK: rows 12-12, cols 11-68, bg BLACK / fg WHITE
    FILLBOX 12,11,12,68,0Fh
    ; text "0" at row 12, col 14
    TEXTAT  12,14,m14
    ; text "BLACK" at row 12, col 22
    TEXTAT  12,22,m15
    ; text "x1" at row 12, col 48
    TEXTAT  12,48,m16
    ; Digit 1 BROWN: rows 13-13, cols 11-68, bg BROWN / fg WHITE
    FILLBOX 13,11,13,68,6Fh
    ; text "1" at row 13, col 14
    TEXTAT  13,14,m17
    ; text "BROWN" at row 13, col 22
    TEXTAT  13,22,m18
    ; text "x10" at row 13, col 48
    TEXTAT  13,48,m19
    ; Digit 2 RED: rows 14-14, cols 11-68, bg RED / fg WHITE
    FILLBOX 14,11,14,68,4Fh
    ; text "2" at row 14, col 14
    TEXTAT  14,14,m20
    ; text "RED" at row 14, col 22
    TEXTAT  14,22,m21
    ; text "x100" at row 14, col 48
    TEXTAT  14,48,m22
    ; Digit 3 ORANGE: rows 15-15, cols 11-68, bg LT.RED / fg BLACK
    FILLBOX 15,11,15,68,0C0h
    ; text "3" at row 15, col 14
    TEXTAT  15,14,m23
    ; text "ORANGE" at row 15, col 22
    TEXTAT  15,22,m24
    ; text "x1,000 (1K)" at row 15, col 48
    TEXTAT  15,48,m25
    ; Digit 4 YELLOW: rows 16-16, cols 11-68, bg YELLOW / fg BLACK
    FILLBOX 16,11,16,68,0E0h
    ; text "4" at row 16, col 14
    TEXTAT  16,14,m26
    ; text "YELLOW" at row 16, col 22
    TEXTAT  16,22,m27
    ; text "x10,000 (10K)" at row 16, col 48
    TEXTAT  16,48,m28
    ; Digit 5 GREEN: rows 17-17, cols 11-68, bg GREEN / fg WHITE
    FILLBOX 17,11,17,68,2Fh
    ; text "5" at row 17, col 14
    TEXTAT  17,14,m29
    ; text "GREEN" at row 17, col 22
    TEXTAT  17,22,m30
    ; text "x100,000 (100K)" at row 17, col 48
    TEXTAT  17,48,m31
    ; Digit 6 BLUE: rows 18-18, cols 11-68, bg BLUE / fg WHITE
    FILLBOX 18,11,18,68,1Fh
    ; text "6" at row 18, col 14
    TEXTAT  18,14,m32
    ; text "BLUE" at row 18, col 22
    TEXTAT  18,22,m33
    ; text "x1,000,000 (1M)" at row 18, col 48
    TEXTAT  18,48,m34
    ; Digit 7 VIOLET: rows 19-19, cols 11-68, bg MAGENTA / fg WHITE
    FILLBOX 19,11,19,68,5Fh
    ; text "7" at row 19, col 14
    TEXTAT  19,14,m35
    ; text "VIOLET" at row 19, col 22
    TEXTAT  19,22,m36
    ; text "x10,000,000 (10M)" at row 19, col 48
    TEXTAT  19,48,m37
    ; Digit 8 GRAY: rows 20-20, cols 11-68, bg LT.GRAY / fg BLACK
    FILLBOX 20,11,20,68,70h
    ; text "8" at row 20, col 14
    TEXTAT  20,14,m38
    ; text "GRAY" at row 20, col 22
    TEXTAT  20,22,m39
    ; text "x100,000,000" at row 20, col 48
    TEXTAT  20,48,m40
    ; Digit 9 WHITE: rows 21-21, cols 11-68, bg WHITE / fg BLACK
    FILLBOX 21,11,21,68,0F0h
    ; text "9" at row 21, col 14
    TEXTAT  21,14,m41
    ; text "WHITE" at row 21, col 22
    TEXTAT  21,22,m42
    ; text "x1,000,000,000" at row 21, col 48
    TEXTAT  21,48,m43
    ; text "BROWN-BLACK-ORANGE-GOLD = 10K OHM +/-5%" at row 24, col 20
    TEXTAT  24,20,m44

    ; ---- park the cursor and wait for a key ----
    MOV  AH, 02h
    MOV  BH, 00h
    MOV  DH, 24
    MOV  DL, 00h
    INT  10h
    MOV  AH, 08h
    INT  21h

    ; ---- restore blink mode and clear the screen ----
    MOV  AX, 1003h
    MOV  BL, 01h
    INT  10h
    FILLBOX 0,0,24,79,07h
    MOV  AH, 02h
    MOV  BH, 00h
    MOV  DX, 0000h
    INT  10h

    MOV  AH, 4Ch            ; terminate program
    INT  21h
END START