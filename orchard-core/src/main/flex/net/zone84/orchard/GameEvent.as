package net.zone84.orchard {
  import flash.events.Event;

  public class GameEvent extends Event {

    public static const FRUIT_PICKED:String = "fruitPicked";
    public static const RAVEN_PIECE_ADDED:String = "ravenPieceAdded";
    public static const GAME_ENDED:String = "gameEnded";


    public function GameEvent(type:String,bubbles:Boolean = false,cancelable:Boolean = false) {
      super(type, bubbles, cancelable);
    }
  }
}
