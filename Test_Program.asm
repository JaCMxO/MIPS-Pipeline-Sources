	
	.text
	# Initializations
	addi $t0,$zero,2
	addi $t1,$zero,3
	addi $t2,$zero,7
	addi $t3,$zero,1
	addi $s7, $s7, 0
	 
	# Moving values
	add $s0,$t0,$zero
	add $s1,$t1,$zero
	add $s3,$t2,$zero
	add $s4,$t3,$zero
	
	# Operations
	add  $t3,$s0,$s1
	add  $s5,$t1,$t2
	addi $s6,$t4,25

	#SP init	
	addi $sp,$sp,15
	
	
