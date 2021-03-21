import 'package:flutter/material.dart';
import 'package:app/conexao/Endpoints.dart';
import 'package:app/noticia/NoticiaModel.dart';
import 'package:app/noticia/NoticiaListModel.dart';

/// Notícia user interface
/// Lista as informações das notícias
class NoticiaUI extends StatefulWidget {
  _NoticiaUI createState() => _NoticiaUI();
}

class _NoticiaUI extends State {
  Future<NoticiaListModel> noticiaListFuture;

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<NoticiaListModel>(
        future: noticiaListFuture,
        // ignore: missing_return
        builder: (context, snapshot) {
          // Identifica em que ponto da conexão estamos
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            {
              return loadingView();
            }
            case ConnectionState.active:
            {
              break;
            }
            case ConnectionState.done:
            {
              if (snapshot.hasData) {
                if (snapshot.data.listaNoticias != null) {
                  if (snapshot.data.listaNoticias.length > 0) {
                    // preenche a lista
                    return ListView.builder(
                        itemCount: snapshot.data.listaNoticias.length,
                        itemBuilder: (context, index) {
                          return generateColum(
                              snapshot.data.listaNoticias[index]);
                        });
                  } else {
                    // Em caso de retorno de lista vazia
                    return noDataView("1 No data found");
                  }
                } else {
                  // Apresenta erro se a lista ou os dados são nulos
                  return noDataView("2 No data found");
                }
              } else if (snapshot.hasError) {
                // Apresenta mensagem se teve algum erro
                print(snapshot.error);
                return noDataView("1 Something went wrong: " +
                    snapshot.error.toString());
              } else {
                return noDataView("2 Something went wrong");
              }
              // ignore: dead_code
              break;
            }
            case ConnectionState.none:
            {
              break;
            }
          }
        }
      ),
    );
  }

  void initState() {
    // Verificamos a conexão com a internet
    isConnected().then((internet) {
      if (internet) {
        // define o estado enquanto carrega as informações da API
        setState(() {
          // chama a API para apresentar os dados
          noticiaListFuture = getNoticiaListData();
        });
      }
    });
    super.initState();
  }

  // retorna a cor do Container, que pode ser verde ou vermelho
  Color setBackgroundColor(fakeNews) {
    if (fakeNews == true) {
      return Colors.red;
    }
    return Colors.green;
  }

  // retorna uma string do tipo de noticia
  String news(fakeNews) {
    if (fakeNews == true) {
      return 'FAKE\nNEWS';
    }
    return 'TRUE\nNEWS';
  }

  Widget generateColum(NoticiaModel item) => Card(
    child: Container(
      // decoration: BoxDecoration(color: setBackgroundColor(item.fakeNews)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: setBackgroundColor(item.fakeNews),
        boxShadow: [
          BoxShadow(color: Colors.teal, spreadRadius: 1),
        ],
      ),
      child: ListTile(
        leading: Text(
          news(item.fakeNews),
          style: TextStyle(fontSize: 13)
        ),
        title: Text(
          item.id.toString() + ' - ' + item.title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          item.text + '\n\nEnviado por: ' + item.userEmail
        ),
      ),
    ),
  );
}
