package net.zone84.orchard.ui {
  import flash.geom.Point;
  import flash.utils.ByteArray;

  import net.zone84.orchard.Game;
  import net.zone84.orchard.GameEvent;
  import net.zone84.orchard.Raven;
  import net.zone84.orchard.Tree;

  import starling.display.Button;

  import starling.display.DisplayObject;
  import starling.display.Image;
  import starling.display.Sprite;
  import starling.events.Event;
  import starling.events.Touch;
  import starling.events.TouchEvent;
  import starling.events.TouchPhase;
  import starling.filters.BlurFilter;
  import starling.text.TextField;
  import starling.textures.Texture;
  import starling.utils.Color;

  public class GameSprite extends Sprite {

    public var SCALE:Number = 0.4;

    [Embed(source='../../../../../resources/graphics/tree.atf', mimeType="application/octet-stream")]
    public var TreeATF:Class;

    [Embed(source='../../../../../resources/graphics/apple.atf', mimeType="application/octet-stream")]
    public var AppleATF:Class;

    [Embed(source='../../../../../resources/graphics/cherry.atf', mimeType="application/octet-stream")]
    public var CherryATF:Class;

    [Embed(source='../../../../../resources/graphics/pear.atf', mimeType="application/octet-stream")]
    public var PearATF:Class;

    [Embed(source='../../../../../resources/graphics/plum.atf', mimeType="application/octet-stream")]
    public var PlumATF:Class;

    [Embed(source='../../../../../resources/graphics/raven.atf', mimeType="application/octet-stream")]
    public var RavenATF:Class;

    public function GameSprite() {
//      var quad:Quad = new Quad(200, 200, Color.RED);
//      quad.x = 100;
//      quad.y = 50;
//      addChild(quad);

      var game:Game = new Game();
      game.initialize();


      var treeTextureData:ByteArray = new TreeATF();
      var treeTexture:Texture = Texture.fromAtfData(treeTextureData);

      var appleTextureData:ByteArray = new AppleATF();
      var appleTexture:Texture = Texture.fromAtfData(appleTextureData);

      var cherryTextureData:ByteArray = new CherryATF();
      var cherryTexture:Texture = Texture.fromAtfData(cherryTextureData);

      var pearTextureData:ByteArray = new PearATF();
      var pearTexture:Texture = Texture.fromAtfData(pearTextureData);

      var plumTextureData:ByteArray = new PlumATF();
      var plumTexture:Texture = Texture.fromAtfData(plumTextureData);

      var ravenTextureData:ByteArray = new RavenATF();
      var ravenTexture:Texture = Texture.fromAtfData(ravenTextureData);


      var tree:DisplayObject;

      var textures:Array = [appleTexture, cherryTexture, pearTexture, plumTexture];
      var trees:Array = [game.appleTree, game.cherryTree, game.pearTree, game.plumTree];

      for (var i:uint = 0; i < 4; i++) {
        tree = createTree(treeTexture, textures[i], trees[i]);

        tree.x = i * 400;
        addChild(tree);
      }

      var raven:DisplayObject = createRaven(ravenTexture, game.raven);

      raven.x = 800;
      raven.y = 600;

      addChild(raven);





      var textfield:TextField = new TextField(128, 128, "Play", "Arial", 12, Color.AQUA);
      textfield.border = true;
      textfield.addEventListener(TouchEvent.TOUCH, function(e:TouchEvent):void{
        if (e.getTouch(textfield, TouchPhase.BEGAN)) {
          game.executeTurn();
        }
      });

      textfield.y = 500;

      addChild(textfield);

    }

    private function createTree(treeTexture:Texture, fruitTexture:Texture, tree:Tree):DisplayObject {

      var image:Image = new Image(treeTexture);

      var treeSprite:Sprite = new Sprite();
      treeSprite.addChild(image);
      for (var i:uint = 0; i < tree.fruitCount; i++) {
        treeSprite.addChild(createApple(fruitTexture));
      }
      treeSprite.scaleX = SCALE;
      treeSprite.scaleY = SCALE;

      tree.addEventListener(GameEvent.FRUIT_PICKED, function (e:GameEvent):void {
        treeSprite.removeChildAt(1);
      });

      return treeSprite;


    }


    private function createApple(fruitTexture:Texture):DisplayObject {

      var blur:BlurFilter = BlurFilter.createDropShadow();

      var fruitImage:Image = new Image(fruitTexture);
      fruitImage.alignPivot();
      fruitImage.filter = blur;


      fruitImage.x = Math.random() * (1024 - 128) + 64;
      fruitImage.y = Math.random() * (512 - 128) + 64;

      fruitImage.addEventListener(TouchEvent.TOUCH, function (e:TouchEvent):void {

        var touch:Touch = e.getTouch(fruitImage);
        if (touch && touch.phase == TouchPhase.MOVED) {
          var currentPos:Point = touch.getLocation(fruitImage.parent);

          fruitImage.x = currentPos.x;
          fruitImage.y = currentPos.y;


        }

      });

      return fruitImage;

    }

    private function createRaven(ravenTexture:Texture, raven:Raven):DisplayObject {

      var ravenImage:Image = new Image(ravenTexture);
      ravenImage.alignPivot();
      ravenImage.scaleX = 0;
      ravenImage.scaleY = 0;

      raven.addEventListener(GameEvent.RAVEN_PIECE_ADDED, function (e:GameEvent):void {
        ravenImage.scaleX = raven.pieceCount / raven.finalPieceCount;
        ravenImage.scaleY = raven.pieceCount / raven.finalPieceCount;
      });

      return ravenImage;


    }
  }
}