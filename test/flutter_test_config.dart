import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  // Initialize sqflite_common_ffi for local tests
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  
  await testMain();
}
