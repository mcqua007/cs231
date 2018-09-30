#Program Description:		This is a items an dcoupon program to get toal price of items and subtract by total
#                        price fo coupons
#Author:		Sean McQuaid
#Creation Date:                 09/17/2018

.data

itemsArray: .word  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
couponArray: .word  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

str0: .asciiz "Please enter the number of item you are purchasing(should be less than or equal to 20): "
str1: .asciiz "Please enter the price of item "
str2: .asciiz "\nPlease enter the number of coupons that you want to use: "
str3: .asciiz "Sorry too many items to purchase!! \n"
str4: .asciiz "Coupons need to be same amount as items!! "
str5: .asciiz "Please enter the amount of coupon "
str6: .asciiz "Your total charge is: $"
str7: .asciiz "This coupon is not acceptable. \n"
str8: .asciiz "\nThank you for shopping with us"
str9: .asciiz "Not enough items."
str10: .asciiz ": "
str11: .asciiz " \n"
str12: .asciiz "Price without coupons: $"
.text

main:


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


add $a0, $s3, $0 # Dispaly the sum of prices
li $v0, 1
syscall
#--------- Ask For Amount Of Coupon -------
askAgain:

li $v0, 4
la $a0, str2  #print out the ask user string
syscall

li $v0, 5  #get user input
syscall

add $s4, $v0, $0

bne $s4, $s0, error3 #check if coupon the same as items

add $a0, $s4, $0  #passing the users input into argument register
 # Jump to coupon subroutine
jal fillCoupon


add $s5, $v0, $0 # Move the sum of coupons into register $s5
#---------------------------------------------------
#---- Start Print the Toal Section -----------------

li $v0, 4
la $a0, str6  #print total charge string
syscall

sub $s6, $s3, $s5  #subtract couposn from price and store in $s6

add $a0, $s6, $0 # Dispaly the total price
li $v0, 1
syscall

li $v0, 4
la $a0, str8 #print the thanks for shopping message
syscall

#----------- End of Print Total Section ------------
exitProgram:

# Exit Program
#-----------------------

  li $v0, 10  # Exit Program
  syscall
#---------------------------------------------------------
# SUBROUTINE SECTION
#---------------------------------------------------------

# Create Array
#------------------------------
createeArray:   add	$t, $a1, $0 	 # pass the number of integer need to inputed into temp register

     loop1: beq $t, $t, exitLoop1

     j loop1

     exitLoop1:
     jr $ra #jump back to function call in main

#------------------------------
# Reverse Subroutine
#------------------------------

reverseArray:  add $t, $a0, $0    # pass the value in $a0/ amount of coupons into regiter $t5

   loop2: beq $t, $t, exitLoop1

   j loop2  #jump back to top of loop1

   exitLoop2:   # end of loop2
   jr $ra  #jump back to the return address



#------------------------------
# Print Subroutine
#------------------------------

printArray:  add $t, $a0, $0    # pass the value in $a0/ amount of coupons into regiter $t5

      loop3: beq $t, $t, exitLoop1

      j loop2  #jump back to top of loop1

      exitLoop2:   # end of loop2
      jr $ra  #jump back to the return address

#------------------------------
# Divisble by 3 Subroutine
#------------------------------

divisibleBy3:  add $t, $a0, $0    # pass the value in $a0/ amount of coupons into regiter $t5

jr $ra

#------------------------------
# checkNumPositive Subroutine
#------------------------------

checkNumPositive:  add $t, $a0, $0    # pass the value in $a0/ amount of coupons into regiter $t5

jr $ra

#------------------------------
# versifySize Subroutine
#------------------------------

versifySize:  add $t, $a0, $0    # pass the value in $a0/ amount of coupons into regiter $t5

jr $ra

#------------------------------
# readNum Subroutine
#------------------------------

readNum:  add $t, $a0, $0    # pass the value in $a0/ amount of coupons into regiter $t5

jr $ra



#---------------------------------------------------------
# ERROR SECTION
#---------------------------------------------------------
  error1:
    li $v0, 4	#print the string
    la $a0, str9	#Display the question string
    syscall

    j main
#------------------------
  error2:
    li $v0, 4	 #print the string
    la $a0, str3  #Display the question string
    syscall

    j main

#------------------------
  error3:
    li $v0, 4	 #print the string
    la $a0, str4  #Display the question string
    syscall

    j askAgain

#------------------------
  error4:
    li $v0, 4	 #print the string
    la $a0, str7  #Display the question string
    syscall

    sw $0, 0($t1)		#store the zero into the coupon array

    j skipCoupon

#------------------------
