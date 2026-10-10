.model small
.stack 100h
.data
    titleMsg DB 'My Favorite TV Shows:', 13, 10, '$'
    show1    DB '1. FPJ Batang Quiapo', 13, 10, '$'
    show2    DB '2. Eat Bulaga', 13, 10, '$'
    show3    DB '3. 24 Oras', 13, 10, '$'
    show4    DB '4. Tv5', 13, 10, '$'
    show5    DB '5. Team Yey', 13, 10, '$'

.code
start:
    mov ax, @data
    mov ds, ax

    ; Print Title
    mov ah, 09h
    mov dx, offset titleMsg
    int 21h

    ; Print Show 1
    mov ah, 09h
    mov dx, offset show1
    int 21h

    ; Print Show 2
    mov ah, 09h
    mov dx, offset show2
    int 21h

    ; Print Show 3
    mov ah, 09h
    mov dx, offset show3
    int 21h

    ; Print Show 4
    mov ah, 09h
    mov dx, offset show4
    int 21h

    ; Print Show 5
    mov ah, 09h
    mov dx, offset show5
    int 21h

    ; Terminate Program
    mov ah, 4ch
    int 21h
end start