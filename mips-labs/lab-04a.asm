#Program Description:		Between 1-100 and divisble by 6
#Author:		Sean McQuaid
#Creation Date:                 09/07/2018

.data
str0: .asciiz "How many positive number that is divisible by you want to add?  \n"
str1: .asciiz "Enter a number: "
str2: .asciiz "The sum of numbers divisble by 6: "
str3: .asciiz "ERROR! The number is less than 1. Enter another number: \n"
str4: .asciiz "ERROR! Number is not divisble by 6. Enter another nubmer: \n"
str5: .asciiz "ERROR! The number is greater than 100. Enter another number: \n"

.text

main:

	li $v0, 4	#print the string
	la $a0, str0	#Display the question string
	syscall

	li $v0, 5	#begin reading a integers
	syscall

	add $s0, $v0, $0	#move integer from v0 to

	li $s1, 0 #counter - initalize $s1 to 0

	li $s2, 0 #sum - initalize to 0

	li $t1, 6 # initalize to 6

	li $t3, 100 # nitalize to 100

	loop1: beq $s1, $s0, exit  # loop is number less than or equal to counter
	  li $t0, 0 #temporary place holder
	  li $t2, 0 #holds remaidner - needs to be intialized each time through loop

    li $v0, 4	 #print the string
	  la $a0, str1	 #Display the Enter  string
	  syscall

  	li $v0, 5	#begin reading integers
   	syscall

  	add $t0, $v0, $0  #move into temporary register

	  ble $t0, $0, error1 # $t0 less than or equal to 0
	  bge $t0, $t3, error3 # $to greater than or equal to 100

	  div $t0, $t1 #devide number in $t0 by 6
    mfhi $t2  # move remainder into $t2

	  bne $t2, $0, error2 # if $t2 not equal to zero throw error2

	  add $s2, $s2, $t0 # added the sum if its divisble by 6

	  addi $s1, $s1, 1  # counter adding 1 to each loop through
	  j loop1   #jump back through loop


     exit:   #end of loop

   li $v0, 4	 #print the string 2
   la $a0, str2	#Display the sum  string
	 syscall

	 add $a0, $s2, $0
	 li $v0, 1
	 syscall

	 li $v0, 10  # Exit Program
	 syscall
#------------------------
	 error1:
		 li $v0, 4	#print the string
		 la $a0, str3	#Display the question string
		 syscall

		 j loop1
#-------------------------
	 error2:
		 li $v0, 4	#print the string
		 la $a0, str4	#Display the question string
		 syscall

		 j loop1
#-------------------------
	error3:
		 li $v0, 4	#print the string
		 la $a0, str5	#Display the question string
		 syscall

		 j loop1
