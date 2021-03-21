import 'package:flutter/material.dart';
import 'package:app/conexao/Endpoints.dart';
import 'package:app/noticia/NoticiaModel.dart';
import 'dart:math';

// style dos titulos
const optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

/// Post notícia
class NoticiaPost extends StatefulWidget {
  _PageVerificacao createState() => _PageVerificacao();
}

// pagina de verificação
class _PageVerificacao extends State {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  NoticiaModel _noticia = new NoticiaModel();

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
                  this._noticia.title = value;
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
                  this._noticia.text = value;
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
                  this._noticia.userEmail = value;
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

                      // chama a rotina para salvar a noticia na API
                      callAPI(_noticia);

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
validaNoticia(NoticiaModel _noticia) {
  // apresenta as informações da notícia
  print('=> Informações da notícia: ');
  print('Título: ${_noticia.title}');
  print('Texto: ${_noticia.text}');
  print('E-mail: ${_noticia.userEmail}');

  // gera um número randômico que pode ser 0 ou 1
  var rng = new Random();
  var typeNews = rng.nextInt(2);
  print('Tipo da notícia: ' + typeNews.toString());
  print('[1 - Fake news | 0 - True news]');

  // se o número for 1 é uma fake news
  // se o número for 0 é uma true news
  if (typeNews == 1) {
    return 'Notícia identificada como uma falsa notícia! ';
  }
  return 'Notícia identificada como uma verdadeira notícia! ';
}
