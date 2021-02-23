

.globl Average 
.globl Biggest 
.globl Smallest 
.globl TotalOfArray 
.globl BiggestOfArray 
.globl SmallestOfArray 

@ -------------------------------------------------------
@ extern int Average (int a, int b);

Average:
  add r0,r0,r1        @ a = a+b
  mov r0,r0,asr #1    @ a= a >>1
  bx  lr              @ return to caller


@ -------------------------------------------------------
@ extern int Biggest (int a, int b);

Biggest:
  cmp   r0,r1
  bge   biggest_found
  mov   r0,r1         @ r0 = r1
biggest_found:
  bx  lr              @ return to caller

@ -------------------------------------------------------
@ extern int Smallest (int a, int b);

Smallest:
  cmp   r0,r1
  ble   smallest_found
  mov   r0,r1         @ r0 = r1
smallest_found:
  bx  lr              @ return to caller


@ -------------------------------------------------------
@ extern int TotalOfArray (int *array, int len);

TotalOfArray:
  ldr   r2,[r0]     @ t = *array
  add   r0,r0,#4    @ array++
  sub   r1,r1,#1    @ len--

total_loop:
  cmp   r1,#0
  beq   total_done
  ldr   r3,[r0]
  add   r0,r0,#4
  add   r2,r2,r3    @ t += (*array++)
  sub   r1,r1,#1
  b     total_loop

total_done:
  mov   r0,r2       @ return value in r0
  bx    lr          @ return to caller

@ -------------------------------------------------------
@ extern int BiggestOfArray (int *array, int len);

BiggestOfArray:

  ldr   r2,[r0]     @ t = *array
  add   r0,r0,#4    @ array++
  sub   r1,r1,#1    @ len--
biggest_loop:
  cmp   r1,#0
  beq   biggest_of_done
  ldr   r3,[r0]
  add   r0,r0,#4
  cmp   r3,r2
  ble   not_bigger
  mov   r2,r3       @ t = *array++ <- current element is the biggest
not_bigger:
  sub   r1,r1,#1
  b     biggest_loop

biggest_of_done:
  mov   r0,r2       @ return value in r0
  bx    lr          @ return to caller

@ -------------------------------------------------------
@ extern int SmallestOfArray (int *array, int len);

SmallestOfArray:

  ldr   r2,[r0]     @ t = *array
  add   r0,r0,#4    @ array++
  sub   r1,r1,#1    @ len--

smallest_loop:
  cmp   r1,#0
  beq   smallest_of_done
  ldr   r3,[r0]
  add   r0,r0,#4
  cmp   r3,r2
  bge   not_smallest
  mov   r2,r3       @ t = *array++  <- current element is the smallest
not_smallest:
  sub   r1,r1,#1
  cmp   r1,#0
  b     smallest_loop

smallest_of_done:
  mov   r0,r2       @ return value in r0
  bx    lr          @ return to caller


