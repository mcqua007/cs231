#Program Description:		Program to calculate n! where n is 0=<n<=10
#Author:		Sean McQuaid
#Creation Date:                 10/1/2018

.data

str0: .asciiz " Please input a temperature in Celsius"
str1: .asciiz "\n The number in Fahrenheit: "
str2: .asciiz ""
str3: .asciiz ""
str4: .asciiz ""
str5: .asciiz ""
strColon: .asciiz ": \t"

const:  .float  1.8
const2: .float  32.0

# f =  (c *1.8) + 32
.text

main:

li $v0, 4	 #print the string 2
la $a0, str0 #Display string
syscall

li $v0, 5   #Get user input
syscall

add $t0, $v0, $0  #move from inpu tot temp register
mtc1 $t0, $f1     #move from $t0 to $f1

cvt.s.w $f1, $f1 #convert to single point float
l.s $f4, const   # load constant 1.8 into $f4
l.s $f5, const2  #load constant 32 into $f5

mul.s $f2, $f4 #multiply input by 1.8

add.s $f3,$f3, $f5  #add product + 32


#----- Display Final -----
li $v0, 4
la $a0, str2            #"The result"
syscall

li $v0, 2              #display float
add.s $f12, $f3, $0    #store in v0 and print
syscall

#-------------------------
exitProgram:

# Exit Program
#-----------------------

  li $v0, 10  # Exit Program
  syscall

# Jump out of Program
#------------------------
