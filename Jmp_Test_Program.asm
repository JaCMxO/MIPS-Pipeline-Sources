.text
main:
	addi	$s0, $zero, 1
	j		next
	addi	$s1, $zero, 3			#no se ejecuta
	addi	$s1, $zero, 0xffff		#no se ejecuta
	addi	$s1, $zero, 77
	addi 	$s1, $zero, 100
next:
	addi	$s2, $zero, 5
	jal		mini
	addi	$at, $zero, 7
	j		exit
	
mini:
	add		$v0, $at, $s2
	jr		$ra
	
exit:
	sll		$v1, $at, 2