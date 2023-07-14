INCLUDE Irvine32.inc
includelib Winmm.lib
PlaySound PROTO,
        pszSound:PTR BYTE, 
        hmod:DWORD, 
        fdwSound:DWORD

; My coord clone for bytes.
coordinate STRUCT
col BYTE ?
row BYTE ?
coordinate ENDS
;

; The struct that represents an alien.
alien STRUCT
fill1 BYTE "  ",0
line1 BYTE "    ",0
line2 BYTE "        ",0
shot BYTE 0
shot2 BYTE 0
shot3 BYTE 0
direction BYTE 0
fire coordinate <121, 121>
fire2 coordinate <121, 121>
fire3 coordinate <121, 121>
bolt BYTE " ",0
alien ENDS
;

; The struct that represents the player.
player STRUCT
fill1 BYTE " ",0
line1 BYTE "  ",0
line2 BYTE "    ",0
line3 BYTE "    ",0
shot BYTE 0
bolt BYTE "  ",0
fire coordinate <58, 47>
position coordinate <58,47>
player ENDS
;

; The struct that represents a shield
shield STRUCT
fill1 BYTE "    ",0
fill2 BYTE "        ",0
line1 BYTE "            ",0
line2 BYTE "    ",0
line3 BYTE "  ",0
shield ENDS
;

; The macro that controls the movement of the aliens.
mMoveAliens MACRO
push eax
mov al, alienSuperposition.col
push eax
add al, 80
.if al < 120 && bigAl.direction == 0
	inc alienSuperposition.col
.elseif al == 120 && bigAl.direction == 0
	inc alienSuperposition.row
	mov bigAl.direction, 1
.endif
pop eax
.if al > 0  && bigAl.direction == 1
	dec alienSuperposition.col
.elseif al == 0  && bigAl.direction == 1
	inc alienSuperposition.row
	mov bigAl.direction, 0
.endif
pop eax
ENDM
;

; the macro that prints the background.
mSetBackground MACRO yval
push eax
push ecx
push edx
mov ecx, yval
mov dh, 0
mov dl, 0
call Gotoxy
loop1:
mov eax, black+(black*16)
call SetTextColor
push edx
mov edx, OFFSET backDrop
call WriteString
mov eax, black+(black*16)
call SetTextColor
mov edx, OFFSET cap
call WriteString
pop edx
inc dh
call Gotoxy
loop loop1
call Gotoxy
mov eax, black+(black*16)
call SetTextColor
mov edx, OFFSET backDrop
call WriteString
mov edx, OFFSET cap
call WriteString
pop edx
pop ecx
pop eax
ENDM
;

; The macro that prints an alien.
mPrintAlien MACRO xval, yval
push edx
push eax
mov dl, xval
mov dh, yval
call Gotoxy
mov eax,black+(black*16)
call SetTextColor
mov edx, OFFSET bigAl.fill1
call WriteString
mov eax,blue+(lightGreen*16)
call SetTextColor
mov edx, OFFSET bigAl.line1
call WriteString
mov eax,black+(black*16)
call SetTextColor
mov edx, OFFSET bigAl.fill1
call WriteString
mov dl, xval
mov dh, yval
inc dh
call Gotoxy
mov eax,blue+(lightGreen*16)
call SetTextColor
mov edx, OFFSET bigAl.line2
call WriteString
mov eax,black+(black*16)
call SetTextColor
pop eax
pop edx
ENDM
;

; The macro that prints the player.
mPrintPlayer MACRO xval, yval
push edx
push eax
mov dl, xval
mov dh, yval
call Gotoxy
mov eax,black+(black*16)
call SetTextColor
mov edx, OFFSET shitBrick.fill1
call WriteString
mov eax,blue+(lightGreen*16)
call SetTextColor
mov edx, OFFSET shitBrick.line1
call WriteString
mov eax,black+(black*16)
call SetTextColor
mov edx, OFFSET shitBrick.fill1
call WriteString
mov dl, xval
mov dh, yval
inc dh
call Gotoxy
mov eax,blue+(lightGreen*16)
call SetTextColor
mov edx, OFFSET shitBrick.line2
call WriteString
mov eax,black+(black*16)
call SetTextColor
mov dl, xval
mov dh, yval
inc dh
inc dh
call Gotoxy
mov eax,blue+(lightGreen*16)
call SetTextColor
mov edx, OFFSET shitBrick.line3
call WriteString
mov eax,black+(black*16)
call SetTextColor
pop eax
pop edx
ENDM
;

; The macro that prints each shield.
mPrintShield MACRO xval, yval
push edx
push eax
mov dl, xval
mov dh, yval
call Gotoxy
mov eax,blue+(lightGreen*16)
call SetTextColor
mov edx, OFFSET fortKnoxWannabe.line1
call WriteString
mov dl, xval
mov dh, yval
inc dh
call Gotoxy
mov eax,blue+(lightGreen*16)
call SetTextColor
mov edx, OFFSET fortKnoxWannabe.line2
call WriteString
mov eax,black+(black*16)
call SetTextColor
mov edx, OFFSET fortKnoxWannabe.fill1
call WriteString
mov eax,blue+(lightGreen*16)
call SetTextColor
mov edx, OFFSET fortKnoxWannabe.line2
call WriteString
mov dl, xval
mov dh, yval
add dh, 2
call Gotoxy
mov edx, OFFSET fortKnoxWannabe.line3
call WriteString
mov eax,black+(black*16)
call SetTextColor
mov edx, OFFSET fortKnoxWannabe.fill2
call WriteString
mov eax,blue+(lightGreen*16)
call SetTextColor
mov edx, OFFSET fortKnoxWannabe.line3
call WriteString
mov dl, xval
mov dh, yval
add dh, 3
call Gotoxy
mov edx, OFFSET fortKnoxWannabe.line3
call WriteString
mov eax,black+(black*16)
call SetTextColor
mov edx, OFFSET fortKnoxWannabe.fill2
call WriteString
mov eax,blue+(lightGreen*16)
call SetTextColor
mov edx, OFFSET fortKnoxWannabe.line3
call WriteString
pop eax
pop edx
ENDM
;

; The macro that prints the bolts from both the aliens and the player.
mPrintShot MACRO xval, yval
push edx
push eax
mov dl, xval
mov dh, yval
call Gotoxy
mov eax,blue+(lightBlue*16)
call SetTextColor
mov edx, OFFSET shitBrick.bolt
call WriteString
pop eax
pop edx
ENDM
;

.data
bigAl alien <>
shitBrick player <>
fortKnoxWannabe shield <>
alienList BYTE "1111111"
cap BYTE " ",0
backDrop BYTE 120 DUP(" "),0
alienSuperposition coordinate <20,10>
prompt BYTE "Are you ready to play? Maximize the window.",0
newGame BYTE "NEW GAME",0
winMess BYTE "YOU WIN!",0
loseMess BYTE "YOU LOSE!",0
invisibleCursor CONSOLE_CURSOR_INFO <1, FALSE>
gameTitle BYTE "Invaders",0
console DWORD ?
hits BYTE 0
lives BYTE 1
boomFile BYTE "boom.wav",0 ; sound from https://mixkit.co/free-sound-effects/arcade/
boltFile BYTE "bolt.wav",0 ; sound from https://mixkit.co/free-sound-effects/arcade/
alienShotFile BYTE "alienShot.wav",0 ; https://mixkit.co/free-sound-effects/arcade/

.code
main PROC

; Titles the game window.
INVOKE SetConsoleTitle,ADDR gameTitle
;

; Makes the cursor invisible.
INVOKE GetStdHandle,STD_OUTPUT_HANDLE
mov console, eax
INVOKE SetConsoleCursorInfo,console,ADDR invisibleCursor
;

; Starts the game.
startGame:

call Clrscr
mov edx, OFFSET prompt
mov ebx, OFFSET newGame
call MsgBoxAsk
cmp eax, 7
je endGame

; Controls the game loop.
gameLoop:

; Delays each round by 16 milliseconds.
mov  eax,16
call Delay
;

call gameShift
call printScr
cmp hits, 7
je win
cmp lives, 0
je lose

jmp gameLoop
;

; Resets the game if the player wishes to play again.
reset:
mov lives, 1
mov alienSuperposition.row, 10
mov alienSuperposition.col, 20
.if bigAl.shot == 1
	dec bigAl.shot
.endif
.if shitBrick.shot == 1
	dec shitBrick.shot
.endif
mov shitBrick.fire.row, 121
mov shitBrick.fire.col, 121
mov bigAl.fire.row, 121
mov bigAl.fire.col, 121
mov ecx, 7
xor esi, esi
fixloop:
.if alienList[esi] == "0"
	inc alienList[esi]
.endif
inc esi
loop fixloop
mov bigAl.shot, 0
mov shitBrick.fire, 0
mov hits, 0
jmp startGame
;

; Win message prompt.
win:
mov edx, OFFSET winMess
mov ebx, 0
call MsgBox
jmp reset
;

; Loss message prompt.
lose:
mov edx, OFFSET loseMess
mov ebx, 0
call MsgBox
jmp reset
;

endGame:
exit
main endp

; Prints out the positions of all sprites.
printScr proc

push eax
push ecx
push ebx

; Overwrites previous frame with background.
mSetBackground 50
;

; Loop that prints out the aliens.
; The loop was too long to utilize "loop" normally, so this solution alleviates that issue.
mov ecx, 8
mov bl, alienSuperposition.col
mov ah, 0
push esi
mov esi, 0
check:
loop aliens
jmp rest
aliens:
mov al, alienList[esi]
.if al == "1"
	mPrintAlien bl, alienSuperposition.row
.endif
inc esi
add bl, 12
jmp check
rest:
;

; Loop that prints out the shields.
; The loop was too long to utilize "loop" normally, so this solution alleviates that issue.
pop esi
mov ecx, 5
mov bl, 9
mov bh, 40
check2:
loop shields
jmp rest2
shields:
mPrintShield bl, bh
add bl, 30
jmp check2
rest2:
;

; This Prints out bolts if they are toggled on.
.if shitBrick.shot == 1
	mPrintShot shitBrick.fire.col, shitBrick.fire.row
.endif
.if bigAl.shot == 1
	mPrintShot bigAl.fire.col, bigAl.fire.row
.endif

.if bigAl.shot2 == 1
	mPrintShot bigAl.fire2.col, bigAl.fire2.row
.endif

.if bigAl.shot3 == 1
	mPrintShot bigAl.fire3.col, bigAl.fire3.row
.endif
;

; This prints the player.
mPrintPlayer shitBrick.position.col, shitBrick.position.row
;

; Holds the frame for 16 milliseconds; padding out the timing to about 30 fps.
mov  eax,16
call Delay
;

pop ebx
pop ecx
pop eax
ret

printScr endp

; Controls game movement and rules.
gameShift PROC

push ecx
push ebx
push eax
push edx

; Reads in input from the user. Skips if no input is recieved.
call ReadKey
jz noKey

.if dx == VK_RIGHT && shitBrick.position.col < 116
	inc shitBrick.position.col
	inc shitBrick.position.col
.elseif dx == VK_LEFT && shitBrick.position.col > 0
	dec shitBrick.position.col
	dec shitBrick.position.col
.elseif dx == VK_SPACE && shitBrick.shot == 0
	mov shitBrick.shot, 1
	mov bl, shitBrick.position.col
	inc bl
	mov shitBrick.fire.col, bl
	mov bl, shitBrick.position.row
	dec bl
	mov shitBrick.fire.row, bl
.endif

noKey:
;

; Where the macro that moves the aliens is inserted.
mMoveAliens
;

; Generates an alien bolt from one of the aliens at random if a bolt is not on screen.
.if bigAl.shot == 0
	mov eax, 7
	call RandomRange 
	inc al
	.if alienList[eax] == "1"
		mov bl, alienSuperposition.col
		inc bl
		inc bl
		mov dl, alienSuperposition.row
		inc dl
		inc dl
		mov cl, 12
		mul cl
		add bl, al
		mov bigAl.shot, 1
		mov bigAl.fire.row, dl
		mov bigAl.fire.col, bl
	.endif
.endif

.if bigAl.shot2 == 0
	mov eax, 7
	call RandomRange 
	inc al
	.if alienList[eax] == "1"
		mov bl, alienSuperposition.col
		inc bl
		inc bl
		mov dl, alienSuperposition.row
		inc dl
		inc dl
		mov cl, 12
		mul cl
		add bl, al
		mov bigAl.shot2, 1
		mov bigAl.fire2.row, dl
		mov bigAl.fire2.col, bl
	.endif
.endif

.if bigAl.shot3 == 0
	mov eax, 7
	call RandomRange 
	inc al
	.if alienList[eax] == "1"
		mov bl, alienSuperposition.col
		inc bl
		inc bl
		mov dl, alienSuperposition.row
		inc dl
		inc dl
		mov cl, 12
		mul cl
		add bl, al
		mov bigAl.shot3, 1
		mov bigAl.fire3.row, dl
		mov bigAl.fire3.col, bl
	.endif
.endif
;

; Checks to see if the player's bolt has hit an alien. The aliens' hitboxes are calulated by their "superposition".
mov bl, alienSuperposition.col
mov bh, alienSuperposition.row
add bh, 2
mov dl, alienSuperposition.col
add dl, 8
mov al, shitbrick.fire.col
inc al
mov ecx, 7
push esi
mov esi, 0

anLoop:
.if shitBrick.fire.row == bh && (shitbrick.fire.col >= bl && shitbrick.fire.col < dl || al >= bl && al < dl) && alienList[esi] == "1"
	add hits, 1
	mov shitBrick.shot, 0
	mov al, shitBrick.position.row
	mov ah, shitBrick.position.col
	inc al
	inc ah
	mov shitBrick.fire.row, al
	mov shitBrick.fire.col, ah
	dec alienList[esi]
.endif


inc esi
add dl, 12
add bl, 12

loop anLoop
pop esi
;

; Checks to see if any of the bolts have touched the shields.
.if bigAl.fire.row == 39 && ((bigAl.fire.col >= 9 && bigAl.fire.col < 21) || (bigAl.fire.col >= 39 && bigAl.fire.col < 51) || (bigAl.fire.col >= 69 && bigAl.fire.col < 81) || (bigAl.fire.col >= 99 && bigAl.fire.col < 111))
	mov bigAl.shot, 0

.elseif bigAl.fire2.row == 39 && ((bigAl.fire2.col >= 9 && bigAl.fire2.col < 21) || (bigAl.fire2.col >= 39 && bigAl.fire2.col < 51) || (bigAl.fire2.col >= 69 && bigAl.fire2.col < 81) || (bigAl.fire2.col >= 99 && bigAl.fire2.col < 111))
	mov bigAl.shot2, 0

.elseif bigAl.fire3.row == 39 && ((bigAl.fire3.col >= 9 && bigAl.fire3.col < 21) || (bigAl.fire3.col >= 39 && bigAl.fire3.col < 51) || (bigAl.fire3.col >= 69 && bigAl.fire3.col < 81) || (bigAl.fire3.col >= 99 && bigAl.fire3.col < 111))
	mov bigAl.shot3, 0
.endif

.if shitBrick.fire.row == 41 && ((shitBrick.fire.col >= 9 && shitBrick.fire.col < 21) || (shitBrick.fire.col >= 39 && shitBrick.fire.col < 51) || (shitBrick.fire.col >= 69 && shitBrick.fire.col < 81) || (shitBrick.fire.col >= 99 && shitBrick.fire.col < 111))
	mov shitBrick.shot, 0
.endif
;

; Checks to see if the aliens have reached the top of the shields.
mov al, alienSuperposition.row
inc al
.if al == 39
	dec lives
.endif
;

; Checks to see if the player was hit.
mov al, shitBrick.position.col
add al, 4
mov bl, bigAl.fire.col
mov bh, bigAl.fire.col
inc bh

.if bigAl.fire.row == 46 && ((shitBrick.position.col <= bl && al > bl) || (shitBrick.position.col <= bh && al > bh))
	dec bigAl.shot
	dec lives
.endif

mov bl, bigAl.fire2.col
mov bh, bigAl.fire2.col
inc bh

.if bigAl.fire2.row == 46 && ((shitBrick.position.col <= bl && al > bl) || (shitBrick.position.col <= bh && al > bh))
	dec bigAl.shot2
	dec lives
.endif

mov bl, bigAl.fire3.col
mov bh, bigAl.fire3.col
inc bh

.if bigAl.fire3.row == 46 && ((shitBrick.position.col <= bl && al > bl) || (shitBrick.position.col <= bh && al > bh))
	dec bigAl.shot3
	dec lives
.endif
;

; Checks to see if the bolts are in valid regions. If they are then they move, otherwise the get toggled off.
.if shitBrick.shot == 1

	.if shitBrick.fire.row > 0
		dec shitBrick.fire.row
	.else
	mov shitBrick.shot, 0
	.endif

.endif

.if bigAl.shot == 1
	.if bigAl.fire.row < 49
		inc bigAl.fire.row
	.else
	mov bigAl.shot, 0
	.endif
.endif

.if bigAl.shot2 == 1
	.if bigAl.fire2.row < 49
		inc bigAl.fire2.row
	.else
	mov bigAl.shot2, 0
	.endif
.endif

.if bigAl.shot3 == 1
	.if bigAl.fire3.row < 49
		inc bigAl.fire3.row
	.else
	mov bigAl.shot3, 0
	.endif
.endif
;

.if lives == 0
INVOKE PlaySound, OFFSET boomFile, NULL,0h
.endif

pop edx
pop eax
pop ebx
pop ecx
ret
gameShift endp
end main
