import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  static const twentyFiveMinutes = 1500;

  int totalSeconds = twentyFiveMinutes;
  bool isRunning = false;
  int totalPomodoros = 0;
  late Timer timer;

  void onTick(Timer timer){  //1초마다 시행되는 함수
    if(totalSeconds == 0){ //totalSeconds가 0이 되면
      setState((){
        totalPomodoros = totalPomodoros + 1;  //totalPomodoros를 1 증가시키기
        isRunning = false; //isRunning도 false로 바꾸기 -> 아이콘 모양이 바뀜
        totalSeconds = twentyFiveMinutes;  //totalSeconds는 다시 1500으로 복귀
      });
      timer.cancel();  //타이머 멈추기
    }
    else{
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }

  }

  void onStartPressed(){
    timer = Timer.periodic(
        Duration(seconds: 1),
        onTick
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed(){ //멈추기
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  //타이머를 분단위로 표시하기 위한 함수
  String format(int seconds){
    var duration = Duration(seconds: seconds);
    //print(duration.toString().split("."));
    //duration을 문자열로 바꾸고 '.'을 기준으로 분할
    //list를 받게 됨 ex) [0:25:00, 000000] -> 이처럼 '.'을 기준으로 분할하여 list에 저장

    //print(duration.toString().split(".").first.subString(2,7));
    //우리는 리스트의 첫번째 부분만 필요하니까 .first 작성
    //또한 2번째 요소부터 7번째 까지가 필요하니까 .substring(2,7) 작성
    return duration.toString().split(".").first.substring(2,7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).
      backgroundColor,
      body:  Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(format(totalSeconds),
                style: TextStyle(color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex : 3,
            child: Center(
              child: IconButton(
                iconSize: 120,
                color: Theme.of(context).cardColor,
                onPressed: isRunning?
                onPausePressed : onStartPressed,
                icon: Icon(isRunning?
                Icons.pause_circle_outline:Icons.play_circle_outline),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      //borderRadius: BorderRadius.circular(50), //맨 아래 박스 모서리를 둥글게 만들기
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Pomodors',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of
                              (context).textTheme.
                            headline1!.color,
                          ),
                        ),
                        Text('$totalPomodoros',
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.w600,
                            color: Theme.of
                              (context).textTheme.
                            headline1!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}