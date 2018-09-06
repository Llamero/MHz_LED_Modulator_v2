package edu.berkeley.MHz_LED_Modulator_v2b;

public class Main_class {
	public static void main(String args[]) throws InterruptedException {
		final GUI_temp_and_panel v = new GUI_temp_and_panel(); //Initialize GUI
		final Pref_and_data m = new Pref_and_data(); //Initialize data model
		final Serial s = new Serial(); //Initialize serial 
		
		//Distribute instances of classes so they can exchange information
		m.setModules(v, s);
		v.setModules(s, m);
		s.setModules(v, m);
		
		//Distribute constants
		m.shareConstants();
		
		//Show GUI
		v.setVisible(true);
	}
}
