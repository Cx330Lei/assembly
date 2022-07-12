.model small
.stack 100h
.data 
      tb1 db 'Nhap ho ten sinh vien: $'
      ten db 100 dup('$')
      hoten db 'TRAN THI THANH$'
      tb2 db 10,13, 'Nhap sai ho ten!$'
      tb3 db 10,13, 'MaSV la: AT160346$'
      dem dw 0
      tb4 db 10,13, 'Nhap ten file: $'
      tenfile db 100 dup(?),'$'
      thefile dw ?
      tb5 db 10,13, 'Du lieu tu file: $'
      chuoi db 251 dup('$')
  
.code
main proc
      mov ax,@data
      mov ds,ax
      
      mov ah,9
      lea dx,tb1
      int 21h
      
      mov ah,10
      lea dx,ten
      int 21h
      
      lea si,ten+2
      lea di,hoten
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

      lea si,tenfile
      mov cx,0
      
nhapten:
      mov ah,1
      int 21h
      cmp al,13
      je  xoafile
      mov [si],al
      inc si
      inc cx
      jmp nhapten
xoafile:
      mov ax,0
      mov ah,41h        ; xoa tap tin file
      lea dx,tenfile
      int 21h
                 
ketthuc:      
      mov ah,4ch
      int 21h           
main endp
end