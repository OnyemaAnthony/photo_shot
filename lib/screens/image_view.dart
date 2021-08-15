import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageView extends StatefulWidget {
  final String? imageUrl;

  const ImageView({Key? key, this.imageUrl}) : super(key: key);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.imageUrl!,
            child: Container(
              height: screenSize.height,
              width: screenSize.width,
              alignment: Alignment.bottomCenter,
              child: CachedNetworkImage(
                imageUrl: widget.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    savePhoto();
                  
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: screenSize.width / 2,
                        height: 50,
                        color: Color(0XFF1C1B1B).withOpacity(0.8),
                      ),
                      Container(
                        width: screenSize.width / 2,
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white60, width: 1),
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(colors: [
                              Color(0X36FFFFFF),
                              Color(0X0FFFFFFF),
                            ])),
                        child: Column(
                          children: [
                            Text(
                              'Download Image',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Image will be saved to your gallery',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  _askPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,

    ].request();

  }


  savePhoto() async {
    await _askPermission();
    var response = await Dio().get(widget.imageUrl!,
        options: Options(responseType: ResponseType.bytes));
    final result =
    await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }
}
