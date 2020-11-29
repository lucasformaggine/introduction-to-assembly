.data
	#Area de dados
	newline: .asciiz "\n" #Declara��o do caracter especial de quebrar linha
	msg_valor: .asciiz "Valor inserido: "  #Mensagem do valor inserido
	msg_preco: .asciiz "Pre�o do produto: " #Mensagem do pre�o do produto
	msg_troco: .asciiz "Valor do troco: " #Mensagem do troco
	msg_insuficiente: .asciiz "Valor insuficiente para compra." #Mensagem de valor 
	zero: .asciiz "0" #String zero
	virgula: .asciiz "," #String da v�rgula
.text
	
	#Inicializa registradores com valores pagos
	#Valor: 98.90
	#Pre�o: 7.70
	
	li $t1, 9890 #Valor adicionado no registro t1
	
	li $s0, 2 #Quantidade de notas de 20.00
	li $s1, 0 #Quantidade de notas de 10.00
	li $s2, 0 #Quantidade de notas de 5.00
	li $s3, 0 #Quantidade de notas de 2.00
	li $s4, 0 #Quantidade de moedas de 1.00
	li $s5, 1 #Quantidade de moedas de 0.50
	li $s6, 0 #Quantidade de moedas de 0.20
	li $s7, 0 #Quantidade de moedas de 0.10
	li $t9, 770 #Pre�o do produto vezes 100
	la $t6, ($t9) #Guarda o produto vezes 100 em outro registrador
	#C�lculo do valor
	
	
	 
	blt $t1, $t9, valorInsuficiente #Se o valor for menor que o pre�o, � insuficiente
	
	
	#Sen�o ...
	sub $t2, $t1, $t9 #C�lculo do troco
	
	li $t3, 2000 #Valor que representa 20 reais x 100
	div $t2, $t3 #Divis�o do troco por 20 reais
	mflo $t4 #Quociente da divis�o (quantidade de notas de 20 reais)
	mfhi $t5 #Resto da divis�o (resto para tentar usar outras notas)
	bnez $t4, add20 #Se o resto n�o for zero, pode-se colocar as notas de 20
	
	add20:
		la $s0, ($t4)#Atualiza o registrador s0 com a quantidade de notas de 20 de troco

	li $t3, 1000
	div $t5, $t3
	mflo $t4
	mfhi $t5
	bnez $t4, add10 
	
	add10:
		la $s1, ($t4)
		
	li $t3, 500
	div $t5, $t3
	mflo $t4
	mfhi $t5
	bnez $t4, add5 
	
	add5:
		la $s2, ($t4)
		
	li $t3, 200
	div $t5, $t3
	mflo $t4
	mfhi $t5
	bnez $t4, add2 
	
	add2:
		la $s3, ($t4)
		
	li $t3, 100
	div $t5, $t3
	mflo $t4
	mfhi $t5
	bnez $t4, add1 
	
	add1:
		la $s4, ($t4)
		
	li $t3, 50
	div $t5, $t3
	mflo $t4
	mfhi $t5
	bnez $t4, add050
	
	add050:
		la $s5, ($t4)
		
	li $t3, 25
	div $t5, $t3
	mflo $t4
	mfhi $t5
	bnez $t4, add025 
	
	add025:
		la $s6, ($t4)
		
	li $t3, 10
	div $t5, $t3
	mflo $t4
	mfhi $t5
	bnez $t4, add010 
	
	add010:
		la $s7, ($t4)
		
	li $t3, 5
	div $t5, $t3
	mflo $t4
	mfhi $t5
	bnez $t4, add005
	
	add005:
		la $t9, ($t4)
			
	
	printValor:
		li $v0, 4 #Indica que uma strings ser�o printadas
		la $a0, msg_valor #Atribui a mensagem do valor � string printada
		syscall #Printa
	
		la $t0, ($t1) #Guarda o valor inserido (x1000 no registrador tempor�rio t0
		li $t7, 100 #Guarda o valor 100 (usado para "colocar o n�mero em float novamente") no registrador tempor�rio t7
		div $t0, $t7 #Divide o valor(x100) por 100
		mflo $t4 #Coloca a parte inteira no t4
		mfhi $t5 #Coloca o resto no t5
	
		li $t7, 10 #Guarda o flag 10 no t7 para tratar o char "0", caso necess�rio, quando o resto � menor que 10 (ex: resto 9: 09)
		blt $t5, $t7, printComZero1 #Verifica se h� necessidade de colocar o 0
		j printSemZero1 #Caso n�o seja, pula para printar sem zero
	
		printComZero1:
			li $v0, 1 #Indica ao registrador v0 que ser� printado um inteiro
			la $a0, ($t4) #Coloca o inteiro (que � a parte inteira do dinheiro) na �rea de print
			syscall #Printa
		
		
			li $v0, 4 #Indica ao registrador v0 que ser� printada uma v�rgula
			la $a0, virgula #Coloca a v�rgula (que est� como string) na �rea de print
			syscall #Printa
		
			la $a0, zero #Coloca o zero (que est� como string) na �rea de print
			syscall #Printa
		
			li $v0, 1 #Indica ao registrador v0 que ser� printado um inteiro
			la $a0, ($t5)  #Coloca o inteiro (que � a parte decimal do dinheiro) na �rea de print
			syscall #Printa
		
			li $v0, 4 #Indica ao registrador v0 que ser� printada uma string
			la $a0, newline	#Atribui o \n � string printada (em formato de string)
			syscall #Printa
		
		
		
		li $t7, 10 
		bge $t5, $t7, printSemZero1
		j printPreco
	
		printSemZero1:
			li $v0, 1
			la $a0, ($t4)
			syscall
		
			li $v0, 4
			la $a0, virgula
			syscall
	
			li $v0, 1
			la $a0, ($t5)
			syscall
	
			li $v0, 4
			la $a0, newline
			syscall
	
	printPreco:
		li $v0, 4	
		la $a0, msg_preco #Atribui a mensagem do pre�o � string printada
		syscall #Printa
	
		la $t0, ($t6)
		li $t7, 100
		div $t0, $t7
		mflo $t4
		mfhi $t5
	
		li $t7, 10
		blt $t5, $t7, printComZero2
		j printSemZero2
	
		printComZero2:
			li $v0, 1
			la $a0, ($t4)
			syscall
		
			li $v0, 4
			la $a0, virgula
			syscall
		
			la $a0, zero
			syscall
		
			li $v0, 1
			la $a0, ($t5)
			syscall
		
			li $v0, 4
			la $a0, newline	#Atribui o \n � string printada
			syscall #Printa
		
		bge $t5, $t7, printSemZero2
		j printTroco
	
		printSemZero2:
			li $v0, 1
			la $a0, ($t4)
			syscall
		
			li $v0, 4
			la $a0, virgula
			syscall
	
			li $v0, 1
			la $a0, ($t5)
			syscall
	
			li $v0, 4
			la $a0, newline
			syscall
		
	printTroco:
		la $a0, msg_troco #Atribui a mensagem do troco � string printada
		syscall #Printa
	
		la $t0, ($t2)
		li $t7, 100
		div $t0, $t7
		mflo $t4
		mfhi $t5
	
		li $t7, 10
		blt $t5, $t7, printComZero3
		j printSemZero3
	
		printComZero3:
			li $v0, 1
			la $a0, ($t4)
			syscall
		
		
			li $v0, 4
			la $a0, virgula
			syscall
		
			la $a0, zero
			syscall
		
			li $v0, 1
			la $a0, ($t5)
			syscall
		
			li $v0, 4
			la $a0, newline	#Atribui o \n � string printada
			syscall #Printa
		
		bge $t5, $t7, printSemZero3
		j final
	
		printSemZero3:
			li $v0, 1
			la $a0, ($t4)
			syscall
		
			li $v0, 4
			la $a0, virgula
			syscall
	
			li $v0, 1
			la $a0, ($t5)
			syscall
	
			li $v0, 4
			la $a0, newline
			syscall
	
	final:
		li $v0, 10 #Indica que o programa est� pass�vel de terminar
		syscall #Encerra o programa
	
	valorInsuficiente:
		li $v0, 4 #Indica que uma string ser� printada
		la $a0, msg_insuficiente #Atribui a mensagem de valor insuficiente � string printada
		syscall #Printa
		
		li $v0, 10 #Indica que o programa est� pass�vel de terminar
		syscall #Termina o programa
