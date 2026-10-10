; ============================================================
; Exer12.asm - Machine Problem 2: Personal LOGO
; Nested color layers with a block-letter 'ML' monogram, name and motto.
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
; See Exer12_graph.png for the coordinate drawing.
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
    m01  DB 'LOGO DESIGN - INT 10H','$'
    m02  DB 'ENGINEERING','$'
    m03  DB 'MANUEL R. LATAYAN','$'
    m04  DB 'PROUD TO BE AN ENGINEER','$'
    m05  DB 'EXER12.ASM','$'

.CODE
START:
    MOV  AX, @DATA
    MOV  DS, AX

    MOV  AX, 1003h          ; bit 7 = intensity (not blink)
    MOV  BL, 00h
    INT  10h

    ; ---- screen background: white on black ----
    FILLBOX 0,0,24,79,0Fh

    ; Layer 1 BLUE: rows 1-23, cols 10-69, bg BLUE / fg WHITE
    FILLBOX 1,10,23,69,1Fh
    ; text "LOGO DESIGN - INT 10H" at row 2, col 29
    TEXTAT  2,29,m01
    ; Layer 2 RED: rows 3-21, cols 14-65, bg RED / fg WHITE
    FILLBOX 3,14,21,65,4Fh
    ; text "ENGINEERING" at row 4, col 34
    TEXTAT  4,34,m02
    ; Corner TL: rows 3-4, cols 14-17, bg LT.GREEN / fg BLACK
    FILLBOX 3,14,4,17,0A0h
    ; Corner TR: rows 3-4, cols 62-65, bg LT.MAGENTA / fg BLACK
    FILLBOX 3,62,4,65,0D0h
    ; Corner BL: rows 20-21, cols 14-17, bg LT.MAGENTA / fg BLACK
    FILLBOX 20,14,21,17,0D0h
    ; Corner BR: rows 20-21, cols 62-65, bg LT.GREEN / fg BLACK
    FILLBOX 20,62,21,65,0A0h
    ; Layer 3 YELLOW: rows 5-19, cols 18-61, bg YELLOW / fg BLACK
    FILLBOX 5,18,19,61,0E0h
    ; text "MANUEL R. LATAYAN" at row 6, col 31
    TEXTAT  6,31,m03
    ; Letter M - left leg: rows 8-16, cols 24-26, bg BLUE / fg BLUE
    FILLBOX 8,24,16,26,11h
    ; Letter M - right leg: rows 8-16, cols 37-39, bg BLUE / fg BLUE
    FILLBOX 8,37,16,39,11h
    ; M diag: rows 8-9, cols 27-28, bg BLUE / fg BLUE
    FILLBOX 8,27,9,28,11h
    ; M diag: rows 8-9, cols 35-36, bg BLUE / fg BLUE
    FILLBOX 8,35,9,36,11h
    ; M diag: rows 10-11, cols 29-30, bg BLUE / fg BLUE
    FILLBOX 10,29,11,30,11h
    ; M diag: rows 10-11, cols 33-34, bg BLUE / fg BLUE
    FILLBOX 10,33,11,34,11h
    ; M center: rows 12-13, cols 31-32, bg BLUE / fg BLUE
    FILLBOX 12,31,13,32,11h
    ; Letter L - stem: rows 8-16, cols 44-46, bg RED / fg RED
    FILLBOX 8,44,16,46,44h
    ; Letter L - foot: rows 14-16, cols 44-56, bg RED / fg RED
    FILLBOX 14,44,16,56,44h
    ; Green base line: rows 17-17, cols 24-56, bg GREEN / fg GREEN
    FILLBOX 17,24,17,56,22h
    ; text "PROUD TO BE AN ENGINEER" at row 18, col 28
    TEXTAT  18,28,m04
    ; text "EXER12.ASM" at row 22, col 35
    TEXTAT  22,35,m05

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