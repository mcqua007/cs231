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
str10: .asciiz ": $"
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
#------------------------
# SUBROUTINE SECTION
#------------------------
FillPriceArray:   add	$t0, $a1, $0 	 # pass the number of integer need to inputed into temp register
  la $t1,itemsArray #load items array into temporary register
  li $t2, 0 #inistalize counter into $t1
  li $t3, 0 #initalize for summation


     loop1: beq $t0, $t2, exitLoop1

     li $v0, 4
     la $a0, str1  #print out the ask user string
     syscall

     li $v0, 1		#print number
     add $a0, $t2, 1		#print counter+1
     syscall

     li $v0, 4
     la $a0, str10  #print out colon
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

#------------------------------
# Coupon Subroutine
#------------------------------

fillCoupon:  add $t0, $a0, $0    # pass the value in $a0/ amount of coupons into regiter $t5

  la $t1, couponArray # store coupon array into register $t4
  li $t2, 0 # initalizing the counter fo rthe fill coupon loop
  li $t3, 0 #initalize for the summation
  li $t4, 10 #initalize to 10 for check
  la $t5, itemsArray  #store address of items array in register $t5

  loop2:  beq $t0, $t2, exitLoop2  # start of loop2

  #----- printing question & getting input -------------------
   li $v0, 4
   la $a0, str5  #print out the ask user for coupon price string
   syscall

   li $v0, 1		#print number
   add $a0, $t2, 1		#print counter+1
   syscall

   li $v0, 4
   la $a0, str10  #print ouut colon
   syscall

   li $v0, 5    #get user input
   syscall
  #--------- End Question and Input Section ---------------------
   add $t6, $v0, $0  #passing user input into temp register $t6
   lw $t7, 0($t5)  #loading the first value in items array and storing into register $t7

   #----- Conditional Section ---------
   bgt $t6, $t4, error4  #comparing user input of coupon to be greater then to
   bgt $t6, $t7, error4  #comparing user input to be not greater then items price

   sw $t6, 0($t1)  #store the user input that is in register $t6 into the array in $t1

   add $t3, $t3, $t6 #make a sum of all the user inputs that meet conditions

   skipCoupon:   #this is where the error jumps to so that we can skip to next input

   add $t1, $t1, 4 #iterator for cpuon array
   add $t5, $t5, 4 #iterator for items array
   add $t2, $t2, 1 #iterator adding 1 each iteration

   j loop2  #jump back to top of loop1

   exitLoop2:   # end of loop2

   add $v0, $t3, $0 # store the sum of all coupons into register $v0 to be pased back

   jr $ra  #jump back to the return address

#------------------------------
# ERROR SECTION
#------------------------------
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
