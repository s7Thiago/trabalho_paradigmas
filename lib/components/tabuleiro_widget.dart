import 'package:campo_minado/components/campo_widget.dart';
import 'package:campo_minado/models/campo.dart';
import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter/material.dart';

class TabuleiroWidget extends StatelessWidget {
  final Tabuleiro tabuleiro;
  final void Function(Campo) onOpen;
  final void Function(Campo) switchMarcacao;

  const TabuleiroWidget({
    Key? key,
    required this.tabuleiro,
    required this.onOpen,
    required this.switchMarcacao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: tabuleiro.colunas,
        children: tabuleiro.campos
            .map((c) => CampoWidget(
                  campo: c,
                  onOpen: onOpen,
                  switchMarcacao: switchMarcacao,
                ))
            .toList(),
      ),
    );
  }
}
