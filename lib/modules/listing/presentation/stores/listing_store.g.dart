// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ListingStore on _ListingStore, Store {
  Computed<bool>? _$hasInformationsComputed;

  @override
  bool get hasInformations =>
      (_$hasInformationsComputed ??= Computed<bool>(
            () => super.hasInformations,
            name: '_ListingStore.hasInformations',
          ))
          .value;
  Computed<int>? _$totalItemsComputed;

  @override
  int get totalItems =>
      (_$totalItemsComputed ??= Computed<int>(
            () => super.totalItems,
            name: '_ListingStore.totalItems',
          ))
          .value;
  Computed<int>? _$totalCharactersComputed;

  @override
  int get totalCharacters =>
      (_$totalCharactersComputed ??= Computed<int>(
            () => super.totalCharacters,
            name: '_ListingStore.totalCharacters',
          ))
          .value;
  Computed<int>? _$totalLettersComputed;

  @override
  int get totalLetters =>
      (_$totalLettersComputed ??= Computed<int>(
            () => super.totalLetters,
            name: '_ListingStore.totalLetters',
          ))
          .value;
  Computed<int>? _$totalNumbersComputed;

  @override
  int get totalNumbers =>
      (_$totalNumbersComputed ??= Computed<int>(
            () => super.totalNumbers,
            name: '_ListingStore.totalNumbers',
          ))
          .value;
  Computed<double>? _$lettersPercentageComputed;

  @override
  double get lettersPercentage =>
      (_$lettersPercentageComputed ??= Computed<double>(
            () => super.lettersPercentage,
            name: '_ListingStore.lettersPercentage',
          ))
          .value;
  Computed<double>? _$numbersPercentageComputed;

  @override
  double get numbersPercentage =>
      (_$numbersPercentageComputed ??= Computed<double>(
            () => super.numbersPercentage,
            name: '_ListingStore.numbersPercentage',
          ))
          .value;

  late final _$informationsAtom = Atom(
    name: '_ListingStore.informations',
    context: context,
  );

  @override
  ObservableList<Information> get informations {
    _$informationsAtom.reportRead();
    return super.informations;
  }

  @override
  set informations(ObservableList<Information> value) {
    _$informationsAtom.reportWrite(value, super.informations, () {
      super.informations = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_ListingStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_ListingStore.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$editCountAtom = Atom(
    name: '_ListingStore.editCount',
    context: context,
  );

  @override
  int get editCount {
    _$editCountAtom.reportRead();
    return super.editCount;
  }

  @override
  set editCount(int value) {
    _$editCountAtom.reportWrite(value, super.editCount, () {
      super.editCount = value;
    });
  }

  late final _$_ListingStoreActionController = ActionController(
    name: '_ListingStore',
    context: context,
  );

  @override
  void addInformation(String text, IconData icon) {
    final _$actionInfo = _$_ListingStoreActionController.startAction(
      name: '_ListingStore.addInformation',
    );
    try {
      return super.addInformation(text, icon);
    } finally {
      _$_ListingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeInformation(String id) {
    final _$actionInfo = _$_ListingStoreActionController.startAction(
      name: '_ListingStore.removeInformation',
    );
    try {
      return super.removeInformation(id);
    } finally {
      _$_ListingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void duplicateInformation(String id) {
    final _$actionInfo = _$_ListingStoreActionController.startAction(
      name: '_ListingStore.duplicateInformation',
    );
    try {
      return super.duplicateInformation(id);
    } finally {
      _$_ListingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateInformation(String id, String newText, IconData newIcon) {
    final _$actionInfo = _$_ListingStoreActionController.startAction(
      name: '_ListingStore.updateInformation',
    );
    try {
      return super.updateInformation(id, newText, newIcon);
    } finally {
      _$_ListingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearErrorMessage() {
    final _$actionInfo = _$_ListingStoreActionController.startAction(
      name: '_ListingStore.clearErrorMessage',
    );
    try {
      return super.clearErrorMessage();
    } finally {
      _$_ListingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
informations: ${informations},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
editCount: ${editCount},
hasInformations: ${hasInformations},
totalItems: ${totalItems},
totalCharacters: ${totalCharacters},
totalLetters: ${totalLetters},
totalNumbers: ${totalNumbers},
lettersPercentage: ${lettersPercentage},
numbersPercentage: ${numbersPercentage}
    ''';
  }
}
