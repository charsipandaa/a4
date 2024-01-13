section .data
    prompt_msg db 'Enter a number (0 to stop): $'
    output_msg db 'Numbers in reverse order: $'
    newline db 13, 10, '$'

section .bss
    stack resb 10
    top resb 1
    char resb 1

section .text
    global _start

_start:
    ; Initialize stack pointer
    lea si, [stack + 9]  ; point to the top of the stack

get_numbers_loop:
    ; Print prompt message
    lea dx, [prompt_msg]
    mov ah, 9
    int 21h

    ; Read a character from the user
    mov ah, 1
    int 21h
    cmp al, '0'
    je  print_numbers  ; If the entered number is '0', stop reading

    ; Convert ASCII to integer
    sub al, '0'

    ; Push the number onto the stack
    mov [si], al
    dec si

    ; Jump back to the loop
    jmp get_numbers_loop

print_numbers:
    ; Print newline
    lea dx, [newline]
    mov ah, 9
    int 21h

    ; Print the numbers in reverse order
    lea si, [stack]
    mov cx, 10
pop_and_print:
    ; Pop a number from the stack
    mov al, [si]
    inc si

    ; Convert integer to ASCII
    add al, '0'

    ; Print the number
    mov ah, 2
    int 21h

    ; Decrement loop counter
    loop pop_and_print

    ; Print newline
    lea dx, [newline]
    mov ah, 9
    int 21h

    ; Exit the program
    mov ah, 4Ch
    xor al, al
    int 21h

