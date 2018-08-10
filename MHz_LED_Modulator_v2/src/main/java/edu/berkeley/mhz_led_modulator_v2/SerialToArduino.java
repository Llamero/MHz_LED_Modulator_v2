/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.berkeley.mhz_led_modulator_v2;

import com.fazecast.jSerialComm.SerialPort;
import static com.fazecast.jSerialComm.SerialPort.TIMEOUT_READ_SEMI_BLOCKING;
import com.fazecast.jSerialComm.SerialPortDataListener;
import com.fazecast.jSerialComm.SerialPortEvent;
import java.awt.EventQueue;
import java.io.InputStream;
import javax.swing.SwingWorker;

/**
 *
 * @author Ben
 */
public class SerialToArduino extends SwingWorker<Integer, String> {
    public static SerialPort arduinoPort = null;
    public static InputStream arduinoStream = null;
    public static int PACKET_SIZE_IN_BYTES = 2;
    public static User_Interface GUI; //Initialize instance of GUI
    
    public void initialize() throws InterruptedException{
        //Generate an array of available ports on system
        int nPorts = SerialPort.getCommPorts().length;
        SerialPort[] serialPorts = SerialPort.getCommPorts();
        byte[] buffer = {(byte) 0xff};
        for(int a = 0; a < nPorts; a++){
            arduinoPort = serialPorts[a];
            arduinoPort.setBaudRate(250000);
            arduinoPort.setComPortTimeouts(TIMEOUT_READ_SEMI_BLOCKING, 2000, 2000);
            System.out.println("Testing " + arduinoPort.getDescriptivePortName());
            arduinoPort.openPort();
            Thread.sleep(2000);
            arduinoPort.writeBytes(buffer, 1);
            arduinoPort.closePort();
        }
    } 

    @Override
    protected Integer doInBackground() throws Exception {
                    arduinoPort.addDataListener(new SerialPortDataListener() {
                @Override
                public int getListeningEvents() { return SerialPort.LISTENING_EVENT_DATA_AVAILABLE; }
                @Override
                public void serialEvent(SerialPortEvent event)
                {
                   if (event.getEventType() != SerialPort.LISTENING_EVENT_DATA_AVAILABLE)
                      return;
                   byte[] newData = new byte[arduinoPort.bytesAvailable()];
                   int numRead = arduinoPort.readBytes(newData, newData.length);
                   System.out.println("Read " + numRead + " bytes.");
                }
            });
        return null;
    }
    
}
