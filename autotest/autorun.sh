#!/bin/bash

CONSOLE_UART_PORT=$(python3 -m serial.tools.list_ports 0403:6010 -q -n 2) #Second instance of Nexsys USB2UART
UART1_UART_PORT=$(python3 -m serial.tools.list_ports 0403:6001 -q -n 1) #First instance of PMOD USB2UART

console_uart_found_flag=0
uart1_uart_found_flag=0

if [ "$CONSOLE_UART_PORT" == "" ]
then
    echo "Nexsys A7 not found"
else
    echo "Nexsys A7 found at $CONSOLE_UART_PORT"
    console_uart_found_flag=1
fi

if [ "$UART1_UART_PORT" == "" ]
then
    echo "UART1 not found"
else
    echo "UART1 found at $UART1_UART_PORT"
    uart1_uart_found_flag=1
fi

if [ $console_uart_found_flag == 1 ] && [ $uart1_uart_found_flag == 1 ] 
then
    echo "Both UART ports found"
    # run all tests
	python3 autorun.py $CONSOLE_UART_PORT $UART1_UART_PORT -e cam >& autoo.log
	echo "DONE. Results logged at ~/NightlyBuild/arnold2/core-v-mcu-cli-test/autotest/TestOutputs/"
else
    echo "Cannot start tests as console_uart_found_flag = $console_uart_found_flag and uart1_uart_found_flag = $uart1_uart_found_flag"
fi
