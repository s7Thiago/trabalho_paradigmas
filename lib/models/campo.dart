import './explosao_exception.dart';

/// Representa os dados de um campo:
/// - Se o campo está aberto
/// - Se o campo está fechado
/// - Se o campo está marcado
/// - Se o campo está desmarcado
/// - Se o campo tem mina
/// - Se o campo tem mina, gera uma exceção
class Campo {
  /// Representa a grid de linhas e colunas do game
  final int linha;
  final int coluna;
  final List<Campo> vizinhos = [];

  bool _aberto = false;
  bool _marcado = false;
  bool _minado = false;
  bool _explodido = false;

  Campo({required this.linha, required this.coluna});

  /// Adiciona vizinhos para o campo
  void adicionarVizinho(Campo vizinho) {
    final deltaLinha = (linha - vizinho.linha).abs();
    final deltaColuna = (coluna - vizinho.coluna).abs();

    // Se for verdadeira, significa que está recebendo o próprio campo como vizinho dele mesmo
    if (deltaLinha == 0 && deltaColuna == 0) return;

    // Se for verdadeira, significa que existe um vizinho verdadeiro, então adiciona na lista
    if (deltaLinha <= 1 && deltaColuna <= 1) vizinhos.add(vizinho);
  }

  void abrir() {
    // Se já estiver aberto, não faz nada
    if (_aberto) return;

    _aberto = true;

    // Se estiver minado, o usuário perde o jogo e uma exceção é gerada
    if (_minado) {
      _explodido = true;
      throw ExplosaoException();
    }

    // Se chegou até aqui, significa que não tem mina, então abre os vizinhos recursivamente
    // Quando chega em uma vizinhança perigosa, para de abrir recursivamente

    if (vizinhancaSegura) vizinhos.forEach((v) => v.abrir());
  }

  /// Abre os campos que estiverem com bomba,será útil para quando o usuário perder o jogo
  void revelarBomba() {
    if (_minado) _aberto = true;
  }

  /// Responsável por colocar uma mina no campo
  void minar() {
    _minado = true;
  }

  // Muda alguns estados do campo para o valor padrão
  void reiniciar() {
    _aberto = false;
    _marcado = false;
    _minado = false;
    _explodido = false;
  }

  // Alterna a marcação do usuário para uma potencial bomba no campo
  void alternarMarcacao() => _marcado = !_marcado;

  /// Responde se o campo está minado
  bool get minado => _minado;

  /// Responde se o campo está explodido
  bool get explodido => _explodido;

  /// Responde se o campo está aberto
  bool get aberto => _aberto;

  /// Responde se o campo está marcado
  bool get marcado => _marcado;

  /// Se o usuário marcou o campo como bomba e ele realmente é uma bomba, o campo está resolvido
  bool get resolvido {
    // se for verdade, o usuário conseguiu resolver este campo
    bool minadoEMarcado = minado && marcado;
    bool _seguroEAberto = !minado && aberto;

    return minadoEMarcado || _seguroEAberto;
  }

  // Verifica se uma vizinhança é perigosa. Se todos os vizinhos não tem uma mina, então a vizinhança é segura
  bool get vizinhancaSegura => vizinhos.every((v) => !v._minado);

  /// Quando o usuário clica num campo para abrir, aparece o número de minas que estão próximas dele
  /// O método contabiliza todos os campos minados na vizinhança de um campo em questão
  int get qtdeMinasNaVizinhanca => vizinhos.where((v) => v.minado).length;
}
