package net.zone84.orchard {
  import flash.events.EventDispatcher;

  [Event(type="net.zone84.orchard.GameEvent", name="fruitPicked")]
  public class Tree extends EventDispatcher {

    private var _fruitCount:Number;

    private var _name:String;

    public function Tree(name:String, initialFruitCount:Number) {
      if (initialFruitCount < 1) {
        throw new GameError("Initial fruit count is too low", GameError.GAME_ERROR_TREE_LOW_FRUIT_COUNT);
      }
      this._fruitCount = initialFruitCount;
      this._name = name;
    }

    public function isEmpty():Boolean {
      return _fruitCount < 1;
    }

    public function pickFruit():void {
      if (this._fruitCount == 0) {
        throw new GameError("Tree is empty", GameError.GAME_ERROR_TREE_EMPTY);
      }
      this._fruitCount--;
      dispatchEvent(new GameEvent(GameEvent.FRUIT_PICKED));
    }

    public function get name():String {
      return _name;
    }

    public function get fruitCount():Number {
      return _fruitCount;
    }
  }
}
