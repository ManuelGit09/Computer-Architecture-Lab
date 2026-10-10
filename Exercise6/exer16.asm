; ============================================================
; Exer16.asm - Machine Problem 1: Student Information Form
; Asks the user to type information, then displays it.
;
; Functions used:
;   INT 10h AH=00h  set video mode 03h (80x25 color text, clears screen)
;   INT 10h AH=06h  scroll/clear window  -> paints colored rectangles
;   INT 10h AH=02h  set cursor position  -> DH=row, DL=column
;   INT 21h AH=0Ah  buffered keyboard input (typed text + ENTER)
;   INT 21h AH=09h  display '$'-terminated string
;   INT 21h AH=07h  read one key without echo (press any key to exit)
; Attribute byte = (background * 16) + foreground
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

; ---- move the cursor: CURSORAT row,col ----
CURSORAT MACRO gRow,gCol
    MOV  AH, 02h
    MOV  BH, 00h
    MOV  DH, gRow
    MOV  DL, gCol
    INT  10h
ENDM

; ---- display a string at the cursor ----
SAY MACRO sMsg
    MOV  AH, 09h
    MOV  DX, OFFSET sMsg
    INT  21h
ENDM

; ---- display a string at a position ----
TEXTAT MACRO tRow,tCol,tMsg
    CURSORAT tRow,tCol
    SAY  tMsg
ENDM

; ---- white input box + buffered input (function 0Ah) ----
INPUTBOX MACRO fRow,fCol1,fCol2,fBuf
    FILLBOX fRow,fCol1,fRow,fCol2,0F0h   ; black text on white
    CURSORAT fRow,fCol1
    MOV  DX, OFFSET fBuf
    MOV  AH, 0Ah
    INT  21h
    MOV  SI, OFFSET fBuf
    CALL TERM                ; put '$' after the typed text
ENDM

; ---- display what was typed in a buffer ----
SHOWBUF MACRO wBuf
    MOV  DX, OFFSET wBuf
    ADD  DX, 2               ; skip the 2 header bytes
    MOV  AH, 09h
    INT  21h
ENDM

.DATA
    tTitle DB 'STUDENT INFORMATION FORM$'
    tLbl1  DB 'FULL NAME :$'
    tLbl2  DB 'AGE       :$'
    tLbl3  DB 'COURSE    :$'
    tLbl4  DB 'ADDRESS   :$'
    tHelp  DB 'Type your answer, then press ENTER.$'
    tSum   DB 'INFORMATION ENTERED$'
    tS1    DB 'NAME    : $'
    tS2    DB 'AGE     : $'
    tS3    DB 'COURSE  : $'
    tS4    DB 'ADDRESS : $'
    tThank DB 'Thank you!$'
    tKey   DB 'Press any key to exit...$'

    ; buffers for function 0Ah: max length, actual length, text
    buf1   DB 30,?,30 DUP(?)       ; name    (29 characters)
    buf2   DB 4,?,4 DUP(?)         ; age     (3 characters)
    buf3   DB 25,?,25 DUP(?)       ; course  (24 characters)
    buf4   DB 40,?,40 DUP(?)       ; address (39 characters)

.CODE
START:
    MOV  AX, @DATA
    MOV  DS, AX

    MOV  AX, 0003h          ; AH=00h set video mode 80x25 text
    INT  10h

    ; ---- background and title bar ----
    FILLBOX 0,0,24,79,1Fh   ; white on blue
    FILLBOX 0,0,2,79,4Fh    ; white on red
    TEXTAT  1,28,tTitle

    ; ---- form panel ----
    FILLBOX 4,6,18,73,30h   ; black on cyan
    TEXTAT  6,10,tLbl1
    TEXTAT  9,10,tLbl2
    TEXTAT  12,10,tLbl3
    TEXTAT  15,10,tLbl4
    TEXTAT  17,10,tHelp

    ; ---- ask for the information ----
    INPUTBOX   6,24,52,buf1
    INPUTBOX   9,24,26,buf2
    INPUTBOX   12,24,47,buf3
    INPUTBOX   15,24,62,buf4

    ; ---- show the information entered ----
    FILLBOX 4,6,18,73,2Fh   ; white on green
    TEXTAT  5,30,tSum
    CURSORAT    8,12
    SAY     tS1
    SHOWBUF buf1
    CURSORAT    10,12
    SAY     tS2
    SHOWBUF buf2
    CURSORAT    12,12
    SAY     tS3
    SHOWBUF buf3
    CURSORAT    14,12
    SAY     tS4
    SHOWBUF buf4
    TEXTAT  17,31,tThank

    TEXTAT  20,28,tKey
    MOV  AH, 07h            ; wait for a key (no echo)
    INT  21h

    MOV  AX, 0003h          ; reset video mode (clears screen)
    INT  10h
    MOV  AH, 4Ch            ; terminate program
    INT  21h

; ------------------------------------------------------------
; TERM: SI = buffer address. Stores '$' right after the typed text
; (buffer layout: [0]=max, [1]=length typed, [2...]=characters)
; ------------------------------------------------------------
TERM PROC
    XOR  BH, BH
    MOV  BL, [SI+1]
    MOV  BYTE PTR [SI+BX+2], '$'
    RET
TERM ENDP

END START