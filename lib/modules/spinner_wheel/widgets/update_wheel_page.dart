import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spin_around/data/models/spinner_wheel_model.dart';
import 'package:spin_around/global/custom_dialog.dart';
import 'package:spin_around/modules/spinner_wheel/bloc/update_wheel_cubit/update_wheel_cubit.dart';

class UpdateWheelPage extends StatelessWidget {
  final SpinnerWheelModel wheelModel;
  const UpdateWheelPage({super.key, required this.wheelModel});

  static final String tag = 'update-wheel';

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: wheelModel.title);
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(wheelModel.isNew ? 'Create Wheel' : 'Edit Wheel'),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: CupertinoColors.activeBlue,
                ),
              ),
              onTap: () {
                context.pop(wheelModel); // Cancel and go back
              },
            ),
          ],
        ),
        trailing: GestureDetector(
          child: Text(
            'Save',
            style: TextStyle(
              color: CupertinoColors.activeBlue,
            ),
          ),
          onTap: () {
            final wheelCubit = context.read<UpdateWheelCubit>();
            wheelModel.title = wheelCubit.state.title;
            wheelModel.itemList = wheelCubit.state.items;
            context.pop(wheelModel);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // TextField for the wheel name using CupertinoTextField
            BlocBuilder<UpdateWheelCubit, UpdateWheelState>(
              builder: (context, state) {
                return CupertinoTextField(
                  placeholder: 'Wheel Name',
                  onChanged: (newTitle) {
                    context
                        .read<UpdateWheelCubit>()
                        .updateTitle(titleController.text);
                  },
                  controller: titleController,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // Dynamic list of items using a Cupertino List
            Expanded(
              child: BlocBuilder<UpdateWheelCubit, UpdateWheelState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      return CupertinoListTile(
                        title: Text(state.items[index]),
                        trailing: CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Icon(CupertinoIcons.delete,
                              color: CupertinoColors.destructiveRed),
                          onPressed: () {
                            if (state.items.length > 2) {
                              context
                                  .read<UpdateWheelCubit>()
                                  .removeItem(index);
                            } else {
                              CustomDialog.showWarningDialog(
                                context,
                                title: 'Remove Item',
                                body: 'You must have at least two items to work.',
                              );
                            }
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
