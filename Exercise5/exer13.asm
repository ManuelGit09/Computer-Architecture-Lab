; ============================================================
; Exer13.asm - Machine Problem 3: Standard TV (SMPTE) Color Bars
; 7 bars of 75% colors (67% of height), reverse strip (8%), bottom pluge section (25%). Network: GMA.
;
; Uses INT 10h (video services):
;   AH=06h  scroll/clear window  -> paints a colored rectangle
;           (CH,CL)=top-left row,col  (DH,DL)=bottom-right row,col
;           BH = attribute = (background * 16) + foreground
;   AH=02h  set cursor position  -> DH=row, DL=column, BH=page 0
;   AX=1003h BL=0 -> background bit 7 = intensity (16 bg colors)
; and INT 21h AH=09h to print '$'-terminated strings (the text
; takes the color attribute of the rectangle it is printed on).
; Screen = 80 columns (0-79) x 25 rows (0-24).
; See Exer13_graph.png for the coordinate drawing.
; ============================================================

.MODEL SMALL
.STACK 100h

; ---- paint a rectangle: FILLBOX row1,col1,row2,col2,attribute ----
FILLBOX MACRO bRow1,bCol1,bRow2,bCol2,bClr
    MOV  AX, 0600h          ; AH=06h scroll window, AL=0 -> clear it
    MOV  BH, bClr
    MOV  CH, bRow1
    MOV  CL, bCol1
    MOV  DH, bRow2
    MOV  DL, bCol2
    INT  10h
ENDM

; ---- print a string at a position: TEXTAT row,col,string ----
TEXTAT MACRO pRow,pCol,pMsg
    MOV  AH, 02h            ; set cursor position
    MOV  BH, 00h
    MOV  DH, pRow
    MOV  DL, pCol
    INT  10h
    MOV  AH, 09h            ; display string
    MOV  DX, OFFSET pMsg
    INT  21h
ENDM

.DATA
    m01  DB 'STANDARD TV COLOR BARS - GMA NETWORK','$'
    m02  DB 'WHITE','$'
    m03  DB '75%','$'
    m04  DB 'YELLOW','$'
    m05  DB '75%','$'
    m06  DB 'CYAN','$'
    m07  DB '75%','$'
    m08  DB 'GREEN','$'
    m09  DB '75%','$'
    m10  DB 'MAGENTA','$'
    m11  DB '75%','$'
    m12  DB 'RED','$'
    m13  DB '75%','$'
    m14  DB 'BLUE','$'
    m15  DB '75%','$'
    m16  DB '-I','$'
    m17  DB 'WHITE','$'
    m18  DB '+Q','$'
    m19  DB 'GMA NETWORK','$'
    m20  DB 'CHANNEL 7','$'
    m21  DB 'KAPUSO','$'
    m22  DB '-4','$'
    m23  DB '0','$'
    m24  DB '+4','$'

.CODE
START:
    MOV  AX, @DATA
    MOV  DS, AX

    MOV  AX, 1003h          ; bit 7 = intensity (not blink)
    MOV  BL, 00h
    INT  10h

    ; ---- screen background: white on black ----
    FILLBOX 0,0,24,79,0Fh

    ; text "STANDARD TV COLOR BARS - GMA NETWORK" at row 0, col 22
    TEXTAT  0,22,m01
    ; Top bar 1 WHITE: rows 1-16, cols 1-11, bg LT.GRAY / fg BLACK
    FILLBOX 1,1,16,11,70h
    ; text "WHITE" at row 8, col 4
    TEXTAT  8,4,m02
    ; text "75%" at row 9, col 5
    TEXTAT  9,5,m03
    ; Top bar 2 YELLOW: rows 1-16, cols 12-22, bg BROWN / fg WHITE
    FILLBOX 1,12,16,22,6Fh
    ; text "YELLOW" at row 8, col 14
    TEXTAT  8,14,m04
    ; text "75%" at row 9, col 16
    TEXTAT  9,16,m05
    ; Top bar 3 CYAN: rows 1-16, cols 23-33, bg CYAN / fg WHITE
    FILLBOX 1,23,16,33,3Fh
    ; text "CYAN" at row 8, col 26
    TEXTAT  8,26,m06
    ; text "75%" at row 9, col 27
    TEXTAT  9,27,m07
    ; Top bar 4 GREEN: rows 1-16, cols 34-44, bg GREEN / fg WHITE
    FILLBOX 1,34,16,44,2Fh
    ; text "GREEN" at row 8, col 37
    TEXTAT  8,37,m08
    ; text "75%" at row 9, col 38
    TEXTAT  9,38,m09
    ; Top bar 5 MAGENTA: rows 1-16, cols 45-55, bg MAGENTA / fg WHITE
    FILLBOX 1,45,16,55,5Fh
    ; text "MAGENTA" at row 8, col 47
    TEXTAT  8,47,m10
    ; text "75%" at row 9, col 49
    TEXTAT  9,49,m11
    ; Top bar 6 RED: rows 1-16, cols 56-66, bg RED / fg WHITE
    FILLBOX 1,56,16,66,4Fh
    ; text "RED" at row 8, col 60
    TEXTAT  8,60,m12
    ; text "75%" at row 9, col 60
    TEXTAT  9,60,m13
    ; Top bar 7 BLUE: rows 1-16, cols 67-77, bg BLUE / fg WHITE
    FILLBOX 1,67,16,77,1Fh
    ; text "BLUE" at row 8, col 70
    TEXTAT  8,70,m14
    ; text "75%" at row 9, col 71
    TEXTAT  9,71,m15
    ; Middle strip 1: rows 17-18, cols 1-11, bg BLUE / fg WHITE
    FILLBOX 17,1,18,11,1Fh
    ; Middle strip 2: rows 17-18, cols 12-22, bg BLACK / fg WHITE
    FILLBOX 17,12,18,22,0Fh
    ; Middle strip 3: rows 17-18, cols 23-33, bg MAGENTA / fg WHITE
    FILLBOX 17,23,18,33,5Fh
    ; Middle strip 4: rows 17-18, cols 34-44, bg BLACK / fg WHITE
    FILLBOX 17,34,18,44,0Fh
    ; Middle strip 5: rows 17-18, cols 45-55, bg CYAN / fg WHITE
    FILLBOX 17,45,18,55,3Fh
    ; Middle strip 6: rows 17-18, cols 56-66, bg BLACK / fg WHITE
    FILLBOX 17,56,18,66,0Fh
    ; Middle strip 7: rows 17-18, cols 67-77, bg LT.GRAY / fg BLACK
    FILLBOX 17,67,18,77,70h
    ; -I (blue): rows 19-24, cols 1-14, bg BLUE / fg WHITE
    FILLBOX 19,1,24,14,1Fh
    ; text "-I" at row 21, col 7
    TEXTAT  21,7,m16
    ; 100% WHITE: rows 19-24, cols 15-28, bg WHITE / fg BLACK
    FILLBOX 19,15,24,28,0F0h
    ; text "WHITE" at row 21, col 20
    TEXTAT  21,20,m17
    ; +Q (purple): rows 19-24, cols 29-42, bg MAGENTA / fg WHITE
    FILLBOX 19,29,24,42,5Fh
    ; text "+Q" at row 21, col 35
    TEXTAT  21,35,m18
    ; BLACK: rows 19-24, cols 43-55, bg BLACK / fg WHITE
    FILLBOX 19,43,24,55,0Fh
    ; text "GMA NETWORK" at row 21, col 44
    TEXTAT  21,44,m19
    ; text "CHANNEL 7" at row 22, col 44
    TEXTAT  22,44,m20
    ; text "KAPUSO" at row 23, col 44
    TEXTAT  23,44,m21
    ; Pluge -4%: rows 19-24, cols 56-62, bg BLACK / fg WHITE
    FILLBOX 19,56,24,62,0Fh
    ; text "-4" at row 22, col 58
    TEXTAT  22,58,m22
    ; Pluge 0%: rows 19-24, cols 63-70, bg BLACK / fg WHITE
    FILLBOX 19,63,24,70,0Fh
    ; text "0" at row 22, col 66
    TEXTAT  22,66,m23
    ; Pluge +4%: rows 19-24, cols 71-77, bg DK.GRAY / fg WHITE
    FILLBOX 19,71,24,77,8Fh
    ; text "+4" at row 22, col 73
    TEXTAT  22,73,m24

    ; ---- park the cursor and wait for a key ----
    MOV  AH, 02h
    MOV  BH, 00h
    MOV  DH, 24
    MOV  DL, 00h
    INT  10h
    MOV  AH, 08h
    INT  21h

    ; ---- restore blink mode and clear the screen ----
    MOV  AX, 1003h
    MOV  BL, 01h
    INT  10h
    FILLBOX 0,0,24,79,07h
    MOV  AH, 02h
    MOV  BH, 00h
    MOV  DX, 0000h
    INT  10h

    MOV  AH, 4Ch            ; terminate program
    INT  21h
END START