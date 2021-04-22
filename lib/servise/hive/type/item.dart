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
    save();
  }

  int refs() {
    var sum = 0;

    for (final item in hiveW.items.all) {
      for (final ui in item.itemUsed) {
        if (ui == key) {
          sum++;
        }
      }
    }

    return sum;
  }

  List<Item> itemRefs() {
    final refs = <Item>[];

    for (final item in hiveW.items.all) {
      for (final ui in item.itemUsed) {
        if (ui == key) {
          refs.add(item);
          continue;
        }
      }
    }

    return refs;
  }
}
