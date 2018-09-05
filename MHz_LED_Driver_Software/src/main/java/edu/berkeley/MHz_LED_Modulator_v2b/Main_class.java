package edu.berkeley.MHz_LED_Modulator_v2b;

public class Main_class {
	public static void main(String args[]) throws InterruptedException {
		View v = new View(); //Initialize GUI
        Model m = new Model(); //Initialize data model
		Serial s = new Serial(); //Initialize serial 
		Controller c = new Controller(v, m, s); //Initialize controller and sent it the GUI, model, and serial so it can route data between modules
		s.setController(c); //Send controller to serial so it can pass event triggers back to controller
		v.setController(c); //Send controller to view so it can pass event triggers back to controller
		m.setController(c); //Send controller to model so it can pass event triggers back to controller
	}
}
