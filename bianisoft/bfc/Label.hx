package bianisoft.bfc;

class Label extends PhysObj2D{
	public override function new(pID: String){
		super(pID, null, CLSID_Label("CLSID_Label"));
	}
}
