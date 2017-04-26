void setup() {
    size(800,600);
    background(91, 147, 20);
    stroke(255);
    imageMode(CENTER);
    noStroke();
    /* @pjs font='/assets/fonts/lato-light.ttf'; */
    /* @pjs image='/assets/img/toys/ball.png'; */
	/* @pjs image='/assets/img/toys/bear.png'; */
	/* @pjs image='/assets/img/toys/car.png'; */
	/* @pjs image='/assets/img/toys/cart.png'; */
	/* @pjs image='/assets/img/toys/clown.png'; */
	/* @pjs image='/assets/img/toys/doll.png'; */
	/* @pjs image='/assets/img/toys/plane.png'; */
	/* @pjs image='/assets/img/toys/train.png'; */
    PFont latoLight;
    latoLight = createFont('/assets/fonts/lato-light.ttf');
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

elements.add(new drawing('Piłka', '/assets/img/toys/ball.png'));
elements.add(new drawing('Miś', '/assets/img/toys/bear.png'));
elements.add(new drawing('Samochodzik', '/assets/img/toys/car.png'));
elements.add(new drawing('Wózek', '/assets/img/toys/cart.png'));
elements.add(new drawing('Klaun', '/assets/img/toys/clown.png'));
elements.add(new drawing('Lalka', '/assets/img/toys/doll.png'));
elements.add(new drawing('Samolot', '/assets/img/toys/plane.png'));
elements.add(new drawing('Kolejka', '/assets/img/toys/train.png'));

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