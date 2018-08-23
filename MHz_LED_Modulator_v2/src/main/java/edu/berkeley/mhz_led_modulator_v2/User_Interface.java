/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.berkeley.mhz_led_modulator_v2;

import com.fazecast.jSerialComm.SerialPort;
import static com.fazecast.jSerialComm.SerialPort.TIMEOUT_READ_BLOCKING;
import java.awt.Image;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import java.net.URL;
import java.text.DecimalFormat;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.ImageIcon;
import javax.swing.SwingWorker;


/**
 *
 * @author Ben
 */
public class User_Interface extends javax.swing.JFrame {
    private SerialPort arduinoPort; //Initialize port object for communication to the Arduino via JSerialComm
    private static final byte[] HANDSHAKE = {38, 77, 46, 64}; //Four digit ID code for identifying driver Arduinos
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
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
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
        rotatePanel1 = new edu.berkeley.mhz_led_modulator_v2.RotatePanel();
        jButton1 = new javax.swing.JButton();
        jSlider1 = new javax.swing.JSlider();

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
        jLabel1.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Images/Dial scale2.png"))); // NOI18N
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

        URL url = getClass().getResource("/Images/knob2-resized.png");   
        Image image = new ImageIcon(url).getImage();

        rotatePanel1.setImage(image);
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

        jButton1.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        jButton1.setText("CONNECT");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        jSlider1.setMaximum(220);
        jSlider1.setMinimum(-40);
        jSlider1.setPaintTicks(true);
        jSlider1.setValue(0);
        jSlider1.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                jSlider1StateChanged(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(jButton1)
                .addGap(37, 37, 37))
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(jLayeredPane2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(126, 126, 126)
                        .addComponent(tempPanel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(35, 35, 35)
                        .addComponent(jSlider1, javax.swing.GroupLayout.PREFERRED_SIZE, 319, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(tempPanel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLayeredPane2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(jButton1)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jSlider1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed


    }//GEN-LAST:event_jButton1ActionPerformed

    private void jSlider1StateChanged(javax.swing.event.ChangeEvent evt) {//GEN-FIRST:event_jSlider1StateChanged
        DecimalFormat df = new DecimalFormat("###.#");
        jLabel2.setText("" + df.format((jSlider1.getValue()+40)/2.6) + "%");
        rotatePanel1.rotateWithParam(jSlider1.getValue());
    }//GEN-LAST:event_jSlider1StateChanged

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
                    User_Interface GUI = new User_Interface();
                    GUI.setVisible(true);
                } catch (InterruptedException ex) {
                    Logger.getLogger(User_Interface.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JLabel inputBarLabel;
    private javax.swing.JLabel inputTempLabel;
    private javax.swing.JProgressBar inputTemprBar;
    private javax.swing.JButton jButton1;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLayeredPane jLayeredPane2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JSlider jSlider1;
    private javax.swing.JLabel ledBarLabel;
    private javax.swing.JProgressBar ledTempBar;
    private javax.swing.JLabel ledTempLabel;
    private javax.swing.JLabel outputBarLabel;
    private javax.swing.JProgressBar outputTempBar;
    private javax.swing.JLabel outputTempLabel;
    private edu.berkeley.mhz_led_modulator_v2.RotatePanel rotatePanel1;
    private javax.swing.JPanel tempPanel;
    // End of variables declaration//GEN-END:variables
    
    //This is a mockup worker to simulate some time-consiming loading task that would be performed at startup, with the GUI providing a loading screen...
    //Code is from: https://stackoverflow.com/questions/39565472/how-to-automatically-execute-a-task-after-jframe-is-displayed-from-within-it
    SwingWorker<Integer, Integer> StartupLoader = new SwingWorker<Integer, Integer>() {
        @Override
        protected Integer doInBackground() throws Exception {
            initializeSerial(HANDSHAKE);
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
                //Do nothing...Or something...You decide!
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
    private void initializeSerial(byte[] HANDSHAKE) throws InterruptedException{
        //Generate an array of available ports on system
        int nPorts = SerialPort.getCommPorts().length;
        SerialPort[] serialPorts = SerialPort.getCommPorts();
        int a;
        byte[] readBuffer = new byte[5]; //Temporary buffer array to store initial reveiced stream
        byte recShake[] = new byte[4]; //Array to store recieved handshake ID
        byte id[] = new byte[1]; //Array to store Arduino ID number
        boolean arduinoFound = false; //Variable to ID whether an Arduino is found on available COM ports
            
        //Toggle each port, until one sends correct sequence of bytes
        
        for(a = 0; a < nPorts; a++){
            arduinoPort = serialPorts[a];
            arduinoPort.setBaudRate(250000);
            arduinoPort.setComPortTimeouts(TIMEOUT_READ_BLOCKING, 2000, 2000); //Blocking means wait the full 2000ms to catch the set number of bytes
            System.out.println("Testing " + arduinoPort.getDescriptivePortName());
            arduinoPort.openPort();
            arduinoPort.readBytes(readBuffer, readBuffer.length);
            recShake = Arrays.copyOfRange(readBuffer, 0, 4);
            id = Arrays.copyOfRange(readBuffer, 4, 5);
            if(Arrays.equals(HANDSHAKE, recShake)){
                System.out.println("Arduino #" + id[0] + " is on " + arduinoPort.getDescriptivePortName());
                arduinoFound = true;
            }
            arduinoPort.closePort();
        }
        if(nPorts == 0) System.out.println("No available COM ports found on this computer.");
        else if(!arduinoFound){
            System.out.println("" + recShake[0] + " " + recShake[1] + " " + recShake[2] + " " + recShake[3] + " ");
            System.out.println("Arduino not found.");
        }
    } 
}

