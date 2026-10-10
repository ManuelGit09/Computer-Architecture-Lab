.MODEL SMALL
.STACK 100h
.DATA
    var1 DB 'PROUD TO BE A ', 13, 10, '$'
    var2 DB 'FILIPINO ENGINEER ', 13, 10, '$'
.CODE
START:

    ;< ---- Displaying the 1st Layer Color Background GREEN ---- >
    MOV  AH, 07h            ; Scroll window
    MOV  AL, 00h            ; 0 = clear the whole window
    MOV  BH, 20h            ; Background setting to Color Green
    MOV  CH, 0              ; starting row
    MOV  CL, 0              ; starting column
    MOV  DH, 24             ; end row
    MOV  DL, 79             ; end column
    INT  10h                ; video function call

    ;< ---- Displaying the 2nd Layer Color Background RED ---- >
    MOV  AH, 07h
    MOV  AL, 00h
    MOV  BH, 40h            ; Background setting to Color Red
    MOV  CH, 3
    MOV  CL, 3
    MOV  DH, 21
    MOV  DL, 76
    INT  10h

    ;< ---- Displaying the 3rd Layer Color Background YELLOW ---- >
    MOV  AH, 07h
    MOV  AL, 00h
    MOV  BH, 60h            ; Background setting to Color Yellow
    MOV  CH, 7
    MOV  CL, 7
    MOV  DH, 17
    MOV  DL, 72
    INT  10h

    ;< ---- Initialize the data segment ---- >
    MOV  AX, @DATA
    MOV  DS, AX

    ;< ---- Set cursor position to row 8, column 8 ---- >
    MOV  AH, 02h
    MOV  BH, 00
    MOV  DH, 8              ; row
    MOV  DL, 8              ; column
    INT  10h

    ;< ---- Print first string at 8,8 ---- >
    MOV  AH, 09h
    MOV  DX, OFFSET var1
    INT  21h

    ;< ---- Set cursor position to row 9, column 8 ---- >
    MOV  AH, 02h
    MOV  BH, 00
    MOV  DH, 9
    MOV  DL, 8
    INT  10h

    ;< ---- Print second string at 9,8 ---- >
    MOV  AH, 09h
    MOV  DX, OFFSET var2
    INT  21h

    MOV  AH, 4Ch            ; terminate program
    INT  21h

END START