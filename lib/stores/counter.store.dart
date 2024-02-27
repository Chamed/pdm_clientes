import 'package:mobx/mobx.dart';

part 'counter.store.g.dart';

class CounterStore = CounterBase with _$CounterStore;

abstract class CounterBase with Store {
  @observable
  int value = 0;

  @observable
  bool loadingCounter = true;

  @action
  void setLoading(loading) {
    loadingCounter = loading;
  }

  @action
  void increment() {
    value++;
  }

  @action
  void incrementBy(int amount) {
    value += amount;
  }
}
