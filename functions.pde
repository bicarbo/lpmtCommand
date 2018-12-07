void playTable(String name) {  
  Table  table = loadTable("data/"+name+".tsv", "header, tsv");
  sequence.clear();
  timer = 0;
  stepSeq = -1;
  playSeq = true;
  for (int i=0; i<table.getRowCount (); i++) {    
    float[] tempon = new float[7];
    for (int j=0; j<7; j++) {
      tempon[j] = table.getFloat(i, j);
    }
    sequence.add(tempon);
  }
  table.clearRows();
  playSequence(sequence);
}

void playSequence(ArrayList<float[]> store) {
  float[] tempon = new float[5]; 
  tempon = sequence.get(++stepSeq);
  play(tempon);
}


// à ne pas mettre dans la librairie si ça ne compile pas, 
// ne mes pas non plus playSequence et playTable
void play(float[] anim) {
}
//jusqu ici
