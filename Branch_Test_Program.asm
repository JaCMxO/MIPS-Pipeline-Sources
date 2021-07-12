.text
main:
	addi	$s0, $zero, 8
	beq		$s0, $zero, notTaken
	addi 	$s2, $zero, 7
	bne		$s0, $s2, taken
	addi	$s3, $zero, 3		#not executed
	
notTaken:
	addi 	$s1, $zero, 100
	addi 	$s1, $zero, 15
	addi 	$s1, $zero, 10
	
taken:
	addi	$s4, $zero, 50
	
exit: