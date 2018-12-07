import oscP5.*;
import netP5.*;
import point2line.*;
import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

// à ne pas mettre dans la librairie
VideoQuad[] vidQuads = new VideoQuad[6];
SquareQuad[] sqQuads = new SquareQuad[6];
HorizontalQuad[] hQuads = new HorizontalQuad[6];
VerticalQuad[] vQuads = new VerticalQuad[6];
HLine[] hLines = new HLine[6];
VLine[] vLines = new VLine[6];
float size = 0.4;
//jusqu ici

// à ne pas mettre dans la librairie
ArrayList<float[]> sequence = new ArrayList();
boolean playSeq;
int timer, stepSeq;
//jusqu ici

// à ne pas mettre dans la librairie
OscP5 oscP5;
NetAddress address;
int projectorWidth = 800, projectorHeight = 600;
//jusqu ici

// à ne pas mettre dans la librairie
void setup() {
  Ani.init(this);
  colorMode(RGB, 1.0);
  oscP5 = new OscP5(this, 7000);
  address = new NetAddress("127.0.0.1", 12345);
  loadLpmtSettings();
}//jusqu ici

// à ne pas mettre dans la librairie
void draw() {
  if (stepSeq<sequence.size()-1) {
    timer++;
    if (sequence.get(stepSeq)[0] == timer) {
      playSequence(sequence);
      timer = 0;
    }
  }
}//jusqu ici

// à ne pas mettre dans la librairie
void loadLpmtSettings() { 
  float[][] bridge = new float[6][8];
  String[] lpmtStr, lpmtNewStr;
  XML lpmtData;
  lpmtStr = loadStrings("_lpmt_settings.xml");
  lpmtNewStr = new String[lpmtStr.length-18];
  arrayCopy(lpmtStr, 18, lpmtNewStr, 0, lpmtStr.length-18);
  saveStrings("data/transit.xml", lpmtNewStr);
  lpmtData = loadXML("transit.xml");
  XML[] children = lpmtData.getChildren();
  for (int i = 1; i < children.length; i+=2) {
    int newI = (i-1)/2;
    XML quadB = children[i];
    XML corner = quadB.getChild("CORNERS");
    for (int j=0; j<4; j++) {
      XML cornerPrecise = corner.getChild("CORNER_"+j);
      bridge[newI][j*2] = float(cornerPrecise.getChild("X").getContent());
      bridge[newI][j*2+1] = float(cornerPrecise.getChild("Y").getContent());
    }
    createVideoQuad(i/2, bridge[newI]);
  }
  for (int i=0; i<6; i++) {
    sendNewQuad(bridge[i]);
    sqQuads[i] = new SquareQuad(i+6, bridge[i], color(random(255), random(255), random(255)));
  }
  for (int i=0; i<6; i++) {
    sendNewQuad(bridge[i]);
    hQuads[i] = new HorizontalQuad(i+12, bridge[i], color(random(255), random(255), random(255)));
  }
  for (int i=0; i<6; i++) {
    sendNewQuad(bridge[i]);
    vQuads[i] = new VerticalQuad(i+18, bridge[i], color(random(255), random(255), random(255)));
  }
  for (int i=0; i<6; i++) {
    sendNewQuad(bridge[i]);
    hLines[i] = new HLine(i+24, bridge[i], color(random(255), random(255), random(255)));
  }
  for (int i=0; i<6; i++) {
    sendNewQuad(bridge[i]);
    vLines[i] = new VLine(i+30, bridge[i], color(random(255), random(255), random(255)));
  }
}//jusqu ici

void createVideoQuad(int id, float[] bridge) {
  vidQuads[id] = new VideoQuad(id, bridge, color(random(255), random(255), random(255)));
}

void sendNewQuad(float[] bridge) {
  OscMessage msg = new OscMessage("/new/quad");
  msg.add(bridge);
  oscP5.send(msg, address);
}
// à ne pas mettre dans la librairie
Easing[] easings = {Ani.LINEAR, Ani.QUAD_IN, Ani.QUAD_OUT, Ani.QUAD_IN_OUT, Ani.CUBIC_IN, Ani.CUBIC_IN_OUT, Ani.CUBIC_OUT, Ani.QUART_IN, Ani.QUART_OUT, Ani.QUART_IN_OUT, Ani.QUINT_IN, Ani.QUINT_OUT, Ani.QUINT_IN_OUT, Ani.SINE_IN, Ani.SINE_OUT, Ani.SINE_IN_OUT, Ani.CIRC_IN, Ani.CIRC_OUT, Ani.CIRC_IN_OUT, Ani.EXPO_IN, Ani.EXPO_OUT, Ani.EXPO_IN_OUT, Ani.BACK_IN, Ani.BACK_OUT, Ani.BACK_IN_OUT, Ani.BOUNCE_IN, Ani.BOUNCE_OUT, Ani.BOUNCE_IN_OUT, Ani.ELASTIC_IN, Ani.ELASTIC_OUT, Ani.ELASTIC_IN_OUT};
String[] easingsVariableNames = {"Ani.LINEAR", "Ani.QUAD_IN", "Ani.QUAD_OUT", "Ani.QUAD_IN_OUT", "Ani.CUBIC_IN", "Ani.CUBIC_IN_OUT", "Ani.CUBIC_OUT", "Ani.QUART_IN", "Ani.QUART_OUT", "Ani.QUART_IN_OUT", "Ani.QUINT_IN", "Ani.QUINT_OUT", "Ani.QUINT_IN_OUT", "Ani.SINE_IN", "Ani.SINE_OUT", "Ani.SINE_IN_OUT", "Ani.CIRC_IN", "Ani.CIRC_OUT", "Ani.CIRC_IN_OUT", "Ani.EXPO_IN", "Ani.EXPO_OUT", "Ani.EXPO_IN_OUT", "Ani.BACK_IN", "Ani.BACK_OUT", "Ani.BACK_IN_OUT", "Ani.BOUNCE_IN", "Ani.BOUNCE_OUT", "Ani.BOUNCE_IN_OUT", "Ani.ELASTIC_IN", "Ani.ELASTIC_OUT", "Ani.ELASTIC_IN_OUT"};
//jusqu ici
