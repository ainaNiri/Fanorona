// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:fanorona/utilities/variable.dart';

bool playerWin(int x, int y, int dx, int dy, List<List<int>> list){
  int playerWin = 0;
  int dimension = 3;
  for(int i = 0; i  < dimension; i++){
    if(x + i * dx < list.length && x + i * dx >= 0 && y + i * dy >= 0 && y + i * dy < list.length){
      for(int j = -i + 1; j  < i + dimension; j++){
        if(x - j * dx < list.length && x - j * dx >= 0 && y - j * dy >= 0 && y - j * dy < list.length){
          if( list[x + i * dx][y + i * dy] == list[x - j * dx][y - j * dy]){
            playerWin = playerWin + 1;
          }
          else{
            break;
          }
        }
        else{
          break;
        }
      }
      if( playerWin == dimension - 1){
        return true;
      }
      playerWin = 0;
    }
  }
  return false;
}

void transformEmpty(int number, List<List<int>> list){
  for(int i= 0; i < 3; i++){
    for(int j = 0; j < 3; j++){
      if(list[i][j] == 0) list[i][j] = number;
      else if(list[i][j] == 3) list[i][j] = number;
    }
  }
}

void buildAlias(int x, int y, List<List<int>> list){
   if(x + 1 < empty.length){
      if(list[x+1][y] == 0) list[x+1][y] = 3;
    }
    if(x + 1 < empty.length && y + 1 < empty.length && x == y){
      if(list[x+1][y + 1] == 0) list[x+1][y+1] = 3;
    }
    if(y + 1 < empty.length){
      if(list[x][y + 1] == 0) list[x][y+1] = 3;
    }
    if(x - 1 >= 0 && y + 1 < empty.length && (x == y || (x == 2 && y == 0))){
      if(list[x-1][y+1] == 0) list[x-1][y+1] = 3;
    }
    if(x - 1 >= 0){
      if(list[x-1][y] == 0) list[x-1][y] = 3;
    }
    if(x - 1 >= 0 && y - 1 >= 0 && x == y){
      if(list[x-1][y-1] == 0) list[x-1][y-1] = 3;
    }
    if(y - 1 >= 0){
      if(list[x][y-1] == 0) list[x][y-1] = 3;
    }
    if(x + 1 < empty.length && y - 1 >= 0 && (x == y || (x == 0 && y == 2))){
      if(list[x+1][y-1] == 0) list[x+1][y-1] = 3;
    }
} 
bool gameOver(int i, int j, List <List <int>> list){
  if(playerWin(i, j, 1, 0, list) || playerWin(i, j, 0, 1, list) || playerWin(i, j, 1, 1, list) || playerWin(i, j, 1, -1, list)){
    return true;
  }
  return false;
}

void reset(){
  isSelected1 = [
    [false, false, false],
    [false, false, false],
    [false, false, false]
  ];
  empty = [
    [1, 1, 1],
    [0, 0, 0],
    [2, 2, 2]
  ];

  move = [
    [false, false, false],
    [false, false, false],
    [false, false, false]
  ];
  
  newBallSelected = [-1, -1];
  oldBallSelected = [-1, -1];

  player = true;
}

bool playerMoved(List<List<bool>> moved ){
  if((moved[0][0] && moved[0][1] && moved[0][2]) || (moved[2][0] && moved[2][1] && moved[2][2])){
    return true;
  }

  return false;
}