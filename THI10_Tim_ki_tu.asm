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
      dung dw ?
      muoi dw 10
      tb5 db 10,13, 'Nhap ki tu can tim: $'
      kt db ?
      tb6 db 10,13, 'Vi tri: $'
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
    jmp ketthuc
caub:
    mov dem,0; khoi tao bien dem bang 0
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
    
    mov kt,al
    lea si,n
    mov cx,0
timkiem:
    mov bx,0
    mov bl,[si+2]
    cmp bl,13
    je ketthuc
    inc si
    inc cx
    cmp al,bl
    je  xuat
    jne timkiem 
xuat:
    inc dem
    mov dung,cx ; bien dung de lay gia tri cua cx
    mov ah,9
    lea dx,tb6
    int 21h
       
lappush:
    mov cx,0
    mov ax,dung
    day:
    mov dx,0
    div muoi
    add dx,'0'
    push dx
    inc cx
    cmp ax,0
    jne lappush
    
hienthi:
    pop dx
    mov ah,2
    int 21h
    loop hienthi
    mov cx,dung
    mov al,kt
    jmp timkiem    
ketthuc:
    cmp dem,0
    je thongbao
    jne thoat
thongbao:
    mov ah,9
    lea dx,tb7
    int 21h
thoat:    
    mov ah,4ch
    int 21h
        
main endp
end