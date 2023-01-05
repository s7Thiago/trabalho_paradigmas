import 'package:campo_minado/models/campo.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Campo', () {
    test('Abrir campo COM explosão', () {
      Campo c = Campo(linha: 0, coluna: 0);
      c.minar();

      // é esperado que o método abrir lance uma exceção
      expect(c.abrir, throwsException);

      // Também poderia ser assim:
      // expect(() => c.abrir, throwsException);
    });

    test('Abrir campo SEM explosão', () {
      Campo c = Campo(linha: 0, coluna: 0);
      c.abrir();

      //  Quando o clique do usuário acionar o método abrir esperado que a propriedade aberto seja true
      expect(c.aberto, isTrue);
    });

    test('Adicionar NÃO vizinho', () {
      Campo c1 = Campo(linha: 0, coluna: 0);
      Campo c2 = Campo(linha: 1, coluna: 3);

      // Tentativa de adicionar c2 como vizinho de c1
      c1.adicionarVizinho(c2);

      // Como o delta de c2 em relação a c1 é maior que 1, não deve ser adicionado como vizinho
      // Então é esperado que a condição isEmpty seja true, indicando que c2 não foi adicionado como vizinho
      expect(c1.vizinhos.isEmpty, isTrue);
    });

    test('Adicionar vizinho', () {
      Campo c1 = Campo(linha: 3, coluna: 3);
      Campo c2 = Campo(linha: 3, coluna: 4);
      Campo c3 = Campo(linha: 2, coluna: 2);
      Campo c4 = Campo(linha: 4, coluna: 4);

      // Tentativa de adicionar c2, c3 3 c4 como vizinhos de c1
      c1.adicionarVizinho(c2);
      c1.adicionarVizinho(c3);
      c1.adicionarVizinho(c4);

      // Como o delta de c2, c3 e c4 em relação a c1 não é maior que 1, todos devem ser adicionados como vizinhos
      // desse modo, é esperado que o tamanho da lista de vizinhos de c1  seja 3 ao passar pelo teste
      expect(c1.vizinhos.length, 3);
    });

    test('Minas na vizinhança', () {
      Campo c1 = Campo(linha: 3, coluna: 3);

      Campo c2 = Campo(linha: 3, coluna: 4);
      c2.minar();

      Campo c3 = Campo(linha: 2, coluna: 2);

      Campo c4 = Campo(linha: 4, coluna: 4);
      c4.minar();

      // Tentativa de adicionar c2, c3 3 c4 como vizinhos de c1
      c1.adicionarVizinho(c2);
      c1.adicionarVizinho(c3);
      c1.adicionarVizinho(c4);

      // Como c2 c3 e c4 são vizinhos válidos de c1, sendo que c2 e c4 estão minados, a tentativa de contabilizar
      // os vizinhos minados deve retornar 2
      expect(c1.qtdeMinasNaVizinhanca, 2);
    });
  });
}
