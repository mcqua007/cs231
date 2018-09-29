#Program Description:		Program to calculate n! where n is 0=<n<=10
#Author:		Sean McQuaid
#Creation Date:                 09/17/2018

.data
str0: .asciiz "Please a positive decimal number: \n"
str1: .asciiz "ERROR! The number is negative. Please Enter a positive number: \n"
str2: .asciiz "In Loop \n"
str3: .asciiz "The binary number is: \n"
.text

main:

li $v0, 4      # print get number string
li $a0, str0
syscall

li $v0, 5      # get user input
syscall

add $a0, $v0, $0  # put user input into argument register

blt $a0, $0, error1 #check if number is positive

jal changeBase    # jump to the change base subroutine

# Exit Program
#-----------------------
exitProgram:

  li $v0, 10  # Exit Program
  syscall

#-----------------------
# SUBROUTINE SECTION
#------------------------
changeBase:
    #initalize values
    li $s0, 0  #load 0 for the counter
    li $s1, 32 # load 32 for the max
    li $s2, 2  # load base 2 for dividing

loop: beq $s0, $t0, makeZero


j loop
# make th ezeros for before the Number
makeZero:
  
#------------------------
# Errors
#------------------------
  error1:
    li $v0, 4	#print the string
    la $a0, str3	#Display the question string
    syscall

    j main    # asking for user input again
#------------------------
