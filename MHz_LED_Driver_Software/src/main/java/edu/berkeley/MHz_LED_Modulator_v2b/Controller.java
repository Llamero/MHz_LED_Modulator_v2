package edu.berkeley.MHz_LED_Modulator_v2b;

import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;

public final class Controller {
	//Initialize modules that data will be routed between
	private final View view;
	private final Model model;
	private final Serial serial;
	
	//Initialize variables for serial routing
    private int IDPACKET;//Identifies packet as device identification packet
    private int TEMPPACKET; //Identifies packet as temperature recordings
    private int PANELPACKET; //Identifies packet as panel status
    private int WAVEPACKET; //Identifies packet as recorded analog waveform
    private byte[] packetArray; //Raw data packet array of bytes from device
    private int packetID; //Identifier for packet type

	
	public Controller(View view, Model model, Serial serial) {
		this.model = model;
		this.view = view;
		this.serial = serial;
		model.setController(this);
		view.setController(this);
		serial.setController(this);
		model.setControllerConstants();
		initializeListeners();
	}
	
	public void getModelConstants(byte idPacket, byte tempPacket, byte panelPacket, byte wavePacket) {
		this.IDPACKET = idPacket & 0xFF;
		this.TEMPPACKET = tempPacket & 0xFF;
		this.PANELPACKET = panelPacket & 0xFF;
		this.WAVEPACKET = wavePacket & 0xFF;
	}
	
    public boolean packetProcessor(byte[] packet, int ID) {
    	this.packetArray = packet;
    	this.packetID = ID;
    	
		if (packetID == IDPACKET) {
			return true;
		} else if (packetID == TEMPPACKET) {
			return true;
		} else if (packetID == PANELPACKET) {
			return true;
		} else if (packetID == WAVEPACKET) {
			return true;
		} else {
			return false; // If the packet ID is invalid, return false
		}
    }
/////////////////////////Listeners/////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//View 
	private void initializeListeners() {
		this.view.initSelfListeners(new taskStarterWindowListener()); //Frame
	}

	
	
	
	
	
	
	//Listen for frame events
	final class taskStarterWindowListener implements WindowListener{

		@Override
		public void windowOpened(WindowEvent e) {
            System.out.println("Performing task..."); //Perform task here. In this case, we are simulating a startup (only once) time-consuming task that would use a worker.
//.            StartupLoader.execute();
		}

		@Override
		public void windowClosing(WindowEvent e) {
			serial.disconnect();
		}

		@Override
		public void windowClosed(WindowEvent e) {
			// TODO Auto-generated method stub
			
		}

		@Override
		public void windowIconified(WindowEvent e) {
			// TODO Auto-generated method stub
			
		}

		@Override
		public void windowDeiconified(WindowEvent e) {
			// TODO Auto-generated method stub
			
		}

		@Override
		public void windowActivated(WindowEvent e) {
			// TODO Auto-generated method stub
			
		}

		@Override
		public void windowDeactivated(WindowEvent e) {
			// TODO Auto-generated method stub
			
		}
	}
}
