.data
.text
main:
	lui		$s0, 0x0101
	addi	$s2, $zero, 1
	addi	$s3, $zero, 32
	#add		$zero, $zero, $zero
	sll		$t0, $s2, 4
	srl		$t1, $s3, 4
	#add		$zero, $zero, $zero
	#add		$zero, $zero, $zero
	sub		$t2, $t0, $t1
	##
	#add		$zero, $zero, $zero
	sll		$t3, $t2, 8
	srl		$t4, $t2, 2
	sll		$t5, $t4, 3
	addi	$t6, $t5, 10
	add		$t6, $t5, $t5
	add 	$t6, $t6, $t6
	##
	ori		$s1, $s0, 0x24
	
exit:

