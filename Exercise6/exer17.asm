; ============================================================
; Exer17.asm - Machine Problem 2: PAPER - ROCK - SCISSORS
; Two players take turns typing P, R or S (upper OR lower case).
; The keys are read with INT 21h AH=07h (no echo) so the opponent
; cannot see the letter; only a '*' is shown. The game repeats
; until the players answer N to "PLAY AGAIN?".
;
; Rules: Paper beats Rock, Rock beats Scissors, Scissors beats Paper.
;
; Functions used:
;   INT 10h AH=00h  set video mode (clear screen)
;   INT 10h AH=06h  paint colored rectangles (windows)
;   INT 10h AH=02h  set cursor position
;   INT 21h AH=07h  read a key WITHOUT echo (secret input)
;   INT 21h AH=09h  display strings
;   INT 21h AH=02h  display one character ('*' and the beep)
; ============================================================

.MODEL SMALL
.STACK 100h

; ---- paint a rectangle: FILLBOX row1,col1,row2,col2,attribute ----
FILLBOX MACRO bRow1,bCol1,bRow2,bCol2,bClr
    MOV  AX, 0600h
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

; ---- display a '*' at the cursor ----
SHOWSTAR MACRO
    MOV  AH, 02h
    MOV  DL, '*'
    INT  21h
ENDM

.DATA
    tTitle DB 'PAPER - ROCK - SCISSORS$'
    tP1    DB 'PLAYER 1$'
    tP2    DB 'PLAYER 2$'
    tVs    DB 'VS$'
    tAsk   DB 'Enter P, R or S:$'
    tWait  DB 'Waiting...$'
    tLock  DB 'LOCKED IN!$'
    tRules DB 'P = Paper   R = Rock   S = Scissors   (upper or lower case)$'
    tC1    DB 'PLAYER 1 CHOSE: $'
    tC2    DB 'PLAYER 2 CHOSE: $'
    tW1    DB '*** PLAYER 1 WINS! ***$'
    tW2    DB '*** PLAYER 2 WINS! ***$'
    tTie   DB '*** IT IS A TIE! ***$'
    tSc1   DB 'PLAYER 1 WINS: $'
    tSc2   DB '   PLAYER 2 WINS: $'
    tSc3   DB '   TIES: $'
    tAgain DB 'PLAY AGAIN? (Y/N): $'
    tBye   DB 'THANKS FOR PLAYING!$'
    tFinal DB 'FINAL SCORE BELOW$'
    tKey   DB 'Press any key to exit...$'
    nmP    DB 'PAPER$'
    nmR    DB 'ROCK$'
    nmS    DB 'SCISSORS$'

    pick1  DB 0
    pick2  DB 0
    score1 DB 0
    score2 DB 0
    ties   DB 0

.CODE
START:
    MOV  AX, @DATA
    MOV  DS, AX

    MOV  AX, 0003h          ; AH=00h set video mode 80x25 text
    INT  10h

NEWROUND:
    CALL DRAWSCREEN

    ; ---------------- Player 1 (secret input) ----------------
    TEXTAT 7,8,tAsk
    TEXTAT 7,48,tWait
    CURSORAT   9,8
    CALL   GETCHOICE        ; AL = 'P', 'R' or 'S' (uppercase)
    MOV    pick1, AL
    CURSORAT   9,8
    SHOWSTAR                    ; hide the letter
    TEXTAT 10,8,tLock

    ; ---------------- Player 2 (secret input) ----------------
    FILLBOX 7,46,7,73,5Fh   ; erase "Waiting..."
    TEXTAT 7,48,tAsk
    CURSORAT   9,48
    CALL   GETCHOICE
    MOV    pick2, AL
    CURSORAT   9,48
    SHOWSTAR
    TEXTAT 10,48,tLock

    ; ---------------- Reveal the choices ----------------
    TEXTAT 16,18,tC1
    MOV    AL, pick1
    CALL   NAMEOF           ; DX = name string
    MOV    AH, 09h
    INT    21h
    TEXTAT 17,18,tC2
    MOV    AL, pick2
    CALL   NAMEOF
    MOV    AH, 09h
    INT    21h

    ; ---------------- Decide the winner ----------------
    MOV    AL, pick1
    MOV    BL, pick2
    CMP    AL, BL
    JE     ISTIE
    CMP    AL, 'P'
    JNE    CHKR
    CMP    BL, 'R'          ; paper beats rock
    JE     P1WIN
    JMP    P2WIN
CHKR:
    CMP    AL, 'R'
    JNE    CHKS
    CMP    BL, 'S'          ; rock beats scissors
    JE     P1WIN
    JMP    P2WIN
CHKS:                       ; player 1 chose scissors
    CMP    BL, 'P'          ; scissors beats paper
    JE     P1WIN
    JMP    P2WIN

P1WIN:
    INC    score1
    FILLBOX 19,15,19,64,2Fh
    TEXTAT 19,29,tW1
    JMP    SHOWRESULT
P2WIN:
    INC    score2
    FILLBOX 19,15,19,64,5Fh
    TEXTAT 19,29,tW2
    JMP    SHOWRESULT
ISTIE:
    INC    ties
    FILLBOX 19,15,19,64,6Fh
    TEXTAT 19,30,tTie

SHOWRESULT:
    CALL   SHOWSCORE

    ; ---------------- Play again? ----------------
    TEXTAT 23,8,tAgain
    CALL   GETYN            ; AL = 'Y' or 'N'
    MOV    DL, AL
    MOV    AH, 02h          ; echo the answer
    INT    21h
    CMP    AL, 'Y'
    JNE    FINISH
    JMP    NEWROUND

FINISH:
    FILLBOX 0,0,24,79,1Fh
    FILLBOX 8,20,14,59,2Fh
    TEXTAT 10,30,tBye
    TEXTAT 12,31,tFinal
    CALL   SHOWSCORE
    TEXTAT 17,28,tKey
    MOV    AH, 07h          ; wait for a key (no echo)
    INT    21h

    MOV    AX, 0003h        ; reset video mode (clears screen)
    INT    10h
    MOV    AH, 4Ch          ; terminate program
    INT    21h

; ------------------------------------------------------------
; DRAWSCREEN: draws the whole game screen
; ------------------------------------------------------------
DRAWSCREEN PROC
    FILLBOX 0,0,24,79,1Fh       ; background: white on blue
    FILLBOX 0,0,2,79,4Fh        ; title bar: white on red
    TEXTAT  1,28,tTitle
    FILLBOX 4,5,11,34,2Fh       ; player 1 panel: green
    FILLBOX 4,45,11,74,5Fh      ; player 2 panel: magenta
    TEXTAT  5,8,tP1
    TEXTAT  5,48,tP2
    TEXTAT  7,38,tVs
    FILLBOX 13,0,13,79,1Eh      ; rules line: yellow on blue
    TEXTAT  13,10,tRules
    FILLBOX 15,15,20,64,70h     ; result panel: black on gray
    FILLBOX 21,0,23,79,0Fh      ; score/prompt area: white on black
    CALL    SHOWSCORE
    RET
DRAWSCREEN ENDP

; ------------------------------------------------------------
; SHOWSCORE: prints the scoreboard on row 22
; ------------------------------------------------------------
SHOWSCORE PROC
    FILLBOX 22,0,22,79,0Eh      ; yellow on black
    CURSORAT    22,8
    SAY     tSc1
    MOV     AL, score1
    CALL    PRTNUM
    SAY     tSc2
    MOV     AL, score2
    CALL    PRTNUM
    SAY     tSc3
    MOV     AL, ties
    CALL    PRTNUM
    RET
SHOWSCORE ENDP

; ------------------------------------------------------------
; PRTNUM: prints AL (0-99) as two digits at the cursor
; ------------------------------------------------------------
PRTNUM PROC
    XOR     AH, AH
    AAM                         ; AH = tens, AL = ones
    PUSH    AX
    MOV     DL, AH
    ADD     DL, '0'
    MOV     AH, 02h
    INT     21h
    POP     AX
    MOV     DL, AL
    ADD     DL, '0'
    MOV     AH, 02h
    INT     21h
    RET
PRTNUM ENDP

; ------------------------------------------------------------
; GETCHOICE: reads keys with function 07h (no echo) until the
; player presses P, R or S in either case. Returns uppercase in AL.
; Wrong keys make a beep and are ignored.
; ------------------------------------------------------------
GETCHOICE PROC
GC_READ:
    MOV     AH, 07h             ; read a key, NO echo
    INT     21h
    CMP     AL, 0               ; extended key? discard its scan code
    JNE     GC_CHK
    MOV     AH, 07h
    INT     21h
    JMP     GC_READ
GC_CHK:
    AND     AL, 0DFh            ; convert lowercase to uppercase
    CMP     AL, 'P'
    JE      GC_OK
    CMP     AL, 'R'
    JE      GC_OK
    CMP     AL, 'S'
    JE      GC_OK
    MOV     AH, 02h             ; beep for an invalid key
    MOV     DL, 07h
    INT     21h
    JMP     GC_READ
GC_OK:
    RET
GETCHOICE ENDP

; ------------------------------------------------------------
; GETYN: reads Y or N (either case) with function 07h. Returns
; uppercase in AL.
; ------------------------------------------------------------
GETYN PROC
GY_READ:
    MOV     AH, 07h
    INT     21h
    CMP     AL, 0
    JNE     GY_CHK
    MOV     AH, 07h
    INT     21h
    JMP     GY_READ
GY_CHK:
    AND     AL, 0DFh
    CMP     AL, 'Y'
    JE      GY_OK
    CMP     AL, 'N'
    JE      GY_OK
    JMP     GY_READ
GY_OK:
    RET
GETYN ENDP

; ------------------------------------------------------------
; NAMEOF: AL = 'P', 'R' or 'S'  ->  DX = address of its name
; ------------------------------------------------------------
NAMEOF PROC
    MOV     DX, OFFSET nmP
    CMP     AL, 'P'
    JE      NM_END
    MOV     DX, OFFSET nmR
    CMP     AL, 'R'
    JE      NM_END
    MOV     DX, OFFSET nmS
NM_END:
    RET
NAMEOF ENDP

END START