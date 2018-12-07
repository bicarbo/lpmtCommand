class Quad {
  int id;
  float x0, y0, x1, y1, x2, y2, x3, y3;
  float h, s, b, a, lerp;
  color from, to, actual;
  Ani[] aniX = new Ani[4];
  Ani[] aniY = new Ani[4];
  Vect2[] corners = new Vect2[4];

  Quad(int id, float[] bridge, color col) {
    this.id = id;
    actual = col;
    x0 = bridge[0];
    y0 = bridge[1];
    x1 = bridge[2];
    y1 = bridge[3];
    x2 = bridge[4];
    y2 = bridge[5];
    x3 = bridge[6];
    y3 = bridge[7];
    corners[0] = new Vect2(x0, y0);
    corners[1] = new Vect2(x1, y1);
    corners[2] = new Vect2(x2, y2);
    corners[3] = new Vect2(x3, y3);
    sendAll();
  }

  void randomColor(float time, int easingId) {
    lerp = .0;
    from = actual;
    to = color(random(1), random(1), random(1));
    Ani transition = new Ani(this, time, "lerp", 1, easings[easingId], "onUpdate:sendColor");
  }
  void changeColor(float time, int easingId, color col) {
    lerp = .0;
    from = actual;
    to = col;
    Ani transition = new Ani(this, time, "lerp", 1, easings[easingId], "onUpdate:sendColor");
  }
  void fade(float time, int easingId) {
    int goal = (alpha(actual)>.0) ? 0 : 1;
    Ani transition = new Ani(this, time, "a", goal, easings[easingId], "onUpdate:sendAlpha");
    actual = goal << 24;
  }
  void fadeLoop(float timeIn, float timeOut, int easingId) {
    Ani fadeIn = new Ani(this, timeIn, "lerp", 1, easings[easingId], "onUpdate:sendAlpha");
    Ani fadeOut = new Ani(this, timeOut, timeIn, "lerp", 0, easings[easingId], "onUpdate:sendAlpha");
  } 
  void reload() {
    x0 = corners[0].x;
    y0 = corners[0].y;
    x1 = corners[1].x;
    y1 = corners[1].y;
    x2 = corners[2].x;
    y2 = corners[2].y;
    x3 = corners[3].x;
    y3 = corners[3].y;
    sendAll();
  }
  void sendAll() {
    sendCorner('x', 0, x0);
    sendCorner('y', 0, y0);
    sendCorner('x', 1, x1);
    sendCorner('y', 1, y1);
    sendCorner('x', 2, x2);
    sendCorner('y', 2, y2);
    sendCorner('x', 3, x3);
    sendCorner('y', 3, y3);
  }

  void sendX(Ani theAni) {
    sendPlacement('x', int(theAni.getPosition()));
  }
  void sendY(Ani theAni) {
    sendPlacement('y', int(theAni.getPosition()));
  }
  void sendW(Ani theAni) {
    sendPlacement('w', int(theAni.getPosition()));
  }
  void sendH(Ani theAni) {
    sendPlacement('h', int(theAni.getPosition()));
  }
  void sendX0(Ani theAni) {
    sendCorner('x', 0, theAni.getPosition());
  }
  void sendY0(Ani theAni) {
    sendCorner('y', 0, theAni.getPosition());
  }
  void sendX1(Ani theAni) {
    sendCorner('x', 1, theAni.getPosition());
  }
  void sendY1(Ani theAni) {
    sendCorner('y', 1, theAni.getPosition());
  }
  void sendX2(Ani theAni) {
    sendCorner('x', 2, theAni.getPosition());
  }
  void sendY2(Ani theAni) {
    sendCorner('y', 2, theAni.getPosition());
  }
  void sendX3(Ani theAni) {
    sendCorner('x', 3, theAni.getPosition());
  }
  void sendY3(Ani theAni) {
    sendCorner('y', 3, theAni.getPosition());
  }
   void sendAlpha(Ani theAni) {
      activate();
      OscMessage msg = new OscMessage("/active/solid/color/4");
      msg.add(theAni.getPosition());
      oscP5.send(msg, address);
      msg.clear();
    }

    void toColor(color col) {
      activate();
      OscMessage msg = new OscMessage("/active/solid/color");
      msg.add(red(col));
      msg.add(green(col));
      msg.add(blue(col));
      msg.add(alpha(col));
      oscP5.send(msg, address);
      msg.clear();
      actual = col;
    }

    void sendColor() {
      actual = lerpColor(from, to, lerp);
      activate();
      OscMessage msg = new OscMessage("/active/solid/color");
      msg.add(red(actual));
      msg.add(green(actual));
      msg.add(blue(actual));
      msg.add(alpha(actual));
      oscP5.send(msg, address);
      msg.clear();
    }

  void sendCorner(char name, int corner, float value) {
    OscMessage msg = new OscMessage("/corners/"+name);
    msg.add(id);
    msg.add(corner);
    msg.add(value);
    oscP5.send(msg, address);
  }
  void sendPlacement(char name, int value) {
    activate();
    OscMessage msg = new OscMessage("/active/placement/"+name);
    msg.add(value);
    oscP5.send(msg, address);
  }
  void activate() {
    OscMessage msg = new OscMessage("/active/set");
    msg.add(id);
    oscP5.send(msg, address);
  }
}
