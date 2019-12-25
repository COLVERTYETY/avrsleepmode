# avrsleepmode [![Codacy Badge](https://api.codacy.com/project/badge/Grade/547f99d5b02a436ea8ea8a31868fbcb1)](https://www.codacy.com/manual/COLVERTYETY/avrsleepmode?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=COLVERTYETY/avrsleepmode&amp;utm_campaign=Badge_Grade)

___

##  

###   

#### Context

You can find here some exemple code on how to use sleep mode on an atmega328p in avr assembly.
This code was written as part of a 1st year course on mcu architecture.
If any avrfreaks would happen to pass by I am open to all critiscisme and pull requests.
___

#### About the code

Two interrupts are used to either send the mcu to sleepmode(INTV1) or to wake it up(INTV0).
The number of times the mcu has been waken up are counted in the "count" register.
Current sleemode is PowerDown.

##### for reference other sleep modes are:

* 000:Idle Mode
* 001:ADC noise Reduction Mode
* 010:PowerDown Mode
* 011:Standby
* 111:Extended Standby
