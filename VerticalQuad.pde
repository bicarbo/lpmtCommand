class VerticalQuad extends Quad {

  VerticalQuad(int id, float[] bridge, color col) {
    super(id, bridge, col); 
    reload(0);
  }

  void scan(float time, float retard, int easingId, int sens) {// sens : 1 left -- sens : 0 right
    float pasL=.0, pasR=.0;
    reload(sens);
    if(sens==1) pasL = retard;
    else pasR = retard;
    aniX[0] = new Ani(this, time, pasR, "x0", corners[1-sens].x, easings[easingId], "onUpdate:sendX0");
    aniY[0] = new Ani(this, time, pasR, "y0", corners[1-sens].y, easings[easingId], "onUpdate:sendY0");  
    aniX[1] = new Ani(this, time, pasL, "x1", corners[1-sens].x, easings[easingId], "onUpdate:sendX1");
    aniY[1] = new Ani(this, time, pasL, "y1", corners[1-sens].y, easings[easingId], "onUpdate:sendY1");
    aniX[2] = new Ani(this, time, pasL, "x2", corners[2+sens].x, easings[easingId], "onUpdate:sendX2");
    aniY[2] = new Ani(this, time, pasL, "y2", corners[2+sens].y, easings[easingId], "onUpdate:sendY2");  
    aniX[3] = new Ani(this, time, pasR, "x3", corners[2+sens].x, easings[easingId], "onUpdate:sendX3");
    aniY[3] = new Ani(this, time, pasR, "y3", corners[2+sens].y, easings[easingId], "onUpdate:sendY3");
  }

  void reload(int v) {
    x0 = corners[v].x;
    y0 = corners[v].y;
    x1 = corners[v].x;
    y1 = corners[v].y;
    x2 = corners[3-v].x;
    y2 = corners[3-v].y;
    x3 = corners[3-v].x;
    y3 = corners[3-v].y;
    sendAll();
  }
} 
