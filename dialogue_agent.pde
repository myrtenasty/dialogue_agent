import controlP5.*;

int Length = 1600;
int Width = 1200;
int fontSize = 40;

int c1,c2;

float n,n1;

int myColor = color(0);
 
ControlP5 cp5;
 
String ans1, ans2, ans3;

String[] question = new String[3];
String[][] answer = new String[3][0];
String[][] words = new String[3][0];

String[] list;
String[] listAll;
int wordCount = 0;
int wordFreq[][] = new int[3][1];
 
void setup() {

  PFont font = createFont("arial",20);
  textFont(font);

  question[0] = "Nice to meet you!";
  question[1] = "Where is the capital of Japan?";
  question[2] = "What is the color of the sky?";
  
  size(Length, Width);
  cp5 = new ControlP5(this);
  cp5.addTextfield("Answer1:")
     .setPosition(20, 3*Width/10)
     .setSize(Length-40, 80)
     .setAutoClear(false)
     .setFont(createFont("arial",fontSize))
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(true)
     .setSize(24)
     .align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE)
     ;

  cp5.addTextfield("Answer2:")
     .setPosition(20, 5*Width/10)
     .setSize(Length-40, 80)
     .setAutoClear(false)
     .setFont(createFont("arial",fontSize))
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(true)
     .setSize(24)
     .align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE)
     ;

  cp5.addTextfield("Answer3:")
     .setPosition(20, 7*Width/10)
     .setSize(Length-40, 80)
     .setAutoClear(false)
     .setFont(createFont("arial",fontSize))
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(true)
     .setSize(24)
     .align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE)
     ;

  cp5.addButton("Submit")
     .setValue(0)
     .setPosition(9*Length/10, 8*Width/10)
     .setSize(120, 60)
     .getCaptionLabel()
     .setSize(24)
     ;

  cp5.addButton("Conclude")
     .setValue(0)
     .setPosition(7*Length/10, 20)
     .setSize(120, 60)
     .getCaptionLabel()
     .setSize(24)
     ;

  cp5.addButton("ReportWithAnswers")
     .setValue(0)
     .setPosition(8*Length/10, 20)
     .setSize(300, 60)
     .getCaptionLabel()
     .setSize(24)
     ;
 
}
 
 
void draw () {
  background(myColor);

  textSize(80);
  text("A Simple Questionnaire", 20, 150);

  textSize(24);
  for(int j = 0; j < question.length; j++){
    String questionNo = "Question "+(j+1)+":";
    text(questionNo, 20, (j+1)*2*Width/10+30);
  }

  textSize(40);
  for(int i = 0; i<question.length; i++){
    text(question[i], 20, (i+1)*2*Width/10+70);
  }
}
 
void Submit() {
  print("the following text was submitted :");
  ans1 = cp5.get(Textfield.class,"Answer1:").getText();
  ans2 = cp5.get(Textfield.class,"Answer2:").getText();
  ans3 = cp5.get(Textfield.class,"Answer3:").getText();

  answer[0] = append(answer[0], ans1);
  answer[1] = append(answer[1], ans2);
  answer[2] = append(answer[2], ans3);

  println();
  println(" Your Answer for question 1 is  " + ans1);
  println(" Your Answer for question 2 is  " + ans2);
  println(" Your Answer for question 3 is  " + ans3);

  delay(2000);
  cp5.get(Textfield.class,"Answer1:").clear();
  cp5.get(Textfield.class,"Answer2:").clear();
  cp5.get(Textfield.class,"Answer3:").clear();
}

void Conclude(){
  for(int i = 0; i < answer.length; i++){
    listAll = new String[0];
    for(int j = 0; j < answer[i].length; j++){
      list = split(answer[i][j], " ");
      // println(list);
      listAll = concat(listAll, list);
    }
    // println(listAll);
    // println(listAll.length);

    for(int k = 0; k < listAll.length; k++){
      wordCount = 0;
      // words[i][0] = "asdfghjkl";
      for(String s:words[i]){
        if(!s.equals(listAll[k])){
          wordCount++;
          // println("s is "+s+" word is "+listAll[k]);
        }
        // println(wordCount);
      }
      if(wordCount>=words[i].length){
        words[i] = append(words[i], listAll[k]);
      }
    }
    // println(words[i]);
    // println(words[i].length);
    wordFreq[i] = expand(wordFreq[i], words[i].length);

    for(int l = 0; l < words[i].length; l++){
      wordFreq[i][l] = 0;
      for(String t:listAll){
        if(t.equals(words[i][l])){
          wordFreq[i][l]++;
        }
      }
    }
    // println(wordFreq[i]);

    println();
    println("For question "+(i+1)+", word frequency are shown blow:");
    for(int m = 1; m < words[i].length; m++){
      println(words[i][m]+": "+wordFreq[i][m]);
    }
  }
  // println(listAll);
}

void ReportWithAnswers(){
  for(int i = 0; i < answer.length; i++){
    println();
    println("Answers for question "+(i+1)+" are:");
    for(int j = 0; j < answer[i].length; j++){
      println(answer[i][j]);
    }
  }
}
