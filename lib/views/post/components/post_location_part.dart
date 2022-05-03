import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_clone/generated/l10n.dart';
import 'package:insta_clone/models/data_models/location.dart';
import 'package:insta_clone/styles/font.dart';
import 'package:insta_clone/viewmodels/post_view_model.dart';
import 'package:insta_clone/views/post/screens/map_screen.dart';
import 'package:provider/provider.dart';

class PostLocationPart extends StatelessWidget {
  const PostLocationPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postViewModel = context.watch<PostViewModel>();

    return ListTile(
      title: Text(
        postViewModel.locationString,
        style: postLocationTextStyle,
      ),
      subtitle: _latLngPart(postViewModel.location, context),
      trailing: IconButton(
        icon: FaIcon(FontAwesomeIcons.mapLocationDot),
        onPressed: () => _openMapScreen(context, postViewModel.location),
      ),
    );
  }

  _latLngPart(Location? location, BuildContext context) {
    const spaceWidth = 8.0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Chip(
          label: Text(S.of(context).latitude),
        ),
        SizedBox(
          width: spaceWidth,
        ),
        Text(location?.latitude.toStringAsFixed(2) ?? "0.00"),
        SizedBox(
          width: spaceWidth,
        ),
        Chip(
          label: Text(S.of(context).longitude),
        ),
        Text(location?.longitude.toStringAsFixed(2) ?? "0.00"),
      ],
    );
  }

  _openMapScreen(BuildContext context, Location? location) {
    if (location == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MapScreen(location: location),
      ),
    );
  }
}
