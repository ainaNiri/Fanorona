import 'dart:math';

import 'package:fanorona/utilities/functions.dart';
import 'package:fanorona/models/player.dart';
import 'package:fanorona/utilities/minimax.dart';
import 'package:fanorona/utilities/variable.dart';
import 'package:fanorona/widgets/ball.dart';
import 'package:fanorona/widgets/rectangle.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({ Key? key }) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Fonorona", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 3,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            itemBuilder: (context)=> <PopupMenuEntry> [
                PopupMenuItem(
                  onTap: (){
                    setState(() {
                      reset();
                    }); 
                  },
                  child: const Text("Restart")
                )
            ]
          )
        ]
      ),
      body:Stack(
        children: [
          Positioned(
            left: 30,
            top: 100,
            child: Row(
              children: [
                Text("Player 1", style: TextStyle(color: player ? Colors.black : const Color.fromRGBO(220, 220, 220, 1))),
                const SizedBox(width: 15,),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: !player ? Colors.green[100] : Colors.green
                  ),
                )
              ],
            ),
          ),
          Stack(
            children: [
              const Fanorona(),
              Stack(
                children: 
                  List.generate(3, (i) => Stack(
                    children: 
                      List.generate(3, (j) => Ball(player: empty[i][j],
                        dx: 10.0 + ( 162 * j), dy: 180.0 + (165 * i), isSelected: isSelected1[i][j],
                        onSelected: (){
                          //empty[oldBallSelected[0]][oldBallSelected[1]] = 0;
                          // oldBallSelected[0] = 0;
                          // oldBallSelected[1] = 0;
                          transformEmpty(0, empty);
                          Future.delayed(const Duration(milliseconds: 500), (){
                            play = true;
                            if(gameOver(i, j, empty) && playerMoved(move)){
                              versus = false;
                              if(player) {
                                showWinDialog(context, "Player 2 win");
                              } else {
                                showWinDialog(context, "Player 1 win");
                              }
                            }
                          });
                          Future.delayed(const Duration(milliseconds: 1200), (){
                            if(versus){
                              play = false;
                              int temp = minimax(7, false, 7, empty, move);
                              Future.delayed(const Duration(milliseconds: 500), (){
                                play = true;
                                if(gameOver((newBallSelected[1] - 180 )~/ 165, (newBallSelected[0] - 10)~/ 162, empty) && playerMoved(move)){
                                  showWinDialog(context, "Computer win");
                                }
                              });
                              setState(() {
                                player = !player;
                              });
                            }
                          });
                          setState(() {
                            player = !player;
                          });                         
                        },
                        onDragStart: (){
                          if(play){
                            buildAlias(i, j, empty);
                            setState(() {
                              
                            });
                          }
                        },
                        onDragEnded: (){
                          transformEmpty(0, empty);
                          setState(() {
                            
                          });
                        },
                        onAccept: (x, y){
                          empty[(x - 10 )~/ 162][(y - 180)~/ 165] = 0;
                          setState(() {
                            
                          });
                        },
                        onTapped: (){
                          if(play){
                            newBallSelected[0] = -1;
                            newBallSelected[1] = -1;
                            bool a = !isSelected1[i][j];
                            isSelected1[i][j] = !isSelected1[i][j];
                            if(isSelected1[i][j]){
                              oldBallSelected[0] = i;
                              oldBallSelected[1] = j;
                              transformEmpty(0, empty);
                              buildAlias(i, j, empty);
                            }
                            else{
                              oldBallSelected[0] = 0;
                              oldBallSelected[1] = 0; 
                              transformEmpty(0, empty);
                            }
                            for(int x = 0; x < 3; x++){
                              for(int y = 0; y < 3; y++){
                                isSelected1[x][y] = false;
                              }
                            }
                            isSelected1[i][j] = a;
                            setState(() {
                              
                            });
                          }
                        },
                      ),
                    )
                  ),
                )
              ),
            ]
          ),
          Positioned(
            left: 280,
            top: 620,
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color:  player ? Colors.green[100] : Colors.green
                  ),
                ),
                const SizedBox(width: 15,),
                Text("Player 2", style: TextStyle(color: !player ? Colors.black : const Color.fromRGBO(220, 220, 220, 1))),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  void showWinDialog(BuildContext context, String text){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))
          ),
          content: Container(
            height: 50,
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Text(text, style: const TextStyle(fontSize: 20),),
            ),
          ),
          actions: [
            TextButton(
              child: const Text("OK", style: TextStyle(fontSize: 20)),
              onPressed:(){
                reset();
                Navigator.of(context).pop();
                setState(() {
                  
                });
              }
            )
          ]
        );
      }
    );
  }
}