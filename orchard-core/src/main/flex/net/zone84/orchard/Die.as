package net.zone84.orchard {

  /**
   * This is the die which generate random throws.
   */
  public class Die {

    protected var maximum:Number;

    public function Die(maximum:Number) {
      this.maximum = maximum;
    }

    public function throwDie():Number {

      return Math.round(Math.random() * maximum);

    }

  }
}
