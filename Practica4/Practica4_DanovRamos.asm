.data
numero_hexadecimal: .space 9

#Textos utilizados
Texto: .asciiz "\nIntroduce un número: "
Texto2: .asciiz "El número en hexadecimal es: 0x"

.text
main:	    la $a0, Texto		#Imprime el mensaje Texto
	    li $v0, 4
	    syscall
	   
	    li $v0, 5			#Pide un número
	    syscall 
	    add $s0, $v0, $zero		#Guarda el número en $s0
	    la $s1, numero_hexadecimal	#Guarda en $s1 la dirección de numero_hexadecimal

	    add $a0, $s0, $zero		#Guarda los parametros para la función Hexadecimal
	    add $a1, $s1, $zero
	    jal Hexadecimal
	   
	    la $a0, Texto2		#Imprime el mensaje Texto2
	    li $v0, 4
	    syscall
	    
	    la $a0, numero_hexadecimal
	    la $v0, 4
	    syscall	   
	   	   	   	   
	    li $v0 10
	    syscall
	  
	   
Hexadecimal:#Función que convierte el registro de $a0 a ASCII
	    #$a0 = número a convertir
	    #$a1 = dirección donde quedará el número anterior hexadecimal en ASCII
	    addi $t0, $zero, 28		# $t0 = 28

Continuar:  srlv $t1, $a0, $t0
	    andi $t1, $t1 ,15		#Hace la mascara --> $t1
	    slti $t3, $t1, 10		# $t1 < 9 --> $t3 = 1
	    beq $t3, 1, esnumero  	    
	    addi $t1, $t1, 87
	    j saltar
	    
esnumero:   addi $t1, $t1, 48		

saltar:     sb $t1, 0($a1)
	    addi $a1, $a1, 1		# $a1 += 1
	    subi $t0, $t0, 4		# $t0 -= 4
	    slti $t2, $t0, 0		# if $t0 < 0 --> $t2 = 1
	    beq $t2, 0, Continuar
	    
	    sb $zero, 0($a1)		#Guarda el terminador de cadena \0
	    jr $ra
