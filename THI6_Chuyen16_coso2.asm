.model small
.stack 100h
.data
      tb1 db 'Nhap ma sinh vien: $'
      masv db 100 dup('$')
      ten db 'AT160346$'
      tb2 db 10,13, 'Ban nhap sai ma sinh vien! $'
      tb3 db 10,13, 'Ten cua ban la: Tran Thi Thanh$'
      dem dw 0
      tb4 db 10,13, 'Nhap so he thap phan: $'
      n db 100 dup('$')
      muoi dw 10
      muoisau dw 16
      hai dw 2
      num dw ?
      tb5 db 10,13, 'Co so 16: $'
      tb6 db 10,13, 'Co so 2: $'
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    lea dx,tb1
    int 21h
    
    mov ah,10
    lea dx,masv
    int 21h
    
    lea si,masv+2
    lea di,ten
 
    mov cx,0
sosanh:    
    mov bx,0
    mov ax,0
    mov al,[si]
    mov bl,[di]
    cmp bl,'$'
    je ketluan
    inc cx
    cmp al,bl
    je cong
    inc si
    inc di
    jmp sosanh
    
cong:
    inc dem
    inc si
    inc di
    jmp sosanh
ketluan:
    cmp cx,dem
    je hienten
    jne sai
    
hienten:
    mov ah,9
    lea dx,tb3
    int 21h
    jmp caub
    
sai:
    mov ah,9
    lea dx,tb2
    int 21h
    jmp ketthuc
caub:
    mov ah,9
    lea dx,tb4
    int 21h
  
    mov ah,10
    lea dx,n
    int 21h
    
    mov ah,9
    lea dx,tb5
    int 21h    
    
    mov cx,0
    lea si,n
    mov cl,[si+1]
    mov ax,0 
chuyenthanhso:
    mov bx,0     ; 123 -> 0*10+1 1*10+2 12*10+3
    mov bl,[si+2]
    sub bl,'0'
    mul muoi
    add ax,bx
    inc si
    loop chuyenthanhso
    
    mov cx,0
    mov num,ax
coso16:
    cmp ax,0
    je hienthi16
    inc cx
    mov dx,0
    div muoisau
    cmp dx,9
    ja  cong55 ; chuyen so thanh chu dang hexa
    add dx,'0'
    push dx
    jmp coso16

cong55:
    add dx,55
    push dx
    jmp coso16 
      
hienthi16:
    pop dx
    mov ah,2
    int 21h
    loop hienthi16
    
    mov ah,9
    lea dx,tb6
    int 21h
    
    mov ax,num
    mov cx,0
coso2:
    mov dx,0
    cmp ax,0
    je  hienthi2
    inc cx
    div hai
    add dx,'0'
    push dx
    jmp coso2
hienthi2:
    pop dx
    mov ah,2
    int 21h
    loop hienthi2           
       
ketthuc:                
    mov ah,4ch
    int 21h
main endp
end