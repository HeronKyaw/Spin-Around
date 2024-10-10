class SpinnerWheelModel {
  String title;
  List<String> itemList;

  SpinnerWheelModel({
    this.title = '',
    this.itemList = const [],
  });

  bool get isEmpty => title.isEmpty && itemList.isEmpty;
}
