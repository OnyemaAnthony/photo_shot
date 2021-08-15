import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:photo_shot/models/photo_model.dart';
import 'package:photo_shot/screens/image_view.dart';

class PhotosList extends StatelessWidget {
  final List<PhotoModel>? photos;

  const PhotosList({
    Key? key,
    this.photos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
          crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
        children: photos!.map((photo){
          return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ImageView(
                        imageUrl: photo.src!.portrait,
                      ),
                    ),
                  );
                },

            child: Hero(
              tag: photo.src!.portrait!,
              child: GridTile(
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: photo.src!.portrait!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
