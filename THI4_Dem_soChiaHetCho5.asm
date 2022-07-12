.model small
.stack 100h
.data
      tb1 db 'Nhap ma sinh vien: $'
      masv db 100 dup('$')
      ma db 'AT160346$'
      tb2 db 10,13, 'Ban nhap sai ma sinh vien! $'
      tb3 db 10,13, 'Ten cua ban la: Tran Thi Thanh$'
      dem dw 0
      tb4 db 10,13, 'Nhap chuoi so n: $'
      n db 100 dup('$')
      nam dw 5
      muoi dw 10
      tb5 db 10,13, 'So chu so chia het so 5 la: $'
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
    mov ah,9
    lea dx,tb4
    int 21h
  
    mov dem,0
    lea si,n
nhap:
    mov ax,0    
    mov ah,1
    int 21h
    mov [si],al
    inc si
    cmp al,13
    jne nhap
    
    mov ah,9
    lea dx,tb5
    int 21h
    
    lea si,n
tinh:
    mov dx,0
    mov ax,0
    mov al,[si]
    cmp al,13
    je lappush    
    sub al,'0'
    inc si
    div nam
    cmp dx,0
    je congB
    jmp tinh
    
congB:
    inc dem
    jmp tinh    
lappush:
    mov ax,dem
    mov cx,0
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
        
ketthuc:                
    mov ah,4ch
    int 21h
main endp
end