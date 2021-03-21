import 'NoticiaModel.dart';

class NoticiaListModel {
  List<NoticiaModel> listaNoticias;

  NoticiaListModel({this.listaNoticias});

  NoticiaListModel.fromJson(List<dynamic> parsedJson) {
    // ignore: deprecated_member_use
    listaNoticias = new List<NoticiaModel>();
    parsedJson.forEach((v) {
      listaNoticias.add(NoticiaModel.fromJson(v));
    });
  }
}
