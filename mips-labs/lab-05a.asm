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
li $s0, 0      # initalize to 0
li $t1, 10     # initalize to 10
li $t3, 1      # initalize to 1

li $v0, 4      # print the string
la $a0, str0   # Display the question string
syscall

li $v0, 5      # begin reading a integers
syscall

add $s0, $v0, $0	#move integer from v0 to register $s0

#Conditional Section 
#-------------------------------------
blt $s0, $0, error1   # $t0 less than  0
bgt $s0, $t1, error2  # $t0 greater than 
beq $s0, $t3, isOne   # go to isOne label
beq $s0, $0, isZero   # go to isZero label

# Initilize more variables
#-------------------------------------
li $s1, 1 #counter - initalize $s1 to 0
li $t2, 1 #holds product of mult - needs to be intialized before loop


# Loop to make Factorial
#-------------------------------------
loop1: beq $s1, $s0, exitLoop1  # loop equal to counter
   #----------------------------------
    li $v0, 4	 #print the string
    la $a0, str6  #Display the question string
    syscall
   #----------------------------------
    li $t0, 0 #temporary place holder
 
    mult $s0, $t2
    mflo $t2  # move product into $t2
   
    addi $s0, $s0, -1  # counter adding 2 to each loop through
    j loop1   #jump back through loop

# End of Loop to make Factorial
#-------------------------------------
 exitLoop1:   #end of loop

  li $v0, 4	 #print the string 2
  la $a0, str2	#Display the sum  string
  syscall

  add $a0, $t2, $0 # Dispaly the product of factorial
  li $v0, 1
  syscall

exitProgram:

# Exit Program
#-----------------------

  li $v0, 10  # Exit Program
  syscall
  
# Jump out of Program
#------------------------
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

