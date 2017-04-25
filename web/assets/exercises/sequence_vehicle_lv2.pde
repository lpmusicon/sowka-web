void setup() {
    size(800,600);
    /* @pjs preload="/assets/img/ship.png"; */
    /* @pjs preload="/assets/img/car.png"; */
    /* @pjs preload="/assets/img/airplane.png"; */
    /* @pjs preload="/assets/img/reset.png"; */
    /* @pjs font='/assets/fonts/lato-light.ttf'; */
    PFont latoLight = createFont('/assets/fonts/lato-light.ttf');
    textFont(latoLight);
}

var DebugPrototype = function(isDebug) {
    this.isDebug = isDebug || false;
    this.draw = function() {
        if(this.isDebug)
        {
            this.drawGameState();
        }
    }
    this.drawGameState = function() {
            fill(255);
            textSize(16);
            textAlign(LEFT);
            text("Rodzaj planszy: " + game.state + "\nAktualnie wybrany obrazek: " + tempUrl + "\nWersja developerska", 70, 18);
    }
    this.drawFieldProperties = function(field) {
        text(field.url, field.x, field.y);
    }
}

var ResetButtonPrototype = function() {
    this.x = 10;
    this.y = 10;
    this.width = 40;
    this.height = 40;
    this.img = loadImage("/assets/img/reset.png");
    this.draw = function() {
        fill(255,255,255, 160);
        noStroke();
        rect(this.x-10, this.y-10, this.width+20, this.height+20);
        imageMode(CORNER);
        image(this.img, this.x, this.y, this.width, this.height);
    }
    this.press = function() {
        if((mouseX > this.x-10) && (mouseX < this.x+this.width+10) && (mouseY > this.y-10) && (mouseY < this.y+this.height+10)) game.state = 4;
    }
}

var CheckButtonPrototype = function() {
    this.x = 750;
    this.y = 10;
    this.width = 40;
    this.height = 40;
    this.img = loadImage("");
    this.draw = function() {
        fill(255,255,255, 160);
        noStroke();
        rect(this.x-10, this.y-10, this.width+20, this.height+20);
        imageMode(CORNER);
        image(this.img, this.x, this.y, this.width, this.height);
    }
    this.press = function() {
        if((mouseX > this.x-10) && (mouseX < this.x+this.width+10) && (mouseY > this.y-10) && (mouseY < this.y+this.height+10)) game.check();
    }
}

var gamePrototype = function() {
    this.state = 1;
    /*  1 = PLAYING
        2 = WIN
        3 = LOSE
        4 = RESET   */
    this.backgroundColor = color(#5697b5);
    this.debug = new DebugPrototype(false);
    this.resetButton = new ResetButtonPrototype();
    this.gameFields = [];
    this.patternFields = [];
    this.draw = function() {
        this.drawBackground();
        switch(this.state) 
        {
            case 1: this.drawPlayState(); break;
            case 2: this.drawWinState(); break;
            case 3: this.drawLoseState(); break;
            case 4: this.resetGame(); break;
        }
        this.debug.draw();
    }
    
    this.drawPlayState = function() {
        this.resetButton.draw();
        for(var i = 0; i < this.gameFields.length; i++) {
            this.gameFields[i].draw();
        }
        for(var i = 0; i < this.patternFields.length; i++) {
            this.patternFields[i].draw();
        }
    }
    
    this.drawWinState = function() {
        textAlign(CENTER);
        textSize(40);
        fill(255);
        text("Gratulacje!", 400, 100);
        text("Oto twoja nagroda", 400, 180);
        context.drawImage(reward, 272, 300, 256, 256);
    }
    
    this.drawLoseState = function() {
        this.resetButton.draw();
        textAlign(CENTER);
        textSize(40);
        text("Wygląda na to, że musisz poćwiczyć \nSpróbuj jeszcze raz\n:)", 400, 200);
    }
    
    this.resetGame = function() {
        this.state = 1;
        mouseClick = 0;
        tempUrl = "";
        mouse.change("");
        for(var i = 0; i < this.gameFields.length; i++ ) {
            this.gameFields[i].url = "";
            this.gameFields[i].reloadImage();
        }
    }
    
    this.check = function() {
        var win = true;
        for(int i = 0; i < this.gameFields.length; i++) {
           if(this.gameFields[i].url != this.patternFields[i%this.patternFields.length].url) win = false; 
        }
        if(win) this.state = 2; else this.state = 3;
    }
    
    this.drawBackground = function() {
        background(this.backgroundColor);
    }
}

var gameField = function(x, y, url, imgWidth, imgHeight) {
    this.url = url || "";
    this.x = x || 0;
    this.y = y || 0;
    this.image = loadImage(this.url);
    this.width = 134;
    this.height = 100;
    this.imgWidth = imgWidth || this.width;
    this.imgHeight = imgHeight || this.height;
    this.reloadImage = function() {
        this.image = loadImage(this.url);
    }
    this.draw = function() {
        if((mouseClick == 1) && ( this.url == "" )) fill(#349079); 
            else if ((mouseClick == 1) && (this.url != "")) fill(#349079);
            else fill(game.backgroundColor);
        stroke(255, 255, 255, 128);
        rect(this.x, this.y, this.width, this.height);
        imageMode(CENTER);
        noStroke();
        image(this.image, this.x+this.width/2, this.y+this.height/2, this.imgWidth, this.imgHeight);    
    }
    this.click = function() {
        if((mouseX > this.x) && (mouseX < this.x+this.width) && (mouseY > this.y) && (mouseY < this.y+this.height) && (mouseClick == 1)) {
            mouseClick = 0;
            this.url = tempUrl;
            this.reloadImage();
            tempUrl = "";
            mouse.change("");
        } 
    }
}

var mouseField = function(url) {
    this.url = url || "";
    this.image = loadImage(this.url);
    this.reloadImage = function() {
        this.image = loadImage(this.url);
    }
    this.draw = function() {
        if(this.url != "" && game.state == 1) {
            image(this.image, mouseX, mouseY, 100, 68);
        }
    }
    this.change = function(url) {
        this.url = url;
        this.reloadImage();
    }
}

var mouse = new mouseField("");

var patternField = function(x, y, url, imgWidth, imgHeight) {
    this.url = url || "";
    this.x = x || 0;
    this.y = y || 0;
    this.image = loadImage(this.url);
    this.width = 133;
    this.height = 100;
    this.imgWidth = imgWidth || this.width;
    this.imgHeight = imgHeight || this.height;
    
    this.draw = function() {
        fill(255, 255, 255, 50);
        stroke(255);
        rect(this.x, this.y, this.width, this.height);
        imageMode(CENTER);
        image(this.image, this.x+this.width/2, this.y+this.height/2, this.imgWidth, this.imgHeight);    
    }
    
    this.click = function() {
        if((mouseX > this.x) && (mouseX < this.x+this.width) && (mouseY > this.y) && (mouseY < this.y+this.height)) {
            mouseClick = 1;
            tempUrl = this.url;
            mouse.change(tempUrl);
        }
    }
}

var game = new gamePrototype();
game.gameFields.push(new gameField(0, 499, "", 100, 68 ));
game.gameFields.push(new gameField(134, 499, "", 100, 68 ));
game.gameFields.push(new gameField(267, 499, "", 100, 68 ));
game.gameFields.push(new gameField(400, 499, "", 100, 68 ));
game.gameFields.push(new gameField(533, 499, "", 100, 68 ));
game.gameFields.push(new gameField(665, 499, "", 100, 68 ));

game.patternFields.push(new patternField(400-200, 250, "/assets/img/airplane.png", 100, 68));
game.patternFields.push(new patternField(400-67, 250, "/assets/img/car.png", 100, 68));
game.patternFields.push(new patternField(400+66, 250, "/assets/img/ship.png", 133, 100));

PImage tempIMG; tempIMG = loadImage("/assets/img/reset.png");

var all = true;
void draw() {
    if(game.state == 1) {
    all = true;
    for(var i = 0; i < game.gameFields.length; i++) {
        if(game.gameFields[i].url == "") { all = false };
    }
    if(all) { game.check(); }
    }
    game.draw();
    mouse.draw();
}

var mouseClick = 0;
var tempUrl = "";
void mouseClicked() {
    game.resetButton.press();
    if(game.state == 1) {
        for(var z = 0; z < game.patternFields.length; z++) {
            game.patternFields[z].click();
        }
        if(mouseClick == 1) {
            for(var z = 0; z < game.gameFields.length; z++) {
                game.gameFields[z].click();
            }
        }
    }
}