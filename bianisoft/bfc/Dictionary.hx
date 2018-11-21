package bianisoft.bfc;

import bianisoft.bfc.Obj;

class Dictionary extends Obj{
	public override function new(pID: String){
		super(pID, CLSID_Dictionary("CLSID_Dictionary"));
	}
	public override function load(pFilename: String){
		super.load(pFilename);
		setLoaded(true);
	}
}
