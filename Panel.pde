class Panel 
{  
  int w, h, x, y;
  color c;
  PFont textFont;

  public Panel(int x, int y, int w, int h, color c) 
  {
    this.w = w;
    this.h = h;
    this.x = x;
    this.y = y;
    this.c = c;    
    textFont = createFont("MovingPictures.ttf", 16);
  }

  public void draw() 
  {
    stroke(c);
    strokeWeight(2);
    noFill();
    rect(x, y, w, h);
  }

  public int getWidth()
  {
    return w;
  }

  public void setWidth(int newWidth)
  {
    this.w = newWidth;
  }

  public int getHeight()
  {
    return h;
  }

  public void setHeight(int newHeight)
  {
    this.h = newHeight;
  }

  public int getX()
  {
    return x;
  }

  public void setX(int newX)
  {
    this.x = newX;
  }

  public int getY()
  {
    return y;
  }

  public void setY(int newY)
  {
    this.y = newY;
  }

  public void setText(String text)
  {
    textFont(textFont);
    textSize(16);
    int textX = x+w/4;
    int textY = y+h+16;
    if (text.length() >= 15) textX = x+w/8;
    text(text, textX, textY);
  }

  public void setImage(PImage img)
  {
    img.resize(w, h);
    image(img, x, y);
  }
}