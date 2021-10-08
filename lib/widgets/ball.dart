// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:fanorona/variable.dart';
import 'package:fanorona/widgets/alias.dart';
import 'package:flutter/material.dart';


class Ball extends StatefulWidget {
  int player;
  double dx;
  double dy;
  void Function() onTapped;
  void Function(double x, double y) onAccept;
  void Function() onDragStart;
  void Function() onDragEnded;
  void Function() onSelected;
  bool isSelected;
  Ball({ Key? key, required this.onSelected, required this.onAccept, required this.player, required this.dx, required this.dy, required this.onTapped, required this.onDragStart, required this.isSelected, required this.onDragEnded}) : super(key: key);
  
  @override
  _BallState createState() => _BallState();
}

class _BallState extends State<Ball> {
  late Offset position;
  bool _animate = false;
  void updatePosition(Offset newPosition) =>
      setState(() => position = newPosition);
  
  @override
  void initState(){
    super.initState();
    position = Offset(widget.dx, widget.dy);
  }

  @override
  Widget build(BuildContext context) {

    if((10.0 + ( 162 * oldBallSelected[1])).compareTo(widget.dx) == 0 && (180.0 + (165 * oldBallSelected[0])).compareTo(widget.dy) == 0 && newBallSelected[0] != -1 && newBallSelected[1] != -1){
      Future.delayed(const Duration(milliseconds: 50), (){
        empty[oldBallSelected[0]][oldBallSelected[1]] = 0;
        player ? empty[(newBallSelected[1] - 180 )~/ 165][(newBallSelected[0] - 10)~/ 162] = 2 : empty[(newBallSelected[1] - 180 )~/ 165][(newBallSelected[0] - 10)~/ 162] = 1;
        oldBallSelected[0] = -1;
        oldBallSelected[1] = -1;
        setState(() {
          _animate = true;
        });
      Future.delayed(const Duration(milliseconds: 560), (){
        _animate = false;
      });
      });
    }

    if(widget.player == 0){
      return Container();
    }
    else if(widget.player == 3){
      return Alias(dx: widget.dx, dy: widget.dy, isForAlias: true, onTapped: widget.onSelected);
    }
    else {
      if((player && widget.player == 1) ||(!player && widget.player == 2)){
        return GestureDetector(
          onTap: (){ 
            widget.onTapped();
          },       
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                left: widget.isSelected ? widget.dx / 1.045 : widget.dx,
                top: widget.isSelected ? widget.dy / 1.045 : widget.dy,
                width: widget.isSelected ? 65 : 50,
                height: widget.isSelected ? 65 : 50,
                child: Stack(
                  children: [
                    Draggable(
                      onDragStarted: (){
                        widget.onDragStart();
                      },
                      childWhenDragging: Container(),
                      feedback: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: widget.player == 1 ? Colors.blue : Colors.grey
                        ),
                      ),
                      onDragEnd: (details) {
                        updatePosition(details.offset);
                        widget.onDragEnded();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: widget.player == 1 ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ),
                    Stack(
                      children: List.generate(3, (index){
                        double dx = 0;
                        double dy = 0;
                        return DragTarget<int>(
                          builder: (
                            BuildContext context,
                            List<dynamic> accepted,
                            List<dynamic> rejected,
                          ) {
                            OUTER : for(int i= 0; i < 3; i++){
                              for(int j = 0; j < 3; j++){
                                if(empty[i][j] == 0 || empty[i][j] == 3){
                                  dx = 10.0 + (162 * j);
                                  dy = 180.0 + (165 * i);
                                  break OUTER;
                                }
                              }
                            }
                            return Stack(
                              children: [
                                Alias(dx: dx, dy: dy, isForAlias: false),
                              ],
                            );
                          },
                          onAccept: (int data){
                            //empty[(dy - 180 )~/ 165][(dx - 10)~/ 162] = 1;
                            widget.onAccept(widget.dx, widget.dy);
                          },
                        );
                      })
                    )
                  ],
                ),               
              ),
            ],
          ),
        );
      }
      else{
        return Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: _animate ? newBallSelected[0].toDouble() : widget.dx,
              top: _animate ? newBallSelected[1].toDouble() : widget.dy,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: widget.player == 1 ? Colors.blue : Colors.grey
                ),
              ),
            ),
          ],
        );
      }
    }
  }
}
