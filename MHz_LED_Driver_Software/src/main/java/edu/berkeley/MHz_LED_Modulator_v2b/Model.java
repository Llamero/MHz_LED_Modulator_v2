package edu.berkeley.MHz_LED_Modulator_v2b;

import java.util.prefs.Preferences;

import javax.swing.JLabel;
import javax.swing.JProgressBar;

//The model class stores the current state of all data that needs to be exchanged between the GUI and the controller
//The model also does any necessary conversions such as beta to T calculations
//The model also saves values in default and loads those values on startup
public class Model {
	//Default values
    private static final double T1 = -9999; //Input temperature sensor - initialize to impossible value
    private static final double T2 = -9999; //Output temperature sensor
    private static final double T3 = -9999; //External temperature sensor
    private static final double B1 = 3470; //Beta coefficient of input temperature sensor
    private static final double B2 = 3470; //Beta coefficient of output temperature sensor
    private static final double B3 = 3470; //Beta coefficient of external temperature sensor
    private static final double R1 = 10000; //Ro of input temperature sensor
    private static final double R2 = 10000; //Ro coefficient of output temperature sensor
    private static final double R3 = 10000; //Ro coefficient of external temperature sensor
    private static final double TEMPWINDOW = 2; //Size of sliding window used to smooth sensor jitter
    private static final double TEMPHISTORESIS = 0.5; //How much temperature has to change to refresh display (in degrees C)
    private static final double DIALHISTORESIS = 0.5; //How much knob has to change to refresh display (in percent)
    private static final double SERIESR = 4700; //Value in ohms of resistor in series with thermistors
    
    //Initialize variables to store 
    private double temp1; //Input temperature sensor - initialize to impossible value
    private double temp2; //Output temperature sensor
    private double temp3; //External temperature sensor
    private double beta1; //Beta coefficient of input temperature sensor
    private double beta2; //Beta coefficient of output temperature sensor
    private double beta3; //Beta coefficient of external temperature sensor
    private double Ro1; //Ro of input temperature sensor
    private double Ro2; //Ro coefficient of output temperature sensor
    private double Ro3; //Ro coefficient of external temperature sensor
    private double tWindow; //Size of sliding window used to smooth sensor jitter
    private double tHist; //How much temperature has to change to refresh display (in degrees C)
    private double dHist; //How much knob has to change to refresh display (in percent)
    private boolean initializeComplete; //State of initialization of connection
	
	//Initialize a preferences file in the model class - this will allow user settings to be saved and loaded when program loads
	Preferences prefs = Preferences.userNodeForPackage(edu.berkeley.MHz_LED_Modulator_v2b.Model.class);
	public Model(){
		reset();
	}
	
	//Load model values from preferences
	public void reset() {
		temp1 = prefs.getDouble("TEMP1", T1);
		temp2 = prefs.getDouble("TEMP2", T2);
		temp3 = prefs.getDouble("TEMP3", T3);
		beta1 = prefs.getDouble("BETA1", B1);
		beta2 = prefs.getDouble("BETA2", B2);
		beta3 = prefs.getDouble("BETA3", B3);
		Ro1 = prefs.getDouble("Ro1", R1);
		Ro2 = prefs.getDouble("Ro2", R2);
		Ro3 = prefs.getDouble("Ro3", R3);
		tWindow = prefs.getDouble("TEMPWINDOW", TEMPWINDOW);
		tHist = prefs.getDouble("TEMPHISTORESIS", TEMPHISTORESIS);
		dHist = prefs.getDouble("DIALHISTORESIS", DIALHISTORESIS);			
	}
	
	private void restoreDefaults() {
		prefs.putDouble("TEMP1", T1);
		prefs.getDouble("TEMP2", T2);
		prefs.getDouble("TEMP3", T3);
		prefs.getDouble("BETA1", B1);
		prefs.getDouble("BETA2", B2);
		prefs.getDouble("BETA3", B3);
		prefs.getDouble("Ro1", R1);
		prefs.getDouble("Ro2", R2);
		prefs.getDouble("Ro3", R3);
		prefs.getDouble("TEMPWINDOW", TEMPWINDOW);
		prefs.getDouble("TEMPHISTORESIS", TEMPHISTORESIS);
		prefs.getDouble("DIALHISTORESIS", DIALHISTORESIS);	
	}
	
    public void updateTemp(byte[] packetArray) {
    	//Only read packet if device is initialized
    	if(initializeComplete) {
    		
    		//Extract temperature bytes and convert to unsigned ints
    		if(temp1 == -9999) { //If this is the first reading - simply load values
    			temp1 = packetArray[0] & 0xFF;
        		temp2 = packetArray[1] & 0xFF;
        		temp3 = packetArray[2] & 0xFF;
    		}
    		else { //Otherwise use sliding window
    			temp1 = (packetArray[0] & 0xFF)/TEMPWINDOW + temp1 * ((TEMPWINDOW-1)/TEMPWINDOW);
        		temp2 = (packetArray[1] & 0xFF)/TEMPWINDOW + temp2 * ((TEMPWINDOW-1)/TEMPWINDOW);
        		temp3 = (packetArray[2] & 0xFF)/TEMPWINDOW + temp3 * ((TEMPWINDOW-1)/TEMPWINDOW);
    		}
    		ADCtoCelcius(temp1, inputTempBar, inputTempLabel);
    		ADCtoCelcius(temp2, outputTempBar, outputTempLabel);
    		ADCtoCelcius(temp3, extTempBar, extTempLabel);
    	}
    }
    
    private void ADCtoCelcius(double ADC, JProgressBar bar, JLabel label) {
    	//If thermistor is sending valid measurement, output result
    	double currentTemp = Double.parseDouble(label.getToolTipText());
    	if(ADC > 2) {   //Minimum threshold for valid ADC recording  	
	    	//Math from: https://learn.adafruit.com/thermistor/using-a-thermistor
	    	double conversion = (-1*SERIESR*ADC) / (ADC-255D);
	    	conversion = conversion/Ro1;
	    	conversion = Math.log(conversion);
	    	conversion /= beta1;
	    	conversion += 1D/(25D+273.15D);
	    	conversion = 1D/conversion;
	    	conversion -= 273.15D;
	    	if(conversion > (currentTemp + TEMPJITTER) || conversion < (currentTemp - TEMPJITTER)) { //If temp has sufficiently changed - update temp

	    	}

    	}
    	//If measurement is 0, thermistor is disconnected
    	else {
    		bar.setValue((int) 0);
    		label.setText("N/A");
    	}
    }
    
   private int[] byteToInt(byte[] a) {
	   int[] c = new int[a.length];
	   for(int b=0; b<c.length; b++) {
			c[b] = a[b] & 0xFF; //Convert uint8_t byte to int
		}
	   return c;
   }
}
