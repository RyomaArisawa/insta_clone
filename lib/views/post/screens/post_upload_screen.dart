import 'package:flutter/material.dart';
import 'package:insta_clone/utils/constants.dart';

class PostUploadScreen extends StatelessWidget {
  final UploadType uploadType;
  PostUploadScreen({required this.uploadType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("PostUploadScreen"),
      ),
    );
  }
}