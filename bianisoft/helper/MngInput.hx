package bianisoft.helper;

import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.events.MouseEvent;

import bianisoft.bfc.App;

typedef Vec<T>= {
	x: T, 
	y: T
};

class Keys{
	static public var RIGHT: UInt;
	static public var DOWN: UInt;
	static public var LEFT: UInt;
	static public var UP: UInt;
	static public var START: UInt;
	static public var MAXKEYS: UInt;
}

class MngInput{
	public var mKeyboard: Array<Bool>;
	public var mKeyboardBack: Array<Array<Bool>>;

	public var mMouseButton: Bool;
	public var mMouseButtonBack: Bool;

	public var mPosMouse(default, null): Vec<Float>;
	
	public function new(){
		App.gTheApp.mRoot.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		App.gTheApp.mRoot.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		App.gTheApp.mRoot.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		App.gTheApp.mRoot.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		App.gTheApp.mRoot.stage.addEventListener(MouseEvent.MOUSE_OVER, onMouseMove);
		App.gTheApp.mRoot.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				
		Keys.RIGHT=		0;
		Keys.DOWN= 		1;
		Keys.LEFT= 		2;
		Keys.UP= 		3;
		Keys.START=		4;
		Keys.MAXKEYS=	5;

		mKeyboard= [];
		mKeyboardBack= [];
		mKeyboardBack[Keys.RIGHT]= [];
		mKeyboardBack[Keys.DOWN]= [];
		mKeyboardBack[Keys.LEFT]= [];
		mKeyboardBack[Keys.UP]= [];
		mKeyboardBack[Keys.START]= [];
		mKeyboardBack[Keys.MAXKEYS]= [];
		
		mPosMouse= {x: 0.0, y: 0.0};
	}
	public function convertKeyboard(pInput): UInt{
		switch(pInput){
		case Keyboard.RIGHT:	return Keys.RIGHT;
		case Keyboard.DOWN:		return Keys.DOWN;
		case Keyboard.LEFT:		return Keys.LEFT;
		case Keyboard.UP:		return Keys.UP;
		case Keyboard.ENTER:	return Keys.START;
		}
		return Keys.MAXKEYS;
	}
	public function onKeyDown(event: KeyboardEvent){
		var value: UInt= convertKeyboard(event.keyCode);
		mKeyboard[value]= true;
		
		//If some of the 5 previous BackBuffer for that key is down
		//Then Down all 5
		if(mKeyboardBack[value][0] || mKeyboardBack[value][1] || mKeyboardBack[value][2] || mKeyboardBack[value][3] || mKeyboardBack[value][4]){
			mKeyboardBack[value][0]= mKeyboardBack[value][1]= mKeyboardBack[value][2]= mKeyboardBack[value][3]= mKeyboardBack[value][4]= true;
			trace("Filling!");
		}
	}
	public function onKeyUp(event: KeyboardEvent){
		mKeyboard[convertKeyboard(event.keyCode)]= false;
	}
	public function onMouseDown(event: MouseEvent){
		mMouseButton= true;
	}
	public function onMouseUp(event: MouseEvent){
		mMouseButton= false;
	}
	public function onMouseMove(event: MouseEvent){
		mPosMouse.x= event.localX;
		mPosMouse.y= event.localY;
	}
	public function update(){
		for(i in 0...mKeyboard.length){
			mKeyboardBack[i].push(mKeyboard[i]);
		}
		//Array of keys
		for(i in 0...mKeyboardBack.length){
			//Array of holding for each keys
			if(mKeyboardBack[i].length > 5){
				mKeyboardBack[i].shift();
			}
		}
//		trace(mKeyboardBack[0].length);

		mMouseButtonBack= mMouseButton;
	}
	public function manage(){
		//Debug
		var temp: String= "";
		for(i in 0...mKeyboard.length){
			if(mKeyboard[i])
				temp+= '1';
			else
				temp+= '0';
		}		
//		trace("mKeyboard: " + temp);		
		temp= "";
		for(i in 0...mKeyboardBack[0].length){
			if(mKeyboardBack[0][i])
				temp+= '1';
			else
				temp+= '0';
		}		
//		trace("mKeyboardBack[0]: " + temp);
	}
	public function isKeyboardDown(pKeyCode: Int): Bool{
		return (mKeyboard[pKeyCode] || mKeyboardBack[pKeyCode][0]);
	}
	public function isKeyboardClicked(pKeyCode: Int): Bool{
		return (!mKeyboard[pKeyCode] && (mKeyboardBack[pKeyCode][0] 
									 && !mKeyboardBack[pKeyCode][1] && !mKeyboardBack[pKeyCode][2] 
									 && !mKeyboardBack[pKeyCode][3] && !mKeyboardBack[pKeyCode][4]));
	}
	public function isMouseButtonDown(): Bool{
		return (mMouseButton && mMouseButtonBack);
	}
	public function isMouseButtonClicked(): Bool{
		return (!mMouseButton && mMouseButtonBack);
	}
}

