class LazyValue<T> {
  final T Function(T) fetch;

  LazyValue(this.fetch);

  T? _value;

  // if value was null, init value
  T get value => value ?? this();

  T call() => fetch(_value!);
}

class LazyListValue<T> {
  final List<T> Function(List<T>) fetch;

  LazyListValue(this.fetch);

  List<T> _list = [];

  // return list
  // if not empty return list
  // if empty run fetch function and then return list
  List<T> get list {
    if (_list.isNotEmpty) {
      return _list;
    }

    return this();
  }

  // when invoke then run fetch func
  List<T> call() => fetch(_list);
}
