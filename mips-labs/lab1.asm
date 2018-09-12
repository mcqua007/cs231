#Program Description:	 Top 5 employees in Erickson Company

#Author: Sean McQuaid

.data

header:	.asciiz "Here is the Report of Top 5 employees in Erickson Company:"

doubleLine: .asciiz "\n=========================================================="

category: .asciiz "\n\tLast Name\tFirst Name\tPosition\t\tSalary"

row1:	.asciiz "\n\n\tSmith\t\tAdam\t\tDirector\t\t"

row2:	.asciiz "\n\tHadden\t\tMary\t\tDirector\t\t"

row3:	.asciiz "\n\tSimpson\t\tMike\t\tManager\t\t\t"

row4:	.asciiz "\n\tWilliams\tAndrea\t\tDesigner\t\t"

row5:	.asciiz "\n\tAmer\t\tAli\t\tDesigner\t\t"

.text

main:

li $v0, 4
la $a0, header
syscall

li $v0,4
la $a0, doubleLine
syscall

li $v0, 4
la $a0, category
syscall

li $v0, 4
la $a0, row1
syscall

li $v0, 1
li $a0, 99010
syscall

li $v0, 4
la $a0, row2
syscall

li $v0, 1
li $a0, 95220
syscall

li $v0, 4
la $a0, row3
syscall

li $v0, 1
li $a0, 80000
syscall

li $v0, 4
la $a0, row4
syscall

li $v0, 1
li $a0, 70000
syscall

li $v0, 4
la $a0, row5
syscall

li $v0, 1
li $a0, 55000
syscall


li $v0, 10
syscall


        
