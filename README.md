Assembly colors:
<details>
  
    ; black (0)
    MOV     BH, 0Fh      
    MOV     CX, 0000h   
    MOV     DX, 004Fh   
    INT     10h

    ; blue (1)
    MOV     BH, 1Fh
    MOV     CX, 0100h
    MOV     DX, 014Fh
    INT     10h

    ; green (2)
    MOV     BH, 2Fh
    MOV     CX, 0200h
    MOV     DX, 024Fh
    INT     10h

    ; cyan (3)
    MOV     BH, 3Fh
    MOV     CX, 0300h
    MOV     DX, 034Fh
    INT     10h

    ; red (4)
    MOV     BH, 4Fh
    MOV     CX, 0400h
    MOV     DX, 044Fh
    INT     10h

    ; magenta (5)
    MOV     BH, 5Fh
    MOV     CX, 0500h
    MOV     DX, 054Fh
    INT     10h

    ; brown (6)
    MOV     BH, 6Fh
    MOV     CX, 0600h
    MOV     DX, 064Fh
    INT     10h

    ; light gray (7)
    MOV     BH, 7Fh
    MOV     CX, 0700h
    MOV     DX, 074Fh
    INT     10h

    ; dark gray (8)
    MOV     BH, 8Fh
    MOV     CX, 0800h
    MOV     DX, 084Fh
    INT     10h

    ; light blue (9)
    MOV     BH, 9Fh
    MOV     CX, 0900h
    MOV     DX, 094Fh
    INT     10h

    ; light green (A)
    MOV     BH, 0AFh
    MOV     CX, 0A00h
    MOV     DX, 0A4Fh
    INT     10h

    ; light cyan (B)
    MOV     BH, 0BFh
    MOV     CX, 0B00h
    MOV     DX, 0B4Fh
    INT     10h

    ; light red (C)
    MOV     BH, 0CFh
    MOV     CX, 0C00h
    MOV     DX, 0C4Fh
    INT     10h

    ; light magenta (D)
    MOV     BH, 0DFh
    MOV     CX, 0D00h
    MOV     DX, 0D4Fh
    INT     10h

    ; yellow (E)
    MOV     BH, 0EFh                        
    MOV     CX, 0E00h
    MOV     DX, 0E4Fh
    INT     10h

    ; white (F)
    MOV     BH, 0F1h
    MOV     CX, 0F00h
    MOV     DX, 0F4Fh
    INT     10h
</details>                    

Useful links:
<br>https://4beginner.com/8086-Assembly-Language-INT-10h-Video-Interrupt
<br>https://care4you.in/interrupt-number-10h-int-10h/
<br>https://handwiki.org/wiki/INT_10H
<br>https://4beginner.com/8086-Assembly-Language-INT-33h-Mouse-Interrupt
<br>http://devdocs.inightmare.org/tutorials/x86-assembly-mouse-int-33h.html
<br>https://stanislavs.org/helppc/int_33.html
