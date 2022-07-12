.model small
.stack 100h
.data
      tb1 db 'Nhap ma sinh vien: $'
      masv db 100 dup('$')
      ten db 'AT160346$'
      tb2 db 10,13, 'Ban nhap sai ma sinh vien! $'
      tb3 db 10,13, 'Ten cua ban la: Tran Thi Thanh$'
      tb4 db 10,13, 'Nhap chuoi so n: $'
      n db 100 dup('$')
      am dw 0
      duong dw 0
      muoi dw 10
      dem dw 0
      tb5 db 10,13, 'So chu so am la: $'
      tb6 db 10,13, 'So chu so duong la: $'
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
    
    lea si,n
    mov bx,0
tinh:
    mov ax,0
    mov al,[si+2]
    inc si
    
    cmp al,13
    je  ketqua
    
    cmp al,20h ; 20h la dau cach
    je  tachso
  
    cmp bx,0
    jne tinh
    
    cmp al,2Dh   ;2Dh la dau am
    je tinham
    jne tinhduong
tachso:
    mov bx,0
    jmp tinh    
tinham: 
    inc am
    mov bx,1
    jmp tinh
   
tinhduong:
    inc duong
    mov bx,1
    jmp tinh   
ketqua:
    mov ah,9
    lea dx,tb5
    int 21h
          
lappush:
    mov ax,am
    mov cx,0
    mov bx,0 ; danh dau vong lap chay den hien thi so duong hay chua
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
    
    cmp bx,1   ; bx=1 nghia la da chay den hien thi so duong 
    je  ketthuc

    mov ah,9
    lea dx,tb6
    int 21h
    
    mov bx,1
    mov ax,duong
    mov cx,0
    jmp day
    
            
ketthuc:                
    mov ah,4ch
    int 21h
main endp
end