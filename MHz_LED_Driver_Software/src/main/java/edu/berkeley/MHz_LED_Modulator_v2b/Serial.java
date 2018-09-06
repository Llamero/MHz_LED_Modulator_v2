package edu.berkeley.MHz_LED_Modulator_v2b;

import static java.lang.Math.random;

import java.awt.event.ActionEvent;
import java.util.Arrays;
import java.util.Collections;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.swing.AbstractButton;
import javax.swing.ButtonGroup;
import javax.swing.JLabel;
import javax.swing.JLayeredPane;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JPanel;
import javax.swing.JProgressBar;
import javax.swing.JRadioButtonMenuItem;

import com.fazecast.jSerialComm.SerialPort;
import com.fazecast.jSerialComm.SerialPortDataListener;
import com.fazecast.jSerialComm.SerialPortEvent;

@SuppressWarnings("serial")
public final class Serial {
	
	//Serial variables
	//Packet structure is: byte(0) STARTBYTE -> byte(1) packet length -> byte(2) checksum -> byte(3) packet identifier -> byte(4-n) data packet;
	private SerialPort arduinoPort; //Port object for communication to the Arduino via JSerialComm
    private SerialPort[] serialPorts; //Array of COM port objects that are currently open
    private byte[] readBuffer = new byte[1024]; //Array for storing the read buffer that can contain at least one packet (max size 256 bytes);
    private byte[] headerArray = new byte [4]; //Array for storing the header on a found data packet
    private byte[] packetArray = new byte[252]; //Array for storing the data packet contents (256 bytes - 4 byte header)
    private int packetID = 0; //Packet ID: 1-ID packet, 2-temperature packet, 3-panel packet, 4-waveform packet 
    private int packetLength = 0; //length of the packet
    private int checkSum = 0; //packet checksum
    private int readLength = 0; //Length of read Buffer
    private static final byte CONFIRMBYTE = 0; //Send byte to confirm receipt of packet
    private static final byte STARTBYTE = 0; //Identifies start of packet
    private static final int BAUDRATE = 250000; //Baudrate of serial communication
    private boolean arduinoConnect = false; //Whether the GUI if currently connected to a driver
    private int nArduino = 0; //Number of Arduino devices found connected to computer
    private boolean initializeComplete = false; //Identifies if initial startup was complete (prevents things like IDs to be rewritten in connection menu)
    private boolean packetFound = false; //Flag for whether a valid packet was found in the buffer
	private Controller controller; //Instance of controller so events can be passed back to controller
    
    public void setController(Controller controller) {
    	this.controller = controller;
    }
    public void disconnect() {
        if(arduinoPort != null) {
        	if(arduinoPort.isOpen()) arduinoPort.closePort(); 
        	arduinoConnect = false;
        }
    }
    
    public boolean initializeSerial() throws InterruptedException{
System.out.println("Testing ");
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
//.            updateProgress(100*(a+1)/(nPorts), "Testing " +  arduinoPort.getDescriptivePortName());
            arduinoPort.setBaudRate(BAUDRATE);
            arduinoPort.setComPortTimeouts(SerialPort.TIMEOUT_READ_BLOCKING, 2000, 2000); //Blocking means wait the full 2000ms to catch the set number of bytes
            arduinoPort.openPort();
            readSerial();
			arduinoPort.closePort();			
	    }
        
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
                        arduinoPort.setComPortTimeouts(SerialPort.TIMEOUT_READ_BLOCKING, 2000, 2000); //Blocking means wait the full 2000ms to catch the set number of bytes
                        arduinoPort.openPort(); //Connect to matching port if found
                        
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
//.                        updateProgress(0, "Connected to: " + ab.getText());
                        break;
                    }
                }
            }
        }
        if(!arduinoConnect) {
//.            if(nArduino == 1) updateProgress(0, "Disconnected: " + nArduino + " device available.");
//.            else updateProgress(0, "Disconnected: " + nArduino + " devices available.");
//.            resetDisplay();
        }
    }
    
    private boolean readSerial() {
    	packetFound = false; //Reset pack found flag
        readLength = arduinoPort.readBytes(readBuffer, readBuffer.length);
System.out.println("Buffer: " + Arrays.toString(readBuffer));
        
        //If minimal packet size is received then verify contents
		if(readLength > 4) {
			//Search entire buffer for all valid packets
            for(int a=0; a<(readLength-headerArray.length); a++) {
            	if(readBuffer[a] == STARTBYTE) { //Search for startbyte
            		//Copy putative header starting at STARTBYTE
            		System.arraycopy(readBuffer, a, headerArray, 0, headerArray.length); 
            	    
            		//Extract header bytes and convert uint8_t to int (variable & 0xFF) - https://stackoverflow.com/questions/14071361/java-how-to-parse-uint8-in-java 
            	    packetLength = headerArray[1] & 0xFF; //length of the packet
            		packetID = headerArray[3] & 0xFF; //Packet ID
            		checkSum = packetID; //Reset checksum value to start at packet ID
            		
            		//Copy putative packet starting at end of header
            		if((a+1+headerArray.length+packetLength) < readBuffer.length && packetLength <= packetArray.length && checkSum > 0) { //Check that packet is complete before trying to copy - ignore fragmented packets at end of buffer or packets that are longer than the packetArray they will be stored in
            			Arrays.fill(packetArray, (byte) 0); //Clear contents of packet array
            			System.arraycopy(readBuffer, a+headerArray.length, packetArray, 0, packetLength); //Copy putative header starting at STARTBYTE
	            		
	            		//Extract checksum from packet and verify it against checksum in data packet
	            		for(int b=0; b<packetLength; b++) checkSum += (packetArray[b] & 0xFF);
System.out.println("Checksums: " + (checkSum % 256) + " " + (headerArray[2] & 0xFF));
	            		if((checkSum % 256) == (headerArray[2] & 0xFF)) { //See if checksum matches checksum in datapacket
	            			//If checksum is valid then valid packet structure - convert packet to int array and send to GUI
//.	            			packetFound = packetProcessor(packetArray, packetID);
	            			
	            			//Move buffer index to end of packet
	            			a += packetLength + headerArray.length-1;
	            		}
            		}
            	}
            	if(!initializeComplete && packetFound) {
//.            		replyByte(IDPACKET); //Tell Arduino that it's ID was found and to boot into loop
            		nArduino++; //Add one to the number of devices found
            		break; //If device was initializing and ID packet was found, stop looking for more packets
            	}
            }
		}
		return packetFound;
    }
    
    private void replyByte(byte reply) {
    	byte[] replyArray = {reply};
    	arduinoPort.writeBytes(replyArray, replyArray.length);
    }
    
    public String getPortID() {
    	return arduinoPort.getDescriptivePortName();
    }
}


