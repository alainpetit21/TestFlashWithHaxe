package bianisoft.bfc;

import flash.display.Sprite;
import flash.display.Loader;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.events.IOErrorEvent;

import bianisoft.bfc.App;
import bianisoft.bfc.Obj;
import bianisoft.bfc.PhysObj;

class BackgroundLayer extends PhysObj2D{
	public var mResImage: String;
	public var mLoader: Loader;
	public var mBmpDest: BitmapData;

	public override function new(pID: String, ?pResImage: String){	trace("BackgroundLayer.new");
		super(pID, null, CLSID_BackgroundLayer("CLSID_BackgroundLayer"));
		mResImage= pResImage;
		mLoader= new Loader();
	}
	public override function load(){	trace("BackgroundLayer.load");
		super.load();
		
		//Load the bitmap;
		mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, eventLoaded);
		mLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorLoading);
		trace("Load request: " + mResImage);
		mLoader.load(new flash.net.URLRequest(mResImage));
	}
	public function errorLoading(pEvent: Event){ 
		trace("***ERROR LOADING!!***");
	}
	public function eventLoaded(pEvent: Event){ 
		trace("Finished Loading " + name);
		mBmpDest= untyped mLoader.content.bitmapData;
		addChild(new Bitmap(mBmpDest));
		trace("Finished Copying " + name);
		setLoaded(true);
	}
}

class Background extends Obj{
	public override function new(pID: String){	trace("Background.new");
		super(pID, CLSID_Background("CLSID_Background"));
		setLoaded(true);
	}
	public override function load(){
		for(i in 0...numChildren){
			if(!Std.is(getChildAt(i), Obj)){
				continue;
			}
			cast(getChildAt(i), Obj).load();
		}							
	}
}
