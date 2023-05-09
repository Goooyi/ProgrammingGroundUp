.section .data #no global data

.section .text

.global _start
.global factorial

_start:
    pushl $4
    call factorial 
    addl $4, %esp

    movl %eax, %ebx
    movl $1, %eax
    int $0x80

# remember each time only ebp will promisied to be reset to
.type factorial, @function
factorial:
    # set ebp
    pushl %ebp
    movl %esp, %ebp

    # moving current factorial to ebx
    movl 8(%ebp), %eax

    cmpl $1, %eax #??do coml need () for addresing mode?no
    je endF

    decl %eax # next factorial =--1
    pushl %eax 
    call factorial
    movl  8(%ebp), %ebx
    # imull 8(%ebp), %eax, can't do direction mull operation on memory, must first load from stack to a register
    imull %ebx, %eax
    # addl $4, %esp, doesn't need to add anymore, because will be erased when movl $ebp, %esp

endF:
   movl %ebp, %esp
   popl %ebp
   ret 
