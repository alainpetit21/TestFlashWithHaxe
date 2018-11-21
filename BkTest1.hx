import bianisoft.bfc.Background;

class BKTest1 extends Background{
	public override function new(){
		super("BkTest1_1");
		
		var path= "/Bianisoft/Test/AppTest/res/back/";
//		var path= "./res/back/";
		var backLayer1= new BackgroundLayer("BkTest1_1", path+"BkTest1_1.png");
		backLayer1.setPos(0.0, 0.0);
		addObjChild(backLayer1);
		load();
	}
}
