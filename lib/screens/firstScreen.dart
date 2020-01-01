import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdg_app/providers/auth.dart';

import 'package:shimmer/shimmer.dart';

import 'package:provider/provider.dart';

enum States { Name, Email, Password }
enum AuthMode { Signup, Login }

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
  AuthMode _authMode = AuthMode.Signup;
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
    _controller.reset();
    _controller.forward();
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

  onSubmit([value]) async {
    if (_state == States.Name)
      _userData['Name'] = value;
    else if (_state == States.Email)
      _userData['Email'] = value;
    else if (_state == States.Password) {
      _userData['Password'] = value;
      if (_authMode == AuthMode.Signup) {
        await Provider.of<Auth>(context).signup(
            _userData['Email'], _userData['Password'], _userData['Name']);
      } else {
        await Provider.of<Auth>(context).signin(
            _userData['Email'], _userData['Password'], _userData['Name']);
      }
    }
    _forwardState();
    setState(() {
      _controller.forward();
    });
    print(_userData);
    _textController.text = '';
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    _controller.forward();
    return Scaffold(
      backgroundColor: Colors.black,
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
                  _state != States.Name
                      ? IconButton(
                        padding: EdgeInsets.all(20),
                          color: Colors.white,
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: _backwardState,
                        )
                      : Container(),
                  FadeTransition(
                    opacity: _opacityAnimator,
                    child: Text(
                      (_state == States.Name
                          ? 'Hello,what\'s your name?'
                          : _state == States.Email
                              ? 'What\'s your email, ${_userData['Name']}?'
                              : _state == States.Password
                                  ? 'Type your password, ${_userData['Name']}.'
                                  : '... HOW THE FUCK YOU GOT HERE ?'),
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
                  TextFormField(
                    validator: (value) {
                      if (_state == States.Name && value.isEmpty) {
                        return 'Please enter a name.';
                      } else if (_state == States.Email &&
                          (value.isEmpty || value.contains('@'))) {
                        return 'Please enter a valid email';
                      } else if (_state == States.Password &&
                          value.length < 8) {
                        return 'Enter a valid password';
                      }
                    },
                    keyboardType: _state == States.Email
                        ? TextInputType.emailAddress
                        : _state == States.Password
                            ? TextInputType.visiblePassword
                            : TextInputType.text,
                    style: TextStyle(
                        fontFamily: 'Segoe',
                        fontSize: 20,
                        color: Colors.white,
                        shadows: [Shadow(color: Colors.black, blurRadius: 3)]),
                    textAlign: TextAlign.center,
                    controller: _textController,
                    decoration: InputDecoration(
                        border: InputBorder.none.copyWith(
                            borderSide: BorderSide(
                                color: Colors.white54,
                                width: 2,
                                style: BorderStyle.solid)),
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
                    onFieldSubmitted: (value) async {
                      onSubmit(value);
                    },
                  ),
                  _state == States.Password
                      ? OutlineButton(
                          color: Colors.blueAccent,
                          padding: EdgeInsets.all(16),
                          onPressed: () => onSubmit(),
                          child: Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: Colors.blueAccent,
                            child: Text(
                              _authMode == AuthMode.Signup
                                  ? 'Sign up'
                                  : 'Login',
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
                      : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _authMode == AuthMode.Signup
                            ? 'Already have an account? | '
                            : 'No Account? , No Problem. | ',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            fontSize: 20,
                            color: Colors.white,
                            shadows: [
                              Shadow(color: Colors.black, blurRadius: 3)
                            ]),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _authMode == AuthMode.Signup
                                ? _authMode = AuthMode.Login
                                : _authMode = AuthMode.Signup;
                          });
                        },
                        child: Shimmer.fromColors(
                          baseColor: Colors.white,
                          highlightColor: Colors.blueAccent,
                          child: Text(
                            _authMode == AuthMode.Signup ? 'Login' : 'Signup',
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
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
