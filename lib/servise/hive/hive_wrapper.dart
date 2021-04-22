import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_wrapper/hive_wrapper.dart';

import 'type/item.dart';

final hiveW = HiveWrapper();

class HiveWrapper {
  final items = BoxItems();

  Future<void> loadHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ItemAdapter());

    await items.load();
  }
}

class BoxItems extends BoxWrapper<Item> {
  BoxItems() : super('items');

  @override
  Future<void> initBox(Box<Item> box) async {}

  Future<int> getOrCreate(String title) async {
    final any = where((element) => element.title == title);

    if (any.isNotEmpty) {
      return any.first.key;
    }

    return box.add(Item.fastInit(title: title));
  }
}
