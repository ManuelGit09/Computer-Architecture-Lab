.model small
.stack 100h
.data
    pol1 DB 13,10,'10th CHARACTER HAS BEEN PRESSED..!!! $'
.code

start:
    mov  ax,@data
    mov  ds,ax

    mov  cx,10              ; accept 10 characters
balik:
    mov  ah,01h             ; read a key with echo, result in AL
    int  21h
    loop balik

    mov  ah,09h             ; display the message
    mov  dx,offset pol1
    int  21h

    mov  ah,4ch             ; terminate program
    int  21h

end start