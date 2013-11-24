package net.zone84.orchard {
  import flash.events.EventDispatcher;

  [Event(type="net.zone84.orchard.GameEvent", name="ravenPieceAdded")]
  public class Raven extends EventDispatcher {

    private var _pieceCount:Number;

    private var _finalPieceCount:Number;

    public function Raven(finalPieceCount:Number) {
      if (finalPieceCount < 0) {
        throw new GameError("Raven piece count is too low", GameError.GAME_ERROR_RAVEN_LOW_PIECE_COUNT);
      }
      this._pieceCount = 0;
      this._finalPieceCount = finalPieceCount;
    }

    public function isComplete():Boolean {
      return this._pieceCount == this._finalPieceCount;
    }

    public function addPiece():void {
      if (this._pieceCount == _finalPieceCount) {
        throw new GameError("Raven is complete", GameError.GAME_ERROR_RAVEN_COMPLETE)
      }
      this._pieceCount++;
      dispatchEvent(new GameEvent(GameEvent.RAVEN_PIECE_ADDED));
    }


    public function get pieceCount():Number {
      return _pieceCount;
    }

    public function get finalPieceCount():Number {
      return _finalPieceCount;
    }
  }
}
