import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'dart:math';

void main() => runApp(MyApp());

// style dos titulos
const optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
// número de notícias verificadas
var numNoticias = 5789;
var numNoticiasTrue = 3567;
var numNoticiasFalse = 2222;

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
  // variavel que controla a página atual
  var _currentPage = 0;
  var _pages = [
    PageVerificacao(),
    PageInformacoes(),
    PageSobre(),
  ];

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Detecção de Fake News')),
        body: Center(child: _pages.elementAt(_currentPage)),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.check_box_outlined),
              label: 'Verificação',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assessment_outlined),
              label: 'Informações',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_ind_rounded),
              label: 'Sobre',
            ),
          ],
          currentIndex: _currentPage,
          fixedColor: Colors.teal,
          onTap: (int inIndex) {
            setState(() {
              _currentPage = inIndex;
            });
          }
        ),
      ),
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
    );
  }
}

// objeto Noticia
class Noticia {
  String titulo = '';
  String texto = '';
  String email = '';
}

// pagina de verificação
// ignore: must_be_immutable
class PageVerificacao extends StatelessWidget {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Noticia _noticia = new Noticia();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(right: 20, left: 20, top: 50),
        child: Form(
          key: this._formKey,
          child: Column(
            children: [
              // verificacao
              Text('Verificação', style: optionStyle),
              // campo titulo
              TextFormField(
                keyboardType: TextInputType.text,
                validator: (String value) {
                  if (value.length == 0) {
                    return 'O preenchimento do campo de título é obrigatório';
                  }
                  return null;
                },
                onSaved: (String value) {
                  this._noticia.titulo = value;
                },
                decoration: InputDecoration(
                    hintText: 'Título da notícia',
                    labelText: 'Título',
                ),
              ),
              // campo texto
              TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 6,
                validator: (String value) {
                  if (value.length == 0) {
                    return 'O preenchimento do campo de texto é obrigatório';
                  }
                  return null;
                },
                onSaved: (String value) {
                  this._noticia.texto = value;
                },
                decoration: InputDecoration(
                    hintText: 'Texto da notícia',
                    labelText: 'Texto',
                ),
              ),
              // campo email
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (String value) {
                  if (value.length == 0) {
                    return 'O preenchimento do campo de e-mail é obrigatório';
                  }
                  return null;
                },
                onSaved: (String value) {
                  this._noticia.email = value;
                },
                decoration: InputDecoration(
                    hintText: 'nome@servidor',
                    labelText: 'E-mail',
                ),
              ),
              // botão validar
              Padding(
                padding: EdgeInsets.only(top: 16, left: 250),
                child: ElevatedButton(
                  onPressed: () {
                    // valida se os campos foram preenchidos corretamente
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      // reseta o formulário
                      _formKey.currentState.reset();
                      var mensagem = validaNoticia(_noticia);
                      // apresenta o alerta se a notícia é fake ou não
                      return showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Verificação'),
                          content: Text(mensagem),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Text('Ok'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Text('Validar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// método responsável por validar se a notícia é fake ou não
validaNoticia(var _noticia) {
  // apresenta as informações da notícia
  print('=> Informações da notícia: ');
  print('Título: ${_noticia.titulo}');
  print('Texto: ${_noticia.texto}');
  print('E-mail: ${_noticia.email}');

  // gera um número randômico que pode ser 0 ou 1
  var rng = new Random();
  var typeNews = rng.nextInt(2);
  print('Tipo da notícia: ' + typeNews.toString());
  print('[1 - Fake news | 0 - True news]');
  numNoticias += 1;

  // se o número for 1 é uma fake news
  // se o número for 0 é uma true news
  if (typeNews == 1) {
    numNoticiasFalse += 1;
    return 'Notícia identificada como uma falsa notícia! ';
  }
  numNoticiasTrue += 1;
  return 'Notícia identificada como uma verdadeira notícia! ';
}

// pagina de informações sobre as notícias
// ignore: must_be_immutable
class PageInformacoes extends StatelessWidget {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(right: 20, left: 20, top: 50),
        child: Form(
          key: this._formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text('Informações', style: optionStyle),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column (children: [
                    Text(
                      '\nNúmero de notícias verificadas: ' + numNoticias.toString()
                      + '\n\nNúmero de notícias verdadeiras: ' + numNoticiasTrue.toString()
                      + '\n\nNúmero de notícias falsas: ' + numNoticiasFalse.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ]),
                ),
              ),
              // adiciona os cards
              new Card(
                child: new Container(
                  padding: new EdgeInsets.only(
                    left: 50.0,
                    right: 50.0,
                    top: 40,
                    bottom: 20,
                  ),
                  child: new Column(
                    children: <Widget>[
                      new Text('Hello World'),
                      new Text('How are you?')
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// pagina sobre as informações do aplicativo
// ignore: must_be_immutable
class PageSobre extends StatelessWidget {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(right: 20, left: 20, top: 50),
        child: Form(
          key: this._formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text('Sobre', style: optionStyle),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Desenvolvido por: \n\t\t\t\t\tMathias Artur Schulz',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Image.asset(
                'imagens/logo.png',
                width: 150,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Em parceira com: \n\t\t\t\t\tGoverno Federal',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Image.asset(
                'imagens/governo.jpg',
                width: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
