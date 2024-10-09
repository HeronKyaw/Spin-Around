import 'package:authentication_repository/authentication_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CreateProfile extends StatelessWidget {
  final User? userInfo;
  const CreateProfile({super.key, this.userInfo});
  static final String tag = 'create-profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: userInfo != null
          ? AppBar(
              title: Text(tr('editProfile')),
            )
          : null,
      body: Column(
        children: [
          CircleAvatar(),
        ],
      ),
    );
  }
}
