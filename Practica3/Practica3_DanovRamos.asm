.data
#Guardar palabras
A: .space 100
B: .space 100
C: .space 200
#Textos utilizados
Texto: .asciiz "\nCadena de entrada: "
Texto2: .asciiz "\nLa cadena resultante es "
Texto3: .asciiz " y tiene "
Texto4: .asciiz " caracteres."

.text
main:	   la $a0, Texto		#Imprime el mensaje Texto
	   li $v0, 4
	   syscall
	   
	   li $v0, 8			#Guarda la cadena A
	   li $a1, 95
	   la $a0, A
	   syscall 
	   
	   la $a0, Texto		#Imprime el mensaje Texto
	   li $v0, 4
	   syscall
	   
	   li $v0, 8			#Guarda la cadena B
	   li $a1, 95
	   la $a0, B
	   syscall 	   
	   la $a0, A			#Elimina \n en la primera cadena
      	   jal Corrector		

      	   la $a0, B			#Elimina \n en la segunda cadena  
      	   jal Corrector		    	   
      	         	
      	   la $a0, A			#Invierte la cadena A
      	   jal Invertir		        
      	   
      	   la $a0, B			#Invierte la cadena B
      	   jal Invertir		        
      	     
      	   la $a0, A
      	   la $a1, B    
      	   la $a2, C
      	   jal Concatenar		#Se guarda en C la concatenación de A y B	            
      	   add $s0, $v0, $zero	    	#Guarda el número de caracteres  
      	                     	            
      	   la $a0, Texto2		#Imprime el mensaje Texto2
	   li $v0, 4
	   syscall
            	            	            	            
      	   la $a0, C			#Imprime el resultado al usuario (Concatenación)
	   li $v0, 4
	   syscall
	
	   la $a0, Texto3		#Imprime el mensaje Texto3
	   li $v0, 4
	   syscall
	   
	   add $a0, $s0, $zero		#Imprime el número de caracteres de la cadena concatenada
	   li $v0, 1
	   syscall
	   
	   la $a0, Texto4		#Imprime el mensaje Texto4
	   li $v0, 4
	   syscall
	   	   	            
      	   li $v0 10
      	   syscall

     	   
Corrector: lb $t0, 0($a0)
	   addi $a0, $a0, 1
	   beq $t0, 10, Cambiar		
	   bne $t0, $zero, Corrector	#Sigue recorriendo la cadena
	   add $t0, $zero, $zero	#Deja $t0 a 0
	   jr $ra
	   
Cambiar:   addi $a0, $a0, -1		#Cambia \n por 0
	   sb $zero, 0($a0)
	   add $t0, $zero, $zero	#Deja $t0 a 0
	   jr $ra 


Invertir:  add $t0, $zero, $a0
Contar:    addi $t0, $t0, 1
	   lb $t1, 0($t0)
	   bne $t1, $zero, Contar	#Recorre la cadena hasta el final
	   addi $t0, $t0, -1		#Ajusta la posición
	   
Hacer:     lb $t1, 0($a0)		#Guarda la última posición en la primera
	   lb $t2, 0($t0)
	   sb $t1, 0($t0)
	   sb $t2, 0($a0)
	   
	   addi $a0, $a0, 1		#Cambia los valores para continuar con el bucle
	   addi $t0, $t0, -1
	   
	   slt $t3, $a0, $t0		#Comprueba si tiene que continuar
	   bne $t3, $zero, Hacer
	   
	   jr $ra
	   
	   
Concatenar:add $v0, $zero, $zero	#Contador de caracteres en $v0

Segundo:   lb $t1, 0($a1)
	   beq $t1, $zero, Primero		#Has terminado la segunda cadena
	   sb $t1, 0($a2)
	   addi $a1, $a1, 1
	   addi $a2, $a2, 1
	   addi $v0, $v0, 1
	   j Segundo
	   
Primero:   lb $t0, 0($a0)
           beq $t0, $zero, Fin	#Has terminado la primera cadena
           sb $t0, 0($a2)
           addi $a0, $a0, 1		
           addi $a2, $a2, 1
           addi $v0, $v0, 1
           j Primero
           	   
Fin:       jr $ra
