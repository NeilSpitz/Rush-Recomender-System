/*
  Name: Neil Spiteri
  SRN: 160335291
  Processing v. 3.2.1
  Credits: 
    All music, album artwork and font styles are the original work of the artist, Rush.
    Font styles obtained from: http://www.2112.net/rushfonts/
    Icons obtained from: https://www.iconfinder.com/
*/
import processing.sound.*;

PImage volControl, logo, Hemispheres, MovingPictures, Signals, SelfTitled, FlyByNight, PermanentWaves, ThumbsUp, ThumbsDown, StopButton, PauseButton, PlayButton;
PFont rushFont, nowFont, playingFont;
color panelBorder;

Panel song1, song2, song3, song4, song5, song6, controlPanel, volumePanel, thumbsUpPanel, thumbsDownPanel, stopButtonPanel, playButtonPanel;
SoundFile[] file;
HScrollbar volumeBar;

String url, nowPlaying;
String[] songNames = new String[]{"Tom Sawyer.mp3", "Subdivisions.mp3", "Working Man.mp3", "Fly By Night.mp3", "La Villa Strangiato.mp3", "The Spirit Of Radio.mp3"};
int controlPanelWidth, panelWidth, panelPadding, panelHeight, buttonWidth, buttonHeight, i;
float normalize;

void setup() {
  size(1024, 512);
  background(0);
  loadData();

  song1 = new Panel(width/12, height/3, panelWidth, panelHeight, panelBorder);
  song1.setText("Tom Sawyer");
  song1.setImage(MovingPictures);

  song2 = new Panel(width/12, 2*height/3, panelWidth, panelHeight, panelBorder);
  song2.setText("Subdivisions");
  song2.setImage(Signals);

  song3 = new Panel(width/12 + panelWidth + panelPadding, height/3, panelWidth, panelHeight, panelBorder);
  song3.setText("Working Man");
  song3.setImage(SelfTitled);

  song4 = new Panel(width/12 + panelWidth + panelPadding, 2*height/3, panelWidth, panelHeight, panelBorder);
  song4.setText("Fly By Night");
  song4.setImage(FlyByNight);

  song5 = new Panel(width/12 + 2*panelWidth + 2*panelPadding, height/3, panelWidth, panelHeight, panelBorder);
  song5.setText("La Villa Strangiato");
  song5.setImage(Hemispheres);

  song6 = new Panel(width/12 + 2*panelWidth + 2*panelPadding, 2*height/3, panelWidth, panelHeight, panelBorder);
  song6.setText("The Spirit of Radio");
  song6.setImage(PermanentWaves);

  controlPanel.draw();
  song1.draw();
  song2.draw();
  song3.draw();
  song4.draw();
  song5.draw();
  song6.draw();
  nowPlaying();
}

void loadData()
{
  controlPanelWidth = 250;
  panelWidth = 175;
  panelHeight = 125;
  panelPadding = 50;

  buttonWidth = 20;
  buttonHeight = 20;

  url = "https://www.amazon.co.uk";

  panelBorder = color(255, 0, 0);
  volumeBar = new HScrollbar(5*width/6 - 20, 2*height/3, width/6, 16, 20);
  MovingPictures = loadImage("MovingPictures.jpg");
  Hemispheres = loadImage("Hemispheres.jpg");
  Signals = loadImage("Signals.jpg");
  SelfTitled = loadImage("SelfTitled.jpg");
  FlyByNight = loadImage("FlyByNight.jpg");
  PermanentWaves = loadImage("PermanentWaves.jpg");
  
  controlPanel = new Panel(width - controlPanelWidth, 0, controlPanelWidth, height, 127);
  
  volumePanel = new Panel(5*width/6 - 5*buttonWidth/2, 2*height/3 - buttonHeight/2, buttonWidth, buttonHeight, 0);
  volControl = loadImage("speaker.png");
  volumePanel.setImage(volControl);

  thumbsUpPanel = new Panel(5*width/6 - 5*buttonWidth/2, height/3, 2*buttonWidth, 2*buttonHeight, 0);
  ThumbsUp = loadImage("ThumbsUp.png");
  thumbsUpPanel.setImage(ThumbsUp);

  thumbsDownPanel = new Panel(width - 3*buttonWidth, height/3, 2*buttonWidth, 2*buttonHeight, 0);
  ThumbsDown = loadImage("ThumbsDown.png");
  thumbsDownPanel.setImage(ThumbsDown);

  playButtonPanel = new Panel(thumbsDownPanel.getX(), height/3 + panelHeight/2, 2*buttonWidth, 2*buttonHeight, 0);
  PlayButton = loadImage("PlayButton.png");
  playButtonPanel.setImage(PlayButton);

  stopButtonPanel = new Panel(thumbsUpPanel.getX(), height/3 + panelHeight/2, 2*buttonWidth, 2*buttonHeight, 0);
  StopButton = loadImage("StopButton.png");
  stopButtonPanel.setImage(StopButton);

  logo = loadImage("rush.png");
  logo.resize(150, 100);
  image(logo, width/2 - logo.width, 20);
  rushFont = createFont("RushThroughTime.ttf", 20);
  playingFont = createFont("Bravado.ttf", 20);
  nowFont = createFont("ExitStageLeft.ttf", 20);
  textFont(rushFont);
  text("Song Sampler Suite", width/2 - 200, 120);

  nowPlaying = "None";
  file = new SoundFile[6];

  for (int i = 0; i < songNames.length; i++)
    file[i] = new SoundFile(this, songNames[i]);
}

void draw()
{
  for (int i = 0; i < songNames.length; i++)
  {
    normalize = (volumeBar.getPos() - 920) / (168);
    file[i].amp(normalize);
  }
  volumeBar.update();
  volumeBar.display();
}

void stopPlaying()
{
  for (int i = 0; i < songNames.length; i++)
    file[i].stop();
}

void mouseClicked()
{     
  if (mouseX <= thumbsUpPanel.getX() + thumbsUpPanel.getWidth() && mouseX >= thumbsUpPanel.getX() && mouseY <= thumbsUpPanel.getY() + thumbsUpPanel.getWidth() && mouseY >= thumbsUpPanel.getY())
    link(url);
  if (mouseX <= thumbsDownPanel.getX() + thumbsDownPanel.getWidth() && mouseX >= thumbsDownPanel.getX() && mouseY <= thumbsDownPanel.getY() + thumbsDownPanel.getWidth() && mouseY >= thumbsDownPanel.getY())
    stopPlaying();
  //Song 1
  if (mouseX <= song1.getX() + panelWidth && mouseX >= song1.getX() && mouseY <= song1.getY() + panelHeight && mouseY >= song1.getY())
  {
    stopPlaying();
    file[0].play();
    nowPlaying = songNames[0];
    url = "https://www.amazon.co.uk/Moving-Pictures-2011-Remaster-Rush/dp/B004UT0S36/ref=ice_ac_b_dpb?ie=UTF8&qid=1520805214&sr=8-2&keywords=moving+pictures";
  }
  //Song 2
  if (mouseX <= song2.getX() + panelWidth && mouseX >= song2.getX() && mouseY <= song2.getY() + panelHeight && mouseY >= song2.getY())
  {
    stopPlaying();
    file[1].play();
    nowPlaying = songNames[1];
    url = "https://www.amazon.co.uk/gp/product/B001KV4Q9Y/ref=dm_ws_sp_ps_dp";
  }
  //Song 3
  if (mouseX <= song3.getX() + panelWidth && mouseX >= song3.getX() && mouseY <= song3.getY() + panelHeight && mouseY >= song3.getY())
  {
    stopPlaying();
    file[2].play();
    nowPlaying = songNames[2];
    url = "https://www.amazon.co.uk/Rush/dp/B001KF63J6/ref=sr_1_5?ie=UTF8&qid=1520807282&sr=8-5&keywords=rush+album";
  }
  //Song 4
  if (mouseX <= song4.getX() + panelWidth && mouseX >= song4.getX() && mouseY <= song4.getY() + panelHeight && mouseY >= song4.getY())
  {
    stopPlaying();
    file[3].play();
    nowPlaying = songNames[3];
    url = "https://www.amazon.co.uk/Fly-Night-Rush/dp/B01N064RH6/ref=ice_ac_b_dpb?ie=UTF8&qid=1520807397&sr=8-1&keywords=rush+fly+by+night";
  }
  //Song 5
  if (mouseX <= song5.getX() + panelWidth && mouseX >= song5.getX() && mouseY <= song5.getY() + panelHeight && mouseY >= song5.getY())
  {
    stopPlaying();
    file[4].play();
    nowPlaying = songNames[4];
    url = "https://www.amazon.co.uk/Hemispheres-Rush/dp/B001KUYWIU/ref=sr_1_1?ie=UTF8&qid=1520807438&sr=8-1&keywords=rush+hemispheres+cd";
  }
  //Song 6
  if (mouseX <= song6.getX() + panelWidth && mouseX >= song6.getX() && mouseY <= song6.getY() + panelHeight && mouseY >= song6.getY())
  {
    stopPlaying();
    file[5].play();
    nowPlaying = songNames[5];  
    url = "https://www.amazon.co.uk/Permanent-Waves-Rush/dp/B001KV6S2W/ref=ice_ac_b_dpb?ie=UTF8&qid=1520807457&sr=8-1&keywords=rush+permanent+waves";
  }
  //Stop Button
  if (mouseX <= stopButtonPanel.getX() + stopButtonPanel.getWidth() && mouseX >= stopButtonPanel.getX() && mouseY <= stopButtonPanel.getY() + stopButtonPanel.getWidth() && mouseY >= stopButtonPanel.getY())
    stopPlaying();
  //Play Button
  if (mouseX <= playButtonPanel.getX() + playButtonPanel.getWidth() && mouseX >= playButtonPanel.getX() && mouseY <= playButtonPanel.getY() + playButtonPanel.getWidth() && mouseY >= playButtonPanel.getY())
  {
    stopPlaying();
    for (int i = 0; i < songNames.length; i++)
      if (songNames[i] == nowPlaying) file[i].play();
  }
  nowPlaying();
}

void nowPlaying()
{
  int songCount = 6;
  fill(0);
  noStroke();
  rect(controlPanel.getX() + 2, 0, width - controlPanel.getWidth(), 150);
  textFont(playingFont);
  textSize(20);
  fill(255);
  float duration = 0;
  for (i = 0; i < songNames.length; i++)
    if (songNames[i] == nowPlaying)
    {
      songCount = i;
      duration = file[i].duration();
    }
    
  int seconds = (int)duration % 60;
  int minutes = (int)duration / 60;
  String[] currentSong = split(nowPlaying, '.');
  
  text("Now Playing: \n"+"          "+currentSong[0], thumbsUpPanel.getX(), thumbsUpPanel.getY() - panelHeight); 
  text("\nDuration: "+minutes+":"+seconds, thumbsUpPanel.getX(), thumbsUpPanel.getY() - 2*thumbsUpPanel.getHeight());
  albumInfo(songCount);
}

void albumInfo(int album)
{
  fill(0);
  rect(controlPanel.getX()+2, volumePanel.getY() + volumePanel.getHeight(), width - controlPanel.getWidth(), 150);
  String[] albums = {"Moving Pictures,1981", "Signals,1982", "Rush,1974", "Fly By Night,1975", "Hemispheres,1978", "Permanent Waves,1980", "None,"};
  fill(255);
  String[] albumYear = split(albums[album], ',');
  text("Album Title: \n"+albumYear[0]+"\nReleased: \n"+albumYear[1], thumbsUpPanel.getX(), volumePanel.getY() + 3*volumePanel.getHeight());
}