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
    private int readLength = 0; //Number of bytes in most recent load of rx serial buffer
    private boolean arduinoConnect = false; //Whether the GUI if currently connected to a driver
    private int nArduino = 0; //Number of Arduino devices found connected to computer
	private GUI_temp_and_panel gui; //Instance of GUI so display can be updated
	private Pref_and_data data; //Instance of controller so events can be passed back to controller
	private int BAUDRATE; //Baud rate for serial connection
	private String PREFERREDPORT; //Port that program should connect to if available
	private int INITIALREADWAIT; //Time to wait for receiving entire packet during initialization
	private int INITIALSENDWAIT; //Time to wait for sending entire packet during initialization
	private int HEADERLENGTH; //Number of bytes in packet header
	private byte[] DISCONNECTPACKET; //Preformatted packet to tell driver the GUI has disconnected
    
    public void setModules(GUI_temp_and_panel gui, Pref_and_data data) {
    	this.gui = gui;
    	this.data = data;
    }
    
    public void setConstants(int baudRate, String preferredPort, int initialReadWait, int initialSendWait, int headerLength, byte[] disconnectPacket) {
    	this.BAUDRATE = baudRate;
    	this.PREFERREDPORT = preferredPort;
    	this.INITIALREADWAIT = initialReadWait;
    	this.INITIALSENDWAIT = initialSendWait;
    	this.HEADERLENGTH = headerLength;
    	this.DISCONNECTPACKET = disconnectPacket;
    }
    
    public boolean initializeSerial(){
        //Generate an array of available ports on system
        //Make instance of GUI
        int nPorts = SerialPort.getCommPorts().length;
        serialPorts = SerialPort.getCommPorts();
        //Toggle each port checking for any that send an ID packet       
        for(int a = 0; a < nPorts; a++){
            arduinoPort = serialPorts[a];
System.out.println("Testing " +  arduinoPort.getDescriptivePortName());
            gui.updateProgress(100*(a+1)/(nPorts), "Testing " +  arduinoPort.getDescriptivePortName());
            arduinoPort.setBaudRate(BAUDRATE);
            arduinoPort.setComPortTimeouts(SerialPort.TIMEOUT_READ_BLOCKING, INITIALREADWAIT, INITIALSENDWAIT); //Blocking means wait the full 2000ms to catch the set number of bytes
            arduinoPort.openPort();
            readSerial();
            disconnect();			
	    }
      
        //Add disconnect option to connect menu
        gui.addMenuItem("Disconnect");
        
        //Inform user if no devices were found
        nArduino = data.getNarduino();
        if(nPorts == 0) gui.updateProgress(0, "No available COM ports found on this computer.");
        else if(nArduino == 0) gui.updateProgress(0, "Arduino not found.");
        else if(nArduino == 1) gui.updateProgress(0, "Disconnected: " + nArduino + " device found.");
        else gui.updateProgress(0, "Disconnected: " + nArduino + " devices available.");
        
        data.initializeFinished(); //Inform the model that the initialization is complete
        return true; //Inform the GUI that the initialization is complete
    }
    
    public void connectDevice(ButtonGroup group){
    	disconnect();
        
        Iterable<AbstractButton> arl = Collections.list(group.getElements()); //Create a list of buttons in connect menu
        for(AbstractButton ab:arl){ //Find which radio button is selected
            if(ab.isSelected()){
                for(SerialPort b:serialPorts){ //Search all COM ports for one that matches active radioButton (using toolTipText which contains COM port name)
                    if(ab.getToolTipText().equals(b.getDescriptivePortName())){
                        System.out.println(b.getDescriptivePortName() + random());
                        arduinoPort = b;
                        arduinoPort.setBaudRate(BAUDRATE);
                        arduinoPort.setComPortTimeouts(SerialPort.TIMEOUT_READ_BLOCKING, INITIALREADWAIT, INITIALSENDWAIT); //Blocking means wait the full 2000ms to catch the set number of bytes
                        arduinoPort.openPort(); //Connect to matching port if found
                        readSerial(); //Perform handshake and send prefs to Arduino since it will have reset
                        
                        //Add a data listener to the port to catch any incoming packets
                        arduinoPort.addDataListener(new SerialPortDataListener() {
                    	   public int getListeningEvents() { return SerialPort.LISTENING_EVENT_DATA_AVAILABLE; }
                    	   @Override
                    	   public void serialEvent(SerialPortEvent event)
                    	   {
								readSerial();

                    	   }
                        });
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
    
    public void disconnect() {
        if(arduinoPort != null) {
        	if(arduinoPort.isOpen()) {
            	for(int a=0; a<3; a++) arduinoPort.writeBytes(DISCONNECTPACKET, DISCONNECTPACKET.length); //Tell driver 3x that the GUI has now disconnected
        		arduinoPort.closePort(); 
        	}
        	arduinoConnect = false;
        }
    }
    
    
    //Read serial data and load it into a circular buffer
    private void readSerial(){
        readLength = arduinoPort.readBytes(readBuffer, readBuffer.length);
        //If minimal packet size is received then verify contents
		if(readLength > HEADERLENGTH) {
System.out.println("Buffer: " + Arrays.toString(readBuffer));
			arduinoConnect = true; //Set connect flag to true if valid data is received
			data.parseSerial(readBuffer, readLength);
		}
    }
    
    public void reply(byte[] reply) {
    	//writes the entire string at once.
		arduinoPort.writeBytes(reply, reply.length);
    }
    
    public String getPortID() {
    	String ID = null;
    	if(arduinoPort != null) ID = arduinoPort.getDescriptivePortName(); //Only get ID if available, otherwise function hangs
    	if(ID == null) ID = "Disconnect Device";
    	return ID;
    }
    
    public void setSerialDelay(int read, int write){
    	arduinoPort.setComPortTimeouts(SerialPort.TIMEOUT_READ_BLOCKING, read, write);
    }
}


