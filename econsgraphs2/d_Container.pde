class Container {
  Button[] buttons;
  String[] labels;  
  PImage[] icons;
  int type;
  float x1, y1, x2, y2;
  

  Container(Button[] buttons, String[] labels, PImage[] icons, int type) {
    this.buttons=buttons;
    this.labels=labels;
    this.type=type;
    this.icons = icons;

    if (type==MAIN) {
      for (int i=0; i<buttons.length; i++) {
        this.buttons[i]=new Button(MAIN,labels[i], icons[i], u, (i+1.5)*1.4*u, u, color(170), color(120));
        this.buttons[i].visible=true;
      }
      x1=u;
      y1=(1.5)*1.4*u;
      x2=u;
      y2=(buttons.length-1+1.5)*1.4*u;
    }
    
    else if (type==SUB) {
      for (int i=0; i<buttons.length; i++) {
        this.buttons[i]=new Button(SUB,labels[i], (1.3*i+2)*1.4*u, 0.8*u, (1.3*i+2)*1.4*u+0.8*u, 0.8*u, 0.8*u, color(200), color(150));
        this.buttons[i].visible=false;
      }
      x1=(1.5)*1.4*u;
      y1=u;
      x2=(buttons.length-1+1.5)*1.4*u;
      y2=u;
    }
  }
  



  void render() {
    if(type==MAIN){
    noStroke();
    fill(200);
    rect(x1-0.7*u, y1-0.4*u, 1.4*u, y2-y1+0.8*u);
    ellipse(x1, y1-0.4*u, 1.4*u, 1.4*u);
    ellipse(x1, y2+0.4*u, 1.4*u, 1.4*u);
    }else if(type==SUB){
    
    
    }
    for (Button b : buttons) {
      b.render();
    }
  }
}
