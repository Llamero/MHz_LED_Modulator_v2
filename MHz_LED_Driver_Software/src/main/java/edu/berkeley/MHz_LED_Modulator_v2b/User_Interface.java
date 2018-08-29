package edu.berkeley.MHz_LED_Modulator_v2b;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import com.fazecast.jSerialComm.SerialPort;
import java.awt.event.ActionEvent;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import static java.lang.Math.random;
import java.text.DecimalFormat;
import java.util.Arrays;
import java.util.Collections;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.AbstractButton;
import javax.swing.ButtonGroup;
import javax.swing.ImageIcon;
import javax.swing.JRadioButtonMenuItem;
import javax.swing.SwingWorker;
import java.awt.Toolkit;


/**
 *
 * @author Ben
 */
@SuppressWarnings("serial")
public class User_Interface extends javax.swing.JFrame {
	//Serial variables
    private SerialPort arduinoPort; //Initialize port object for communication to the Arduino via JSerialComm
    private SerialPort[] serialPorts; //Initialize arrays of COM port objects that are currently open
    private static final byte[] STARTSHAKE = {38, 77, 46, 64}; //Four digit ID code for identifying start of Arduino communication
    private static final byte[] ENDSHAKE = {114, 1, 97, 57}; //Four digit ID code for identifying end of Arduino communication
    private static final int BAUDRATE = 250000; //Baudrate of serial communication
    private boolean arduinoConnect = false; //Variable for whether the GUI if currently connected to a driver
    
    //GUI variables
    private static User_Interface GUI; //User interface frame
    private ButtonGroup group; //List of buttons in Connect menu
    private JRadioButtonMenuItem rbMenuItem; //Holder for current menu item
    /**
     * Creates new form User_Interface
     * @throws java.lang.InterruptedException
     */
    private User_Interface() throws InterruptedException {
        initComponents(); //Initialize interface components
        initSelfListeners(); //Setup listeners for initialization events to happen when GUI appears
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    
    // <editor-fold defaultstate="collapsed" desc="Generated Code">                          
    private void initComponents() {

        tempPanel = new javax.swing.JPanel();
        outputTempBar = new javax.swing.JProgressBar();
        outputBarLabel = new javax.swing.JLabel();
        inputBarLabel = new javax.swing.JLabel();
        inputTemprBar = new javax.swing.JProgressBar();
        inputTempLabel = new javax.swing.JLabel();
        outputTempLabel = new javax.swing.JLabel();
        ledTempBar = new javax.swing.JProgressBar();
        ledTempLabel = new javax.swing.JLabel();
        ledBarLabel = new javax.swing.JLabel();
        jLayeredPane2 = new javax.swing.JLayeredPane();
        jPanel3 = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        rotatePanel1 = new edu.berkeley.MHz_LED_Modulator_v2b.RotatePanel();
        jSlider1 = new javax.swing.JSlider();
        statusLabel = new javax.swing.JLabel();
        jProgressBar1 = new javax.swing.JProgressBar();
        jMenuBar1 = new javax.swing.JMenuBar();
        connectMenu = new javax.swing.JMenu();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        outputTempBar.setOrientation(1);

        outputBarLabel.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        outputBarLabel.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        outputBarLabel.setText("Output");

        inputBarLabel.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        inputBarLabel.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        inputBarLabel.setText("Input");

        inputTemprBar.setOrientation(1);

        inputTempLabel.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        inputTempLabel.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        inputTempLabel.setText("25°C");

        outputTempLabel.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        outputTempLabel.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        outputTempLabel.setText("25°C");

        ledTempBar.setOrientation(1);

        ledTempLabel.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        ledTempLabel.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        ledTempLabel.setText("25°C");

        ledBarLabel.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        ledBarLabel.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        ledBarLabel.setText("LED");

        javax.swing.GroupLayout tempPanelLayout = new javax.swing.GroupLayout(tempPanel);
        tempPanel.setLayout(tempPanelLayout);
        tempPanelLayout.setHorizontalGroup(
            tempPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(tempPanelLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(tempPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(tempPanelLayout.createSequentialGroup()
                        .addComponent(inputBarLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 67, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(27, 27, 27)
                        .addComponent(outputBarLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 67, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(26, 26, 26)
                        .addComponent(ledBarLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 67, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(tempPanelLayout.createSequentialGroup()
                        .addGroup(tempPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(inputTemprBar, javax.swing.GroupLayout.PREFERRED_SIZE, 67, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(inputTempLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 67, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(27, 27, 27)
                        .addGroup(tempPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(outputTempLabel, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 67, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(outputTempBar, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 67, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(26, 26, 26)
                        .addGroup(tempPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(ledTempLabel, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 67, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(ledTempBar, javax.swing.GroupLayout.PREFERRED_SIZE, 67, javax.swing.GroupLayout.PREFERRED_SIZE))))
                .addContainerGap())
        );
        tempPanelLayout.setVerticalGroup(
            tempPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(tempPanelLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(tempPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(inputBarLabel)
                    .addComponent(outputBarLabel)
                    .addComponent(ledBarLabel))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(tempPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(inputTemprBar, javax.swing.GroupLayout.PREFERRED_SIZE, 261, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(ledTempBar, javax.swing.GroupLayout.PREFERRED_SIZE, 261, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(outputTempBar, javax.swing.GroupLayout.PREFERRED_SIZE, 261, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(tempPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(tempPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                        .addComponent(inputTempLabel)
                        .addComponent(outputTempLabel))
                    .addComponent(ledTempLabel))
                .addContainerGap())
        );

        jLayeredPane2.setMaximumSize(new java.awt.Dimension(382, 382));
        jLayeredPane2.setMinimumSize(new java.awt.Dimension(382, 382));

        jPanel3.setMaximumSize(new java.awt.Dimension(382, 382));
        jPanel3.setMinimumSize(new java.awt.Dimension(382, 382));
        jPanel3.setOpaque(false);
        jPanel3.setPreferredSize(new java.awt.Dimension(382, 382));

        jLabel1.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel1.setIcon(new ImageIcon(User_Interface.class.getResource("/images/Dialscale2.png"))); // NOI18N
        jLabel1.setToolTipText("");

        jLabel2.setFont(new java.awt.Font("Tahoma", 0, 36)); // NOI18N
        jLabel2.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel2.setText("15.0%");
        jLabel2.setToolTipText("");

        javax.swing.GroupLayout jPanel3Layout = new javax.swing.GroupLayout(jPanel3);
        jPanel3.setLayout(jPanel3Layout);
        jPanel3Layout.setHorizontalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addGap(111, 111, 111)
                .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 164, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(107, Short.MAX_VALUE))
            .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                .addGroup(jPanel3Layout.createSequentialGroup()
                    .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 382, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addContainerGap()))
        );
        jPanel3Layout.setVerticalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel3Layout.createSequentialGroup()
                .addContainerGap(316, Short.MAX_VALUE)
                .addComponent(jLabel2)
                .addGap(33, 33, 33))
            .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel3Layout.createSequentialGroup()
                    .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 382, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addContainerGap()))
        );

        rotatePanel1.setImage(Toolkit.getDefaultToolkit().getImage(User_Interface.class.getResource("/images/knob2-resized.png")));
        rotatePanel1.setOpaque(false);

        javax.swing.GroupLayout rotatePanel1Layout = new javax.swing.GroupLayout(rotatePanel1);
        rotatePanel1.setLayout(rotatePanel1Layout);
        rotatePanel1Layout.setHorizontalGroup(
            rotatePanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 382, Short.MAX_VALUE)
        );
        rotatePanel1Layout.setVerticalGroup(
            rotatePanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 382, Short.MAX_VALUE)
        );

        jLayeredPane2.setLayer(jPanel3, javax.swing.JLayeredPane.DEFAULT_LAYER);
        jLayeredPane2.setLayer(rotatePanel1, javax.swing.JLayeredPane.DEFAULT_LAYER);

        javax.swing.GroupLayout jLayeredPane2Layout = new javax.swing.GroupLayout(jLayeredPane2);
        jLayeredPane2.setLayout(jLayeredPane2Layout);
        jLayeredPane2Layout.setHorizontalGroup(
            jLayeredPane2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jLayeredPane2Layout.createSequentialGroup()
                .addComponent(jPanel3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
            .addGroup(jLayeredPane2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                .addGroup(jLayeredPane2Layout.createSequentialGroup()
                    .addComponent(rotatePanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addContainerGap()))
        );
        jLayeredPane2Layout.setVerticalGroup(
            jLayeredPane2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
            .addGroup(jLayeredPane2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                .addComponent(rotatePanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        jSlider1.setMaximum(220);
        jSlider1.setMinimum(-40);
        jSlider1.setPaintTicks(true);
        jSlider1.setValue(0);
        jSlider1.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                jSlider1StateChanged(evt);
            }
        });

        statusLabel.setText("jLabel3");

        jProgressBar1.setValue(50);
        jProgressBar1.setStringPainted(true);

        connectMenu.setText("Connect");
        connectMenu.setToolTipText("");
        jMenuBar1.add(connectMenu);

        setJMenuBar(jMenuBar1);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(statusLabel)
                .addGap(368, 368, 368))
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(jLayeredPane2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(126, 126, 126)
                        .addComponent(tempPanel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(0, 0, Short.MAX_VALUE))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(37, 37, 37)
                        .addComponent(jSlider1, javax.swing.GroupLayout.PREFERRED_SIZE, 319, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(122, 122, 122)
                        .addComponent(jProgressBar1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jLayeredPane2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 23, Short.MAX_VALUE)
                        .addComponent(statusLabel)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jSlider1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(tempPanel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(jProgressBar1, javax.swing.GroupLayout.PREFERRED_SIZE, 25, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap())
        );

        pack();
    }// </editor-fold>                        

    private void jSlider1StateChanged(javax.swing.event.ChangeEvent evt) {                                      
        DecimalFormat df = new DecimalFormat("###.#");
        jLabel2.setText("" + df.format((jSlider1.getValue()+40)/2.6) + "%");
        rotatePanel1.rotateWithParam(jSlider1.getValue());
    }                                     

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(User_Interface.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(User_Interface.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(User_Interface.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(User_Interface.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                try {
                    GUI = new User_Interface();
                    GUI.setVisible(true);
                } catch (InterruptedException ex) {
                    Logger.getLogger(User_Interface.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        });
    }

    // Variables declaration - do not modify                     
    private javax.swing.JMenu connectMenu;
    private javax.swing.JLabel inputBarLabel;
    private javax.swing.JLabel inputTempLabel;
    private javax.swing.JProgressBar inputTemprBar;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLayeredPane jLayeredPane2;
    private javax.swing.JMenuBar jMenuBar1;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JProgressBar jProgressBar1;
    private javax.swing.JSlider jSlider1;
    private javax.swing.JLabel ledBarLabel;
    private javax.swing.JProgressBar ledTempBar;
    private javax.swing.JLabel ledTempLabel;
    private javax.swing.JLabel outputBarLabel;
    private javax.swing.JProgressBar outputTempBar;
    private javax.swing.JLabel outputTempLabel;
    private edu.berkeley.MHz_LED_Modulator_v2b.RotatePanel rotatePanel1;
    private javax.swing.JLabel statusLabel;
    private javax.swing.JPanel tempPanel;
    // End of variables declaration                   
    
    //Code is from: https://stackoverflow.com/questions/39565472/how-to-automatically-execute-a-task-after-jframe-is-displayed-from-within-it
    //Perform handshaking on backgorund thread so as not to lock-up the GUI
    SwingWorker<Integer, Integer> StartupLoader = new SwingWorker<Integer, Integer>() {
        @Override
        protected Integer doInBackground() throws Exception {
            initializeSerial();
            return 100;
        }
    };

    //This method is used to avoid calling an overridable method ('addWindowListener()') from within the constructor.
    //Code is from: https://stackoverflow.com/questions/39565472/how-to-automatically-execute-a-task-after-jframe-is-displayed-from-within-it
    private void initSelfListeners() {
        WindowListener taskStarterWindowListener = new WindowListener() {
            @Override
            public void windowOpened(WindowEvent e) {
                System.out.println("Performing task..."); //Perform task here. In this case, we are simulating a startup (only once) time-consuming task that would use a worker.
                StartupLoader.execute();
            }

            @Override
            public void windowClosing(WindowEvent e) {
            	
                if(arduinoPort != null) {
                	if(arduinoPort.isOpen()) arduinoPort.closePort();  //Close port connection when JFrame is closed
                	arduinoConnect = false;
                }
            }

            @Override
            public void windowClosed(WindowEvent e) {
                //Do nothing...Or drink coffee...NVM; always drink coffee!
            }

            @Override
            public void windowIconified(WindowEvent e) {
                //Do nothing...Or do EVERYTHING!
            }

            @Override
            public void windowDeiconified(WindowEvent e) {
                //Do nothing...Or break the law...
            }

            @Override
            public void windowActivated(WindowEvent e) {
                //Do nothing...Procrastinate like me!
            }

            @Override
            public void windowDeactivated(WindowEvent e) {
                //Do nothing...And please don't notice I have way too much free time today...
            }
        };

        //Here is where the magic happens! We make (a listener within) the frame start listening to the frame's own events!
        this.addWindowListener(taskStarterWindowListener);
    }
    
    private void initializeSerial() throws InterruptedException{
        //Generate an array of available ports on system
        int nPorts = SerialPort.getCommPorts().length;
        serialPorts = SerialPort.getCommPorts();
        int a;
        byte[] readBuffer = new byte[1024]; //Temporary buffer array to store initial received stream
        byte[] idArray = new byte[1]; //Array to store ID string as char array
        boolean arduinoFound = false; //Variable for whether at least one arduino driver was found - i.e. successful handshake
        byte[] testArray = new byte[4]; //test for known references in data packet
        int idLength = 0; //Variable for marking the lenght of the id in the data packet
        int numRead; //Number of bytes in a data packet

        //Toggle each port, until one sends correct sequence of bytes
        group = new ButtonGroup();
        for(a = 0; a < nPorts; a++){
            arduinoPort = serialPorts[a];
            jProgressBar1.setValue(100*(a+1)/(nPorts));
            jProgressBar1.setString("Testing " +  arduinoPort.getDescriptivePortName());
            arduinoPort.setBaudRate(BAUDRATE);
            arduinoPort.setComPortTimeouts(SerialPort.TIMEOUT_READ_BLOCKING, 2000, 2000); //Blocking means wait the full 2000ms to catch the set number of bytes
            arduinoPort.openPort();
            numRead = arduinoPort.readBytes(readBuffer, readBuffer.length);
            System.out.println(Arrays.toString(readBuffer));
            
            //If minimal packet size is received then verify contents
			if(numRead > 9) {
				//Search for start of packet identifier
	            for(int c=0; c<readBuffer.length; c++) {
	            	System.arraycopy(readBuffer, c, testArray, 0, testArray.length);
	            	if(Arrays.equals(testArray, STARTSHAKE)) { //Verify valid packet: START (4 bytes) - length of ID (1 byte) - ID (length # of bytes) - END (4 bytes)
	            		idLength = readBuffer[c+4]; //Retrieve putative ID length from packet
	            		System.arraycopy(readBuffer, c+idLength+4, testArray, 0, testArray.length);
	            		if(Arrays.equals(testArray, ENDSHAKE)) { //Look for end of packet immediately after the ID
	            			
	            			//If everything is valid, then add connection to the connection menu
	            			idArray = new byte[idLength-1]; //Subtract 1 to remove null pointer which is not sent, but is counted by the Arduino
	            			System.arraycopy(readBuffer, c+5, idArray, 0, idArray.length);
	            			System.out.println(new String(idArray));
	                        //Add Arduino to radio button connection list
	                        rbMenuItem = new JRadioButtonMenuItem(new String(idArray)); 
	                        rbMenuItem.setToolTipText(arduinoPort.getDescriptivePortName());
	                        
	                        arduinoFound = true;
	                        
	                        //Add an action listener to the radio button so it can check when clicked
	                        rbMenuItem.addActionListener((ActionEvent e) -> {
	                            //If a radio button is selected connect to that device
	                            connectDevice();
	                        });
	                        group.add(rbMenuItem);
	                        connectMenu.add(rbMenuItem);
	            			break; //end loop

	            		}
	            	}
	            }
			}
			arduinoPort.closePort();
			
	     }
        
        //Add disconnect button to menu options
        rbMenuItem = new JRadioButtonMenuItem("Disconnect"); 
        rbMenuItem.setToolTipText("Disconnect from current device");
        
        //Add an action listener to the radio button so it can check when clicked
        rbMenuItem.addActionListener((ActionEvent e) -> {
            //If a radio button is selected connect to that device
            connectDevice();
        });
        group.add(rbMenuItem);
        connectMenu.add(rbMenuItem);
     
        //Inform user if no devices were found
        if(nPorts == 0) jProgressBar1.setString("No available COM ports found on this computer.");
        else if(!arduinoFound) jProgressBar1.setString("Arduino not found.");
        else jProgressBar1.setString("COM search complete");
        jProgressBar1.setValue(0); //Reset progress bar
    }
    private void connectDevice(){
        if(arduinoPort != null) { //Close active open port if one is open
        	if(arduinoPort.isOpen()) arduinoPort.closePort();
        	arduinoConnect = false;
        }
        
        Iterable<AbstractButton> arl = Collections.list(group.getElements()); //Create a list of buttons in connect menu
        for(AbstractButton ab:arl){
            if(ab.isSelected()){
                for(SerialPort b:serialPorts){ //Search all COM ports for on that matches radioButton (using toolTipText which contains COM port name)
                    if(ab.getToolTipText().equals(b.getDescriptivePortName())){
                        System.out.println(b.getDescriptivePortName() + random());
                        arduinoPort = b;
                        arduinoPort.openPort(); //Connect to matching port if found
                        arduinoConnect = true;
                        break;
                    }
                }
            }
        }
    }
}

