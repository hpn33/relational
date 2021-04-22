import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:relational/servise/hive/hive_wrapper.dart';
import 'package:relational/servise/hive/type/item.dart';

import 'package:hive_flutter/hive_flutter.dart';

class ItemPage extends StatelessWidget {
  final Item item;

  ItemPage(this.item);

  @override
  Widget build(BuildContext context) {
    var hslColor = HSLColor.fromColor(Colors.white).withLightness(0.9);

    return Scaffold(
      backgroundColor: hslColor.toColor(),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          BackButton(),
                          Text(item.title),
                        ],
                      ),
                      Divider(),
                      Text(item.description),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      whatUsingCard(),
                      whereUsedCard(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget whereUsedCard() {
    return HookBuilder(
      builder: (BuildContext context) {
        return Card(
          child: Column(
            children: [
              Text('Where Used (refs)'),
              Divider(),
              for (final refItem in item.refs)
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ItemPage(refItem),
                      ),
                    );
                  },
                  child: Text(refItem.title),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget whatUsingCard() {
    return HookBuilder(
      builder: (BuildContext context) {
        useListenable(hiveW.items.box.listenable());
        final controller = useTextEditingController();

        return Card(
          child: Column(
            children: [
              Text('What using'),
              Divider(),
              TextField(
                controller: controller,
                onSubmitted: (value) async {
                  await item.addUsedByTitle(value);

                  controller.clear();
                },
              ),
              Divider(),
              for (final itemId in item.itemUsed)
                Builder(
                  builder: (BuildContext context) {
                    final it = hiveW.items
                        .where((element) => element.key == itemId)
                        .first;

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => ItemPage(it),
                          ),
                        );
                      },
                      child: Text(it.title),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
