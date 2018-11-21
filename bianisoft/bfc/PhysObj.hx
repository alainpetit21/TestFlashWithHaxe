package bianisoft.bfc;

import phx.Body;
import phx.Circle;
import phx.World;
import bianisoft.bfc.Obj;

/*
class PhysObj3D extends Obj{
}
*/

class PhysObj2D extends Obj{
	public var mIsShown: Bool;
	public var mBody: Body;
	public var mWorldPt: World;

	public var mIsCollidable(default, setCollidable): Bool;
	public var mCircle: Circle;

	public override function new(pID: String,  ?pRadius: Int, ?pClassID: ClassID){	trace("PhysObj.new");
		super(pID, (pClassID == null)? CLSID_PhysObj("CLSID_PhysObj") : pClassID);

		mWorldPt= null;
		mIsShown= true;

		mCircle= new phx.Circle((pRadius == null)? 1.0 : pRadius, new phx.Vector(0, 0));
		mBody= new phx.Body(0, 0);
		mBody.isCollidable= false;
		mBody.addShape(mCircle);
	}
	
	public override function reset(){
		super.reset();
		mIsShown= true;

		mBody.x= 0.0;		mBody.y= 0.0;
		mBody.v.x= 0.0;		mBody.v.y= 0.0;
		mBody.f.x= 0.0;		mBody.f.y= 0.0;

		mBody.a= 0.0;
		mBody.w= 0.0;
		mBody.t= 0.0;
		
		if(mWorldPt != null)	
			mWorldPt.sync(mBody);
	}
	
	public function setCollidable(pIsCollidable: Bool): Bool{
		mBody.isCollidable= mIsCollidable= pIsCollidable;
		return mIsCollidable;
	}

	public override function manage(pTimingVariation: Float){//	trace("PhysObj.manage");
		super.manage(pTimingVariation);

	}
	
	public override function update(){//	trace("PhysObj.update");
		super.update();
				
		x= mBody.x;
		y= mBody.y;
	}

	public function getWidth(): Int		{return 0;}
	public function getHeight(): Int	{return 0;}

	public function setPos(pX: Float, pY: Float){
		mBody.x= pX;
		mBody.y= pY;

		if(mWorldPt != null)	
			mWorldPt.sync(mBody);
	}
	
	public function setAngle(pAngle: Float){
		mBody.a= pAngle;

		if(mWorldPt != null)	
			mWorldPt.sync(mBody);
	}
	
	public function setVel(pX: Float, pY: Float){
		mBody.v.x= pX;
		mBody.v.y= pY;

		if(mWorldPt != null)	
			mWorldPt.sync(mBody);
	}
	
	public function setVelAngle(pW: Float){
		mBody.w= pW;

		if(mWorldPt != null)	
			mWorldPt.sync(mBody);
	}

	public function setAccel(pX: Float, pY: Float){
		mBody.f.x= pX;
		mBody.f.y= pY;

		if(mWorldPt != null)	
			mWorldPt.sync(mBody);
	}

	public function setAccelAngle(pT: Float){
		mBody.t= pT;

		if(mWorldPt != null)	
			mWorldPt.sync(mBody);
	}
}
