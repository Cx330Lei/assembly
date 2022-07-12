.model small
.stack 100h
.data
      tb1 db 'Nhap ma sinh vien: $'
      masv db 100 dup('$')
      ten db 'AT160346$'
      tb2 db 10,13, 'Ban nhap sai ma sinh vien! $'
      tb3 db 10,13, 'Ten cua ban la: Tran Thi Thanh$'
      dem dw 0
      tb4 db 10,13, 'Nhap chuoi ky tu: $'
      n db 100 dup('$')
      tb5 db 10,13, 'Chuoi ky tu DAO NGUOC la: $',10,13
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
    
    lea si,n
    mov cx,0
daonguoc:
    mov dx,0
    mov dl,[si+2]
    cmp dl,13
    je  hienthi
    inc si        
    inc cx
    push dx
    jmp daonguoc
    
hienthi:
    pop dx
    mov ah,2
    int 21h
    loop hienthi
        
ketthuc:                
    mov ah,4ch
    int 21h
main endp
end