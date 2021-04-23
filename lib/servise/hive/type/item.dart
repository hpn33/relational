import 'package:hive/hive.dart';
import 'package:relational/util/fetch.dart';
import 'package:relational/util/lazy.dart';

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

  Item() {
    refs = FetchListValue<Item>(
      (list) {
        list.clear();

        for (final item in hiveW.items.all) {
          for (final ui in item.itemUsed) {
            if (ui == key) {
              list.add(item);
              continue;
            }
          }
        }

        return list;
      },
    );
  }

  late final FetchListValue refs;

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
}
