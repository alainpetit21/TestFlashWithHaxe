import bianisoft.bfc.App;
import bianisoft.bfc.Context;
import bianisoft.bfc.Background;
import bianisoft.helper.MngInput;

import BkLogo;

class CtxLogo extends Context{
	public override function load(){	trace("CtxLogo.load");
		super.load();
		
		//Creer 1 background
		addObjChild(new BkLogo());
		
		setLoaded(true);
	}	
	public override function keyManage(){//	trace("CtxLogo.keyManage");
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
