package edu.berkeley.MHz_LED_Modulator_v2b;

public class Controller {
	private View view;
	private Model model;
	private Serial serial;
	
	public Controller(View view, Model model, Serial serial) {
		this.model = model;
		this.view = view;
		this.serial = serial;
	}
}
