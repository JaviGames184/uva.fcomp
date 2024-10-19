#----- Mario Danov / Javier Ramos -----#
.data
Vector: .word -5, 10, -50
	.space 388

.text
main: addi $s0, $zero, 97  	# $s0 = 97
      add $s2, $zero, $zero 	# $s2 = 0
      la $s1, Vector		#s1 = Dirección Vector
      addi $s1, $s1, 12
Bucle:	sll $t1, $s2, 2
	add $t1, $t1, $s1	#Se mueve a la siguiente posición
	lw $t3, -12($t1)
	lw $t4, -8($t1)
	lw $t5, -4($t1)
	add $t2, $t3, $t4	#Suma c[i-3] + c[i-2]	
	sub $t0, $t2, $t5  	#Resta (c[i-3] + c[i-2]) - c[i-1]
	sw $t0, 0($t1)		#Guarda
	addi $s2, $s2, 1	#Incrementa el indice
	bne $s2, $s0, Bucle
	li $v0 10
	syscall
