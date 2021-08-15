import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_shot/screens/category.dart';
import 'package:photo_shot/screens/image_view.dart';

class CategoryList extends StatelessWidget {
  final String? imageUrl;
  final String? title;

  const CategoryList({
    Key? key,
    this.imageUrl,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => Category(
              categoryName: title!.toLowerCase(),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 4),
        child: Stack(
          children: [
            Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl!,
                    height: 50,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(16),
              ),
              height: 50,
              width: 100,
              child: Text(
                title!,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
