// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CounterStore on CounterBase, Store {
  late final _$valueAtom = Atom(name: 'CounterBase.value', context: context);

  @override
  int get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(int value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  late final _$loadingCounterAtom =
      Atom(name: 'CounterBase.loadingCounter', context: context);

  @override
  bool get loadingCounter {
    _$loadingCounterAtom.reportRead();
    return super.loadingCounter;
  }

  @override
  set loadingCounter(bool value) {
    _$loadingCounterAtom.reportWrite(value, super.loadingCounter, () {
      super.loadingCounter = value;
    });
  }

  late final _$CounterBaseActionController =
      ActionController(name: 'CounterBase', context: context);

  @override
  void setLoading(dynamic loading) {
    final _$actionInfo = _$CounterBaseActionController.startAction(
        name: 'CounterBase.setLoading');
    try {
      return super.setLoading(loading);
    } finally {
      _$CounterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void increment() {
    final _$actionInfo = _$CounterBaseActionController.startAction(
        name: 'CounterBase.increment');
    try {
      return super.increment();
    } finally {
      _$CounterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementBy(int amount) {
    final _$actionInfo = _$CounterBaseActionController.startAction(
        name: 'CounterBase.incrementBy');
    try {
      return super.incrementBy(amount);
    } finally {
      _$CounterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value},
loadingCounter: ${loadingCounter}
    ''';
  }
}
