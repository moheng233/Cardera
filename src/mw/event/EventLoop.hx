package mw.event;

import haxe.ds.HashMap;
import sys.thread.Deque;
import sys.thread.FixedThreadPool;

/**
 * 基于多线程的事件循环实现
 */
class EventLoop extends FixedThreadPool{
    /**
     * 每秒基准逻辑
     */
    var tps = 20;

    /**
     * 事件队列
     */
    var EventDeque:Deque<Promise<Any>>;

    var NextEventDeque:Deque<Promise<Any>>;

    var CurrentTaskMap:Map<Int,Promise<Any>>;
    
    public function new() {
        this.NextEventDeque = new Deque();
        NextEventDeque.push(new Promise(function (done) {
            done("233");
        }));

        super(4);
        run(this.loop);
    }

    private function loop() {
        this.EventDeque = this.NextEventDeque;
        this.NextEventDeque = new Deque();

        while (true){
            var task = EventDeque.pop(false);
            if(task != null){
                this.run(task.task);
                if(task.loop){
                    this.NextEventDeque.push(task);
                }
            } else {
                trace("One Loop End");
                run(this.loop);
                return;
            }
        }
    }
}
