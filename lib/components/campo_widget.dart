import 'package:campo_minado/models/campo.dart';
import 'package:flutter/material.dart';

class CampoWidget extends StatelessWidget {
  // Encapsula todas as propriedades e comportamentos de um campo
  final Campo campo;
  final void Function(Campo) onOpen;
  final void Function(Campo) switchMarcacao;

  const CampoWidget({
    Key? key,
    required this.campo,
    required this.onOpen,
    required this.switchMarcacao,
  }) : super(key: key);

  Widget _getImage() {
    int qtdeMinas = campo.qtdeMinasNaVizinhanca;
    if (campo.aberto && campo.minado && campo.explodido) {
      return Image.asset('assets/images/bomba_0.jpeg');
    }
    if (campo.aberto && campo.minado) {
      return Image.asset('assets/images/bomba_1.jpeg');
    } else if (campo.aberto) {
      return Image.asset('assets/images/aberto_$qtdeMinas.jpeg');
    } else if (campo.marcado) {
      return Image.asset('assets/images/bandeira.jpeg');
    } else {
      return Image.asset('assets/images/fechado.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(campo),
      onLongPress: () => switchMarcacao(campo),
      child: _getImage(),
    );
  }
}
