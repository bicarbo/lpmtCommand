class HorizontalQuad extends Quad {

  HorizontalQuad(int id, float[] bridge, color col) {
    super(id, bridge, col); 
    reload(0);
  }

  void scan(float time, float retard, int easingId, int sens) {// sens : 1 down -- sens : 0 up
    float pasD =.0, pasU=.0;
    reload(sens);
    if(sens==1) pasD = retard;
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
}
