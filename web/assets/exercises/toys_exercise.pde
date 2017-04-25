void setup() {
    size(800,600);
    background(91, 147, 20);
    stroke(255);
    imageMode(CENTER);
    noStroke();
    /* @pjs font='fonts/Lato-Light.ttf'; */
    /* @pjs image='img/exercises/toys/ball.png'; */
	/* @pjs image='img/exercises/toys/bear.png'; */
	/* @pjs image='img/exercises/toys/car.png'; */
	/* @pjs image='img/exercises/toys/cart.png'; */
	/* @pjs image='img/exercises/toys/clown.png'; */
	/* @pjs image='img/exercises/toys/doll.png'; */
	/* @pjs image='img/exercises/toys/plane.png'; */
	/* @pjs image='img/exercises/toys/train.png'; */
    PFont latoLight;
    latoLight = createFont('fonts/Lato-Light.ttf');
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

elements.add(new drawing('Piłka', 'img/exercises/toys/ball.png'));
elements.add(new drawing('Miś', 'img/exercises/toys/bear.png'));
elements.add(new drawing('Samochodzik', 'img/exercises/toys/car.png'));
elements.add(new drawing('Wózek', 'img/exercises/toys/cart.png'));
elements.add(new drawing('Klaun', 'img/exercises/toys/clown.png'));
elements.add(new drawing('Lalka', 'img/exercises/toys/doll.png'));
elements.add(new drawing('Samolot', 'img/exercises/toys/plane.png'));
elements.add(new drawing('Kolejka', 'img/exercises/toys/train.png'));

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