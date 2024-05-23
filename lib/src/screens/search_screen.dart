// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:watchncook/src/helper/constants.dart';
import 'package:watchncook/src/helper/sizedbox_extenstion.dart';
import 'package:watchncook/src/models/model_recipe.dart';
import 'package:watchncook/src/screens/detail_recipe_screen.dart';
import 'package:watchncook/src/screens/home_screen.dart';
import 'package:watchncook/src/widgets/custom_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<RecipeModel> _searchList = [];
  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onsearchChanged);
  }

  _onsearchChanged() {
    // print("Search Text: ${_searchController.text}");
    searchResult();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onsearchChanged);
    _searchController.dispose();

    super.dispose();
  }

  searchResult() {
    List<RecipeModel> searchList = [];

    if (_searchController.text != "") {
      for (RecipeModel reci in recipeListMain) {
        String name = reci.name;
        // print("name = $name");
        if (name.toLowerCase().contains(_searchController.text.toLowerCase())) {
          searchList.add(reci);
        }
      }
    } else {}
    setState(() {
      _searchList = searchList;
    });
  }

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.sizeOf(context).width;
    double sh = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: AppColors.black.withOpacity(0.02),
                      borderRadius: BorderRadius.circular(50),
                      border:
                          Border.all(color: AppColors.black.withOpacity(0.1))),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                        hintText: "Search Recipe...",
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search_outlined)),
                  )),
              20.height,
              ListView.builder(
                  padding: EdgeInsets.only(
                      left: sw * 0.05, right: sw * 0.05, bottom: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _searchList.length,
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
                              _searchList[index].imageUrl,
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
                                      customText(context,
                                          _searchList[index].cookingTime,
                                          size: 12),
                                    ],
                                  ),
                                )),
                            Align(
                              alignment: Alignment.center,
                              child: customText(
                                  context, _searchList[index].name,
                                  size: 24),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
