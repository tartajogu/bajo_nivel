
.globl Biggest 
.globl Smallest 
.globl Average 

Biggest:
  cmp   r0,r1           @ if (a > b)
  bge   biggest_found   @ if true go to biggest_done
  mov   r0,r1           @ if not -> res = b
biggest_done:
  bx  lr                @ return res; (r0)

Smallest:
  cmp   r0,r1           @ if (a < b)
  ble   smallest_found  @ if true go to smallest_done
  mov   r0,r1           @ if not -> res = b
smallest_done:
  bx  lr                @ return res;

Average:
  add r0,r0,r1          @ a+b
  mov r0,r0,asr #1      @ a+b >> 1
  bx  lr                @ return res;
