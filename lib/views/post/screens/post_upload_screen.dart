import 'package:flutter/material.dart';
import 'package:insta_clone/generated/l10n.dart';
import 'package:insta_clone/utils/constants.dart';
import 'package:insta_clone/viewmodels/post_view_model.dart';
import 'package:provider/provider.dart';

import '../components/post_caption_part.dart';
import '../components/post_location_part.dart';

class PostUploadScreen extends StatelessWidget {
  final UploadType uploadType;
  PostUploadScreen({required this.uploadType});

  @override
  Widget build(BuildContext context) {
    final postViewModel = context.read<PostViewModel>();

    if (!postViewModel.isImagePicked && !postViewModel.isProcessing) {
      Future(() => postViewModel.pickImage(uploadType));
    }
    return Consumer<PostViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            leading: model.isProcessing
                ? Container()
                : IconButton(
                    onPressed: () => _cancelPost(context),
                    icon: Icon(Icons.arrow_back),
                  ),
            title: model.isProcessing
                ? Text(S.of(context).underProcessing)
                : Text(S.of(context).post),
            actions: [
              (model.isProcessing || !model.isImagePicked)
                  ? IconButton(
                      onPressed: () => _cancelPost(context),
                      icon: Icon(Icons.close),
                    )
                  : IconButton(onPressed: null, icon: Icon(Icons.done))
            ],
          ),
          body: model.isProcessing
              ? Center(child: CircularProgressIndicator())
              : model.isImagePicked
                  ? Column(
                      children: [
                        Divider(),
                        //TODO
                        PostCaptionPart(
                          from: PostCaptionOpenMode.FROM_POST,
                        ),
                        Divider(),
                        PostLocationPart(),
                        Divider(),
                      ],
                    )
                  : Container(),
        );
      },
    );
  }

  _cancelPost(BuildContext context) {
    Navigator.pop(context);
  }
}
