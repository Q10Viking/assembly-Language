;PROGRAM TITLE GOES HERE--Compare string
;s输入两个字符串并比较是否相同

datarea segment
	BUFFER1 db 25,0          ;作为输入到STRING1的缓冲区
	STRING1 db 25 dup(?)
	BUFFER2 db 25,0			;作为输入到STRING2的缓冲区
	STRING2 db 25 dup(?)
	
	INPUT1 db 'please input the string:','$'
	INPUT db 10,13,'please input the string:','$'
	MESS1 db 10,13,'Match','$'
	MESS2 db 10,13,'No match','$'
datarea ends

code segment
	assume cs:code,ds:datarea,es:datarea
main proc far
start:
	push ds
	sub ax,ax
	push ax

	mov ax,datarea
	mov ds,ax
	mov es,ax

	lea dx,INPUT1   ;提示输入字符串
	mov ah,09
	int 21h

	lea dx,BUFFER1  ;输入第一个字符串
	mov ah,0ah
	int 21h

	lea dx,INPUT   ;提示输入字符串
	mov ah,09
	int 21h

	lea dx,BUFFER2  ;输入第二个字符串
	mov ah,0ah
	int 21h

	lea si,STRING1
	lea di,STRING2
	mov ch,0
	mov cl,25
	cld
	repz cmpsb   ;当zf=0时退出，也就是不相等的时候
	jz match
	lea dx,MESS2
	jmp short disp
match:
	lea dx,MESS1

disp:
	mov ah,09h
	int 21h
	ret

main endp
code ends
end start
