import 'package:flutter/material.dart';
import 'package:app/conexao/Endpoints.dart';
import 'package:app/noticia/NoticiaModel.dart';

/// Post notícia
class NoticiaPost extends StatefulWidget {
  _NoticiaPost createState() => _NoticiaPost();
}

class _NoticiaPost extends State {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  NoticiaModel noticia = new NoticiaModel();

  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: this._formKey,
        child: Column(
          children: [
          ],
        ),
      ),
    );
  }
}
