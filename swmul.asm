;;Jia Wei Hu Lab B2 Oct 29,2020 
;;This program multiplies 2 numbers x and y together
X:	DD	12 ;;define constants
Y:	DD	40
ZERO:	DD	0
ONE:	DD	1
EQU:	DD	64
	
	ld	a0, X(x0)   	
	ld	a1, Y(x0)   		
	ld	t1, ZERO(x0)		
	ld	t0, ZERO(x0)		
	ld	a2, EQU(x0) 		;;set 64 for the for loop
	ld	a3, ONE(x0) 		;;a constant 1
	ld	a4, ZERO(x0)		
	mul	a5, a0, a1		;;store X x Y for later checking
				;;a0 --> x
				;;a1 --> y
				;;t1 --> res
				;;t0 --> i
				;;a4 --> used to store value of and
				;;a5 --> result of the mul for check

	jal	ra,swmul		;;goTo swmul
	ecall	x0, a5, 0
	ecall	x0, t1, 0		;;print out res
	ebreak	x0, x0, 0
	
swmul:
	bge	t0, a2, EXIT    ;;if i > 64 exit
	and	a4, a1, a3	     ;;y&1
	beq	a4, a3, trueIf  ;;if y&1 == true goTo trueIf
	slli	a0, a0, 1		;;x = x<<1
	srli	a1, a1, 1		;;y = y>>1
	addi	t0, t0, 1		;;i++
	jal	x0,swmul		;;go back to top of loop
trueIf:
	add	t1, t1, a0		;;res += x
	slli	a0, a0, 1		;;x = x<<1
	srli	a1, a1, 1		;;y = y>>1
	addi	t0, t0, 1		;;i++
	jal	x0, swmul		;;goTo swmul
	
EXIT:
	jalr	x0, 0(ra)		;;go back