
/**********/
import java.awt.*;
import java.awt.event.*;
import java.io.*;
import java.util.*;

import javax.swing.*;

/**********/
PFont FONT = null;

Options OPTIONS = null;

Stat STAT = null;

CardManager CARDMANAGER = null;

DeckManager DECKMANAGER = null;

/*
void settings()
{
    
}
*/    
    
/**********/
void setup() 
{
    //init
    size(400, 900, P2D);
    smooth();
    frameRate(30);

    rectMode(CENTER);

    //font and text
    FONT = createFont("font.ttf", 40);
    textFont(FONT);
    textAlign(CENTER, CENTER);

    //run the loader
    LOADER = new Loader();
    LOADER.start();

    noLoop();
}

/**********/
void draw_stat()
{
    image(OPTIONS.bg_image, 0, 0, width, height);

    noFill();
    strokeJoin(ROUND);
    strokeWeight(7.5);

    stroke(OPTIONS.bg_color);
    rect(width/2+3, 150+3, 375, 275, 50);
    stroke(OPTIONS.fg_color);
    rect(width/2, 150, 375, 275, 50);
     
    stroke(OPTIONS.bg_color);
    rect(width/2+3, 450+3, 375, 275, 50);
    stroke(OPTIONS.fg_color);
    rect(width/2, 450, 375, 275, 50);

    fill(OPTIONS.bg_color);
    text(STAT.getGeneralString(), width/2+3, 150+3, 375, 275);
    fill(OPTIONS.fg_color);
    text(STAT.getGeneralString(), width/2, 150, 375, 275);

    fill(OPTIONS.bg_color);
    text(STAT.getRecentString(), width/2+3, 450+3, 375, 275);
    fill(OPTIONS.fg_color);
    text(STAT.getRecentString(), width/2, 450, 375, 275);


} 

/**********/
void draw_deck()
{
    int y_offset = 600;

    Deck deck = DECKMANAGER.selected;

    int counter = 0;

    for(int i=0; i<3; i++)
    {
        for(int j=0; j<4; j++)
        {
            Card card = deck.cards.get(counter);

            image(card.image, j*100, y_offset + i*100, 100, 100);

            counter++;
        }
    }
} 

/**********/
void draw() 
{    
    background(120);

    if(!LOADER.finished())
    {
        text("LOADING...", width/2, height/2, width, height);
        return;
    }
    
    draw_stat();

    draw_deck();
}
