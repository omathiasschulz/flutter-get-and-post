import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:app/noticia/NoticiaUI.dart';
import 'package:app/noticia/NoticiaPost.dart';

void main() => runApp(MyApp());

// widget principal da aplicação
class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

// splash screen
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SplashScreen(
          seconds: 4,
          gradientBackground: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.teal[100],
              Colors.teal[900],
            ],
          ),
          navigateAfterSeconds: Start(),
          loaderColor: Colors.transparent,
        ),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('imagens/logo.png'),
            ),
          ),
        ),
      ],
    );
  }
}

class Start extends StatefulWidget {
  Start({Key key}) : super(key: key);
  _Start createState() => _Start();
}

class _Start extends State {
  PageController _controller = PageController(
    initialPage: 0,
  );

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Detecção de Fake News')),
        body: PageView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          controller: _controller,
          children: [NoticiaUI(), NoticiaPost()],
        ),
      ),
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
    );
  }
}
