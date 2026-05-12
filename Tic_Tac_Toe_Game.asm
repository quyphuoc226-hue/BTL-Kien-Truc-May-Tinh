                             Name "Tic Tac Toe" ; Ð?t tên chuong trình"Tic Tac Toe"
Org 100h           ; Thi?t l?p v? trí b?t d?u trong b? nh?
.DATA              ; Kh?i d? li?u
	MANG DB '1','2','3'  	; Khai báo m?ng 2D grid
             DB '4','5','6'
             DB '7','8','9'
	PLAYER DB ?  						; Khai báo bi?n cho ngu?i choi
	WELCOME DB 'Welcome to Tic Tac Toe! $'			; Thông di?p chào m?ng
	INPUT DB 'Enter Position Number, PLAYER Turn is: $' 	; Thông di?p nh?p d? li?u
	DRAW DB 'DRAW! $' 					; Thông di?p hòa
	WIN DB 'PLAYER WIN: $' 					; Thông di?p chi?n th?ng

.CODE    ; Kh?i mã l?nh
main:
	mov cx,9    		; L?p 9 l?n vì s? lu?ng t?i da các lu?t choi là 9
x:   
        call XOA_MAN_HINH  	; Xóa màn hình d? cho giao di?n d?p hon
	call PRINT_WELCOME 	; In thông di?p chào m?ng
	call PRINT_MANG    	; In b?ng lu?i
	mov bx, cx        	; Di chuy?n cx vào bx
	and bx, 1         	; Ki?m tra s? ch?n ho?c l?
	cmp bx, 0        	; So sánh k?t qu? AND
	je isEven         	; Nh?y d?n isEven n?u k?t qu? 0 (ch?n)
	mov PLAYER, 'x'    	; N?u là s? l? thì là lu?t c?a ngu?i choi x
	jmp endif		; Chuy?n d?n bu?c ti?p theo
isEven:
	mov PLAYER, 'o'    	; N?u là s? ch?n thì là lu?t c?a ngu?i choi o
endif:
  NOT_VALID:
	call IN_DONG_MOI 	; In dòng m?i
	call IN_NHAP	 	; In thông di?p nh?p li?u
	call NHAP   		; Ð?c d? li?u d?u vào, al ch?a v? trí trên b?ng lu?i
           
	push cx           	; Ð?y cx vào ngan x?p
	mov cx, 9         	; Thi?t l?p s? lu?ng vòng l?p
	mov bx, 0         	; Ch? s? d? truy c?p b?ng lu?i
y:
	cmp MANG[bx], al  	; Ki?m tra v? trí trên b?ng lu?i v?i d? li?u d?u vào
	je UPDATE         	; N?u trùng kh?p c?p nh?t v? trí c?a ngu?i choi(x ho?c o)
	jmp CONTINUE     	; Ti?p t?c n?u không trùng
UPDATE:
	mov dl, PLAYER     	; Di chuy?n ng choi vào dl
	mov MANG[bx], dl  	; C?p nh?t b?ng lu?i v?i ngu?i choi
CONTINUE:
	inc bx            	; Tang ch? s?
	loop y            	; L?p d?n khi hoàn t?t
	pop cx            	; L?y giá tr? cx ra kh?i ngan x?p
	call CHECKWIN     	; Ki?m tra k?t qu? choi        
	loop x                  ; L?p l?i chuong trình
	call PRINT_DRAW      	; N?u không ai th?ng in hòa
programEnd:   
	mov     ah, 0        	; Thi?t l?p thanh ghi AH thành giá tr? 0
        int     16h          	
ret                      		
	    
; Các hàm 
PRINT_MANG:         			; Th? t?c in b?ng lu?i
	push cx           		; Ð?y cx vào ngan x?p
	mov bx,0         		; Thi?t l?p ch? s? ban d?u
	mov cx,3          		; S? dòng c?a b?ng lu?i
	x1:
                call IN_DONG_MOI 	; In dòng m?i
                push cx          	; Ð?y cx vào ngan x?p
                mov cx, 3       	; S? c?t c?a b?ng lu?i
	x2:
	mov dl, MANG[bx] 		; Di chuy?n giá tr? grid vào dl
	mov ah, 2h   			; Câu l?nh in ký t?
	int 21h       
	call PRINT_Space 		; G?i hàm in kho?ng tr?ng
	inc bx       			; Tang ch? s?
	loop x2          		; L?p l?i qua các c?t
	pop cx          		; L?y l?i giá tr? cx
	loop x1              		; L?p lai qua cac dòng
	pop cx               		; L?y l?i giá tr? cx
	call IN_DONG_MOI    		; In dòng m?i 
ret                      					
        
IN_DONG_MOI:            		; Th? t?c in dòng m?i
	mov dl, 0ah     		; Kí t? xu?ng dòng
	mov ah, 2       		; Câu l?nh in kí t?
	int 21h         		; G?i ng?t d? in kí t?
	mov dl, 13          		 		
	mov ah, 2       		; Câu l?nh in kí t?
	int 21h         		; G?i ng?t d? in kí t?
ret                     			 		
        
PRINT_Space:            		; Th? t?c in kho?ng tr?ng
	mov dl, 32          		; Mã ascii c?a kho?ng tr?ng
	mov ah, 2            		; Câu l?nh in kí t?
	int 21h              		; G?i ng?t d? in kí t?
ret       
              		 			
NHAP:  				        ; Th? t?c d?c d? li?u d?u vào

	mov ah, 1        		; Cho phép nh?p kí t?
	int 21h               	 	; G?i ng?t d? nh?p d? li?u
	cmp al, '1'                     ; Ki?m tra giá tr? nh?p vào
	je VALID
	cmp al, '2'
	je VALID
	cmp al, '3'
	je VALID
	cmp al, '4'
	je VALID
	cmp al, '5'
	je VALID
	cmp al, '6'
	je VALID
	cmp al, '7'
	je VALID
	cmp al, '8'
	je VALID
	cmp al, '9'
	je VALID
	jmp NOT_VALID                   ; Quay l?i v? trí không h?p l?
	VALID:                          ; Ði?m h?p l?
ret                       					
        
PRINT_WELCOME:          	 	; Th? t?c in thông di?p chào m?ng
	lea dx, WELCOME   		; T?i d?a ch? c?a thông di?p vào dx
	mov ah, 9            		; Câu l?nh in chu?i
	int 21h             		; G?i ng?t d? in chu?i
ret                       					
        
PRINT_DRAW:                  		; Th? t?c in thông di?p hoa
	call IN_DONG_MOI       		; In dòng m?i
	lea dx, DRAW            	; T?i d?a ch? thông di?p
	mov ah, 9                	; Câu l?nh in chu?i
	int 21h                   	; G?i ng?t d? in chu?i
ret                         		 			
        
PRINT_WIN:                     		; Th? t?c in thông di?p chi?n th?ng
	call IN_DONG_MOI       	 	; In dòng m?i
	call PRINT_MANG           	; In b?ng lu?i l?n cu?i
	lea dx, WIN               	; T?i d?a ch? thông di?p
	mov ah, 9                 	; Câu l?nh in chu?i
	int 21h                    	; G?i ng?t d? in chu?i
	mov dl, PLAYER            	; Di chuy?n giá tr? ngu?i choi vào dl
	mov ah, 2h                 	; Câu l?nh in kí t?
	int 21h                    	; G?i ng?t d? in kí t?
	jmp programEnd            	; Quay l?i k?t thúc chuong trình
ret                            				
        
IN_NHAP:                 		; Th? t?c in thông di?p nh?p li?u
	lea dx, INPUT            	; T?i d?a ch? thông di?p
	mov ah, 9                   	; Câu l?nh in chu?i
	int 21h                       	; G?i ng?t d? in chu?i
	mov dl, PLAYER               	; Di chuy?n giá tr? ngu?i choi vào dl
	mov ah, 2h                     	; Câu l?nh in kí t?
	int 21h                       	; G?i ng?t d? in kí t?
	call PRINT_Space                ; G?i th? t?c in kho?ng tr?ng
ret                                				
        
CHECKWIN:                      		; Th? t?c ki?m tra k?t qu?
	mov bl, MANG[0]                 ; Ki?m tra hàng 0
	cmp bl, MANG[1]          	; So sánh giá tr? d?u tiên và th? 2
	jne skip1                	; N?u không gi?ng nhau b? qua
	cmp bl, MANG[2]          	; So sánh giá tr? d?u tiên và th? 3
	jne skip1                	; N?u không gi?ng nhau b? qua
	call PRINT_WIN           	; N?u gi?ng nhau in thông di?p chi?n th?ng

skip1:                           	; V? trí b? qua
	mov bl, MANG[3]          	; Ki?m tra hàng 1
	cmp bl, MANG[4]          	; So sánh giá tr? d?u tiên và th? 2 c?a hàng 1
	jne skip2                	; N?u không gi?ng nhau b? qua
	cmp bl, MANG[5]          	; So sánh giá tr? d?u tiên và th? 3 c?a hàng 1
	jne skip2                	; N?u không gi?ng nhau b? qua
	call PRINT_WIN           	; N?u gi?ng nhau in thông di?p chi?n th?ng

skip2:                           	; V? trí b? qua
	mov bl, MANG[6]          	; Ki?m tra hàng 2
	cmp bl, MANG[7]          	; So sánh giá tr? d?u tiên và th? 2 c?a hàng 2
	jne skip3                	; N?u không gi?ng nhau b? qua
	cmp bl, MANG[8]          	; So sánh giá tr? d?u tiên và th? 3 c?a hàng 2
	jne skip3                	; N?u không gi?ng nhau b? qua
	call PRINT_WIN           	; N?u gi?ng nhau in thông di?p chi?n th?ng

skip3:                           	; V? trí b? qua
	mov bl, MANG[0]          	; Ki?m tra c?t 0
	cmp bl, MANG[3]          	; So sánh v? trí d?u tiên và th? 2 c?a c?t 0
	jne skip4                	; N?u không gi?ng nhau b? qua
	cmp bl, MANG[6]          	; So sánh v? trí d?u tiên và th? 3 c?a c?t 0
	jne skip4               	; N?u không gi?ng nhau b? qua
	call PRINT_WIN           	; N?u gi?ng nhau in thông di?p chi?n th?ng

skip4:                           	; V? trí b? qua
	mov bl, MANG[1]          	; Ki?m tra c?t 1
	cmp bl, MANG[4]          	; So sánh v? trí d?u tiên và th? 2 c?a c?t 1
	jne skip5                	; N?u không gi?ng nhau b? qua
	cmp bl, MANG[7]          	; So sánh v? trí d?u tiên và th? 3 c?a c?t 1
	jne skip5                	; N?u không gi?ng nhau b? qua
	call PRINT_WIN           	; N?u gi?ng nhau in thông di?p chi?n th?ng

skip5:                           	; V? trí b? qua    
	mov bl, MANG[2]          	; Ki?m tra c?t 2
	cmp bl, MANG[5]          	; So sánh v? trí d?u tiên và th? 2 c?a c?t 2
	jne skip6                	; N?u không gi?ng nhau b? qua
	cmp bl, MANG[8]          	; So sánh v? trí d?u tiên và th? 3 c?a c?t 2
	jne skip6                	; N?u không gi?ng nhau b? qua
	call PRINT_WIN           	; N?u gi?ng nhau in thông di?p chi?n th?ng


skip6:                           	; V? trí b? qua
            
            mov bl, MANG[0]      	; Ki?m tra du?ng chéo chính
            cmp bl, MANG[4]      	; So sánh giá tr? d?u tiên và th? 2 c?a du?ng chéo chính
            jne skip7            	; N?u không gi?ng nhau b? qua
            cmp bl, MANG[8]      	; So sánh giá tr? d?u tiên và th? 3 c?a du?ng chéo chính
            jne skip7            	; N?u không gi?ng nhau b? qua
            call PRINT_WIN       	; N?u gi?ng nhau in thông di?p chi?n th?ng

skip7:               		 	; V? trí b? qua
	mov bl, MANG[2]          	; Ki?m tra du?ng chéo ph?
	cmp bl, MANG[4]          	; So sánh giá tr? d?u tiên và th? 2 c?a du?ng chéo ph?
	jne skip8                	; N?u không gi?ng nhau b? qua 
	cmp bl, MANG[6]          	; So sánh giá tr? d?u tiên và th? 3 c?a du?ng chéo ph?
	jne skip8                	; N?u không gi?ng nhau b? qua
	call PRINT_WIN          	; N?u gi?ng nhau in thông di?p chi?n th?ng

skip8:                           	; V? trí b? qua
ret                                                                 	 
        
XOA_MAN_HINH:                    	; Th? t?c xóa màn hình
	mov ax, 3                	; Xóa màn hình
	int 10h                  	; G?i ng?t
ret                                                            	
end main                         	; K?t thúc chuong trình