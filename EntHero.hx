import bianisoft.bfc.Entity;

class EntHero extends Entity2D{
	public override function new(){	trace("EntHero.new");
		super("EntHero", "/Bianisoft/Test/AppTest/res/sprites/EntHero.png", 16);
//		super("EntHero", "./res/sprites/EntHero.png", 16);

		mArStates.push(new State2D("StandRight", 4));	
		mArStates.push(new State2D("StandDown", 4));	
		mArStates.push(new State2D("StandLeft", 4));	
		mArStates.push(new State2D("StandUp", 4));	
		mArStates.push(new State2D("WalkRight", 8));	
		mArStates.push(new State2D("WalkDown", 8));	
		mArStates.push(new State2D("WalkLeft", 8));	
		mArStates.push(new State2D("WalkUp", 8));	
		load();

		setPos(30, 30);
		setVel(1, 1);
		mIsCollidable= false;
	}
	
	public override function reset(){
		super.reset();
		
		setPos(30, 30);
		setVel(1, 1);
	}
	
	public override function manage(pTimingVariation: Float){//		trace("Entity.manage");
		super.manage(pTimingVariation);
		
		trace("EntHero: X,Y, vX, vY: " + mBody.x + ", " + mBody.y + ", " + mBody.v.x + ", " + mBody.v.y);

		if(++mCurFrame >= mArStates[mCurState].mNbMaxFrames){
			mCurFrame= 0;
			if(++mCurState >= mArStates.length){
				mCurState= 0;
			}
		}
	}
}
