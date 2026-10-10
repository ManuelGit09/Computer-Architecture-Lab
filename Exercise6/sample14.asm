.model small
.stack
.data

 don1 DB'HELLO    ',13,10,'$'
 don2 DB'JUAN DELA CRUZ  ',13,10,'$'
 don3 DB'YES how about you? ',13,10,'$'
 don4 DB' PHILIPPINES',13,10,'$'
 don5 DB'BSCpE',13,10,'$'
 don6 DB'Amazing! ',13,10,'$'
.code

start:
     mov cx,2
     mov ah,01h
back:mov dl,al
     int 21h
     loop back
     
     call hi

     mov cx,3
     mov ah,01h
go:mov dl,al
     int 21h
     loop go
     
    call huu

     mov cx,3
     mov ah,01h
lipat:mov dl,al
     int 21h
     loop lipat
     
    call study

     mov cx,3
     mov ah,01h
alin:mov dl,al
     int 21h
     loop alin
     
     call skul

     mov cx,3
     mov ah,01h
ganda:mov dl,al
     int 21h
     loop ganda
     
    call course

     
mov cx,3
     mov ah,01h
owss:mov dl,al
     int 21h
     loop owss
     
     call dscryb

     call exit
hi:call agwat
   mov ax,@data
   mov ds,ax
   mov ah,09h
   mov dx,offset don1
   int 21h
   mov ah,07h
   int 21h
   ret

huu: call agwat
    mov ax,@data
    mov ds,ax
    mov ah,09h
    mov dx,offset don2
    int 21h
    ret

study:call agwat
      mov ax,@data
      mov ds,ax
      mov ah,09h
      mov dx,offset don3
      int 21h
      ret

skul:call agwat
      mov ax,@data
     mov ds,ax
     mov ah,09h
     mov dx,offset don4
     int 21h
     ret

course:call agwat
       mov ax,@data
       mov ds,ax
       mov ah,09h
       mov dx,offset don5
       int 21h
       ret

dscryb:call agwat
       mov ax,@data
       mov ds,ax
       mov ah,09h
       mov dx,offset don6
       int 21h
       ret



agwat: mov ah,0dh
           int 21h
           mov ah,0ah
           int 21h
           ret

exit:
mov ah,4ch
int 21h
end start