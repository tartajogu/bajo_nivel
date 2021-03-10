
.globl SortArray

@ static void SortArray (int *array, int len)
@ int *array - r0
@ int len - r1

SortArray:
  stmdb   sp!,{r4,r5,r6,r7}     @ prolog

while_loop:
  cmp   r1,#1     
  ble   sort_done   @ while (len < 1)

  mov   r2,#1     @ ordered = 1    
  mov   r3,#0     @ i
  sub   r7,r1,#1  @ len - 1
for_loop:
  cmp   r3,r7
  bge   for_done

  ldr r4,[r0,r3,lsl #2]    @ t0 = array[i]
  add   r6,r3,#1      @ i + 1
  ldr r5,[r0,r6,lsl #2]    @ t1 = array[i+1]

@Ejemplo de predicación
@Primero hace la comparacion ->31 cmp r4,r5
@Esto hace que todas las instrucciones condicionales posteriores comprueben esos valores
@Es decir, la inst cond ->33 strGT, esta haciendo que el str solo se ejecute si se cumple GT

  cmp   r4,r5

  strgt  r5,[r0,r3,lsl #2]    @ array[i] = t1
  strgt  r4,[r0,r6,lsl #2]    @ array[i+1] = t0
  movgt   r2,#0         @ ordered = 0

  add   r3,r3,#1   @ i++
  b     for_loop

for_done:
  cmp   r2,#0
  bne   sort_done   @ if (ordered) return
  sub   r1,r1,#1    @ len--
  b     while_loop

sort_done:
  ldmia   sp!,{r4,r5,r6,r7}    @ epilog
  bx      lr

