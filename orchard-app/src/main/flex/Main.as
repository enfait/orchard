package {
  import flash.display.Sprite;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;
  import flash.events.Event;
  import flash.geom.Rectangle;

  import mx.logging.Log;


  import net.zone84.orchard.ui.GameSprite;

  import org.as3commons.logging.api.LOGGER_FACTORY;

  import org.as3commons.logging.integration.FlexLogger;
  import org.as3commons.logging.setup.SimpleTargetSetup;
  import org.as3commons.logging.setup.target.TraceTarget;

  import starling.core.Starling;

  use namespace LOGGER_FACTORY;

  {
    LOGGER_FACTORY.setup = new SimpleTargetSetup(new TraceTarget());
    Log.addTarget(new FlexLogger());
  }

  [SWF(width="800", height="480", frameRate="60", backgroundColor="#000000")]
  public class Main extends Sprite {
    private var mStarling:Starling;

    public function Main() {
      // These settings are recommended to avoid problems with touch handling
      stage.scaleMode = StageScaleMode.NO_SCALE;
      stage.align = StageAlign.TOP_LEFT;


      // Create a Starling instance that will run the "Game" class
      mStarling = new Starling(GameSprite, stage);

      stage.addEventListener(Event.RESIZE, function (e:Event):void {
        // set rectangle dimensions for viewPort:
        var viewPortRectangle:Rectangle = new Rectangle();
        viewPortRectangle.width = stage.stageWidth;
        viewPortRectangle.height = stage.stageHeight;

        // resize the viewport:
        Starling.current.viewPort = viewPortRectangle;

        mStarling.stage.stageHeight = stage.stageHeight;
        mStarling.stage.stageWidth = stage.stageWidth;


      });

      mStarling.start();
    }
  }
}