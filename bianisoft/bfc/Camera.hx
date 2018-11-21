package bianisoft.bfc;

import bianisoft.bfc.Obj;
import bianisoft.bfc.PhysObj;

class Camera2D extends PhysObj2D{
	public static var gCurCamera: Camera2D;

	public override function new(pID: String){	trace("Camera2D.new");
		super(pID, null, CLSID_Camera2D("CLSID_Camera2D"));
		setLoaded(true);
	}
	public function setCurrent(){	trace("Camera2D.setCurrent");
		Camera2D.gCurCamera= this;
	}
}

/*
class Camera3D extends PhysObj3D{
	public static var gCurCamera: Camera3D;

	public override function new(pID: String){	trace("Camera3D.new");
		super(pID, null, CLSID_Camera3D("CLSID_Camera3D"));
		setLoaded(true);
	}
	public function setCurrent(){	trace("Camera3D.setCurrent");
		Camera3D.gCurCamera= this;
	}
}
*/
