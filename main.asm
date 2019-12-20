;
; td3.asm
;
; Created: 19/11/2019 08:51:10
; Author : Nicolas
;

.NOLIST
.INCLUDE "m328pdef.inc"
.LIST
.def temp  = r16 ; multiporpose register 
.def count = r17;counter
.CSEG  ;begin code segement
.ORG 0000  ; set initial pointer to 0000
	rjmp SETUP
.ORG INT0addr
	rjmp IntV0  ;INT0 (ext:interrupt from pinD2)
.ORG INT1addr
	rjmp IntV1

SLEEPMODE:
	in temp, MCUCR ;move mcucr to temp     in because is a io register
	ldi temp,(1<<SE) ; Enable sleep mode
	out MCUCR, temp
	sleep ; Put MCU in sleep mode
	rjmp LOOP; return froom subroutine
DEFINEMODE:
	ldi temp, (1<<SM2) ;set power down Mode
	out MCUCR, temp ; ecrire le temp sur le MCUCR
	ret;
WAKEUP:
	in temp, MCUCR ; load the MCUCR to temp
	andi temp, !(1<<SE);and ooperation ~=!
	out MCUCR, temp;ecire sur le MCUCR
	ret;

INTV0:;interrupt for wake up will increase count
	rjmp WAKEUP
	inc count
	reti; return from interrupt

INTV1:;interrupt go to sleep
	rjmp SLEEPMODE
	reti; return from interrupt

; Replace with your application code
SETUP:
	ldi temp, low(RAMEND);set low ram pointer for stack
	out SPL, temp
	ldi temp,high(RAMEND);set high ram pointer fro stack
	out SPH, temp
	ldi count, 0x00
	ser temp ;set all bits to high
	out PORTD, temp ;set portD to high for pullup on input
	ldi temp, (1<<INT0)+(1<<INT1); int masks 0 for interrupts
	out GIMSK, temp ;write the interupts to interrupt register
	ldi temp, 0x0f; rising edge
	out MCUCR,temp
	sei;enable interrupts an off we go
	rjmp DEFINEMODE 
	rjmp SLEEPMODE

LOOP:
	rjmp LOOP