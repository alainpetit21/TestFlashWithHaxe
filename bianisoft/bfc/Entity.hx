package bianisoft.bfc;

import flash.display.Sprite;
import flash.display.Loader;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.geom.Rectangle;
import flash.geom.Point;

import bianisoft.bfc.Obj;
import bianisoft.bfc.PhysObj;

class Frame2D{
	public var mRect: Rectangle;	//No picture in frame, only rectangle ref. of General EntBitmap

	public function new(pX: Float, pY: Float, pWidth: Float, pHeight: Float){	trace("EntFrame.new");
		mRect= new Rectangle(pX, pY, pWidth, pHeight);
	}
}


class State2D{
	public var mIDState: String;
	public var mArFrames: Array<Frame2D>;
	public var mNbMaxFrames: Int;
	public var mSpeed: Float;				//1.0 -> Same as Main (30fps)
	
	public function new(pIDState: String, pNbFrame: Int, ?pSpeed: Float){	trace("EntState.new");
		mIDState= pIDState;
		mArFrames= new Array();
		mNbMaxFrames= pNbFrame;
		mSpeed= if(pSpeed != null) pSpeed else 1.0;
	}
}

class Entity2D extends PhysObj2D{
	public var mResImage: String;
	public var mLoader: Loader;
	public var mArStates: Array<State2D>;
	public var mBmpSource: BitmapData;
	public var mBmpDest: BitmapData;
	
	public var mCurState: Int;
	public var mCurFrame: Int;
	public var mWidthFrame: Int;
	public var mHeightFrame: Int;

	public override function new(pID: String, pResImage: String, pRadius: Int, ?pClassID: ClassID){	trace("Entity.new");
		super(pID, pRadius, {if(pClassID == null) CLSID_Entity("CLSID_Entity"); else pClassID;});

		mArStates= new Array();
		mResImage= pResImage;
		mLoader= new Loader();

		mCurState= 0;
		mCurFrame= 0;
		mWidthFrame= 0;
		mHeightFrame= 0;

		mIsCollidable= true;
	}
	
	public override function reset(){		trace("Entity.reset");
		super.reset();
		
		mCurState= 0;
		mCurFrame= 0;
		mWidthFrame= 0;
		mHeightFrame= 0;
	}
	
	public override function load(){		trace("Entity.load");
		//Do request for image
		mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, eventLoaded);
		mLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorLoading);
		trace("Load request: " + mResImage);
		mLoader.load(new flash.net.URLRequest(mResImage));
	}
	
	public function errorLoading(pEvent: Event){
		trace("***ERROR LOADING!!***");
	}
	
	public function eventLoaded(pEvent: Event){
		trace("Finished Loading " + mResImage);
		mBmpSource= untyped mLoader.content.bitmapData;
		trace("Finished Copying " + mResImage);
		setLoaded(true);
		trace("setLoaded(true);");

		//Do calculation
		//Find Highest Frame Count within all states
		var nHighestFrameCount= 0;
		for(i in 0...mArStates.length){
			if(mArStates[i].mNbMaxFrames > nHighestFrameCount){
				nHighestFrameCount= mArStates[i].mNbMaxFrames;
			}
		}
		//Using Widht of image, and highest mNbFrame find each frame width
		mWidthFrame= cast(mBmpSource.width / nHighestFrameCount, Int);
		mHeightFrame= cast(mBmpSource.height / mArStates.length, Int);

		mBmpDest= new BitmapData(mWidthFrame, mHeightFrame);
		addChild(new Bitmap(mBmpDest));
		
		//Set All rectangles of all frames of all states
		for(i in 0...mArStates.length){
			for(j in 0...mArStates[i].mNbMaxFrames){
				mArStates[i].mArFrames[j]= new Frame2D(j*mWidthFrame, i*mHeightFrame, mWidthFrame, mHeightFrame);
			}
		}
	}
	
	public override function update(){//			trace("Entity.update");
		super.update();

		//Draw Current frame to this graphix or mBitmap	
//		trace("mBmpDest"+mBmpDest);
//		trace("mBmpDest"+mBmpDest);
//		trace("mBmpSource"+mBmpSource);
//		trace("mArStates"+mArStates);
//		trace("mCurState"+mCurState);
//		trace("mCurFrame"+mCurFrame);
//		trace("mArStates[mCurState]"+mArStates[mCurState]);
//		trace("mArStates[mCurState].mArFrames"+mArStates[mCurState].mArFrames);
//		trace("mArStates[mCurState].mArFrames[mCurFrame].mRect"+mArStates[mCurState].mArFrames[mCurFrame].mRect);
//		mBmpDest.fillRect(mBmpDest.rect, )
		mBmpDest.copyPixels(mBmpSource, mArStates[mCurState].mArFrames[mCurFrame].mRect, new Point(0, 0), null, null, false);
	}
}
