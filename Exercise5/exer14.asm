; ============================================================
; Exer14.asm - Machine Problem 4: Mobile Phone
; Feature phone: body, speaker, LCD with status bar and text, call/OK/end keys and 12-key pad.
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
; See Exer14_graph.png for the coordinate drawing.
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
    m01  DB 'ASM-PHONE','$'
    m02  DB '4G ||||','$'
    m03  DB '10:45','$'
    m04  DB '[==]','$'
    m05  DB 'WELCOME TO MY','$'
    m06  DB 'MANUEL R. LATAYAN','$'
    m07  DB 'Exer14.asm','$'
    m08  DB 'SAT OCT 10 2026','$'
    m09  DB 'Menu','$'
    m10  DB 'Names','$'
    m11  DB 'CALL','$'
    m12  DB 'OK','$'
    m13  DB 'END','$'
    m14  DB '1','$'
    m15  DB '2abc','$'
    m16  DB '3def','$'
    m17  DB '4ghi','$'
    m18  DB '5jkl','$'
    m19  DB '6mno','$'
    m20  DB '7pqrs','$'
    m21  DB '8tuv','$'
    m22  DB '9wxyz','$'
    m23  DB '*','$'
    m24  DB '0','$'
    m25  DB '#','$'

.CODE
START:
    MOV  AX, @DATA
    MOV  DS, AX

    MOV  AX, 1003h          ; bit 7 = intensity (not blink)
    MOV  BL, 00h
    INT  10h

    ; ---- screen background: white on black ----
    FILLBOX 0,0,24,79,0Fh

    ; Phone body: rows 0-24, cols 26-53, bg DK.GRAY / fg WHITE
    FILLBOX 0,26,24,53,8Fh
    ; Speaker: rows 1-1, cols 35-44, bg BLACK / fg WHITE
    FILLBOX 1,35,1,44,0Fh
    ; Camera/sensor: rows 1-1, cols 47-48, bg BLUE / fg BLUE
    FILLBOX 1,47,1,48,11h
    ; text "ASM-PHONE" at row 2, col 35
    TEXTAT  2,35,m01
    ; Screen bezel: rows 3-11, cols 29-50, bg BLACK / fg WHITE
    FILLBOX 3,29,11,50,0Fh
    ; LCD: rows 4-10, cols 30-49, bg LT.GREEN / fg BLACK
    FILLBOX 4,30,10,49,0A0h
    ; LCD status bar: rows 4-4, cols 30-49, bg BLUE / fg WHITE
    FILLBOX 4,30,4,49,1Fh
    ; text "4G ||||" at row 4, col 31
    TEXTAT  4,31,m02
    ; text "10:45" at row 4, col 40
    TEXTAT  4,40,m03
    ; text "[==]" at row 4, col 46
    TEXTAT  4,46,m04
    ; text "WELCOME TO MY" at row 6, col 31
    TEXTAT  6,31,m05
    ; text "MANUEL R. LATAYAN" at row 7, col 31
    TEXTAT  7,31,m06
    ; text "Exer14.asm" at row 8, col 31
    TEXTAT  8,31,m07
    ; text "SAT OCT 10 2026" at row 9, col 31
    TEXTAT  9,31,m08
    ; LCD soft-key bar: rows 10-10, cols 30-49, bg BLUE / fg WHITE
    FILLBOX 10,30,10,49,1Fh
    ; text "Menu" at row 10, col 31
    TEXTAT  10,31,m09
    ; text "Names" at row 10, col 44
    TEXTAT  10,44,m10
    ; CALL key: rows 13-14, cols 29-34, bg LT.GREEN / fg BLACK
    FILLBOX 13,29,14,34,0A0h
    ; text "CALL" at row 13, col 30
    TEXTAT  13,30,m11
    ; OK key: rows 13-14, cols 37-42, bg LT.GRAY / fg BLACK
    FILLBOX 13,37,14,42,70h
    ; text "OK" at row 13, col 39
    TEXTAT  13,39,m12
    ; END key: rows 13-14, cols 45-50, bg LT.RED / fg BLACK
    FILLBOX 13,45,14,50,0C0h
    ; text "END" at row 13, col 46
    TEXTAT  13,46,m13
    ; Key 1: rows 16-16, cols 29-34, bg WHITE / fg BLACK
    FILLBOX 16,29,16,34,0F0h
    ; text "1" at row 16, col 31
    TEXTAT  16,31,m14
    ; Key 2abc: rows 16-16, cols 37-42, bg WHITE / fg BLACK
    FILLBOX 16,37,16,42,0F0h
    ; text "2abc" at row 16, col 38
    TEXTAT  16,38,m15
    ; Key 3def: rows 16-16, cols 45-50, bg WHITE / fg BLACK
    FILLBOX 16,45,16,50,0F0h
    ; text "3def" at row 16, col 46
    TEXTAT  16,46,m16
    ; Key 4ghi: rows 18-18, cols 29-34, bg WHITE / fg BLACK
    FILLBOX 18,29,18,34,0F0h
    ; text "4ghi" at row 18, col 30
    TEXTAT  18,30,m17
    ; Key 5jkl: rows 18-18, cols 37-42, bg WHITE / fg BLACK
    FILLBOX 18,37,18,42,0F0h
    ; text "5jkl" at row 18, col 38
    TEXTAT  18,38,m18
    ; Key 6mno: rows 18-18, cols 45-50, bg WHITE / fg BLACK
    FILLBOX 18,45,18,50,0F0h
    ; text "6mno" at row 18, col 46
    TEXTAT  18,46,m19
    ; Key 7pqrs: rows 20-20, cols 29-34, bg WHITE / fg BLACK
    FILLBOX 20,29,20,34,0F0h
    ; text "7pqrs" at row 20, col 29
    TEXTAT  20,29,m20
    ; Key 8tuv: rows 20-20, cols 37-42, bg WHITE / fg BLACK
    FILLBOX 20,37,20,42,0F0h
    ; text "8tuv" at row 20, col 38
    TEXTAT  20,38,m21
    ; Key 9wxyz: rows 20-20, cols 45-50, bg WHITE / fg BLACK
    FILLBOX 20,45,20,50,0F0h
    ; text "9wxyz" at row 20, col 45
    TEXTAT  20,45,m22
    ; Key *: rows 22-22, cols 29-34, bg LT.GRAY / fg BLACK
    FILLBOX 22,29,22,34,70h
    ; text "*" at row 22, col 31
    TEXTAT  22,31,m23
    ; Key 0: rows 22-22, cols 37-42, bg LT.GRAY / fg BLACK
    FILLBOX 22,37,22,42,70h
    ; text "0" at row 22, col 39
    TEXTAT  22,39,m24
    ; Key #: rows 22-22, cols 45-50, bg LT.GRAY / fg BLACK
    FILLBOX 22,45,22,50,70h
    ; text "#" at row 22, col 47
    TEXTAT  22,47,m25
    ; Microphone: rows 24-24, cols 37-42, bg BLACK / fg WHITE
    FILLBOX 24,37,24,42,0Fh

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