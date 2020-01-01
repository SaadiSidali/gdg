import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdg_app/providers/auth.dart';
import 'package:gdg_app/providers/quoteProvider.dart';
import 'package:gdg_app/screens/firstScreen.dart';
import 'package:gdg_app/screens/splash.dart';
import 'package:gdg_app/screens/theTasksScreen.dart';
import 'package:provider/provider.dart';
import './screens/secondScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MultiProvider(
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          routes: {
            TasksScreen.routeName: (ctx) => TasksScreen(),
          },
          debugShowCheckedModeBanner: false,
          home: auth.isAuth
              ? SecondScreen()
              : FutureBuilder(
                  future: Future.delayed(
                    Duration(seconds: 3),
                  ).then((onValue) {
                    auth.tryAutoLogin();
                  }),
                  builder: (ctx, autoResultSnapshot) =>
                      autoResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : FirstScreen(),
                ),
        ),
      ),
      providers: [
        ChangeNotifierProvider.value(
          value: QuoteProvider(),
        ),
        ChangeNotifierProvider.value(
          value: Auth(),
        )
      ],
    );
  }
}
