import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spin_around/data/models/spinner_wheel_model.dart';
import 'package:spin_around/modules/spinner_wheel/bloc/spinner_wheel_list_cubit/spinner_wheel_list_cubit.dart';
import 'package:spin_around/modules/spinner_wheel/views/single_spinner_wheel.dart';

class SpinnerWheelListScreen extends StatelessWidget {
  const SpinnerWheelListScreen({super.key});

  static final String tag = 'spinner-wheel-list-screen';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Spin Around'),
        trailing: Icon(CupertinoIcons.add),
      ),
      child: CupertinoScrollbar(
        child: BlocConsumer<SpinnerWheelListCubit, SpinnerWheelListState>(
          listener: (context, state) {
            // TODO: implement listener if needed
          },
          builder: (context, state) {
            if (state is SpinnerWheelListFetched) {
              List<SpinnerWheelModel> wheelList = state.wheelList;
              if (wheelList.isEmpty) {
                return Center(
                  child: Text('Empty Data'),
                );
              } else {
                List<SpinnerWheelModel> pinnedWheelList =
                    wheelList.where((w) => w.isPinned).toList();
                List<SpinnerWheelModel> unpinnedWheelList =
                    wheelList.where((w) => !w.isPinned).toList();

                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16.0,
                        left: 16.0,
                        right: 16.0,
                      ),
                      child: CupertinoSearchTextField(
                        controller: TextEditingController(),
                        placeholder: 'Search',
                      ),
                    ),
                    if (pinnedWheelList.isNotEmpty) ...[
                      CupertinoListSection.insetGrouped(
                        header: Text('Pinned List'),
                        children: pinnedWheelList.map((wheelModel) {
                          return wheelListTile(
                            context,
                            wheelModel: wheelModel,
                            wheelList: wheelList,
                          );
                        }).toList(),
                      ),
                    ],
                    if (unpinnedWheelList.isNotEmpty) ...[
                      CupertinoListSection.insetGrouped(
                        children: unpinnedWheelList.map((wheelModel) {
                          return wheelListTile(
                            context,
                            wheelModel: wheelModel,
                            wheelList: wheelList,
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                );
              }
            } else {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget wheelListTile(
    BuildContext context, {
    required SpinnerWheelModel wheelModel,
    required List<SpinnerWheelModel> wheelList,
  }) {
    return CupertinoContextMenu(
      enableHapticFeedback: true,
      actions: <Widget>[
        CupertinoContextMenuAction(
          trailingIcon: wheelModel.isPinned
              ? CupertinoIcons.pin_slash
              : CupertinoIcons.pin,
          child: Text(wheelModel.isPinned ? 'Unpin' : 'Pin'),
          onPressed: () {
            Navigator.pop(context); // Close the context menu
            context.read<SpinnerWheelListCubit>().updatePinList(
                  id: wheelModel.id,
                  existedModelList: wheelList,
                );
          },
        ),
        CupertinoContextMenuAction(
          trailingIcon: CupertinoIcons.delete,
          child: Text('Delete'),
          onPressed: () {
            // Implement delete functionality
          },
        ),
      ],
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width, // Avoid infinite width
        ),
        child: CupertinoListTile.notched(
          leadingSize: 40,
          leading: Container(
            decoration: BoxDecoration(
              color: CupertinoColors.activeGreen,
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          title: Text(wheelModel.title),
          subtitle: Text(
            wheelModel.itemList.length.toString(),
          ),
          trailing: CupertinoListTileChevron(),
          onTap: () => context.pushNamed(
            SingleSpinnerWheel.tag,
            extra: wheelModel,
          ),
        ),
      ),
    );
  }
}
