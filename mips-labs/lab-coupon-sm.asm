#Program Description:		Program to calculate n! where n is 0=<n<=10
#Author:		Sean McQuaid
#Creation Date:                 09/17/2018

.data

itemsArray: .word  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
couponArray: .word  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

str0: .asciiz "Please enter the number of item you are purchasing(should be less than or equal to 20): "
str1: .asciiz "Please enter the price of item "
str2: .asciiz "Please enter the number of coupons that you want to use.\n"
str3: .asciiz "Sorry too many items to purchase!! Please enter number of items you are purchasing"
str4: .asciiz "Too many Coupons!! Please enter the number of coupons that you want to use \n"
str5: .asciiz "Please enter the amount of coupon"
str6: .asciiz "Your total charge is: \n$"
str7: .asciiz "This coupon is not acceptable"
str8: .asciiz "Thank you for shopping with us"
str9: .asciiz "Not enough items."
str10: .asciiz ": \t"
str11: .asciiz " \n"
str12: .asciiz "Price without coupons: $"
.text

main:

askAgain:
li $s0, 0      # initalize to 0
li $s1, 20     # initalize to 20
li $s2, 10     # initialize to 10 for coupon


li $v0, 4      # print the string
la $a0, str0   # Display the question string
syscall

li $v0, 5      # begin reading a integer
syscall



#Conditional Section 1
#-------------------------------------
add	$s0, $v0, $0 	 # pass the number of integer need to inputed into temp


ble $s0, $0, error1   # $t0 less than  0
bgt $s0, $s1, error2  # $t0 greater than


#---- End Conditional Section 1 -------------
add	$a1, $s0, $0 	 # pass the number of integer need to inputed into argument register
# call subroutines
jal FillPriceArray #jump to factorial subroutine


add $s3, $v0, $0	#sum of prices passed to $s3
 #--------Testing the number in prices -----------
 li $v0, 4
 la $a0, str12  #print out the ask user string
 syscall


add $a0, $s3, $0 # Dispaly the sum o fprices
li $v0, 1
syscall
#---------------------------------------------------
exitProgram:

# Exit Program
#-----------------------

  li $v0, 10  # Exit Program
  syscall
#------------------------
# SUBROUTINE SECTION
#------------------------
FillPriceArray:
  add	$t0, $a1, $0 	 # pass the number of integer need to inputed into temp register

  la $t1,itemsArray #load items array into temporary register
  li $t2, 0 #inistalize counter into $t1
  li $t3, 0 #inistalize for summation


     loop1: beq $t0, $t2, exitLoop1

     li $v0, 4
     la $a0, str1  #print out the ask user string
     syscall

     li $v0, 1		#print number
     add $a0, $t2, 1		#print counter+1
     syscall

     li $v0, 4
     la $a0, str10  #print ouut colon
     syscall

     li $v0, 5  #get user input
     syscall

     sw $v0, 0($t1) #store the user input into the array

     add $t3, $t3, $v0 #adding up the input plus previous sum of all

     add $t1, $t1, 4 # move over for the next piece of memory
     add $t2, $t2, 1 #iterator adding 1 each iteration

     j loop1   #jump back through loop


     exitLoop1:
     #-----------------
     add $v0, $t3, $0 # Store sum in $v0
     jr $ra #jump back to function call in main
#------------------------
# ERROR SECTION
#------------------------
  error1:
    li $v0, 4	#print the string
    la $a0, str9	#Display the question string
    syscall

    j askAgain
#------------------------
  error2:
    li $v0, 4	 #print the string
    la $a0, str3  #Display the question string
    syscall

    j askAgain

#------------------------
  error3:
    li $v0, 4	 #print the string
    la $a0, str4  #Display the question string
    syscall

    j askAgain

#------------------------
