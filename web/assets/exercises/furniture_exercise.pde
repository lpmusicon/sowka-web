void setup() {
    size(800,600);
    background(91, 147, 20);
    stroke(255);
    imageMode(CENTER);
    noStroke();
    /* @pjs image='/assets/img/furniture/bed.png'; */
	/* @pjs image='/assets/img/furniture/chair.png'; */
	/* @pjs image='/assets/img/furniture/commode.png'; */
	/* @pjs image='/assets/img/furniture/lamp.png'; */
    /* @pjs image='/assets/img/furniture/table.png'; */
    /* @pjs image='/assets/img/furniture/wardrobe.png'; */
    /* @pjs font='/assets/fonts/lato-light.ttf'; */
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

elements.add(new drawing('Łóżko', '/assets/img/furniture/bed.png'));
elements.add(new drawing('Krzesło', '/assets/img/furniture/chair.png'));
elements.add(new drawing('Komoda', '/assets/img/furniture/commode.png'));
elements.add(new drawing('Lampa', '/assets/img/furniture/lamp.png'));
elements.add(new drawing('Stolik', '/assets/img/furniture/table.png'));
elements.add(new drawing('Szafa', '/assets/img/furniture/wardrobe.png'));

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