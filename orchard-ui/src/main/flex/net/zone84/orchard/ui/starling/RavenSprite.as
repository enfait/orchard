package net.zone84.orchard.ui.starling {
  import com.greensock.TweenMax;

  import flash.utils.ByteArray;

  import net.zone84.orchard.GameEvent;

  import net.zone84.orchard.Raven;

  import starling.animation.Tween;

  import starling.display.Image;
  import starling.display.Sprite;
  import starling.textures.Texture;
  import starling.textures.TextureAtlas;

  /**
   * test
   */
  public class RavenSprite extends Sprite {

    // Embed the Atlas XML
    [Embed(source="../../../../../../resources/graphics/raven_puzzle.xml", mimeType="application/octet-stream")]
    public static const AtlasXml:Class;

    [Embed(source='../../../../../../resources/graphics/raven_puzzle.atf', mimeType="application/octet-stream")]
    public var RavenATF:Class;

    public const atlasTextureNames:Array = [
      ['A1', 'B1', 'C1'],
      ['A2', 'B2', 'C2'],
      ['A3', 'B3', 'C3']
    ];

    private var currentPiece:uint = 0;

    private var raven:Raven;

    private var images:Array;

    public function RavenSprite(raven:Raven) {
      super();

      this.raven = raven;

      // create atlas
      var ravenTextureData:ByteArray = new RavenATF();
      var ravenTexture:Texture = Texture.fromAtfData(ravenTextureData);

      var xml:XML = XML(new AtlasXml());
      var atlas:TextureAtlas = new TextureAtlas(ravenTexture, xml);


      images = new Array();
      var yOffset:Number = 0;
      var subImage:Image;

      for (var i:uint = 0; i < atlasTextureNames.length; i++) {
        images.push(new Array());

        var xOffset:Number = 0;
        for (var j:uint = 0; j < atlasTextureNames[i].length; j++) {
          // display a sub-texture
          var subTexture:Texture = atlas.getTexture(atlasTextureNames[i][j]);
          subImage = new Image(subTexture);
          subImage.y = yOffset;
          subImage.x = xOffset;
          subImage.alpha = 0;
          xOffset += subImage.width;
          images[i].push(subImage);
          addChild(subImage);
        }
        yOffset += subImage.height;
      }

      raven.addEventListener(GameEvent.RAVEN_PIECE_ADDED, function(e:GameEvent):void{

        var image:Image = images[Math.floor(currentPiece/3)][currentPiece%3];

        TweenMax.to(image, 0.2, {alpha:1});

        currentPiece++;

      });

    }

  }
}

