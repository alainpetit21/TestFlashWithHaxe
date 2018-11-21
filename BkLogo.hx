import bianisoft.bfc.Background;

class BkLogo extends Background{
	public override function new(){
		super("BkBianiSoftLogo");
		
		var path= "/Bianisoft/Test/AppTest/res/back/";
//		var path= "./res/back/";
		var backLayer1= new BackgroundLayer("BkBianiSoftLogo", path+"BkBianiSoftLogo.png");
		backLayer1.setPos(0.0, 0.0);
		addObjChild(backLayer1);
		load();
	}
}
