package mw.event;

import sys.thread.Thread;

// /**
//  * 承诺
//  */
// typedef Promise = { 
//     var loop:Bool;
//     var postpone:Bool;
//     function task():Void;
//     function thentask():Void;
//     function errortask():Void;
// }

typedef PromiseDone = {
    ret: Any,
    PromiseID: Int
};

class Promise<R> {
    public var loop = false;
    public var postpone = true;

    private var PromiseID:Int;

    dynamic function task(done:R->Void) {
        
    }

    dynamic function thentask(R) {
        
    }

    public function new(task:(done:R->Void)->Void) {
        this.task = task;
    }

    public function then(task:(R -> Void)) {
        this.thentask = task;
    }

    public function done(ret:R) {
        var doneMessage:PromiseDone = {
            ret: ret,
            PromiseID: this.PromiseID
        };
        Thread.current().sendMessage(doneMessage);
        
    }
}