class SpinnerWheelModel {
  int id;
  String title;
  String modifiedDate;
  List<String> itemList;
  bool isPinned;
  bool isNew;

  SpinnerWheelModel({
    this.id = 0,
    this.title = 'Untitled Wheel',
    this.modifiedDate = '',
    this.itemList = const ['Marvel', 'DC', 'The Boys'],
    this.isPinned = false,
    this.isNew = false,
  });
}
