void setup() {
    size(800,600);
    background(91, 147, 20);
    stroke(255);
    noStroke();
    /* @pjs font='/assets/fonts/lato-light.ttf'; */
    /* @pjs preload="/assets/img/car.png"; */
    /* @pjs preload="/assets/img/car_crashed.png"; */
    /* @pjs preload="/assets/img/reset.png"; */
    /* @pjs preload="/assets/exercises/car_lv3.png"; */
    PFont latoLight = createFont('/assets/fonts/lato-light.ttf');
    textFont(latoLight);
    bg = loadImage("/assets/exercises/car_lv3.png");
}

/*
    Stany Gry:
     1 = GAME
     2 = WIN
     3 = LOSE
     4 = RESET
 */
var gameState = 1;

var carProto = function() {
    this.x = 120;
    this.y = 250;
    this.width = 50;
    this.height = 34;
    this.colission = false;
    this.boundaryColor = hex(color(91,147,20), 6);
    this.winColor = hex(color(74, 103, 255), 6);
    this.img = loadImage("/assets/img/car.png");
    this.img_crash = loadImage("/assets/img/car_crashed.png");

    this.draw = function() {
        imageMode(CENTER);
        if(gameState == 1) {
            image(this.img, this.x, this.y, this.width, this.height);
            this.move();
        } else if (gameState == 3) image(this.img_crash, this.x, this.y, this.width, this.height);
        
        this.checkColission();
    }

    this.move = function() {
        if(mousePressed && (mouseX > this.x - this.width/2) && (mouseX < (this.x + this.width/2)) && (mouseY > this.y - this.height/2) && (mouseY < (this.y + this.height/2))) {
            this.x = mouseX;
            this.y = mouseY;
        }
    }

    this.checkColission = function() {
        if( (this.leftTopCornerColor() == this.boundaryColor) || (this.rightTopCornerColor() == this.boundaryColor) || (this.leftBottomCornerColor() == this.boundaryColor) || (this.rightBottomCornerColor() == this.boundaryColor) ) {
            this.colission = true;
            gameState = 3;
        } else {
            if( (this.leftTopCornerColor() == this.winColor) || (this.rightTopCornerColor() == this.winColor) || (this.leftBottomCornerColor() == this.winColor) || (this.rightBottomCornerColor() == this.winColor) )
            {
                gameState = 2;
            }
            this.colission = false;
        }
    }

    this.leftTopCornerColor = function() {  return hex(get( this.x - this.width/2, this.y - this.height/2 ), 6); }

    this.leftBottomCornerColor = function() { return hex(get( this.x - this.width/2, this.y + this.height/2 ), 6); }

    this.rightTopCornerColor = function() { return hex(get( this.x + this.width/2, this.y - this.height/2 ), 6); }

    this.rightBottomCornerColor = function() { return hex(get( this.x + this.width/2, this.y + this.height/2 ), 6); }

}

var resetProto = function() {
    this.x = 10;
    this.y = 10;
    this.width = 40;
    this.height = 40;
    this.img = loadImage("/assets/img/reset.png");
    this.draw = function() {
        fill(255,255,255, 160);
        rect(this.x-10, this.y-10, this.width+20, this.height+20);
        imageMode(CORNER);
        image(this.img, this.x, this.y, this.width, this.height);
    }
    this.press = function() {
        if((mouseX > this.x-10) && (mouseX < this.x+this.width+10) && (mouseY > this.y-10) && (mouseY < this.y+this.height+10)) gameState = 4;
    }
}

var car = new carProto();
var reset = new resetProto();
var runOnce = 0;

void draw() {
    background(91, 147, 20);    
    if(gameState == 1 || gameState == 3) {
        image(bg, 400, 300, 800, 600);
        if(runOnce < 80) { gameState = 1; runOnce++; }
        reset.draw();
        car.draw();
    } else if(gameState == 2) {
        fill(255);
        textAlign(CENTER);
        textSize(40);
        text("Gratulacje!", 400, 100);
        text("Oto twoja nagroda", 400, 180);
        context.drawImage(reward, 272, 300, 256, 256);
    } else if(gameState == 4 ) {
        gameState = 1;
        car.x = 120;
        car.y = 250;
    }
}

void mouseClicked() {
    if(gameState != 2) reset.press();
}

