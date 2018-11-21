import bianisoft.bfc.App;
import bianisoft.bfc.Context;
import bianisoft.bfc.Background;
import bianisoft.helper.MngInput;

import BkTest2;

class CtxTest2 extends Context{
	public override function load(){	trace("CtxTest2.load");
		super.load();
		
		//Creer 1 background
		addObjChild(new BKTest2());
		
		setLoaded(true);
	}
	public override function keyManage(){	trace("CtxTest2.keyManage");
		if(App.gTheApp.mMngInput.isMouseButtonClicked()){
			trace("Clicked!!");
			App.gTheApp.setCurContext("CtxTest1");
		}
		if(App.gTheApp.mMngInput.isKeyboardClicked(Keys.START)){
			trace("Clicked!!");
			App.gTheApp.setCurContext("CtxTest1");
		}
	}
}
