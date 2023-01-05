import 'package:campo_minado/components/resultado_widget.dart';
import 'package:campo_minado/components/tabuleiro_widget.dart';
import 'package:campo_minado/models/campo.dart';
import 'package:campo_minado/models/explosao_exception.dart';
import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter/material.dart';

class CampoMinadoApp extends StatefulWidget {
  const CampoMinadoApp({Key? key}) : super(key: key);

  @override
  State<CampoMinadoApp> createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {
  bool? _venceu;
  Tabuleiro? _tabuleiro;

  void _reiniciar() {
    print('reiniciar...');
    setState(() {
      _venceu = null;
      _tabuleiro!.reiniciar();
    });
  }

  void _abrir(Campo c) {
    // Para evitar que o usuário possa continuar jogando após uma explosão, verifica-se se o
    // status de vitória já foi definido na partida.
    if (_venceu != null) return;

    print('(${c.linha}, ${c.coluna}) => abrir...');

    setState(() {
      try {
        c.abrir();

        // Se o tabuleiro estiver resolvido após o usuário abrir um campo, significa que ele venceu
        if (_tabuleiro!.resolvido) {
          _venceu = true;
        }
      } on ExplosaoException {
        // Se o usuário clicou em uma bomba, significa que o jogo acabou, e as bombas podem ser reveladas
        _venceu = false;
        _tabuleiro!.revelarBombas();
      }
    });
  }

  void _alternarMarcacao(Campo c) {
    // Para evitar que o usuário possa continuar jogando após uma explosão, verifica-se se o
    // status de vitória já foi definido na partida.
    if (_venceu != null) return;

    print('(${c.linha}, ${c.coluna}) => alternar marcação...');

    setState(() {
      c.alternarMarcacao();

      // Se o tabuleiro estiver resolvido após o usuário alternar a marcação de um campo, significa que ele venceu
      if (_tabuleiro!.resolvido) {
        _venceu = true;
      }
    });
  }

  Tabuleiro _getTabuleiro(double largura, double altura) {
    if (_tabuleiro == null) {
      int qtdeColunas = 15;
      double tamanhoCampo = largura / qtdeColunas;
      int qtdeLinhas = (altura / tamanhoCampo).floor();

      _tabuleiro = Tabuleiro(
        linhas: qtdeLinhas,
        colunas: qtdeColunas,
        qtdeBombas: 15,
      );
    }
    return _tabuleiro!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultadoWidget(venceu: _venceu, onRestart: _reiniciar),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(builder: (context, constraints) {
            return TabuleiroWidget(
              tabuleiro: _getTabuleiro(
                constraints.maxWidth,
                constraints.maxHeight,
              ),
              onOpen: _abrir,
              switchMarcacao: _alternarMarcacao,
            );
          }),
        ),
      ),
    );
  }
}
