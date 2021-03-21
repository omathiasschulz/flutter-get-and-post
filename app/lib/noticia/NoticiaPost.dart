import 'package:flutter/material.dart';
import 'package:app/conexao/Endpoints.dart';
import 'package:app/noticia/NoticiaModel.dart';

/// Post notícia
class PostNoticia extends StatefulWidget {
  _PostNoticia createState() => _PostNoticia();
}

class _PostNoticia extends State {
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
