void setup() {
    size(800,600);
    imageMode(CENTER);
    noStroke();
    /* @pjs font='/assets/fonts/lato-light.ttf'; */
    /* @pjs image='/assets/img/clothes/cap.png'; */
	/* @pjs image='/assets/img/clothes/coat.png'; */
	/* @pjs image='/assets/img/clothes/dress.png'; */
	/* @pjs image='/assets/img/clothes/glow.png'; */
    /* @pjs image='/assets/img/clothes/panties.png'; */
    /* @pjs image='/assets/img/clothes/pants.png'; */
    /* @pjs image='/assets/img/clothes/scarf.png'; */
    /* @pjs image='/assets/img/clothes/shirt.png'; */
    PFont latoLight = createFont('/assets/fonts/lato-light.ttf');
    textFont(latoLight);
    rectMode(CENTER);
    textSize(64);
}

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

elements.add(new drawing('Czapka', '/assets/img/clothes/cap.png'));
elements.add(new drawing('Płaszcz', '/assets/img/clothes/coat.png'));
elements.add(new drawing('Spódniczka', '/assets/img/clothes/dress.png'));
elements.add(new drawing('Rękawiczka', '/assets/img/clothes/glow.png'));
elements.add(new drawing('Majtki', '/assets/img/clothes/panties.png'));
elements.add(new drawing('Spodnie', '/assets/img/clothes/pants.png'));
elements.add(new drawing('Szalik', '/assets/img/clothes/scarf.png'));
elements.add(new drawing('Koszula', '/assets/img/clothes/shirt.png'));

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