package edu.berkeley.MHz_LED_Modulator_v2b;

import java.nio.ByteBuffer;
import java.util.Arrays;
import java.util.prefs.Preferences;

//The model class stores the current state of all data that needs to be exchanged between the GUI and the controller
//The model also does any necessary conversions such as beta to T calculations
//The model also saves values in default and loads those values on startup
public final class Pref_and_data {
	//Default values
	//Panel
	private static final double DEFAULTSLOPE = 1.7; //slope in line fitted to dial angle vs. dial percent
	private static final double DEFAULTOFFSET = 25; //Y-axis offset in line fitted to dial angle vs. dial percent
	private static final double DEFAULTPERCENT = -100; //Value flags dial as N/A
	private static final double DEFAULTANGLE = 270; //Default angle for dial - position dial takes when not connected
	private static final String[] TOGGLEPOSITIONS = {"Manual", "Auto"}; //Names of positions for toggle switch
	private static final byte FAULTLED = 4; //Alarm to alert to warning temperature (0=false, 4=true) 
	private static final byte FAULTVOLUME = 127; //Volume of alarm to alert to fault temperature (0 = min, 127 = max);
	private static final byte STARTVOLUME = 10; //Volume of short tone upon initializing (0 = min, 127 = max);
	
	//Temperature
	private static final double[] MINTEMP = {10, 10, 10}; //Minimum temperature for GUI thermometers - 0-input, 1-output, 2-external
	private static final double[] WARNTEMP = {50, 50, 50}; //Temperature at which overheat warning starts - also temp that device has to recover to before turning back on after fault - 0-input, 1-output, 2-external
	private static final double[] FAULTTEMP = {80, 80, 80}; //Temperature at which driver automatically shuts off - this is also max temp for gui thermometers - 0-input, 1-output, 2-external
	private static final double INITIALTEMP = -9999; //Initialize temps at impossible reading to flag that no reading had been made yet
	private static final double[] DEFAULTTEMP = {INITIALTEMP, INITIALTEMP, INITIALTEMP}; //Input temperature sensor - initialize to impossible value - 0-input, 1-output, 2-external
    private static final double[] DEFAULTBETA = {3470, 3470, 3470}; //Beta coefficient of input temperature sensor - 0-input, 1-output, 2-externa
    private static final double[] DEFAULTRO = {10000, 10000, 10000}; //Ro of input temperature sensor - 0-input, 1-output, 2-external
    private static final double[] DEFAULTTO = {25, 25, 25}; //Temperature at Ro (in oC) of input temperature sensor - 0-input, 1-output, 2-external
    private static final double TEMPWINDOW = 2; //Size of sliding window used to smooth sensor jitter
    private static final double TEMPHISTORESIS = 0.5; //How much temperature has to change to refresh display (in degrees C)
    private static final double DIALHISTORESIS = 0.5; //How much knob has to change to refresh display (in percent)
    private static final double SERIESR = 4700; //Value in ohms of resistor in series with thermistors
    private static final int ADCMIN = 250; //Maximum valid value on raw temp ADC readings - equal to -40oC
    private static final int FANMINTEMP = 140; //LED temp at which the PWM fan runs at minimum speed, - default to room temp (25oC = 173 on 8-bit ADC)
    private static final int FANMAXTEMP = 118; //LED temp above which the PWM fan runs at maximum speed, - default to warn temp  
    private static final int PWMFAN = 0; //Digital I/O as PWM fan controller (0=N/A, 1=on)
    private static final int FANPIN = 0; //Which digital ouput to use to drive the fan (0=N/A, 32=I/O 1, 64=I/O 2)
	private static final double[] DEFAULTSTATUS = new double[] {INITIALTEMP,INITIALTEMP,INITIALTEMP,DEFAULTPERCENT, DEFAULTANGLE, -1,-1}; //Initialize status array to impossible values
    
    //Serial
    private static final byte STARTBYTE = 0; //Identifies start of packet
    private static final int BAUDRATE = 250000; //Baud rate of serial communication
    private static final String PREFERREDPORT = null; //Set preferred port to null flagging that no preferred port is selected
	private static final int INITIALREADWAIT = 3000; //Time to wait for receiving entire packet during initialization
	private static final int INITIALSENDWAIT = INITIALREADWAIT; //Time to wait for sending entire packet during initialization
	private static final int RUNREADWAIT = 200; //Update rate when GUI is running
	private static final int RUNSENDWAIT = RUNREADWAIT; //Time to wait for sending entire packet
	private static final int HEADERLENGTH = 4; //Number of bytes in header of serial packet
    private static final int IDPACKET = 1; //Identifies packet as device identification packet
    private static final int STATUSPACKET = 6; //Identifies packet as driver status (temp, panel)
    private static final int FAULTPACKET = 10; //Identifies packet as command that driver is in fault, or to command driver to enter fault (i.e. fault test)
    private static final int RESETPACKET = 11; //Command to driver to move to first line of code (address 0) - soft restart
    private static final int DISCONNECTPACKET = 12; //Command to driver to enter disconnect status
    private static final int SETUPPACKET = 31; //Identifies packet as receiving setup configuration information - also is number of data bytes in packet
    private static final int WAVEPACKET = HEADERLENGTH + 250; //Identifies packet as recorded analog waveform
    private static final int CONNECTRETRY = 3; //Number of times to retry a connection to a driver before disconnecting - needs to be less than Arduino retry
    
    //Sync:
    private static final int DELAY1 = 0; //Delay from trigger to LED trigger state
    private static final int DELAY2 = 0; //Delay from delay 1 to LED standby state
    private static final int ATHRESHOLD = 0; //Threshold for analog trigger
    private static final int DELAYORDER = 0; //Order of delays before trigger (0 = LED starts off, 1 = LED starts on);
    private static final int DELAYUNITS = 0; //us or ms delay - confocal sync will always use us - us is also capped at 16383.
    private static final int TRIGGER = 0; //trigger (0=toggle, 1=analog, 2=digital - confocal uses separate digital to trigger syncing)
    private static final int ANALOGSEL = 3; //(analog select (3 = diode, 4 = raw) 
    private static final int SYNCTYPE = 0; //sync type (0=regular, 1=confocal sync (pipeline syncs through fast routines)
    private static final int DTRIGGERPOL = 0; //digital trigger polarity (0 = Low, 1 = High)
    private static final int ATRIGGERPOL = 0; //analog trigger polarity (0 = Rising, 1 = Falling)
    private static final int SHUTTERTRIGGERPOL = 0; //Shutter trigger polarity (0 = Low, 1 = High) - only used for confocal syncs
    private static final int LEDSOURCE = 0; //LED intensity signal source (0 = Ext source, 1 = AWG source)
    private static final int TRIGHOLD = 0; //trigger hold (0 = single shot, 1 = repeat until trigger resets),
    private static final int AWGSOURCE = 0; //AWG source (0=rxPacket, 1=mirror the intensity knob),  
    private static final int SYNCOUT = 0; //Digital I/O 2 as sync out (0=false, 64=true),
    
    //--Standard packets
	private static final byte[] DISCONNECTPACKETARRAY = new byte[] {STARTBYTE, DISCONNECTPACKET, HEADERLENGTH+1, DISCONNECTPACKET, DISCONNECTPACKET};   
    
    //Preference keys
    //Panel
    private static final String SLOPEID = "Dial Slope";
    private static final String OFFSETID = "Dial Offset";
    private static final String ANGLEID = "Dial Angle";
    private static final String TOGGLE0ID = "Toggle 0";
    private static final String TOGGLE1ID = "Toggle 1";
    private static final String FAULTLEDID = "Fault LED";
    private static final String FAULTVOLUMEID = "Fault Volume";
    private static final String STARTVOLUMEID = "Start Volume";
    //Temperature
    private static final String MINID = "Minimum Temp";
    private static final String WARNID = "Warning Temp";
    private static final String FAULTID = "Fault Temp";
    private static final String BETAID = "Beta";
    private static final String ROID = "Ro";
    private static final String TOID = "To";
    private static final String TWINDOWID = "Temp Window";
    private static final String THISTID = "Temp Historesis";
    private static final String DHISTID = "Dial Historesis";
    private static final String ADCMINID = "Minimum ADC";
    private static final String FANMINTEMPID = "Fan min temp";
    private static final String FANMAXTEMPID = "Fan max temp";
    private static final String PWMFANID = "Fan output";
    private static final String FANPINID = "Fan pin";
    //Serial
    private static final String BAUDID = "Baud rate";
    private static final String PORTID = "Preferred port";
	private static final String INITIALREADWAITID = "Initial read wait";
	private static final String INITIALSENDWAITID = "Initial send wait"; 
	private static final String RUNREADWAITID = "Run read wait";
	private static final String RUNSENDWAITID = "Run send wait"; 
    //Sync:
    private static final String DELAY1ID = "Delay 1";
    private static final String DELAY2ID = "Delay 2";
    private static final String ATHRESHOLDID = "Analog Threshold";
    private static final String DELAYORDERID = "Delay order";
    private static final String DELAYUNITSID = "Delay units";
    private static final String TRIGGERID = "Trigger type";
    private static final String ANALOGSELID = "Analog input pin";
    private static final String SYNCTYPEID = "Sync type";
    private static final String DTRIGGERPOLID = "Digital polarity";
    private static final String ATRIGGERPOLID = "Analog polarity";
    private static final String SHUTTERTRIGGERPOLID = "Shutter polarity";
    private static final String LEDSOURCEID = "LED input";
    private static final String TRIGHOLDID = "Trigger hold";
    private static final String AWGSOURCEID = "AWG Source";
    private static final String SYNCOUTID = "Sync output";
    
    //Initialize variables to store model data
	private GUI_temp_and_panel gui; //Instance of GUI so display can be updated
	private Serial serial; //Instance of serial port communication
    private boolean initializeComplete; //State of initialization of connection
    private double[] statusArray = DEFAULTSTATUS; //Initialize status array to impossible values
    
    //Panel variables
	private double currentPercent; //Position of dial in percent currently displayed on GUI
	private double newPercent; //Most recent recorded position of dial in percent
	private double dialAngle; //Most recent recorded position of dial in percent
	private double defaultAngle; //Angle the dial should go to when disconnected
	private double dialSlope; //Slope of line fitted to dial angle vs. dial percent
	private double dialOffset; //Offset of line fitted to dial angle vs. dial percent
	private String[] togglePositions = new String[2]; //Stores names of toggle positions
	private boolean currentToggle; //Current position of toggle switch
	private int faultLED; //Alarm to alert to warning temperature (0=false, 4=true) 
	private int faultVolume; //Volume of alarm to alert to fault temperature (0 = min, 127 = max);
	private int startVolume; //Volume of short tone upon initializing (0 = min, 127 = max);
    //Temperature variables
	private double[] minTemp; //Minimum temperature for GUI thermometers - 0-input, 1-output, 2-external
	private double[] warnTemp; //Temperature at which overheat warning starts - this is also max temp for gui thermometers - 0-input, 1-output, 2-external
	private double[] faultTemp; //Temperature at which driver automatically shuts off - 0-input, 1-output, 2-external
    private double[] currentTemp; //Temperature sensor reading currently being displayed in GUI - 0-input, 1-output, 2-external
    private double[] newTemp; //Most recent temperature reading from driver - 0-input, 1-output, 2-external
    private double[] beta; //Beta coefficient of temperature sensors - 0-input, 1-output, 2-external
    private double[] Ro; //Ro of input temperature sensors - 0-input, 1-output, 2-external
    private double[] To; //Temperature at Ro (in oC) of input temperature sensor - 0-input, 1-output, 2-external
    private double tWindow; //Size of sliding window used to smooth sensor jitter
    private double tHist; //How much temperature has to change to refresh display (in degrees C)
    private double dHist; //How much knob has to change to refresh display (in percent)
    private int adcMin; //Minimum valid value on raw temp ADC readings - noise floor on readings that should be 0
    private int fanMinTemp; //LED temp at which the PWM fan runs at minimum speed, - default to room temp (25oC = 173 on 8-bit ADC)
    private int fanMaxTemp; //LED temp above which the PWM fan runs at maximum speed, - default to warn temp  
    private int pwmFan; //Digital I/O as PWM fan controller (0=N/A, 1=on)
    private int fanPin; //Which digital ouput to use to drive the fan (0=N/A, 32=I/O 1, 64=I/O 2)
    //Serial variables
    private int baudRate; //Baud rate of serial communication
    private String preferredPort; //String containing name of preferred port (not port object itself)
    private int nArduino = 0; //Number of driver devices connected to the computer
    private byte[] packetArray = new byte[252]; //Array for storing the data packet contents (256 bytes - 4 byte header)
    private int packetID = 0; //Packet ID: 1-ID packet, 2-temperature packet, 3-panel packet, 4-waveform packet 
    private int packetLength = 0; //length of the packet
    private int checkSum = 0; //packet checksum
	private int initialReadWait; //Time to wait for receiving entire packet during initialization
	private int initialSendWait; //Time to wait for sending entire packet during initialization
	private int runReadWait; //Update rate while GUI is running
	private int runSendWait; //Time to wait for sending entire packet
	private int rxStart = 0; //Index for start of packet in rx buffer
	private int rxIndex = 0; //Current position 
	private byte[] rxBuffer = new byte[1024]; //Circular buffer for storing the rx serial stream
	private byte[] preferencePacket = new byte[SETUPPACKET+HEADERLENGTH]; //Array for storing the prefence packet to check against driver version
	private int connectCount = 0; //Number of attempts at connecting to driver
	private String currentID; //ID of device that is currently connected
    //Sync:
    private int delay1; //Delay from trigger to LED trigger state
    private int delay2; //Delay from delay 1 to LED standby state
    private int aThreshold; //Threshold for analog trigger
    private int delayOrder; //Order of delays before trigger (0 = LED starts off, 1 = LED starts on);
    private int delayUnits; //us or ms delay - confocal sync will always use us - us is also capped at 16383.
    private int trigger; //trigger (0=toggle, 1=analog, 2=digital - confocal uses separate digital to trigger syncing)
    private int analogSel; //(analog select (3 = diode, 4 = raw) 
    private int syncType; //sync type (0=regular, 1=confocal sync (pipeline syncs through fast routines)
    private int dTriggerPol; //digital trigger polarity (0 = Low, 1 = High)
    private int aTriggerPol; //analog trigger polarity (0 = Rising, 1 = Falling)
    private int shutterTriggerPol; //Shutter trigger polarity (0 = Low, 1 = High) - only used for confocal syncs
    private int ledSource; //LED intensity signal source (0 = Ext source, 1 = AWG source)
    private int trigHold; //trigger hold (0 = single shot, 1 = repeat until trigger resets),
    private int awgSource; //AWG source (0=rxPacket, 1=mirror the intensity knob),   
    private int syncOut; //Digital I/O 2 as sync out (0=false, 64=true),
	

	//Initialize a preferences file in the model class - this will allow user settings to be saved and loaded when program loads
	Preferences prefs = Preferences.userNodeForPackage(edu.berkeley.MHz_LED_Modulator_v2b.Pref_and_data.class);

	public Pref_and_data(){
		initializeComplete = false; //On boot of model - reset the initialize flag to false 
		currentToggle = false; //Initialize the toggle switch to a state (either state can be initial state);
		initialize();
	}
	
    public void setModules(GUI_temp_and_panel gui, Serial serial) {
    	this.gui = gui;
    	this.serial = serial;
    }
    
    public void shareConstants() {
    	gui.setConstants(minTemp, warnTemp, faultTemp, DEFAULTTEMP, TOGGLEPOSITIONS, defaultAngle, DEFAULTPERCENT, DEFAULTSTATUS);
    	serial.setConstants(baudRate, preferredPort, initialReadWait, initialSendWait, HEADERLENGTH, DISCONNECTPACKETARRAY);
    }
//    public void setControllerConstants() {
//    	controller.getModelConstants(IDPACKET, TEMPPACKET, PANELPACKET, WAVEPACKET, initializeComplete);
//    }

/////////////////////////////PREFERENCES//////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	//Load model values from preferences
	public void initialize() {
		//Panel
		dialSlope = prefs.getDouble(SLOPEID, DEFAULTSLOPE);
		dialOffset = prefs.getDouble(OFFSETID, DEFAULTOFFSET);
		dialAngle = prefs.getDouble(ANGLEID, DEFAULTANGLE);
		defaultAngle = prefs.getDouble(ANGLEID, DEFAULTANGLE);
		currentPercent = DEFAULTPERCENT;
		newPercent = DEFAULTPERCENT;
		togglePositions[0] = prefs.get(TOGGLE0ID, TOGGLEPOSITIONS[0]);
		togglePositions[1] = prefs.get(TOGGLE1ID, TOGGLEPOSITIONS[1]);
		faultLED = prefs.getInt(FAULTLEDID, FAULTLED);
		faultVolume = prefs.getInt(FAULTVOLUMEID, FAULTVOLUME);
		startVolume = prefs.getInt(STARTVOLUMEID, STARTVOLUME);

		//Temperature
		statusArray = DEFAULTSTATUS;
		minTemp = stringToDoubleArray(prefs.get(MINID, doubleArrayToString(MINTEMP)));
		warnTemp = stringToDoubleArray(prefs.get(WARNID, doubleArrayToString(WARNTEMP)));
		faultTemp = stringToDoubleArray(prefs.get(FAULTID, doubleArrayToString(FAULTTEMP)));
		currentTemp = DEFAULTTEMP; //Initialize temp readings to impossible default to flag that no recording has been made
		newTemp = DEFAULTTEMP;
		beta = stringToDoubleArray(prefs.get(BETAID, doubleArrayToString(DEFAULTBETA)));
		Ro = stringToDoubleArray(prefs.get(ROID, doubleArrayToString(DEFAULTRO)));
		To = stringToDoubleArray(prefs.get(TOID, doubleArrayToString(DEFAULTTO)));
		tWindow = prefs.getDouble(TWINDOWID, TEMPWINDOW);
		tHist = prefs.getDouble(THISTID, TEMPHISTORESIS);
		dHist = prefs.getDouble(DHISTID, DIALHISTORESIS);
		adcMin = prefs.getInt(ADCMINID, ADCMIN);
	    fanMinTemp = prefs.getInt(FANMINTEMPID, FANMINTEMP); 
	    fanMaxTemp = prefs.getInt(FANMAXTEMPID, FANMAXTEMP); 
	    pwmFan = prefs.getInt(PWMFANID, PWMFAN); 
	    fanPin = prefs.getInt(FANPINID, FANPIN); 
		
		//Serial
		baudRate = prefs.getInt(BAUDID, BAUDRATE);
		preferredPort = prefs.get(PORTID, PREFERREDPORT);
		initialReadWait = prefs.getInt(INITIALREADWAITID, INITIALREADWAIT);
		initialSendWait = prefs.getInt(INITIALSENDWAITID, INITIALSENDWAIT);
		runReadWait = prefs.getInt(RUNREADWAITID, RUNREADWAIT);
		runSendWait = prefs.getInt(RUNSENDWAITID, RUNSENDWAIT);
		
	    //Sync:
	    delay1 = prefs.getInt(DELAY1ID, DELAY1);
	    delay2 = prefs.getInt(DELAY2ID, DELAY2);
	    aThreshold = prefs.getInt(ATHRESHOLDID, ATHRESHOLD);
	    delayOrder = prefs.getInt(DELAYORDERID, DELAYORDER);
	    delayUnits = prefs.getInt(DELAYUNITSID, DELAYUNITS);
	    trigger = prefs.getInt(TRIGGERID, TRIGGER);
	    analogSel = prefs.getInt(ANALOGSELID, ANALOGSEL);
	    syncType = prefs.getInt(SYNCTYPEID, SYNCTYPE);
	    dTriggerPol = prefs.getInt(DTRIGGERPOLID, DTRIGGERPOL);
	    aTriggerPol = prefs.getInt(ATRIGGERPOLID, ATRIGGERPOL);
	    shutterTriggerPol = prefs.getInt(SHUTTERTRIGGERPOLID, SHUTTERTRIGGERPOL);
	    shutterTriggerPol = prefs.getInt(SHUTTERTRIGGERPOLID, SHUTTERTRIGGERPOL);
	    ledSource = prefs.getInt(LEDSOURCEID, LEDSOURCE);
	    trigHold = prefs.getInt(TRIGHOLDID, TRIGHOLD);
	    awgSource = prefs.getInt(AWGSOURCEID, AWGSOURCE);
	    syncOut = prefs.getInt(SYNCOUTID, SYNCOUT);	
	}
	
	public void restoreDefaults() {
		//Reset preferences to default values
		//Panel
		prefs.putDouble(SLOPEID, DEFAULTSLOPE);
		prefs.putDouble(OFFSETID, DEFAULTOFFSET);
		prefs.putDouble(ANGLEID, DEFAULTANGLE);
		prefs.putDouble(ANGLEID, DEFAULTANGLE);
		currentPercent = DEFAULTPERCENT;
		newPercent = DEFAULTPERCENT;
		prefs.put(TOGGLE0ID, TOGGLEPOSITIONS[0]);
		prefs.put(TOGGLE1ID, TOGGLEPOSITIONS[1]);
		prefs.putInt(FAULTLEDID, FAULTLED);
		prefs.putInt(FAULTVOLUMEID, FAULTVOLUME);
		prefs.putInt(STARTVOLUMEID, STARTVOLUME);

		//Temperature
		statusArray = DEFAULTSTATUS;
		prefs.put(MINID, doubleArrayToString(MINTEMP));
		prefs.put(WARNID, doubleArrayToString(WARNTEMP));
		prefs.put(FAULTID, doubleArrayToString(FAULTTEMP));
		currentTemp = DEFAULTTEMP; //Initialize temp readings to impossible default to flag that no recording has been made
		newTemp = DEFAULTTEMP;
		prefs.put(BETAID, doubleArrayToString(DEFAULTBETA));
		prefs.put(ROID, doubleArrayToString(DEFAULTRO));
		prefs.put(TOID, doubleArrayToString(DEFAULTTO));
		prefs.putDouble(TWINDOWID, TEMPWINDOW);
		prefs.putDouble(THISTID, TEMPHISTORESIS);
		prefs.putDouble(DHISTID, DIALHISTORESIS);
		prefs.putInt(ADCMINID, ADCMIN);
		prefs.putInt(FANMINTEMPID, FANMINTEMP); 
		prefs.putInt(FANMAXTEMPID, FANMAXTEMP); 
		prefs.putInt(PWMFANID, PWMFAN); 
		prefs.putInt(FANPINID, FANPIN); 
		
		//Serial
		prefs.putInt(BAUDID, BAUDRATE);
		prefs.put(PORTID, PREFERREDPORT);
		prefs.putInt(INITIALREADWAITID, INITIALREADWAIT);
		prefs.putInt(INITIALSENDWAITID, INITIALSENDWAIT);
		prefs.putInt(RUNREADWAITID, RUNREADWAIT);
		prefs.putInt(RUNSENDWAITID, RUNSENDWAIT);
		
	    //Sync:
		prefs.putInt(DELAY1ID, DELAY1);
		prefs.putInt(DELAY2ID, DELAY2);
		prefs.putInt(ATHRESHOLDID, ATHRESHOLD);
		prefs.putInt(DELAYORDERID, DELAYORDER);
		prefs.putInt(DELAYUNITSID, DELAYUNITS);
		prefs.putInt(TRIGGERID, TRIGGER);
		prefs.putInt(ANALOGSELID, ANALOGSEL);
		prefs.putInt(SYNCTYPEID, SYNCTYPE);
		prefs.putInt(DTRIGGERPOLID, DTRIGGERPOL);
		prefs.putInt(ATRIGGERPOLID, ATRIGGERPOL);
		prefs.putInt(SHUTTERTRIGGERPOLID, SHUTTERTRIGGERPOL);
		prefs.putInt(LEDSOURCEID, LEDSOURCE);
		prefs.putInt(TRIGHOLDID, TRIGHOLD);
		prefs.putInt(AWGSOURCEID, AWGSOURCE);
		prefs.putInt(SYNCOUTID, SYNCOUT);	
		
		//Re-initialize to enact default values
		initialize();
		shareConstants();
	}
	
	//String strategy from: https://stackoverflow.com/questions/22698751/save-an-array-of-booleans-using-shared-preference
	private String doubleArrayToString(double[] array) {
		String string = ""; //Initialize empty string
		for(int a=0; a<array.length; a++) {
			string = string + Double.toString(array[a]) + "|$|SEPARATOR|$|"; //Concatenate doubles into single string with safe separator
		}
		return string;
	}
	
	private double[] stringToDoubleArray(String string) {
		String[] stringArray = string.split("\\|\\$\\|SEPARATOR\\|\\$\\|"); //Split concatenated string into discrete units
		double[] doubleArray = new double[stringArray.length];  //Initialize double array to store results
		for(int a=0; a<stringArray.length; a++) {
			doubleArray[a] = Double.parseDouble(stringArray[a]);
		}
		return doubleArray;
	}
	
///////////////////////////////////////SERIAL//////////////////////////////////////////////////////////////////////////////////////////////////	
	public boolean parseSerial(byte[] readBuffer, int readLength) {
		boolean packetFound = false;
		int a = 0;
		int b = 0;
		
		//Load most recent stream into the rxBuffer
		for(a = 0; a<readLength; a++) {
			rxBuffer[rxIndex++] = readBuffer[a];
			rxIndex %= rxBuffer.length; //If end of buffer is reached loop to beginning to create circular buffer
		}
		
		//Search entire buffer for all valid packets
	    for(a = rxStart; a != Math.floorMod(rxIndex, rxBuffer.length); a=(a+1)%rxBuffer.length) { //Search circular buffer for packet
	    	System.out.println(a + " " + Math.floorMod((rxIndex-HEADERLENGTH-1), rxBuffer.length));
	    	if(rxBuffer[a] == STARTBYTE) { //Search for startbyte
	    		//Extract header bytes and convert uint8_t to int (variable & 0xFF) - https://stackoverflow.com/questions/14071361/java-how-to-parse-uint8-in-java 
	    		packetID = rxBuffer[(a+1)%rxBuffer.length] & 0xFF; //Packet ID
	    		packetLength = rxBuffer[(a+2)%rxBuffer.length] & 0xFF; //length of the packet
	    		checkSum = 0; //Initialize checksum to 0
	    		
	    		if(packetID > 0 && packetLength > HEADERLENGTH && Math.floorMod((rxIndex - a), rxBuffer.length) >= packetLength) { //Verify that ID and length are valid, and packet fits in remainder of buffer (i.e. is not a fragment)
	    			packetArray = new byte[packetLength-HEADERLENGTH]; //Resize packet array to match size of packet
		    		
	    			//Copy putative packet starting at end of header and calculate the checksum
		    		for(b=0; b<(packetLength-HEADERLENGTH); b++){
		    			packetArray[b] = rxBuffer[(b+a+HEADERLENGTH)%rxBuffer.length];
		    			checkSum += packetArray[b] & 0xFF;
		    		}
System.out.println("Packet ID: " + packetID + ", Packet Length: " + packetLength + ", Checksums: " + (checkSum % 256) + " " + (rxBuffer[(a+3)%rxBuffer.length] & 0xFF) + ", packet end = " + Math.floorMod((a + packetLength), rxBuffer.length) + ", buffer end = " + rxIndex);
	        		if((checkSum % 256) == (rxBuffer[(a+3)%rxBuffer.length] & 0xFF)) { //See if checksum matches checksum in datapacket
	        			//If checksum is valid then valid packet structure - convert packet to int array and send to GUI
	        			packetFound = false;
	        			packetFound = packetProcessor(packetArray, packetID);
	        			
	        			//Move buffer start index to end of packet
	        			if(packetFound) {
		        			rxStart = (a+packetLength)%rxBuffer.length;
		        			a = rxStart-1;
	        			}
	        		}
	        		else {
System.out.println("INVALID PACKET-------------------------------------------------------------------------------------------------------------------");
	        		}
	    		}
	    	}

	    	if(!initializeComplete && packetFound) {
	    		
////NOTE: Install handshake code here to exchange critical parameters with arduino such as fault temps, etc.+++++++++++++++++++++++++++++++++++++	    		    	
//	    		serial.reply(new byte[] {CONFIRMBYTE, headerArray[2]}); //Tell Arduino that it's ID was found and to boot into loop
	    		nArduino++; //Add one to the number of devices found
	    		break; //If device was initializing and ID packet was found, stop looking for more packets
	    	}
	    }
	    return packetFound;
	}
	
	public int getNarduino() {
		return nArduino;
	}
	
	public boolean packetProcessor(byte[] packet, int packetID) {
		switch (packetID) {
			case IDPACKET: return updateID(packet);
			case STATUSPACKET: return updateStatus(packet);
			case FAULTPACKET: return updateFault(packet);
			case RESETPACKET: return sendReset(packet);
			case DISCONNECTPACKET: return sendDisconnect(packet);
			case SETUPPACKET: return confirmSetup(packet);
			case WAVEPACKET: return updateWave(packet);
			default: return false; // If the packet ID is invalid, return false
		}
    }
	
	public void initializeFinished() {
		initializeComplete = true;
	}
///////////////////////////////////////////////////ID//////////////////////////////////////////////////////////////////////////////////////////	
	private boolean updateID(byte[] packetArray) {
    	//Only add to menu during initialization
    	if(!initializeComplete) {
System.out.println("ID Buffer: " + Arrays.toString(packetArray));
    		String ID = new String(packetArray);
    		gui.addMenuItem(ID);
System.out.println(ID);
    		return true;
    	}
    	else { //Otherwise, ID packet means device is now connected, so send and verify prefs, then adjust serial speed to live update rate    		
    		currentID = new String(packetArray);
System.out.println(currentID);
			serial.setSerialDelay(runReadWait, runSendWait); //Speed up streaming now that initialization is complete
    		sendPreferencePacket();
    		return true;
    	}
    }
	
	private void sendPreferencePacket() {
		//Send single STARTBYTE to confirm receipt of ID and start of SETUP transfer
		serial.reply(new byte[] {STARTBYTE});
		gui.updateProgress(66, "Validating setup packet of: " + currentID);
		byte[] onDelayArray = ByteBuffer.allocate(4).putInt(delay1).array();
		byte[] offDelayArray = ByteBuffer.allocate(4).putInt(delay2).array();
		connectCount = 0; //Reset the counter for number of reconnect attempts
		
		preferencePacket = new byte[] {
			STARTBYTE,
			SETUPPACKET,
			SETUPPACKET+HEADERLENGTH,
			STARTBYTE, //Place holder for checksum - will be calculated after rest of packet is assembled
			CelciustoADC(WARNTEMP[0], 0),
			CelciustoADC(WARNTEMP[1], 1),
			CelciustoADC(WARNTEMP[2], 2),
			CelciustoADC(FAULTTEMP[0], 0),
			CelciustoADC(FAULTTEMP[1], 1),
			CelciustoADC(FAULTTEMP[2], 2),
			onDelayArray[2],
			onDelayArray[3],
			offDelayArray[2],
			offDelayArray[3],
			(byte) delayOrder,
			(byte) delayUnits,
			(byte) fanMinTemp,
			(byte) fanMaxTemp,
			(byte) trigger,
			(byte) analogSel,
			(byte) faultLED,
			(byte) faultVolume,
			(byte) startVolume,
			(byte) pwmFan,
			(byte) fanPin,
			(byte) syncType,
			(byte) dTriggerPol,
			(byte) aTriggerPol,
			(byte) ledSource,
			(byte) trigHold,
			(byte) awgSource,
			(byte) syncOut
		};
	
		//Calculate checksum of packet
		checkSum = 0;
		for(int a = HEADERLENGTH; a<preferencePacket.length; a++) checkSum += preferencePacket[a] & 0xFF; 
		preferencePacket[3] = (byte) checkSum;

		//Send setup packet
		serial.reply(preferencePacket);
	}
	
	//Verify the setup of the driver
	private boolean confirmSetup(byte[] packetArray) {
		if(initializeComplete) {
			gui.updateProgress(99, "Validating driver setup packet...");
			boolean confirm = false;		
			//verify each setup parameter against the packet
			if(packetLength == SETUPPACKET + HEADERLENGTH) {
				for(int a=0; a<SETUPPACKET; a++) {
					System.out.println(packetArray[a] + " " + preferencePacket[a+HEADERLENGTH]);
					if(packetArray[a] == preferencePacket[a+HEADERLENGTH]) {
						confirm = true;
						gui.updateProgress(0, "Connected to: " + currentID);
					}
					else confirm = false;
				}
			}
			
			//If packet is invalid, reset the arduino and retry connection;
			if(!confirm) {
				if(connectCount++ < CONNECTRETRY) {
					int progress = (int) Math.round(100D*((double) connectCount/(double) CONNECTRETRY));
					String message = "Re-connection attempt: " + connectCount + " of " + CONNECTRETRY;
					serial.connectDevice(gui.getGroup());
				}
				else {
					serial.disconnect();
				}
			}
			return confirm;
		}
		else return false;
	}
//////////////////////////////////////STATUS////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    public boolean updateStatus(byte[] packetArray) {
    	//Only read packet if device is initialized
    	if(initializeComplete) {
System.out.println("Status Buffer: " + Arrays.toString(packetArray)); 
    		//Extract temperature bytes and convert to double
    		for(int a=0; a<3; a++) {
    			double temp = ADCtoCelcius(packetArray[a], a); //Convert ADC reading to temperature in oC
    			if(statusArray[a] == INITIALTEMP) statusArray[a] = temp; //If this is the first reading - simply load values
    			else statusArray[a] = temp/tWindow + statusArray[a] * ((tWindow-1)/tWindow); //Otherwise use sliding window
    			
    			//Check if current reading should be sent to GUI - i.e. has significantly changed
    			if(statusArray[a] > (currentTemp[a] + tHist) || statusArray[a] < (currentTemp[a] - tHist)) { 
    				currentTemp[a] = statusArray[a];				
    	    	}
    			else; //Otherwise keep current value to reduce thermometer jitter
    		}
 	    	double dialADC = (double) (packetArray[3] & 0xFF);
	     	newPercent = dialADC/255D*100D;
	       	dialAngle = (newPercent*dialSlope)+dialOffset;
	       	
	       	//If dial has sufficiently changed, or is at 0 or 100, then update GUI
	       	if(newPercent > (currentPercent + dHist) || newPercent< (currentPercent - dHist) || newPercent == 0 || newPercent == 100) {
	       		currentPercent = newPercent;
	       		statusArray[3] = newPercent;
	       		statusArray[4] = dialAngle;
	       	}
	       	else; //Otherwise keep current value to reduce dial jitter
	       	
	       	statusArray[5] = packetArray[4] & 0xFF; //Get sync status
	       	statusArray[6] = packetArray[5] & 0xFF; //Get toggle status
System.out.println("Status Send: " + Arrays.toString(statusArray));
	       	gui.updateStatus(statusArray);
       	
	       	return true;
    	}
    	else return false;
    }
	
//////////////////////////////////////TEMPERATURE//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
    private double ADCtoCelcius(byte adcByte, int a) {
    	double adcDouble = (double) (adcByte & 0xFF); //Convert unsigned byte to double
    	double conversion = INITIALTEMP; //Initialize temp to impossible value to flag if conversion was not done
    	
    	if(adcDouble < adcMin) {   //Minimum threshold for valid ADC recording  	
	    	//Math from: https://learn.adafruit.com/thermistor/using-a-thermistor
	    	conversion = (-1*SERIESR*adcDouble) / (adcDouble-255D);
	    	conversion = conversion/Ro[a];
	    	conversion = Math.log(conversion);
	    	conversion /= beta[a];
	    	conversion += 1D/(To[a]+273.15D);
	    	conversion = 1D/conversion;
	    	conversion -= 273.15D;
    	}
     	return conversion;
    }
    
    private byte CelciustoADC(double temp, int a) {
    	byte adcByte = 0;
    	
    	temp += 273.15;
    	temp = 1D/temp;
    	temp -= 1D/(To[a]+273.15D);
    	temp *= beta[a];
    	temp = Math.exp(temp);
    	temp *= Ro[a];
    	temp = temp*255/(SERIESR+temp);
        adcByte = (byte) Math.round(temp);
    	 
    	
    	return adcByte;
    }
///////////////////////////////////////WAVE///////////////////////////////////////////////////////////////////////////////////////////////////
    private boolean updateFault(byte[] packetArray) {
    	return false;
    }
    private boolean sendReset(byte[] packetArray) {
    	return false;
    }
    private boolean sendDisconnect(byte[] packetArray) {
    	return false;
    }
    private boolean updateWave(byte[] packetArray) {
    	return false;
    }
}
