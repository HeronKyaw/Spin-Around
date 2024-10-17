import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:go_router/go_router.dart';
import 'package:spin_around/data/models/spinner_wheel_model.dart';
import 'package:spin_around/modules/spinner_wheel/bloc/spinner_wheel_list_cubit/spinner_wheel_list_cubit.dart';
import 'package:spin_around/modules/spinner_wheel/views/single_spinner_wheel.dart';
import 'package:spin_around/modules/spinner_wheel/widgets/spinner_wheel_widget.dart';
import 'package:super_context_menu/super_context_menu.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

class SpinnerWheelListScreen extends StatelessWidget {
  const SpinnerWheelListScreen({super.key});

  static final String tag = 'spinner-wheel-list-screen';

  @override
  Widget build(BuildContext context) {
    return SuperScaffold(
      stretch: true,
      appBar: SuperAppBar(
        title: Text(
          'Spin Around',
        ),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 15,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/image/profile.jpeg',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        actions: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(
                CupertinoIcons.add,
              ),
              onPressed: () {
                context.pushNamed(
                  SingleSpinnerWheel.tag,
                );
              },
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
        searchBar: SuperSearchBar(
          enabled: true,
          scrollBehavior: SearchBarScrollBehavior.pinned,
          resultBehavior: SearchBarResultBehavior.visibleOnInput,
          placeholderText: 'Search',
          onChanged: (text) {},
          onSubmitted: (text) {},
        ),
        largeTitle: SuperLargeTitle(
          largeTitle: 'Spin Around',
        ),
      ),
      body: CupertinoScrollbar(
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

                return Column(
                  children: [
                    if (pinnedWheelList.isNotEmpty) ...[
                      CupertinoListSection.insetGrouped(
                        header: Text('Pinned List'),
                        children: pinnedWheelList.map((wheelModel) {
                          return customContextMenuBuilder(
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
                          return customContextMenuBuilder(
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

  Widget customContextMenuBuilder(
    BuildContext context, {
    required SpinnerWheelModel wheelModel,
    required List<SpinnerWheelModel> wheelList,
  }) {
    return ContextMenuWidget(
      child: wheelListTile(context, wheelModel: wheelModel),
      previewBuilder: (context, child) {
        return SizedBox(
          height: 400,
          child: CupertinoPageScaffold(
              child: SpinnerWheelWidget(
            wheelModel: wheelModel,
          )),
        );
      },
      menuProvider: (request) {
        return Menu(
          children: [
            // MenuAction(
            //   title: 'Spin the Wheel',
            //   callback: () {
            //     controller.add(Fortune.randomInt(0, wheelModel.itemList.length));
            //   },
            // ),
            MenuAction(
              title: wheelModel.isPinned ? 'Unpin' : 'Pin',
              image: MenuImage.icon(
                wheelModel.isPinned
                    ? CupertinoIcons.pin_slash
                    : CupertinoIcons.pin,
              ),
              callback: () async {
                await Future.delayed(
                  const Duration(milliseconds: 350),
                  () {
                    if (context.mounted) {
                      context.read<SpinnerWheelListCubit>().updatePinList(
                            id: wheelModel.id,
                            existedModelList: wheelList,
                          );
                    }
                  },
                );
              },
            ),
            MenuAction(
              title: 'Delete',
              image: MenuImage.icon(
                CupertinoIcons.delete,
              ),
              attributes: MenuActionAttributes(
                destructive: true,
              ),
              callback: () {},
            ),
          ],
        );
      },
    );
  }

  Widget wheelListTile(
    BuildContext context, {
    required SpinnerWheelModel wheelModel,
  }) {
    return CupertinoListTile.notched(
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
      additionalInfo:
          wheelModel.isPinned ? Icon(CupertinoIcons.pin_fill) : null,
      trailing: CupertinoListTileChevron(),
      onTap: () => context.pushNamed(
        SingleSpinnerWheel.tag,
        extra: wheelModel,
      ),
    );
  }
}
