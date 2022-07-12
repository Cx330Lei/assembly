.model small
.stack 100h
.data
      tb1 db 'Nhap ma sinh vien: $'
      masv db 100 dup('$')
      ten db 'AT160346$'
      tb2 db 10,13, 'Ban nhap sai ma sinh vien! $'
      tb3 db 10,13, 'Ten cua ban la: Tran Thi Thanh$'
      dem dw 0
      tb4 db 10,13, 'Nhap chuoi: $'
      n db 100 dup('$')
      muoi dw 10
      kt db ?
      tb5 db 10,13, 'Nhap ki tu can tim: $'
      tb6 db 10,13, 'So ki tu can tim co trong chuoi la: $'
      tb7 db 10,13, 'Khong tim thay ki tu trong chuoi!$'
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
    jmp thoat
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
    
    mov ah,1
    int 21h
    
    mov dem,0
    lea si,n
timkiem:
    mov bx,0
    mov bl,[si+2]
    cmp bl,13
    je lappush
    inc si
    cmp al,bl
    je  demkytu
    jne timkiem 
demkytu:
    inc dem
    jmp timkiem
       
lappush:
    cmp dem,0
    je rong
    
    mov ah,9
    lea dx,tb6
    int 21h
    
    mov cx,0
    mov ax,dem
day:
    mov dx,0
    div muoi
    add dx,'0'
    push dx
    inc cx
    cmp ax,0
    jne day
    
hienthi:
    pop dx
    mov ah,2
    int 21h
    loop hienthi
    jmp thoat
rong:
    mov ah,9
    lea dx,tb7
    int 21h
thoat:    
    mov ah,4ch
    int 21h
        
main endp
end