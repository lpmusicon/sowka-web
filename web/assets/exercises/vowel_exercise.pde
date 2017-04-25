void setup() {
    size(800,600);
    background(91, 147, 20);
    stroke(255);
    noStroke();
    frameRate(180);
    /* @pjs font='/assets/fonts/lato-light.ttf'; */
    PFont latoLight = createFont('/assets/fonts/lato-light.ttf');
    textFont(latoLight);
}

var gameState = 0;
var cleanScr = true;
var charX;
var wait = 0;

void cls() {
    background(240);
    cleanScr = false;
}

void doRect(x, r, g, b) {
    fill(r, g, b);
    rect(x, 550, 50, 50);
}

void changeSize(x) {
    textAlign(CENTER, CENTER);
    textSize(x);
}

var letter = function(char one, int x, int y, int rectX, int rectY) {
    this.one = one;
    this.x = x;
    this.y = y;
    this.rectX = rectX;
    this.rectY = rectY;
    this.draw = function() {
        fill(255);
        text( this.one , this.x, this.y );
    }
}

var canvas = function() {
    this.r = 0;
    this.g = 0;
    this.b = 0;
    this.draw = function() {
            ellipseMode(CENTER);
            if(mousePressed == true && gameState == 1) {
                fill(this.r, this.g, this.b);
                ellipse(mouseX, mouseY, 20, 20);
            }
        }
    }

var back = function() {
    gameState = 0;
    wait = 10;
    cleanScr = true;
}

textSize(180);
var a = new letter('A', 75, 215, 0, 0);
var e = new letter('E', 335, 215, 266, 0);
var i = new letter('I', 640, 215, 532, 0);
var o = new letter('O', 65, 515, 0, 300);
var u = new letter('U', 335, 515, 266, 300);
var y = new letter('Y', 607, 515, 532, 300);

var canvas = new canvas();
/* a, e, i, o, u, y */
void draw() {
    if(gameState == 0) {
        if(wait > 0) { wait--; }
        background(#5697b5);
        a.draw();
        e.draw();
        i.draw();
        o.draw();
        u.draw();
        y.draw();
    }
    if(gameState == 1) {
        if(cleanScr) { cls(); }
        fill(255);
        canvas.draw();
        fill(#5697b5);
        rect(0,0, 300, 600);
        fill(0);
        
        fill(255);
        changeSize(200);
        text(charX, 150, 275);
        
        changeSize(20);
        fill(0,0,0,40);
        rect(0, 0, 150, 50); //Przycisk wroc
        fill(255);
        text("< Wróć", 75, 25);
        
        fill(0,0,0,40);
        rect(150, 0, 150, 50); //Przycisk wyczysc
        fill(255);
        text("Wyczyść", 225 , 25 );
        
        doRect(0, 67, 122, 204); //JasnyNieb
        doRect(50, 248, 227, 73); //Zolty
        doRect(100, 208, 7, 9); //Czerwony
        doRect(150, 29, 14, 203); //Niebieski
        doRect(200, 186, 252, 58); //Zielony
        doRect(250, 250, 4, 95); //Rozowy
    }
    fill(255);
}


void mouseClicked() {
    if(mouseX > 0 && mouseX < 150 && mouseY > 0 && mouseY < 50 && gameState == 1) { back(); }
    if(mouseX > 150 && mouseX < 300 && mouseY > 0 && mouseY < 50 && gameState == 1) { cleanScr = true; }
    
    //CanvasColors
    if(mouseX > 0 && mouseX < 50 && mouseY > 550 && mouseY < 600 && gameState == 1) { canvas.r = 67; canvas.g = 122; canvas.b = 204; }
    if(mouseX > 50 && mouseX < 100 && mouseY > 550 && mouseY < 600 && gameState == 1) { canvas.r = 248; canvas.g = 227; canvas.b = 73; }
    if(mouseX > 100 && mouseX < 150 && mouseY > 550 && mouseY < 600 && gameState == 1) { canvas.r = 208; canvas.g = 7; canvas.b = 9; }
    if(mouseX > 150 && mouseX < 200 && mouseY > 550 && mouseY < 600 && gameState == 1) { canvas.r = 29; canvas.g = 14; canvas.b = 203; }
    if(mouseX > 200 && mouseX < 250 && mouseY > 550 && mouseY < 600 && gameState == 1) { canvas.r = 186; canvas.g = 252; canvas.b = 58; }
    if(mouseX > 250 && mouseX < 300 && mouseY > 550 && mouseY < 600 && gameState == 1) { canvas.r = 250; canvas.g = 4; canvas.b = 95; }

    //MainMenu
    if(wait == 0) {
        if(mouseX >= a.x && mouseX <= a.x+266 && mouseY >= 0 && mouseY <= 300 && gameState == 0 ) { gameState = 1; charX = 'A';}
        if(mouseX >= e.x && mouseX <= e.x+266 && mouseY >= 0 && mouseY <= 300 && gameState == 0 ) { gameState = 1; charX = 'E';}
        if(mouseX >= i.x && mouseX <= i.x+266 && mouseY >= 0 && mouseY <= 300 && gameState == 0 ) { gameState = 1; charX = 'I';}
        if(mouseX >= o.x && mouseX <= o.x+266 && mouseY >= 300 && mouseY <= 600 && gameState == 0 ) { gameState = 1; charX = 'O';}
        if(mouseX >= u.x && mouseX <= u.x+266 && mouseY >= 300 && mouseY <= 600 && gameState == 0 ) { gameState = 1; charX = 'U';}
        if(mouseX >= y.x && mouseX <= y.x+266 && mouseY >= 300 && mouseY <= 600 && gameState == 0 ) { gameState = 1; charX = 'Y';}
    }
}