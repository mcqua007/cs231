#Program Description:		Program to calculate n! where n is 0=<n<=10
#Author:		Sean McQuaid
#Creation Date:                 09/17/2018

.data
str0: .asciiz "Please Enter a Number between 0 and 10: \n"
str1: .asciiz "Enter a another number: "
str2: .asciiz "The factorial is: "
str3: .asciiz "ERROR! The number is less than 0. Enter another number: \n"
str4: .asciiz "ERROR! The number is greater than 10. Enter another number: \n"
str5: .asciiz "The Factorial of 1 is: \n"
str6: .asciiz "In Loop \n"
str7: .asciiz "The Factorial of 0 is: \n"
.text

main:

askAgain:
li $t0, 0      # initalize to 0
li $t1, 10     # initalize to 10
li $t3, 1      # initalize to 1

li $v0, 4      # print the string
la $a0, str0   # Display the question string
syscall

li $v0, 5      # begin reading a integer
syscall

add	$a1, $v0, $0 	 # pass the number of integer need to inputed to getFactorial at rutine

jal getFact #jump to factorial subroutine

  li $v0, 4	 #print the string 2
  la $a0, str2	#Display the sum  string
  syscall

  add $a0, $v1, $0 # Dispaly the product of factorial
  li $v0, 1
  syscall

# Exit Program
#-----------------------

exitProgram:

  li $v0, 10  # Exit Program
  syscall

# Jump out of Program
#------------------------
getFact:
add	$t4, $a1, $0		#get the argument from $a0 in temp register


  #Conditional Section
  #-------------------------------------
  blt $t4, $0, error1   # $t0 less than  0
  bgt $t4, $t1, error2  # $t0 greater than
  beq $t4, $t3, isOne   # go to isOne label
  beq $t4, $0, isZero   # go to isZero label

  # Initilize more variables
  #-------------------------------------
  li $s1, 1 #counter - initalize $s1 to 0
  li $t2, 1 #holds product of mult - needs to be intialized before loop


  # Loop to make Factorial
  #-------------------------------------
  loop1: beq $s1, $t0, exitLoop1  # loop equal to counter
     #----------------------------------
      li $v0, 4	 #print the string
      la $a0, str6  #Display the question string
      syscall
     #----------------------------------
      li $t0, 0 #temporary place holder

      mult $t4, $t2
      mflo $t2  # move product into $t2

      addi $t4, $s0, -1  # counter adding 2 to each loop through
      j loop1   #jump back through loop

  # End of Loop to make Factorial
   exitLoop1:   #end of loop

   add $v1, $t2, $0

   jr $ra

#-------------------------
  error1:
    li $v0, 4	#print the string
    la $a0, str3	#Display the question string
    syscall

    j askAgain
#------------------------
  error2:
    li $v0, 4	 #print the string
    la $a0, str4  #Display the question string
    syscall

    j askAgain

#------------------------
 isOne:     #trying to give the condition if its one to print out 1
  li $v0, 4	 #print the string 2
  la $a0, str5	#Display the sum  string
  syscall

  li $v0, 1
  li $a0, 0
  syscall

  j exitProgram


#------------------------
 isZero:     #trying to give the condition if its one to print out 1
  li $v0, 4	 #print the string 2
  la $a0, str7	#Display the sum  string
  syscall

  li $v0, 1
  li $a0, 0
  syscall

  j exitProgram

#--------------------
