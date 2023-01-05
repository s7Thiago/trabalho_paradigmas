import 'dart:math';

import 'package:campo_minado/models/campo.dart';

class Tabuleiro {
  final int linhas;
  final int colunas;
  final int qtdeBombas;

  final List<Campo> _campos = [];

  Tabuleiro({
    required this.linhas,
    required this.colunas,
    required this.qtdeBombas,
  }) {
    _criarCampos();
    _relacionarVizinhos();
    _sortearMinas();
  }

  // Faz um reset em cada um dos campos
  void reiniciar() {
    _campos.forEach((c) => c.reiniciar());
    _sortearMinas();
  }

  // Mostra todas as bombas no tabuleiro
  void revelarBombas() {
    _campos.forEach((c) => c.revelarBomba());
  }

  // Usa a quantidade de linhas e colunas para criar os campos e atribuir as posições a cada um
  void _criarCampos() {
    for (var l = 0; l < linhas; l++) {
      for (var c = 0; c < colunas; c++) {
        _campos.add(Campo(linha: l, coluna: c));
      }
    }
  }

  /// Para cada campo do tabuleiro, percorre todo o tabuleiro e associa os campos que forem vizinhos
  void _relacionarVizinhos() {
    for (var campo in _campos) {
      for (var vizinho in _campos) {
        campo.adicionarVizinho(vizinho);
      }
    }
  }

  void _sortearMinas() {
    int sorteadas = 0;

    // Garantido que a quantidade de minas no tabuleiro sempre será menor do que a quantidade de campos
    // isso evita que seja criado um laço infinito durante o sorteio das minas
    if (qtdeBombas > linhas * colunas) return;

    while (sorteadas < qtdeBombas) {
      // Escolhendo aleatoriamente um índice da lista de campos para adicionar uma mina
      int index = Random().nextInt(_campos.length - 1);

      // Verifica se o campo escolhido já possui uma mina
      if (!_campos[index].minado) {
        sorteadas++;
        _campos[index].minar();
      }
    }
  }

  // Retorna a lista de campos completa do tabuleiro
  List<Campo> get campos => _campos;

  // Retorna verdadeiro se todos os campos do tabuleiro estiverem resolvidos
  // Retorna falso caso contrário
  bool get resolvido => _campos.every((c) => c.resolvido);
  
}
