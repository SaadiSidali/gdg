import 'package:flutter/material.dart';
import 'package:loading/indicator.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import '../helpers/task_helper.dart';
import 'package:loading/loading.dart';

class TodayFocus extends StatefulWidget {
  @override
  TtodayFocusState createState() => TtodayFocusState();
}

class TtodayFocusState extends State<TodayFocus> {
  var _stringValue = '';

  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      child: Column(
        children: <Widget>[
          TextField(
            onSubmitted: (value) {
              _stringValue = value;
              _controller.text = '';
              FocusScope.of(context).requestFocus(FocusNode());
            },
            scrollPadding: EdgeInsets.all(8),
            decoration: InputDecoration(
                hintStyle: TextStyle(
                    fontFamily: 'Segoe',
                    fontSize: 20,
                    color: Colors.white70,
                    shadows: [Shadow(color: Colors.black, blurRadius: 3)]),
                hintText: 'What\'s your main focus for today',
                focusColor: Colors.white),
            controller: _controller,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Segoe',
                fontSize: 20,
                color: Colors.white,
                shadows: [Shadow(color: Colors.black, blurRadius: 3)]),
          ),
          DoneTasks(),
        ],
      ),
    );
  }
}

class DoneTasks extends StatefulWidget {
  @override
  _DoneTasksState createState() => _DoneTasksState();
}

class _DoneTasksState extends State<DoneTasks> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TaskHelper.getDoneTasks(),
      builder: (ctx, snap) {
        final data = (snap.data as List<String>);
        if (snap.connectionState == ConnectionState.waiting)
          return Container(
            child: Loading(
              indicator: BallPulseIndicator(),
            ),
          );
        else
          snap == null
              ? Container()
              : ListView.builder(
                  itemCount: snap.data.length,
                  itemBuilder: (ctx, i) => Text(
                    data[i],
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontFamily: 'Segoe',
                        fontSize: 20,
                        color: Colors.white,
                        shadows: [Shadow(color: Colors.black, blurRadius: 3)]),
                  ),
                );
      },
    );
  }
}
