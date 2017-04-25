void setup() {
    size(800,600);
    background(91, 147, 20);
    imageMode(CENTER);
    rectMode(CENTER);
    noStroke();

    /* @pjs font='/assets/fonts/lato-light.ttf'; */
    PFont latoLight = createFont('/assets/fonts/lato-light.ttf');
    textFont(latoLight);
    textAlign(CENTER, CENTER);
    textSize(64);
}

var i = 0;

ArrayList elements = new ArrayList();

var drawing = function(tekst, r, g, b) {
    /*
        Stany zwierzęcia
        1 - Wejście
        2 - Na ekranie
        3 - Wyjście
    */

    this.state = 1;
    this.r = r || 0;
    this.g = g || 0;
    this.b = b || 0;

    this.text = tekst || '';
    this.draw = function() {

        if(this.state == 1) {
            this.getIn();
        }  
        else if(this.state == 3) {
            this.getOut();
        } 

        fill(r, g, b);
        rect(width/2, height/2, 800, 600);

        fill(255, this.alpha);
        text(this.text, width/2, height/2);
    }

    this.getIn = function() { this.state = 2; }
    this.getOut = function() { i++; this.state = 1; }
}

elements.add(new drawing('Niebieski', 29, 98, 240));
elements.add(new drawing('Zielony', 62,187,0));
elements.add(new drawing('Fioletowy', 176,67,252));
elements.add(new drawing('Różowy', 252,67,172));
elements.add(new drawing('Pomarańczowy', 255,149,0));
elements.add(new drawing('Żółty', 255,224,58));

var color;

void draw() {
    if(i < elements.size()) {
        color = elements.get(i);
        color.draw();
        fill(255);
    } else if (i == elements.size()) {
        //Reset gdy przejedziemy całość
        i = 0;
    }
}

void mouseClicked() {
    color.state = 3;
}