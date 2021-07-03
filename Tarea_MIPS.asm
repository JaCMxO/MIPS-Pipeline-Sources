.data
.text
main:
	lui		$s0, 0x1001
	addi	$t0, $zero, 4
	add 	$t2, $zero, $zero
	
	sw		$t0, 0($s0)
	lw		$t7, 0($s0)

	bne		$t0, $zero, isnZero	# if $t0 != $zero then isnZero

next_branch:
	beq		$t2, $zero, isZero	# if $t2 == $zero then isZero

isnZero:
	addi	$t1, $zero, 7
	j		next_branch			# jump to next_branch
	
isZero:
	addi	$t5, $zero, 8
	jal		sumt3
	
next:
	addi	$t9, $zero, 0xA
	j		exit
	

sumt3:
	addi	$t3, $t3, 5
	jr		$ra

exit:

