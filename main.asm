TITLE Nome: Giovani Bellini dos Santos, RA: 22007263 | Nome: Joao Victor Rokemback Tapparo, RA:22003236

.model small
.stack 100h

;------------------------------------data------------------------------------
.data
horizontal_mouse_position dw ?
vertical_mouse_position dw ?
variable_a db ?
variable_b db ?
variable_c db ?
length_second_number db ?
length_first_number db ?
variable_d db ?
array_first_number db 40 dup (?)
array_second_number db 40 dup (?)
flag db ?
operator db ?
registered_character db ?
pixel_pointer db ?
input_value dw ?
output_value dw ?
;----------------------------------------------------------------------------

;---data initialization---
mov ax, @data
mov ds, ax

;---return to dos---
returning_dos macro
    mov ah,4ch
    int 21h
endm

;---cleaning the registers---
cleaning_registers macro
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx
endm

;---set video mode---
setmode macro
    mov ah,0
    mov al,13h
    int 10h
endm

;-----------------------------------lines------------------------------------

;to design the calculator as a general rule, macros were created to create
;modelable lines, so that you can make the design you want just by
;informing basic variables such as the size, its x, y and its color.

;---make a horizontal line---
horizontal_line_printer macro x,y,z,c  
    local l1 ;In the first directive, within a macro, LOCAL defines 
			 ;labels that are unique to each instance of the macro.
    mov cx,x
    mov dx,z
    l1:
        mov ah,0ch ;
        mov al,c
        int 10h
        inc cx
        cmp cx,y
        jnz l1    
endm

;---make a vertical line---
vertical_line_printer macro x,y,z,c
    local l2
    mov cx,z
    mov dx,x
    l2:
        mov ah,0ch
        mov al,c      
        int 10h
        inc dx
        cmp dx,y
        jnz l2
endm

;---make a diagonal line---
diagonal_line_printer macro x,y,z,c 
    local l2
    mov cx,z
    mov dx,x
    l2:
        mov ah,0ch
        mov al,c      
        int 10h
        inc dx
        inc cx
        cmp dx,y
        jnz l2
endm

;---make a inverted diagonal line---
inverted_diagonal_line_printer macro x,y,z,c
    local l2
    mov cx,z
    mov dx,y
    l2:
        mov ah,0ch
        mov al,c      
        int 10h
        dec dx
        inc cx
        cmp dx,x
        jnz l2
endm
;----------------------------------------------------------------------------

;------------------------------calculator edge-------------------------------
drawouter macro

	;this macro has the function of creating and managing the edge of
	;the calculator, being it the part that would imitate the housing
	;of a real calculator
	
	;---first border---
    cleaning_registers
	horizontal_line_printer 4,254,4,7
	cleaning_registers
	horizontal_line_printer 4,255,194,7
	cleaning_registers
	vertical_line_printer 4,194,4,7
	cleaning_registers
	vertical_line_printer 4,194,254,7
	cleaning_registers

	;---second border---
	cleaning_registers
	horizontal_line_printer 4,256,196,8
	cleaning_registers
	vertical_line_printer 4,197,256,8
endm
;----------------------------------------------------------------------------

;-----------------------------calculator display-----------------------------
calculator_display macro

	;this part that shapes the look of the calculator display, that
	;is, that rectangular border that surrounds the input and 
	;the output of the calculator

	;---first border---
	cleaning_registers
	horizontal_line_printer 9,249,9,7
	cleaning_registers
	horizontal_line_printer 9,250,69,7
	cleaning_registers
	vertical_line_printer 9,69,9,7
	cleaning_registers
	vertical_line_printer 9,69,249,7
	cleaning_registers

	;-second border---
	cleaning_registers
	horizontal_line_printer 11,248,67,8
	cleaning_registers
	vertical_line_printer 11,67,11,8
endm
;----------------------------------------------------------------------------

;-----------------------------all buttons border-----------------------------

;here macros are made to create all the keycaps present in the calculator
;the macros are made to draw the border of the keycaps

default_button_border_printer macro x, y, c
	cleaning_registers
	horizontal_line_printer y,(y+39),x,c
	cleaning_registers
	horizontal_line_printer y,(y+39),(x+24),c
	cleaning_registers
	vertical_line_printer x,(x+24),y,c
	cleaning_registers
	vertical_line_printer x,(x+25),(y+39),c
	cleaning_registers
endm

zero_button_border_printer macro x, y, c
	cleaning_registers
	horizontal_line_printer y,(y+39+40+10),x,c
	cleaning_registers
	horizontal_line_printer y,(y+39+40+10),(x+24),c
	cleaning_registers
	vertical_line_printer x,(x+24),y,c
	cleaning_registers
	vertical_line_printer x,(x+25),(y+39+40+10),c
	cleaning_registers
endm

equal_button_border_printer macro x, y, c
	cleaning_registers
	horizontal_line_printer y,(y+39),x,c
	cleaning_registers
	horizontal_line_printer y,(y+39),(x+24+25+5),c
	cleaning_registers
	vertical_line_printer x,(x+24+25+5),y,c
	cleaning_registers
	vertical_line_printer x,(x+25+25+5),(y+39),c
	cleaning_registers
endm
;----------------------------------------------------------------------------

;---------------------------button border printer----------------------------
button_border_printer macro

	;this section of the code is entirely dedicated to creating borders 
	;around symbols and numerals working as if they were keycaps
	;of a real calculator

	;---default button border---
	default_button_border_printer 74,9,3
	default_button_border_printer 104,9,3
	default_button_border_printer 134,9,3
	default_button_border_printer 164,9,3
	default_button_border_printer 74,59,15
	default_button_border_printer 104,59,15
	default_button_border_printer 134,59,15
	default_button_border_printer 74,109,15
	default_button_border_printer 104,109,15
	default_button_border_printer 134,109,15
	default_button_border_printer 74,159,15
	default_button_border_printer 104,159,15
	default_button_border_printer 134,159,15
	default_button_border_printer 164,159,3
	default_button_border_printer 74,209,3
	default_button_border_printer 104,209,3

	;---zero button border---
	zero_button_border_printer 164,59,15

	;---equal button border---
	equal_button_border_printer 134,209,3	
endm
;----------------------------------------------------------------------------

;--------------------------print imput and output----------------------------
print_imput_output macro

	;---print "imput:"---
	character_printer 'i',2,2,11
	character_printer 'n',2,3,11
	character_printer 'p',2,4,11
	character_printer 'u',2,5,11
	character_printer 't',2,6,11
	character_printer ':',2,7,11

	;---print "output:"---
	character_printer 'o',4+1,2,11
	character_printer 'u',4+1,3,11
	character_printer 't',4+1,4,11
	character_printer 'p',4+1,5,11
	character_printer 'u',4+1,6,11
	character_printer 't',4+1,7,11
	character_printer ':',4+1,8,11
endm
;----------------------------------------------------------------------------

;-------------------------numeral symbols from 1 to 9------------------------

;this part of the code is several macros that will create the design of 
;the digits that will appear on the calculator keyboard, and each one 
;will be in its proper square (key)

number_0_printer macro x,y
	horizontal_line_printer (y-4),(y+4),x-8,15
	horizontal_line_printer (y-4),(y+4),x+8,15
	vertical_line_printer (x-8),(x+8),(y-4),15
	vertical_line_printer (x-8),(x+9),(y+4),15
endm

number_1_printer macro x,y
	vertical_line_printer (x-8),(x+8),(y+4),15
endm

number_2_printer macro x,y
	horizontal_line_printer (y-4),(y+4),x,15
	horizontal_line_printer (y-4),(y+5),x-8,15
	horizontal_line_printer (y-4),(y+4),x+8,15
	vertical_line_printer (x),(x+9),(y-4),15
	vertical_line_printer (x-8),(x+1),(y+4),15
endm

number_3_printer macro x,y
	horizontal_line_printer (y-4),(y+4),x,15
	horizontal_line_printer (y-4),(y+4),x-8,15
	horizontal_line_printer (y-4),(y+4),x+8,15
	vertical_line_printer (x-8),(x+9),(y+4),15
endm

number_4_printer macro x,y
	horizontal_line_printer (y-4),(y+4),x,15
	vertical_line_printer (x-8),(x),(y-4),15
	vertical_line_printer (x-8),(x+8),(y+4),15
endm

number_5_printer macro x,y
	horizontal_line_printer (y-4),(y+4),x,15
	horizontal_line_printer (y-4),(y+4),x-8,15
	horizontal_line_printer (y-4),(y+5),x+8,15
	vertical_line_printer (x-8),(x),(y-4),15
	vertical_line_printer (x),(x+8),(y+4),15
endm

number_6_printer macro x,y
	horizontal_line_printer (y-4),(y+4),x,15
	horizontal_line_printer (y-4),(y+4),x-8,15
	horizontal_line_printer (y-4),(y+5),x+8,15
	vertical_line_printer (x-8),(x+8),(y-4),15
	vertical_line_printer x,(x+8),(y+4),15
endm

number_7_printer macro x,y
	horizontal_line_printer (y-4),(y+4),x-8,15
	vertical_line_printer (x-8),(x+8),(y+4),15
endm

number_8_printer macro x,y
	horizontal_line_printer (y-4),(y+4),x,15
	horizontal_line_printer (y-4),(y+4),x-8,15
	horizontal_line_printer (y-4),(y+5),x+8,15
	vertical_line_printer (x-8),(x+8),(y-4),15
	vertical_line_printer (x-8),(x+8),(y+4),15
endm

number_9_printer macro x,y
	horizontal_line_printer (y-4),(y+4),x,15
	horizontal_line_printer (y-4),(y+4),x-8,15
	horizontal_line_printer (y-4),(y+4),x+8,15
	vertical_line_printer (x-8),(x),(y-4),15
	vertical_line_printer (x-8),(x+9),(y+4),15
endm
;----------------------------------------------------------------------------

;------------------plus, minus, multiply and divide symbols------------------

;this part of the code is several macros that will create the design of the 
;plus, minus, multiplication and division symbols that will appears on the
;calculator keyboard, and each will be in its appropriate square (key)

plus_symbol_printer macro x,y
	horizontal_line_printer (y-4),(y+4+1),x,3
	vertical_line_printer (x-4),(x+4+1),(y),3
endm

minus_symbol_printer macro x,y
	horizontal_line_printer (y-4),(y+4),x,3
endm

multiply_symbol_printer macro
	diagonal_line_printer 110+3,118+4,14+11,3
	diagonal_line_printer 110+3,118+4,14+10,3
	diagonal_line_printer 110+3,118+4,14+9,3
	inverted_diagonal_line_printer 110+2,118+3,14+11,3
	inverted_diagonal_line_printer 110+2,118+3,14+10,3
	inverted_diagonal_line_printer 110+2,118+3,14+9,3
endm

divide_symbol_printer macro x,y
	horizontal_line_printer (y-4),(y+4),x,3
	horizontal_line_printer (y-1),(y+1),x-3,3
	horizontal_line_printer (y-1),(y+1),x-4,3
	horizontal_line_printer (y-1),(y+1),x+3,3
	horizontal_line_printer (y-1),(y+1),x+4,3
endm
;----------------------------------------------------------------------------

;--------------------------function buttons symbols--------------------------

;this part of the code is several macros that will create the drawing 
;of the C, AC and equal symbols appears on the calculator keyboard, and
; each will be in its appropriate square (key)

c_symbol_printer macro x,y
	horizontal_line_printer (y-4),(y+4),x-8,3
	horizontal_line_printer (y-4),(y+4),x+8,3
	vertical_line_printer (x-8),(x+8),(y-4),3
endm

ac_symbol_printer macro x,y
	horizontal_line_printer (y-4+6),(y+4+6),x-8,3
	horizontal_line_printer (y-4+6),(y+4+6),x+8,3
	vertical_line_printer (x-8),(x+8),(y-4+6),3
	
	horizontal_line_printer (y-4-6),(y+4-6),x,3
	horizontal_line_printer (y-4-6),(y+4-6),x-8,3
	vertical_line_printer (x-8),(x+8+1),(y-4-6),3
	vertical_line_printer (x-8),(x+8+1),(y+4-6),3
endm

equal_symbol_printer macro x,y
	horizontal_line_printer (y-5),(y+5),x-2,3
	horizontal_line_printer (y-5),(y+5),x+1,3
endm
;----------------------------------------------------------------------------

;----------------------------------symbols----------------------------------
symbols_printer macro

	;this part of the code is responsible for printing all
	;the drawings that will be on the calculator keyboard

	;---number 0---
	number_0_printer (164+12),(59+39)
	number_0_printer (164+12),(59+40)
	number_0_printer (164+12),(59+41)

	;---number 1---
	number_1_printer (134+12),(59+19)
	number_1_printer (134+12),(59+20)
	number_1_printer (134+12),(59+21)

	;---number 2---
	number_2_printer (134+12),(109+19)
	number_2_printer (134+12),(109+20)
	number_2_printer (134+12),(109+21)

	;---number 3---
	number_3_printer (134+12),(159+19)
	number_3_printer (134+12),(159+20)
	number_3_printer (134+12),(159+21)

	;---number 4---
	number_4_printer (104+12),(59+19)
	number_4_printer (104+12),(59+20)
	number_4_printer (104+12),(59+21)

	;---number 5---
	number_5_printer (104+12),(109+19)		
	number_5_printer (104+12),(109+20)
	number_5_printer (104+12),(109+21)

	;---number 6---
	number_6_printer (104+12),(159+19)
	number_6_printer (104+12),(159+20)
	number_6_printer (104+12),(159+21)

	;---number 7---
	number_7_printer (74+12),(59+19)
	number_7_printer (74+12),(59+20)
	number_7_printer (74+12),(59+21)

	;---number 8---
	number_8_printer (74+12),(109+19)
	number_8_printer (74+12),(109+20)
	number_8_printer (74+12),(109+21)

	;---number 9---
	number_9_printer (74+12),(159+19)
	number_9_printer (74+12),(159+20)
	number_9_printer (74+12),(159+21)

	;---off---
	character_printer 'o',22,21,3
	character_printer 'f',22,22,3
	character_printer 'f',22,23,3

	;---plus---
	plus_symbol_printer (164+12),(9+19)
	plus_symbol_printer(164+12),(9+20)
	plus_symbol_printer(164+12),(9+21)
	plus_symbol_printer(164+11),(9+20)
	plus_symbol_printer(164+13),(9+20)

	;---minus---
	minus_symbol_printer (134+12),(9+19)
	minus_symbol_printer(134+12),(9+20)
	minus_symbol_printer(134+12),(9+21)
	minus_symbol_printer(134+11),(9+20)
	minus_symbol_printer(134+13),(9+20)

	;---multiply---
	multiply_symbol_printer(104+12),(9+20)

	;---divide---
	divide_symbol_printer (74+12),(9+19)
	divide_symbol_printer(74+12),(9+20)
	divide_symbol_printer(74+12),(9+21)
	divide_symbol_printer(74+11),(9+20)
	divide_symbol_printer(74+13),(9+20)

	c_symbol_printer(74+12),(209+20)
	ac_symbol_printer(104+12),(209+20)
	equal_symbol_printer(134+26),(209+20)
endm
;----------------------------------------------------------------------------

;---------------------------printing a character-----------------------------
character_printer macro character,r,c,col

	;character_printer is a macro created to facilitate writing on the 
	;screen, whenever you need to print a character just use
	;character_printer 'c',row,column,color

	;---set background/border color---
	mov ah,0bh
	mov bh,0h ;if bh were equal to 01h he would set palette
	
	mov bl,3
	int 10h

	;---set cursor position---
	mov ah,2
	mov bh,0
	mov dh,r
	mov dl,c
	int 10h

	;---write character and attribute at cursor position---
	mov ah,9
	mov al, character
	mov bl,col
	mov cx,1
	int 10h
endm
;----------------------------------------------------------------------------

;-----------------------------------mouse------------------------------------
initialize_mouse_cursor macro
	xor ax, ax
	int 33h ;mouse reset/get mouse installed flag

	mov ax,1 ;show mouse cursor
	int 33h 
endm
;----------------------------------------------------------------------------

;-------------------------------mouse position-------------------------------

;this part of the code serves to inform the position where the mouse
;is, to be able, for example, to click on a button

mouse_position macro vertical,horizontal
	local greater_than_horizontal,greater_than_vertical,cc3,less_than_horizontal,less_than_vertical,end_mouse_position_comparison
	mov ax,horizontal_mouse_position
	mov bx,vertical_mouse_position
	xor cx, cx
	cmp ax,horizontal
	jge greater_than_horizontal
	jmp end_mouse_position_comparison
	greater_than_horizontal: ;if horizontal_mouse_position is 
							 ;greater than horizontal

		sub ax,horizontal
		cmp ax,40
		jle less_than_horizontal
		jmp end_mouse_position_comparison
	less_than_horizontal: ;if horizontal_mouse_position is less
						  ;than horizontal

		inc cx
		cmp bx,vertical
		jge greater_than_vertical
		jmp end_mouse_position_comparison
	greater_than_vertical: ;if vertical_mouse_position is
						   ;greater than vertical

		sub bx,vertical
		cmp bx,25
		jle less_than_vertical
		jmp end_mouse_position_comparison
	less_than_vertical: ;if vertical_mouse_position is
						;less than vertical
						
		inc cx
		jmp end_mouse_position_comparison
	end_mouse_position_comparison:
endm
;----------------------------------------------------------------------------

;-----------------------------pressed character------------------------------
pressed_character macro
	local end_pressed_character
	local register_equal,register_ac,register_dell,register_off
	local register_0,register_1,register_2,register_3,register_4,register_5,register_6,register_7,register_8,register_9
	local register_plus,register_minus,register_multiply,register_divide
	local mouse_on_ac_button,mouse_on_dell_button,mouse_on_off_button
	local mouse_on_0_button,mouse_on_1_button,mouse_on_2_button,mouse_on_3_button,mouse_on_4_button,mouse_on_5_button,mouse_on_6_button,mouse_on_7_button,mouse_on_8_button,mouse_on_9_button
	local mouse_on_plus_button,mouse_on_minus_button,mouse_on_multiply_button,mouse_on_divide_button

	;whenever you use the local directive it cannot contain spaces
	;because otherwise it will give an error

	;local directive order
	;---local end---
	;---local registers functions---
	;---local registers numbers---
	;---local registers operations---
	;---local mouse position functions---
	;---local mouse position numbers---
	;---local mouse position operations---

	mouse_on_equal_button:
		mouse_position 134,209 ;if the mouse is on the equal button
		cmp cx,2
		je register_equal ;if cx is equal to 2, then the mouse is on the equal button
		cmp cx,2
		jne mouse_on_ac_button ;if the mouse is not on the equal button	
		register_equal: 
			mov cl, '=' ;if the mouse is on the equal button, then cl will be equal to '='
			mov registered_character,cl
	
	mouse_on_ac_button:
		mouse_position 104,209
		cmp cx,2
		je register_ac
		cmp cx,2
		jne mouse_on_dell_button
		register_ac:
			mov cl, 'a'
			mov registered_character,cl	
		
	mouse_on_dell_button:
		mouse_position 74,209
		cmp cx,2
		je register_dell
		cmp cx,2
		jne mouse_on_off_button
		register_dell:
			mov cl, 'c'
			mov registered_character,cl
	
	mouse_on_off_button:
		mouse_position 164,159
		cmp cx,2
		je register_off
		cmp cx,2
		jne mouse_on_0_button
		register_off:
			mov cl, '*'
			mov registered_character,cl
	
	mouse_on_0_button:
		mouse_position 164,59
		cmp cx,2
		je register_0
		cmp cx,2
		jne mouse_on_1_button
		register_0:
			mov cl, '0'
			mov registered_character,cl
	
	mouse_on_1_button:
		mouse_position 134,59
		cmp cx,2
		je register_1
		cmp cx,2
		jne mouse_on_2_button
		register_1:
			mov cl, '1'
			mov registered_character,cl
	
	mouse_on_2_button:
		mouse_position 134,109
		cmp cx,2
		je register_2
		cmp cx,2
		jne mouse_on_3_button
		register_2:
			mov cl, '2'
			mov registered_character,cl

	mouse_on_3_button:
		mouse_position 134,159
		cmp cx,2
		je register_3
		cmp cx,2
		jne mouse_on_4_button
		register_3:
			mov cl, '3'
			mov registered_character,cl
	
	mouse_on_4_button:
		mouse_position 104,59
		cmp cx,2
		je register_4
		cmp cx,2
		jne mouse_on_5_button
		register_4:
			mov cl, '4'
			mov registered_character,cl

	mouse_on_5_button:
		mouse_position 104,109
		cmp cx,2
		je register_5
		cmp cx,2
		jne mouse_on_6_button
		register_5:
			mov cl, '5'
			mov registered_character,cl
	
	mouse_on_6_button:
		mouse_position 104,159
		cmp cx,2
		je register_6
		cmp cx,2
		jne mouse_on_7_button
		register_6:
			mov cl, '6'
			mov registered_character,cl
	
	mouse_on_7_button:
		mouse_position 74,59
		cmp cx,2
		je register_7
		cmp cx,2
		jne mouse_on_8_button
		register_7:
			mov cl, '7'
			mov registered_character,cl	
	
	mouse_on_8_button:
		mouse_position 74,109
		cmp cx,2
		je register_8
		cmp cx,2
		jne mouse_on_9_button
		register_8:
			mov cl, '8'
			mov registered_character,cl
		
	mouse_on_9_button:
		mouse_position 74,159
		cmp cx,2
		je register_9
		cmp cx,2
		jne mouse_on_plus_button
		register_9:
			mov cl, '9'
			mov registered_character,cl	
	
	mouse_on_plus_button:
		mouse_position 164,9
		cmp cx,2
		je register_plus
		cmp cx,2
		jne mouse_on_minus_button
		register_plus:
			mov cl, '+'
			mov registered_character,cl
		
	mouse_on_minus_button:
		mouse_position 134,9
		cmp cx,2
		je register_minus
		cmp cx,2
		jne mouse_on_multiply_button
		register_minus:
			mov cl, '-'
			mov registered_character,cl
	
	mouse_on_multiply_button:
		mouse_position 104,9
		cmp cx,2
		je register_multiply
		cmp cx,2
		jne mouse_on_divide_button
		register_multiply:
			mov cl, 'x'
			mov registered_character,cl
	
	mouse_on_divide_button:
		mouse_position 74,9
		cmp cx,2
		je register_divide
		cmp cx,2
		jne end_pressed_character
		register_divide:
			mov cl, '/'
			mov registered_character,cl

			jmp end_pressed_character
	
	end_pressed_character:
endm
;----------------------------------------------------------------------------

;-------------------------------mouse pressed--------------------------------
mouse_pressed macro 
	local jump_ac,jump_off
	local jump_plus,jump_minus,jump_multiply,jump_divide
	local plus,multiply,minus,divide,check
	local number_1,number_2,final,not_number,proceed

	;if the mouse is pressed, then the mouse will be registered
	
	pressed_character

	;---dell---
	mov cl,'c'
	cmp registered_character,cl
	jne jump_ac
	
	xor dl,dl
	cmp length_first_number,dl
	je jump_ac
	dec length_first_number
	dec pixel_pointer 
	character_printer ' ',3,pixel_pointer,0 ;dell the last character

	;---ac---
	jump_ac:
		mov cl,'a'
		cmp registered_character,cl
		jne jump_off
		initializing_variables
		cleaning_screen

	;---off---
	jump_off:
		mov cl,'*'
		cmp registered_character,cl
		jne jump_plus
		returning_dos

	;---plus---
	jump_plus:
		mov cl,'+'
		cmp registered_character,cl
		jne jump_minus
		mov operator,cl
		character_printer '+',6,30,14
		mov dl,1
		cmp flag,dl
		je plus
		cmp flag,dl
		jne jump_minus
	plus:
		mov bl,2
		mov flag,bl
		mov pixel_pointer,bl
		call clear

	;---minus---
	jump_minus:
		mov cl,'-'
		cmp registered_character,cl
		jne jump_multiply
		mov operator,cl
		character_printer '-',6,30,14
		mov dl,1
		cmp flag,dl
		je minus
		cmp flag,dl
		jne jump_multiply
	minus:
		mov bl,2
		mov flag,bl
		mov pixel_pointer,bl
		call clear

	;---multiply---
	jump_multiply:
		mov cl,'x'
		cmp registered_character,cl
		jne jump_divide
		mov operator,cl
		character_printer 'x',6,30,14
		mov dl,1
		cmp flag,dl
		je multiply
		cmp flag,dl
		jne jump_divide
	multiply:
		mov bl,2
		mov flag,bl
		mov pixel_pointer,bl
		call clear

	;---divide---
	jump_divide:
		mov cl,'/'
		cmp registered_character,cl
		jne check
		mov operator,cl
		character_printer '/',6,30,14
		mov dl,1
		cmp flag,dl
		je divide
		cmp flag,dl
		jne check
	divide: ;
		mov bl,2
		mov flag,bl
		mov pixel_pointer,bl
		call clear
	
	;---check---
	check:
		mov cl,registered_character ;if the character is a number, then
									;it will be printed

		cmp cl,'0'
		jl not_number ;if the character is not a number, then
					  ;it will not be printed

		cmp cl,'9'
		jg not_number 
		mov cl,1 
		cmp flag,cl ;if the character is a number, then
					;it will be printed

		je number_1 ;number_1 is the first number
		mov cl,2  
		cmp flag,cl ;flag is 2, then it will be printed in
					;the second number

		je number_2
	not_number:
		jmp final
	number_1:
		first_number_entered
		jmp final
	number_2:
		second_number_entered
		jmp final
	
	final:
		mov cl,'=' 
		cmp registered_character,cl ;if the character is =, then the 
									;result will be printed

		jne proceed
		call mathematical_resolution
	proceed:
endm
;----------------------------------------------------------------------------

;----------------------------first number entered----------------------------
first_number_entered macro

	;this part of the server code to get the first number pressed and
	;display it on the calculator display

	xor cx,cx
	mov cl,length_first_number ;length_first_number is the number of
							   ;characters in the first number

	mov si,cx ;si is the number of characters in the first number

	mov cl,registered_character ;cl is the character pressed

	mov array_first_number[si],cl ;array_first_number is the array that
								  ;contains the first number

	inc length_first_number

	;---display the first number---
	character_printer registered_character,3,pixel_pointer,15
	
	;---increment the pixel pointer---
	inc pixel_pointer ;it is necessary to increment 1 pixel on
					  ;the display because if not, whenever a 
					  ;composite number was typed, for example
					  ;12, after pressing 1 and then 2, the 
					  ;number 2 would overlap 1
endm
;----------------------------------------------------------------------------

;---------------------------second number entered----------------------------
second_number_entered macro

	;this part of the server code to get the second number pressed and
	;display it on the calculator display

	xor cx,cx
	mov cl,length_second_number ;length_second_number is the length of the
								;second number

	mov si,cx
	mov cl,registered_character
	mov array_second_number[si],cl ;array_second_number is the array that
								   ;stores the second number

	inc length_second_number

	;---display the second number---
	character_printer registered_character,3,pixel_pointer,15

	;---increment the pixel pointer---
	inc pixel_pointer
endm
;----------------------------------------------------------------------------

;----------------------------cleaning the screen-----------------------------
cleaning_screen macro
	local cleaning_loop

	;without that part of code every time you type some operation the program
	;would keep the old digits, for example if i wanted to perform an
	;operation: 50 x 2 = 100 when typing the 2 keep the 0 of the 50 because
	;it didn't clear the screen, it just put 2 in front of the 5, making
	;it equal to 50 x 20 = 100

	mov cl,2
	mov variable_a,cl
	cleaning_loop:
	character_printer ' ',3,variable_a,0
	character_printer ' ',6,variable_a,0
	inc variable_a
	mov cl,variable_a
	cmp cl,30
	jl cleaning_loop
endm
;----------------------------------------------------------------------------

;-------------------------------output display-------------------------------
output_display macro wd,xxx
	local first_loop,secund_loop ;ATTENTION, ALWAYS REMEMBER THAT THE 
								 ;LOCATION MUST BE JUST BELOW THE MACRO

	;this part of the code is responsible for displaying the result of the
	;operation on the calculator display

	mov cl,0
	mov variable_a,cl
	mov ax,wd
	mov bl,10
	first_loop: ;this loop is responsible for getting the digits
				;of the result

		div bl
		mov dl,ah
		mov dh,0
		add dl,48
		mov ah,0
		push dx
		inc variable_a
		cmp al,0
		jg first_loop
		mov cl,xxx
		mov variable_c,cl

	secund_loop: ;this loop is responsible for displaying the result
		pop dx
		mov variable_b,dl
		character_printer variable_b,6,variable_c,15
		inc variable_c
		dec variable_a
		mov cl,variable_a
		cmp cl,0
		jne secund_loop	
endm
;----------------------------------------------------------------------------

;---------------------------initializing variables---------------------------
initializing_variables macro

	;this part of the code is responsible for initializing the variables
	;that are used in the program

	mov cx,0
	mov length_first_number,cl
	mov length_second_number,cl
	mov input_value,cx
	mov output_value,cx
	mov cl,1
	mov flag,cl ;flag is a variable that is used to know if the first number
				;or the second number is being typed

	mov cl,2
	mov pixel_pointer,cl
	cleaning_registers
endm
;----------------------------------------------------------------------------

;-----------------------------saving input value-----------------------------
saving_input_value macro
	local first_loop

	;this part of the code is responsible for saving the input value

	xor ax, ax
	mov bl,10
	xor ch,ch
	mov cl,length_first_number
	mov si,0
	first_loop:
		mul bl
		mov dl,array_first_number[si]
		inc si
		mov dh,0
		add ax,dx ;ax is the first input value and dx is the character
				  ;that is being converted to a number
		sub ax,48 
		loop first_loop
		mov input_value,ax ;input_value is the variable
						   ;that stores the input value

endm
;----------------------------------------------------------------------------

;----------------------------saving output value-----------------------------
saving_output_value macro
	local secund_loop	
	xor ax, ax
	mov bl,10
	xor ch,ch
	mov cl,length_second_number
	mov si,0
	secund_loop:
		mul bl
		mov dl,array_second_number[si]
		inc si
		mov dh,0
		add ax,dx
		sub ax,48
		loop secund_loop
	mov output_value,ax
endm
;----------------------------------------------------------------------------

.code

main proc
	;-------------------------------calling macros-------------------------------

	;this part of the code is responsible for calling all the macros needed 
	;to start the calculator in case of a problem in the code, just comment
	;one of the macros until you find out in which part the error is

    setmode
	drawouter
	calculator_display
	button_border_printer
	symbols_printer
	print_imput_output
	initialize_mouse_cursor
	initializing_variables
	cleaning_registers
	;----------------------------------------------------------------------------
	
	;-------------------------initializing mouse cursor--------------------------
	initializing_mouse_cursor:

		;this part of the code is responsible for getting the
		;position of the mouse cursor

		xor ax, ax
		mov horizontal_mouse_position,ax
		mov vertical_mouse_position,ax
	;----------------------------------------------------------------------------
	
	;-------------------------------waiting press--------------------------------
	waiting_press:

		;this part of the code is responsible for waiting for the user to press
		;the mouse cursor

		mov ax,5
		mov bx,0
		int 33h
		cmp ax,1
		je jump_1
		cmp ax,1
		jne waiting_press
		jump_1:
			shr cx,1
			cmp cx,horizontal_mouse_position
			je waiting_press
			cmp cx,horizontal_mouse_position
			jne pressed
			pressed:
					;this part of the code is responsible for getting the
					;position of the mouse cursor when the user clicks

				mov horizontal_mouse_position,cx
				mov vertical_mouse_position,dx
				mouse_pressed
				jmp waiting_press
	;----------------------------------------------------------------------------
	
	;------------------------finishing the main structure------------------------
		returning_dos
		main endp
		clear proc
		cleaning_screen
		ret
		clear endp	
	;----------------------------------------------------------------------------
	

mathematical_resolution proc
	mov cl,2
	mov variable_d,cl
	saving_input_value
	saving_output_value

;----------------------------------operator----------------------------------

	;in this part of the code it will be analyzing the type of operator, for
	;example, if it is a +, it will call the add function, but if not, it
	;will give a jump until it finds out which operator it is

	mov cl,operator
	
	addition:
		;---add---
		cmp cl,'+'
		jne subtraction
		xor dx, dx
		add dx,input_value
		add dx,output_value
		mov output_value,dx
	
	subtraction:
		;---sub---	
		cmp cl,'-'
		jne multiplication
		
		mov dx,input_value
		cmp dx,output_value
		jge positive
		cmp dx,output_value
		jl negative
		
		positive:
			sub dx,output_value
			mov output_value,dx
			jmp multiplication
		
		negative:
			mov dx,output_value
			sub dx,input_value
			mov output_value,dx
			inc variable_d
			character_printer '-',6,2,15
		
	multiplication:
		;---mul---	
		cmp cl,'x'
		jne division
		
		mov ax,input_value
		mov bx,output_value
		mul bx
		mov output_value,ax
	
	division:
		;---div---
		cmp cl,'/'
		jne result	
		mov ax,input_value
		mov bx,output_value
		cmp bl,0
		je extension_cord
		div bl
		mov ah,0
		mov output_value,ax
		jmp result
	
	extension_cord:
		;The only function of this jump is to serve as a 
		;"signal repeater", because if it were to jump directly to 
		;"divide_zero" it would give the error of relative jump out of range
		;in 000Bh bytes

		jmp divide_zero ;this jump is responsible for printing the error message
						;in case the user tries to divide by zero
	
	result:
		;result is the jump that is responsible for printing the result
		character_printer '=',6,30,14
		output_display output_value,variable_d
		jmp jump_ret

	divide_zero:
		;easter egg!!!!!!!!!!!!

		character_printer 'O',6,2,01
		character_printer 'l',6,3,02
		character_printer 'a',6,4,03
		character_printer ',',6,5,04
		character_printer 'P',6,7,05
		character_printer 'a',6,8,06
		character_printer 'n',6,9,07
		character_printer 'n',6,10,08
		character_printer 'a',6,11,09
		character_printer 'i',6,12,10
		character_printer 'n',6,13,11
		character_printer '!',6,14,14
		character_printer '!',6,15,15
		character_printer ':',6,20,12
		character_printer ')',6,21,13

	jump_ret:
		ret
;----------------------------------------------------------------------------

	mathematical_resolution endp
end main