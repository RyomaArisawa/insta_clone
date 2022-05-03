import 'package:flutter/material.dart';
import 'package:insta_clone/utils/constants.dart';
import 'package:insta_clone/viewmodels/post_view_model.dart';
import 'package:insta_clone/views/post/components/post_caption_input_text_field.dart';
import 'package:insta_clone/views/post/screens/enlarge_image_screen.dart';
import 'package:provider/provider.dart';

import 'hero_image.dart';

class PostCaptionPart extends StatelessWidget {
  final PostCaptionOpenMode from;
  PostCaptionPart({required this.from});

  @override
  Widget build(BuildContext context) {
    final postViewModel = context.read<PostViewModel>();
    final image = (postViewModel.imageFile != null)
        ? Image.file(postViewModel.imageFile!)
        : Image.asset("assets/images/no_image.png");

    if (from == PostCaptionOpenMode.FROM_POST) {
      return ListTile(
        //TODO
        leading: HeroImage(
          image: image,
          onTap: () => _displayLargeImage(context, image),
        ),
        //TODO
        title: PostCaptionInputTextField(),
      );
    } else {
      //TODO
      return Container();
    }
  }

  _displayLargeImage(BuildContext context, Image image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EnlargeImageScreen(image: image),
      ),
    );
  }
}
