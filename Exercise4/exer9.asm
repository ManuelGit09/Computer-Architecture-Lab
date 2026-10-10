.model small
.stack 100h
.data
    c1  DB '=========================================', 13, 10, '$'
    c2  DB '|  [cpe]            MR. Manuel R. Latayan |', 13, 10, '$'
    c3  DB '|                     Computer Eng.     |', 13, 10, '$'
    c4  DB '|                                       |', 13, 10, '$'
    c5  DB '|  Certicode          OFFICE: N/A       |', 13, 10, '$'
    c6  DB '|                     FAX: N/A          |', 13, 10, '$'
    c7  DB '|                     RES.: Batangas    |', 13, 10, '$'
    c8  DB '|  certicode.com      MOBILE: 09511575516   |', 13, 10, '$'
    c9  DB '|                     EMAIL: manuellatayan|', 13, 10, '$'
    c10 DB '=========================================', 13, 10, '$'

.code
start:
    mov ax, @data
    mov ds, ax

    mov ah, 09h
    mov dx, offset c1
    int 21h
    mov ah, 09h
    mov dx, offset c2
    int 21h
    mov ah, 09h
    mov dx, offset c3
    int 21h
    mov ah, 09h
    mov dx, offset c4
    int 21h
    mov ah, 09h
    mov dx, offset c5
    int 21h
    mov ah, 09h
    mov dx, offset c6
    int 21h
    mov ah, 09h
    mov dx, offset c7
    int 21h
    mov ah, 09h
    mov dx, offset c8
    int 21h
    mov ah, 09h
    mov dx, offset c9
    int 21h
    mov ah, 09h
    mov dx, offset c10
    int 21h

    mov ah, 4ch
    int 21h
end start