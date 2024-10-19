.data
A: .ascii "Hola mundo"
B: .space 100
C: .space 100
D: .word 100

.text
main:	   la $s1, A
      	   la $s2, B
      	   la $s3, C
     	   la $s4, D   
      	
     	   add $t2, $zero, $zero	 #Declaración contador
      	   add $t1, $s1, $zero
        
Contar:    lb $t6, 0($t1)		#Cargas posición
	   addi $t2, $t2, 1		#Incrementas Contador
	   addi $t1, $t1, 1		#Incrementas posición
	   bne $t6, $zero, Contar	#caracter != 0
	
	   subi $t2, $t2, 1		#Ajuste del indice
	   add $s5, $t2, $zero		#Guardas la posición
		
	   andi $t7, $t2, 1		#Par/Impar
	   sub $t2, $t2, $t7
	   add $t1, $s1, $t2		#A
	   add $t3, $zero, $s2		#B

Impar:     lb $t6, 0($t1)		#Cargas y guardas
	   sb $t6, 0($t3)		
	
	   subi $t2, $t2, 2	
	   subi $t1, $t1, 2		#Cambio de indices
	   addi $t3, $t3, 1
	
	   slti $t8 , $t2, 1 		# $t2 < 1 -> $t8 = 1
	   bne $t8, 1, Impar 		
	
	   lb $t6, 0($t1)		#Cargas y guardas el úlitmo valor
	   sb $t6, 0($t3)
	
	   add $t2, $s5, $zero
	
	   andi $t7, $t2, 1		#Par/Impar
	   sub $t2, $t2, $t7	
	   subi $t2, $t2, 1		#Par = - 1 / Impar = 0
	
	   add $t1, $s1, $t2		#A
	   add $t3, $zero, $s3		#C
		
Par:	   lb $t6, 0($t1)		#Cargas y guardas
	   sb $t6, 0($t3)		
	
	   subi $t2, $t2, 2	
  	   subi $t1, $t1, 2		#Cambio de indices
	   addi $t3, $t3, 1
	
	   slti $t8 , $t2, 1 		# $t2 < 1 -> $t8 = 1
	   bne $t8, 1, Par 		
	
	   lb $t6, 0($t1)		#Cargas y guardas el úlitmo valor
	   sb $t6, 0($t3)
	
	
	   add $t2, $s5, $zero
		
	   add $t1, $s1, $t2		#A
	   add $t3, $zero, $s4		#C
	   addi $t4, $zero, 1		#Contador Palabras
	  
Palabras:  lb $t6, 0($t1)		#Cargas y guardas
	  	  
  	   bne $t6, 32, NoEspacio	# If $t6 == ' ': $t4 += 1
  	   addi $t4, $t4, 1		
  	  
NoEspacio: subi $t2, $t2, 1	
  	   subi $t1, $t1, 1		#Cambio de indices  	   
  	   bne $t2, 0, Palabras 	# $t2 != 1	  	
	   sb $t4, 0($t3)		#Guardas el valor	  
	  
      	   li $v0 10
      	   syscall
