import 'package:flutter/material.dart';
import 'package:time_clock_flutter/database/dao/marcacao_dao.dart';
import 'package:time_clock_flutter/models/marcacao.dart';

class ListaTodasMarcacoes extends StatelessWidget {
  final MarcacaoDao _marcacaoDao = MarcacaoDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todas as Marcações'),
      ),
      body: FutureBuilder<List<Marcacao>>(
        initialData: List(),
        future: _marcacaoDao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Carregando'),
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Marcacao> marcacaoes = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Marcacao marcacao = marcacaoes[index];
                  return _MarcacaoItem(marcacao);
                },
                itemCount: marcacaoes.length,
              );
              break;
          }
          return Text('Erro');
        },
      ),
    );
  }
}

class _MarcacaoItem extends StatelessWidget {
  final Marcacao marcacao;

  _MarcacaoItem(this.marcacao);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          marcacao.data,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          marcacao.hora,
          style: TextStyle(fontSize: 16.0),
        ),
        trailing: Icon(Icons.access_time),
      ),
    );
  }
}
