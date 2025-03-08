import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 10;
public final static int NUM_COLS = 10;
public final static int NUM_MINES = 10;
private MSButton[][] buttons;//2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS; c++){
       buttons[r][c] = new MSButton(r,c); 
      }
    }
    
    
    setMines();
}
public void setMines()
{
    for(int i = 0; i < NUM_MINES ; i ++)
  {
    int row = (int)(Math.random()*NUM_ROWS);
    int col = (int)(Math.random()*NUM_COLS);
    if(!mines.contains(buttons[row][col]))
    {
      mines.add(buttons[row][col]);
    }
  }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    for(int i = 0; i < buttons.length;i++){
     for(int j = 0; j < buttons[i].length;j++){
      if(mines.contains(buttons[i][j]) && !buttons[i][j].isFlagged()){
       return false; 
      }
      if(!mines.contains(buttons[i][j]) && !buttons[i][j].clicked){
       return false; 
      }
     }
    }
    return true;
}
public void displayLosingMessage()
{
  String [] los = {"G","A","M","E","O","V","E","R"};
   if(!isWon()){
      for(int i = 0; i < los.length; i++){
       if(i < NUM_COLS){
        buttons[0][i+1].setLabel(los[i]);
        buttons[0][i+1].clicked = true;
       }
      }
   }
}
public void displayWinningMessage()
{
  String [] win = {"W","I","N","N","E","R","R","R"};
    if(isWon()){
      for(int i = 0; i < win.length; i++){
       if(i < NUM_COLS){
        buttons[0][i+1].setLabel(win[i]);
        buttons[0][i+1].clicked = true;
       }
}
}
}
public boolean isValid(int r, int c)
{
      if(r >= NUM_ROWS || r < 0) return false;
  else if(c >= NUM_COLS || c < 0) return false;
  return true;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    //your code here
    for(int r = row-1;r<= row+1;r++)
    for( int c = col-1; c<= col+1;c++)
    if(isValid(r,c) && mines.contains(buttons[r][c]))
    numMines++;
    if(mines.contains(buttons[row][col]))
    numMines--;
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(mouseButton == RIGHT)
        {
         if(flagged)
         {
           flagged = false;
           clicked = false;
         }
         else{
flagged = true;
}
        }
        else if(mines.contains(this))
        {
          displayLosingMessage();
        }
        else if(countMines(myRow,myCol) > 0)
        {
         buttons[myRow][myCol].myLabel = countMines(myRow, myCol)+"";
        }
        else
        {
          if(isValid(myRow,myCol-1) && buttons[myRow][myCol-1].clicked == false) buttons[myRow][myCol-1].mousePressed();
          if(isValid(myRow,myCol+1) && buttons[myRow][myCol+1].clicked == false) buttons[myRow][myCol+1].mousePressed();
          if(isValid(myRow+1,myCol) && buttons[myRow +1][myCol].clicked == false) buttons[myRow+1][myCol].mousePressed();
          if(isValid(myRow-1,myCol) && buttons[myRow -1][myCol].clicked == false) buttons[myRow-1][myCol].mousePressed();
          if(isValid(myRow+1,myCol+1) && buttons[myRow +1][myCol+1].clicked == false) buttons[myRow+1][myCol+1].mousePressed();
          if(isValid(myRow+1,myCol-1) && buttons[myRow +1][myCol-1].clicked == false) buttons[myRow+1][myCol-1].mousePressed();
          if(isValid(myRow-1,myCol-1) && buttons[myRow -1][myCol-1].clicked == false) buttons[myRow-1][myCol-1].mousePressed();
          if(isValid(myRow-1,myCol+1) && buttons[myRow -1][myCol+1].clicked == false) buttons[myRow-1][myCol+1].mousePressed();
        } 
    }
    public void draw () 
    {    
        if (flagged)
            fill(0,0,255);
        else if( clicked && mines.contains(this) ) 
         fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}

