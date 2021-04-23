class LazyValue<T> {
  final T Function() init;

  LazyValue(this.init);

  T? _value;

  // if value was null, init value
  T get value {
    if (_value == null) {
      _value = init();
    }

    return _value!;
  }
}

class LazyListValue<T> {
  final List<T> Function() init;

  LazyListValue(this.init);

  List<T> _list = [];

  List<T> get list {
    if (_list.isEmpty) {
      _list = init();
    }

    return _list;
  }
}
