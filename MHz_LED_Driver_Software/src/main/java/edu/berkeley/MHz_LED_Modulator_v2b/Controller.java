package edu.berkeley.MHz_LED_Modulator_v2b;

import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;

import javax.swing.SwingWorker;

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
    private boolean initializeComplete; //Stores whether serial initialization has completed

	
	public Controller(View view, Model model, Serial serial) {
		//Get instances of modules
		this.model = model;
		this.view = view;
		this.serial = serial;
		
		//Send this instance of controller to the peripheral modules so they can talk to controller
		model.setController(this);
		view.setController(this);
		serial.setController(this);
		
		//Import necessary constants
		model.setControllerConstants();
		
		//Start up listeners to catch events
		initializeListeners();
	}
	
	public void getModelConstants(byte idPacket, byte tempPacket, byte panelPacket, byte wavePacket, boolean initializeComplete) {
		this.IDPACKET = idPacket & 0xFF;
		this.TEMPPACKET = tempPacket & 0xFF;
		this.PANELPACKET = panelPacket & 0xFF;
		this.WAVEPACKET = wavePacket & 0xFF;
		this.initializeComplete = initializeComplete;
	}
	
    public boolean packetProcessor(byte[] packet, int packetID) {
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
    
    public void updateProgress(int progress, String string) {
    	view.updateProgress(progress, string);
    }
    
    public void resetDisplay() {
    	view.resetDisplay();
    }
/////////////////////////Listeners/////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//View 
	private void initializeListeners() {
		this.view.initSelfListeners(new taskStarterWindowListener()); //Frame
	}

	
	
	
	
	
	
	//Listen for frame events
	class taskStarterWindowListener implements WindowListener{

		@Override
		public void windowOpened(WindowEvent e) {
            System.out.println("Performing task..."); //Perform task here. In this case, we are simulating a startup (only once) time-consuming task that would use a worker.
   	     	//Code is from: https://stackoverflow.com/questions/39565472/how-to-automatically-execute-a-task-after-jframe-is-displayed-from-within-it
    	    //Perform handshaking on backgorund thread so as not to lock-up the GUI
    	    SwingWorker<Integer, Integer> StartupLoader = new SwingWorker<Integer, Integer>() {
    	        protected Integer doInBackground() throws Exception {
    	        	initializeComplete = serial.initializeSerial();
    	            return 100;
    	        }
    	    };
            StartupLoader.execute();
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
