void __attribute__((weak)) Reset_Handler(void);     /* Reset Handler */
extern const void __StackTop ;
void Default_Handler(void);
__attribute__ ((section(".vector_table")))
void (* const intVectors[49])(void) = {
  &__StackTop,
  Reset_Handler      // The reset handler
};
 
//extern int main(void);
void Reset_Handler(void) {
  // main();
  volatile int x = 0;
  for (x = 0; x < 5; ) {
    x++;
  }
  // If main() ever exit, this should hold MCU from running wild
  while(1);
}
