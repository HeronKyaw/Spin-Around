import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spin_around/global/editable_text_field/editabe_text_field_cubit.dart';

class EditableTitleWidget extends StatelessWidget {
  final String? initialText;
  final Function(String)? onTextChanged;
  final VoidCallback onDelete; // Callback for delete action
  final int maxLength;

  EditableTitleWidget({
    super.key,
    this.initialText,
    this.onTextChanged,
    required this.onDelete, // Require delete callback
    this.maxLength = 25, // Allow a longer length for list items
  });

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    _controller.text = initialText ?? '';

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TitleCubit()),
        BlocProvider(create: (_) => TextCubit(initialText ?? '')),
      ],
      child: BlocBuilder<TitleCubit, bool>(
        builder: (context, isEditing) {
          context.read<TextCubit>().updateTitle(_controller.text);
          return GestureDetector(
            onDoubleTap: () {
              if (!isEditing) {
                context.read<TitleCubit>().toggleEditing();
                if (!isEditing) {
                  _focusNode.requestFocus();
                }
              }
            },
            child: SizedBox(
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<TextCubit, String>(
                    builder: (context, text) {
                      if (isEditing) {
                        return Expanded(
                          child: CupertinoTextField(
                            controller: _controller,
                            focusNode: _focusNode,
                            autofocus: true,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(maxLength),
                            ],
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: CupertinoColors.systemGrey,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            onSubmitted: (newValue) {
                              context.read<TextCubit>().updateTitle(newValue);
                              if (onTextChanged != null) {
                                onTextChanged!(newValue);
                              }
                              FocusScope.of(context).unfocus();
                              context.read<TitleCubit>().toggleEditing();
                            },
                            onTapOutside: (event) {
                              context
                                  .read<TextCubit>()
                                  .updateTitle(_controller.text);
                              if (onTextChanged != null) {
                                onTextChanged!(_controller.text);
                              }
                              FocusScope.of(context).unfocus();
                              context.read<TitleCubit>().toggleEditing();
                            },
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            text.isEmpty ? 'Double tap to edit' : text,
                            style: const TextStyle(
                                fontSize: 19, letterSpacing: 0.5),
                          ),
                        );
                      }
                    },
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: onDelete,
                    child: Icon(
                      CupertinoIcons.delete,
                      color: CupertinoColors.destructiveRed,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
