package edu.berkeley.MHz_LED_Modulator_v2b;

import java.util.prefs.Preferences;

//The model class stores the current state of all data that needs to be exchanged between the GUI and the controller
//The model also does any necessary conversions such as beta to T calculations
//The model also saves values in default and loads those values on startup
public final class Model {
	//Default values
	//Panel
	private static final double DEFAULTSLOPE = 1.7;
	private static final double DEFAULTOFFSET = 25;
	private static final double DEFAULTPERCENT = -100;
	private static final double DEFAULTANGLE = 270;
	private static final String[] TOGGLEPOSITIONS = {"Manual", "Auto"};
	//Temperature
	private static final double INITIALTEMP = -9999; //Initialize temps at impossible reading to flag that no reading had been made yet
    private static final double[] DEFAULTTEMP = {INITIALTEMP, INITIALTEMP, INITIALTEMP}; //Input temperature sensor - initialize to impossible value - 0-input, 1-output, 2-external
    private static final double[] DEFAULTBETA = {3470, 3470, 3470}; //Beta coefficient of input temperature sensor - 0-input, 1-output, 2-externa
    private static final double[] DEFAULTRO = {10000, 10000, 10000}; //Ro of input temperature sensor - 0-input, 1-output, 2-external
    private static final double[] DEFAULTTO = {25, 25, 25}; //Temperature at Ro (in oC) of input temperature sensor - 0-input, 1-output, 2-external
    private static final double TEMPWINDOW = 2; //Size of sliding window used to smooth sensor jitter
    private static final double TEMPHISTORESIS = 0.5; //How much temperature has to change to refresh display (in degrees C)
    private static final double DIALHISTORESIS = 0.5; //How much knob has to change to refresh display (in percent)
    private static final double SERIESR = 4700; //Value in ohms of resistor in series with thermistors
    private static final int ADCMIN = 2; //Minimum valid value on raw temp ADC readings - noise floor on readings that should be 0
    //Serial
    private static final byte IDPACKET = 1; //Identifies packet as device identification packet
    private static final byte TEMPPACKET = 2; //Identifies packet as temperature recordings
    private static final byte PANELPACKET = 3; //Identifies packet as panel status
    private static final byte WAVEPACKET = 4; //Identifies packet as recorded analog waveform
    
    //Preference keys
    //Panel
    private static final String SLOPEID = "Dial Slope";
    private static final String OFFSETID = "Dial Offset";
    private static final String ANGLEID = "Dial Angle";
    //Temperature
    private static final String BETAID = "Beta";
    private static final String ROID = "Ro";
    private static final String TOID = "To";
    private static final String TWINDOWID = "Temp Window";
    private static final String THISTID = "Temp Historesis";
    private static final String DHISTID = "Dial Historesis";
    private static final String ADCMINID = "Minimum ADC";
    
    //Initialize variables to store model data
	private Controller controller; //Instance of controller so events can be passed back to controller
    private boolean initializeComplete; //State of initialization of connection
    //Panel variables
	private double currentPercent; //Position of dial in percent currently displayed on GUI
	private double newPercent; //Most recent recorded position of dial in percent
	private double dialAngle; //Most recent recorded position of dial in percent
	private double defaultAngle; //Angle the dial should go to when disconnected
	private double dialSlope; //Slope of line fitted to dial angle vs. dial percent
	private double dialOffset; //Offset of line fitted to dial angle vs. dial percent
	private boolean currentToggle; //Current position of toggle switch
    //Temperature variables
    private double[] currentTemp; //Temperature sensor reading currently being displayed in GUI - 0-input, 1-output, 2-external
    private double[] newTemp; //Most recent temperature reading from driver - 0-input, 1-output, 2-external
    private double[] beta; //Beta coefficient of temperature sensors - 0-input, 1-output, 2-external
    private double[] Ro; //Ro of input temperature sensors - 0-input, 1-output, 2-external
    private double[] To; //Temperature at Ro (in oC) of input temperature sensor - 0-input, 1-output, 2-external
    private double tWindow; //Size of sliding window used to smooth sensor jitter
    private double tHist; //How much temperature has to change to refresh display (in degrees C)
    private double dHist; //How much knob has to change to refresh display (in percent)
    private int adcMin; //Minimum valid value on raw temp ADC readings - noise floor on readings that should be 0
    
    
	
	//Initialize a preferences file in the model class - this will allow user settings to be saved and loaded when program loads
	Preferences prefs = Preferences.userNodeForPackage(edu.berkeley.MHz_LED_Modulator_v2b.Model.class);
	public Model(){
		initializeComplete = false; //On boot of model - reset the initialize flag to false 
		currentToggle = false; //Initialize the toggle switch to a state (either state can be initial state);
		initialize();
	}
	
    public void setController(Controller controller) {
    	this.controller = this.controller==null?controller:this.controller; //Only set the controller if it is null (i.e. do not overwrite controller)
    }
    
    public void setControllerConstants() {
    	controller.getModelConstants(IDPACKET, TEMPPACKET, PANELPACKET, WAVEPACKET, initializeComplete);
    }

/////////////////////////////PREFERENCES//////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	//Load model values from preferences
	public void initialize() {
		//Panel
		dialSlope = prefs.getDouble(SLOPEID, DEFAULTSLOPE);
		dialOffset = prefs.getDouble(OFFSETID, DEFAULTOFFSET);
		dialAngle = prefs.getDouble(ANGLEID, DEFAULTANGLE);
		currentPercent = DEFAULTPERCENT;
		newPercent = DEFAULTPERCENT;
		
		//Temperature
		currentTemp = DEFAULTTEMP; //Initialize temp readings to impossible default to flag that no recording has been made
		newTemp = DEFAULTTEMP;
		beta = stringToDoubleArray(prefs.get(BETAID, doubleArrayToString(DEFAULTBETA)));
		Ro = stringToDoubleArray(prefs.get(ROID, doubleArrayToString(DEFAULTRO)));
		To = stringToDoubleArray(prefs.get(TOID, doubleArrayToString(DEFAULTTO)));
		tWindow = prefs.getDouble(TWINDOWID, TEMPWINDOW);
		tHist = prefs.getDouble(THISTID, TEMPHISTORESIS);
		dHist = prefs.getDouble(DHISTID, DIALHISTORESIS);
		adcMin = prefs.getInt(ADCMINID, ADCMIN);
	}
	
	public void restoreDefaults() {
		//Reset preferences to default values
		//Panel
		prefs.putDouble(SLOPEID, DEFAULTSLOPE);
		prefs.putDouble(OFFSETID, DEFAULTOFFSET);
		prefs.putDouble(ANGLEID, DEFAULTANGLE);
		
		//Temperature
		prefs.put(BETAID, doubleArrayToString(DEFAULTBETA));
		prefs.put(ROID, doubleArrayToString(DEFAULTRO));
		prefs.put(TOID, doubleArrayToString(DEFAULTTO));
		prefs.putDouble(TWINDOWID, TEMPWINDOW);
		prefs.putDouble(THISTID, TEMPHISTORESIS);
		prefs.putDouble(DHISTID, DIALHISTORESIS);
		prefs.putInt(ADCMINID, ADCMIN);
		
		//Re-initialize to enact default values
		initialize();
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
//////////////////////////////////////PANEL////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    public boolean[] updatePanel(byte[] packetArray) {
    	boolean[] returnArray = {false, false}; //Initialize array that flags to controller if panel needs to be updated in GUI
    	
    	//Only read packet if device is initialized
    	if(initializeComplete) {
	    	double dialADC = (double) (packetArray[0] & 0xFF);
	     	newPercent = dialADC/255D*100D;
	       	dialAngle = (newPercent*dialSlope)+dialOffset;
	       	
	       	//If dial has sufficiently changed, or is at 0 or 100, then update GUI
	       	if(newPercent > (currentPercent + dHist) || newPercent< (currentPercent - dHist) || newPercent == 0 || newPercent == 100) {
	       		currentPercent = newPercent;
	       		returnArray[0] = true;
	       	}
	       	else;
	       	
	       	//Check if toggle switch position has changed
	       	boolean toggleState = packetArray[1]!=0; //Convert byte to boolean
	       	if(toggleState^currentToggle) { // ^ = XOR - only if values are unequal returns true
	       		currentToggle = toggleState;
	       		returnArray[1] = true;
	       	}   	
    	}
    	return returnArray;
    }
	
//////////////////////////////////////TEMPERATURE//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
    public boolean[] updateTemp(byte[] packetArray) {
    	boolean[] returnArray = {false, false, false}; //Initialize array that flags to controller if temp needs to be updated in GUI
    	
    	//Only read packet if device is initialized
    	if(initializeComplete) {
    		
    		//Extract temperature bytes and convert to double
    		for(int a=0; a<newTemp.length; a++) {
    			double temp = ADCtoCelcius(packetArray[a], a); //Convert ADC reading to temperature in oC
    			if(temp != INITIALTEMP) {  //Check that valid temperature was returned  			
	    			if(newTemp[a] == INITIALTEMP) newTemp[a] = temp; //If this is the first reading - simply load values
	    			else newTemp[a] = temp/tWindow + newTemp[a] * ((tWindow-1)/tWindow); //Otherwise use sliding window
	    			
	    			//Check if current reading should be sent to GUI - i.e. has significantly changed
	    			if(newTemp[a] > (currentTemp[a] + tHist) || newTemp[a] < (currentTemp[a] - tHist)) { 
	    				currentTemp[a] = newTemp[a];
	    				returnArray[a] = true;  				
	    	    	}
    			}
    			else; //Otherwise, skip conversion and leave GUI flag false
    		}
    	}
    	return returnArray;
    }
    
    private double ADCtoCelcius(byte adcByte, int a) {
    	double adcDouble = (double) (adcByte & 0xFF); //Convert unsigned byte to double
    	double conversion = INITIALTEMP; //Initialize temp to impossible value to flag if conversion was not done
    	
    	if(adcDouble > adcMin) {   //Minimum threshold for valid ADC recording  	
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
    

}
