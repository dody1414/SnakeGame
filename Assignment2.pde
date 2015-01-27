PrintWriter output;
   import ddf.minim.*;    //import library for sounds

    Minim minim;  //sounds objects
  AudioPlayer player;
  
  Minim minimCrash;
  AudioPlayer playerCrash;
//screen width and height
static int width = 500;
static int height = 500;
//speed of the game - delay time after each draw step
static int timeDelay = 100;


ArrayList<Player> players = new ArrayList<Player>();
boolean[] keys = new boolean[526];


void fileCopy(){  
  File file = saveFile("scores.txt");
  println(file);
 
  File dest = new File(savePath("new.txt"), "scores.txt");
  println(dest);
} 

void setup()
{
  size(width, height);
  setUpPlayerControllers();
  minim = new Minim(this);    //load sound for shoot
  player = minim.loadFile("sound//shootsound.mp3");
  minimCrash = new Minim(this);    //load sound to collide spaceship with Meteor
  playerCrash = minimCrash.loadFile("sound//Crash.wav");
}

void draw()
{
  for (Player player : players)
  {
    player.update();
    player.display();
  }
}

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}

boolean checkKey(char theKey)
{
  return keys[Character.toUpperCase(theKey)];
}

char buttonNameToKey(XML xml, String buttonName)
{
  String value =  xml.getChild(buttonName).getContent();
  if ("LEFT".equalsIgnoreCase(value))
  {
    return LEFT;
  }
  if ("RIGHT".equalsIgnoreCase(value))
  {
    return RIGHT;
  }
  if ("UP".equalsIgnoreCase(value))
  {
    return UP;
  }
  if ("DOWN".equalsIgnoreCase(value))
  {
    return DOWN;
  }
  //.. Others to follow
  return value.charAt(0);
}

void setUpPlayerControllers()
{
  XML xml = loadXML("arcade.xml");
  XML[] children = xml.getChildren("player");
  int gap = width / (children.length + 1);

  XML playerXML = children[0];
  Player p = new Player(
  0
    , color(random(0, 255), random(0, 255), random(0, 255))
    , playerXML);
  int x = (0 + 1) * gap;
  p.pos.x = 230;
  p.pos.y = 300;
  players.add(p);
}

