package tools;

import h2d.Tile;
import h2d.Anim;

class BetterAmim extends Anim {
    public var xFlip = false;
    public var yFlip = false;

    override function getFrame():Tile {
        var tile = super.getFrame();
        tile.xFlip = this.xFlip;
        tile.yFlip = this.yFlip;

        return tile;
    }
}