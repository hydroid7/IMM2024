/*
 * main.c
 *
 *  Created on: 3 Jun 2024
 *      Author: Lóránt Meszlényi
 */


#include <DAVE.h>

int main(void) {
  DAVE_STATUS_t status;
  status = DAVE_Init();
  if(status == DAVE_STATUS_FAILURE) {
    /* Placeholder for error handler code. The while loop below can be replaced with an user error handler. */
    XMC_DEBUG("DAVE APPs initialization failed\n");

    while(1U) {

    }
  }
  /* ADC trigger signal setting */
//  XMC_CCU8_SLICE_SetTimerCompareMatchChannel2(PWM_CCU8_0.ccu8_slice_ptr,TRIGGER_ADC);
//  PWM_CCU8_0.ccu8_module_ptr->GCSS= 0x1;

  /* Start PWM */
  PWM_CCU8_Start(&PWM_CCU8_0);
  while(1U) {
	  uint16_t inputs = BUS_IO_Read(&DIP_SWITCH_IO_0);
	  XMC_DEBUG("Inputs are %b\n", inputs);
  }
}
