target remote localhost:2331
# monitor interface swd
# monitor device MKL05Z32xxx4
monitor speed 1000
load test
file test

# flash debug
monitor reg r13 = (0x00000000)
monitor reg pc = (0x00000004)

# ram debug
# monitor reg r13 = (0x20000000)
# monitor reg pc = (0x20000004)
