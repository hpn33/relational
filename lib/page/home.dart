import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:relational/servise/hive/hive_wrapper.dart';
import 'package:relational/servise/hive/type/item.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'item/item_page.dart';

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useListenable(hiveW.items.box.listenable());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Column(
              children: [
                Text('All Items'),
                Divider(),
                for (final item in hiveW.items.all) itemCard(context, item),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemCard(BuildContext context, Item item) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) {
              return ItemPage(item);
            }),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(item.title),
            Text('used ${item.itemUsed.length}'),
            Text('ref ${item.refs.list.length}'),
          ],
        ),
      ),
    );
  }
}
