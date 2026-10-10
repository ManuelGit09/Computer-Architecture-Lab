; ============================================================
; Exer15.asm - Machine Problem 5: Chess Board
; 8x8 board, each square 6 columns x 3 rows, white and green; a8 (top-left) is a light square.
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
; See Exer15_graph.png for the coordinate drawing.
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
    m01  DB '8','$'
    m02  DB '7','$'
    m03  DB '6','$'
    m04  DB '5','$'
    m05  DB '4','$'
    m06  DB '3','$'
    m07  DB '2','$'
    m08  DB '1','$'
    m09  DB 'A','$'
    m10  DB 'B','$'
    m11  DB 'C','$'
    m12  DB 'D','$'
    m13  DB 'E','$'
    m14  DB 'F','$'
    m15  DB 'G','$'
    m16  DB 'H','$'
    m17  DB 'CHESS','$'
    m18  DB 'BOARD','$'
    m19  DB '8 x 8','$'

.CODE
START:
    MOV  AX, @DATA
    MOV  DS, AX

    MOV  AX, 1003h          ; bit 7 = intensity (not blink)
    MOV  BL, 00h
    INT  10h

    ; ---- screen background: white on black ----
    FILLBOX 0,0,24,79,0Fh

    ; Board: all squares WHITE: rows 0-23, cols 16-63, bg WHITE / fg BLACK
    FILLBOX 0,16,23,63,0F0h
    ; Square b8 GREEN: rows 0-2, cols 22-27, bg GREEN / fg BLACK
    FILLBOX 0,22,2,27,20h
    ; Square d8 GREEN: rows 0-2, cols 34-39, bg GREEN / fg BLACK
    FILLBOX 0,34,2,39,20h
    ; Square f8 GREEN: rows 0-2, cols 46-51, bg GREEN / fg BLACK
    FILLBOX 0,46,2,51,20h
    ; Square h8 GREEN: rows 0-2, cols 58-63, bg GREEN / fg BLACK
    FILLBOX 0,58,2,63,20h
    ; Square a7 GREEN: rows 3-5, cols 16-21, bg GREEN / fg BLACK
    FILLBOX 3,16,5,21,20h
    ; Square c7 GREEN: rows 3-5, cols 28-33, bg GREEN / fg BLACK
    FILLBOX 3,28,5,33,20h
    ; Square e7 GREEN: rows 3-5, cols 40-45, bg GREEN / fg BLACK
    FILLBOX 3,40,5,45,20h
    ; Square g7 GREEN: rows 3-5, cols 52-57, bg GREEN / fg BLACK
    FILLBOX 3,52,5,57,20h
    ; Square b6 GREEN: rows 6-8, cols 22-27, bg GREEN / fg BLACK
    FILLBOX 6,22,8,27,20h
    ; Square d6 GREEN: rows 6-8, cols 34-39, bg GREEN / fg BLACK
    FILLBOX 6,34,8,39,20h
    ; Square f6 GREEN: rows 6-8, cols 46-51, bg GREEN / fg BLACK
    FILLBOX 6,46,8,51,20h
    ; Square h6 GREEN: rows 6-8, cols 58-63, bg GREEN / fg BLACK
    FILLBOX 6,58,8,63,20h
    ; Square a5 GREEN: rows 9-11, cols 16-21, bg GREEN / fg BLACK
    FILLBOX 9,16,11,21,20h
    ; Square c5 GREEN: rows 9-11, cols 28-33, bg GREEN / fg BLACK
    FILLBOX 9,28,11,33,20h
    ; Square e5 GREEN: rows 9-11, cols 40-45, bg GREEN / fg BLACK
    FILLBOX 9,40,11,45,20h
    ; Square g5 GREEN: rows 9-11, cols 52-57, bg GREEN / fg BLACK
    FILLBOX 9,52,11,57,20h
    ; Square b4 GREEN: rows 12-14, cols 22-27, bg GREEN / fg BLACK
    FILLBOX 12,22,14,27,20h
    ; Square d4 GREEN: rows 12-14, cols 34-39, bg GREEN / fg BLACK
    FILLBOX 12,34,14,39,20h
    ; Square f4 GREEN: rows 12-14, cols 46-51, bg GREEN / fg BLACK
    FILLBOX 12,46,14,51,20h
    ; Square h4 GREEN: rows 12-14, cols 58-63, bg GREEN / fg BLACK
    FILLBOX 12,58,14,63,20h
    ; Square a3 GREEN: rows 15-17, cols 16-21, bg GREEN / fg BLACK
    FILLBOX 15,16,17,21,20h
    ; Square c3 GREEN: rows 15-17, cols 28-33, bg GREEN / fg BLACK
    FILLBOX 15,28,17,33,20h
    ; Square e3 GREEN: rows 15-17, cols 40-45, bg GREEN / fg BLACK
    FILLBOX 15,40,17,45,20h
    ; Square g3 GREEN: rows 15-17, cols 52-57, bg GREEN / fg BLACK
    FILLBOX 15,52,17,57,20h
    ; Square b2 GREEN: rows 18-20, cols 22-27, bg GREEN / fg BLACK
    FILLBOX 18,22,20,27,20h
    ; Square d2 GREEN: rows 18-20, cols 34-39, bg GREEN / fg BLACK
    FILLBOX 18,34,20,39,20h
    ; Square f2 GREEN: rows 18-20, cols 46-51, bg GREEN / fg BLACK
    FILLBOX 18,46,20,51,20h
    ; Square h2 GREEN: rows 18-20, cols 58-63, bg GREEN / fg BLACK
    FILLBOX 18,58,20,63,20h
    ; Square a1 GREEN: rows 21-23, cols 16-21, bg GREEN / fg BLACK
    FILLBOX 21,16,23,21,20h
    ; Square c1 GREEN: rows 21-23, cols 28-33, bg GREEN / fg BLACK
    FILLBOX 21,28,23,33,20h
    ; Square e1 GREEN: rows 21-23, cols 40-45, bg GREEN / fg BLACK
    FILLBOX 21,40,23,45,20h
    ; Square g1 GREEN: rows 21-23, cols 52-57, bg GREEN / fg BLACK
    FILLBOX 21,52,23,57,20h
    ; text "8" at row 1, col 14
    TEXTAT  1,14,m01
    ; text "7" at row 4, col 14
    TEXTAT  4,14,m02
    ; text "6" at row 7, col 14
    TEXTAT  7,14,m03
    ; text "5" at row 10, col 14
    TEXTAT  10,14,m04
    ; text "4" at row 13, col 14
    TEXTAT  13,14,m05
    ; text "3" at row 16, col 14
    TEXTAT  16,14,m06
    ; text "2" at row 19, col 14
    TEXTAT  19,14,m07
    ; text "1" at row 22, col 14
    TEXTAT  22,14,m08
    ; text "A" at row 24, col 18
    TEXTAT  24,18,m09
    ; text "B" at row 24, col 24
    TEXTAT  24,24,m10
    ; text "C" at row 24, col 30
    TEXTAT  24,30,m11
    ; text "D" at row 24, col 36
    TEXTAT  24,36,m12
    ; text "E" at row 24, col 42
    TEXTAT  24,42,m13
    ; text "F" at row 24, col 48
    TEXTAT  24,48,m14
    ; text "G" at row 24, col 54
    TEXTAT  24,54,m15
    ; text "H" at row 24, col 60
    TEXTAT  24,60,m16
    ; text "CHESS" at row 10, col 67
    TEXTAT  10,67,m17
    ; text "BOARD" at row 11, col 67
    TEXTAT  11,67,m18
    ; text "8 x 8" at row 13, col 67
    TEXTAT  13,67,m19

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