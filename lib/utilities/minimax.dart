// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:fanorona/utilities/functions.dart';
import 'package:fanorona/utilities/variable.dart';

int minimax(int dim, bool mplayer, int node, List<List<int>> temp, List<List<bool>> moved){
  List<List<int>> minMax = List.generate(9, (index) => mplayer ? [50, -1, -1] : [0, -1, -1]);
  List<List<int>> list = List.generate(3, (i) => List.generate(3, (j) => temp[i][j]));
  List<List<bool>> tempMoved = List.generate(3, (i) => List.generate(3, (j) => moved[i][j]));

  if(node == 1){
    return 1;
  }

   OUTER : for(int i = 0; i < empty.length; i++){
    for(int j = 0; j < empty.length; j++){
      if( (mplayer == true) ?  list[i][j] == 1 : list[i][j] == 2){
        buildAlias(i, j, list);
        for(int m = 0; m < empty.length; m++){
          for(int n = 0; n < empty.length; n++){
            buildAlias(i, j, list);
            if(list[m][n] == 3){
              list[i][j] = 0;
              tempMoved[i][j] = true;
              if(dim == node){
                list[m][n] = 1;
                if(gameOver(m, n, list) && playerMoved(tempMoved, !mplayer)){
                  minMax[m*empty.length  + n][0] = 13;
                }
              }
              list[m][n] = (mplayer == true) ? 1 : 2;
              if(gameOver(m, n, list) && playerMoved(tempMoved, mplayer)){
                if(node == dim){
                  minMax[m*empty.length  + n][0] = 2*node;
                  minMax[m*empty.length  + n][1] = i;
                  minMax[m*empty.length  + n][2] = j;
                  break OUTER;
                }

                minMax[m*empty.length  + n][0] = 2*node;
              }
              else if(minMax[m*empty.length  + n][0] == 0 || minMax[m*empty.length  + n][0] == 50){
                transformEmpty(0, list);
                node = node - 1;
                minMax[m*empty.length  + n][0] = minimax(dim, !mplayer, node, list, tempMoved);
                node = node + 1;
              }
              minMax[m*empty.length  + n][1] = i;
              minMax[m*empty.length  + n][2] = j;
              tempMoved[i][j] = false;
              list = List.generate(3, (i) => List.generate(3, (j) => temp[i][j]));
            }
          }
        }
        list = List.generate(3, (i) => List.generate(3, (j) => temp[i][j]));
        tempMoved = List.generate(3, (i) => List.generate(3, (j) => moved[i][j]));
      }
    }
  }

  if(node == dim){
    print(minMax);
    for(int i = 0; i < minMax.length; i++){
      if(max(minMax.sublist(i)) == minMax[i][0]){
        oldBallSelected[0] = minMax[i][1];
        oldBallSelected[1] = minMax[i][2];
        move[minMax[i][1]][minMax[i][2]] = true;
        newBallSelected[0] = 10 + ( 162 * (i%empty.length));
        newBallSelected[1] = 180 + (165 * (i~/empty.length));
        break;
      }
    }
  }

  return mplayer ? min(minMax) : max(minMax); 
}

int min(List<List<int>> list){
  int min = list[0][0];
  for (var element in list) { 
    if(min > element[0]){
      min = element[0];
    }
  }
  return min;
}

int max(List<List<int>> list){
  int max = list[0][0];
  for (var element in list) { 
    if(max < element[0]){
      max = element[0];
    }
  }
  return max;
}
