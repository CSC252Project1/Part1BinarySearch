# Determine if an element is in an array or not (and return the index if it is in the array).
      .data
length: .word  10      		# length of the array
nums: .word  1, 2, 3, 4, 5, 6, 7, 8, 9, 10  # sorted array of integers
target:  .word 9		# element the search is looking for
      .text
      la   $t0, nums        	# load base address of array
      la   $t5, length        	# load address of length variable
      la   $t9, target		# load address of target element
      lw   $t5, 0($t5)      	# load array length
      lw   $t9, 0($t9)		# load target element
      addi $t1, $t5, 0    	# Counter for loop, will execute (length) times
loop: lw   $t3, 0($t0)      	# Get value from array B[n] 
      beq  $t3, $t9, bloop	# branch if current array element is equal to target element
      addi $t0, $t0, 4      	# increment address of array source
      addi $t1, $t1, -1     	# decrement loop counter
      bgtz $t1, loop        	# repeat if not finished yet.
      j	   notfound		# jump to print routine
bloop:addi  $a0, $t3, -1    	# argument for print (element address)
      j    found           	# jump to print routine
      
		
#########  routine to print answer 

      .data        
head: .asciiz  "The target element is in "
error:.asciiz  "Target not found."  
      .text
found:add  $t0, $zero, $a0  	# address of element in array
      la   $a0, head        	# load address of print heading
      li   $v0, 4           	# specify Print String service
      syscall               	# print heading
      move   $a0, $t0		# load target element address
      li   $v0, 1		# specify Print Integer service
      syscall			# print target element address
      j	   out			# jump to leave program
notfound:la   $a0, error        # load address of error to print
      li   $v0, 4           	# specify Print String service
      syscall			# print error message
out:  li   $v0, 10          	# system call for exit
      syscall               	# done