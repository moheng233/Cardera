/**
	This class is the entry point for the app.
	It doesn't do much, except creating Main and taking care of app speed ()
**/

class Boot extends mw.BaseBoot {
	static var EventLoop:mw.event.EventLoop;

	/**
		App entry point
	**/
	static function main() {
		trace("233");
		EventLoop = new mw.event.EventLoop();

		new Boot();
	}


	/** Main app loop **/
	override function update(deltaTime:Float) {
		super.update(deltaTime);

	}
}

