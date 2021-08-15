import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:photo_shot/models/photo_model.dart';
import 'package:photo_shot/utilities/utilities.dart';
import 'package:photo_shot/widgets/app_bar.dart';
import 'package:http/http.dart'as http;
import 'package:photo_shot/widgets/photos_list.dart';

class SearchScreen extends StatefulWidget {
  final String? searchQuery;

  const SearchScreen({
    Key? key,
    this.searchQuery,
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  List<PhotoModel> photos = [];


  fetchSearchPhotos(String text) async {
    var response = await http.get(
      Uri.parse('https://api.pexels.com/v1/search?query=${text}'),
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
    fetchSearchPhotos(widget.searchQuery!);
    super.initState();
    searchController.text = widget.searchQuery!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            hintText: 'Search Photos', border: InputBorder.none),
                      ),
                    ),
                    GestureDetector(
                      onTap: ()async {
                        fetchSearchPhotos(searchController.text);
                      },
                      child: Icon(
                        Icons.search,
                      ),
                    ),
                  ],
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
