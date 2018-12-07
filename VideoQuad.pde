class VideoQuad extends Quad {

  boolean sharedShow, vmirror, hmirror;
  VideoQuad(int id, float[] bridge, color col) {
    super(id, bridge, col);
  }

  void sendAlpha(Ani theAni) {
    activate();
    OscMessage msg = new OscMessage("/active/video/color/4");
    msg.add(theAni.getPosition());
    oscP5.send(msg, address);
    msg.clear();
  }

  void toColor(color col) {
    activate();
    OscMessage msg = new OscMessage("/active/video/color");
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
    OscMessage msg = new OscMessage("/active/video/color");
    msg.add(red(actual));
    msg.add(green(actual));
    msg.add(blue(actual));
    msg.add(alpha(actual ));
    oscP5.send(msg, address);
    msg.clear();
  }
  
  void flipV(){
    activate();
    OscMessage msg = new OscMessage("/active/video/vmirror");
    vmirror =! vmirror; 
    msg.add(int(vmirror));
    oscP5.send(msg, address);
  }
  
  void flipH(){
    activate();
    OscMessage msg = new OscMessage("/active/video/hmirror");
    hmirror =! hmirror; 
    msg.add(int(hmirror));
    oscP5.send(msg, address);
  }

  void activeSharedVideo() {
    activate();
    OscMessage msg = new OscMessage("/active/sharedVideo/show");
    sharedShow =! sharedShow; 
    msg.add(int(sharedShow));
    oscP5.send(msg, address);
  }
  void changeSharedVideo(int sharedVideoNum) {
    activate();
    OscMessage msg = new OscMessage("/active/sharedVideo/num");
    msg.add(int(sharedVideoNum));
    oscP5.send(msg, address);
  }
}
