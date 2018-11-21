import bianisoft.bfc.App;
import bianisoft.bfc.Context;
import bianisoft.bfc.Background;
import bianisoft.helper.MngInput;

import BkTest1;

class CtxTest1 extends Context{
	public override function load(){	trace("CtxTest1.load");
		super.load();
		
		//Creer 1 background
		addObjChild(new BKTest1());
		addObjChild(new EntHero());
		
		setLoaded(true);
	}
	
	public override function activate(){	trace("CtxTest1.activate");
		super.activate();

		cast(getChildByName("EntHero"), EntHero).reset();
	}
	
	public override function keyManage(){//	trace("CtxTest1.keyManage");
		if(App.gTheApp.mMngInput.isMouseButtonClicked()){
			trace("Clicked!!");
			App.gTheApp.setCurContext("CtxTest2");
		}
		if(App.gTheApp.mMngInput.isKeyboardClicked(Keys.START)){
			trace("Clicked!!");
			App.gTheApp.setCurContext("CtxTest2");
		}
	}
}
