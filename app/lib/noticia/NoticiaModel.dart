
/// Classe que representa a entidade notícia
class NoticiaModel {
  int id;
  String title;
  String text;
  String userEmail;
  bool fakeNews;

  NoticiaModel({this.id, this.title, this.text, this.userEmail, this.fakeNews});

  NoticiaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    text = json['text'];
    userEmail = json['userEmail'];
    fakeNews = json['fakeNews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['text'] = this.text;
    data['userEmail'] = this.userEmail;
    data['fakeNews'] = this.fakeNews;
    return data;
  }
}
