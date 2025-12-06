import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:target/modules/listing/presentation/stores/listing_store.dart';

void main() {
  setUpAll(() {
    mobx.mainContext.config = mobx.mainContext.config.clone(
      writePolicy: mobx.ReactiveWritePolicy.never,
    );
  });

  group('ListingStore - Adição de Cards (Informações)', () {
    late ListingStore store;

    setUp(() {
      store = ListingStore();
    });

    tearDown(() {
      // Limpa o store após cada teste
      store.informations.clear();
      store.clearErrorMessage();
    });

    test('deve adicionar uma informação com sucesso', () {
      // Arrange
      const text = 'Nova informação';
      const icon = Icons.info;

      // Act
      store.addInformation(text, icon);

      // Assert
      expect(store.informations.length, 1);
      expect(store.informations.first.text, text);
      expect(store.informations.first.icon, icon);
      expect(store.errorMessage, isNull);
      expect(store.hasInformations, isTrue);
      expect(store.totalItems, 1);
    });

    test('deve gerar ID único para cada informação adicionada', () {
      // Arrange
      const text1 = 'Primeira informação';
      const text2 = 'Segunda informação';
      const icon = Icons.info;

      // Act
      store.addInformation(text1, icon);
      store.addInformation(text2, icon);

      // Assert
      expect(store.informations.length, 2);
      expect(store.informations[0].id, isNot(store.informations[1].id));
      expect(store.informations[0].id, isNotEmpty);
      expect(store.informations[1].id, isNotEmpty);
    });

    test('deve definir createdAt ao adicionar informação', () {
      // Arrange
      const text = 'Informação com data';
      const icon = Icons.calendar_today;
      final beforeAdd = DateTime.now();

      // Act
      store.addInformation(text, icon);

      // Assert
      final addedInfo = store.informations.first;
      expect(addedInfo.createdAt, isNotNull);
      expect(
        addedInfo.createdAt.isAfter(
          beforeAdd.subtract(const Duration(seconds: 1)),
        ),
        isTrue,
      );
      expect(
        addedInfo.createdAt.isBefore(
          DateTime.now().add(const Duration(seconds: 1)),
        ),
        isTrue,
      );
    });

    test('deve trimar espaços em branco do texto antes de adicionar', () {
      // Arrange
      const textWithSpaces = '  Informação com espaços  ';
      const expectedText = 'Informação com espaços';
      const icon = Icons.info;

      // Act
      store.addInformation(textWithSpaces, icon);

      // Assert
      expect(store.informations.first.text, expectedText);
      expect(store.informations.first.text, isNot(textWithSpaces));
    });

    test('deve limpar errorMessage ao adicionar informação com sucesso', () {
      // Arrange
      const text = 'Informação válida';
      const icon = Icons.info;

      // Primeiro, define um erro
      store.addInformation('', icon);
      expect(store.errorMessage, isNotNull);

      // Act
      store.addInformation(text, icon);

      // Assert
      expect(store.errorMessage, isNull);
      expect(store.informations.length, 1);
    });

    test('não deve adicionar informação quando texto está vazio', () {
      // Arrange
      const emptyText = '';
      const icon = Icons.info;

      // Act
      store.addInformation(emptyText, icon);

      // Assert
      expect(store.informations.length, 0);
      expect(store.errorMessage, 'O texto não pode estar vazio');
      expect(store.hasInformations, isFalse);
      expect(store.totalItems, 0);
    });

    test(
      'não deve adicionar informação quando texto contém apenas espaços',
      () {
        // Arrange
        const spacesOnlyText = '   ';
        const icon = Icons.info;

        // Act
        store.addInformation(spacesOnlyText, icon);

        // Assert
        expect(store.informations.length, 0);
        expect(store.errorMessage, 'O texto não pode estar vazio');
        expect(store.hasInformations, isFalse);
      },
    );

    test('deve adicionar múltiplas informações com sucesso', () {
      // Arrange
      const texts = ['Primeira', 'Segunda', 'Terceira'];
      const icon = Icons.info;

      // Act
      for (final text in texts) {
        store.addInformation(text, icon);
      }

      // Assert
      expect(store.informations.length, 3);
      expect(store.totalItems, 3);
      expect(store.hasInformations, isTrue);
      expect(store.informations[0].text, 'Primeira');
      expect(store.informations[1].text, 'Segunda');
      expect(store.informations[2].text, 'Terceira');
    });

    test('deve atualizar totalItems após adicionar informações', () {
      // Arrange
      const icon = Icons.info;

      // Act & Assert
      expect(store.totalItems, 0);

      store.addInformation('Primeira', icon);
      expect(store.totalItems, 1);

      store.addInformation('Segunda', icon);
      expect(store.totalItems, 2);

      store.addInformation('Terceira', icon);
      expect(store.totalItems, 3);
    });

    test('deve manter informações anteriores ao adicionar nova', () {
      // Arrange
      const icon = Icons.info;
      store.addInformation('Primeira informação', icon);
      store.addInformation('Segunda informação', icon);
      final firstId = store.informations[0].id;
      final secondId = store.informations[1].id;

      // Act
      store.addInformation('Terceira informação', icon);

      // Assert
      expect(store.informations.length, 3);
      expect(store.informations[0].id, firstId);
      expect(store.informations[1].id, secondId);
      expect(store.informations[0].text, 'Primeira informação');
      expect(store.informations[1].text, 'Segunda informação');
      expect(store.informations[2].text, 'Terceira informação');
    });

    test('deve adicionar informação com texto longo', () {
      // Arrange
      const longText =
          r'Esta é uma informação com um texto muito longo que pode conter várias palavras e caracteres especiais como: !@#$%^&*()';
      const icon = Icons.description;

      // Act
      store.addInformation(longText, icon);

      // Assert
      expect(store.informations.length, 1);
      expect(store.informations.first.text, longText);
      expect(store.informations.first.text.length, greaterThan(50));
    });

  });
}
