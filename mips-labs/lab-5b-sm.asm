#Program Description:		Program to calculate n! where n is 0=<n<=10
#Author:		Sean McQuaid
#Creation Date:                 09/17/2018

.data

array1: .word  0,0,0,0,0,0,0,0,0,0

str0: .asciiz "Please Enter a Number between 0 and 10: \n"
str1: .asciiz "Enter a another number "
str2: .asciiz "Enter Number "
str3: .asciiz "ERROR! The number is less than 0. Enter another number: \n"
str4: .asciiz "ERROR! The number is greater than 10. Enter another number: \n"
str5: .asciiz "The array in reverse order is: \n"
strColon: .asciiz ": \t"

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

la $s4, array1 #load array1 into $s4

#Conditional Section
#-------------------------------------
blt $s0, $0, error1   # $t0 less than  0
bgt $s0, $t1, error2  # $t0 greater than

# Initilize more variables
#-------------------------------------
li $s1, 0 #counter - initalize $s1 to 0
li $t2, 1 #set to 1


# Loop to make Factorial
#-------------------------------------
loop1: beq $s1, $s0, exitLoop1  # loop equal to counter
   #----------------------------------
    li $v0, 4	 #print the string
    la $a0, str2  #Display the question string
    syscall

    li $v0, 1		#print which number it is
    add $a0, $t2, $0
    syscall

    li $v0, 4		#print the colon with the tabs.
    la $a0, strColon
    syscall

    # Read in numbers to array
    li $v0, 5		#take input form users
    syscall

    sw $v0, 0($s4)		#move the int to the array

    add $s4, $s4, 4  # array counter- moving spacess 4 bits for next input
    add $s1, $s1, 1  # loop1 counter/ iterator

    j loop1   #jump back through loop

# End of Loop to make Factorial
#-------------------------------------
 exitLoop1:   #end of loop

  li $v0, 4	 #print the string 2
  la $a0, str5	#Display string
  syscall

 loop2:	beq $s0, $0, exitProgram

 	      sub $s4, $s4, 4  #subtract the array by 4 spaces

        li $v0, 1
        lw $a0, 0($s1)	#display the integers

        sub $s0, $s0,1

        j loop2


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
