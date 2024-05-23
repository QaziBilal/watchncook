import 'package:flutter/material.dart';
import 'package:watchncook/src/widgets/custom_text.dart';

import '../helper/constants.dart';

class ShowUpdateDialog extends StatelessWidget {
  const ShowUpdateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      title: Text('App Update'),
      content:
          Text('App have some updates. Update the app to proceed to the app'),
      actions: [
        TextButton(
          onPressed: () {},
          child: customText(context, "Exit", color: AppColors.black, size: 18),
        ),
        TextButton(
            onPressed: () {},
            child: customText(context, "Update App",
                color: AppColors.mainColor, size: 18)),
      ],
    );
  }
}
