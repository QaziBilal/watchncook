import 'package:flutter/material.dart';
import 'package:watchncook/src/firebase/app_update.dart';
import 'package:watchncook/src/helper/constants.dart';
import 'package:watchncook/src/helper/sizedbox_extenstion.dart';
import 'package:watchncook/src/models/model_recipe.dart';
import 'package:watchncook/src/widgets/custom_text.dart';

// ignore: must_be_immutable
class DetailRecipeScreen extends StatelessWidget {
  RecipeModel recipeModel;
  DetailRecipeScreen({required this.recipeModel, super.key});

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.sizeOf(context).width;
    double sh = MediaQuery.sizeOf(context).height;
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          elevation: 0,
          pinned: true,
          backgroundColor: AppColors.mainColor,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white,
              ),
              width: double.maxFinite,
              padding: const EdgeInsets.only(top: 10, bottom: 0),
              child: Center(
                child: customText(context, recipeModel.name,
                    color: AppColors.black,
                    size: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.white),
                  width: sw * 0.1,
                  height: sh * 0.045,
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    size: 25,
                  ),
                ),
              ),
              Container(
                  width: sw * 0.1,
                  height: sh * 0.045,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.white),
                  child: const Icon(Icons.share)),
            ],
          ),
          expandedHeight: sh * 0.5,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              recipeModel.imageUrl,
              width: double.maxFinite,
              height: sh * 0.5,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: customText(context, recipeModel.description,
                        color: AppColors.black,
                        size: 16,
                        textAlign: TextAlign.justify),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        size: 25,
                        color: Color(0xffFFB400),
                      ),
                      customText(context, "4.9 (12)", color: AppColors.black),
                    ],
                  ),
                  10.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () async {
                          print("Button Clikced");
                          await FirebaseWork().addToFavorites(recipeModel.name);
                          print("Data Added into Firebase");
                        },
                        child: Column(
                          children: [
                            const Icon(
                              Icons.favorite_border,
                              size: 25,
                            ),
                            15.height,
                            customText(context, "Add To Favourite",
                                color: AppColors.black),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => RateRecipeScreen(
                          //               id: widget.id,
                          //             )));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Color(0xffFFB400),
                              size: 25,
                            ),
                            customText(context, "Rate Recipe",
                                color: AppColors.black),
                          ],
                        ),
                      ),
                    ],
                  ),
                  10.height,
                  Container(
                    width: sw * 0.8,
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.mainColor)),
                    child: customText(context, "Ingredients",
                        color: AppColors.black, size: 18),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: recipeModel.ingredients.length,
                      itemBuilder: (context, index) {
                        String ingredients = recipeModel.ingredients[index];
                        return ListTile(
                          title: Row(
                            children: [
                              const CircleAvatar(
                                  radius: 6, backgroundColor: Colors.green),
                              8.width,
                              Flexible(
                                child: customText(context, ingredients,
                                    color: AppColors.black,
                                    size: 16,
                                    textAlign: TextAlign.left),
                              )
                            ],
                          ),
                          // trailing: customText(context, "Gram",
                          //     color: AppColors.black, size: 14)
                        );
                      }),
                  12.height,
                  const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Divider()),
                  12.height,
                  Container(
                    width: sw * 0.8,
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.mainColor)),
                    child: customText(context, "Steps of Recipe",
                        color: AppColors.black, size: 18),
                  ),
                  12.height,
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: recipeModel.steps.length,
                    itemBuilder: (context, index) {
                      String step = recipeModel.steps[index];
                      return Container(
                        padding: const EdgeInsets.only(left: 24, right: 46),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Step ${index + 1}",
                              style: const TextStyle(),
                            ),
                            4.height,
                            Text(
                              step,
                              style: const TextStyle(),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Divider());
                    },
                  ),
                  30.height
                ]),
          ),
        ),
      ],
    ));
  }
}

