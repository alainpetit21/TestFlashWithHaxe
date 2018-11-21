package bianisoft.bfc;

import flash.events.EventDispatcher;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ErrorEvent;
import flash.display.MovieClip;
import haxe.Serializer;
import haxe.Timer;

import bianisoft.bfc.Obj;
import bianisoft.bfc.Context;
import bianisoft.helper.MngInput;


class App extends Obj{
	public static var gTheApp: App;
	
	public var mRoot: MovieClip;
	
	public var mCurContext(default, null): Context;
	public var mHasSound: Bool;
	public var mHas3D: Bool;
	public var mLastTime: Float;
	public var mPostLoaded: Bool;
	public var mMngInput: MngInput; 

	public override function new(pID: String, pHasSound: Bool, pHas3D: Bool){	trace("App.new");
		super(pID, CLSID_App("CLSID_App"));
		
		mRoot= flash.Lib.current;
		mRoot.addChild(this);
		
		gTheApp= this;	
		mHasSound= pHasSound;
		mHas3D= pHas3D;
		mPostLoaded= false;
		mLastTime= Timer.stamp();
		mMngInput= new MngInput();
		
		load();
	}
	public override function load(){	trace("App.load");
		super.load();

		//Sound on/off
		//3D on/off
		//Physic properties
		//etc. 
		mRoot.addEventListener(Event.ENTER_FRAME, onFrame);
		mRoot.stage.frameRate= 30;
	}
	public function postLoad(){
	}
	public function onFrame(e: flash.events.Event){	//trace("App.onFrame");
		//Make sure that everything is Loaded		
		if(!mPostLoaded && !isLoaded()){
//			trace("Waiting for a child to load");
			return;
		}
		if(!mPostLoaded){
			trace("Only Once");
			mPostLoaded= true;
			postLoad();
			trace("All loaded");
		}

		//Calculate frame lenght
		var now: Float= Timer.stamp();
		var difTime: Float= now - mLastTime;
		var varTime: Float= difTime /0.01666;
		mLastTime= now;
//		trace("Time: " + now +" "+ difTime +" "+ varTime);
		
		if(mCurContext == null)
			return;

		mMngInput.manage();
		mCurContext.keyManage();
		mCurContext.manage(varTime);
		mCurContext.update();
		mMngInput.update();
	}
	public function	setCurContext(pID: String){	trace("App.setCurContext");
		if(mCurContext != null){
			mCurContext.deActivate();
			//Find it
			//remove it from this.removeChild;
		}

		mCurContext= cast(getChildByName(pID), Context);
		mCurContext.activate();
		swapChildrenAt(getChildIndex(getChildByName(pID)), 0);
	}
}

