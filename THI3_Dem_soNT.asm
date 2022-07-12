.model small
.stack 100h
.data
   tb1 db 'Nhap ma sinh vien: $'
   masv db 100 dup('$')
   ma db 'AT160346$'
   tb2 db 10,13, 'Nhap sai ma sinh vien!$'
   tb3 db 10,13, 'Ten ban la: Tran Thi Thanh$'
   dem dw 0
   tb4 db 10,13, 'Nhap mot chuoi so: $'
   chuoi dw 100 dup('$')
   so dw 0
   kq dw 0 
   muoi dw 10
   tb5 db 10,13, 'Ket qua la: $'

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
      lea di,ma
      mov cx,0
lap:      
      mov dx,0
      mov ax,0
      mov al,[si]
      mov dl,[di]
      cmp dl,'$'
      je  kiemtra
      cmp al,'a'
      jl  tiep
      cmp al,'z'
      jl  chuyenHoa  
tiep:
      inc cx
      cmp al,dl
      je  cong
      inc si
      inc di
      jmp lap
      
chuyenHoa:
      sub al,32
      jmp tiep
cong:
      inc dem
      inc si
      inc di
      jmp lap
      
kiemtra:
      cmp cx,dem
      je  hienCo
      jne sai
hienco:
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
    lea dx,tb4
    int 21h
    
    lea si,chuoi
    mov cx,0
    
nhap:
    mov ax,0
    mov ah,1
    int 21h
    mov [si],al
    inc si
    inc cx
    cmp al,13
    jne nhap
    
    mov ah,9
    lea dx,tb5
    int 21h

mov dem,cx    
    lea si,chuoi
lapb:
    dec dem
    cmp dem,0
    je lappush
    mov ax,0
    mov al,[si]
    sub al,'0'
    inc si
    cmp ax,1
    je lapb
    cmp ax,2
    je congb
    call soNT
    loop lapb
; day ket qua vao ngan xep    
lappush:
    mov ax,kq
    mov cx,0
    xl:
    mov dx,0
    div muoi
    add dx,'0'
    push dx
    inc cx
    cmp ax,0
    jne xl
    
hienthi:
    pop dx
    mov ah,2
    int 21h
    loop hienthi
ketthuc:        
    mov ah,4ch
    int 21h
    
main endp

soNT proc
    mov bx,1
    mov cx,2
    mov so,ax
 
 chia:
    mov dx,0
    inc bx
    inc cx
    div bx
    cmp dx,0  ;chia het
    je lapb
    cmp so,cx
    je congb
    mov ax,so 
    jmp chia
    
 congb:
    inc kq  
    jmp lapb 
    
soNT endp
end