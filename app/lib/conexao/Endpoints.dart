import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:app/noticia/NoticiaModel.dart';
import 'package:app/noticia/NoticiaListModel.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

// variavel utilizada como auxilio se será buscado todas as notícias ou apenas uma
const String _noValueGiven = "";

// API url
String noticiaGet  = 'http://10.0.2.2/list';
String noticiaPost = 'http://10.0.2.2/insert';

// Utilização do package http para carregar os dados da API
Future<NoticiaListModel> getNoticiaListData([String id = _noValueGiven]) async {
  // delay de 2 segundos para simular o peso da aplicação ao buscar as notícias
  await Future.delayed(const Duration(seconds: 2), () {});

  var response;
  if (identical(id, _noValueGiven)) {
    response = await http.get(
      noticiaGet,
    );
  } else {
    response = await http.get(
      noticiaGet + '?id=' + id,
    );
  }
  // json.decode usado para decodificar o response.body(string to map)
  return NoticiaListModel.fromJson(json.decode(response.body));
}

Future<http.Response> createPost(NoticiaModel noticia, String url) async {
  print('noticia v1: ' + jsonEncode(noticia));
  final response = await http.post(noticiaPost,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: ''
      },
      body: jsonEncode(noticia));
  print('noticia v2: ' + jsonEncode(noticia));
  return response;
}

NoticiaListModel postFromJson(String str) {
  final jsonData = json.decode(str);
  return NoticiaListModel.fromJson(jsonData);
}

Future<NoticiaListModel> callAPI(NoticiaModel noticia) async {
  print('Notícia para gravar: ');
  print(noticia.toJson());

  createPost(noticia, noticiaPost).then((response) {
    print(response.body);
    if (response.statusCode == 200) {
      return NoticiaListModel.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }).catchError((error) {
    print('errors : $error');
    // ignore: return_of_invalid_type_from_catch_error
    return error;
  });
  return null;
}

// Verifica se há conexão com a internet
Future<bool> isConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

Widget loadingView() {
  return Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.red,
    ),
  );
}

Widget noDataView(String msg) => Center(
  child: Text(
    msg,
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
  ),
);
