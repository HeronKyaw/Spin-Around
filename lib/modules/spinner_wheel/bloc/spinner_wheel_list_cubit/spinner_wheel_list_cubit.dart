import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spin_around/data/models/spinner_wheel_model.dart';

part 'spinner_wheel_list_state.dart';

class SpinnerWheelListCubit extends Cubit<SpinnerWheelListState> {
  SpinnerWheelListCubit() : super(SpinnerWheelListInitial());

  void fetchData() {
    List<SpinnerWheelModel> wheelList = [
      SpinnerWheelModel(
        id: 1,
        title: 'Wheel #1',
        itemList: [
          'Item #1',
          'Item #2',
          'Item #3',
          'Item #4',
        ],
      ),
      SpinnerWheelModel(
        id: 2,
        title: 'Wheel #2',
        itemList: [
          'Item #1',
          'Item #2',
          'Item #3',
          'Item #4',
          'Item #5',
        ],
      ),
      SpinnerWheelModel(
        id: 3,
        title: 'Wheel #3',
        itemList: [
          'Item #1',
          'Item #2',
          'Item #3',
          'Item #4',
          'Item #5',
          'Item #6',
          'Item #7',
          'Item #9',
        ],
      ),
    ];

    emit(SpinnerWheelListFetched(wheelList));
  }

  void updatePinList({
    required int id,
    required List<SpinnerWheelModel> existedModelList,
  }) {
    final SpinnerWheelModel wheelModel =
        existedModelList.firstWhere((model) => model.id == id);
    wheelModel.isPinned = !wheelModel.isPinned;

    // Sort the list with pinned items on top, followed by unpinned, sorted by modified date
    List<SpinnerWheelModel> sortedWheelList = List.from(existedModelList)
      ..sort((a, b) {
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;
        return b.modifiedDate.compareTo(a.modifiedDate); // Sort by modified date
      });

    // Emit the updated model list
    emit(SpinnerWheelListFetched(sortedWheelList));
  }
}
