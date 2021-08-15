import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  final String? imageUrl;

  const ImageView({Key? key, this.imageUrl}) : super(key: key);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;
    return Stack(
      children: [
        Hero(
          tag: widget.imageUrl!,
          child: Container(
            height: screenSize.height,
            width: screenSize.width,
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl!,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          child:Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0X36FFFFFF),
                      Color(0X0FFFFFFF),
                    ]
                  )
                ),
                child: Column(
                children: [
                  Text('Download Image'),
                  Text('Image will be saved to your gallery'),

                ],
                ),
              ),
              Text('Cancel', style: TextStyle(color: Colors.white),),
            ],
          ),
        ),

      ],
    );
  }
}
