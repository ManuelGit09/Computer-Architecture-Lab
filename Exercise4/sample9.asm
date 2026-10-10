; ============================================================
; sample9.asm - Example No. 9
; Displays an abstract design ("ROCK N ROLL!!! BABY!!") made of
; string characters, using Function 09h of INT 21h.
; Each line ends with CR (13), LF (10) and the '$' terminator.
; ============================================================

.MODEL SMALL
.STACK 100h

.DATA
    p1  DB ' +88        ROCK N ROLL!!!       ', 13, 10, '$'
    p2  DB ' +880', 13, 10, '$'
    p3  DB ' ++88           BABY!!', 13, 10, '$'
    p4  DB ' ++88', 13, 10, '$'
    p5  DB ' +880                     ++', 13, 10, '$'
    p6  DB ' +888                    +88', 13, 10, '$'
    p7  DB ' ++880                   +88', 13, 10, '$'
    p8  DB ' ++888     +++88     +++8', 13, 10, '$'
    p9  DB ' ++8888 +++8880++88   ++88', 13, 10, '$'
    p10 DB ' ++8888+++8880++8888  ++88', 13, 10, '$'
    p11 DB ' ++888++8888++888888++888', 13, 10, '$'
    p12 DB ' ++88++8888++8888888++888', 13, 10, '$'
    p13 DB ' +++++8888888888888888', 13, 10, '$'
    p14 DB '    +++++++88888888888888', 13, 10, '$'
    p15 DB '     +++++++088888888888', 13, 10, '$'
    p16 DB '      +++++++088888888888', 13, 10, '$'
    p17 DB '       +++++++8888888888', 13, 10, '$'
    p18 DB '       +++++++0088888888', 13, 10, '$'
    p19 DB '        ++++++0088888888', 13, 10, '$'
    p20 DB '         ++++0008888888', 13, 10, '$'
    p21 DB '        ############', 13, 10, '$'
    p22 DB '        ############', 13, 10, '$'
    p23 DB '        ############', 13, 10, '$'

.CODE
START:
    MOV  AX, @DATA          ; initialize data segment
    MOV  DS, AX

    MOV  AH, 09h            ; DOS function: display string

    MOV  DX, OFFSET p1
    INT  21h
    MOV  DX, OFFSET p2
    INT  21h
    MOV  DX, OFFSET p3
    INT  21h
    MOV  DX, OFFSET p4
    INT  21h
    MOV  DX, OFFSET p5
    INT  21h
    MOV  DX, OFFSET p6
    INT  21h
    MOV  DX, OFFSET p7
    INT  21h
    MOV  DX, OFFSET p8
    INT  21h
    MOV  DX, OFFSET p9
    INT  21h
    MOV  DX, OFFSET p10
    INT  21h
    MOV  DX, OFFSET p11
    INT  21h
    MOV  DX, OFFSET p12
    INT  21h
    MOV  DX, OFFSET p13
    INT  21h
    MOV  DX, OFFSET p14
    INT  21h
    MOV  DX, OFFSET p15
    INT  21h
    MOV  DX, OFFSET p16
    INT  21h
    MOV  DX, OFFSET p17
    INT  21h
    MOV  DX, OFFSET p18
    INT  21h
    MOV  DX, OFFSET p19
    INT  21h
    MOV  DX, OFFSET p20
    INT  21h
    MOV  DX, OFFSET p21
    INT  21h
    MOV  DX, OFFSET p22
    INT  21h
    MOV  DX, OFFSET p23
    INT  21h

    MOV  AH, 4Ch            ; DOS function: terminate program
    INT  21h
END START