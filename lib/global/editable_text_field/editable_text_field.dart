import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spin_around/global/editable_text_field/editabe_text_field_cubit.dart';

class EditableTitleWidget extends StatelessWidget {
  final String? initialTitle;
  final Function(String)? onTitleChanged;
  EditableTitleWidget({super.key, this.initialTitle, this.onTitleChanged});

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // Set the initial title value from the model or default to empty string
    _controller.text = initialTitle ?? '';

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TitleCubit()),
        BlocProvider(create: (_) => TextCubit(initialTitle ?? '')),
      ],
      child: BlocBuilder<TitleCubit, bool>(
        builder: (context, isEditing) {
          return GestureDetector(
            onTap: () {
              // Toggle editing state on tap
              context.read<TitleCubit>().toggleEditing();

              // If we're entering editing mode, request focus
              if (!isEditing) {
                _focusNode.requestFocus();
              }
            },
            child: isEditing
                ? BlocBuilder<TextCubit, String>(
              builder: (context, title) {
                return TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  autofocus: true,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(25),
                  ],
                  decoration: const InputDecoration(
                    border: InputBorder.none, // No underline
                  ),
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  // Update title when the user finishes editing
                  onSubmitted: (newValue) {
                    context.read<TextCubit>().updateTitle(newValue);
                    // Notify parent via callback
                    if (onTitleChanged != null) {
                      onTitleChanged!(newValue);
                    }
                    context.read<TitleCubit>().toggleEditing(); // Exit editing mode
                  },
                );
              },
            )
                : BlocBuilder<TextCubit, String>(
              builder: (context, title) {
                return Text(
                  title.isEmpty ? 'Tap to edit' : title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
