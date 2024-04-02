Description of example project
==============================
This example implements a Buck Converter in Voltage Control Mode controller 
for being used together with the PV Optimizer.
The project is implemented using XMC1300, a 32-bit ARM Cortex M0
based microcontroller. It has dedicated control peripherals
such as the CCU8 PWM module for PWM generation and a Versatile Analog-to-Digital
(VADC) module for analog signal measurement, making it suitable for applications that require fast
calculation such as the Voltage Control mode.

The voltage Control loop is implemented by a classic 3 poles 3 zeros filter using fixed points values.
The provided filter coefficients has been selected to have the following controller characteristics:
 + Switching freq = 200kHz
 + Crossover freq = 5kHz
 + Phase margin   = 50 degrees
 + PWM resoluiton = 15.625 ns
 + ADC resolution = 12 bits 
 
VADC conversion is being continuously triggered by the Compare Match 2 of the CCU8(set by default to the maximum, period value).
Once the output voltage has being measured by the VADC an interrupt is generated. 
Inside the ISR, the 3 poles 3 zeros controller is applied and new value for the duty cycle is set.

ADC Trigger                        ADC Trigger
   ;                                   :
   ;_______                            :________
PWM|    <--|-->                        |     <--|-->
___|  20%  |___________________________|  20%   |_______
   ;                                   :
   ;                                   :
   ;   ADC                             :   ADC
   ;<--------> __________              :<--------> __________
ISR;          | Filter + |             :          | Filter + |
   ;          |  PWM     |             :          |  PWM     |
___;__________|  update  |_____________:__________|  update  |_______

One instance of each of those DAVE 4 APPs has been used to easy the peripherals configuration:

PWM_CCU8 (PWM, generates the ADC trigger through the CCU8 peripheral(Compare Match 2) and the PWM(Compare Match 1))
ADC_MEASUREMENT_ADV(Output Voltage measurement)
INTERRUPT (NVIC configuration)
DIGITAL_IO_HS_Boost (switches high side of boost stage constant on)
DIGITAL_IO_LS_Boost (switches low side of boost stage constant off)


Filter related APIs are implemented in the xmc_3p3z_filter_fixed.h file
while the PWM initialization and control ISR are implemented in the main.c.
   
Hardware Setup
===============
PV Optimizer Board
Vout P2.3
CCU8 direct output P0.0
CCU8 inverted output P0.5
DIGITAL_IO (HS_boost) P0.6
DIGITAL_IO (LS_boost) P0.7
Vin  P2.10 (not measured in project)

How to test the application
============================
a. Import the project
b. Prepare board set up: connect PV Optimizer and supply power with external power supply to it. Pin3 = 3.3V, Pin4 = GND or Pin5 = GND and Pin6= 3.3V  
    Make sure power 	
c. Compile and flash the application onto the device 
d. disconnect power supply of debugger and supply board at input clamps. Power the system.
e. Run the application.
f. Check via oscilloscope or multimeter the output voltage.
   Vout is now controlled to be stable at 20 V independent of load. 

If changes are needed in APPs configuration, make sure code is generated again before compiling
