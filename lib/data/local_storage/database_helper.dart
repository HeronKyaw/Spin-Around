import 'package:hive_flutter/hive_flutter.dart';

class DatabaseHelper<T> {
  final String boxName;

  DatabaseHelper(this.boxName);

  // Initialize Hive and open a generic box
  static Future<void> initHive() async {
    await Hive.initFlutter();
  }

  // Open the box for the specific data type
  Future<void> openBox() async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<T>(boxName);
    }
  }

  // Add an item to the box
  Future<void> addItem(T item) async {
    var box = Hive.box<T>(boxName);
    await box.add(item);
  }

  // Retrieve an item by index
  T? getItem(int index) {
    var box = Hive.box<T>(boxName);
    return box.getAt(index);
  }

  // Get all items from the box
  List<T> getAllItems() {
    var box = Hive.box<T>(boxName);
    return box.values.toList();
  }

  // Update an item at a specific index
  Future<void> updateItem(int index, T newItem) async {
    var box = Hive.box<T>(boxName);
    await box.putAt(index, newItem);
  }

  // Delete an item by index
  Future<void> deleteItem(int index) async {
    var box = Hive.box<T>(boxName);
    await box.deleteAt(index);
  }

  // Clear all data from the box
  Future<void> clearAllItems() async {
    var box = Hive.box<T>(boxName);
    await box.clear();
  }

  // Close Hive boxes
  static Future<void> closeHive() async {
    await Hive.close();
  }

  static void registerAdaptors() async {}
}
