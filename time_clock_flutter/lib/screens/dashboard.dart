import 'package:flutter/material.dart';
import 'package:time_clock_flutter/database/dao/marcacao_dao.dart';
import 'package:time_clock_flutter/models/marcacao.dart';
import 'package:time_clock_flutter/screens/lista_marcacoes_hoje.dart';
import 'package:time_clock_flutter/screens/lista_todas_marcacoes.dart';
import 'package:toast/toast.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  final MarcacaoDao _marcacaoDao = MarcacaoDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auxiliar de Marcação de Ponto'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 32.0),
            child: RaisedButton(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Fazer Marcação',
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
              onPressed: () {
                _marcacaoDao.save(
                  Marcacao(
                    0,
                    DateTime.now().day.toString() +
                        '/' +
                        DateTime.now().month.toString() +
                        '/' +
                        DateTime.now().year.toString(),
                    DateTime.now().hour.toString() +
                        ':' +
                        DateTime.now().minute.toString() +
                        ':' +
                        DateTime.now().second.toString(),
                  ),
                );
                Toast.show(
                  'Marcação Realizada com Sucesso!',
                  context,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.BOTTOM,
                );
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Dashboard(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 32.0),
            child: Card(
              color: Color(0xff9fa8da),
              child: FutureBuilder(
                future: _marcacaoDao.findAllByToday(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      break;
                    case ConnectionState.waiting:
                      break;
                    case ConnectionState.active:
                      break;
                    case ConnectionState.done:
                      final List<Marcacao> marcacaoes = snapshot.data;
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Total de marcações realizadas hoje: ' +
                                  marcacaoes.length.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
//                          Padding(
//                            padding: const EdgeInsets.only(bottom: 16.0),
//                            child: Text(
//                              'Total de horas registradas hoje: 8',
//                              textAlign: TextAlign.center,
//                              style: TextStyle(fontSize: 16.0),
//                            ),
//                          ),
                        ],
                      );
                      break;
                  }
                  return Text('Erro');
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff1a237e),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            title: Text('Marcações de Hoje'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Todas as Marcações'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (value) {
          if (value == 0) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ListaMarcacoesHoje(),
              ),
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ListaTodasMarcacoes(),
              ),
            );
          }
        },
      ),
    );
  }
}
