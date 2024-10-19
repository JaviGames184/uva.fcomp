#----- Mario Danov / Javier Ramos -----#
.data
Cadena_Entrada: .space 400
Cadena_Operacion: .space 6
Cadena_Operando_1: .space 196
Cadena_Operando_2: .space 196
Cadena_Resultados: .space 400
Op_len: .asciiz "len"
Op_lwc: .asciiz "lwc"
Op_upc: .asciiz "upc"
Op_cat: .asciiz "cat"
Op_cmp: .asciiz "cmp"
Op_chr: .asciiz "chr"
Op_rchr: .asciiz "rchr"
Op_str: .asciiz "str"
Op_rev: .asciiz "rev"
Op_rep: .asciiz "rep"
Cadena1Menor: .asciiz "MENOR"
Cadena1Igual: .asciiz "IGUAL"
Cadena1Mayor: .asciiz "MAYOR"
Entrada_Incorrecta: .asciiz "ENTRADA INCORRECTA"

.text      
main: 		la $a0, Cadena_Entrada
		addi $a1, $zero, 396
      		li $v0, 8			# Pide la cadena
       		syscall    
       		la $a0, Cadena_Entrada		# Se prepara la entrada recibida y se comprueban algunas entradas incorrectas
       		la $a1, Cadena_Operacion
       		la $a2, Cadena_Operando_1
       		la $a3, Cadena_Operando_2
       		jal Separar_Palabras
       		beq $v0, -1, Error       
       		la $a0, Cadena_Operando_1	# Comprueba si el operando 1 no esta vacio
       		lb $t0, 0($a0)
       		beq $t0, $zero, Error
                     
       		la $a0, Cadena_Operacion	# Comprueba si la cadena de operación no esta vacia
       		lb $t0, 0($a0)
       		beq $t0, $zero, Error
       		la $a1, Op_len
       		jal CMP
       		bne $v0, 0, O_1
       		la $a0, Cadena_Operando_1	# Se llama a LEN
       		jal LEN
       		add $a0, $zero, $v0
       		la $a1, Cadena_Resultados
       		jal Bin2Hex
       		la $a0, Cadena_Resultados	# Imprime el numero de caracteres en hexadecimal
       		j Imprimir
       
O_1:   		la $a0, Cadena_Operacion		
      		la $a1, Op_lwc
       		jal CMP
       		bne $v0, 0, O_2
       		la $a0, Cadena_Operando_1	
       		la $a1, Cadena_Resultados
       		jal LWC				# Se llama a LWC
       		la $a0, Cadena_Resultados	# Imprime la cadena en minúsculas
       		j Imprimir
       
O_2:   		la $a0, Cadena_Operacion
       		la $a1, Op_upc
       		jal CMP
       		bne $v0, 0, O_3
       		la $a0, Cadena_Operando_1	
       		la $a1, Cadena_Resultados
       		jal UPC				# Se llama a UPC
      		la $a0, Cadena_Resultados	# Imprime la cadena en mayúsculas
		j Imprimir
       
O_3:   		la $a0, Cadena_Operacion
       		la $a1, Op_rev
       		jal CMP
       		bne $v0, 0, O_4
       		la $a0, Cadena_Operando_1	
       		la $a1, Cadena_Resultados
       		jal REV				# Se llama a REV	
       		la $a0, Cadena_Resultados	# Imprime la cadena invertida
       		j Imprimir
       
O_4:   		la $a0, Cadena_Operando_2
       		lb $t0, 0($a0)
       		beq $t0, $zero, Error
       		la $a0, Cadena_Operacion
       		la $a1, Op_str
       		jal CMP
       		bne $v0, 0, O_5
       		la $a0, Cadena_Operando_1
       		la $a1, Cadena_Operando_2
       		jal STR				# Se llama a STR
       		add $a0, $v0, $zero
       		la $a1, Cadena_Resultados
       		jal Bin2Hex
       		la $a0, Cadena_Resultados	# Imprime la posición donde se encuentra la cadena en hexadecimal
       		j Imprimir
       
O_5:   		la $a0, Cadena_Operacion
       		la $a1, Op_rep
       		jal CMP				
       		bne $v0, 0, O_6	
       		la $a0, Cadena_Operando_2
       		jal H2B
      		beq $v0, -1, Error	
       		la $a0, Cadena_Operando_1
       		add $a1, $v0, $zero
       		la $a2, Cadena_Resultados
       		jal REP				# Se llama a REP
       		la $a0, Cadena_Resultados	# Imprime la cadena invertida
       		j Imprimir
       
O_6:   		la $a0, Cadena_Operacion
       		la $a1, Op_cat
       		jal CMP
       		bne $v0, 0, O_7
       		la $a0, Cadena_Operando_1	
       		la $a1, Cadena_Operando_2	
       		la $a2, Cadena_Resultados
       		jal CAT				# Se llama a CAT
       		la $a0, Cadena_Resultados	# Imprime la cadena concatenada
       		j Imprimir
      
O_7:   		la $a0, Cadena_Operacion
       		la $a1, Op_chr
       		jal CMP
       		bne $v0, 0, O_8
      		la $a0, Cadena_Operando_1	
       		la $a1, Cadena_Operando_2
       		lb $a0, 0($a0)
		jal CHR				# Se llama CHR
       		add $a0, $zero, $v0
       		la $a1, Cadena_Resultados
       		jal Bin2Hex
       		la $a0, Cadena_Resultados	# Imprime la posición ocupada por el caracter en hexadecimal
       		j Imprimir
       
O_8:   		la $a0, Cadena_Operacion
       		la $a1, Op_rchr
       		jal CMP
       		bne $v0, 0, O_9
       		la $a0, Cadena_Operando_1
       		lb $s0, 0($a0)
       		la $a0, Cadena_Operando_2
       		jal LEN
       		add $a2, $v0, $zero
       		add $a0, $s0, $zero   
       		la $a1, Cadena_Operando_2       
       		jal RCHR			# Se llama RCHR
       		add $a0, $v0, $zero
		la $a1, Cadena_Resultados
       		jal Bin2Hex
       		la $a0, Cadena_Resultados	# Imprime la posición ocupada por el caracter en hexadecimal
       		j Imprimir
       
O_9:   		la $a0, Cadena_Operacion
       		la $a1, Op_cmp			
       		jal CMP
       		bne $v0, 0, Error		# No tiene ninguno de los códigos de operación --> ERROR
       		la $a0, Cadena_Operando_1	
       		la $a1, Cadena_Operando_2	
       		jal CMP				# Se llama CMP
       		beq $v0, 0, IgualCMP		# Imprime "IGUAL", "MAYOR" o "MENOR" dependiendo del resultado
       		beq $v0, 1, Cadena1MayorCmp
       		la $a0, Cadena1Menor
       		j Imprimir
IgualCMP:	la $a0, Cadena1Igual
       		j Imprimir
Cadena1MayorCmp:la $a0, Cadena1Mayor

Imprimir:	li $v0, 4			# Imprime la cadena cuya dirección esta en $a0
       		syscall
       		li $v0 10
       		syscall

Error: 		la $a0, Entrada_Incorrecta	# Imprime el mensaje de error
       		li $v0, 4
      		syscall
       		li $v0 10
       		syscall       
  	        	      
#-------------------------Funciones-------------------------#
    	      	      	      
Separar_Palabras:#Función que separa 3 palabras
		 #$a0 = dirección de la cadena inicial
		 #$a1 = dirección donde se guarda la operación
		 #$a2 = dirección donde se guarda el operando 1
		 #$a3 = dirección donde se guarda el operando 2
		 #Devuelve -1 si la cadena tiene más de 3 palabras
		 add $v0, $zero, $zero				 
Loop_Palabras:	 lb $t1, 0($a0)
		 beq $t1, 10, Terminar		# Se comprueba el fin de cadena
		 beq $t1, 0, Terminar
		 beq $t1, 32, Espacio		# Se comprueba el espacio
		 beq $t1, 9, Espacio		
		 sb $t1, 0($a1)
		 addi $a1, $a1, 1
		 addi $a0, $a0, 1
		 j Loop_Palabras
Espacio:         beq $v0, 0, Etapa1
		 sb $zero, 0($a1)
	         add $a1, $zero, $a3		# Empieza a guardar el operando 2
		 j Salto
Etapa1:		 sb $zero, 0($a1)
		 add $a1, $zero, $a2		# Empieza a guardar el operando 1
Salto:		 addi $v0, $v0, 1
		 beq $v0, 3, Incorrecto		# No puede tener 4 operandos
Loop_Espacio:    addi $a0, $a0, 1
		 lb $t1, 0($a0) 
                 beq $t1, 32, Loop_Espacio
                 beq $t1, 9, Loop_Espacio
                 j Loop_Palabras
Incorrecto:      addi $v0, $zero, -1
		 jr $ra		 
Terminar: 	 sb $zero, 0($a1)
		 jr $ra	
#-----------------------------------------------------------#
Bin2Hex:    #Función que convierte de binario a hexadecimal
	    #$a0 = número
	    #$a1 = dirección donde se guarda en hexadeciamal
	    addi $t0, $zero, 28			# $t0 = 28
Continuar:  srlv $t1, $a0, $t0
	    andi $t1, $t1 ,15			# Hace la mascara --> $t1
	    blt $t1, 10, Numero  	    	# $t1 < 9 --> $t3 = 1
	    addi $t1, $t1, 39
Numero:     addi $t1, $t1, 48		
	    sb $t1, 0($a1)
	    addi $a1, $a1, 1			# $a1 += 1
	    addi $t0, $t0, -4			# $t0 -= 4
	    bne $t0, -4, Continuar
	    sb $zero, 0($a1)		 
	    jr $ra
#-----------------------------------------------------------#
H2B: 		#Función que convierte de hexadecimal a binario
     		#$a0 = numero en hexadecimal
     		#$v0 = devuelve el número en decimal
     		lb $t0, 0($a0)
     		beq $t0, 48, NoesHexadecimal	# No se aceptan ceros al principio
LoopH2B: 	lb $t0, 0($a0)			 
	 	beq $t0, $zero, AcabarH2B		
	 	blt $t0, 48, NoesHexadecimal
	 	blt $t0, 58, EsNumeroH2B
		blt $t0, 65, NoesHexadecimal
	 	blt $t0, 71, EsletraMAYH2B
	 	blt $t0, 97, NoesHexadecimal 
		bge $t0, 103, NoesHexadecimal
	 	addi $t0, $t0, -32		# Letra minúscula: -87 (-32-7-48)
EsletraMAYH2B: 	addi $t0, $t0, -7		# Letra mayúscula: -55 (-7-48)
EsNumeroH2B: 	addi $t0, $t0, -48   		# Número: -48
SeguirH2B:	add $v0, $v0, $t0
		sll $v0, $v0, 4			# $v0 = $v0 * 16
		addi $a0, $a0, 1
		j LoopH2B
AcabarH2B:	srl $v0, $v0, 4	
	  	bne $v0, $zero, FinH2B
NoesHexadecimal:addi $v0, $zero, -1
FinH2B:   	jr $ra
#-----------------------------------------------------------#     	    	    	    	    	    	    
LEN:	#Función que cuenta el número de caracteres
	#$a0 = dirección de la cadena
	#$v0 = número de caracteres
	addi $v0, $a0, 1			# $v0 = $a0
Looplen:lb $t0, 0($a0)
	addi $a0, $a0, 1
	bne $t0, 0, Looplen
	sub $v0, $a0, $v0			# $v0 = Posfinal - Posinicial	
	jr $ra
#-----------------------------------------------------------#	    
LWC:	  #Función que convierte la cadena a minúsculas
	  #$a0 = dirección de la cadena
	  #$a1 = dirección de la cadena convertida
Looplwc:  lb $t0, 0($a0)
	  beq $t0, 0, AcabarLWC
	  bge $t0, 91, Iguallwc			# Si $t0, entre 'A'-'Z'
	  blt $t0, 65, Iguallwc
	  addi $t0, $t0, 32			# Se pasa a minúsculas
Iguallwc: sb $t0, 0($a1)
	  addi $a0, $a0, 1
	  addi $a1, $a1, 1
	  j Looplwc
AcabarLWC:jr $ra
#-----------------------------------------------------------#
UPC:	  #Función que convierte la cadena a mayúsculas
	  #$a0 = dirección de la cadena
	  #$a1 = dirección de la cadena convertida
Loopupc:  lb $t0, 0($a0)
	  beq $t0, 0, AcabarUPC
	  bge $t0, 123, Igualupc		# Si $t0, entre 'a'-'z'
	  blt $t0, 97, Igualupc
	  addi $t0, $t0, -32			# Se pasa a minúsculas
Igualupc: sb $t0, 0($a1)
	  addi $a0, $a0, 1
	  addi $a1, $a1, 1
	  j Loopupc
AcabarUPC:jr $ra
#-----------------------------------------------------------#
CAT:   		 #Función que concatena dos cadenas
		 #$a0 = dirección de la cadena 1
		 #$a1 = dirección de la cadena 2
		 #$a2 = dirección donde se devuelven las cadenas concatenadas
		 add $t1, $zero, $zero
LoopCat:	 lb $t0, 0($a0)			# Copia valores
		 sb $t0, 0($a2)
		 beq $t0, $zero, AcabasCadenaCat
		 addi $a0, $a0, 1
		 addi $a2, $a2, 1
		 j LoopCat
AcabasCadenaCat: beq $t1, 1, AcabarCat		# Con el segundo ' ' acaba
		 addi $t1, $t1, 1
		 add $a0, $a1, $zero
		 j LoopCat  
AcabarCat: 	 jr $ra
#-----------------------------------------------------------#            
CMP:      #Función que compara cadenas en ASCII
	  #$a0 = dirección de la cadena1
     	  #$a1 = dirección de la cadena2
     	  #devuelve en $v0:-1 si Cadena1 < Cadena2
     	  #		   0 si Cadena1 = Cadena2
     	  #		   1 si Cadena1 > Cadena2
Loopcmp:  lb $t0, 0($a0)
    	  lb $t1, 0($a1)
    	  slt $v0, $t1, $t0			# Cadena 1 > Cadena 2 --> $v0 = 1  
    	  beq $v0, 1, Salircmp
    	  bne $t0, $zero, Seguircmp
    	  beq $t1, $zero, Salircmp		# Si acaba las 2 cadenas: Cadena1 = Cadena2 --> $v0 = 0	
Seguircmp:addi $a0, $a0, 1
	  addi $a1, $a1, 1
	  beq $t0, $t1, Loopcmp
AcabarC1: addi $v0, $zero, -1	  		# Cadena 1 < Cadena 2 --> $v0 = -1
Salircmp: jr $ra				
#-----------------------------------------------------------#
CHR:	 #Función que busca un carácter en una cadena
    	 #$a0 = caracter a buscar
    	 #$a1 = cadena donde buscarlo
    	 #$v0 = posición donde se encuentra (0 si no aparece)
         add $v0, $zero, $zero
LoopChr: lb $t0, 0($a1)
	 addi $v0, $v0, 1
	 beq $t0, $a0, AcabaChr 		# $t0 = $a0 --> En esa posición se encuentra el caracter
	 addi $a1, $a1, 1
	 bne $t0, $zero, LoopChr
	 add $v0, $zero, $zero
AcabaChr:jr $ra
#-----------------------------------------------------------#
RCHR:    #Función que busca un carácter en una cadena desde el final
    	 #$a0 = caracter a buscar
    	 #$a1 = cadena donde buscarlo
    	 #$a2 = longitud de la cadena donde lo buscas
    	 #$v0 = posición donde se encuentra (0 si no aparece)
    	 add $a1, $a1, $a2
    	 addi $a1, $a1, -1
    	 addi $v0, $a2, 1
LoopRChr:lb $t0, 0($a1)
	 addi $v0, $v0, -1
	 beq $t0, $a0, AcabaRChr 		# $t0 = $a0 --> En esa posición se encuentra el caracter
	 addi $a1, $a1, -1
	 bne $t0, $zero, LoopRChr
	 add $v0, $zero, $zero
AcabaRChr:jr $ra
#-----------------------------------------------------------#    	   
STR: 	       #Función que busca una cadena en otra y devuelve su posición
    	       #$a0 = Dirección de la cadena 1
    	       #$a1 = Dirección de la cadena 2
     	       #$v0 = Posición de la cadena 1 en la cadena 2
               add $v0, $zero, $zero		# Se almacenan los datos que se necesitan guardar
	       add $t2, $a0, $zero
	       add $t3, $a1, $zero
	       lb $t0, 0($t2)
LoopexisteStr: lb $t1, 0($t3)
	       beq $t1, $zero, NoEstaStr
	       addi $t3, $t3, 1
               bne $t0, $t1, LoopexisteStr	# Si los carácteres no son los mismos continuas	
               sub $v0, $t3, $a1
               addi $t2, $t2, 1
LoopPCStr:     lb $t0, 0($t2)			# Primera Cadena
	       lb $t1, 0($t3)			# Segunda Cadena
	       beq $t0, $zero, AcabarSTR
	       addi $t2, $t2, 1
	       addi $t3, $t3, 1
	       beq $t0, $t1, LoopPCStr
               add $t2, $zero, $a0
               add $t3, $v0, $a1
               lb $t0, 0($t2)
               j LoopexisteStr  
NoEstaStr:     add $v0, $zero, $zero          
AcabarSTR:     jr $ra
#-----------------------------------------------------------#										
REV:       #Función que invierte la cadena
	   #$a0 = dirección de la cadena
	   #$a1 = dirección para guardar la cadena invertida	
Contar:    addi $a0, $a0, 1
	   lb $t1, 0($a0)
	   bne $t1, $zero, Contar		# Recorre la cadena hasta el final
	   addi $a0, $a0, -1				   
LoopRev:   lb $t1, 0($a0)			# Copia recorriendose al revés
	   sb $t1, 0($a1)
	   beq $t1, $zero, AcabarREV
	   addi $a0, $a0, -1
	   addi $a1, $a1, 1
	   j LoopRev	   	  
AcabarREV: jr $ra
#-----------------------------------------------------------#
REP: 		#Función que escribe una cadena un número de veces
    		#$a0 = dirección de la cadena a repetir
    		#$a1 = número de veces que se tiene que repetir la cadena
     		#$a2 = dirección de la cadena resultados	 
LoopRepCompleto:add $t0, $a0, $zero
		addi $a1, $a1, -1		# Cuentas bules
                beq $a1, -1, AcabarRep
LoopRepParcial: lb $t1, 0($t0)			# Copias la palabra
		beq $t1, $zero, LoopRepCompleto
                sb $t1, 0($a2)
                addi $t0, $t0, 1
                addi $a2, $a2, 1
                j LoopRepParcial
AcabarRep: 	jr $ra
