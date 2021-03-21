import 'NoticiaModel.dart';

class NoticiaListModel {
  List<NoticiaModel> lista;

  NoticiaListModel({this.lista});

  NoticiaListModel.fromJson(List<dynamic> parsedJson) {
    // ignore: deprecated_member_use
    lista = new List<NoticiaModel>();
    parsedJson.forEach((v) {
      lista.add(NoticiaModel.fromJson(v));
    });
  }
}
