package bianisoft.bfc;

import bianisoft.bfc.Entity;

class Button extends Entity{
	public override function new(pID: String){
		super(pID, null, null, CLSID_Button("CLSID_Button"));
	}
}
