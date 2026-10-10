; ============================================================
; sample8.asm - Example No. 8
; Displays three lines of text using Function 09h of INT 21h.
; Each string ends with CR (13), LF (10) and the '$' terminator.
;
; Output:
;   Proud to be an Engineer
;   Good teachers can produce
;   Great Engineers
; ============================================================

.MODEL SMALL
.STACK 100h

.DATA
    var1 DB 'Proud to be an Engineer', 13, 10, '$'
    var2 DB 'Good teachers can produce', 13, 10, '$'
    var3 DB 'Great Engineers', 13, 10, '$'

.CODE
START:
    MOV  AX, @DATA          ; initialize data segment
    MOV  DS, AX

    MOV  AH, 09h            ; DOS function: display string
    MOV  DX, OFFSET var1
    INT  21h

    MOV  AH, 09h
    MOV  DX, OFFSET var2
    INT  21h

    MOV  AH, 09h
    MOV  DX, OFFSET var3
    INT  21h

    MOV  AH, 4Ch            ; DOS function: terminate program
    INT  21h
END START