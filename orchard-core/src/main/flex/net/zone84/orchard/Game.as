package net.zone84.orchard {
  import mx.logging.ILogger;
  import mx.logging.Log;

  /**
   * Main game logic
   *
   * TODO phases: die throw, fruit pickup
   * TODO dispatch event for failure & victory
   */
  public class Game {

    private static var logger:ILogger = Log.getLogger("net.zone84.orchard.Game");


    public static const DIE_NUMBER_APPLE:String = "apple";
    public static const DIE_NUMBER_PEAR:String = "pear";
    public static const DIE_NUMBER_PLUM:String = "plum";
    public static const DIE_NUMBER_CHERRY:String = "cherry";
    public static const DIE_NUMBER_BASKET:String = "basket";
    public static const DIE_NUMBER_RAVEN:String = "_raven";

    public static const DIE_FACES:Array = [
      DIE_NUMBER_APPLE, DIE_NUMBER_BASKET, DIE_NUMBER_CHERRY,
      DIE_NUMBER_PEAR, DIE_NUMBER_PLUM, DIE_NUMBER_RAVEN,
    ];

    public static const GAME_CONTINUE:String = "continue";
    public static const GAME_VICTORY:String = "victory";
    public static const GAME_FAILURE:String = "failure";


    protected var die:Die;

    private var _appleTree:Tree;

    private var _pearTree:Tree;

    private var _plumTree:Tree;

    private var _cherryTree:Tree;

    private var _raven:Raven;

    public function Game() {
    }

    public function initialize():void {

      logger.debug("initialize()");

      this.die = new Die(5);

      this._appleTree = new Tree("apple", 10);
      this._pearTree = new Tree("pear", 10);
      this._plumTree = new Tree("plum", 10);
      this._cherryTree = new Tree("cherry", 10);

      this._raven = new Raven(9);

    }

    public function executeTurn():String {

      logger.debug("Turn start");

      logger.debug("Apples: {0}, Pears: {1}, Cherries: {2}, Plums: {3}, Raven: {4}/{5}", _appleTree.fruitCount, _pearTree.fruitCount, _cherryTree.fruitCount, _plumTree.fruitCount, _raven.pieceCount, _raven.finalPieceCount)

      if (_appleTree.isEmpty() && _pearTree.isEmpty() && _plumTree.isEmpty() && _cherryTree.isEmpty()) {
        // game end: victory
        logger.debug("Victory");
        return GAME_VICTORY;
      } else if (_raven.isComplete()) {
        // game end: failure
        logger.debug("Failure");
        return GAME_FAILURE;
      }


      var dieRoll:Number = die.throwDie();

      logger.debug("Die roll: {0}", dieRoll);
      logger.debug("Face: {0}", DIE_FACES[dieRoll]);

      switch (DIE_FACES[dieRoll]) {
        case DIE_NUMBER_APPLE:
        case DIE_NUMBER_CHERRY:
        case DIE_NUMBER_PEAR:
        case DIE_NUMBER_PLUM:

          logger.debug("== Fruit face");
          var tree:Tree;

          switch (DIE_FACES[dieRoll]) {
            case DIE_NUMBER_APPLE:
              tree = _appleTree;
              break;
            case DIE_NUMBER_CHERRY:
              tree = _cherryTree;
              break;
            case DIE_NUMBER_PEAR:
              tree = _pearTree;
              break;
            case DIE_NUMBER_PLUM:
              tree = _plumTree;
              break;

          }

          if (!tree.isEmpty()) {
            pickFruitOn(tree);
          } else {
            logger.debug("{0} tree is empty", tree.name);
          }
          break;

        case DIE_NUMBER_BASKET:
          logger.debug("== Basket");
          var fruitPicked:Number = 0;
          for each(var tree:Tree in [_appleTree, _cherryTree, _pearTree, _plumTree]) {
            if (fruitPicked == 2) {
              break;
            }
            if (!tree.isEmpty()) {
              pickFruitOn(tree);
              fruitPicked++;
              if (!tree.isEmpty() && fruitPicked < 2) {
                pickFruitOn(tree);
                fruitPicked++;
              }
            }
          }
          break;

        case DIE_NUMBER_RAVEN:
          logger.debug("== Raven");
          logger.debug("Add a piece to the raven");
          _raven.addPiece();
          logger.debug("Raven is now {0} piece(s) out of {1}", _raven.pieceCount, _raven.finalPieceCount);
          break;

      }


      return GAME_CONTINUE;

    }

    public function pickFruitOn(tree:Tree):void {
      logger.debug("Pick a {0}", tree.name);
      tree.pickFruit();
      logger.debug("{1} {0}(s) left", tree.name, tree.fruitCount);
    }


    public function get appleTree():Tree {
      return _appleTree;
    }

    public function get pearTree():Tree {
      return _pearTree;
    }

    public function get plumTree():Tree {
      return _plumTree;
    }

    public function get raven():Raven {
      return _raven;
    }

    public function get cherryTree():Tree {
      return _cherryTree;
    }
  }
}
