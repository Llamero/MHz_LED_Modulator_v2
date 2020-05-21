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
Sheet 1 1
Title ""
Date "lun. 30 mars 2015"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text Label 9400 2150 2    60   ~ 0
Vin(Arduino)
Text Label 9350 1300 1    60   ~ 0
IOREF
Text Label 8900 2350 0    60   ~ 0
A0
Text Label 8900 2450 0    60   ~ 0
A1
Text Label 8900 2550 0    60   ~ 0
A2
Text Label 8900 2650 0    60   ~ 0
A3
Text Label 8900 2750 0    60   ~ 0
A4(SDA)
Text Label 8900 2850 0    60   ~ 0
A5(SCL)
Text Label 10550 2850 0    60   ~ 0
0(Rx)
Text Label 10550 2650 0    60   ~ 0
2
Text Label 10550 2750 0    60   ~ 0
1(Tx)
Text Label 10550 2550 0    60   ~ 0
3(**)
Text Label 10550 2450 0    60   ~ 0
4
Text Label 10550 2350 0    60   ~ 0
5(**)
Text Label 10550 2250 0    60   ~ 0
6(**)
Text Label 10550 2150 0    60   ~ 0
7
Text Label 10550 1950 0    60   ~ 0
8
Text Label 10550 1850 0    60   ~ 0
9(**)
Text Label 10550 1750 0    60   ~ 0
10(**/SS)
Text Label 10550 1650 0    60   ~ 0
11(**/MOSI)
Text Label 10550 1550 0    60   ~ 0
12(MISO)
Text Label 10550 1450 0    60   ~ 0
13(SCK)
Text Label 10550 1250 0    60   ~ 0
AREF
NoConn ~ 9400 1450
Text Label 10550 1150 0    60   ~ 0
A4(SDA*)
Text Label 10550 1050 0    60   ~ 0
A5(SCL*)
Text Notes 8550 750  0    60   ~ 0
Shield for Arduino that uses\nthe same pin disposition\nlike "Uno" board Rev 3.
$Comp
L CONN_01X08 P1
U 1 1 56D70129
P 9600 1800
F 0 "P1" H 9600 2250 50  0000 C CNN
F 1 "Power" V 9700 1800 50  0000 C CNN
F 2 "Socket_Arduino_Uno:Socket_Strip_Arduino_1x08" V 9750 1800 20  0000 C CNN
F 3 "" H 9600 1800 50  0000 C CNN
	1    9600 1800
	1    0    0    -1  
$EndComp
Text Label 9400 1650 2    60   ~ 0
Reset
$Comp
L +3.3V #PWR01
U 1 1 56D70538
P 9150 1300
F 0 "#PWR01" H 9150 1150 50  0001 C CNN
F 1 "+3.3V" H 9150 1440 50  0000 C CNN
F 2 "" H 9150 1300 50  0000 C CNN
F 3 "" H 9150 1300 50  0000 C CNN
	1    9150 1300
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR02
U 1 1 56D707BB
P 9050 1200
F 0 "#PWR02" H 9050 1050 50  0001 C CNN
F 1 "+5V" H 9050 1340 50  0000 C CNN
F 2 "" H 9050 1200 50  0000 C CNN
F 3 "" H 9050 1200 50  0000 C CNN
	1    9050 1200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR03
U 1 1 56D70CC2
P 9300 3000
F 0 "#PWR03" H 9300 2750 50  0001 C CNN
F 1 "GND" H 9300 2850 50  0000 C CNN
F 2 "" H 9300 3000 50  0000 C CNN
F 3 "" H 9300 3000 50  0000 C CNN
	1    9300 3000
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X06 P2
U 1 1 56D70DD8
P 9600 2600
F 0 "P2" H 9600 2950 50  0000 C CNN
F 1 "Analog" V 9700 2600 50  0000 C CNN
F 2 "Socket_Arduino_Uno:Socket_Strip_Arduino_1x06" V 9750 2650 20  0000 C CNN
F 3 "" H 9600 2600 50  0000 C CNN
	1    9600 2600
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X08 P4
U 1 1 56D7164F
P 10000 2500
F 0 "P4" H 10000 2950 50  0000 C CNN
F 1 "Digital" V 10100 2500 50  0000 C CNN
F 2 "Socket_Arduino_Uno:Socket_Strip_Arduino_1x08" V 10150 2450 20  0000 C CNN
F 3 "" H 10000 2500 50  0000 C CNN
	1    10000 2500
	-1   0    0    -1  
$EndComp
$Comp
L CONN_01X10 P3
U 1 1 56D721E0
P 10000 1500
F 0 "P3" H 10000 2050 50  0000 C CNN
F 1 "Digital" V 10100 1500 50  0000 C CNN
F 2 "Socket_Arduino_Uno:Socket_Strip_Arduino_1x10" V 10150 1500 20  0000 C CNN
F 3 "" H 10000 1500 50  0000 C CNN
	1    10000 1500
	-1   0    0    -1  
$EndComp
Text Notes 9700 1450 0    60   ~ 0
1
Text Notes 1800 1900 0    60   ~ 0
-5V DC/DC SEPIC SMPS Converter to -1.8V LDO
$Comp
L MAX4239AUT OA1
U 1 1 5B0661BC
P 8550 5350
F 0 "OA1" H 8700 5500 50  0000 L CNN
F 1 "LT6200-10" H 8700 5250 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-23-6" H 8550 5350 50  0001 C CNN
F 3 "http://www.analog.com/media/en/technical-documentation/data-sheets/62001ff.pdf" H 8700 5500 50  0001 C CNN
F 4 "Linear Technology/Analog Devices" H 8550 5350 60  0001 C CNN "Manufacturer"
F 5 "LT6200CS6-10#TRMPBF" H 8550 5350 60  0001 C CNN "Manufacturer Part #"
F 6 "LT6200CS6-10#TRMPBFCT-ND" H 8550 5350 60  0001 C CNN "Digikey Part #"
F 7 "1.6GHz GBWP - 12V Max" H 8550 5350 60  0001 C CNN "NOTE:"
	1    8550 5350
	1    0    0    -1  
$EndComp
$Comp
L C C14
U 1 1 5B06671A
P 8600 5050
F 0 "C14" V 8348 5050 50  0000 C CNN
F 1 "2.2 uF" V 8439 5050 50  0000 C CNN
F 2 "Ben_Custom:0508_Capacitor" H 8638 4900 50  0001 C CNN
F 3 "http://ds.yuden.co.jp/TYCOMPAS/ut/detail.do?productNo=TWK212B7225MD-T&fileName=TWK212B7225MD-T_SS&mode=specSheetDownload" H 8600 5050 50  0001 C CNN
F 4 "Taiyo Yuden" V 8600 5050 60  0001 C CNN "Manufacturer"
F 5 "TWK212B7225MD-T" V 8600 5050 60  0001 C CNN "Manufacturer Part #"
F 6 "587-5165-1-ND" V 8600 5050 60  0001 C CNN "Digikey Part #"
F 7 "Lower GHz impedance than pair of 0402 caps in SPICE" V 8600 5050 60  0001 C CNN "NOTE:"
	1    8600 5050
	0    1    1    0   
$EndComp
$Comp
L GND #PWR05
U 1 1 5B06C060
P 8750 5050
F 0 "#PWR05" H 8750 4800 50  0001 C CNN
F 1 "GND" V 8755 4922 50  0000 R CNN
F 2 "" H 8750 5050 50  0001 C CNN
F 3 "" H 8750 5050 50  0001 C CNN
	1    8750 5050
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR06
U 1 1 5B06C22C
P 8750 5800
F 0 "#PWR06" H 8750 5550 50  0001 C CNN
F 1 "GND" V 8755 5672 50  0000 R CNN
F 2 "" H 8750 5800 50  0001 C CNN
F 3 "" H 8750 5800 50  0001 C CNN
	1    8750 5800
	0    -1   -1   0   
$EndComp
Text GLabel 8450 5050 0    60   Input ~ 0
10V
Text GLabel 8450 5800 0    60   Input ~ 0
-2V
$Comp
L C C16
U 1 1 5B088C2D
P 9200 5700
F 0 "C16" V 8948 5700 50  0000 C CNN
F 1 "2200 pF" V 9039 5700 50  0000 C CNN
F 2 "Capacitors_SMD:C_0603" H 9238 5550 50  0001 C CNN
F 3 "https://psearch.en.murata.com/capacitor/product/GCM188R71H222KA37%23.pdf" H 9200 5700 50  0001 C CNN
F 4 "Murata Electronics North America" V 9200 5700 60  0001 C CNN "Manufacturer"
F 5 "GCM188R71H222KA37D" V 9200 5700 60  0001 C CNN "Manufacturer Part #"
F 6 "490-4931-1-ND" V 9200 5700 60  0001 C CNN "Digikey Part #"
F 7 "50V ±10% " V 9200 5700 60  0001 C CNN "NOTE:"
	1    9200 5700
	-1   0    0    1   
$EndComp
$Comp
L Q_NMOS_GDS Q1
U 1 1 5B089B04
P 9750 5350
F 0 "Q1" H 9955 5396 50  0000 L CNN
F 1 "Q_NMOS_GDS" H 9955 5305 50  0000 L CNN
F 2 "Ben_Custom:IRFH5104_PQFN_5x6b" H 9950 5450 50  0001 C CNN
F 3 "https://www.infineon.com/dgdl/irfh5104pbf.pdf?fileId=5546d462533600a40153561add341ea4" H 9750 5350 50  0001 C CNN
F 4 "Infineon Technologies" H 9750 5350 60  0001 C CNN "Manufacturer"
F 5 "IRFH5104TR2PBF" H 9750 5350 60  0001 C CNN "Manufacturer Part #"
F 6 "IRFH5104TR2PBFCT-ND" H 9750 5350 60  0001 C CNN "Digikey Part #"
F 7 "40V 100A 114W max - can be replaced with IRFH5006TRPBFCT-ND" H 9750 5350 60  0001 C CNN "NOTE:"
	1    9750 5350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR08
U 1 1 5B08A231
P 9850 6300
F 0 "#PWR08" H 9850 6050 50  0001 C CNN
F 1 "GND" H 9900 6150 50  0000 R CNN
F 2 "" H 9850 6300 50  0001 C CNN
F 3 "" H 9850 6300 50  0001 C CNN
	1    9850 6300
	1    0    0    -1  
$EndComp
$Comp
L C C20
U 1 1 5B0E5891
P 10000 4900
F 0 "C20" V 9850 4900 50  0000 C CNN
F 1 "22 uF" V 10150 4900 50  0000 C CNN
F 2 "Ben_Custom:2_J-lead_stacked_cap" H 10038 4750 50  0001 C CNN
F 3 "http://psearch.en.murata.com/capacitor/product/KCM55WR71J226MH01%23.pdf" H 10000 4900 50  0001 C CNN
F 4 "Murata Electronics North America" V 10000 4900 60  0001 C CNN "Manufacturer"
F 5 "KCM55WR71J226MH01K" V 10000 4900 60  0001 C CNN "Manufacturer Part #"
F 6 "490-5839-1-ND" V 10000 4900 60  0001 C CNN "Digikey Part #"
F 7 "63V reverse geometry" V 10000 4900 60  0001 C CNN "NOTE:"
	1    10000 4900
	0    1    1    0   
$EndComp
$Comp
L C C18
U 1 1 5B0E64E4
P 9700 4700
F 0 "C18" V 9448 4700 50  0000 C CNN
F 1 "22 uF" V 9539 4700 50  0000 C CNN
F 2 "Ben_Custom:2_J-lead_stacked_cap" H 9738 4550 50  0001 C CNN
F 3 "http://psearch.en.murata.com/capacitor/product/KCM55WR71J226MH01%23.pdf" H 9700 4700 50  0001 C CNN
F 4 "Murata Electronics North America" V 9700 4700 60  0001 C CNN "Manufacturer"
F 5 "KCM55WR71J226MH01K" V 9700 4700 60  0001 C CNN "Manufacturer Part #"
F 6 "490-5839-1-ND" V 9700 4700 60  0001 C CNN "Digikey Part #"
F 7 "63V reverse geometry" V 9700 4700 60  0001 C CNN "NOTE:"
	1    9700 4700
	0    1    1    0   
$EndComp
$Comp
L GND #PWR09
U 1 1 5B0E67D4
P 10150 4900
F 0 "#PWR09" H 10150 4650 50  0001 C CNN
F 1 "GND" V 10155 4772 50  0000 R CNN
F 2 "" H 10150 4900 50  0001 C CNN
F 3 "" H 10150 4900 50  0001 C CNN
	1    10150 4900
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR010
U 1 1 5B0E682D
P 10150 4500
F 0 "#PWR010" H 10150 4250 50  0001 C CNN
F 1 "GND" V 10155 4372 50  0000 R CNN
F 2 "" H 10150 4500 50  0001 C CNN
F 3 "" H 10150 4500 50  0001 C CNN
	1    10150 4500
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR011
U 1 1 5B0E69AC
P 9550 4700
F 0 "#PWR011" H 9550 4450 50  0001 C CNN
F 1 "GND" V 9450 4700 50  0000 R CNN
F 2 "" H 9550 4700 50  0001 C CNN
F 3 "" H 9550 4700 50  0001 C CNN
	1    9550 4700
	0    1    1    0   
$EndComp
$Comp
L Coupled_Inductor FL1
U 1 1 5B1101AF
P 2200 1100
F 0 "FL1" H 2200 850 50  0000 C CNN
F 1 "4.7uH" H 2200 950 50  0000 C CNN
F 2 "Ben_Custom:Wurth_Coupled_Inductor" H 2200 1140 50  0001 C CNN
F 3 "http://katalog.we-online.de/pbs/datasheet/74489440047.pdf" H 2200 1293 50  0001 C CNN
F 4 "Wurth Electronics Inc." H 2200 1100 60  0001 C CNN "Manufacturer"
F 5 "74489440047" H 2200 1100 60  0001 C CNN "Manufacturer Part #"
F 6 "732-2603-1-ND" H 2200 1100 60  0001 C CNN "Digikey Part #"
F 7 " " H 2200 1100 60  0001 C CNN "NOTE:"
	1    2200 1100
	1    0    0    1   
$EndComp
$Comp
L LT8330 Reg1
U 1 1 5B110DCF
P 2200 1450
F 0 "Reg1" H 2200 1650 60  0000 C CNN
F 1 "LT8330" H 2200 1250 60  0000 C CNN
F 2 "TO_SOT_Packages_SMD:SOT-23-6" H 2200 1700 60  0001 C CNN
F 3 "http://www.analog.com/media/en/technical-documentation/data-sheets/8330fa.pdf?domain=www.linear.com" H 2200 1700 60  0001 C CNN
F 4 "Linear Technology/Analog Devices" H 2200 1450 60  0001 C CNN "Manufacturer"
F 5 "LT8330IS6#TRMPBF" H 2200 1450 60  0001 C CNN "Manufacturer Part #"
F 6 "LT8330IS6#TRMPBFCT-ND" H 2200 1450 60  0001 C CNN "Digikey Part #"
F 7 " " H 2200 1450 60  0001 C CNN "NOTE:"
	1    2200 1450
	-1   0    0    -1  
$EndComp
$Comp
L GND #PWR012
U 1 1 5B11126E
P 2650 1450
F 0 "#PWR012" H 2650 1200 50  0001 C CNN
F 1 "GND" V 2655 1322 50  0000 R CNN
F 2 "" H 2650 1450 50  0001 C CNN
F 3 "" H 2650 1450 50  0001 C CNN
	1    2650 1450
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR013
U 1 1 5B11282A
P 1450 1450
F 0 "#PWR013" H 1450 1200 50  0001 C CNN
F 1 "GND" V 1400 1550 50  0000 R CNN
F 2 "" H 1450 1450 50  0001 C CNN
F 3 "" H 1450 1450 50  0001 C CNN
	1    1450 1450
	0    1    1    0   
$EndComp
$Comp
L C C5
U 1 1 5B113287
P 2650 1050
F 0 "C5" V 2800 1050 50  0000 C CNN
F 1 "1 uF" V 2500 1050 50  0000 C CNN
F 2 "Capacitors_SMD:C_0805" H 2688 900 50  0001 C CNN
F 3 "http://ds.yuden.co.jp/TYCOMPAS/ut/detail.do?productNo=HMK212BC7105KG-TE&fileName=HMK212BC7105KG-TE_SS&mode=specSheetDownload" H 2650 1050 50  0001 C CNN
F 4 "Taiyo Yuden" V 2650 1050 60  0001 C CNN "Manufacturer"
F 5 "HMK212BC7105KG-TE" V 2650 1050 60  0001 C CNN "Manufacturer Part #"
F 6 "587-5018-1-ND" V 2650 1050 60  0001 C CNN "Digikey Part #"
F 7 "Low ESL (same as 0603) - 100V" V 2650 1050 60  0001 C CNN "NOTE:"
	1    2650 1050
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR015
U 1 1 5B113323
P 2000 1000
F 0 "#PWR015" H 2000 750 50  0001 C CNN
F 1 "GND" V 1900 1000 50  0000 R CNN
F 2 "" H 2000 1000 50  0001 C CNN
F 3 "" H 2000 1000 50  0001 C CNN
	1    2000 1000
	0    1    1    0   
$EndComp
$Comp
L D_Schottky D1
U 1 1 5B113867
P 2800 900
F 0 "D1" H 2800 700 50  0000 C CNN
F 1 "D_Schottky" H 2800 800 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-323F" H 2800 900 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/PMEG6010CEH_PMEG6010CEJ.pdf" H 2800 900 50  0001 C CNN
F 4 "Nexperia USA Inc." H 2800 900 60  0001 C CNN "Manufacturer"
F 5 "PMEG6010CEJ,115" H 2800 900 60  0001 C CNN "Manufacturer Part #"
F 6 "1727-3882-1-ND" H 2800 900 60  0001 C CNN "Digikey Part #"
F 7 "Recommended" H 2800 900 60  0001 C CNN "NOTE:"
	1    2800 900 
	-1   0    0    1   
$EndComp
$Comp
L R R5
U 1 1 5B113D39
P 2950 1050
F 0 "R5" V 2743 1050 50  0000 C CNN
F 1 "1Meg" V 2850 1050 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 2880 1050 50  0001 C CNN
F 3 "http://www.yageo.com/documents/recent/PYu-RT_1-to-0.01_RoHS_L_9.pdf" H 2950 1050 50  0001 C CNN
F 4 "Yageo" V 2950 1050 60  0001 C CNN "Manufacturer"
F 5 "RT0805FRE071ML" V 2950 1050 60  0001 C CNN "Manufacturer Part #"
F 6 "YAG3361CT-ND" V 2950 1050 60  0001 C CNN "Digikey Part #"
F 7 "50 ppm/oC  ±1%" V 2950 1050 60  0001 C CNN "NOTE:"
	1    2950 1050
	-1   0    0    1   
$EndComp
$Comp
L R R6
U 1 1 5B113DF9
P 3100 1550
F 0 "R6" V 2893 1550 50  0000 C CNN
F 1 "154k" V 2984 1550 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 3030 1550 50  0001 C CNN
F 3 "https://industrial.panasonic.com/cdbs/www-data/pdf/RDA0000/AOA0000C304.pdf" H 3100 1550 50  0001 C CNN
F 4 "Panasonic Electronic Components" V 3100 1550 60  0001 C CNN "Manufacturer"
F 5 "ERJ-3EKF1543V" V 3100 1550 60  0001 C CNN "Manufacturer Part #"
F 6 "P154KHCT-ND" V 3100 1550 60  0001 C CNN "Digikey Part #"
F 7 "±1% ±100ppm/°C" V 3100 1550 60  0001 C CNN "NOTE:"
	1    3100 1550
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR016
U 1 1 5B11406A
P 3250 1550
F 0 "#PWR016" H 3250 1300 50  0001 C CNN
F 1 "GND" V 3350 1550 50  0000 R CNN
F 2 "" H 3250 1550 50  0001 C CNN
F 3 "" H 3250 1550 50  0001 C CNN
	1    3250 1550
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR017
U 1 1 5B1158D2
P 3800 1200
F 0 "#PWR017" H 3800 950 50  0001 C CNN
F 1 "GND" V 3805 1072 50  0000 R CNN
F 2 "" H 3800 1200 50  0001 C CNN
F 3 "" H 3800 1200 50  0001 C CNN
	1    3800 1200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR018
U 1 1 5B115941
P 4200 1200
F 0 "#PWR018" H 4200 950 50  0001 C CNN
F 1 "GND" V 4205 1072 50  0000 R CNN
F 2 "" H 4200 1200 50  0001 C CNN
F 3 "" H 4200 1200 50  0001 C CNN
	1    4200 1200
	1    0    0    -1  
$EndComp
Text GLabel 6650 900  2    60   Input ~ 0
10V
Text GLabel 650  1200 1    60   Input ~ 0
Vin
Text Notes 1800 600  0    60   ~ 0
12V DC/DC SEPIC SMPS Converter to 10V LDO
$Comp
L C C1
U 1 1 5B1172BE
P 1650 1050
F 0 "C1" V 1800 1050 50  0000 C CNN
F 1 "4.7 uF" V 1500 1050 50  0000 C CNN
F 2 "Capacitors_SMD:C_0805" H 1688 900 50  0001 C CNN
F 3 "https://product.tdk.com/en/search/capacitor/ceramic/mlcc/info?part_no=C2012X5R1H475M125AB" H 1650 1050 50  0001 C CNN
F 4 "TDK Corporation" V 1650 1050 60  0001 C CNN "Manufacturer"
F 5 "C2012X5R1H475M125AB" V 1650 1050 60  0001 C CNN "Manufacturer Part #"
F 6 "445-5981-1-ND" V 1650 1050 60  0001 C CNN "Digikey Part #"
F 7 " 50V max - low ESL" V 1650 1050 60  0001 C CNN "NOTE:"
	1    1650 1050
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR019
U 1 1 5B117386
P 1650 900
F 0 "#PWR019" H 1650 650 50  0001 C CNN
F 1 "GND" H 1655 772 50  0000 R CNN
F 2 "" H 1650 900 50  0001 C CNN
F 3 "" H 1650 900 50  0001 C CNN
	1    1650 900 
	-1   0    0    1   
$EndComp
$Comp
L Coupled_Inductor FL2
U 1 1 5B1179E0
P 2200 2450
F 0 "FL2" H 2200 2200 50  0000 C CNN
F 1 "2.7uH" H 2200 2300 50  0000 C CNN
F 2 "Ben_Custom:Wurth_Coupled_Inductor" H 2200 2490 50  0001 C CNN
F 3 "http://katalog.we-online.de/pbs/datasheet/74489440027.pdf" H 2200 2643 50  0001 C CNN
F 4 "Wurth Electronics Inc." H 2200 2450 60  0001 C CNN "Manufacturer"
F 5 "74489440027" H 2200 2450 60  0001 C CNN "Manufacturer Part #"
F 6 "732-3708-1-ND" H 2200 2450 60  0001 C CNN "Digikey Part #"
F 7 " Comparable to datasheet that is in stock" H 2200 2450 60  0001 C CNN "NOTE:"
	1    2200 2450
	1    0    0    1   
$EndComp
$Comp
L LT8330 Reg2
U 1 1 5B1179EB
P 2200 2800
F 0 "Reg2" H 2200 3000 60  0000 C CNN
F 1 "LT8330" H 2200 2600 60  0000 C CNN
F 2 "TO_SOT_Packages_SMD:SOT-23-6" H 2200 3050 60  0001 C CNN
F 3 "http://www.analog.com/media/en/technical-documentation/data-sheets/8330fa.pdf?domain=www.linear.com" H 2200 3050 60  0001 C CNN
F 4 "Linear Technology/Analog Devices" H 2200 2800 60  0001 C CNN "Manufacturer"
F 5 "LT8330IS6#TRMPBF" H 2200 2800 60  0001 C CNN "Manufacturer Part #"
F 6 "LT8330IS6#TRMPBFCT-ND" H 2200 2800 60  0001 C CNN "Digikey Part #"
F 7 " " H 2200 2800 60  0001 C CNN "NOTE:"
	1    2200 2800
	-1   0    0    -1  
$EndComp
$Comp
L GND #PWR020
U 1 1 5B1179F5
P 2650 2800
F 0 "#PWR020" H 2650 2550 50  0001 C CNN
F 1 "GND" V 2655 2672 50  0000 R CNN
F 2 "" H 2650 2800 50  0001 C CNN
F 3 "" H 2650 2800 50  0001 C CNN
	1    2650 2800
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR021
U 1 1 5B117A06
P 1450 2800
F 0 "#PWR021" H 1450 2550 50  0001 C CNN
F 1 "GND" V 1400 2900 50  0000 R CNN
F 2 "" H 1450 2800 50  0001 C CNN
F 3 "" H 1450 2800 50  0001 C CNN
	1    1450 2800
	0    1    1    0   
$EndComp
$Comp
L D_Schottky D2
U 1 1 5B117A44
P 2800 2250
F 0 "D2" H 2800 2000 50  0000 C CNN
F 1 "D_Schottky" H 2800 2100 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-323F" H 2800 2250 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/PMEG6010CEH_PMEG6010CEJ.pdf" H 2800 2250 50  0001 C CNN
F 4 "Nexperia USA Inc." H 2800 2250 60  0001 C CNN "Manufacturer"
F 5 "PMEG6010CEJ,115" H 2800 2250 60  0001 C CNN "Manufacturer Part #"
F 6 "1727-3882-1-ND" H 2800 2250 60  0001 C CNN "Digikey Part #"
F 7 "Recommended" H 2800 2250 60  0001 C CNN "NOTE:"
	1    2800 2250
	-1   0    0    1   
$EndComp
$Comp
L R R7
U 1 1 5B117A4F
P 3150 2400
F 0 "R7" V 2943 2400 50  0000 C CNN
F 1 "1Meg" V 3050 2400 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 3080 2400 50  0001 C CNN
F 3 "http://www.yageo.com/documents/recent/PYu-RT_1-to-0.01_RoHS_L_9.pdf" H 3150 2400 50  0001 C CNN
F 4 "Yageo" V 3150 2400 60  0001 C CNN "Manufacturer"
F 5 "RT0805FRE071ML" V 3150 2400 60  0001 C CNN "Manufacturer Part #"
F 6 "YAG3361CT-ND" V 3150 2400 60  0001 C CNN "Digikey Part #"
F 7 "50 ppm/oC  ±1%" V 3150 2400 60  0001 C CNN "NOTE:"
	1    3150 2400
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR023
U 1 1 5B117A63
P 3450 2900
F 0 "#PWR023" H 3450 2650 50  0001 C CNN
F 1 "GND" V 3455 2772 50  0000 R CNN
F 2 "" H 3450 2900 50  0001 C CNN
F 3 "" H 3450 2900 50  0001 C CNN
	1    3450 2900
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR024
U 1 1 5B117A8E
P 4000 2550
F 0 "#PWR024" H 4000 2300 50  0001 C CNN
F 1 "GND" V 4005 2422 50  0000 R CNN
F 2 "" H 4000 2550 50  0001 C CNN
F 3 "" H 4000 2550 50  0001 C CNN
	1    4000 2550
	1    0    0    -1  
$EndComp
Text GLabel 6650 2250 2    60   Input ~ 0
-2V
$Comp
L GND #PWR026
U 1 1 5B117AAA
P 1700 2250
F 0 "#PWR026" H 1700 2000 50  0001 C CNN
F 1 "GND" H 1705 2122 50  0000 R CNN
F 2 "" H 1700 2250 50  0001 C CNN
F 3 "" H 1700 2250 50  0001 C CNN
	1    1700 2250
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR027
U 1 1 5B117DDC
P 2950 2250
F 0 "#PWR027" H 2950 2000 50  0001 C CNN
F 1 "GND" V 2850 2300 50  0000 R CNN
F 2 "" H 2950 2250 50  0001 C CNN
F 3 "" H 2950 2250 50  0001 C CNN
	1    2950 2250
	0    -1   -1   0   
$EndComp
Text GLabel 9850 3600 2    60   Input ~ 0
Vin
$Comp
L POT_TRIM RV3
U 1 1 5B11C544
P 9550 6000
F 0 "RV3" V 9750 5950 50  0000 C CNN
F 1 "POT_TRIM" V 9850 5900 50  0000 C CNN
F 2 "Ben_Custom:Potentiometer_Trimmer_Bourns_3224W" H 9550 6000 50  0001 C CNN
F 3 "http://www.bourns.com/docs/Product-Datasheets/3224.pdf" H 9550 6000 50  0001 C CNN
F 4 "Bourns Inc." V 9550 6000 60  0001 C CNN "Manufacturer"
F 5 "3224W-1-102E" V 9550 6000 60  0001 C CNN "Manufacturer Part #"
F 6 "3224W-1-102ECT-ND" V 9550 6000 60  0001 C CNN "Digikey Part #"
F 7 "1k Ohm ±100ppm/°C 12 turns" V 9550 6000 60  0001 C CNN "NOTE:"
	1    9550 6000
	0    -1   -1   0   
$EndComp
$Comp
L POT_TRIM RV2
U 1 1 5B11DA90
P 9550 5500
F 0 "RV2" V 9750 5450 50  0000 C CNN
F 1 "POT_TRIM" V 9850 5400 50  0000 C CNN
F 2 "Ben_Custom:Potentiometer_Trimmer_Bourns_3224W" H 9550 5500 50  0001 C CNN
F 3 "http://www.bourns.com/docs/Product-Datasheets/3224.pdf" H 9550 5500 50  0001 C CNN
F 4 "Bourns Inc." V 9550 5500 60  0001 C CNN "Manufacturer"
F 5 "3224W-1-201E" V 9550 5500 60  0001 C CNN "Manufacturer Part #"
F 6 "3224W-1-201ECT-ND" V 9550 5500 60  0001 C CNN "Digikey Part #"
F 7 "200 Ohm  ±100ppm/°C 12 turns" V 9550 5500 60  0001 C CNN "NOTE:"
	1    9550 5500
	0    -1   -1   0   
$EndComp
$Comp
L POT_TRIM RV1
U 1 1 5B121F44
P 7450 5250
F 0 "RV1" V 7350 5250 50  0000 C CNN
F 1 "POT_TRIM" V 7550 5250 50  0000 C CNN
F 2 "Ben_Custom:Bourns_3313J_Trimpot-compact" H 7450 5250 50  0001 C CNN
F 3 "http://www.bourns.com/docs/Product-Datasheets/3313.pdf" H 7450 5250 50  0001 C CNN
F 4 "Bourns Inc." V 7450 5250 60  0001 C CNN "Manufacturer"
F 5 "3313J-1-502E" V 7450 5250 60  0001 C CNN "Manufacturer Part #"
F 6 "3313J-502ECT-ND" V 7450 5250 60  0001 C CNN "Digikey Part #"
F 7 "5k Ohm" V 7450 5250 60  0001 C CNN "NOTE:"
	1    7450 5250
	1    0    0    1   
$EndComp
$Comp
L GND #PWR030
U 1 1 5B1224A4
P 7450 5400
F 0 "#PWR030" H 7450 5150 50  0001 C CNN
F 1 "GND" V 7455 5272 50  0000 R CNN
F 2 "" H 7450 5400 50  0001 C CNN
F 3 "" H 7450 5400 50  0001 C CNN
	1    7450 5400
	0    1    1    0   
$EndComp
$Comp
L TEST_1P J6
U 1 1 5B125DF5
P 10100 6150
F 0 "J6" V 10150 6750 50  0000 L CNN
F 1 "Heat_Sink" V 10145 6337 50  0000 L CNN
F 2 "Ben_Custom:40x40mm-heatsink_only-eighth-pad" H 10300 6150 50  0001 C CNN
F 3 "https://media.digikey.com/pdf/Data%20Sheets/Wakefield%20Thermal%20PDFs/910_Series_Pin.pdf" H 10300 6150 50  0001 C CNN
F 4 "Wakefield-Vette" V 10100 6150 60  0001 C CNN "Manufacturer"
F 5 "910-40-2-23-2-B-0" V 10100 6150 60  0001 C CNN "Manufacturer Part #"
F 6 "345-1161-ND" V 10100 6150 60  0001 C CNN "Digikey Part #"
F 7 "2.00°C/W @ 200 LFM" V 10100 6150 60  0001 C CNN "NOTE:"
	1    10100 6150
	0    1    1    0   
$EndComp
$Comp
L TEST_1P J4
U 1 1 5B126B39
P 9450 5250
F 0 "J4" V 9650 5450 50  0000 C CNN
F 1 "TEST_1P" V 9550 5400 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 9650 5250 50  0001 C CNN
F 3 "" H 9650 5250 50  0001 C CNN
	1    9450 5250
	0    -1   -1   0   
$EndComp
$Comp
L TEST_1P J2
U 1 1 5B126DDE
P 9050 5250
F 0 "J2" V 8900 5250 50  0000 C CNN
F 1 "TEST_1P" V 9000 5200 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 9250 5250 50  0001 C CNN
F 3 "" H 9250 5250 50  0001 C CNN
	1    9050 5250
	0    1    1    0   
$EndComp
$Comp
L TEST_1P J3
U 1 1 5B127230
P 9350 6300
F 0 "J3" V 9400 6350 50  0000 C CNN
F 1 "TEST_1P" V 9300 6150 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 9550 6300 50  0001 C CNN
F 3 "" H 9550 6300 50  0001 C CNN
	1    9350 6300
	0    1    1    0   
$EndComp
$Comp
L R-current R9
U 1 1 5B12E302
P 9850 6150
F 0 "R9" H 9920 6196 50  0000 L CNN
F 1 "5" H 9920 6105 50  0000 L CNN
F 2 "Ben_Custom:Bourns_DPAK" V 9780 6150 50  0001 C CNN
F 3 "https://www.bourns.com/docs/Product-Datasheets/PWR163.pdf" H 9850 6150 50  0001 C CNN
F 4 "Bourns Inc." H 9850 6150 60  0001 C CNN "Manufacturer"
F 5 "PWR163S-25-5R00F" H 9850 6150 60  0001 C CNN "Manufacturer Part #"
F 6 "PWR163S-25-5R00F-ND" H 9850 6150 60  0001 C CNN "Digikey Part #"
F 7 "25W  ±100ppm/°C ±1%" H 9850 6150 60  0001 C CNN "NOTE:"
	1    9850 6150
	-1   0    0    1   
$EndComp
Text GLabel 4950 3800 0    60   Input ~ 0
Vin
$Comp
L GND #PWR032
U 1 1 5B15EA79
P 5550 3700
F 0 "#PWR032" H 5550 3450 50  0001 C CNN
F 1 "GND" H 5500 3600 50  0000 R CNN
F 2 "" H 5550 3700 50  0001 C CNN
F 3 "" H 5550 3700 50  0001 C CNN
	1    5550 3700
	-1   0    0    1   
$EndComp
$Comp
L D D4
U 1 1 5B161720
P 5400 3800
F 0 "D4" H 5400 3700 50  0000 C CNN
F 1 "D" H 5400 3600 50  0000 C CNN
F 2 "Ben_Custom:Powerdi5060-8" H 5400 3800 50  0001 C CNN
F 3 "https://www.diodes.com/assets/Datasheets/SBRT20U50SLP.pdf" H 5400 3800 50  0001 C CNN
F 4 "Diodes Incorporated" H 5400 3800 60  0001 C CNN "Manufacturer"
F 5 "SBRT20U50SLP-13" H 5400 3800 60  0001 C CNN "Manufacturer Part #"
F 6 "SBRT20U50SLP-13DICT-ND" H 5400 3800 60  0001 C CNN "Digikey Part #"
F 7 "500mV at 20A - 50V reverse" H 5400 3800 60  0001 C CNN "NOTE:"
	1    5400 3800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR029
U 1 1 5B11AE70
P 9550 4250
F 0 "#PWR029" H 9550 4000 50  0001 C CNN
F 1 "GND" V 9450 4250 50  0000 R CNN
F 2 "" H 9550 4250 50  0001 C CNN
F 3 "" H 9550 4250 50  0001 C CNN
	1    9550 4250
	0    1    1    0   
$EndComp
$Comp
L CP1 C17
U 1 1 5B11E8F4
P 9700 4250
F 0 "C17" V 9952 4250 50  0000 C CNN
F 1 "2700 uF" V 9861 4250 50  0000 C CNN
F 2 "Capacitors_THT:CP_Radial_D18.0mm_P7.50mm" H 9700 4250 50  0001 C CNN
F 3 "http://www.chemi-con.co.jp/cgi-bin/CAT_DB/SEARCH/cat_db_al.cgi?e=e&j=p&pdfname=ky" H 9700 4250 50  0001 C CNN
F 4 "United Chemi-Con" V 9700 4250 60  0001 C CNN "Manufacturer"
F 5 "EKY-500ELL272MM40S" V 9700 4250 60  0001 C CNN "Manufacturer Part #"
F 6 "565-1624-ND" V 9700 4250 60  0001 C CNN "Digikey Part #"
F 7 "50V - 3.8A" V 9700 4250 60  0001 C CNN "NOTE:"
	1    9700 4250
	0    1    -1   0   
$EndComp
$Comp
L CP1 C22
U 1 1 5B1716FF
P 10000 4500
F 0 "C22" V 10150 4500 50  0000 C CNN
F 1 "2700 uF" V 9850 4450 50  0000 C CNN
F 2 "Capacitors_THT:CP_Radial_D18.0mm_P7.50mm" H 10000 4500 50  0001 C CNN
F 3 "http://www.chemi-con.co.jp/cgi-bin/CAT_DB/SEARCH/cat_db_al.cgi?e=e&j=p&pdfname=ky" H 10000 4500 50  0001 C CNN
F 4 "United Chemi-Con" V 10000 4500 60  0001 C CNN "Manufacturer"
F 5 "EKY-500ELL272MM40S" V 10000 4500 60  0001 C CNN "Manufacturer Part #"
F 6 "565-1624-ND" V 10000 4500 60  0001 C CNN "Digikey Part #"
F 7 "50V - 3.8A" V 10000 4500 60  0001 C CNN "NOTE:"
	1    10000 4500
	0    -1   -1   0   
$EndComp
$Comp
L CP1 C21
U 1 1 5B17197C
P 10000 4100
F 0 "C21" V 9850 4100 50  0000 C CNN
F 1 "2700 uF" V 10150 4050 50  0000 C CNN
F 2 "Capacitors_THT:CP_Radial_D18.0mm_P7.50mm" H 10000 4100 50  0001 C CNN
F 3 "http://www.chemi-con.co.jp/cgi-bin/CAT_DB/SEARCH/cat_db_al.cgi?e=e&j=p&pdfname=ky" H 10000 4100 50  0001 C CNN
F 4 "United Chemi-Con" V 10000 4100 60  0001 C CNN "Manufacturer"
F 5 "EKY-500ELL272MM40S" V 10000 4100 60  0001 C CNN "Manufacturer Part #"
F 6 "565-1624-ND" V 10000 4100 60  0001 C CNN "Digikey Part #"
F 7 "50V - 3.8A" V 10000 4100 60  0001 C CNN "NOTE:"
	1    10000 4100
	0    -1   1    0   
$EndComp
$Comp
L CP1 C19
U 1 1 5B171A10
P 9700 3850
F 0 "C19" V 9952 3850 50  0000 C CNN
F 1 "2700 uF" V 9861 3850 50  0000 C CNN
F 2 "Capacitors_THT:CP_Radial_D18.0mm_P7.50mm" H 9700 3850 50  0001 C CNN
F 3 "http://www.chemi-con.co.jp/cgi-bin/CAT_DB/SEARCH/cat_db_al.cgi?e=e&j=p&pdfname=ky" H 9700 3850 50  0001 C CNN
F 4 "United Chemi-Con" V 9700 3850 60  0001 C CNN "Manufacturer"
F 5 "EKY-500ELL272MM40S" V 9700 3850 60  0001 C CNN "Manufacturer Part #"
F 6 "565-1624-ND" V 9700 3850 60  0001 C CNN "Digikey Part #"
F 7 "50V - 3.8A" V 9700 3850 60  0001 C CNN "NOTE:"
	1    9700 3850
	0    1    -1   0   
$EndComp
$Comp
L GND #PWR033
U 1 1 5B171C7D
P 9550 3850
F 0 "#PWR033" H 9550 3600 50  0001 C CNN
F 1 "GND" V 9450 3850 50  0000 R CNN
F 2 "" H 9550 3850 50  0001 C CNN
F 3 "" H 9550 3850 50  0001 C CNN
	1    9550 3850
	0    1    1    0   
$EndComp
$Comp
L GND #PWR034
U 1 1 5B171CF8
P 10150 4100
F 0 "#PWR034" H 10150 3850 50  0001 C CNN
F 1 "GND" V 10050 4100 50  0000 R CNN
F 2 "" H 10150 4100 50  0001 C CNN
F 3 "" H 10150 4100 50  0001 C CNN
	1    10150 4100
	0    -1   -1   0   
$EndComp
$Comp
L TEST_1P J8
U 1 1 5B1728BF
P 5550 3700
F 0 "J8" V 5504 3888 50  0000 L CNN
F 1 "TEST_1P" V 5250 3700 50  0000 L CNN
F 2 "Wire_Pads:SolderWirePad_single_2mmDrill" H 5750 3700 50  0001 C CNN
F 3 "" H 5750 3700 50  0001 C CNN
	1    5550 3700
	0    1    1    0   
$EndComp
$Comp
L TEST_1P J9
U 1 1 5B172A71
P 5550 3800
F 0 "J9" V 5504 3988 50  0000 L CNN
F 1 "TEST_1P" V 5650 3800 50  0000 L CNN
F 2 "Ben_Custom:SolderWirePad_single_2mmDrill-square" H 5750 3800 50  0001 C CNN
F 3 "" H 5750 3800 50  0001 C CNN
	1    5550 3800
	0    1    1    0   
$EndComp
$Comp
L TEST_1P J10
U 1 1 5B1733F3
P 9850 4950
F 0 "J10" V 9850 5150 50  0000 L CNN
F 1 "TEST_1P" V 9950 4950 50  0000 L CNN
F 2 "Ben_Custom:SolderWirePad_single_2mmDrill-square" H 10050 4950 50  0001 C CNN
F 3 "https://media.digikey.com/pdf/Data%20Sheets/Phoenix%20Contact%20PDFs/0708250.pdf" H 10050 4950 50  0001 C CNN
F 4 "Phoenix Contact" V 9850 4950 60  0001 C CNN "Manufacturer"
F 5 "0708250" V 9850 4950 60  0001 C CNN "Manufacturer Part #"
F 6 "277-5906-ND" V 9850 4950 60  0001 C CNN "Digikey Part #"
F 7 "32A  12-24 AWG" V 9850 4950 60  0001 C CNN "NOTE:"
	1    9850 4950
	0    -1   -1   0   
$EndComp
$Comp
L TEST_1P J11
U 1 1 5B173A33
P 9850 5050
F 0 "J11" V 9804 5238 50  0000 L CNN
F 1 "TEST_1P" V 9900 5250 50  0000 L CNN
F 2 "Wire_Pads:SolderWirePad_single_2mmDrill" H 10050 5050 50  0001 C CNN
F 3 "" H 10050 5050 50  0001 C CNN
	1    9850 5050
	0    -1   -1   0   
$EndComp
$Comp
L Ferrite_Bead L4
U 1 1 5B1A2CE2
P 4700 900
F 0 "L4" V 4850 850 50  0000 C CNN
F 1 "Ferrite_Bead" V 4500 950 50  0000 C CNN
F 2 "Inductors_SMD:L_0603" V 4630 900 50  0001 C CNN
F 3 "http://katalog.we-online.de/pbs/datasheet/742863147.pdf" H 4700 900 50  0001 C CNN
F 4 "Wurth Electronics Inc." V 4700 900 60  0001 C CNN "Manufacturer"
F 5 "742863147" V 4700 900 60  0001 C CNN "Manufacturer Part #"
F 6 "732-2380-1-ND" V 4700 900 60  0001 C CNN "Digikey Part #"
F 7 "320 mOhm - 500mA max" V 4700 900 60  0001 C CNN "NOTE:"
	1    4700 900 
	0    1    1    0   
$EndComp
Text GLabel 650  2550 1    60   Input ~ 0
Vin
$Comp
L C C6
U 1 1 5B1A9CA4
P 2650 2400
F 0 "C6" V 2800 2400 50  0000 C CNN
F 1 "1 uF" V 2500 2400 50  0000 C CNN
F 2 "Capacitors_SMD:C_0805" H 2688 2250 50  0001 C CNN
F 3 "http://ds.yuden.co.jp/TYCOMPAS/ut/detail.do?productNo=HMK212BC7105KG-TE&fileName=HMK212BC7105KG-TE_SS&mode=specSheetDownload" H 2650 2400 50  0001 C CNN
F 4 "Taiyo Yuden" V 2650 2400 60  0001 C CNN "Manufacturer"
F 5 "HMK212BC7105KG-TE" V 2650 2400 60  0001 C CNN "Manufacturer Part #"
F 6 "587-5018-1-ND" V 2650 2400 60  0001 C CNN "Digikey Part #"
F 7 "Low ESL (same as 0603)  - 100V to absorb inductor flyback" V 2650 2400 60  0001 C CNN "NOTE:"
	1    2650 2400
	-1   0    0    1   
$EndComp
$Comp
L Ferrite_Bead L1
U 1 1 5B1AA0AB
P 800 1200
F 0 "L1" V 650 1200 50  0000 C CNN
F 1 "Ferrite_Bead" V 950 1300 50  0000 C CNN
F 2 "Inductors_SMD:L_0805" V 730 1200 50  0001 C CNN
F 3 "http://katalog.we-online.de/pbs/datasheet/742792097.pdf" H 800 1200 50  0001 C CNN
F 4 "Wurth Electronics Inc." V 800 1200 60  0001 C CNN "Manufacturer"
F 5 "742792097" V 800 1200 60  0001 C CNN "Manufacturer Part #"
F 6 "732-4649-1-ND" V 800 1200 60  0001 C CNN "Digikey Part #"
F 7 "300 mOhm - 1A max" V 800 1200 60  0001 C CNN "NOTE:"
	1    800  1200
	0    1    1    0   
$EndComp
$Comp
L Ferrite_Bead L3
U 1 1 5B1AA297
P 4650 2250
F 0 "L3" V 4500 2250 50  0000 C CNN
F 1 "Ferrite_Bead" V 4400 2250 50  0000 C CNN
F 2 "Inductors_SMD:L_0603" V 4580 2250 50  0001 C CNN
F 3 "http://katalog.we-online.de/pbs/datasheet/742863147.pdf" H 4650 2250 50  0001 C CNN
F 4 "Wurth Electronics Inc." V 4650 2250 60  0001 C CNN "Manufacturer"
F 5 "742863147" V 4650 2250 60  0001 C CNN "Manufacturer Part #"
F 6 "732-2380-1-ND" V 4650 2250 60  0001 C CNN "Digikey Part #"
F 7 "320 mOhm - 500mA max" V 4650 2250 60  0001 C CNN "NOTE:"
	1    4650 2250
	0    1    1    0   
$EndComp
$Comp
L C C8
U 1 1 5B117A6D
P 3600 2400
F 0 "C8" V 3750 2400 50  0000 C CNN
F 1 "4.7 pF" V 3450 2400 50  0000 C CNN
F 2 "Capacitors_SMD:C_0603" H 3638 2250 50  0001 C CNN
F 3 "https://product.tdk.com/info/en/documents/chara_sheet/C1608NP01H4R7C080AA.pdf" H 3600 2400 50  0001 C CNN
F 4 "TDK Corporation" V 3600 2400 60  0001 C CNN "Manufacturer"
F 5 "C1608NP01H4R7C080AA" V 3600 2400 60  0001 C CNN "Manufacturer Part #"
F 6 "445-14084-1-ND" V 3600 2400 60  0001 C CNN "Digikey Part #"
F 7 " 0.3Ohm ESR - 80pH ESL" V 3600 2400 60  0001 C CNN "NOTE:"
	1    3600 2400
	-1   0    0    1   
$EndComp
$Comp
L C C7
U 1 1 5B1AACBC
P 3400 1050
F 0 "C7" V 3550 1050 50  0000 C CNN
F 1 "4.7 pF" V 3250 1050 50  0000 C CNN
F 2 "Capacitors_SMD:C_0603" H 3438 900 50  0001 C CNN
F 3 "https://product.tdk.com/info/en/documents/chara_sheet/C1608NP01H4R7C080AA.pdf" H 3400 1050 50  0001 C CNN
F 4 "TDK Corporation" V 3400 1050 60  0001 C CNN "Manufacturer"
F 5 "C1608NP01H4R7C080AA" V 3400 1050 60  0001 C CNN "Manufacturer Part #"
F 6 "445-14084-1-ND" V 3400 1050 60  0001 C CNN "Digikey Part #"
F 7 " 0.3Ohm ESR - 80pH ESL" V 3400 1050 60  0001 C CNN "NOTE:"
	1    3400 1050
	-1   0    0    1   
$EndComp
$Comp
L TEST_1P J12
U 1 1 5B23A059
P 5250 3800
F 0 "J12" V 5100 4100 50  0000 L CNN
F 1 "Heat_Sink" V 5200 4000 50  0000 L CNN
F 2 "Ben_Custom:Heatsink-10x10mm-V2017B" H 5450 3800 50  0001 C CNN
F 3 "http://www.assmann-wsw.com/fileadmin/datasheets/ASS_0875_HS.pdf" H 5450 3800 50  0001 C CNN
F 4 "Assmann WSW Components" V 5250 3800 60  0001 C CNN "Manufacturer"
F 5 "V2017B" V 5250 3800 60  0001 C CNN "Manufacturer Part #"
F 6 "AE10837-ND" V 5250 3800 60  0001 C CNN "Digikey Part #"
F 7 "31.00°C/W @ Natural" V 5250 3800 60  0001 C CNN "NOTE:"
	1    5250 3800
	-1   0    0    1   
$EndComp
$Comp
L TEST_1P J13
U 1 1 5B23862C
P 10100 6300
F 0 "J13" V 10100 6900 50  0000 L CNN
F 1 "Heat_Sink" V 10100 6500 50  0000 L CNN
F 2 "Ben_Custom:Heatsink-Wakefield_655-53AB_41x41mm" H 10300 6300 50  0001 C CNN
F 3 "http://www.wakefield-vette.com/Portals/0/resources/datasheets/655.pdf" H 10300 6300 50  0001 C CNN
F 4 "Wakefield-Vette" V 10100 6300 60  0001 C CNN "Manufacturer"
F 5 "655-53AB" V 10100 6300 60  0001 C CNN "Manufacturer Part #"
F 6 "345-1093-ND" V 10100 6300 60  0001 C CNN "Digikey Part #"
F 7 "2.00°C/W @ 400 LFM" V 10100 6300 60  0001 C CNN "NOTE:"
	1    10100 6300
	0    1    1    0   
$EndComp
Text GLabel 10300 3000 0    60   Input ~ 0
GND(NC)
Text Notes 8800 3450 0    60   ~ 0
Op-amp LED driver
$Comp
L GND #PWR04
U 1 1 5B2A3F6E
P 5450 1200
F 0 "#PWR04" H 5450 950 50  0001 C CNN
F 1 "GND" V 5455 1072 50  0000 R CNN
F 2 "" H 5450 1200 50  0001 C CNN
F 3 "" H 5450 1200 50  0001 C CNN
	1    5450 1200
	1    0    0    -1  
$EndComp
$Comp
L ADP7182AUJZ-Fixed Reg3
U 1 1 5B2A6284
P 6000 2350
F 0 "Reg3" H 5800 2650 50  0000 C CNN
F 1 "ADP7182AUJZ-Fixed" H 6000 2074 50  0000 C CNN
F 2 "TO_SOT_Packages_SMD:TSOT-23-5" H 6000 1950 50  0001 C CIN
F 3 "http://www.analog.com/media/en/technical-documentation/data-sheets/ADP7182.pdf" H 6000 1850 50  0001 C CNN
F 4 "Analog Devices Inc." H 6000 2350 60  0001 C CNN "Manufacturer"
F 5 "ADP7182AUJZ-1.8-R7" H 6000 2350 60  0001 C CNN "Manufacturer Part #"
F 6 "ADP7182AUJZ-1.8-R7CT-ND" H 6000 2350 60  0001 C CNN "Digikey Part #"
F 7 "Dropout max: 90mV at 50mA, 360mV at 200mA" H 6000 2350 60  0001 C CNN "NOTE:"
	1    6000 2350
	1    0    0    1   
$EndComp
$Comp
L GND #PWR035
U 1 1 5B2A70E4
P 5400 2550
F 0 "#PWR035" H 5400 2300 50  0001 C CNN
F 1 "GND" V 5405 2422 50  0000 R CNN
F 2 "" H 5400 2550 50  0001 C CNN
F 3 "" H 5400 2550 50  0001 C CNN
	1    5400 2550
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR036
U 1 1 5B2A717D
P 6000 2650
F 0 "#PWR036" H 6000 2400 50  0001 C CNN
F 1 "GND" V 6005 2522 50  0000 R CNN
F 2 "" H 6000 2650 50  0001 C CNN
F 3 "" H 6000 2650 50  0001 C CNN
	1    6000 2650
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 5B2A7A17
P 3300 2900
F 0 "R1" V 3093 2900 50  0000 C CNN
F 1 "187k" V 3184 2900 50  0000 C CNN
F 2 "Capacitors_SMD:C_0805" V 3230 2900 50  0001 C CNN
F 3 "http://www.susumu.co.jp/common/pdf/n_catalog_partition05_en.pdf" H 3300 2900 50  0001 C CNN
F 4 "Susumu" V 3300 2900 60  0001 C CNN "Manufacturer"
F 5 "RR1220P-1873-D-M" V 3300 2900 60  0001 C CNN "Manufacturer Part #"
F 6 "RR12P187KDCT-ND" V 3300 2900 60  0001 C CNN "Digikey Part #"
F 7 "25 ppm/oC ±0.5%" V 3300 2900 60  0001 C CNN "NOTE:"
	1    3300 2900
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR038
U 1 1 5B2AD1E0
P 6000 1300
F 0 "#PWR038" H 6000 1050 50  0001 C CNN
F 1 "GND" V 6005 1172 50  0000 R CNN
F 2 "" H 6000 1300 50  0001 C CNN
F 3 "" H 6000 1300 50  0001 C CNN
	1    6000 1300
	1    0    0    -1  
$EndComp
$Comp
L D_Schottky D5
U 1 1 5B2B6FB2
P 1150 1200
F 0 "D5" H 1150 1000 50  0000 C CNN
F 1 "D_Schottky" H 1150 1100 50  0000 C CNN
F 2 "Ben_Custom:DO-214AC" H 1150 1200 50  0001 C CNN
F 3 "http://www.comchiptech.com/cms/UserFiles/CDBA120SL-HF%20Thru295959.%20CDBA140SL-HF%20RevA.pdf" H 1150 1200 50  0001 C CNN
F 4 "Comchip Technology" H 1150 1200 60  0001 C CNN "Manufacturer"
F 5 "CDBA140SL-HF" H 1150 1200 60  0001 C CNN "Manufacturer Part #"
F 6 "641-1762-1-ND" H 1150 1200 60  0001 C CNN "Digikey Part #"
F 7 "330mV @ 1A" H 1150 1200 60  0001 C CNN "NOTE:"
	1    1150 1200
	-1   0    0    1   
$EndComp
$Comp
L D_Schottky D6
U 1 1 5B2B960B
P 1150 2550
F 0 "D6" H 1150 2350 50  0000 C CNN
F 1 "D_Schottky" H 1150 2450 50  0000 C CNN
F 2 "Ben_Custom:DO-214AC" H 1150 2550 50  0001 C CNN
F 3 "http://www.comchiptech.com/cms/UserFiles/CDBA120SL-HF%20Thru295959.%20CDBA140SL-HF%20RevA.pdf" H 1150 2550 50  0001 C CNN
F 4 "Comchip Technology" H 1150 2550 60  0001 C CNN "Manufacturer"
F 5 "CDBA140SL-HF" H 1150 2550 60  0001 C CNN "Manufacturer Part #"
F 6 "641-1762-1-ND" H 1150 2550 60  0001 C CNN "Digikey Part #"
F 7 "330mV @ 1A" H 1150 2550 60  0001 C CNN "NOTE:"
	1    1150 2550
	-1   0    0    1   
$EndComp
$Comp
L Ferrite_Bead L2
U 1 1 5B2BAB76
P 800 2550
F 0 "L2" V 650 2550 50  0000 C CNN
F 1 "Ferrite_Bead" V 950 2650 50  0000 C CNN
F 2 "Inductors_SMD:L_0805" V 730 2550 50  0001 C CNN
F 3 "http://katalog.we-online.de/pbs/datasheet/742792097.pdf" H 800 2550 50  0001 C CNN
F 4 "Wurth Electronics Inc." V 800 2550 60  0001 C CNN "Manufacturer"
F 5 "742792097" V 800 2550 60  0001 C CNN "Manufacturer Part #"
F 6 "732-4649-1-ND" V 800 2550 60  0001 C CNN "Digikey Part #"
F 7 "300 mOhm - 1A max" V 800 2550 60  0001 C CNN "NOTE:"
	1    800  2550
	0    1    1    0   
$EndComp
Text Label 3550 900  0    60   ~ 0
12V-SMPS
Text Label 3400 2250 0    60   ~ 0
-5V-SMPS
$Comp
L GND #PWR028
U 1 1 5B119B31
P 6400 1300
F 0 "#PWR028" H 6400 1050 50  0001 C CNN
F 1 "GND" V 6405 1172 50  0000 R CNN
F 2 "" H 6400 1300 50  0001 C CNN
F 3 "" H 6400 1300 50  0001 C CNN
	1    6400 1300
	1    0    0    -1  
$EndComp
$Comp
L C C28
U 1 1 5B2AF2A3
P 6400 1150
F 0 "C28" V 6550 1150 50  0000 C CNN
F 1 "10 nF" V 6650 1150 50  0000 C CNN
F 2 "Capacitors_SMD:C_0805" H 6438 1000 50  0001 C CNN
F 3 "http://www.samsungsem.com/kr/support/product-search/mlcc/__icsFiles/afieldfile/2016/09/21/Data%20sheet_CL21B103KDCNNNC.pdf" H 6400 1150 50  0001 C CNN
F 4 "Samsung Electro-Mechanics" V 6400 1150 60  0001 C CNN "Manufacturer"
F 5 "CL21B103KDCNNNC" V 6400 1150 60  0001 C CNN "Manufacturer Part #"
F 6 "1276-1170-1-ND" V 6400 1150 60  0001 C CNN "Digikey Part #"
F 7 "250V - 50MOhm resistance" V 6400 1150 60  0001 C CNN "NOTE:"
	1    6400 1150
	1    0    0    -1  
$EndComp
Text Label 5250 1600 0    60   ~ 0
Vin(Arduino)
$Comp
L R R2
U 1 1 5B2E06F1
P 5150 3700
F 0 "R2" V 4943 3700 50  0000 C CNN
F 1 "4.7k" V 5034 3700 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 5080 3700 50  0001 C CNN
F 3 "http://www.rohm.com/web/global/datasheet/ESR01MZPF/esr-e" H 5150 3700 50  0001 C CNN
F 4 "Rohm Semiconductor" V 5150 3700 60  0001 C CNN "Manufacturer"
F 5 "ESR10EZPJ472" V 5150 3700 60  0001 C CNN "Manufacturer Part #"
F 6 "RHM4.7KKCT-ND" V 5150 3700 60  0001 C CNN "Digikey Part #"
F 7 "0.4W - 200 ppm/oC - thick film" V 5150 3700 60  0001 C CNN "NOTE:"
	1    5150 3700
	0    1    1    0   
$EndComp
$Comp
L C C15
U 1 1 5B2ED4BE
P 8600 5800
F 0 "C15" V 8350 5850 50  0000 C CNN
F 1 "2.2 uF" V 8450 5900 50  0000 C CNN
F 2 "Ben_Custom:0508_Capacitor" H 8638 5650 50  0001 C CNN
F 3 "http://ds.yuden.co.jp/TYCOMPAS/ut/detail.do?productNo=TWK212B7225MD-T&fileName=TWK212B7225MD-T_SS&mode=specSheetDownload" H 8600 5800 50  0001 C CNN
F 4 "Taiyo Yuden" V 8600 5800 60  0001 C CNN "Manufacturer"
F 5 "TWK212B7225MD-T" V 8600 5800 60  0001 C CNN "Manufacturer Part #"
F 6 "587-5165-1-ND" V 8600 5800 60  0001 C CNN "Digikey Part #"
F 7 "Lower GHz impedance than pair of 0402 caps in SPICE" V 8600 5800 60  0001 C CNN "NOTE:"
	1    8600 5800
	0    1    1    0   
$EndComp
$Comp
L GND #PWR022
U 1 1 5B2F2306
P 4800 1600
F 0 "#PWR022" H 4800 1350 50  0001 C CNN
F 1 "GND" V 4805 1472 50  0000 R CNN
F 2 "" H 4800 1600 50  0001 C CNN
F 3 "" H 4800 1600 50  0001 C CNN
	1    4800 1600
	0    1    1    0   
$EndComp
$Comp
L D_Schottky D8
U 1 1 5B2F4378
P 5300 900
F 0 "D8" H 5300 700 50  0000 C CNN
F 1 "D_Schottky" H 5150 800 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-123F" H 5300 900 50  0001 C CNN
F 3 "https://www.fairchildsemi.com/datasheets/SS/SS13FL.pdf" H 5300 900 50  0001 C CNN
F 4 "ON Semiconductor" H 5300 900 60  0001 C CNN "Manufacturer"
F 5 "SS13FL" H 5300 900 60  0001 C CNN "Manufacturer Part #"
F 6 "SS13FLCT-ND" H 5300 900 60  0001 C CNN "Digikey Part #"
F 7 "6ns recovery for 100+ MHz filtering" H 5300 900 60  0001 C CNN "NOTE:"
	1    5300 900 
	-1   0    0    1   
$EndComp
$Comp
L LP2985-10.0 Reg4
U 1 1 5B2ACBCF
P 6000 1000
F 0 "Reg4" H 6000 1342 50  0000 C CNN
F 1 "LP2985-10.0" H 6000 1251 50  0000 C CNN
F 2 "TO_SOT_Packages_SMD:SOT-23-5" H 6000 1325 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lp2985.pdf" H 6000 1000 50  0001 C CNN
F 4 "Texas Instruments" H 6000 1000 60  0001 C CNN "Manufacturer"
F 5 "LP2985-10DBVR" H 6000 1000 60  0001 C CNN "Manufacturer Part #"
F 6 "296-24263-1-ND" H 6000 1000 60  0001 C CNN "Digikey Part #"
F 7 "10V fixed - 150mA max - PSRR 45dB (1kHz)" H 6000 1000 60  0001 C CNN "NOTE:"
	1    6000 1000
	1    0    0    -1  
$EndComp
$Comp
L D_Schottky D9
U 1 1 5B2E270A
P 5100 1250
F 0 "D9" H 5100 1350 50  0000 C CNN
F 1 "D_Schottky" H 5150 1150 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-123F" H 5100 1250 50  0001 C CNN
F 3 "https://www.fairchildsemi.com/datasheets/SS/SS13FL.pdf" H 5100 1250 50  0001 C CNN
F 4 "ON Semiconductor" H 5100 1250 60  0001 C CNN "Manufacturer"
F 5 "SS13FL" H 5100 1250 60  0001 C CNN "Manufacturer Part #"
F 6 "SS13FLCT-ND" H 5100 1250 60  0001 C CNN "Digikey Part #"
F 7 "6ns recovery for 100+ MHz filtering" H 5100 1250 60  0001 C CNN "NOTE:"
	1    5100 1250
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR025
U 1 1 5B2E4257
P 4850 1200
F 0 "#PWR025" H 4850 950 50  0001 C CNN
F 1 "GND" H 4900 1050 50  0000 R CNN
F 2 "" H 4850 1200 50  0001 C CNN
F 3 "" H 4850 1200 50  0001 C CNN
	1    4850 1200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR040
U 1 1 5B2E4804
P 4800 2550
F 0 "#PWR040" H 4800 2300 50  0001 C CNN
F 1 "GND" H 5000 2500 50  0000 R CNN
F 2 "" H 4800 2550 50  0001 C CNN
F 3 "" H 4800 2550 50  0001 C CNN
	1    4800 2550
	1    0    0    -1  
$EndComp
$Comp
L D_Schottky D10
U 1 1 5B2E58E2
P 4400 900
F 0 "D10" H 4400 700 50  0000 C CNN
F 1 "D_Schottky" H 4350 800 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-123F" H 4400 900 50  0001 C CNN
F 3 "https://www.fairchildsemi.com/datasheets/SS/SS13FL.pdf" H 4400 900 50  0001 C CNN
F 4 "ON Semiconductor" H 4400 900 60  0001 C CNN "Manufacturer"
F 5 "SS13FL" H 4400 900 60  0001 C CNN "Manufacturer Part #"
F 6 "SS13FLCT-ND" H 4400 900 60  0001 C CNN "Digikey Part #"
F 7 "6ns recovery for 100+ MHz filtering" H 4400 900 60  0001 C CNN "NOTE:"
	1    4400 900 
	-1   0    0    1   
$EndComp
$Comp
L D D11
U 1 1 5B2E6FF8
P 5250 2250
F 0 "D11" H 5250 2466 50  0000 C CNN
F 1 "D" H 5250 2375 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-323F" H 5250 2250 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BAS16_SER.pdf" H 5250 2250 50  0001 C CNN
F 4 "Nexperia USA Inc." H 5250 2250 60  0001 C CNN "Manufacturer"
F 5 "BAS16J,135" H 5250 2250 60  0001 C CNN "Manufacturer Part #"
F 6 "1727-4797-1-ND" H 5250 2250 60  0001 C CNN "Digikey Part #"
F 7 "1.25V max @ 150mA - 4ns recovery" H 5250 2250 60  0001 C CNN "NOTE:"
	1    5250 2250
	1    0    0    -1  
$EndComp
$Comp
L D D7
U 1 1 5B2E7740
P 4350 2250
F 0 "D7" H 4350 2466 50  0000 C CNN
F 1 "D" H 4350 2375 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-323F" H 4350 2250 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BAS16_SER.pdf" H 4350 2250 50  0001 C CNN
F 4 "Nexperia USA Inc." H 4350 2250 60  0001 C CNN "Manufacturer"
F 5 "BAS16J,135" H 4350 2250 60  0001 C CNN "Manufacturer Part #"
F 6 "1727-4797-1-ND" H 4350 2250 60  0001 C CNN "Digikey Part #"
F 7 "1.25V max @ 150mA - 4ns recovery" H 4350 2250 60  0001 C CNN "NOTE:"
	1    4350 2250
	1    0    0    -1  
$EndComp
$Comp
L TEST_1P J14
U 1 1 5B3347C2
P 4950 3800
F 0 "J14" V 4900 4100 50  0000 L CNN
F 1 "Heat_Sink" V 5000 4000 50  0000 L CNN
F 2 "Ben_Custom:Heatsink-10x10mm-V2017B" H 5150 3800 50  0001 C CNN
F 3 "http://www.assmann-wsw.com/fileadmin/datasheets/ASS_0875_HS.pdf" H 5150 3800 50  0001 C CNN
F 4 "Assmann WSW Components" V 4950 3800 60  0001 C CNN "Manufacturer"
F 5 "V2017B" V 4950 3800 60  0001 C CNN "Manufacturer Part #"
F 6 "AE10837-ND" V 4950 3800 60  0001 C CNN "Digikey Part #"
F 7 "31.00°C/W @ Natural" V 4950 3800 60  0001 C CNN "NOTE:"
	1    4950 3800
	-1   0    0    1   
$EndComp
$Comp
L TEST_1P J15
U 1 1 5B335C88
P 5100 3800
F 0 "J15" V 5000 4150 50  0000 L CNN
F 1 "Heat_Sink" V 5100 4000 50  0000 L CNN
F 2 "Ben_Custom:Heatsink-10x10mm-V2017B" H 5300 3800 50  0001 C CNN
F 3 "http://www.assmann-wsw.com/fileadmin/datasheets/ASS_0875_HS.pdf" H 5300 3800 50  0001 C CNN
F 4 "Assmann WSW Components" V 5100 3800 60  0001 C CNN "Manufacturer"
F 5 "V2017B" V 5100 3800 60  0001 C CNN "Manufacturer Part #"
F 6 "AE10837-ND" V 5100 3800 60  0001 C CNN "Digikey Part #"
F 7 "31.00°C/W @ Natural" V 5100 3800 60  0001 C CNN "NOTE:"
	1    5100 3800
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR014
U 1 1 5B3386D8
P 10000 5950
F 0 "#PWR014" H 10000 5700 50  0001 C CNN
F 1 "GND" H 10050 5800 50  0000 R CNN
F 2 "" H 10000 5950 50  0001 C CNN
F 3 "" H 10000 5950 50  0001 C CNN
	1    10000 5950
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR037
U 1 1 5B34BBE9
P 1050 4700
F 0 "#PWR037" H 1050 4450 50  0001 C CNN
F 1 "GND" V 1055 4572 50  0000 R CNN
F 2 "" H 1050 4700 50  0001 C CNN
F 3 "" H 1050 4700 50  0001 C CNN
	1    1050 4700
	0    1    1    0   
$EndComp
$Comp
L GND #PWR041
U 1 1 5B34C734
P 3200 4650
F 0 "#PWR041" H 3200 4400 50  0001 C CNN
F 1 "GND" V 3205 4522 50  0000 R CNN
F 2 "" H 3200 4650 50  0001 C CNN
F 3 "" H 3200 4650 50  0001 C CNN
	1    3200 4650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR043
U 1 1 5B34F56D
P 1450 4400
F 0 "#PWR043" H 1450 4150 50  0001 C CNN
F 1 "GND" V 1455 4272 50  0000 R CNN
F 2 "" H 1450 4400 50  0001 C CNN
F 3 "" H 1450 4400 50  0001 C CNN
	1    1450 4400
	-1   0    0    1   
$EndComp
$Comp
L C C23
U 1 1 5B353C2E
P 1150 5000
F 0 "C23" V 950 5000 50  0000 C CNN
F 1 "10 nF" V 1000 5000 50  0000 C CNN
F 2 "Capacitors_SMD:C_0805" H 1188 4850 50  0001 C CNN
F 3 "http://www.samsungsem.com/kr/support/product-search/mlcc/__icsFiles/afieldfile/2016/09/21/Data%20sheet_CL21B103KDCNNNC.pdf" H 1150 5000 50  0001 C CNN
F 4 "Samsung Electro-Mechanics" V 1150 5000 60  0001 C CNN "Manufacturer"
F 5 "CL21B103KDCNNNC" V 1150 5000 60  0001 C CNN "Manufacturer Part #"
F 6 "1276-1170-1-ND" V 1150 5000 60  0001 C CNN "Digikey Part #"
F 7 "250V - 50MOhm resistance" V 1150 5000 60  0001 C CNN "NOTE:"
	1    1150 5000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR046
U 1 1 5B3540DE
P 1150 5150
F 0 "#PWR046" H 1150 4900 50  0001 C CNN
F 1 "GND" V 1155 5022 50  0000 R CNN
F 2 "" H 1150 5150 50  0001 C CNN
F 3 "" H 1150 5150 50  0001 C CNN
	1    1150 5150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR047
U 1 1 5B355164
P 1450 5150
F 0 "#PWR047" H 1450 4900 50  0001 C CNN
F 1 "GND" V 1455 5022 50  0000 R CNN
F 2 "" H 1450 5150 50  0001 C CNN
F 3 "" H 1450 5150 50  0001 C CNN
	1    1450 5150
	1    0    0    -1  
$EndComp
$Comp
L C C32
U 1 1 5B355F95
P 3450 4650
F 0 "C32" V 3550 4500 50  0000 C CNN
F 1 "10 nF" V 3350 4500 50  0000 C CNN
F 2 "Capacitors_SMD:C_0805" H 3488 4500 50  0001 C CNN
F 3 "http://www.samsungsem.com/kr/support/product-search/mlcc/__icsFiles/afieldfile/2016/09/21/Data%20sheet_CL21B103KDCNNNC.pdf" H 3450 4650 50  0001 C CNN
F 4 "Samsung Electro-Mechanics" V 3450 4650 60  0001 C CNN "Manufacturer"
F 5 "CL21B103KDCNNNC" V 3450 4650 60  0001 C CNN "Manufacturer Part #"
F 6 "1276-1170-1-ND" V 3450 4650 60  0001 C CNN "Digikey Part #"
F 7 "250V - 50MOhm resistance" V 3450 4650 60  0001 C CNN "NOTE:"
	1    3450 4650
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR048
U 1 1 5B3567C7
P 3600 4650
F 0 "#PWR048" H 3600 4400 50  0001 C CNN
F 1 "GND" V 3605 4522 50  0000 R CNN
F 2 "" H 3600 4650 50  0001 C CNN
F 3 "" H 3600 4650 50  0001 C CNN
	1    3600 4650
	0    -1   -1   0   
$EndComp
Text Label 7300 5100 0    60   ~ 0
Input
Text Label 3850 4400 0    60   ~ 0
Input
$Comp
L R R3
U 1 1 5B35B1A1
P 2650 3900
F 0 "R3" V 2550 3900 50  0000 C CNN
F 1 "100" V 2750 3900 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 2580 3900 50  0001 C CNN
F 3 "http://www.yageo.com/documents/recent/PYu-RT_1-to-0.01_RoHS_L_9.pdf" H 2650 3900 50  0001 C CNN
F 4 " Yageo" V 2650 3900 60  0001 C CNN "Manufacturer"
F 5 "RT0603FRE07100RL" V 2650 3900 60  0001 C CNN "Manufacturer Part #"
F 6 "YAG2320CT-ND" V 2650 3900 60  0001 C CNN "Digikey Part #"
F 7 " ±50ppm/°C 0.1W ±1%" V 2650 3900 60  0001 C CNN "NOTE:"
	1    2650 3900
	0    1    1    0   
$EndComp
$Comp
L GND #PWR050
U 1 1 5B35FCE2
P 2800 3900
F 0 "#PWR050" H 2800 3650 50  0001 C CNN
F 1 "GND" V 2900 3900 50  0000 R CNN
F 2 "" H 2800 3900 50  0001 C CNN
F 3 "" H 2800 3900 50  0001 C CNN
	1    2800 3900
	0    -1   -1   0   
$EndComp
Text Notes 1550 3250 0    60   ~ 0
On-board square wave generator
$Comp
L TEST_1P J5
U 1 1 5B363956
P 10100 6450
F 0 "J5" V 10100 7050 50  0000 L CNN
F 1 "Heat_Sink" V 10100 6650 50  0000 L CNN
F 2 "Ben_Custom:Heatsink-10x10mm-V2017B" H 10300 6450 50  0001 C CNN
F 3 "http://www.assmann-wsw.com/fileadmin/datasheets/ASS_0875_HS.pdf" H 10300 6450 50  0001 C CNN
F 4 "Assmann WSW Components" V 10100 6450 60  0001 C CNN "Manufacturer"
F 5 "V2017B" V 10100 6450 60  0001 C CNN "Manufacturer Part #"
F 6 "AE10837-ND" V 10100 6450 60  0001 C CNN "Digikey Part #"
F 7 "31.00°C/W @ Natural" V 10100 6450 60  0001 C CNN "NOTE:"
	1    10100 6450
	0    1    1    0   
$EndComp
$Comp
L Ferrite_Bead L5
U 1 1 5B37053C
P 1750 3900
F 0 "L5" V 1800 4000 50  0000 C CNN
F 1 "Ferrite_Bead" V 1900 4000 50  0000 C CNN
F 2 "Inductors_SMD:L_0603" V 1680 3900 50  0001 C CNN
F 3 "http://katalog.we-online.de/pbs/datasheet/742863147.pdf" H 1750 3900 50  0001 C CNN
F 4 "Wurth Electronics Inc." V 1750 3900 60  0001 C CNN "Manufacturer"
F 5 "742863147" V 1750 3900 60  0001 C CNN "Manufacturer Part #"
F 6 "732-2380-1-ND" V 1750 3900 60  0001 C CNN "Digikey Part #"
F 7 "320 mOhm - 500mA max" V 1750 3900 60  0001 C CNN "NOTE:"
	1    1750 3900
	0    -1   -1   0   
$EndComp
$Comp
L AD5162 DP1
U 1 1 5B3B156D
P 1850 4600
F 0 "DP1" H 1850 5047 60  0000 C CNN
F 1 "AD5162" H 1850 4941 60  0000 C CNN
F 2 "Housings_SSOP:MSOP-10_3x3mm_Pitch0.5mm" H 1800 4600 60  0001 C CNN
F 3 "http://www.analog.com/media/en/technical-documentation/data-sheets/AD5162.pdf" H 1800 4600 60  0001 C CNN
F 4 "Analog Devices Inc." H 1850 4600 60  0001 C CNN "Manufacturer"
F 5 "AD5162BRMZ2.5" H 1850 4600 60  0001 C CNN "Manufacturer Part #"
F 6 "AD5162BRMZ2.5-ND" H 1850 4600 60  0001 C CNN "Digikey Part #"
F 7 "35 ppm/°C - 35MHz SPI" H 1850 4600 60  0001 C CNN "NOTE:"
	1    1850 4600
	1    0    0    -1  
$EndComp
Text Label 2250 4800 0    60   ~ 0
13(SCK)
Text Label 2250 4600 0    60   ~ 0
8
$Comp
L R R8
U 1 1 5B3B88BA
P 2350 3900
F 0 "R8" V 2450 3900 50  0000 C CNN
F 1 "1.8k" V 2250 3900 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 2280 3900 50  0001 C CNN
F 3 "http://www.yageo.com/documents/recent/PYu-RT_1-to-0.01_RoHS_L_9.pdf" H 2350 3900 50  0001 C CNN
F 4 " Yageo" V 2350 3900 60  0001 C CNN "Manufacturer"
F 5 " RT0603DRE071K8L" V 2350 3900 60  0001 C CNN "Manufacturer Part #"
F 6 " 311-2472-1-ND" V 2350 3900 60  0001 C CNN "Digikey Part #"
F 7 " ±50ppm/°C 0.1W ±0.5%" V 2350 3900 60  0001 C CNN "NOTE:"
	1    2350 3900
	0    -1   -1   0   
$EndComp
Text Label 1450 4500 2    60   ~ 0
9(**)
Text Label 2250 4700 0    60   ~ 0
11(**/MOSI)
Text Label 1150 4850 2    60   ~ 0
7
$Comp
L R R4
U 1 1 5B3C777E
P 3300 4800
F 0 "R4" V 3200 4900 50  0000 C CNN
F 1 "0" V 3300 4800 50  0000 C CNN
F 2 "Resistors_SMD:R_1206" V 3230 4800 50  0001 C CNN
F 3 "https://www.seielect.com/Catalog/SEI-RMCF_RMCP.pdf" H 3300 4800 50  0001 C CNN
F 4 "Stackpole Electronics Inc." V 3300 4800 60  0001 C CNN "Manufacturer"
F 5 "RMCF1206ZT0R00" V 3300 4800 60  0001 C CNN "Manufacturer Part #"
F 6 "RMCF1206ZT0R00CT-ND" V 3300 4800 60  0001 C CNN "Digikey Part #"
F 7 "Used as jumper - 0.25W" V 3300 4800 60  0001 C CNN "NOTE:"
	1    3300 4800
	-1   0    0    1   
$EndComp
$Comp
L C C29
U 1 1 5B3CB864
P 2200 3750
F 0 "C29" V 1950 3800 50  0000 C CNN
F 1 "2.2 uF" V 2050 3800 50  0000 C CNN
F 2 "Ben_Custom:0508_Capacitor" H 2238 3600 50  0001 C CNN
F 3 "http://ds.yuden.co.jp/TYCOMPAS/ut/detail.do?productNo=TWK212B7225MD-T&fileName=TWK212B7225MD-T_SS&mode=specSheetDownload" H 2200 3750 50  0001 C CNN
F 4 "Taiyo Yuden" V 2200 3750 60  0001 C CNN "Manufacturer"
F 5 "TWK212B7225MD-T" V 2200 3750 60  0001 C CNN "Manufacturer Part #"
F 6 "587-5165-1-ND" V 2200 3750 60  0001 C CNN "Digikey Part #"
F 7 "Lower GHz impedance than pair of 0402 caps in SPICE" V 2200 3750 60  0001 C CNN "NOTE:"
	1    2200 3750
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR042
U 1 1 5B3CBE74
P 2200 3600
F 0 "#PWR042" H 2200 3350 50  0001 C CNN
F 1 "GND" V 2300 3600 50  0000 R CNN
F 2 "" H 2200 3600 50  0001 C CNN
F 3 "" H 2200 3600 50  0001 C CNN
	1    2200 3600
	0    -1   -1   0   
$EndComp
$Comp
L D D12
U 1 1 5B3CC7E7
P 2050 3900
F 0 "D12" H 2050 4000 50  0000 C CNN
F 1 "D" H 1900 4000 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-323F" H 2050 3900 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BAS16_SER.pdf" H 2050 3900 50  0001 C CNN
F 4 "Nexperia USA Inc." H 2050 3900 60  0001 C CNN "Manufacturer"
F 5 "BAS16J,135" H 2050 3900 60  0001 C CNN "Manufacturer Part #"
F 6 "1727-4797-1-ND" H 2050 3900 60  0001 C CNN "Digikey Part #"
F 7 "1.25V max @ 150mA - 4ns recovery" H 2050 3900 60  0001 C CNN "NOTE:"
	1    2050 3900
	1    0    0    1   
$EndComp
Text Label 4800 2250 0    60   ~ 0
-4V
Text Label 1600 3900 2    60   ~ 0
-4V
Text Label 3300 4950 3    60   ~ 0
7
Text Label 3200 4050 1    60   ~ 0
3(**)
Text Label 3300 4050 1    60   ~ 0
4
$Comp
L R R10
U 1 1 5B3D608C
P 10450 3000
F 0 "R10" V 10350 3000 50  0000 C CNN
F 1 "10" V 10550 3000 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 10380 3000 50  0001 C CNN
F 3 "https://www.seielect.com/Catalog/SEI-rncp.pdf" H 10450 3000 50  0001 C CNN
F 4 "Stackpole Electronics Inc." V 10450 3000 60  0001 C CNN "Manufacturer"
F 5 "RNCP0603FTD10R0" V 10450 3000 60  0001 C CNN "Manufacturer Part #"
F 6 "RNCP0603FTD10R0CT-ND" V 10450 3000 60  0001 C CNN "Digikey Part #"
F 7 "Prevent ground loop with second ground pin" V 10450 3000 60  0001 C CNN "NOTE:"
	1    10450 3000
	0    1    1    0   
$EndComp
$Comp
L GND #PWR044
U 1 1 5B3D64E6
P 10600 3000
F 0 "#PWR044" H 10600 2750 50  0001 C CNN
F 1 "GND" H 10600 2850 50  0000 C CNN
F 2 "" H 10600 3000 50  0000 C CNN
F 3 "" H 10600 3000 50  0000 C CNN
	1    10600 3000
	0    -1   -1   0   
$EndComp
$Comp
L C C2
U 1 1 5B3F67EF
P 1700 2400
F 0 "C2" V 1850 2400 50  0000 C CNN
F 1 "4.7 uF" V 1550 2400 50  0000 C CNN
F 2 "Capacitors_SMD:C_0805" H 1738 2250 50  0001 C CNN
F 3 "https://product.tdk.com/en/search/capacitor/ceramic/mlcc/info?part_no=C2012X5R1H475M125AB" H 1700 2400 50  0001 C CNN
F 4 "TDK Corporation" V 1700 2400 60  0001 C CNN "Manufacturer"
F 5 "C2012X5R1H475M125AB" V 1700 2400 60  0001 C CNN "Manufacturer Part #"
F 6 "445-5981-1-ND" V 1700 2400 60  0001 C CNN "Digikey Part #"
F 7 " 50V max - low ESL" V 1700 2400 60  0001 C CNN "NOTE:"
	1    1700 2400
	-1   0    0    1   
$EndComp
$Comp
L C C9
U 1 1 5B3FC7C8
P 3800 1050
F 0 "C9" V 3950 1050 50  0000 C CNN
F 1 "4.7 uF" V 3650 1050 50  0000 C CNN
F 2 "Capacitors_SMD:C_0805" H 3838 900 50  0001 C CNN
F 3 "https://product.tdk.com/en/search/capacitor/ceramic/mlcc/info?part_no=C2012X5R1H475M125AB" H 3800 1050 50  0001 C CNN
F 4 "TDK Corporation" V 3800 1050 60  0001 C CNN "Manufacturer"
F 5 "C2012X5R1H475M125AB" V 3800 1050 60  0001 C CNN "Manufacturer Part #"
F 6 "445-5981-1-ND" V 3800 1050 60  0001 C CNN "Digikey Part #"
F 7 " 50V max - low ESL" V 3800 1050 60  0001 C CNN "NOTE:"
	1    3800 1050
	-1   0    0    1   
$EndComp
$Comp
L C C11
U 1 1 5B3FC9A8
P 4200 1050
F 0 "C11" V 4350 1050 50  0000 C CNN
F 1 "4.7 uF" V 4050 1050 50  0000 C CNN
F 2 "Capacitors_SMD:C_0805" H 4238 900 50  0001 C CNN
F 3 "https://product.tdk.com/en/search/capacitor/ceramic/mlcc/info?part_no=C2012X5R1H475M125AB" H 4200 1050 50  0001 C CNN
F 4 "TDK Corporation" V 4200 1050 60  0001 C CNN "Manufacturer"
F 5 "C2012X5R1H475M125AB" V 4200 1050 60  0001 C CNN "Manufacturer Part #"
F 6 "445-5981-1-ND" V 4200 1050 60  0001 C CNN "Digikey Part #"
F 7 " 50V max - low ESL" V 4200 1050 60  0001 C CNN "NOTE:"
	1    4200 1050
	-1   0    0    1   
$EndComp
$Comp
L C C12
U 1 1 5B3FCA88
P 4850 1050
F 0 "C12" V 4950 1150 50  0000 C CNN
F 1 "4.7 uF" V 4700 1050 50  0000 C CNN
F 2 "Capacitors_SMD:C_0805" H 4888 900 50  0001 C CNN
F 3 "https://product.tdk.com/en/search/capacitor/ceramic/mlcc/info?part_no=C2012X5R1H475M125AB" H 4850 1050 50  0001 C CNN
F 4 "TDK Corporation" V 4850 1050 60  0001 C CNN "Manufacturer"
F 5 "C2012X5R1H475M125AB" V 4850 1050 60  0001 C CNN "Manufacturer Part #"
F 6 "445-5981-1-ND" V 4850 1050 60  0001 C CNN "Digikey Part #"
F 7 " 50V max - low ESL" V 4850 1050 60  0001 C CNN "NOTE:"
	1    4850 1050
	-1   0    0    1   
$EndComp
$Comp
L C C10
U 1 1 5B3FEBE0
P 4000 2400
F 0 "C10" V 4150 2400 50  0000 C CNN
F 1 "4.7 uF" V 3850 2400 50  0000 C CNN
F 2 "Capacitors_SMD:C_0805" H 4038 2250 50  0001 C CNN
F 3 "https://product.tdk.com/en/search/capacitor/ceramic/mlcc/info?part_no=C2012X5R1H475M125AB" H 4000 2400 50  0001 C CNN
F 4 "TDK Corporation" V 4000 2400 60  0001 C CNN "Manufacturer"
F 5 "C2012X5R1H475M125AB" V 4000 2400 60  0001 C CNN "Manufacturer Part #"
F 6 "445-5981-1-ND" V 4000 2400 60  0001 C CNN "Digikey Part #"
F 7 " 50V max - low ESL" V 4000 2400 60  0001 C CNN "NOTE:"
	1    4000 2400
	-1   0    0    1   
$EndComp
$Comp
L C C24
U 1 1 5B3FED4A
P 4800 2400
F 0 "C24" V 4950 2450 50  0000 C CNN
F 1 "4.7 uF" V 4650 2400 50  0000 C CNN
F 2 "Capacitors_SMD:C_0805" H 4838 2250 50  0001 C CNN
F 3 "https://product.tdk.com/en/search/capacitor/ceramic/mlcc/info?part_no=C2012X5R1H475M125AB" H 4800 2400 50  0001 C CNN
F 4 "TDK Corporation" V 4800 2400 60  0001 C CNN "Manufacturer"
F 5 "C2012X5R1H475M125AB" V 4800 2400 60  0001 C CNN "Manufacturer Part #"
F 6 "445-5981-1-ND" V 4800 2400 60  0001 C CNN "Digikey Part #"
F 7 " 50V max - low ESL" V 4800 2400 60  0001 C CNN "NOTE:"
	1    4800 2400
	-1   0    0    1   
$EndComp
$Comp
L C C27
U 1 1 5B3FFB95
P 1450 5000
F 0 "C27" V 1600 5050 50  0000 C CNN
F 1 "4.7 uF" V 1300 5000 50  0000 C CNN
F 2 "Capacitors_SMD:C_0805" H 1488 4850 50  0001 C CNN
F 3 "https://product.tdk.com/en/search/capacitor/ceramic/mlcc/info?part_no=C2012X5R1H475M125AB" H 1450 5000 50  0001 C CNN
F 4 "TDK Corporation" V 1450 5000 60  0001 C CNN "Manufacturer"
F 5 "C2012X5R1H475M125AB" V 1450 5000 60  0001 C CNN "Manufacturer Part #"
F 6 "445-5981-1-ND" V 1450 5000 60  0001 C CNN "Digikey Part #"
F 7 " 50V max - low ESL" V 1450 5000 60  0001 C CNN "NOTE:"
	1    1450 5000
	-1   0    0    1   
$EndComp
$Comp
L C C13
U 1 1 5B407E7B
P 5450 1050
F 0 "C13" V 5600 1000 50  0000 C CNN
F 1 "2.2 uF" V 5300 1000 50  0000 C CNN
F 2 "Ben_Custom:0508_Capacitor" H 5488 900 50  0001 C CNN
F 3 "http://ds.yuden.co.jp/TYCOMPAS/ut/detail.do?productNo=TWK212B7225MD-T&fileName=TWK212B7225MD-T_SS&mode=specSheetDownload" H 5450 1050 50  0001 C CNN
F 4 "Taiyo Yuden" V 5450 1050 60  0001 C CNN "Manufacturer"
F 5 "TWK212B7225MD-T" V 5450 1050 60  0001 C CNN "Manufacturer Part #"
F 6 "587-5165-1-ND" V 5450 1050 60  0001 C CNN "Digikey Part #"
F 7 "Lower GHz impedance than pair of 0402 caps in SPICE" V 5450 1050 60  0001 C CNN "NOTE:"
	1    5450 1050
	1    0    0    -1  
$EndComp
$Comp
L C C26
U 1 1 5B409050
P 5400 2400
F 0 "C26" V 5550 2350 50  0000 C CNN
F 1 "2.2 uF" V 5250 2350 50  0000 C CNN
F 2 "Ben_Custom:0508_Capacitor" H 5438 2250 50  0001 C CNN
F 3 "http://ds.yuden.co.jp/TYCOMPAS/ut/detail.do?productNo=TWK212B7225MD-T&fileName=TWK212B7225MD-T_SS&mode=specSheetDownload" H 5400 2400 50  0001 C CNN
F 4 "Taiyo Yuden" V 5400 2400 60  0001 C CNN "Manufacturer"
F 5 "TWK212B7225MD-T" V 5400 2400 60  0001 C CNN "Manufacturer Part #"
F 6 "587-5165-1-ND" V 5400 2400 60  0001 C CNN "Digikey Part #"
F 7 "Lower GHz impedance than pair of 0402 caps in SPICE" V 5400 2400 60  0001 C CNN "NOTE:"
	1    5400 2400
	1    0    0    -1  
$EndComp
$Comp
L D_TVS D3
U 1 1 5B412FC4
P 10500 5350
F 0 "D3" V 10454 5429 50  0000 L CNN
F 1 "D_TVS" V 10545 5429 50  0000 L CNN
F 2 "Ben_Custom:DO-214AC" H 10500 5350 50  0001 C CNN
F 3 "http://katalog.we-online.de/pbs/datasheet/824501241.pdf" H 10500 5350 50  0001 C CNN
F 4 "Wurth Electronics Inc." V 10500 5350 60  0001 C CNN "Manufacturer"
F 5 "824501241" V 10500 5350 60  0001 C CNN "Manufacturer Part #"
F 6 "732-9956-1-ND" V 10500 5350 60  0001 C CNN "Digikey Part #"
F 7 "Standoff - 24V, Clamping - 38.9V - 10.3A max" V 10500 5350 60  0001 C CNN "NOTE:"
	1    10500 5350
	0    1    1    0   
$EndComp
$Comp
L D_Schottky D13
U 1 1 5B41A41B
P 8750 2650
F 0 "D13" H 8900 2600 50  0000 C CNN
F 1 "D_Schottky" H 8900 2750 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-323" H 8750 2650 50  0001 C CNN
F 3 "https://toshiba.semicon-storage.com/info/docget.jsp?did=14077&prodName=CUS10S30" H 8750 2650 50  0001 C CNN
F 4 "Toshiba Semiconductor and Storage" H 8750 2650 60  0001 C CNN "Manufacturer"
F 5 "CUS10S30,H3F" H 8750 2650 60  0001 C CNN "Manufacturer Part #"
F 6 "CUS10S30H3FCT-ND" H 8750 2650 60  0001 C CNN "Digikey Part #"
F 7 "230mV @ 100mA max" H 8750 2650 60  0001 C CNN "NOTE:"
	1    8750 2650
	-1   0    0    1   
$EndComp
$Comp
L TS5A3357DCUR SW1
U 1 1 5B349A05
P 3200 4400
F 0 "SW1" V 3050 4100 50  0000 R CNN
F 1 "TS5A3357DCUR" V 2950 4100 50  0000 R CNN
F 2 "Ben_Custom:8-VFSOP" H 3300 3550 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/ts5a3357.pdf" H 3200 4400 50  0001 C CNN
F 4 "Texas Instruments" H 3200 4400 60  0001 C CNN "Manufacturer"
F 5 "TS5A3357DCUR" H 3200 4400 60  0001 C CNN "Manufacturer Part #"
F 6 "296-17404-1-ND" H 3200 4400 60  0001 C CNN "Digikey Part #"
F 7 "15 Ohm - 6.5ns switch time" H 3200 4400 60  0001 C CNN "NOTE:"
	1    3200 4400
	-1   0    0    1   
$EndComp
$Comp
L Conn_Coaxial J1
U 1 1 5B444F1E
P 2750 4300
F 0 "J1" H 2850 4184 50  0000 L CNN
F 1 "Conn_Coaxial" H 2650 4450 50  0000 L CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x02_Pitch2.54mm" H 2750 4300 50  0001 C CNN
F 3 "http://www.sullinscorp.com/drawings/78_P(N)PxCxxxLFBN-RC,_10492-H.pdf" H 2750 4300 50  0001 C CNN
F 4 "Sullins Connector Solutions" H 2750 4300 60  0001 C CNN "Manufacturer"
F 5 "PPPC021LFBN-RC" H 2750 4300 60  0001 C CNN "Manufacturer Part #"
F 6 "S7035-ND" H 2750 4300 60  0001 C CNN "Digikey Part #"
F 7 " " H 2750 4300 60  0001 C CNN "NOTE:"
	1    2750 4300
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR07
U 1 1 5B447DE2
P 2750 4100
F 0 "#PWR07" H 2750 3850 50  0001 C CNN
F 1 "GND" V 2755 3972 50  0000 R CNN
F 2 "" H 2750 4100 50  0001 C CNN
F 3 "" H 2750 4100 50  0001 C CNN
	1    2750 4100
	0    -1   -1   0   
$EndComp
$Comp
L R_Pack04 RN1
U 1 1 5B45DFCE
P 8850 1850
F 0 "RN1" V 8550 1800 50  0000 L CNN
F 1 "4.7k" V 8600 1550 50  0000 L CNN
F 2 "Ben_Custom:Resistor_Array_x4_1206" V 9125 1850 50  0001 C CNN
F 3 "https://industrial.panasonic.com/cdbs/www-data/pdf/AOC0000/AOC0000C14.pdf" H 8850 1850 50  0001 C CNN
F 4 "Panasonic Electronic Components" V 8850 1850 60  0001 C CNN "Manufacturer"
F 5 "EXB-38V472JV" V 8850 1850 60  0001 C CNN "Manufacturer Part #"
F 6 "Y9472CT-ND" V 8850 1850 60  0001 C CNN "Digikey Part #"
F 7 "±5% ±200ppm/°C 62.5mW" V 8850 1850 60  0001 C CNN "NOTE:"
	1    8850 1850
	0    1    1    0   
$EndComp
$Comp
L GND #PWR039
U 1 1 5B46DFC7
P 8700 2100
F 0 "#PWR039" H 8700 1850 50  0001 C CNN
F 1 "GND" V 8600 2050 50  0000 C CNN
F 2 "" H 8700 2100 50  0000 C CNN
F 3 "" H 8700 2100 50  0000 C CNN
	1    8700 2100
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR045
U 1 1 5B46E156
P 9050 1950
F 0 "#PWR045" H 9050 1700 50  0001 C CNN
F 1 "GND" H 9050 1800 50  0000 C CNN
F 2 "" H 9050 1950 50  0000 C CNN
F 3 "" H 9050 1950 50  0000 C CNN
	1    9050 1950
	0    -1   -1   0   
$EndComp
$Comp
L Thermistor TH1
U 1 1 5B470D28
P 8300 2350
F 0 "TH1" V 8300 2350 50  0000 C CNN
F 1 "10k" V 8149 2350 50  0000 C CNN
F 2 "Ben_Custom:CC_silkscreen" H 8300 2350 50  0001 C CNN
F 3 "http://www.cantherm.com/wp-content/uploads/2017/05/cantherm_mf52_1.pdf" H 8300 2350 50  0001 C CNN
F 4 "Cantherm" V 8300 2350 60  0001 C CNN "Manufacturer"
F 5 "MF52A2103J3470" V 8300 2350 60  0001 C CNN "Manufacturer Part #"
F 6 "317-1258-ND" V 8300 2350 60  0001 C CNN "Digikey Part #"
F 7 "B25/50 3470K" V 8300 2350 60  0001 C CNN "NOTE:"
	1    8300 2350
	0    1    1    0   
$EndComp
$Comp
L Conn_01x05_Female J17
U 1 1 5B472F85
P 7900 2550
F 0 "J17" H 7850 2250 50  0000 C CNN
F 1 "Conn_01x05_Female" V 7950 2550 50  0000 C CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x05_Pitch2.54mm" H 7900 2550 50  0001 C CNN
F 3 "http://www.sullinscorp.com/drawings/78_P(N)PxCxxxLFBN-RC,_10492-H.pdf" H 7900 2550 50  0001 C CNN
F 4 "Sullins Connector Solutions" H 7900 2550 60  0001 C CNN "Manufacturer"
F 5 "PPPC051LFBN-RC" H 7900 2550 60  0001 C CNN "Manufacturer Part #"
F 6 "S7038-ND" H 7900 2550 60  0001 C CNN "Digikey Part #"
F 7 " " H 7900 2550 60  0001 C CNN "NOTE:"
	1    7900 2550
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR049
U 1 1 5B473C09
P 8100 2300
F 0 "#PWR049" H 8100 2050 50  0001 C CNN
F 1 "GND" H 8200 2150 50  0000 C CNN
F 2 "" H 8100 2300 50  0000 C CNN
F 3 "" H 8100 2300 50  0000 C CNN
	1    8100 2300
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR051
U 1 1 5B47438A
P 8100 2750
F 0 "#PWR051" H 8100 2500 50  0001 C CNN
F 1 "GND" V 8100 2550 50  0000 C CNN
F 2 "" H 8100 2750 50  0000 C CNN
F 3 "" H 8100 2750 50  0000 C CNN
	1    8100 2750
	0    -1   -1   0   
$EndComp
$Comp
L C C25
U 1 1 5B4764E9
P 4950 1600
F 0 "C25" V 5100 1550 50  0000 C CNN
F 1 "2.2 uF" V 4800 1550 50  0000 C CNN
F 2 "Ben_Custom:0508_Capacitor" H 4988 1450 50  0001 C CNN
F 3 "http://ds.yuden.co.jp/TYCOMPAS/ut/detail.do?productNo=TWK212B7225MD-T&fileName=TWK212B7225MD-T_SS&mode=specSheetDownload" H 4950 1600 50  0001 C CNN
F 4 "Taiyo Yuden" V 4950 1600 60  0001 C CNN "Manufacturer"
F 5 "TWK212B7225MD-T" V 4950 1600 60  0001 C CNN "Manufacturer Part #"
F 6 "587-5165-1-ND" V 4950 1600 60  0001 C CNN "Digikey Part #"
F 7 "Lower GHz impedance than pair of 0402 caps in SPICE" V 4950 1600 60  0001 C CNN "NOTE:"
	1    4950 1600
	0    1    1    0   
$EndComp
$Comp
L Thermistor TH2
U 1 1 5B4784AA
P 8350 2450
F 0 "TH2" V 8350 2450 50  0000 C CNN
F 1 "10k" V 8199 2450 50  0001 C CNN
F 2 "Ben_Custom:CC_Attribution" H 8350 2450 50  0001 C CNN
F 3 "http://www.cantherm.com/wp-content/uploads/2017/05/cantherm_mf52_1.pdf" H 8350 2450 50  0001 C CNN
F 4 "Cantherm" V 8350 2450 60  0001 C CNN "Manufacturer"
F 5 "MF52A2103J3470" V 8350 2450 60  0001 C CNN "Manufacturer Part #"
F 6 "317-1258-ND" V 8350 2450 60  0001 C CNN "Digikey Part #"
F 7 "B25/50 3470K" V 8350 2450 60  0001 C CNN "NOTE:"
	1    8350 2450
	0    1    1    0   
$EndComp
$Comp
L Thermistor TH3
U 1 1 5B47858A
P 8400 2550
F 0 "TH3" V 8400 2550 50  0000 C CNN
F 1 "10k" V 8249 2550 50  0001 C CNN
F 2 "Ben_Custom:CC_Share_alike" H 8400 2550 50  0001 C CNN
F 3 "http://www.cantherm.com/wp-content/uploads/2017/05/cantherm_mf52_1.pdf" H 8400 2550 50  0001 C CNN
F 4 "Cantherm" V 8400 2550 60  0001 C CNN "Manufacturer"
F 5 "MF52A2103J3470" V 8400 2550 60  0001 C CNN "Manufacturer Part #"
F 6 "317-1258-ND" V 8400 2550 60  0001 C CNN "Digikey Part #"
F 7 "B25/50 3470K" V 8400 2550 60  0001 C CNN "NOTE:"
	1    8400 2550
	0    1    1    0   
$EndComp
$Comp
L Conn_Coaxial J16
U 1 1 5B4803F2
P 10000 5750
F 0 "J16" H 10100 5750 50  0000 L CNN
F 1 "Conn_Coaxial" H 9900 5850 50  0000 L CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x02_Pitch2.54mm" H 10000 5750 50  0001 C CNN
F 3 "http://www.sullinscorp.com/drawings/78_P(N)PxCxxxLFBN-RC,_10492-H.pdf" H 10000 5750 50  0001 C CNN
F 4 "Sullins Connector Solutions" H 10000 5750 60  0001 C CNN "Manufacturer"
F 5 "PPPC021LFBN-RC" H 10000 5750 60  0001 C CNN "Manufacturer Part #"
F 6 "S7035-ND" H 10000 5750 60  0001 C CNN "Digikey Part #"
F 7 " " H 10000 5750 60  0001 C CNN "NOTE:"
	1    10000 5750
	1    0    0    -1  
$EndComp
Text Notes 4750 3250 0    60   ~ 0
Power entry to board
$Comp
L POT RV4
U 1 1 5B479FE9
P 8900 3000
F 0 "RV4" V 8786 3000 50  0000 C CNN
F 1 "10k" V 8900 3000 50  0000 C CNN
F 2 "Symbols:OSHW-Symbol_6.7x6mm_SilkScreen" H 8900 3000 50  0001 C CNN
F 3 "http://www.ttelectronics.com/sites/default/files/download-files/Datasheet_RotaryPanelPot_P170series.pdf" H 8900 3000 50  0001 C CNN
F 4 "TT Electronics/BI" V 8900 3000 60  0001 C CNN "Manufacturer"
F 5 "P170S-FC20BR10K" V 8900 3000 60  0001 C CNN "Manufacturer Part #"
F 6 "987-1318-ND" V 8900 3000 60  0001 C CNN "Digikey Part #"
F 7 "Rotary, SPST" V 8900 3000 60  0001 C CNN "NOTE:"
	1    8900 3000
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR031
U 1 1 5B47A4A1
P 9050 3000
F 0 "#PWR031" H 9050 2750 50  0001 C CNN
F 1 "GND" H 9050 2850 50  0000 C CNN
F 2 "" H 9050 3000 50  0000 C CNN
F 3 "" H 9050 3000 50  0000 C CNN
	1    9050 3000
	0    -1   -1   0   
$EndComp
$Comp
L +5V #PWR052
U 1 1 5B47A753
P 8750 3000
F 0 "#PWR052" H 8750 2850 50  0001 C CNN
F 1 "+5V" H 8750 3140 50  0000 C CNN
F 2 "" H 8750 3000 50  0000 C CNN
F 3 "" H 8750 3000 50  0000 C CNN
	1    8750 3000
	0    -1   -1   0   
$EndComp
$Comp
L C C3
U 1 1 5B481002
P 1600 1450
F 0 "C3" V 1750 1450 50  0000 C CNN
F 1 "1 uF" V 1450 1450 50  0000 C CNN
F 2 "Capacitors_SMD:C_0805" H 1638 1300 50  0001 C CNN
F 3 "http://ds.yuden.co.jp/TYCOMPAS/ut/detail.do?productNo=HMK212BC7105KG-TE&fileName=HMK212BC7105KG-TE_SS&mode=specSheetDownload" H 1600 1450 50  0001 C CNN
F 4 "Taiyo Yuden" V 1600 1450 60  0001 C CNN "Manufacturer"
F 5 "HMK212BC7105KG-TE" V 1600 1450 60  0001 C CNN "Manufacturer Part #"
F 6 "587-5018-1-ND" V 1600 1450 60  0001 C CNN "Digikey Part #"
F 7 "Low ESL (same as 0603) - 100V" V 1600 1450 60  0001 C CNN "NOTE:"
	1    1600 1450
	0    -1   -1   0   
$EndComp
$Comp
L C C4
U 1 1 5B4812B2
P 1600 2800
F 0 "C4" V 1750 2800 50  0000 C CNN
F 1 "1 uF" V 1450 2800 50  0000 C CNN
F 2 "Capacitors_SMD:C_0805" H 1638 2650 50  0001 C CNN
F 3 "http://ds.yuden.co.jp/TYCOMPAS/ut/detail.do?productNo=HMK212BC7105KG-TE&fileName=HMK212BC7105KG-TE_SS&mode=specSheetDownload" H 1600 2800 50  0001 C CNN
F 4 "Taiyo Yuden" V 1600 2800 60  0001 C CNN "Manufacturer"
F 5 "HMK212BC7105KG-TE" V 1600 2800 60  0001 C CNN "Manufacturer Part #"
F 6 "587-5018-1-ND" V 1600 2800 60  0001 C CNN "Digikey Part #"
F 7 "Low ESL (same as 0603) - 100V" V 1600 2800 60  0001 C CNN "NOTE:"
	1    1600 2800
	0    -1   -1   0   
$EndComp
$Comp
L Conn_Coaxial J7
U 1 1 5B49488D
P 1000 4250
F 0 "J7" H 1100 4134 50  0000 L CNN
F 1 "Conn_Coaxial" H 900 4400 50  0000 L CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x02_Pitch2.54mm" H 1000 4250 50  0001 C CNN
F 3 "http://www.sullinscorp.com/drawings/78_P(N)PxCxxxLFBN-RC,_10492-H.pdf" H 1000 4250 50  0001 C CNN
F 4 "Sullins Connector Solutions" H 1000 4250 60  0001 C CNN "Manufacturer"
F 5 "PPPC021LFBN-RC" H 1000 4250 60  0001 C CNN "Manufacturer Part #"
F 6 "S7035-ND" H 1000 4250 60  0001 C CNN "Digikey Part #"
F 7 " " H 1000 4250 60  0001 C CNN "NOTE:"
	1    1000 4250
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR053
U 1 1 5B494A02
P 1000 4050
F 0 "#PWR053" H 1000 3800 50  0001 C CNN
F 1 "GND" H 1250 4000 50  0000 R CNN
F 2 "" H 1000 4050 50  0001 C CNN
F 3 "" H 1000 4050 50  0001 C CNN
	1    1000 4050
	-1   0    0    1   
$EndComp
$Comp
L Conn_Coaxial J18
U 1 1 5B49B083
P 4000 2050
F 0 "J18" V 4100 1934 50  0000 L CNN
F 1 "Conn_Coaxial" H 3300 2100 50  0000 L CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x02_Pitch2.54mm" H 4000 2050 50  0001 C CNN
F 3 "http://www.sullinscorp.com/drawings/78_P(N)PxCxxxLFBN-RC,_10492-H.pdf" H 4000 2050 50  0001 C CNN
F 4 "Sullins Connector Solutions" H 4000 2050 60  0001 C CNN "Manufacturer"
F 5 "PPPC021LFBN-RC" H 4000 2050 60  0001 C CNN "Manufacturer Part #"
F 6 "S7035-ND" H 4000 2050 60  0001 C CNN "Digikey Part #"
F 7 " " H 4000 2050 60  0001 C CNN "NOTE:"
	1    4000 2050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR054
U 1 1 5B49B8D5
P 3850 2050
F 0 "#PWR054" H 3850 1800 50  0001 C CNN
F 1 "GND" H 3950 2150 50  0000 R CNN
F 2 "" H 3850 2050 50  0001 C CNN
F 3 "" H 3850 2050 50  0001 C CNN
	1    3850 2050
	1    0    0    -1  
$EndComp
Connection ~ 10100 6300
Wire Notes Line
	4100 3250 4100 5500
Wire Notes Line
	4100 5500 550  5500
Wire Notes Line
	550  5500 550  3250
Wire Notes Line
	7000 3450 7000 6550
Wire Wire Line
	1450 4850 1450 4800
Wire Wire Line
	1150 4850 1450 4850
Wire Wire Line
	1450 4700 1050 4700
Connection ~ 5100 3800
Wire Wire Line
	4950 3800 5250 3800
Connection ~ 5000 3800
Wire Wire Line
	8450 5650 8450 5800
Wire Wire Line
	9200 5850 9200 6000
Wire Wire Line
	8150 5450 8150 6000
Wire Notes Line
	550  600  550  1800
Wire Notes Line
	6900 1800 6900 600 
Wire Wire Line
	5000 3700 5000 3800
Wire Wire Line
	5300 3700 5550 3700
Connection ~ 5600 900 
Wire Notes Line
	6900 3150 6900 1900
Wire Notes Line
	550  1900 550  3150
Wire Wire Line
	1000 2550 950  2550
Wire Wire Line
	1000 1200 950  1200
Wire Wire Line
	3150 2250 4200 2250
Connection ~ 8450 5800
Wire Wire Line
	8150 6000 9400 6000
Wire Wire Line
	1300 2550 2000 2550
Connection ~ 1300 2550
Wire Wire Line
	1300 2900 1300 2550
Wire Wire Line
	1750 2900 1300 2900
Wire Wire Line
	1300 1200 2000 1200
Connection ~ 1300 1200
Wire Wire Line
	1300 1550 1300 1200
Wire Wire Line
	1750 1550 1300 1550
Connection ~ 1650 1200
Connection ~ 1700 2550
Wire Wire Line
	9850 5050 9850 5150
Wire Wire Line
	9850 3600 9850 4950
Connection ~ 9850 4100
Connection ~ 9850 3850
Connection ~ 9850 4250
Connection ~ 9850 5600
Wire Wire Line
	10500 5600 9850 5600
Connection ~ 9850 5100
Connection ~ 9850 4700
Wire Wire Line
	10100 6150 10100 6450
Wire Wire Line
	9850 6300 10100 6300
Connection ~ 9850 5750
Connection ~ 9350 6000
Wire Wire Line
	9350 6300 9350 6000
Connection ~ 9050 5350
Wire Wire Line
	9050 5250 9050 5350
Wire Wire Line
	9500 5350 9550 5350
Wire Wire Line
	9500 5250 9500 5350
Wire Wire Line
	9450 5250 9500 5250
Wire Wire Line
	7450 5100 7300 5100
Connection ~ 9200 6000
Connection ~ 9200 5350
Wire Wire Line
	9200 5350 9200 5550
Connection ~ 9850 5850
Wire Wire Line
	9850 5850 9550 5850
Wire Wire Line
	9400 5350 9400 5500
Wire Notes Line
	6900 1900 550  1900
Connection ~ 4200 900 
Wire Wire Line
	2000 2150 2000 2350
Wire Wire Line
	2000 2150 3150 2150
Wire Wire Line
	3150 2150 3150 2250
Wire Notes Line
	550  3150 6900 3150
Connection ~ 4000 2250
Connection ~ 3600 2250
Wire Wire Line
	3150 2550 3600 2550
Wire Wire Line
	2650 2900 3150 2900
Wire Wire Line
	3150 2900 3150 2550
Wire Wire Line
	2400 2250 2400 2350
Wire Wire Line
	2650 2250 2400 2250
Wire Wire Line
	2650 2550 2400 2550
Connection ~ 2650 2550
Connection ~ 1750 2550
Wire Wire Line
	2650 2550 2650 2700
Wire Wire Line
	1750 2550 1750 2700
Wire Notes Line
	550  1800 6900 1800
Wire Notes Line
	6900 600  550  600 
Connection ~ 3800 900 
Connection ~ 3400 900 
Wire Wire Line
	3400 1200 2950 1200
Wire Wire Line
	2950 1550 2650 1550
Wire Wire Line
	2950 1200 2950 1550
Wire Wire Line
	2400 900  2400 1000
Wire Wire Line
	2650 900  2400 900 
Wire Wire Line
	2650 1200 2400 1200
Connection ~ 2650 1200
Connection ~ 1750 1200
Wire Wire Line
	2650 1200 2650 1350
Wire Wire Line
	1750 1200 1750 1350
Connection ~ 9850 4900
Connection ~ 9850 4500
Wire Wire Line
	9850 5550 9850 6000
Wire Wire Line
	8850 5350 9400 5350
Wire Wire Line
	8150 5450 8250 5450
Wire Notes Line
	7000 3450 11200 3450
Wire Wire Line
	9300 1950 9300 3000
Wire Wire Line
	10300 1350 10300 3000
Wire Wire Line
	10200 1350 10300 1350
Wire Wire Line
	10200 2150 10550 2150
Wire Wire Line
	10200 2250 10550 2250
Wire Wire Line
	10200 2350 10550 2350
Wire Wire Line
	10200 2450 10550 2450
Wire Wire Line
	10200 2550 10550 2550
Wire Wire Line
	10200 2650 10550 2650
Wire Wire Line
	10200 2750 10550 2750
Wire Wire Line
	10200 2850 10550 2850
Wire Wire Line
	10200 1050 10550 1050
Wire Wire Line
	10200 1150 10550 1150
Wire Wire Line
	10200 1250 10550 1250
Wire Wire Line
	10200 1450 10550 1450
Wire Wire Line
	10200 1550 10550 1550
Wire Wire Line
	10200 1650 10550 1650
Wire Wire Line
	10200 1750 10550 1750
Wire Wire Line
	10200 1850 10550 1850
Wire Wire Line
	10200 1950 10550 1950
Wire Wire Line
	9400 2850 8900 2850
Wire Wire Line
	9400 2750 8900 2750
Wire Wire Line
	9400 2650 8900 2650
Wire Wire Line
	9150 1750 9150 1300
Wire Wire Line
	9050 1200 9050 1850
Connection ~ 9300 2050
Wire Wire Line
	9400 2050 9300 2050
Wire Wire Line
	9400 1950 9300 1950
Wire Wire Line
	9050 1850 9400 1850
Wire Wire Line
	9400 1750 9150 1750
Wire Wire Line
	9350 1550 9400 1550
Wire Wire Line
	9350 1300 9350 1550
Wire Notes Line
	9925 825  9925 475 
Wire Notes Line
	8525 825  9925 825 
Connection ~ 5600 1000
Wire Wire Line
	5100 1400 5100 1600
Wire Wire Line
	5100 1600 5250 1600
Wire Wire Line
	6400 2250 6650 2250
Wire Wire Line
	5600 2250 5400 2250
Wire Wire Line
	5600 2250 5600 2450
Wire Wire Line
	5450 900  5600 900 
Connection ~ 5100 900 
Wire Wire Line
	5100 1100 5100 900 
Wire Wire Line
	2950 900  4250 900 
Wire Wire Line
	4850 900  5150 900 
Wire Wire Line
	5100 2250 4800 2250
Wire Wire Line
	2500 3900 2500 4500
Wire Wire Line
	2250 4400 2250 4500
Wire Wire Line
	1450 4600 1150 4600
Wire Wire Line
	1150 4600 1150 4100
Wire Wire Line
	1150 4100 2400 4100
Wire Wire Line
	2400 4100 2400 4400
Wire Wire Line
	2400 4400 2900 4400
Wire Wire Line
	5600 900  5600 1000
Wire Wire Line
	9850 5100 10500 5100
Wire Wire Line
	10500 5100 10500 5200
Wire Wire Line
	10500 5500 10500 5600
Wire Wire Line
	2500 4500 2900 4500
Connection ~ 9050 1850
Connection ~ 9050 1750
Connection ~ 9050 1650
Wire Wire Line
	8650 1850 8600 1850
Wire Wire Line
	8600 1850 8600 2550
Wire Wire Line
	8600 2550 9400 2550
Wire Wire Line
	8650 1750 8550 1750
Wire Wire Line
	8550 1750 8550 2450
Wire Wire Line
	8550 2450 9400 2450
Wire Wire Line
	8650 1650 8500 1650
Wire Wire Line
	8500 1650 8500 2350
Wire Wire Line
	8500 2350 9400 2350
Wire Wire Line
	8650 1950 8650 2100
Wire Wire Line
	8650 2100 8700 2100
Wire Wire Line
	8150 2450 8100 2450
Wire Wire Line
	8100 2550 8200 2550
Wire Wire Line
	8600 2650 8100 2650
Wire Wire Line
	8100 2300 8100 2550
Connection ~ 8100 2450
Connection ~ 8100 2350
Wire Notes Line
	6000 3250 6000 4500
Wire Notes Line
	6000 4500 4500 4500
Wire Notes Line
	550  3250 4100 3250
Wire Notes Line
	6000 3250 4500 3250
Wire Notes Line
	4500 3250 4500 4500
Wire Notes Line
	11200 3300 7750 3300
Wire Notes Line
	7750 3300 7750 500 
Wire Wire Line
	6650 900  6400 900 
Connection ~ 1150 4250
Wire Wire Line
	3550 4400 3850 4400
Wire Wire Line
	8250 5250 7600 5250
$EndSCHEMATC
