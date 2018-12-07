class SquareQuad extends Quad {

  Vect2 center;
  Ani[] aniX = new Ani[4];
  Ani[] aniY = new Ani[4];
  Vect2[] tilt = new Vect2[4];
  Ani anW, anH, anX, anY; 
  int rotation, x, y, w, h;
  int newSens, newEasingId;
  float newTime;
  boolean moves;

  SquareQuad(int id, float[] bridge, color col) {
    super(id, bridge, col);
    center = new Vect2(Space2.lineIntersection(corners[0], corners[2], corners[1], corners[3]));
    for (int i=0; i<4; i++) tilt[i] = new Vect2();
  }

  void turn(float time, int sens, int easingId) {
    rotation = (rotation<0) ? 3 :(rotation+sens)%4;
    aniX[0] = new Ani(this, time, "x0", corners[(rotation+4)%4].x, easings[easingId], "onUpdate:sendX0");
    aniY[0] = new Ani(this, time, "y0", corners[(rotation+4)%4].y, easings[easingId], "onUpdate:sendY0");  
    aniX[1] = new Ani(this, time, "x1", corners[(rotation+1)%4].x, easings[easingId], "onUpdate:sendX1");
    aniY[1] = new Ani(this, time, "y1", corners[(rotation+1)%4].y, easings[easingId], "onUpdate:sendY1");
    aniX[2] = new Ani(this, time, "x2", corners[(rotation+2)%4].x, easings[easingId], "onUpdate:sendX2");
    aniY[2] = new Ani(this, time, "y2", corners[(rotation+2)%4].y, easings[easingId], "onUpdate:sendY2");  
    aniX[3] = new Ani(this, time, "x3", corners[(rotation+3)%4].x, easings[easingId], "onUpdate:sendX3");
    aniY[3] = new Ani(this, time, "y3", corners[(rotation+3)%4].y, easings[easingId], "onUpdate:sendY3");
  }

  void flip(float time, int s, int easingId) {
    reload();
    aniX[0] = new Ani(this, time, "x0", corners[(3-(2*s))%4].x, easings[easingId], "onUpdate:sendX0");
    aniY[0] = new Ani(this, time, "y0", corners[(3-(2*s))%4].y, easings[easingId], "onUpdate:sendY0");
    aniX[1] = new Ani(this, time, "x1", corners[(2-(2*s))%4].x, easings[easingId], "onUpdate:sendX1");
    aniY[1] = new Ani(this, time, "y1", corners[(2-(2*s))%4].y, easings[easingId], "onUpdate:sendY1");
    aniX[2] = new Ani(this, time, "x2", corners[((1-(2*s))+4)%4].x, easings[easingId], "onUpdate:sendX2");
    aniY[2] = new Ani(this, time, "y2", corners[((1-(2*s))+4)%4].y, easings[easingId], "onUpdate:sendY2");
    aniX[3] = new Ani(this, time, "x3", corners[((2*s))%4].x, easings[easingId], "onUpdate:sendX3");
    aniY[3] = new Ani(this, time, "y3", corners[((2*s))%4].y, easings[easingId], "onUpdate:sendY3");
  }

  void tilt(int sens, float offset) {
    if (sens == 0) {
      tilt[0] = Vect2.lerp(corners[3], corners[0], offset);
      tilt[1] = Vect2.lerp(corners[2], corners[1], offset);
      tilt[2] = corners[2];
      tilt[3] = corners[3];
    } else if (sens == 1) {
      tilt[0] = corners[0];
      tilt[1] = Vect2.lerp(corners[0], corners[1], offset);
      tilt[2] = Vect2.lerp(corners[3], corners[2], offset);
      tilt[3] =  corners[3];
    } else if (sens == 2) {
      tilt[0] = corners[0];
      tilt[1] = corners[1];
      tilt[2] = Vect2.lerp(corners[1], corners[2], offset);
      tilt[3] = Vect2.lerp(corners[0], corners[3], offset);
    } else if (sens == 3) {
      tilt[0] = Vect2.lerp(corners[1], corners[0], offset);
      tilt[1] = corners[1];
      tilt[2] = corners[2];
      tilt[3] = Vect2.lerp(corners[2], corners[3], offset);
    }
    x0 = tilt[0].x;
    y0 = tilt[0].y;
    x1 = tilt[1].x;
    y1 = tilt[1].y;
    x2 = tilt[2].x;
    y2 = tilt[2].y;
    x3 = tilt[3].x;
    y3 = tilt[3].y;
    sendAll();
  }

  void hide(int a, int b, int c, int d) {
    x = a;
    y = b;
    w = c;
    h = d;
    sendPlacement('x', a);
    sendPlacement('y', b);
    sendPlacement('w', c);
    sendPlacement('h', d);
  }

  void reMove(float time, int easingId, int sens) {
    reload();
    moves = true;
    newSens = int(sens/4)-1;
    move(newTime=time/2.0, newEasingId=easingId, sens%4);    
  }
    void move(float time, int easingId, int sens) {
      if (sens==0) goUp(time, easingId);
      else if (sens==1) goLeft(time, easingId);
      else if (sens==2) goDown(time, easingId);
      else if (sens==3) goRight(time, easingId);
    }

    void goRight(float time, int easingId) {
      if (x==projectorWidth || y==projectorHeight ||  w==0 || h==0) {
        hide(projectorWidth, 0, 0, projectorHeight);
        anX = new Ani(this, time, "x", 0, easings[easingId], "onUpdate:sendX");
        anW = new Ani(this, time, "w", projectorWidth, easings[easingId], "onUpdate:sendW, onEnd:isPassed");
      } else { 
        anX = new Ani(this, time, "x", projectorWidth, easings[easingId], "onUpdate:sendX");
        anW = new Ani(this, time, "w", 0, easings[easingId], "onUpdate:sendW, onEnd:isPassed");
      }
    }
    void goLeft(float time, int easingId) {
      if (x==projectorWidth || y==projectorHeight ||  w==0 || h==0) {
        hide(0, 0, 0, projectorHeight);
        anW = new Ani(this, time, "w", projectorWidth, easings[easingId], "onUpdate:sendW, onEnd:isPassed");
      } else { 
        anW = new Ani(this, time, "w", 0, easings[easingId], "onUpdate:sendW, onEnd:isPassed");
      }
    }
    void goUp(float time, int easingId) {
      if (x==projectorWidth || y==projectorHeight ||  w==0 || h==0) { 
        hide(0, projectorHeight, projectorWidth, 0);
        anY = new Ani(this, time, "y", 0, easings[easingId], "onUpdate:sendY");
        anH = new Ani(this, time, "h", projectorHeight, easings[easingId], "onUpdate:sendH, onEnd:isPassed");
      } else {
        anY = new Ani(this, time, "y", projectorHeight, easings[easingId], "onUpdate:sendY");
        anH = new Ani(this, time, "h", 0, easings[easingId], "onUpdate:sendH, onEnd:isPassed");
      }
    }
    void goDown(float time, int easingId) {
      if (x==projectorWidth || y==projectorHeight ||  w==0 || h==0) { 
        hide(0, 0, projectorWidth, 0);
        anH = new Ani(this, time, "h", projectorHeight, easings[easingId], "onUpdate:sendH, onEnd:isPassed");
      } else { 
        anH = new Ani(this, time, "h", 0, easings[easingId], "onUpdate:sendH, onEnd:isPassed");
      }
    }

    private void isPassed() {
      if (moves) move(newTime, newEasingId, newSens);
      moves = false;
    }
  }
