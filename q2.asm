[org 0x0100]
jmp start
array1: db 1, 2, 3, 4, 5, 6, 7, 3, 2, 10
results: dw 0

find_max:
   mov cx, 10            ; Initialize loop counter
   lea si, [array1]      ; Load the address of the array into si
   movzx bx, byte [si]   ; Load the first element of the array into bx

skip_update:
   dec cx                ; Decrement loop counter
   jz done               ; If counter is zero, jump to done
   shl si, 1             ; Double the array index
   cmp bx, [si]          ; Compare bx with the value in the array
   jge skip_update       ; If bx is greater or equal, jump to skip_update
   mov bx, [si]          ; Update bx with the array value
   jmp skip_update       ; Jump to skip_update

done:
   ret

start:
   call find_max         ; Call the find_max subroutine for array1
   mov [results], bx     ; Store the result in the results array

   ; Display the result
   mov ax, [results]     ; Load the result into ax
   call DisplayNumber    ; Call a subroutine to display the number

   mov ax, 0x4c00        ; Exit program
   int 0x21

DisplayNumber:
mov ah, 2
   int 0x21
   ret

