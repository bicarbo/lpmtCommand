class VLine extends Quad {

  Vect2[] centerLine = new Vect2[2];

  VLine(int id, float[] bridge, color col) {
    super(id, bridge, col);
    centerLine[0] = Vect2.lerp(corners[0], corners[1], 0.5);
    centerLine[1] = Vect2.lerp(corners[3], corners[2], 0.5);
    corners[0] = Vect2.lerp(centerLine[0], corners[0], size);
    corners[1] = Vect2.lerp(centerLine[0], corners[1], size);
    corners[2] = Vect2.lerp(centerLine[1], corners[2], size);
    corners[3] = Vect2.lerp(centerLine[1], corners[3], size);
    hide();
  }

  void shide(float time, int easingId) {
    if (x0 == centerLine[0].x) {
      aniX[0] = new Ani(this, time, "x0", corners[0].x, easings[easingId], "onUpdate:sendX0");
      aniY[0] = new Ani(this, time, "y0", corners[0].y, easings[easingId], "onUpdate:sendY0");  
      aniX[1] = new Ani(this, time, "x1", corners[1].x, easings[easingId], "onUpdate:sendX1");
      aniY[1] = new Ani(this, time, "y1", corners[1].y, easings[easingId], "onUpdate:sendY1");
      aniX[2] = new Ani(this, time, "x2", corners[2].x, easings[easingId], "onUpdate:sendX2");
      aniY[2] = new Ani(this, time, "y2", corners[2].y, easings[easingId], "onUpdate:sendY2");  
      aniX[3] = new Ani(this, time, "x3", corners[3].x, easings[easingId], "onUpdate:sendX3");
      aniY[3] = new Ani(this, time, "y3", corners[3].y, easings[easingId], "onUpdate:sendY3");
    } else {
      aniX[0] = new Ani(this, time, "x0", centerLine[0].x, easings[easingId], "onUpdate:sendX0");
      aniY[0] = new Ani(this, time, "y0", centerLine[0].y, easings[easingId], "onUpdate:sendY0");  
      aniX[1] = new Ani(this, time, "x1", centerLine[0].x, easings[easingId], "onUpdate:sendX1");
      aniY[1] = new Ani(this, time, "y1", centerLine[0].y, easings[easingId], "onUpdate:sendY1");
      aniX[2] = new Ani(this, time, "x2", centerLine[1].x, easings[easingId], "onUpdate:sendX2");
      aniY[2] = new Ani(this, time, "y2", centerLine[1].y, easings[easingId], "onUpdate:sendY2");  
      aniX[3] = new Ani(this, time, "x3", centerLine[1].x, easings[easingId], "onUpdate:sendX3");
      aniY[3] = new Ani(this, time, "y3", centerLine[1].y, easings[easingId], "onUpdate:sendY3");
    }
  }
  void scan(float time, float retard, int easingId, int sens) {// sens : 1 down -- sens : 0 up
    float pasD =.0, pasU=.0;
    reload(sens);
    if (sens==1) pasD = retard;
    else pasU = retard;
    aniX[0] = new Ani(this, time, pasD, "x0", corners[3*sens].x, easings[easingId], "onUpdate:sendX0");
    aniY[0] = new Ani(this, time, pasD, "y0", corners[3*sens].y, easings[easingId], "onUpdate:sendY0");  
    aniX[1] = new Ani(this, time, pasD, "x1", corners[1+sens].x, easings[easingId], "onUpdate:sendX1");
    aniY[1] = new Ani(this, time, pasD, "y1", corners[1+sens].y, easings[easingId], "onUpdate:sendY1");
    aniX[2] = new Ani(this, time, pasU, "x2", corners[1+sens].x, easings[easingId], "onUpdate:sendX2");
    aniY[2] = new Ani(this, time, pasU, "y2", corners[1+sens].y, easings[easingId], "onUpdate:sendY2");  
    aniX[3] = new Ani(this, time, pasU, "x3", corners[3*sens].x, easings[easingId], "onUpdate:sendX3");
    aniY[3] = new Ani(this, time, pasU, "y3", corners[3*sens].y, easings[easingId], "onUpdate:sendY3");
  }

  void reload(int v) {
    x0 = corners[3-(3*v)].x;
    y0 = corners[3-(3*v)].y;
    x1 = corners[2-v].x;
    y1 = corners[2-v].y;
    x2 = corners[2-v].x;
    y2 = corners[2-v].y;
    x3 = corners[3-(3*v)].x;
    y3 = corners[3-(3*v)].y;
    sendAll();
  }
  void hide() {
    x0 = centerLine[0].x;
    y0 = centerLine[0].y;
    x1 = centerLine[0].x;
    y1 = centerLine[0].y;
    x2 = centerLine[1].x;
    y2 = centerLine[1].y;
    x3 = centerLine[1].x;
    y3 = centerLine[1].y;
    sendAll();
  }
}
