import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:relational/servise/hive/hive_wrapper.dart';

import 'app.dart';

Future main() async {
  await hiveW.loadHive();

  runApp(ProviderScope(child: MyApp()));
}
