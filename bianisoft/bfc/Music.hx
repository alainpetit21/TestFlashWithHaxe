package bianisoft.bfc;

class Music extends PhysObj2D{
	public override function new(pID: String){
		super(pID, null, CLSID_Music("CLSID_Music"));
	}
}
