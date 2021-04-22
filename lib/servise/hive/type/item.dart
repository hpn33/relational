import 'package:hive/hive.dart';

import '../hive_wrapper.dart';
part 'item.g.dart';

@HiveType(typeId: 0)
class Item extends HiveObject {
  @HiveField(0)
  String title = '';

  @HiveField(1)
  String description = '';

  @HiveField(2)
  List<int> itemUsed = [];

  @HiveField(3)
  late DateTime createAt;

  @HiveField(4)
  late DateTime updateAt;

  Item();

  factory Item.fastInit({required String title}) {
    return Item()
      ..title = title
      ..createAt = DateTime.now()
      ..updateAt = DateTime.now();
  }

  Future<void> addUsedByTitle(String title) async {
    final id = await hiveW.items.getOrCreate(title);
    await addUsed(id);
  }

  Future<void> addUsed(int id) async {
    itemUsed.add(id);
    updateAt = DateTime.now();

    save();
  }

  // final refs = DelayListValue<Item>((list) {
  //   list.clear();

  //   for (final item in hiveW.items.all) {
  //     for (final ui in item.itemUsed) {
  //       if (ui == key) {
  //         list.add(item);
  //         continue;
  //       }
  //     }
  //   }

  //   return list;
  // });
  final _refs = <Item>[];

  List<Item> get refs {
    if (_refs.isNotEmpty) {
      return _refs;
    }

    return getRefs();
  }

  List<Item> getRefs() {
    _refs.clear();

    for (final item in hiveW.items.all) {
      for (final ui in item.itemUsed) {
        if (ui == key) {
          _refs.add(item);
          continue;
        }
      }
    }

    return _refs;
  }
}

// class DelayValue<T> {
//   final T Function(T) getFunc;

//   DelayValue(this.getFunc);

//   T? _value;

//   T get value {
//     if (_value != null) {
//       return _value!;
//     }

//     return getFunc(_value!);
//   }

//   void refresh() => getFunc(_value!);

//   void call() => getFunc(_value!);
// }

// class DelayListValue<T> {
//   final List<T> Function(List<T>) getFunc;

//   DelayListValue(this.getFunc);

//   List<T> _list = [];

//   List<T> get value {
//     if (_list.isNotEmpty) {
//       return _list;
//     }

//     return getFunc(_list);
//   }

//   void refresh() => getFunc(_list);

//   void call() => getFunc(_list);
// }
