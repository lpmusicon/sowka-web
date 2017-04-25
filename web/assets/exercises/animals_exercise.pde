void setup() {
    size(800,600);
    imageMode(CENTER);
    noStroke();
    /* @pjs image='/assets/img/cat.png'; */
    /* @pjs image='/assets/img/chicken.png'; */
    /* @pjs image='/assets/img/cow.png'; */
    /* @pjs image='/assets/img/dog.png'; */
    /* @pjs image='/assets/img/pig.png'; */
    /* @pjs image='/assets/img/sheep.png'; */
    /* @pjs image='/assets/img/snake.png'; */
    /* @pjs font='/assets/fonts/lato-light.ttf'; */
    PFont latoLight = createFont('/assets/fonts/lato-light.ttf');
    textFont(latoLight);
    rectMode(CENTER);
    textSize(64);
}


var i = 0;
ArrayList elements = new ArrayList();

var Drawing = function(tekst, img) {
    this.state = 1;
    this.z = img || '';
    this.img = loadImage(this.z);
    this.x = 1000;
    this.v = 20;
    this.alpha = 255;
    this.text = tekst || "";
    this.draw = function() {
        if(this.state == 1) {
            this.fadeIn();
        }  else if(this.state == 3) {
            this.fadeOut();
        } 

        image(this.img, width/2, height/2+75);
        textAlign(CENTER, CENTER);
        fill(#f5f5f5, this.alpha);
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


elements.add(new Drawing('Kot', '/assets/img/cat.png'));
elements.add(new Drawing('Kura', '/assets/img/chicken.png'));
elements.add(new Drawing('Krowa', '/assets/img/cow.png'));
elements.add(new Drawing('Pies', '/assets/img/dog.png'));
elements.add(new Drawing('Świnka', '/assets/img/pig.png'));
elements.add(new Drawing('Owca', '/assets/img/sheep.png'));
elements.add(new Drawing('Wąż', '/assets/img/snake.png'));

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