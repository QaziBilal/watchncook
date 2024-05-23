import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:watchncook/src/controller/tag_controller.dart';
import 'package:watchncook/src/firebase/app_update.dart';
import 'package:watchncook/src/helper/sizedbox_extenstion.dart';
import 'package:watchncook/src/models/model_recipe.dart';
import 'package:watchncook/src/widgets/custom_text.dart';
import 'package:watchncook/src/widgets/tag_container.dart';

import '../helper/constants.dart';
import 'detail_recipe_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List<String> tags = [
    "Spring Pasta",
    "Maccroni",
    "Pakistani",
    "Asian",
    "Dessert",
    "Chicken",
    "Kabab"
  ];
  List tagsList = [];

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.sizeOf(context).width;
    double sh = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: customText(context, "Home",
              size: 20, fontWeight: FontWeight.w800)),
      body: SingleChildScrollView(
        child: Column(
          children: [10.height, tagList(sh), 20.height, cardDesign(sh, sw)],
        ),
      ),
    );
  }

  Widget tagList(sh) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Consumer<TagController>(
          builder: (context, tag, child) => Row(
            children: [
              CustomTagWidget(
                onTap: () {
                  // tag.updateIndex(-1);
                  tag.updateTagsindex('All');
                },
                text: "All",
                selectedIndex: tag.selectedtag,
                currentIndex: 'All',
              ),
              5.width,
              FutureBuilder(
                  future: FirebaseWork().fetchTagsFromFirestore(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Shimmer.fromColors(
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Container(
                                  height: 40,
                                  width: 70,
                                  margin: const EdgeInsets.only(right: 20),
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: Text(
                                    "  ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              );
                            }),
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text("Data has Some Errors"),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("There is no tags in the database"),
                      );
                    } else {
                      tagsList = snapshot.data!;
                      // print("TagsList = ${tagsList.length}");
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: tagsList.length,
                        itemBuilder: (context, index) {
                          return CustomTagWidget(
                            onTap: () {
                              tag.updateTagsindex('${tagsList[index]}');
                              // tag.updateIndex(index);
                              // print("Selected Index = ${tagsList[index]}");
                            },
                            text: tagsList[index],
                            selectedIndex: tag.selectedtag,
                            currentIndex: tagsList[index],
                          );
                        },
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

Widget cardDesign(sh, sw) {
  return FutureBuilder<List<RecipeModel>>(
      future: FirebaseWork().fetchRecipesFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
            padding:
                EdgeInsets.only(left: sw * 0.05, right: sw * 0.05, bottom: 20),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4, // Placeholder for shimmer effect
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Card(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    width: sw * 0.9,
                    height: sh * 0.2,
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Data Have Some Error"),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text("There is No recipes Available"),
          );
        } else {
          recipeListMain = snapshot.data!;
          final tagProvider = Provider.of<TagController>(context);
          List<RecipeModel> filteredList = tagProvider.selectedtag == "All"
              ? recipeListMain
              : recipeListMain
                  .where((cat) => cat.category == tagProvider.selectedtag)
                  .toList();

          return ListView.builder(
              padding: EdgeInsets.only(
                  left: sw * 0.05, right: sw * 0.05, bottom: 20),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailRecipeScreen(
                                  recipeModel: recipeListMain[index],
                                )));
                  },
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 15),
                    clipBehavior: Clip.hardEdge,
                    elevation: 5,
                    shadowColor: AppColors.black.withOpacity(0.7),
                    child: Stack(
                      children: [
                        Image.network(
                          filteredList[index].imageUrl,
                          height: sh * 0.2,
                          width: sw * 0.9,
                          fit: BoxFit.cover,
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                  Colors.transparent,
                                  AppColors.black.withOpacity(0.5),
                                ])),
                          ),
                        ),
                        Positioned(
                            bottom: 15,
                            right: 20,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey.shade200,
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 25,
                              ),
                            )),
                        Positioned(
                            bottom: 15,
                            left: 20,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  gradient: LinearGradient(colors: [
                                    AppColors.black.withOpacity(0.6),
                                    AppColors.black.withOpacity(0.3)
                                  ])),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: AppColors.white,
                                    size: 20,
                                  ),
                                  5.width,
                                  customText(
                                      context, filteredList[index].cookingTime,
                                      size: 12),
                                ],
                              ),
                            )),
                        Align(
                          alignment: Alignment.center,
                          child: customText(context, filteredList[index].name,
                              size: 24),
                        ),
                      ],
                    ),
                  ),
                );
              });
        }
      });
}

List<RecipeModel> recipeListMain = [];
