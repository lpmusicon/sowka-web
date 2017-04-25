void setup() {
    size(800,600);
    background(91, 147, 20);
    stroke(255);
    imageMode(CENTER);
    noStroke();
    /* @pjs image='/assets/img/cutlery/fork.png'; */
	/* @pjs image='/assets/img/cutlery/knife.png'; */
	/* @pjs image='/assets/img/cutlery/plate.png'; */
	/* @pjs image='/assets/img/cutlery/spoon.png'; */
    /* @pjs font='/assets/fonts/lato-light.ttf'; */
    PFont latoLight = createFont('/assets/fonts/lato-light.ttf');
    textFont(latoLight);
    rectMode(CENTER);
}
void textFontSize(x) {
    textSize(x);
}
PImage bg;
var i = 0;
ArrayList elements = new ArrayList();
var drawing = function(tekst, img) {
    this.state = 1;
    this.z = img || '';
    this.img = loadImage(this.z);
    this.x = 1000;
    this.v = 20;
    this.alpha = 255;
    this.text = tekst || '';
    this.draw = function() {
        if(this.state == 1) {
            this.fadeIn();
        }  else if(this.state == 3) {
            this.fadeOut();
        } 
            textFontSize(64);
            image(this.img, width/2, height/2+75);
            textAlign(CENTER, CENTER);
            fill(#f5f5f5);
            text(this.text, width/2, 100);
    }
    this.fadeIn = function() {
       this.state = 2;
    }
    this.fadeOut = function() {
        i++;
        this.state = 1;
    }
}
elements.add(new drawing('Widelec', '/assets/img/cutlery/fork.png'));
elements.add(new drawing('Nóż', '/assets/img/cutlery/knife.png'));
elements.add(new drawing('Talerz', '/assets/img/cutlery/plate.png'));
elements.add(new drawing('Łyżka', '/assets/img/cutlery/spoon.png'));

void draw() {
    background(#5697b5);
        if(i < elements.size()) {
            animal = elements.get(i);
            animal.draw();
        } else if (i == elements.size()) {
            i = 0;
        }
}


void mouseClicked() {
    animal.state = 3;
}