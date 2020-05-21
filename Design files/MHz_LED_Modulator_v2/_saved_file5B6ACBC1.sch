EESchema Schematic File Version 3
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:MHz_LED_Modulator_v2-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 2
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text Label 4700 4100 2    60   ~ 0
Vin(Arduino)
Text Label 4650 3250 1    60   ~ 0
IOREF
Text Label 4200 4300 0    60   ~ 0
A0
Text Label 4200 4400 0    60   ~ 0
A1
Text Label 4200 4500 0    60   ~ 0
A2
Text Label 4200 4600 0    60   ~ 0
A3
Text Label 4200 4700 0    60   ~ 0
A4(SDA)
Text Label 4200 4800 0    60   ~ 0
A5(SCL)
Text Label 5850 4800 0    60   ~ 0
0(Rx)
Text Label 5850 4600 0    60   ~ 0
2
Text Label 5850 4700 0    60   ~ 0
1(Tx)
Text Label 5850 4500 0    60   ~ 0
3(**)
Text Label 5850 4400 0    60   ~ 0
4
Text Label 5850 4300 0    60   ~ 0
5(**)
Text Label 5850 4200 0    60   ~ 0
6(**)
Text Label 5850 4100 0    60   ~ 0
7
Text Label 5850 3900 0    60   ~ 0
8
Text Label 5850 3800 0    60   ~ 0
9(**)
Text Label 5850 3700 0    60   ~ 0
10(**/SS)
Text Label 5850 3600 0    60   ~ 0
11(**/MOSI)
Text Label 5850 3500 0    60   ~ 0
12(MISO)
Text Label 5850 3400 0    60   ~ 0
13(SCK)
Text Label 5850 3200 0    60   ~ 0
AREF
NoConn ~ 4700 3400
Text Label 5850 3100 0    60   ~ 0
A4(SDA*)
Text Label 5850 3000 0    60   ~ 0
A5(SCL*)
Text Notes 3850 2700 0    60   ~ 0
Shield for Arduino that uses\nthe same pin disposition\nlike "Uno" board Rev 3.
$Comp
L CONN_01X08 P?
U 1 1 5B6AD07B
P 4900 3750
F 0 "P?" H 4900 4200 50  0000 C CNN
F 1 "Power" V 5000 3750 50  0000 C CNN
F 2 "Socket_Arduino_Uno:Socket_Strip_Arduino_1x08" V 5050 3750 20  0000 C CNN
F 3 "" H 4900 3750 50  0000 C CNN
	1    4900 3750
	1    0    0    -1  
$EndComp
Text Label 4700 3600 2    60   ~ 0
Reset
$Comp
L +3.3V #PWR?
U 1 1 5B6AD083
P 4450 3250
F 0 "#PWR?" H 4450 3100 50  0001 C CNN
F 1 "+3.3V" H 4450 3390 50  0000 C CNN
F 2 "" H 4450 3250 50  0000 C CNN
F 3 "" H 4450 3250 50  0000 C CNN
	1    4450 3250
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR?
U 1 1 5B6AD089
P 4350 3150
F 0 "#PWR?" H 4350 3000 50  0001 C CNN
F 1 "+5V" H 4350 3290 50  0000 C CNN
F 2 "" H 4350 3150 50  0000 C CNN
F 3 "" H 4350 3150 50  0000 C CNN
	1    4350 3150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 5B6AD08F
P 4600 4950
F 0 "#PWR?" H 4600 4700 50  0001 C CNN
F 1 "GND" H 4600 4800 50  0000 C CNN
F 2 "" H 4600 4950 50  0000 C CNN
F 3 "" H 4600 4950 50  0000 C CNN
	1    4600 4950
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X06 P?
U 1 1 5B6AD095
P 4900 4550
F 0 "P?" H 4900 4900 50  0000 C CNN
F 1 "Analog" V 5000 4550 50  0000 C CNN
F 2 "Socket_Arduino_Uno:Socket_Strip_Arduino_1x06" V 5050 4600 20  0000 C CNN
F 3 "" H 4900 4550 50  0000 C CNN
	1    4900 4550
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X08 P?
U 1 1 5B6AD09C
P 5300 4450
F 0 "P?" H 5300 4900 50  0000 C CNN
F 1 "Digital" V 5400 4450 50  0000 C CNN
F 2 "Socket_Arduino_Uno:Socket_Strip_Arduino_1x08" V 5450 4400 20  0000 C CNN
F 3 "" H 5300 4450 50  0000 C CNN
	1    5300 4450
	-1   0    0    -1  
$EndComp
$Comp
L CONN_01X10 P?
U 1 1 5B6AD0A3
P 5300 3450
F 0 "P?" H 5300 4000 50  0000 C CNN
F 1 "Digital" V 5400 3450 50  0000 C CNN
F 2 "Socket_Arduino_Uno:Socket_Strip_Arduino_1x10" V 5450 3450 20  0000 C CNN
F 3 "" H 5300 3450 50  0000 C CNN
	1    5300 3450
	-1   0    0    -1  
$EndComp
Text Notes 5000 3400 0    60   ~ 0
1
Text GLabel 5600 4950 0    60   Input ~ 0
GND(NC)
Text Notes 4100 5400 0    60   ~ 0
Op-amp LED driver
$Comp
L R R?
U 1 1 5B6AD0B1
P 5750 4950
F 0 "R?" V 5650 4950 50  0000 C CNN
F 1 "10" V 5850 4950 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5680 4950 50  0001 C CNN
F 3 "https://www.seielect.com/Catalog/SEI-rncp.pdf" H 5750 4950 50  0001 C CNN
F 4 "Stackpole Electronics Inc." V 5750 4950 60  0001 C CNN "Manufacturer"
F 5 "RNCP0603FTD10R0" V 5750 4950 60  0001 C CNN "Manufacturer Part #"
F 6 "RNCP0603FTD10R0CT-ND" V 5750 4950 60  0001 C CNN "Digikey Part #"
F 7 "Prevent ground loop with second ground pin" V 5750 4950 60  0001 C CNN "NOTE:"
	1    5750 4950
	0    1    1    0   
$EndComp
$Comp
L GND #PWR?
U 1 1 5B6AD0B8
P 5900 4950
F 0 "#PWR?" H 5900 4700 50  0001 C CNN
F 1 "GND" H 5900 4800 50  0000 C CNN
F 2 "" H 5900 4950 50  0000 C CNN
F 3 "" H 5900 4950 50  0000 C CNN
	1    5900 4950
	0    -1   -1   0   
$EndComp
$Comp
L D_Schottky D?
U 1 1 5B6AD0C2
P 4050 4600
F 0 "D?" H 4200 4550 50  0000 C CNN
F 1 "D_Schottky" H 4200 4700 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-323" H 4050 4600 50  0001 C CNN
F 3 "https://toshiba.semicon-storage.com/info/docget.jsp?did=14077&prodName=CUS10S30" H 4050 4600 50  0001 C CNN
F 4 "Toshiba Semiconductor and Storage" H 4050 4600 60  0001 C CNN "Manufacturer"
F 5 "CUS10S30,H3F" H 4050 4600 60  0001 C CNN "Manufacturer Part #"
F 6 "CUS10S30H3FCT-ND" H 4050 4600 60  0001 C CNN "Digikey Part #"
F 7 "230mV @ 100mA max" H 4050 4600 60  0001 C CNN "NOTE:"
	1    4050 4600
	-1   0    0    1   
$EndComp
$Comp
L R_Pack04 RN?
U 1 1 5B6AD0CD
P 4150 3800
F 0 "RN?" V 3850 3750 50  0000 L CNN
F 1 "4.7k" V 3900 3500 50  0000 L CNN
F 2 "Ben_Custom:Resistor_Array_x4_1206" V 4425 3800 50  0001 C CNN
F 3 "https://industrial.panasonic.com/cdbs/www-data/pdf/AOC0000/AOC0000C14.pdf" H 4150 3800 50  0001 C CNN
F 4 "Panasonic Electronic Components" V 4150 3800 60  0001 C CNN "Manufacturer"
F 5 "EXB-38V472JV" V 4150 3800 60  0001 C CNN "Manufacturer Part #"
F 6 "Y9472CT-ND" V 4150 3800 60  0001 C CNN "Digikey Part #"
F 7 "±5% ±200ppm/°C 62.5mW" V 4150 3800 60  0001 C CNN "NOTE:"
	1    4150 3800
	0    1    1    0   
$EndComp
$Comp
L GND #PWR?
U 1 1 5B6AD0D4
P 4000 4050
F 0 "#PWR?" H 4000 3800 50  0001 C CNN
F 1 "GND" V 3900 4000 50  0000 C CNN
F 2 "" H 4000 4050 50  0000 C CNN
F 3 "" H 4000 4050 50  0000 C CNN
	1    4000 4050
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR?
U 1 1 5B6AD0DA
P 4350 3900
F 0 "#PWR?" H 4350 3650 50  0001 C CNN
F 1 "GND" H 4350 3750 50  0000 C CNN
F 2 "" H 4350 3900 50  0000 C CNN
F 3 "" H 4350 3900 50  0000 C CNN
	1    4350 3900
	0    -1   -1   0   
$EndComp
$Comp
L Thermistor TH?
U 1 1 5B6AD0E4
P 3600 4300
F 0 "TH?" V 3600 4300 50  0000 C CNN
F 1 "10k" V 3449 4300 50  0000 C CNN
F 2 "Ben_Custom:CC_silkscreen" H 3600 4300 50  0001 C CNN
F 3 "http://www.cantherm.com/wp-content/uploads/2017/05/cantherm_mf52_1.pdf" H 3600 4300 50  0001 C CNN
F 4 "Cantherm" V 3600 4300 60  0001 C CNN "Manufacturer"
F 5 "MF52A2103J3470" V 3600 4300 60  0001 C CNN "Manufacturer Part #"
F 6 "317-1258-ND" V 3600 4300 60  0001 C CNN "Digikey Part #"
F 7 "B25/50 3470K" V 3600 4300 60  0001 C CNN "NOTE:"
	1    3600 4300
	0    1    1    0   
$EndComp
Wire Wire Line
	4600 3900 4600 4950
Wire Wire Line
	5600 3300 5600 4950
Wire Wire Line
	5500 3300 5600 3300
Wire Wire Line
	5500 4100 5850 4100
Wire Wire Line
	5500 4200 5850 4200
Wire Wire Line
	5500 4300 5850 4300
Wire Wire Line
	5500 4400 5850 4400
Wire Wire Line
	5500 4500 5850 4500
Wire Wire Line
	5500 4600 5850 4600
Wire Wire Line
	5500 4700 5850 4700
Wire Wire Line
	5500 4800 5850 4800
Wire Wire Line
	5500 3000 5850 3000
Wire Wire Line
	5500 3100 5850 3100
Wire Wire Line
	5500 3200 5850 3200
Wire Wire Line
	5500 3400 5850 3400
Wire Wire Line
	5500 3500 5850 3500
Wire Wire Line
	5500 3600 5850 3600
Wire Wire Line
	5500 3700 5850 3700
Wire Wire Line
	5500 3800 5850 3800
Wire Wire Line
	5500 3900 5850 3900
Wire Wire Line
	4700 4800 4200 4800
Wire Wire Line
	4700 4700 4200 4700
Wire Wire Line
	4700 4600 4200 4600
Wire Wire Line
	4450 3700 4450 3250
Wire Wire Line
	4350 3150 4350 3800
Connection ~ 4600 4000
Wire Wire Line
	4700 4000 4600 4000
Wire Wire Line
	4700 3900 4600 3900
Wire Wire Line
	4350 3800 4700 3800
Wire Wire Line
	4700 3700 4450 3700
Wire Wire Line
	4650 3500 4700 3500
Wire Wire Line
	4650 3250 4650 3500
Wire Notes Line
	5225 2775 5225 2425
Wire Notes Line
	3825 2775 5225 2775
Connection ~ 4350 3800
Connection ~ 4350 3700
Connection ~ 4350 3600
Wire Wire Line
	3950 3800 3900 3800
Wire Wire Line
	3900 3800 3900 4500
Wire Wire Line
	3900 4500 4700 4500
Wire Wire Line
	3950 3700 3850 3700
Wire Wire Line
	3850 3700 3850 4400
Wire Wire Line
	3850 4400 4700 4400
Wire Wire Line
	3950 3600 3800 3600
Wire Wire Line
	3800 3600 3800 4300
Wire Wire Line
	3800 4300 4700 4300
Wire Wire Line
	3950 3900 3950 4050
Wire Wire Line
	3950 4050 4000 4050
$Comp
L Conn_01x05_Female J?
U 1 1 5B6AD11F
P 3200 4500
F 0 "J?" H 3150 4200 50  0000 C CNN
F 1 "Conn_01x05_Female" V 3250 4500 50  0000 C CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x05_Pitch2.54mm" H 3200 4500 50  0001 C CNN
F 3 "http://www.sullinscorp.com/drawings/78_P(N)PxCxxxLFBN-RC,_10492-H.pdf" H 3200 4500 50  0001 C CNN
F 4 "Sullins Connector Solutions" H 3200 4500 60  0001 C CNN "Manufacturer"
F 5 "PPPC051LFBN-RC" H 3200 4500 60  0001 C CNN "Manufacturer Part #"
F 6 "S7038-ND" H 3200 4500 60  0001 C CNN "Digikey Part #"
F 7 " " H 3200 4500 60  0001 C CNN "NOTE:"
	1    3200 4500
	-1   0    0    1   
$EndComp
Wire Wire Line
	3450 4400 3400 4400
Wire Wire Line
	3400 4500 3500 4500
Wire Wire Line
	3900 4600 3400 4600
Wire Wire Line
	3400 4250 3400 4500
Connection ~ 3400 4400
Connection ~ 3400 4300
$Comp
L GND #PWR?
U 1 1 5B6AD12C
P 3400 4250
F 0 "#PWR?" H 3400 4000 50  0001 C CNN
F 1 "GND" H 3500 4100 50  0000 C CNN
F 2 "" H 3400 4250 50  0000 C CNN
F 3 "" H 3400 4250 50  0000 C CNN
	1    3400 4250
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR?
U 1 1 5B6AD132
P 3400 4700
F 0 "#PWR?" H 3400 4450 50  0001 C CNN
F 1 "GND" V 3400 4500 50  0000 C CNN
F 2 "" H 3400 4700 50  0000 C CNN
F 3 "" H 3400 4700 50  0000 C CNN
	1    3400 4700
	0    -1   -1   0   
$EndComp
$Comp
L Thermistor TH?
U 1 1 5B6AD13C
P 3650 4400
F 0 "TH?" V 3650 4400 50  0000 C CNN
F 1 "10k" V 3499 4400 50  0001 C CNN
F 2 "Ben_Custom:CC_Attribution" H 3650 4400 50  0001 C CNN
F 3 "http://www.cantherm.com/wp-content/uploads/2017/05/cantherm_mf52_1.pdf" H 3650 4400 50  0001 C CNN
F 4 "Cantherm" V 3650 4400 60  0001 C CNN "Manufacturer"
F 5 "MF52A2103J3470" V 3650 4400 60  0001 C CNN "Manufacturer Part #"
F 6 "317-1258-ND" V 3650 4400 60  0001 C CNN "Digikey Part #"
F 7 "B25/50 3470K" V 3650 4400 60  0001 C CNN "NOTE:"
	1    3650 4400
	0    1    1    0   
$EndComp
$Comp
L Thermistor TH?
U 1 1 5B6AD147
P 3700 4500
F 0 "TH?" V 3700 4500 50  0000 C CNN
F 1 "10k" V 3549 4500 50  0001 C CNN
F 2 "Ben_Custom:CC_Share_alike" H 3700 4500 50  0001 C CNN
F 3 "http://www.cantherm.com/wp-content/uploads/2017/05/cantherm_mf52_1.pdf" H 3700 4500 50  0001 C CNN
F 4 "Cantherm" V 3700 4500 60  0001 C CNN "Manufacturer"
F 5 "MF52A2103J3470" V 3700 4500 60  0001 C CNN "Manufacturer Part #"
F 6 "317-1258-ND" V 3700 4500 60  0001 C CNN "Digikey Part #"
F 7 "B25/50 3470K" V 3700 4500 60  0001 C CNN "NOTE:"
	1    3700 4500
	0    1    1    0   
$EndComp
Wire Notes Line
	6500 5250 3050 5250
Wire Notes Line
	3050 5250 3050 2450
$Comp
L POT RV?
U 1 1 5B6AD154
P 4200 4950
F 0 "RV?" V 4086 4950 50  0000 C CNN
F 1 "10k" V 4200 4950 50  0000 C CNN
F 2 "Symbols:OSHW-Symbol_6.7x6mm_SilkScreen" H 4200 4950 50  0001 C CNN
F 3 "http://www.ttelectronics.com/sites/default/files/download-files/Datasheet_RotaryPanelPot_P170series.pdf" H 4200 4950 50  0001 C CNN
F 4 "TT Electronics/BI" V 4200 4950 60  0001 C CNN "Manufacturer"
F 5 "P170S-FC20BR10K" V 4200 4950 60  0001 C CNN "Manufacturer Part #"
F 6 "987-1318-ND" V 4200 4950 60  0001 C CNN "Digikey Part #"
F 7 "Rotary, SPST" V 4200 4950 60  0001 C CNN "NOTE:"
	1    4200 4950
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR?
U 1 1 5B6AD15B
P 4350 4950
F 0 "#PWR?" H 4350 4700 50  0001 C CNN
F 1 "GND" H 4350 4800 50  0000 C CNN
F 2 "" H 4350 4950 50  0000 C CNN
F 3 "" H 4350 4950 50  0000 C CNN
	1    4350 4950
	0    -1   -1   0   
$EndComp
$Comp
L +5V #PWR?
U 1 1 5B6AD161
P 4050 4950
F 0 "#PWR?" H 4050 4800 50  0001 C CNN
F 1 "+5V" H 4050 5090 50  0000 C CNN
F 2 "" H 4050 4950 50  0000 C CNN
F 3 "" H 4050 4950 50  0000 C CNN
	1    4050 4950
	0    -1   -1   0   
$EndComp
Text Notes 7250 7000 0    315  ~ 0
Box Schematic
$EndSCHEMATC
