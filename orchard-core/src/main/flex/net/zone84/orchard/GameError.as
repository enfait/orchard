package net.zone84.orchard {
  public class GameError extends Error {

    public static const GAME_ERROR_TREE_EMPTY:Number = 1001;
    public static const GAME_ERROR_TREE_LOW_FRUIT_COUNT:Number = 1002;
    public static const GAME_ERROR_RAVEN_COMPLETE:Number = 2001;
    public static const GAME_ERROR_RAVEN_LOW_PIECE_COUNT:Number = 2002;

    public function GameError(message:* = "", id:* = 0) {
      super(message, id);
    }
  }
}
