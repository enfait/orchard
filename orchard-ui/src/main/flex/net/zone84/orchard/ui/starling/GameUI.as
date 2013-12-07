package net.zone84.orchard.ui.starling {
  import com.bit101.components.Component;
  import com.bit101.components.HBox;
  import com.bit101.components.Label;
  import com.bit101.components.Meter;
  import com.bit101.components.PushButton;
  import com.bit101.components.VBox;

  import flash.display.Sprite;
  import flash.events.MouseEvent;

  import net.zone84.orchard.Game;
  import net.zone84.orchard.GameEvent;
  import net.zone84.orchard.Raven;
  import net.zone84.orchard.Tree;

  public class GameUI extends Sprite {

    protected var game:Game;

    public function GameUI(game:Game) {
      super();
      this.game = game;
      var box:VBox = new VBox();
      box.addChild(createMeters());

      var button:PushButton = new PushButton();

      button.label = "Turn";
      button.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
        game.executeTurn();
      });

      box.addChild(button);

      addChild(box);

    }

    private function createMeters():Component {

      var box:HBox = new HBox();

      box.addChild(createTreeView(game.appleTree));
      box.addChild(createTreeView(game.pearTree));
      box.addChild(createTreeView(game.cherryTree));
      box.addChild(createTreeView(game.plumTree));

      box.addChild(createRavenView(game.raven));

      return box;

    }

    private function createTreeView(tree:Tree):Component {
      var box:VBox = new VBox();
      var meter:Meter = new Meter();
      meter.minimum = 0;
      meter.maximum = tree.fruitCount;
      meter.value = tree.fruitCount;
      box.addChild(meter);
      var label:Label = new Label();
      label.text = tree.name;
      box.addChild(label);

      tree.addEventListener(GameEvent.FRUIT_PICKED, function (e:GameEvent):void {
        meter.value = tree.fruitCount;
      });

      return box;
    }

    private function createRavenView(raven:Raven):Component {
      var box:VBox = new VBox();
      var meter:Meter = new Meter();
      meter.minimum = 0;
      meter.maximum = raven.finalPieceCount;
      meter.value = 0;
      box.addChild(meter);
      var label:Label = new Label();
      label.text = "raven";
      box.addChild(label);

      raven.addEventListener(GameEvent.RAVEN_PIECE_ADDED, function (e:GameEvent):void {
        meter.value = raven.pieceCount;
      });

      return box;
    }


  }
}
