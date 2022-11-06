TITLE NOME: Giovani Bellini dos Santos, RA: 22007263 | Joao Victor Rokemback Tapparo, RA:22003236

.model small
.data
    msg0 db 10,"- CALCULADORA -",10,'$'
    msg1 db "Digite um dos 4 numeros a baixo para a respequitivas operacoes matematicas",10,'$'
    msg2 db "[1] - Soma",10,'$'
    msg3 db "[2] - Subtracao",10,'$'
    msg4 db "[3] - Multiplicacao",10,'$'
    msg5 db "[4] - Divisao",10,'$'
    msg6 db 10, "Digite o primeiro numero:",'$'
    msg7 db 10, "Digite o segundo numero:", '$'
    msg8 db 10,"- - SOMA - -", 10,'$'
    msg9 db 10,"- - SUBTRACAO - -", 10,'$'
    msg10 db 10,"- - MULTIPLICA - -", 10, '$'
    msg11 db 10,"- - DIVISAO - -", 10, '$'
    msg12 db 10,"O resultado da operacao eh:",'$'  
    msg13 db 10,"deseja repetir a conta? S para sim caso contrario de enter:",'$'  
    msg14 db 10,"o resultado da divisao eh:",'$'
    msg15 db 10,"o resto da divisao eh:",'$'
.code
calculadora PROC

        SIM2:

        ;-----inicializando o data----- 
        mov ax,@data
        mov ds,ax

;-----prints----- 
menu_escolha_1_a_4:
        mov ah,9 ;imprimindo "calculadora"
        mov dx,offset msg0
        int 21h
        
        mov ah,9 ;imprimindo explicação da calculadora 
        mov dx,offset msg1
        int 21h

                ;---imprimindo msg2 "soma"---
                mov ah,9
                mov dx,offset msg2
                int 21h

                ;---imprimindo msg3 "subtração"---
                mov ah,9
                mov dx,offset msg3
                int 21h
                
                ;---imprimindo msg4 "multiplicação"---
                mov ah,9
                mov dx,offset msg4
                int 21h

        mov ah,9 ;imprimindo divisão
        mov dx,offset msg5
        int 21h
        
;-----lendo o numero e dando seu respectivo jump-----
        mov ah,01h ; lendo numero escolhido e quardando em al
        int 21h
        sub al,30h ;transformando o al em digito para uso interno do programa

                ;---comparação e jump para a soma---
                cmp al,1
                je SOMA

                ;---comparação e jump para a subtração---
                cmp al,2 
                je SUBI

                ;---comparação e jump para a multiplicação--- 
                cmp al,3 
                je MULTI

                ;---comparação e jump para a divisão---
                cmp al,4  
                je DIVI

                ;---jump caso o usuario digite um numro maior do que o numero de operações---
                cmp al,4
                ja menu_escolha_1_a_4
        ;----------------------------------------------------------------------------

                ;------------------------------------jump multiplicação------------------------------------
                        MULTI:;devido o jump condicional ser muito não "alcançar" onde ele deve ir
                                jmp MULTI2; usamos um jump condicional para um incondicional para pular para o lugar certo 
                ;------------------------------------------------------------------------------------------
                ;------------------------------------jump Divisão------------------------------------
                        DIVI:;devido o jump condicional ser muito não "alcançar" onde ele deve ir
                                jmp DIVI2; usamos um jump condicional para um incondicional para pular para o lugar certo 
                ;------------------------------------------------------------------------------------

        ;------------------------------------soma------------------------------------
        SOMA:
                ;---imprimindo msg8 "titulo soma"
                mov ah,9 
                mov dx,offset msg8
                int 21h

                ;---imprimindo msg6 "Digite o primeiro numero"---
                mov ah,9  
                mov dx,offset msg6
                int 21h

                ;---lendo o numero digitado---
                mov ah,01h
                int 21h

                ;---movendo o valor digitado em al para bh---
                mov bl,al

                ;---transformando o bl em digito para uso interno do programa---
                sub bl,30h

                ;---imprimindo msg7 "Digte o segundo numero"---
                mov ah,9
                mov dx,offset msg7
                int 21h

                ;---lendo o numero digitado---
                mov ah,01h
                int 21h
                
                ;---movendo o valor digitado em al para bh---
                mov bh,al

                ;---transformando o bl em digito para uso interno do programa---
                sub bh,30h

                ;---somando bh e bl---
                add bh,bl

                ;---imprimindo o resultado da soma(msg12)---
                mov ah,9
                mov dx,offset msg12
                int 21h

                ;---compara bh,que esta com o resultado da soma, com 9 para saber se ele possui ou não dois digitos---
                cmp bh,09
                jle UM; caso o numro,em bh, for maior que 09 ele é um numero de dois digitos então o programa não efetuara o jump 

                ;---zerando os registradores para usar eles na divisão---
                xor ax,ax
                xor cx,cx
                xor dx,dx

                ;---iniciando os registradores com os numeros para a divisão e dividindo---
                mov cl,10
                mov al,bh
                div cl

                ;---salvando ah para não perder ele com a movimentação de funções---
                mov bl,ah

                ;---imprimindo o primeiro numero---
                mov dl,al
                add dl,30h
                mov ah,02
                int 21h
                
                ;---imprimindo o segundo numero---
                mov dl,bl
                add dl,30h
                int 21h



                jmp FINAL ;jump incondicinal para finalizar o programa
                UM:;caso o numro,em bh, seja menor ou igual a 09 ele possui somente um digito então o programa efetua o jump para essa linha  

                        add bh,30h ;tornando o bh em caracter novamente para imprimi ele
                        mov dl,bh
                        mov ah,02
                        int 21h       
                
                        jmp FINAL
        ;----------------------------------------------------------------------------


        ;------------------------------------subtração------------------------------------
        SUBI:

                mov ah,9 ;imprimindo "subtração"
                mov dx,offset msg9
                int 21h

                mov ah,9 ;perguntand pelo primeiro nuemro  
                mov dx,offset msg6
                int 21h

                mov ah,01h ; lendo numero escolhido e quardando em bl
                int 21h
                mov bl,al

                ;---transformando o bl em digito para uso interno do programa---
                sub bl,30h

                mov ah,9 ;perguntand pelo segundo nuemro  
                mov dx,offset msg7
                int 21h

                mov ah,01h ; lendo numero escolhido e quardando em bh
                int 21h
                mov bh,al
                sub bh,30h; tranformando o bh em digito para uso interno do sistema

                cmp bh, bl; esse é uma comparação para ver qual dos dois numeros digitados é maior para assim executar ou não o jump
                ja NEGAT ;jump se caso o numro qualdado em bh for maior que o quardade em bl, e com isso o resultado sera negativo 
                sub bl,bh ;subtraindo os dois numeros esolhidos pelo usuario

                mov ah,9 ;imprimindo mensagen de resultado da subtração  
                mov dx,offset msg12
                int 21h

                add bl,30h ;tornando o bl em caracter novamente para imprimi ele
                mov dl,bl
                mov ah,02
                int 21h   

                jmp FINAL
                NEGAT: ;caso o resultado da subtração for negativo ele ira dar um jump condicional para ca 

                        sub bh, bl; subtraindo os dois numeros escolhidos pelo usuario 

                        mov ah,9 ;imprimindo mensagen de resultado da subtração  
                        mov dx,offset msg12
                        int 21h

                        mov dl,45 ;imprimindo um sinal de neg para o resultado seja negativo 
                        mov ah,02
                        int 21h

                        add bh,30h ;tornando o bh em caracter novamente para imprimi ele
                        mov dl,bh
                        mov ah,02
                        int 21h 

                        jmp FINAL ;jump incondicional para finalizar o programa

        ;----------------------------------------------------------------------------------  

        ;------------------------------------multiplicação------------------------------------
        MULTI2:

                ;---imprimindo msg10 "titulo multiplicação"
                mov ah,9 
                mov dx,offset msg10
                int 21h

                ;---imprimindo msg6 "Digite o primeiro numero"---
                mov ah,9  
                mov dx,offset msg6
                int 21h

                ;---lendo o numero digitado---
                mov ah,01h
                int 21h

                ;---movendo o valor digitado em al para bh---
                mov bl,al

                ;---transformando o bl em digito para uso interno do programa---
                sub bl,30h

                ;---imprimindo msg7 "Digte o segundo numero"---
                mov ah,9
                mov dx,offset msg7
                int 21h

                ;---lendo o numero digitado---
                mov ah,01h
                int 21h
                
                ;---movendo o valor digitado em al para bh---
                mov bh,al

                ;---transformando o bl em digito para uso interno do programa---
                sub bh,30h

                ;---imprimindo o resultado da soma(msg12)---
                mov ah,9
                mov dx,offset msg12
                int 21h

                ;---iniciando cl parausar ele de contaodr no loop---
                mov cl,4

                ;---arrumando os numeros dentra do registrador---
                shl bh,4        

                MULT3:

                ;---testando bl com 1 se for igual a 1 ele soma se for 0 ele ignora
                test bl,01h     

                jz zero
                add bl,bh
                zero:
                shr bl,1;próximo bit
                dec cl
                jnz MULT3

                xor ax,ax;zera ax só pra ter certeza de que ah vai estar vazio
                mov al,bl
                mov bh,10       
                div bh          ;binario para decimal
                mov bl,ah       ;unidade

                mov ah,2h
                mov dl,al       ;dezena
                add dl,30h
                int 21h
                mov dl,bl
                add dl,30h
                int 21h

                jmp FINAL

        ;-------------------------------------------------------------------------------------

        ;------------------------------------divisão------------------------------------
        DIVI2:

                ;---imprimindo msg11 "titulo divisão"
                mov ah,9 
                mov dx,offset msg11
                int 21h

                ;---imprimindo msg6 "Digite o primeiro numero"---
                mov ah,9  
                mov dx,offset msg6
                int 21h

                ;---lendo o numero digitado---
                mov ah,01h
                int 21h

                ;---movendo o valor digitado em al para bh---
                mov bl,al

                ;---transformando o bl em digito para uso interno do programa---
                sub bl,30h

                ;---imprimindo msg7 "Digte o segundo numero"---
                mov ah,9
                mov dx,offset msg7
                int 21h

                ;---lendo o numero digitado---
                mov ah,01h
                int 21h
                
                ;---movendo o valor digitado em al para bh---
                mov bh,al

                ;---transformando o bl em digito para uso interno do programa---
                sub bh,30h

                ;---imprimindo o resto  da divisão(msg14)---
                mov ah,9
                mov dx,offset msg14
                int 21h

                ;---setando ch para o loop---
                mov ch,4

                ;---arrumando os numros dentro dos registradores---
                shl bh,4
                shl bl,1

                ;---parte de divisão---
                DIVI3:
                sub bl,bh
                cmp bl,0
                jge D1
                add bl,bh
                shl bl,1
                jmp D0
                D1:
                shl bl,1
                add bl,1
                D0:
                dec ch
                jnz DIVI3

                mov al,bl
                and al,0F0H
                shr al,5
                and bl,0FH
                
                ;---imprimindo o resultado---
                mov AH,2
                mov dl,bl
                mov bl,al
                add dl,30h
                int 21h

                ;---imprimindo o resultado do restos da divisão4(msg15)---
                mov ah,9
                mov dx,offset msg15
                int 21h

                ;---parte que imprimi o resto---
                mov ah,02
                mov dl,bl
                add dl,30h
                int 21h

        ;-------------------------------------------------------------------------------              


        ;-----finalizar codigo----- 

        FINAL:

                ;---imprimindo msg13 "quer fazer uma nova operação"
                mov ah,9 
                mov dx,offset msg13
                int 21h

                ;---pegando a letra digitada pelo usuario 
                mov ah,01h
                int 21h

                ;---comparando a letra com S e s para saber se o usuraio deseja repetir o programa 
                cmp al,'S'
                je SIM
                cmp al,'s'
                je SIM

                ;---jumps condicionais e incondicionais que seram ativados ou não de acordo com o que o usuario responder na pergunta acima 
                jmp NAO

                        SIM:
                        jmp SIM2

                NAO:

                mov ah,4ch 
                int 21h
calculadora ENDP
END calculadora