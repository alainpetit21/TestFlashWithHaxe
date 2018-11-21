package bianisoft.bfc;

import phx.World;
import phx.Shape;
import phx.col.AABB;
import phx.col.SortedList;
import bianisoft.bfc.PhysObj;
import bianisoft.bfc.Obj;
import bianisoft.bfc.Entity;
import bianisoft.bfc.Camera;
import bianisoft.bfc.Background;

class WorldContext extends World{
	public override function onCollide(s1: Shape, s2: Shape): Bool{
		if(s1.body.isCollidable && s2.body.isCollidable)
			return super.onCollide(s1, s2);
		
		return false;
	}	
}

class Context extends Obj{
	public var mContextID:	Int;
	public var mCamera2D:	Camera2D;
	
	public var mCurBackground:	Background;
	public var mMouse:	Entity2D;

	public var mCollidingWorld: World;

	public override function new(pID: String){	trace("Context.new");
		super(pID, CLSID_Context("CLSID_Context"));
		load();
		
		mCamera2D= new Camera2D("Cam2D_Default");
		mCamera2D.setPos(0.0, 0.0);
		mCamera2D.name= "Camera2D";
		mCamera2D.setAngle(0.0);
		mCamera2D.setCurrent();
		addObjChild(mCamera2D);
		
		var size= new AABB(-10000, -10000, 10000, 10000);
		var bf= new SortedList();
		mCollidingWorld= new World(size, bf);

		//AddAllCollibablesChilds
		for(i in 0...numChildren){
			if(Std.is(getChildAt(i), PhysObj2D)){
				var objPhys2D= cast(getChildAt(i), PhysObj2D);
				
				mCollidingWorld.addBody(objPhys2D.mBody);
				objPhys2D.mWorldPt= mCollidingWorld;
			}
		}
	}
	
	public override function setLoaded(pLoaded: Bool): Bool{
		var ret= super.setLoaded(pLoaded);
		visible= false;
		return ret;
	}
	
	public function activate(){	trace("Context.activate");
		visible= true;
		
	}
	
	public function deActivate(){	trace("Context.deActivate");
		visible= false;

		//RemoveAllCollibablesChilds
	}
	
	public function keyManage(){//	trace("Context.keyManage");
	}

	public function setMouse(pEntMouse: Entity2D){	trace("Context.setMouse");
	}
	
	public function findAt(pX: Int, pY: Int, ?pZ){	trace("Context.findAt");
	}
	
	public override function manage(pTimingVariation: Float){//	trace("Context.manage");
		super.manage(pTimingVariation);
		
		mCollidingWorld.step(1, 20);
//
//			
	//	// draw the world
//		var g= flash.Lib.current.graphics;
//		g.clear();/
//
//		var fd= new phx.FlashDraw(flash.Lib.current.graphics);
//		fd.drawCircleRotation= true;
//		fd.drawWorld(mCollidingWorld);
		
	}
//	public function findByID(pX: Int, pY: Int, ?pZ)
//	public function findByIDUnder(pX: Int, pY: Int, ?pZ)
//	public function findByRtti(pX: Int, pY: Int, ?pZ)

//	void	AddMap(u32 p_type, const char * p_idControl, TCallback p_fctMapped);
//	void	AddMap(u32 p_type, CEntity* p_pButton, TCallback p_fctMapped);
//	void	Click(const char *p_idControl);
//	void	Click(CEntity *p_pObj);

//	int		AddTimer(int nDelay, void (CContext::*p_pFct)(void));
//	void	ResetTimers();
}

