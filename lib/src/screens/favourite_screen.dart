import 'package:flutter/material.dart';

import '../helper/constants.dart';
import '../widgets/custom_text.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: customText(context, "Favourite",
              size: 20, fontWeight: FontWeight.w800)),
      body: ListView.builder(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
        itemCount: 10,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Card(
            child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                tileColor: Colors.orange.shade100,
                leading: const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blueAccent,
                ),
                title: customText(context, "Dish Name",
                    color: AppColors.black,
                    fontWeight: FontWeight.w800,
                    size: 20,
                    textAlign: TextAlign.left),
                subtitle: customText(context, "Cooking Time 2 hours",
                    textAlign: TextAlign.left,
                    size: 15,
                    color: AppColors.black.withOpacity(0.7)),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.close,
                    size: 20,
                    color: Colors.red,
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
