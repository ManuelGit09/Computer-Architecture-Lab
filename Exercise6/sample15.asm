.model small
.stack 
.data
wn     db    'What is your name?',20h,'$'
ag     db    'how old are you?',20h,'$'
bd     db    'When is  your birthday?',20h,'$'
gd     db    'What is your gender?',20h,'$'
rpt    db    'Repeat? Press N to Exit. ',20h, 20h, '$'
wnpar  label byte
wnlen  db  20
actwnlen db  ?
wnfld  db  20 dup(' ')
agpar  label byte
aglen  db  10
actaglen db  ?
agfld  db  10 dup(' ')
bdpar  label byte
bdlen  db  20
actbdlen db  ?
bdfld  db  20 dup(' ')


.code

start:
  mov ax, @data
  mov ds, ax

ulit:
 
  ;** clear the screen**
  mov ah, 06h
  mov bh, 07h
  mov cx, 0000h
  mov dx, 184fh
  int 10h

  ;** first prompt**
  mov ah, 02
  mov bh, 00
  mov dx, 0820h
  int 10h

  mov ah, 09h
  mov dx, offset wn
  int 21h

  ;** response to first prompt**
  mov ah, 0ah
  mov dx, offset wnpar
  int 21h

  ;** second prompt**
  mov ah, 02
  mov bh, 00
  mov dx, 0920h
  int 10h

  mov ah, 09h
  mov dx, offset ag
  int 21h
  ;** response to second prompt**
  mov ah, 0ah
  mov dx, offset agpar   
 int 21h

  ;** third prompt**
  mov ah, 02
  mov bh, 00
  mov dx, 0A20h
  int 10h

  mov ah, 09h
  mov dx, offset bd
  int 21h
  
  ;** response to third prompt**
  mov ah, 0ah

  int 21h

  ;** fourth prompt**
  mov ah, 02
  mov bh, 00
  mov dx, 0B20h
  int 10h

  mov ah, 09h
  mov dx, offset gd
  int 21h

  ;** response to fourth prompt**
  mov ah, 0ah
  int 21h


  mov ah, 02
  mov bh, 00
  mov dx, 0e24h
  int 10h

  mov ah, 09h
  mov dx, offset rpt
  int 21h

  mov ah, 01
  mov dx, offset bdpar
  int 21h

  cmp al, 'N'
  jne ulit

  mov ah, 4ch
  int 21h

  end   start