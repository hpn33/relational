class FetchValue<T> {
  final T Function(T?) fetch;

  FetchValue(this.fetch);

  T? _value;

  // if value was null, init value
  T get value => _value ?? this();

  T call() {
    _value = fetch(_value);

    return _value!;
  }
}

class FetchListValue<T> {
  final List<T> Function(List<T>) fetch;

  FetchListValue(this.fetch);

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
