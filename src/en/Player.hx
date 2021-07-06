package en;

import h2d.Tile;
import h2d.Anim;
import hxd.Res;
import hxd.Key;

enum PlayerState {
    IDLE;
    RUN;
}

enum PlayerRunState {
    RUNSTART;
    RUN;
    RUNEND;
}

enum PlayerFaceState {
    RIGHT;
    LEFT;
}

class Player extends Entity {
    var ca:dn.heaps.Controller.ControllerAccess;

    var state:PlayerState = IDLE;
    var runstate:PlayerRunState = RUNSTART;
    var facestate:PlayerFaceState = LEFT;

    var idletile:Array<Tile>;
    var runstarttile:Array<Tile>;
    var runtile:Array<Tile>;
    var runendtile:Array<Tile>;

    var anim: Anim;

    public function new(x,y) {
        super(x,y);

        var g = Res.atlas.player.PrototypeHero.toBitmap();
        var tile = Tile.autoCut(g,100,80);

        this.idletile = tile.tiles[0].slice(0,6);
        for (t in this.idletile){
            t.setCenterRatio();
        }

        this.runstarttile = tile.tiles[0].slice(7);
        for (t in this.runstarttile){
            t.setCenterRatio();
        }
        this.runtile = tile.tiles[1];
        for (t in this.runtile){
            t.setCenterRatio();
        }
        
        this.runendtile = tile.tiles[2].slice(0,2);
        for (t in this.runendtile){
            t.setCenterRatio();
        }

        this.anim = new Anim(this.idletile,7,spr);
        // this.anim.fading = true;
        trace("Player is Render");

        ca = Main.ME.controller.createAccess("player");
    }

    /**
     * 切换到状态
     */
    public function toState(state: PlayerState) {
        trace("Player State To "+state.getName());
        switch state {
            case IDLE:
                this.anim.play(idletile);
            case RUN:
                this.toRunState(RUNSTART);
            case _:

        }

        this.state = state;
    }

    public function toRunState(state:PlayerRunState) {
        trace("Player Run State To "+state.getName());
        switch state {
            case RUNSTART:
                this.anim.play(this.runstarttile);
                this.anim.onAnimEnd = function animend() {
                    this.toRunState(RUN);
                    this.anim.onAnimEnd = function animend() {};
                }
            case RUN:
                this.anim.play(this.runtile);
            case RUNEND:
                this.anim.play(this.runendtile);
                this.anim.onAnimEnd = function animend() {
                    this.toState(IDLE);
                    this.anim.onAnimEnd = function animend() {};
                }
        }

        this.runstate = state;
    }

    /**
     * 根据不同状态进行刷新
     */
    public function updateState() {
        switch this.state {
            case IDLE:
                if(this.dx != 0 && (ca.isKeyboardDown(Key.A) || ca.isKeyboardDown(Key.D))){
                    this.toState(RUN);
                }
            case RUN:
                this.updateRunState();
            case _:
                
        }
    }

    public function updateRunState() {
        switch  this.runstate {
            case RUN:
                if(!(ca.isKeyboardDown(Key.A) || ca.isKeyboardDown(Key.D))){
                    this.toRunState(RUNEND);
                }
            case _:
        }
    }

    override function dispose() {
        super.dispose();
        ca.dispose();
    }

    override function update() {
        super.update();

        if(ca.isKeyboardDown(Key.A)){
            dx -= 0.1*tmod;
            this.facestate = RIGHT;
        }
        if(ca.isKeyboardDown(Key.D)){
            dx += 0.1 *tmod;
            this.facestate = LEFT;
        }

        if(this.facestate == RIGHT){
            this.anim.getFrame().xFlip = true;
        }
        if(this.facestate == LEFT){
            this.anim.getFrame().xFlip = false;
        }

        this.updateState();
    }
}