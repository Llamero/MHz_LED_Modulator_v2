package edu.berkeley.MHz_LED_Modulator_v2b;

import static java.lang.Math.random;

import java.util.Arrays;
import java.util.Collections;

import javax.swing.AbstractButton;
import javax.swing.ButtonGroup;
import javax.swing.JRadioButtonMenuItem;

import com.fazecast.jSerialComm.SerialPort;
import com.fazecast.jSerialComm.SerialPortDataListener;
import com.fazecast.jSerialComm.SerialPortEvent;

@SuppressWarnings("serial")
public final class Serial {
  
	//Packet structure is: byte(0) STARTBYTE -> byte(1) packet length -> byte(2) checksum -> byte(3) packet identifier -> byte(4-n) data packet;
	private SerialPort arduinoPort; //Port object for communication to the Arduino via JSerialComm
    private SerialPort[] serialPorts; //Array of COM port objects that are currently open
    private byte[] readBuffer = new byte[1024]; //Array for storing the read buffer that can contain at least one packet (max size 256 bytes);
    private int readLength = 0; //Length of read Buffer
    private boolean arduinoConnect = false; //Whether the GUI if currently connected to a driver
    private int nArduino = 0; //Number of Arduino devices found connected to computer
    private boolean initializeComplete = false; //Identifies if initial startup was complete (prevents things like IDs to be rewritten in connection menu)
    private boolean packetFound = false; //Flag for whether a valid packet was found in the buffer
	private GUI_temp_and_panel gui; //Instance of GUI so display can be updated
	private Pref_and_data data; //Instance of controller so events can be passed back to controller
	private int BAUDRATE; //Baud rate for serial connection
	private String PREFERREDPORT; //Port that program should connect to if available
	private double[] WARNTEMP; //Temperature at which driver and GUI will warn user of overheat state - 0-input, 1-output, 2-external
	private double[] FAULTTEMP; //Temperature at which driver will shutoff automatically - 0-input, 1-output, 2-external
	private int READWAIT; //Time to wait for receiving entire packet
	private int SENDWAIT; //Time to wait for sending entire packet
    
    public void setModules(GUI_temp_and_panel gui, Pref_and_data data) {
    	this.gui = gui;
    	this.data = data;
    }
    
    public void setConstants(int baudRate, String preferredPort, double[] warnTemp, double[] faultTemp, int readWait, int sendWait) {
    	this.BAUDRATE = baudRate;
    	this.PREFERREDPORT = preferredPort;
    	this.WARNTEMP = warnTemp;
    	this.FAULTTEMP = faultTemp; 
    	this.READWAIT = readWait;
    	this.SENDWAIT = sendWait;
    }
    
    public void disconnect() {
        if(arduinoPort != null) {
        	arduinoPort.writeBytes(new byte[] {0, 50}, 2);
        	if(arduinoPort.isOpen()) arduinoPort.closePort(); 
        	arduinoConnect = false;
        }
    }
    
    public boolean initializeSerial(){
        //Generate an array of available ports on system
        //Make instance of GUI
        int nPorts = SerialPort.getCommPorts().length;
        serialPorts = SerialPort.getCommPorts();
        JRadioButtonMenuItem[] tempMenu = new JRadioButtonMenuItem[nPorts]; //Create a temporary array to store menu items to give to GUI
        int devicePorts = 0; //Counter for number of device ports found out of all ports available
        //Toggle each port checking for any that send an ID packet       
        for(int a = 0; a < nPorts; a++){
            arduinoPort = serialPorts[a];
System.out.println("Testing " +  arduinoPort.getDescriptivePortName());
            gui.updateProgress(100*(a+1)/(nPorts), "Testing " +  arduinoPort.getDescriptivePortName());
            arduinoPort.setBaudRate(BAUDRATE);
            arduinoPort.setComPortTimeouts(SerialPort.TIMEOUT_READ_BLOCKING, READWAIT, SENDWAIT); //Blocking means wait the full 2000ms to catch the set number of bytes
            arduinoPort.openPort();
            readSerial();
			arduinoPort.closePort();			
	    }
        
        //Add disconnect option to connect menu
        gui.addMenuItem("Disconnect");
        
        //Inform user if no devices were found
        nArduino = data.getNarduino();
        if(nPorts == 0) gui.updateProgress(0, "No available COM ports found on this computer.");
        else if(nArduino == 0) gui.updateProgress(0, "Arduino not found.");
        else if(nArduino == 1) gui.updateProgress(0, "Disconnected: " + nArduino + " device found.");
        else gui.updateProgress(0, "Disconnected: " + nArduino + " devices available.");
        
        return true;
    }
    
    public void connectDevice(ButtonGroup group){
    	disconnect();
        
        Iterable<AbstractButton> arl = Collections.list(group.getElements()); //Create a list of buttons in connect menu
        for(AbstractButton ab:arl){
            if(ab.isSelected()){
                for(SerialPort b:serialPorts){ //Search all COM ports for on that matches radioButton (using toolTipText which contains COM port name)
                    if(ab.getToolTipText().equals(b.getDescriptivePortName())){
                        System.out.println(b.getDescriptivePortName() + random());
                        arduinoPort = b;
                        arduinoPort.setBaudRate(BAUDRATE);
                        arduinoPort.setComPortTimeouts(SerialPort.TIMEOUT_READ_BLOCKING, READWAIT, SENDWAIT); //Blocking means wait the full 2000ms to catch the set number of bytes
                        arduinoPort.openPort(); //Connect to matching port if found
readSerial();
reply(new byte[] {0, 100}); //Tell Arduino that it's ID was found and to boot into loop
                        //Add a data listener to the port to catch any incoming packets
                        arduinoPort.addDataListener(new SerialPortDataListener() {
                    	   public int getListeningEvents() { return SerialPort.LISTENING_EVENT_DATA_AVAILABLE; }
                    	   @Override
                    	   public void serialEvent(SerialPortEvent event)
                    	   {
								readSerial();

                    	   }
                        });
                        arduinoConnect = true;
                        gui.updateProgress(0, "Connected to: " + ab.getText());
                        break;
                    }
                }
            }
        }
        if(!arduinoConnect) {
            if(nArduino == 1) gui.updateProgress(0, "Disconnected: " + nArduino + " device available.");
            else gui.updateProgress(0, "Disconnected: " + nArduino + " devices available.");
            gui.resetDisplay();
        }
    }
    
    private boolean readSerial(){
    	packetFound = false; //Reset pack found flag
        readLength = arduinoPort.readBytes(readBuffer, readBuffer.length);
System.out.println("Buffer: " + Arrays.toString(readBuffer));
        //If minimal packet size is received then verify contents
		if(readLength > 4) {
			packetFound = data.parseSerial(readBuffer, readLength);			
		}
		return packetFound;
    }
    
    public void reply(byte[] reply) {
    	//writes the entire string at once.
		arduinoPort.writeBytes(reply, reply.length);
		System.out.println(packetFound + " " + initializeComplete);
    }
    
    public String getPortID() {
    	String ID = arduinoPort.getDescriptivePortName();
    	if(ID == null) ID = "Disconnect Device";
    	return ID;
    }
}


