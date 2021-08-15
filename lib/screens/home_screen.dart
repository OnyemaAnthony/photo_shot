import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:photo_shot/data/data.dart';
import 'package:photo_shot/models/category_model.dart';
import 'package:photo_shot/models/photo_model.dart';
import 'package:photo_shot/screens/search.dart';
import 'package:photo_shot/utilities/utilities.dart';
import 'package:photo_shot/widgets/app_bar.dart';
import 'package:photo_shot/widgets/category_list.dart';
import 'package:http/http.dart' as http;
import 'package:photo_shot/widgets/photos_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  List<CategoryModel> categories = [];
  List<PhotoModel> photos = [];

  getTrendingPhotos() async {
    var response = await http.get(
      Uri.parse('https://api.pexels.com/v1/curated'),
      headers: {
        'Authorization': Utilities.API_KEY,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> pixelsData = jsonDecode(response.body);
      pixelsData['photos'].forEach((data) {
        PhotoModel photo = PhotoModel();
        photo = PhotoModel.fromMap(data);
        photos.add(photo);
      });
      setState(() {});
    }
  }

  @override
  void initState() {
    getTrendingPhotos();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: ApBar(),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0XFFF5F8FD),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: 'Search Photos',
                            border: InputBorder.none),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SearchScreen(searchQuery: searchController.text,),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.search,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 80,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return CategoryList(
                      title: category.categoryName,
                      imageUrl: category.imageUrl,
                    );
                  },
                ),
              ),
              PhotosList(
                photos: photos,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
