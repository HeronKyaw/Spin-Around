class SpinnerWheelModel {
  int id;
  String title;
  String modifiedDate;
  List<String> itemList;
  bool isPinned;

  SpinnerWheelModel({
    this.id = 0,
    this.title = '',
    this.modifiedDate = '',
    this.itemList = const [],
    this.isPinned = false,
  });

  bool get isEmpty => title.isEmpty && itemList.isEmpty;
}
