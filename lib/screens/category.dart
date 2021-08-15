import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:photo_shot/models/photo_model.dart';
import 'package:photo_shot/utilities/utilities.dart';
import 'package:http/http.dart' as http;

class Category extends StatefulWidget {
  final String? categoryName;

  const Category({Key? key, this.categoryName}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<PhotoModel> photos = [];

  fetchSearchPhotos(String text) async {
    var response = await http.get(
      Uri.parse('https://api.pexels.com/v1/search?query=$text'),
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
    fetchSearchPhotos(widget.categoryName!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
