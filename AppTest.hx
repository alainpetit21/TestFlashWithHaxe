import bianisoft.bfc.Obj;
import bianisoft.bfc.Context;
import bianisoft.bfc.App;

import CtxLogo;
import CtxTest1;
import CtxTest2;
/**/
class AppTest extends App{
	public static function main(){	trace("AppTest.main");
		App.gTheApp= new AppTest("AppTest", false, false);
	}
		
	public override function load(){ 	trace("AppTest.load");
		super.load();
		
		addObjChild(new CtxLogo("CtxLogo"));		
		addObjChild(new CtxTest1("CtxTest1"));		
		addObjChild(new CtxTest2("CtxTest2"));		
		setLoaded(true);
	}
	
	public override function postLoad(){
		super.postLoad();
		setCurContext("CtxLogo"); 
	}
}
/** /

class WorldAppTest extends phx.World{
	public override function onCollide(s1: phx.Shape, s2: phx.Shape): Bool{
		if(s1.body.isCollidable && s2.body.isCollidable)
			return super.onCollide(s1, s2);
		
		return false;
	}	
}

class AppTest{
	static var world: WorldAppTest;

	static var b1: phx.Body;
	static var b2: phx.Body;
	static var b3: phx.Body;

	static var floor: phx.Shape;
	static var box1: phx.Shape;
	static var circle: phx.Shape;
	static var box2: phx.Shape;
	static var bOn: Bool;

	static function main(){
		
		var size= new phx.col.AABB(-1000, -1000, 1000, 1000);	//Size of the world
		var bf= new phx.col.SortedList();	//Broadphase: The algorithm

		world= new WorldAppTest(size,bf);		//Initialize the world

		
		b1= new phx.Body(210, -50);		//Create one 50x50 box body at x=210,y=-50
		b2= new phx.Body(200, 250);		//Create one 30 radius circle at x=200,y=250
		b3= new phx.Body(100, 270);		//Create one 20x20 box body at x=100,y=270
		
		floor= phx.Shape.makeBox(270, 50, 0, 280);	//Creates a 270x50 box at x=0,y=280
		box1= phx.Shape.makeBox(50, 50);
		circle= new phx.Circle(30, new phx.Vector(0, 0));
		box2= phx.Shape.makeBox(20, 20);

		b1.addShape(box1);
		b2.addShape(circle);
		b3.addShape(box2);

		
		world.addBody(b1);	//Add the created bodies to the world
		world.addBody(b2);
		world.addBody(b3);
		world.addStaticShape(floor);	//The floor is static, it can't move

		b1.isCollidable= false;
//		bOn= false;
//		b1.removeShape(box1);
//		b1.setPos(210, -50);
//		world.sync(b1);

//		bOn= true;
//		b1.addShape(box1);
//		world.sync(b1);

		world.gravity= new phx.Vector(0, 0.2);	//Setup gravity
		flash.Lib.current.addEventListener(flash.events.Event.ENTER_FRAME, loop);
	}

	static function loop(_) {
		// update the world
		world.step(1, 20);

		// clear the graphics
		var g= flash.Lib.current.graphics;
		g.clear();

		// draw the world
		var fd= new phx.FlashDraw(g);
		fd.drawCircleRotation= true;
		fd.drawWorld(world);
		
		trace(b1.toString() + " : PosX: " + b1.x+ " : PosY: " + b1.y);

//		if(bOn && (b1.y >= 50 && (b1.y < 150))){
//			bOn= false;
//			b1.removeShape(box1);
//			world.sync(b1);
//		}

//		if(!bOn && b1.y >= 350){
//			bOn= true;
//			b1.addShape(box1);
//			world.sync(b1);
//		}
	}
}
/ **/
