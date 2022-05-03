import 'package:flutter/material.dart';
import 'package:insta_clone/generated/l10n.dart';
import 'package:insta_clone/styles/font.dart';
import 'package:insta_clone/viewmodels/post_view_model.dart';
import 'package:provider/provider.dart';

class PostCaptionInputTextField extends StatefulWidget {
  const PostCaptionInputTextField({Key? key}) : super(key: key);

  @override
  State<PostCaptionInputTextField> createState() =>
      _PostCaptionInputTextFieldState();
}

class _PostCaptionInputTextFieldState extends State<PostCaptionInputTextField> {
  final TextEditingController _captionController = TextEditingController();

  @override
  void initState() {
    _captionController.addListener(_onCaptionUpdated);
    super.initState();
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _captionController,
      style: postCaptionTextStyle,
      autofocus: true,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
          hintText: S.of(context).inputCaption, border: InputBorder.none),
    );
  }

  _onCaptionUpdated() {
    final viewModel = context.read<PostViewModel>();
    viewModel.caption = _captionController.text;
    print("${viewModel.caption}");
  }
}
