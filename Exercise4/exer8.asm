.MODEL SMALL
.STACK 100h

.DATA
    var1 DB 'Manuel Latayan', 13, 10, '$'
    var2 DB 'Computer Engineer', 13, 10, '$'
   

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



    MOV  AH, 4Ch            ; DOS function: terminate program
    INT  21h
END START