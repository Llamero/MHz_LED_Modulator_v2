package edu.berkeley.MHz_LED_Modulator_v2b;

import java.net.URL;

import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.SwingUtilities;

public class Main_class {
	public static void main(String args[]) throws InterruptedException {

        
		final View v = new View(); //Initialize GUI
		final Model m = new Model(); //Initialize data model
		final Serial s = new Serial(); //Initialize serial 
		final Controller c = new Controller(v, m, s); //Initialize controller and sent it the GUI, model, and serial so it can route data between modules
		v.setVisible(true);
	}
}
