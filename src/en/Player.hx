package en;

import h2d.Tile;
import h2d.Anim;
import hxd.Res;
import hxd.Key;

class Player extends Entity {
    var ca:dn.heaps.Controller.ControllerAccess;

    var idletile:Array<Tile>;
    var anim: Anim;

    public function new(x,y) {
        super(x,y);

        var g = Res.atlas.player.PrototypeHero.toBitmap();
        var idletile = Tile.autoCut(g,100,80);
        this.idletile = idletile.tiles[0].slice(0,6);
        this.anim = new Anim(this.idletile,7,spr);

        trace("Player is Render");

        ca = Main.ME.controller.createAccess("player");
    }

    override function dispose() {
        super.dispose();
        ca.dispose();
    }

    override function update() {
        super.update();

        if(ca.isKeyboardDown(Key.A)){
            dx -= 0.1*tmod;
        }
        if(ca.isKeyboardDown(Key.D)){
            dx += 0.1 *tmod;
        }
    }
}