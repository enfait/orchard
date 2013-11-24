package {
  import flash.display.Sprite;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;

  import mx.logging.Log;

  import net.zone84.orchard.Game;
  import net.zone84.orchard.ui.GameUI;

  import org.as3commons.logging.api.LOGGER_FACTORY;
  import org.as3commons.logging.integration.FlexLogger;
  import org.as3commons.logging.setup.SimpleTargetSetup;
  import org.as3commons.logging.setup.target.TraceTarget;

  use namespace LOGGER_FACTORY;

  {
    LOGGER_FACTORY.setup = new SimpleTargetSetup(new TraceTarget());
    Log.addTarget(new FlexLogger());
  }

  public class Main extends Sprite {
    public function Main() {
      super();

      stage.scaleMode = StageScaleMode.NO_SCALE;
      stage.align = StageAlign.TOP_LEFT;

      var game:Game = new Game();
      game.initialize();
      addChild(new GameUI(game));

//
//      while (game.executeTurn() == Game.GAME_CONTINUE) {
//
//      }
    }
  }
}
