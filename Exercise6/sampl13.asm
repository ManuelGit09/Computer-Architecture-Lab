.model small
.stack
.data

p0 DB 'Press UPPERCASE or lowercase letter  A/a     ',13,10,'$'
p1 DB 'You Pressed UPPERCASE letter A           ',13,10,'$'
p2 DB 'You Pressed LOWERCASE letter a             ',13,10,'$'
p3 DB 'Press any Key to continue [X] to Exit ',13,10,'$'
P4 DB '                                                               ',13,10,'$'
.code

start:
        
        mov ax,@data
        mov ds,ax

        mov ah,09
        mov dx,offset p0
        int 21h
        mov dx,offset p4
        int 21h

        mov ah,07h
        int 21h

        cmp al,41h
        je Malaki
        cmp al,61h
        je Maliit
        jne start

  Malaki:
        
        mov ah,09h
        mov dx,offset p1
        int 21h
        
        mov dx,offset p3
        int 21h

        mov ah,07h
        int 21h

        mov ah,01h
        cmp al,'X'
        je EXIT
        jne start

Maliit:mov ah,09h
        mov dx,offset p2
        int 21h
        
        mov dx,offset p3
        int 21h

        mov ah,07h
        int 21h

        mov ah,01h
        cmp al,'X'
        je EXIT
        jne start

EXIT:   mov ah,4ch
        int 21h

        end start
