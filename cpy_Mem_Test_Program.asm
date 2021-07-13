.text
main:
	lui		$s0, 0x1001
	addi	$at, $zero, 7
	sw		$at, 0($s0)
	lw		$at, 0($s0)
	sw		$at, 4($s0)
	lw		$s1, 0($s0)
	lw		$s2, 4($s0)
	sw		$s2, 8($s0)
	