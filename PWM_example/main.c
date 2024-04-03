/*
 * main.c
 *
 *  Created on: 2024 Mar 27 08:28:17
 *  Author: AlbrechAndre
 */




#include "DAVE.h"                 //Declarations from DAVE Code Generation (includes SFR declaration)

/**

 * @brief main() - Application entry point
 *
 * <b>Details of function</b><br>
 * This routine is the application entry point. It is invoked by the device startup code. It is responsible for
 * invoking the APP initialization dispatcher routine - DAVE_Init() and hosting the place-holder for user application
 * code.
 */

int main(void)
{
  DAVE_Init();           /* Initialization of DAVE APPs  */

  int duty_A=1000; //duty cycle = 10%
  int duty_B=9000; //duty cycle = 90%
  int duty=5000; //duty cycle = 50%
  int i=0; //counter variable

  while(1U)
  {
	  if(i==50000){
		  duty=duty_A;
	  }
	  if(i==100000){
		  duty=duty_B;
	  }
	  if(i==150000){
		  i=0;
	  }

	  PWM_CCU8_SetDutyCycleAsymmetric(&PWM_CCU8_0, 0, duty); //sets the duty cycle to value of duty
	  i++; //counter i + 1
  }
}
