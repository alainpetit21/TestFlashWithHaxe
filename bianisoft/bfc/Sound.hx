package bianisoft.bfc;

class Sound extends PhysObj2D{
	public override function new(pID: String){
		super(pID, null, CLSID_Sound("CLSID_Sound"));
	}
}
