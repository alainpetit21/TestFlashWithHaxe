package bianisoft.bfc;

import flash.display.Sprite;
import flash.display.DisplayObject;

enum ClassID{
	CLSID_Obj(stID: String);
	CLSID_App(stID: String);
	CLSID_Context(stID: String);
	CLSID_Font(stID: String);
	CLSID_Dictionary(stID: String);
	CLSID_SceneEngine(stID: String);
	CLSID_PhysObj(stID: String);
	CLSID_Background(stID: String);
	CLSID_BackgroundLayer(stID: String);
	CLSID_BackgroundLayerLooping(stID: String);
	CLSID_BackgroundLayerTiled(stID: String);
	CLSID_Camera2D(stID: String);
	CLSID_Camera3D(stID: String);
	CLSID_Entity(stID: String);
	CLSID_Entity3D(stID: String);
	CLSID_Sprite3D(stID: String);
	CLSID_Maze3D(stID: String);
	CLSID_Button(stID: String);
	CLSID_Label(stID: String);
	CLSID_LabelGradual(stID: String);
	CLSID_Sound(stID: String);
	CLSID_Music(stID: String);
}

class Obj extends Sprite{
	public var	mClassID:	ClassID;
	public var	mParent:	Obj;
	public var	mIsLoaded(isLoaded, setLoaded):	Bool;

	public function new(pID:String, ?pClassID: ClassID){	trace("Obj.new " + pClassID);
		super();
		name= pID;
		mClassID= if(pClassID == null) CLSID_Obj("CLSID_Obj") else pClassID;
		mIsLoaded= false;

		alpha= 1.0;
		scaleX= 1.0;
		scaleY= 1.0;
		visible= true;
	}

	public function reset(){
		alpha= 1.0;
		scaleX= 1.0;
		scaleY= 1.0;
		visible= true;
	}
	
	public function load(){	trace("Obj.load");
	}
	
	public function setLoaded(pLoaded: Bool): Bool{
		if(pLoaded)
			reset();
			
		return mIsLoaded= pLoaded;
	}
	
	public function isLoaded(): Bool{
		for(i in 0...numChildren){
			if(!Std.is(getChildAt(i), Obj)){
//				trace("This NOT is a Dakiisoft Obj");
				continue;
			}
			if(cast(getChildAt(i), Obj).isLoaded() == false){
				return false;
			}
		}
		if(mIsLoaded == false){
//			trace("Still Loading: " + name);
			return false;
		}
		return true;
	}
	
	public function manage(pTimingVariation: Float){//	trace("Obj.manage");
		for(i in 0...numChildren){
			if(!Std.is(getChildAt(i), Obj)){
//				trace("This NOT is a Dakiisoft Obj");
				continue;
			}
			cast(getChildAt(i), Obj).manage(pTimingVariation);
		}
	} 
	
	public function update(){//	trace("Obj.update");
		for(i in 0...numChildren){
			if(!Std.is(getChildAt(i), Obj)){
//				trace("This NOT is a Dakiisoft Obj");
				continue;
			}
			cast(getChildAt(i), Obj).update();
		}
	}
	
	public function addObjChild(pObj: Obj): Obj{	trace("Obj.addObjChild");
		pObj.mParent= this;
		
		return cast(super.addChild(pObj), Obj);
	}
}

