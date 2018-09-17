#Program Description:		Program to calculate n! where n is 0=<n<=10
#Author:		Sean McQuaid
#Creation Date:                 09/07/2018

.data
str0: .asciiz "Please Enter a Number between 0 and 10: \n"
str1: .asciiz "Enter a another number: "
str2: .asciiz "The factorial is: "
str3: .asciiz "ERROR! The number is less than 0. Enter another number: \n"
str4: .asciiz "ERROR! The number is greater than 10. Enter another number: \n"

.text

main:

li $v0, 4	#print the string
la $a0, str0	#Display the question string
syscall

li $v0, 5	#begin reading a integers
syscall

add $s0, $v0, $0	#move integer from v0 to

li $s1, 0 #counter - initalize $s1 to 0

li $s2, 0 #product- of factorial - initalize to 0

li $t1, 10 # initalize to 6

li $t3, 1 # initalize to 1

	loop1: beq $s1, $s0, exit  # loop is number less than or equal to counter

  li $t0, 0 #temporary place holder
  li $t2, 0 #holds product of mult - needs to be intialized each time through loop

  blt $s0, $0, error1 # $t0 less than  0
  bgt $s0, $t1, error2 # $t0 greater than 10
  beq $s0, $t3, isOne #go to is one label

  addi $t0, $s1, -1  # -1 from counter and storing in $t0

  mult $s1, $t0
  mflo $t2  # move remainder into $t2

  addi $s1, $s1, 1  # counter adding 1 to each loop through
  j loop1   #jump back through loop

  isOne:# trying to give the condition if its one to print out 1
  li $v0, 4	 #print the string 2
  la $a0, str2	#Display the sum  string
  syscall

  li $v0, 1
  li $a0, 0
  syscall

  exit:   #end of loop



  li $v0, 4	 #print the string 2
  la $a0, str2	#Display the sum  string
  syscall

  add $a0, $s2, $0 # Dispaly the product of factorial
  li $v0, 1
  syscall


#***************************

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
