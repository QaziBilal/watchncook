import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:watchncook/src/models/model_recipe.dart';
import 'package:watchncook/src/widgets/update_dialog.dart';

class FirebaseWork {
  Future checkForUpdates(context) async {
    int firestoreVersion = await getAppVersionFromFirebaseFirestore();
    // print("firestore version = $firestoreVersion");
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    // print("version is $version");
    List versionComponents = version.split('.');
    int appVersion = int.parse(versionComponents[0]);
    if (appVersion < firestoreVersion) {
      // print("Update Needed");
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return ShowUpdateDialog();
        },
      );
    }
  }

  Future getAppVersionFromFirebaseFirestore() async {
    try {
      DocumentSnapshot versionsnapShot = await FirebaseFirestore.instance
          .collection("appUpdate")
          .doc("version")
          .get();
      if (versionsnapShot.exists) {
        return versionsnapShot["versioncode"];
      }
    } catch (e) {
      print("Error firebase firestore version : $e");
    }
  }

  // Fetch data from Firebase Firestore
  Future<List<RecipeModel>> fetchRecipesFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('recipe').get();

      List<RecipeModel> recipes = querySnapshot.docs.map((doc) {
        // Map Firestore document data to your RecipeModel
        return RecipeModel.fromFirestore(doc.data() as Map<String, dynamic>?);
      }).toList();

      return recipes;
    } catch (e) {
      // Handle any potential errors during Firestore fetch
      print('Error fetching recipes: $e');
      return []; // Return an empty list or handle error accordingly
    }
  }

  Future<List> fetchTagsFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('categories').get();
      List tags = querySnapshot.docs.map((tag) {
        return tag['categoryName'] as String;
      }).toList();
      return tags;
    } catch (e) {
      print("Error Fetching Tags: $e");
      return [];
    }
  }

  Future<List<RecipeModel>> fetchRecipesByCategory(String category) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('recipe') // Replace with your actual collection name
              .where('category', isEqualTo: category)
              .get();

      // Extract the data from the documents
      List<RecipeModel> recipes = querySnapshot.docs.map((doc) {
        // Map Firestore document data to your RecipeModel
        return RecipeModel.fromFirestore(doc.data());
      }).toList();

      return recipes;
    } catch (e) {
      print("Error fetching recipes: $e");
      return [];
    }
  }

  Future<void> addToFavorites(String recipeName) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Reference to the collection of favorite recipes
        CollectionReference favoritesCollection =
            FirebaseFirestore.instance.collection('favorites');

        await favoritesCollection
            .add({'userId': user.uid, 'recipeName': recipeName});

        print("Added to favorites for user ${user.uid}");
      } else {
        print("User not signed in");
      }
    } catch (e) {
      print("Error adding to favorites: $e");
    }
  }
}
