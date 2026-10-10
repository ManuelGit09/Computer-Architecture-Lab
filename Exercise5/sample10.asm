.model small
	.stack
	.code
	start:

	;< ---- Displaying of the big rectangle with BLUE background---- >
	mov ah,06h	; Scroll up text Lines
	mov bh,10h 	; Background setting to Color Blue
	mov ch,0	; starting row of Blue  background (starting X coordinate)
	mov cl, 0 	; starting column of Blue  background (starting Y coordinate)
	mov dh, 24	; end row of Blue  background (end X coordinate)
	mov dl, 79	; end column of Blue  background (end Y coordinate)
	int 10h 		; video function call to display the video information

	; < ---- Displaying of the small rectangle with YELLOW  background--- >

	mov ah,06h	; Scroll up text Lines
	mov bh, 60h 	; Set rectangle color to Yellow
	mov ch,5	; starting row of  the Yellow rectangle (starting X coordinate)
	mov cl, 5 	; starting column of  the Yellow rectangle (starting Y coordinate)
	mov dh, 17	; end row of the Yellow rectangle (end X coordinate)
	mov dl, 74	; end column of the Yellow rectangle (end Y coordinate)
	int 10h 		; video function call to display the video information


	mov ah,4ch	
	int 21h

	end start