import processing.opengl.*;
PShape obj;

void setup(){
  size(500,500,P3D);
  
    noFill();//描画する際に塗りつぶさない
    stroke(255);//枠線を白に
    obj = loadShape("tinker2.obj");
    
}

void draw() {
  background(255);//白で塗りつぶす
    //ortho(-width/2,width/2,-height/2,height/2);//平行投影法（無限遠点から見ている）
    //perspective(radians(60),1,100,-100);//透視投影法（遠近法）

//大きな立方体の中心に座標系の原点があることをわかりやすくするためにＸ軸、Y軸、Ｚ軸を表示不要ならコメントアウト
    arrow(0, 0, 0, 150, 0, 0, 150, 0, 0);
    arrow(0, 0, 0, 0, 150, 0, 0, 150, 0);
    arrow(0, 0, 0, 0, 0, 150, 0, 0, 150);
    
    camera(500,1000,500,0,0,0,0,0,-1); //カメラの位置
    noFill();
    
    obj.scale(1.0);
    stroke(255);
    translate(500,500,0);
    rotateZ(frameCount/100.0);
    shape(obj);
}



//--------------------------------------------------プログラムの追加(ここまで)--------------------------------------------------

//以下は3次元の座標系を描画するためのものなのでスルーでOK
void arrow(int x1, int y1, int z1, int x2, int y2, int z2, int Color1, int Color2, int Color3)
{
  int arrowLength = 10;
  float arrowAngle = 0.5;
  float phi = -atan2(y2-y1, x2-x1);
  float theta = PI/2-atan2(z2-z1, x2-x1);
  stroke(Color1, Color2, Color3);
  strokeWeight(4);
  line(x1, y1, z1, x2, y2, z2);
  strokeWeight(1);
  pushMatrix();
  translate(x2, y2, z2);
  rotateY(theta);
  rotateX(phi);
  cone(arrowLength, arrowLength*sin(arrowAngle), Color1, Color2, Color3);
  popMatrix();
}

void cone(int L, float radius, int Color1, int Color2, int Color3)
{
  float x, y;
  noStroke();
  fill(Color1, Color2, Color3);
  beginShape(TRIANGLE_FAN);  // 底面の円の作成
  vertex(0, 0, -L);
  for(float i=0; i<2*PI; )
  {
    x = radius*cos(i);
    y = radius*sin(i);
    vertex(x, y, -L);
    i = i+0.01;
  }
  endShape(CLOSE);
  beginShape(TRIANGLE_FAN);  // 側面の作成
  vertex(0, 0, 0);
  for(float i=0; i<2*PI; )
  {
    x = radius*cos(i);
    y = radius*sin(i);
    vertex(x, y, -L);
    i = i+0.01;
  }
  endShape(CLOSE);
    noFill();
    stroke(0);
}
