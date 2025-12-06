import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:target/modules/listing/domain/entities/information.dart';

part 'listing_store.g.dart';

class ListingStore = _ListingStore with _$ListingStore;

abstract class _ListingStore with Store {
  _ListingStore() {
    _initializeStore();
  }

  void _initializeStore() {
    // Inicialização se necessário
  }

  @observable
  ObservableList<Information> informations = ObservableList<Information>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  int editCount = 0;

  @action
  void addInformation(String text, IconData icon) {
    if (text.trim().isEmpty) {
      errorMessage = 'O texto não pode estar vazio';
      return;
    }

    errorMessage = null;

    final newInformation = Information(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text.trim(),
      icon: icon,
      createdAt: DateTime.now(),
    );

    informations.add(newInformation);
  }

  @action
  void removeInformation(String id) {
    informations.removeWhere((info) => info.id == id);
  }

  @action
  void duplicateInformation(String id) {
    final information = getInformationById(id);
    if (information != null) {
      final duplicatedInformation = Information(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: information.text,
        icon: information.icon,
        createdAt: DateTime.now(),
      );
      informations.add(duplicatedInformation);
    }
  }

  @action
  void updateInformation(String id, String newText, IconData newIcon) {
    if (newText.trim().isEmpty) {
      errorMessage = 'O texto não pode estar vazio';
      return;
    }

    errorMessage = null;

    final index = informations.indexWhere((info) => info.id == id);
    if (index != -1) {
      final existingInfo = informations[index];
      informations[index] = existingInfo.copyWith(
        text: newText.trim(),
        icon: newIcon,
      );
      editCount++;
    }
  }

  @action
  void clearErrorMessage() {
    errorMessage = null;
  }

  Information? getInformationById(String id) {
    try {
      return informations.firstWhere((info) => info.id == id);
    } catch (e) {
      return null;
    }
  }

  @computed
  bool get hasInformations => informations.isNotEmpty;

  @computed
  int get totalItems => informations.length;

  @computed
  int get totalCharacters {
    return informations.fold(0, (sum, info) => sum + info.text.length);
  }

  @computed
  int get totalLetters {
    return informations.fold(0, (sum, info) {
      var count = 0;
      for (final codeUnit in info.text.codeUnits) {
        if ((codeUnit >= 65 && codeUnit <= 90) ||
            (codeUnit >= 97 && codeUnit <= 122)) {
          count++;
        }
      }
      return sum + count;
    });
  }

  @computed
  int get totalNumbers {
    return informations.fold(0, (sum, info) {
      var count = 0;
      for (final codeUnit in info.text.codeUnits) {
        if (codeUnit >= 48 && codeUnit <= 57) {
          count++;
        }
      }
      return sum + count;
    });
  }

  @computed
  double get lettersPercentage {
    final total = totalCharacters;
    if (total == 0) return 0;
    return (totalLetters / total) * 100;
  }

  @computed
  double get numbersPercentage {
    final total = totalCharacters;
    if (total == 0) return 0;
    return (totalNumbers / total) * 100;
  }
}
