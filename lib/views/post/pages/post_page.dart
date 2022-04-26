import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_clone/utils/constants.dart';
import 'package:insta_clone/views/components/button_with_icon.dart';
import 'package:insta_clone/views/post/screens/post_upload_screen.dart';

import '../../../generated/l10n.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 90.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ButtonWithIcon(
                  onPressed: () =>
                      _openUploadScreen(UploadType.GALLERY, context),
                  iconData: FontAwesomeIcons.images,
                  label: S.of(context).gallery),
              SizedBox(
                height: 24.0,
              ),
              ButtonWithIcon(
                  onPressed: () =>
                      _openUploadScreen(UploadType.CAMERA, context),
                  iconData: FontAwesomeIcons.camera,
                  label: S.of(context).camera),
            ],
          ),
        ),
      ),
    );
  }

  _openUploadScreen(UploadType uploadType, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PostUploadScreen(
          uploadType: uploadType,
        ),
      ),
    );
  }
}
