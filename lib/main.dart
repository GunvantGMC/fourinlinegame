import 'package:flutter/material.dart';
import 'package:fourinlinegame/showToast.dart';
import 'package:slider_button/slider_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '4 In Line Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '4 In Line Game'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Array Indicates The Arrow Position For Respective Players
  var player1Arrow = [false, false, false, false, false, false, true];
  var player2Arrow = [true, false, false, false, false, false, false];

  List<Object> allPlayerDiskArray = new List();
  //var allPlayerDiskArray = [];

  int totalGrids = 42;

  bool playerTurn = false;
  // False Indicates Blue Player (P1) Turn --- True Indicates Green Player (P2) Turn.

  @override
  void initState() {
    for (int i = 0; i < totalGrids; i++) {
      allPlayerDiskArray.add("");
      //if (i == 24) allPlayerDiskArray.insert(i, true);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Color(0xff194c5c),
      body: Container(
        width: 360,
        height: 640,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Player 1 Functionality.
            getPlayer1Widgets(),

            // Game Grid Board.
            getGameGridBoard(),

            // Player 2 Functionality.
            getPlayer2Widgets()
          ],
        ),
      ),
    );
  }

  getPlayer1Widgets() {
    // Player 1 Functionality.

    return Container(
      padding: EdgeInsets.only(bottom: 5.0),
      height: 130,
      width: MediaQuery.of(context).size.width,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 3.0),
            height: 70,
            color: Colors.lightBlueAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Left Side Arrow Functionality Of Blue(P1) Player.

                Container(
                  child: IconButton(
                    onPressed: () {
                      // False Indicates Blue Player (P1).
                      handleLeftSideArrow(false);
                    },
                    icon: Icon(Icons.arrow_back),
                    //color: Colors.cyan,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.cyan,
                  ),
                ),
                SizedBox(
                  width: 25.0,
                ),
                GestureDetector(
                  onTap: () {
                    if (playerTurn == false) {
                      setDiskToPosition(playerTurn);
                    } else {
                      showToast("Not Your Turn");
                    }
                  },
                  child: Container(
                    //alignment: FractionalOffset.center,
                    width: 75,
                    height: 75,
                    child: Image.asset("assets/bplayer.png"),
                    decoration: BoxDecoration(shape: BoxShape.circle),
                  ),
                ),
                SizedBox(
                  width: 25.0,
                ),

                // Right Side Arrow Functionality Of Blue(P1) Player.

                Container(
                  //width: 60,
                  //height: 60,
                  child: IconButton(
                    onPressed: () {
                      handleRightSideArrow(false);
                    },
                    icon: Icon(Icons.arrow_forward),
                    //color: Colors.cyan,
                  ),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.cyan),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(3.0),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1.3,
                  mainAxisSpacing: 15.0),
              itemBuilder: (context, index) {
                return Container(
                  width: 20,
                  height: 20,

                  //child: Center(child: Text(index.toString())),
                  child: player1Arrow[index] == true
                      ? Icon(Icons.arrow_downward)
                      : Container(),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: player1Arrow[index] == true
                          ? Colors.redAccent
                          : Colors.pinkAccent),
                );
              },
              shrinkWrap: true,
              itemCount: 7,
            ),
          ),
        ],
      ),
      //child: Image.asset(""),
    );
  }

  getGameGridBoard() {
    // Game Grid Board.

    return Container(
      padding: EdgeInsets.all(5.0),
      alignment: Alignment.center,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, childAspectRatio: 1.5, mainAxisSpacing: 15.0),
        itemBuilder: (context, index) {
          return Container(
            width: 60,
            height: 60,
            child: Center(
              child: allPlayerDiskArray.elementAt(index) == ""
                  ? null
                  : Image.asset(allPlayerDiskArray[index] == "true"
                      ? "assets/gdisk.png"
                      : "assets/bdisk.png"),
            ),
            //child: Center(child: Text(index.toString())),
            //child: Icon(CustomIcons.option, size: 20,),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Color(0xFFe0f2f1)),
          );
        },
        shrinkWrap: true,
        itemCount: totalGrids,
      ),
    );
  }

  getPlayer2Widgets() {
    // Player 2 Functionality.

    return Container(
      //alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(top: 5.0),

      height: 130,
      width: MediaQuery.of(context).size.width,
      //color: Colors.pink,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(3.0),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1.3,
                  mainAxisSpacing: 15.0),
              itemBuilder: (context, index) {
                return Container(
                  width: 20,
                  height: 20,

                  //child: Center(child: Text(index.toString())),
                  child: player2Arrow[index] == true
                      ? Icon(Icons.arrow_upward)
                      : Container(),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: player2Arrow[index] == true
                          ? Colors.redAccent
                          : Colors.pinkAccent),
                );
              },
              shrinkWrap: true,
              itemCount: 7,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(top: 3.0),
            height: 70,
            color: Colors.lightGreenAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Left Side Arrow Functionality Of Green(P2) Player.

                Container(
                  child: IconButton(
                    onPressed: () {
                      // True Indicates Green Player (P2).
                      handleLeftSideArrow(true);
                    },
                    icon: Icon(Icons.arrow_back),
                    //color: Colors.cyan,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.cyan,
                  ),
                ),
                SizedBox(
                  width: 25.0,
                ),
                GestureDetector(
                  onTap: () {
                    if (playerTurn == true) {
                      setDiskToPosition(playerTurn);
                    } else {
                      showToast("Not Your Turn");
                    }
                  },
                  child: Container(
                    width: 75,
                    height: 75,
                    child: Image.asset("assets/gplayer.png"),
                    decoration: BoxDecoration(shape: BoxShape.circle),
                  ),
                ),
                SizedBox(
                  width: 25.0,
                ),

                // Right Side Arrow Functionality Of Green(P2) Player.

                Container(
                  //width: 60,
                  //height: 60,
                  child: IconButton(
                    onPressed: () {
                      handleRightSideArrow(true);
                    },
                    icon: Icon(Icons.arrow_forward),
                    //color: Colors.cyan,
                  ),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.cyan),
                ),
              ],
            ),
          )
        ],
      ),
      //child: Image.asset(""),
    );
  }

  void handleLeftSideArrow(bool playerTurn) {
    if (!playerTurn) {
      int tempIndex = player1Arrow.indexOf(true);
      int mainIndexToSet = tempIndex == 0 ? 6 : tempIndex - 1;

      setState(() {
        player1Arrow[tempIndex] = false;
        player1Arrow[mainIndexToSet] = true;
      });
    } else {
      int tempIndex = player2Arrow.indexOf(true);
      int mainIndexToSet = tempIndex == 0 ? 6 : tempIndex - 1;
      setState(() {
        player2Arrow[tempIndex] = false;
        player2Arrow[mainIndexToSet] = true;
      });
    }
  }

  void handleRightSideArrow(bool playerTurn) {
    if (!playerTurn) {
      int tempIndex = player1Arrow.indexOf(true);
      int mainIndexToSet = tempIndex == 6 ? 0 : tempIndex + 1;

      setState(() {
        player1Arrow[tempIndex] = false;
        player1Arrow[mainIndexToSet] = true;
      });
    } else {
      int tempIndex = player2Arrow.indexOf(true);
      int mainIndexToSet = tempIndex == 6 ? 0 : tempIndex + 1;
      setState(() {
        player2Arrow[tempIndex] = false;
        player2Arrow[mainIndexToSet] = true;
      });
    }
  }

  void setDiskToPosition(bool playerTurn) {
    bool isBreak = false;

    // Green Player (G2)
    if (playerTurn) {
      int arrowIndex = player2Arrow.indexOf(true);
      for (int k = arrowIndex; k < totalGrids; k = k + 7) {
        if (allPlayerDiskArray[k] == "") {
          setState(() {
            allPlayerDiskArray[k] = "true";
          });
          isBreak = true;
          break;
        }
        print(" : " + allPlayerDiskArray[k]);
      }
    }
    // Blue Player (G1)
    else {
      int arrowIndex = player1Arrow.indexOf(true);

      for (int k = arrowIndex; k < totalGrids; k = k + 7) {
        if (allPlayerDiskArray[k] == "") {
          setState(() {
            allPlayerDiskArray[k] = "false";
          });
          isBreak = true;
          break;
        }
        print(" : " + allPlayerDiskArray[k]);
      }
    }
    if (isBreak) {
      this.playerTurn = !playerTurn;
    } else {
      showToast("Choose Another Row To Continue");
    }
  }
}
