TITLE NOME: Giovani Bellini dos Santos, RA: 22007263 | Joao Victor Rokemback Tapparo, RA:22003236

.model small

.data
    msg0 db 10,"<>----------CALCULADORA----------<>",10,'$'
    msg1 db " | [1] - Soma                    |",10,'$'
    msg2 db " | [2] - Subtracao               |",10,'$'
    msg3 db " | [3] - Multiplicacao           |",10,'$'
    msg4 db " | [4] - Divisao                 |",10,'$'
    msg5 db " | [5] - Sair                    |",10,'$'
    msg6 db "<>-------------------------------<>",10,'$'
    msg7 db 10,"Digite a opcao desejada: ",'$'
    msg8 db 10, "Digite o primeiro numero:",'$'
    msg9 db 10, "Digite o segundo numero:", '$'
    msg10 db 10,"- - SOMA - -",'$'
    msg11 db 10,"- - SUBTRACAO - -",'$'
    msg12 db 10,"- - MULTIPLICA - -",'$'
    msg13 db 10,"- - DIVISAO - -",'$'
    msg14 db 10,"O resultado da operacao eh:",'$' 
    msg15 db 10,"deseja repetir a conta? S para sim caso contrario de enter:",'$'  
    msg16 db 10,"Obrigado por usar a calculadora!",'$'
    msg17 db 10,"o resto da divisao eh:",'$'
    msg18 db 10,'voce nao digitou um numero, porfavor digite tente novamente:',"$"



;---return to dos---
returning_dos macro
    mov ah,4ch
    int 21h
endm

;------------------------------printing header-------------------------------
printing_header macro

        ;printing header is a macro that prints the header of the program

        ;---printing msg0, "Calculadora"---
        mov ah,9
        mov dx,offset msg0
        int 21h

        ;---printing msg1, "Soma"---
        mov ah,9
        mov dx,offset msg1
        int 21h

        ;---printing msg2, "Subtracao"---
        mov ah,9
        mov dx,offset msg2
        int 21h
        
        ;---printing msg3, "Multiplicacao"---
        mov ah,9
        mov dx,offset msg3
        int 21h

        ;---printing msg4, "Divisao"---
        mov ah,9
        mov dx,offset msg4
        int 21h

        ;---printing msg5, "Sair"---
        mov ah,9
        mov dx,offset msg5
        int 21h

        ;---printing msg6---
        mov ah,9
        mov dx,offset msg6
        int 21h
        
endm
;----------------------------------------------------------------------------

;------------------------------choosing option-------------------------------
choosing_option macro

        ;choosing option is a macro that prints the header of the program

        invalid_option:
                ;---printing msg7, "Digite a opcao desejada: "---
                mov ah,9
                mov dx,offset msg7
                int 21h

                ;---reading the option---
                mov ah,01h
                int 21h

                sub al,30h

                ;---checking if the option is valid---
                cmp al,5
                jg invalid_option
                cmp al,1
                jl invalid_option

                ;---compering for the plus jump---
                cmp al,1
                je SOMA

                ;---compering for the minus jump---
                cmp al,2 
                je SUBI

                ;---compering for the multiplication jump---
                cmp al,3 
                je MULTI

                ;---compering for the division jump---
                cmp al,4  
                je DIVI

                ;---compering for the exit jump---
                returning_dos
                
endm
;----------------------------------------------------------------------------

;------------------------------------plus------------------------------------
addition macro

                ;---printing msg10, "SOMA"---
                mov ah,9 
                mov dx,offset msg10
                int 21h

                ;---printing msg8, "Digite o primeiro numero:"---
                mov ah,9  
                mov dx,offset msg8
                int 21h

                ;---reading the first number---
                mov ah,01h
                int 21h

                ;---moving the number to the register bl---
                mov bl,al

                call checador_de_numero_Bl;check if the number is valid

                sub bl,30h

                ;---printing msg9, "Digite o segundo numero:"---
                mov ah,9
                mov dx,offset msg9
                int 21h

                ;---reading the second number---
                mov ah,01h
                int 21h
                
                ;---moving the second number to bh---
                mov bh,al

                call checador_de_numero_BH;check if the number is valid

                ;---turning the caracter into a number---
                sub bh,30h


                ;---adding the numbers---
                add bh,bl

                ;---printing msg14, "O resultado da operacao eh:"---
                mov ah,9
                mov dx,offset msg14
                int 21h

                cmp bh,09;compare bh, which is with the result of the
                         ;sum, with 9 to know if it has two digits or not
                         
                jle UM;if the number, in bh, is greater than 09 it is a number
                       ;of digits then the program does not structure the jump
                       ;to two digits

                ;---zero the al the register---
                xor ax,ax
                xor cx,cx
                xor dx,dx

                ;---initializing the register to use on the division---
                mov cl,10
                mov al,bh
                div cl

                ;---saving the ah value in the register bl---
                mov bl,ah

                ;---printing the first digit---
                mov dl,al
                add dl,30h
                mov ah,02
                int 21h
                
                ;---printing the second digit---
                mov dl,bl
                add dl,30h
                int 21h

                jmp FINAL ;jump to the end of the macro

                UM:;in case of the number in bh is less  or igual to 09 it is
                   ;a number of one digit then the program does not
                   ;structure the jump to two digits 

                        add bh,30h ;turning the number into a caracter
                        mov dl,bh
                        mov ah,02
                        int 21h       
                
endm
;----------------------------------------------------------------------------

;---------------------------------subtraction----------------------------------

subtraction macro
                mov ah,9 ;printing "subtração"
                mov dx,offset msg11
                int 21h

                mov ah,9 ;asking for the first number 
                mov dx,offset msg8
                int 21h

                mov ah,01h ;moving the first number to the register bl
                int 21h
                mov bl,al

                call checador_de_numero_BL;check if the number is valid

                ;---turning the caracter into a number---
                sub bl,30h

                mov ah,9 ;asking for the second number 
                mov dx,offset msg9
                int 21h

                mov ah,01h ;moving the second number to the register bh
                int 21h
                mov bh,al

                call checador_de_numero_BH;check if the number is valid

                sub bh,30h;turning the caracter into a number

                cmp bh,bl; this is to check if the first number is bigger
                          ;than the second number
                ja NEGAT ; if the first number is bigger than the second number
                         ;the program does not structure the jump to the
                         ;negative number 
                sub bl,bh ;subtraction of the numbers

                mov ah,9 ; printing "O resultado da operacao eh:" 
                mov dx,offset msg14
                int 21h

                add bl,30h ;turning the number into a caracter and printing it
                mov dl,bl
                mov ah,02
                int 21h   

                jmp FINAL
                NEGAT: ;if the first number is smaller than the second number

                        sub bh,bl; subtraction of the numbers 

                        mov ah,9 ; printing "O resultado da operacao eh:"
                        mov dx,offset msg14
                        int 21h

                        mov dl,45 ;printing the negative sign
                        mov ah,02
                        int 21h

                        add bh,30h ;turning the number into a caracter and printing it
                        mov dl,bh
                        mov ah,02
                        int 21h
                        
endm
;----------------------------------------------------------------------------

;-------------------------------multiplication--------------------------------
macro_multiplicadora macro

                ;---printing msg12 "titulo multiplicação"
                mov ah,9 
                mov dx,offset msg12
                int 21h

                ;---printing msg8 "Digite o primeiro numero"---
                mov ah,9  
                mov dx,offset msg8
                int 21h

                ;---reading the first number---
                mov ah,01h
                int 21h

                ;---moving the number to the register bl---
                mov bl,al

                call checador_de_numero_Bl;check if the number is valid

                ;---turning the caracter into a number---
                sub bl,30h

                ;---printing msg9 "Digte o segundo numero"---
                mov ah,9
                mov dx,offset msg9
                int 21h

                ;---reading the second number---
                mov ah,01h
                int 21h

                ;---moving the second number to bh---
                mov bh,al
                
                call checador_de_numero_BH;check if the number is valid

                ;---turning the caracter into a number---
                sub bh,30h

                ;---printing msg14 "O resultado da operacao eh:"---
                mov ah,9
                mov dx,offset msg14
                int 21h

                ;---inicializing the registers to make the loop---
                mov cl,4

                ;---organizing the bh register---
                shl bh,4        

                MULT3:

                ;--- testing if bl is 1 if it is 1 it sums if it is 0 it ignores---
                test bl,01h     
                jz zero

                ;---sum bh with bl  who is the result register---
                add bl,bh

                zero:

                ;---moving bl one position to the right---
                shr bl,1

                ;---decrementing cl---
                dec cl
                jnz MULT3;jump loop

                ;---initializing ax to use on the division---
                xor ax,ax

                ;---saving the value of bl in al---
                mov al,bl

                ;---colocando 10 em bh para usar ele na divisão---
                mov bh,10 
                
                ;---dividindo o resultado da multiplicação por 10 caso ele tenha mais de um digito---
                div bh          

                ;---salvando o resultado de ah que é a dezena em bl---
                mov bl,ah       

                ;---inicializando ah com a função de imprimir caracter---
                mov ah,2h

                ;---printing a casa da unidade---
                mov dl,al       
                add dl,30h
                int 21h

                ;---printing a casa da dezena do resultado---
                mov dl,bl
                add dl,30h
                int 21h

                

endm
;----------------------------------------------------------------------------

;----------------------------------division-----------------------------------
macro_divisora macro

                ;---printing msg13 "titulo divisão"
                mov ah,9 
                mov dx,offset msg13
                int 21h

                ;---printing msg8 "Digite o primeiro numero"---
                mov ah,9  
                mov dx,offset msg8
                int 21h

                ;---reading the first---
                mov ah,01h
                int 21h

                ;---moving the valeu of al to bl---
                mov bl,al

                call checador_de_numero_BL;cheking if the caracter is a number

                ;---turnig bl in a to a digit---
                sub bl,30h

                ;---printing msg9 "Digte o segundo numero"---
                mov ah,9
                mov dx,offset msg9
                int 21h

                ;---reading the second number---
                mov ah,01h
                int 21h
                
                ;---moving the valeu of al to bh---
                mov bh,al

                call checador_de_numero_BH;cheking if the caracter is a number

                ;---turnig bh in a to a digit---
                sub bh,30h

                ;---print msg14 "resultado da divisão"---
                mov ah,9
                mov dx,offset msg14
                int 21h

                ;---seting the ch for the loop---
                mov ch,4

                ;---organazing the numbers in the registers---
                shl bh,4
                shl bl,1

                ;---devision loop---
                DIVI3:

                ;---subtracting bl from bh---
                sub bl,bh

                ;---test if bl is bigger or less than zero---
                ;---for the program know if it gona shift the quotient or restore the original value---
                cmp bl,0

                jge D1;jump if bl is bigger or equal to zero

                ;---restoring the valeu of bh---
                add bl,bh

                ;---shifting the quotient register---
                shl bl,1

                jmp D0;jump to the end of the loop

                D1:

                ;moving bl to the left and seting a new MSB---
                shl bl,1
                add bl,1

                D0:

                ;---decrementing ch---
                dec ch
                jnz DIVI3

                mov al,bl
                and al,0F0H
                shr al,5
                and bl,0FH
                
                ;---printing the result---
                mov ah,02h
                add bl,30h;turning the number into a caracter
                mov dl,bl
                mov bl,al ;moving the rest to bl
                int 21h

                ;---print msg17 "resto da divisão"---
                mov ah,9
                mov dx,offset msg17
                int 21h

                ;---part of the code that prints the rest---
                mov ah,02h
                add bl,30h
                mov dl,bl
                int 21h

endm
;----------------------------------------------------------------------------
.code

calculadora PROC

              ;---function to clear the screen---
                mov ah,0;seting video mode
                mov al,6;text type
                int 10h;executing the function
;function who change the color of the
                

        SIM2:

            ;---initializing the data---
            mov ax,@data
            mov ds,ax

            ;---printing msg1 "titulo calculadora" an choosing option---
            printing_header
            choosing_option


            ;------------------------------------jump multiplication------------------------------------
            MULTI:;multiplication jump but the conditional jump is to small to reach this point
                    jmp MULTI2; so we use the conditional jump to a inconditional jump 
            ;------------------------------------------------------------------------------------------
            ;------------------------------------jump Division-----------------------------------
            DIVI:;division jump but the conditional jump is to small to reach this point
                    jmp DIVI2; so we use the conditional jump to a inconditional jump
            ;------------------------------------------------------------------------------------

                ;------------------------------------jump who call the macros------------------------------------
                SOMA:
                    addition
                    jmp final
                SUBI:
                    subtraction
                    jmp final
                MULTI2:
                    macro_multiplicadora 
                    jmp final
                DIVI2:
                    macro_divisora
                    jmp final
                ;-------------------------------------------------------------------------------------------------            


            ;---ending in program--- 

            FINAL:

                    ;---printing msg15, "Deseja fazer outra operacao? (S/N)"---
                    mov ah,9 
                    mov dx,offset msg15
                    int 21h

                    ;---pick the caracter typed by the user---
                    mov ah,01h
                    int 21h

                    ;---comparing the caracter with S and s to know if the user wants to repeat the program---
                    cmp al,'S'
                    je SIM
                    cmp al,'s'
                    je SIM

                    ;---jump conditional and inconditional that will be activated or not according to what the user answers in the question above---
                    jmp NAO

                            SIM:
                            jmp SIM2

                NAO:
                ;---printing msg16 "Obrigado por usar a calculadora"---
                mov ah,9
                mov dx,offset msg16
                int 21h

                ;---ending the program---
                mov ah,4ch 
                int 21h

                
calculadora ENDP
checador_de_numero_BH proc ;procedment to check if the caracter typed by the user is a number (in bh)
 
        jmp IGNORA1;inconditional jump for the progrma ignore a section of the code
        NAONUMERO1:


           mov dx,offset msg18 ;invalid number menssager 
           mov ah,09h 
              int 21h

           mov ah,01h;re reading o numero
           int 21h
           mov bh,al

        IGNORA1:;it will be ognore antil the conditional jump is activated

           ;---cheking if the caracter is a number with conditional jumps---
                cmp bh,'0'
                jb  NAONUMERO1

                cmp bh,'9'
                ja  NAONUMERO1
          ;-----------------------------------------------------------------------------------------------------------------------------------------------------


        ret 
           
 checador_de_numero_BH endp

 checador_de_numero_BL proc;procedment to check if the caracter typed by the user is a number (in bl)
 

       jmp IGNORA2
        NAONUMERO2:


           mov dx,offset msg18 ;printing msg18 "numero invalido"
           mov ah,09h 
              int 21h

           mov ah,01h;re reading the number
           int 21h
           mov bl,al

        IGNORA2:; it will be ignore antil the conditional jump is activated 

            ;---cheking if the caracter is a number with conditional jumps---
                cmp bl,'0'
                jb  NAONUMERO2

                cmp bl,'9'
                ja  NAONUMERO2
            ;-----------------------------------------------------------------------------------------------------------------------------------------------------


        ret
checador_de_numero_Bl endp


END calculadora