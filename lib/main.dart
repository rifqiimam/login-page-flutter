import 'package:flutter/material.dart';
import 'package:tokopedia/page/splash_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tokopedia/authentication/authentication.dart';
import 'package:tokopedia/page/home_page.dart';
import 'package:tokopedia/page/login_page.dart';
import 'package:tokopedia/theme/theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges,
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'tokopedia',
          //theme: ThemeData(
          //primarySwatch: blueColor,
          //visualDensity: VisualDensity.adaptivePlatformDensity,
          //),
          home: splashPage(),
        ));
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return homePage();
    }
    return loginPage();
  }
}

//class MyApp extends StatelessWidget {
// This widget is the root of your application.
//@override
//Widget build(BuildContext context) {
//return MaterialApp(
//title: 'tokopedia',
//debugShowCheckedModeBanner: false,
//home: splashPage(),
//);
//}
//}
