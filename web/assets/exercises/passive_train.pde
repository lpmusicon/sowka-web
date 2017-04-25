void setup() {
    size(800,600);
    background(91, 147, 20);
    stroke(255);
    imageMode(CENTER);
    noStroke();
    /* @pjs font='fonts/Lato-Light.ttf'; */
    /* @pjs image='exercises/1/passive/cat.png'; */
    /* @pjs image='exercises/1/passive/chicken.png'; */
    /* @pjs image='exercises/1/passive/cow.png'; */
    /* @pjs image='exercises/1/passive/dog.png'; */
    /* @pjs image='exercises/1/passive/pig.png'; */
    /* @pjs image='exercises/1/passive/sheep.png'; */
    /* @pjs image='exercises/1/passive/snake.png'; */
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
    this.z = img || 'exercises/1/passive/cat.png';
    this.img = loadImage(this.z);
    this.x = 1000;
    this.v = 20;
    this.alpha = 255;
    this.text = tekst || "ko";
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

elements.add(new drawing('Miau Miau', 'exercises/1/passive/cat.png'));
elements.add(new drawing('Ko Ko Ko', 'exercises/1/passive/chicken.png'));
elements.add(new drawing('Muuu Muuu', 'exercises/1/passive/cow.png'));
elements.add(new drawing('Hau Hau', 'exercises/1/passive/dog.png'));
elements.add(new drawing('Chrum Chrum', 'exercises/1/passive/pig.png'));
elements.add(new drawing('Beee Beee', 'exercises/1/passive/sheep.png'));
elements.add(new drawing('Ssss Ssss', 'exercises/1/passive/snake.png'));

void draw() {
    background(#5697b5);
        if(i < elements.size()) {
            animal = elements.get(i);
            animal.draw();
            fill(255);
        } else if (i == elements.size()) {
            text("rowne", 50, 100);
            i = 0;
        }
}


void mouseClicked() {
    animal.state = 3;
}