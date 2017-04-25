void setup() {
    size(800,600);
    /* @pjs preload="/assets/img/car.png"; */
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
            text("Rodzaj planszy: " + game.state + "\nAktualnie wybrany obrazek: " + tempUrl + "W: " + clickedImgWidth + " H:" + clickedImgHeight + "\nWersja developerska", 70, 18);
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
    this.backgroundColor = color(91, 147, 20);
    this.debug = new DebugPrototype();
    this.resetButton = new ResetButtonPrototype();
    this.checkButton = new CheckButtonPrototype();
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
        this.checkButton.draw();
        for(var i = 0; i < this.gameFields.length; i++) {
            this.gameFields[i].draw();
        }
        for(var i = 0; i < this.patternFields.length; i++) {
            this.patternFields[i].draw();
        }
    }
    
    this.drawWinState = function() {
        this.resetButton.draw();
        textAlign(CENTER);
        textSize(40);
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
        clickedImgWidth = 0;
        clickedImgHeight = 0;
        mouse.change("", 0, 0);
        for(var i = 0; i < this.gameFields.length; i++ ) {
            this.gameFields[i].url = "";
            this.gameFields[i].reloadImage();
        }
    }
    
    this.check = function() {
        var win = true;
        for(var i = 0; i < this.gameFields.length; i++) {
           if(this.gameFields[i].imgWidth != this.patternFields[i%this.patternFields.length].imgWidth) win = false; 
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
        if((mouseClick == 1) && ( this.url == "" )) fill(50,120,50); 
            else if ((mouseClick == 1) && (this.url != "")) fill(50,100,50);
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
            this.imgWidth = clickedImgWidth;
            this.imgHeight = clickedImgHeight;
            this.reloadImage();
            tempUrl = "";
            clickedImgWidth = 0;
            clickedImgHeight = 0;
            mouse.change("", 0, 0);
        } 
    }
}

var mouseField = function(url) {
    this.url = url || "";
    this.width = 100;
    this.height = 68;
    this.image = loadImage(this.url);
    this.reloadImage = function() {
        this.image = loadImage(this.url);
    }
    this.draw = function() {
        if(this.url != "" && game.state == 1) {
            image(this.image, mouseX, mouseY, this.width, this.height);
        }
    }
    this.change = function(url, width, height) {
        this.url = url;
        this.width = width;
        this.height = height;
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
            clickedImgWidth = this.imgWidth;
            clickedImgHeight = this.imgHeight;
            mouse.change(tempUrl, this.imgWidth, this.imgHeight);
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

game.patternFields.push(new patternField(400-133-66, 250, "/assets/img/car.png", 64, 44));
game.patternFields.push(new patternField(400-66, 250, "/assets/img/car.png", 80, 54));
game.patternFields.push(new patternField(400+133-66, 250, "/assets/img/car.png", 100, 68));

PImage tempIMG; tempIMG = loadImage("/assets/img/reset.png");
void draw() {
    game.draw();
    mouse.draw();
}

var mouseClick = 0;
var tempUrl = "";
var clickedImgWidth = 0;
var clickedImgHeight = 0;

void mouseClicked() {
    game.resetButton.press();
    game.checkButton.press();
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