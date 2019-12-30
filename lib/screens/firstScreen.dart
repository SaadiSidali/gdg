import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdg_app/providers/auth.dart';

import 'package:shimmer/shimmer.dart';

import 'package:provider/provider.dart';

enum States { Name, Email, Password }

class FirstScreen extends StatefulWidget {
  static const routeName = '/first';

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with SingleTickerProviderStateMixin {
  Map<String, String> _userData = {
    'Name': '',
    'Email': '',
    'Password': '',
  };
  States _state = States.Name;
  AnimationController _controller;
  Animation<double> _opacityAnimator;
  final _textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _opacityAnimator = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(curve: Curves.easeIn, parent: _controller),
    );
  }

  void _forwardState() {
    if (_state == States.Name) {
      setState(() {
        _state = States.Email;
      });
    } else if (_state == States.Email) {
      setState(() {
        _state = States.Password;
      });
    }
  }

  void _backwardState() {
    if (_state == States.Password) {
      setState(() {
        _state = States.Email;
      });
    } else if (_state == States.Email) {
      setState(() {
        _state = States.Name;
        //it's 4 am ... am on my 5th cup of coffee ... i can smell colors.
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    _controller.forward();
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/images/image.jpg'),
                image: NetworkImage('https://i.redd.it/cx37grsl6i741.jpg'),
              ),
              height: double.infinity,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FadeTransition(
                    opacity: _opacityAnimator,
                    child: Text(
                      _state == States.Name
                          ? 'Hello,what\'s your name?'
                          : _state == States.Email
                              ? 'What\'s your email ${_userData['Name']}?'
                              : _state == States.Password
                                  ? 'Type your password, ${_userData['Name']}.'
                                  : '... HOW THE FUCK YOU GOT HERE ?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 60,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: Colors.black, blurRadius: 12)
                          ]),
                    ),
                  ),
                  TextField(
                    style: TextStyle(
                        fontFamily: 'Segoe',
                        fontSize: 20,
                        color: Colors.white,
                        shadows: [Shadow(color: Colors.black, blurRadius: 3)]),
                    textAlign: TextAlign.center,
                    controller: _textController,
                    decoration: InputDecoration(
                        hoverColor: Colors.white,
                        hintStyle: TextStyle(
                            fontFamily: 'Segoe',
                            fontSize: 20,
                            color: Colors.white70,
                            shadows: [
                              Shadow(color: Colors.black, blurRadius: 3)
                            ]),
                        hintText: _state == States.Name
                            ? 'Name'
                            : _state == States.Email
                                ? 'Email'
                                : _state == States.Password
                                    ? 'Password'
                                    : 'again ... HOW THE FUCK YOU GOT HERE ?',
                        focusColor: Colors.white),
                    obscureText: _state == States.Password,
                    onChanged: (value) {
                      if (_state == States.Password)
                        _userData['Password'] = value;
                    },
                    onSubmitted: (value) async {
                      if (_state == States.Name)
                        _userData['Name'] = value;
                      else if (_state == States.Email)
                        _userData['Email'] = value;
                      else if (_state == States.Password) {
                        _userData['Password'] = value;

                        await Provider.of<Auth>(context).signup(
                            _userData['Email'],
                            _userData['Password'],
                            _userData['Name']);
                      }
                      _forwardState();
                      setState(() {
                        _controller.forward();
                      });
                      print(_userData);
                      _textController.text = '';
                    },
                  ),
                  _state == States.Password
                      ? OutlineButton(
                          color: Colors.blueAccent,
                          padding: EdgeInsets.all(16),
                          onPressed: () async {
                            await Provider.of<Auth>(context).signup(
                                _userData['Email'],
                                _userData['Password'],
                                _userData['Name']);
                          },
                          child: Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: Colors.blueAccent,
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                  fontFamily: 'Segoe',
                                  fontSize: 20,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(color: Colors.black, blurRadius: 3)
                                  ]),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
