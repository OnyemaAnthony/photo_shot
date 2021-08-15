import 'package:flutter/material.dart';

class PhotoModel {
  String? photographer;
  String? photographer_url;
  int? photographer_id;
  SrcModel? src;

  PhotoModel({
    this.photographer,
    this.photographer_id,
    this.photographer_url,
    this.src,
  });

  factory PhotoModel.fromMap(Map<String, dynamic> pixelData) {
    return PhotoModel(
        src: SrcModel.fromMap(pixelData['src']),
        photographer: pixelData['photographer'],
        photographer_id: pixelData['photographer_id'],
        photographer_url: pixelData['photographer_url']);
  }
}

class SrcModel {
  String? original;
  String? small;
  String? portrait;

  SrcModel({this.original, this.portrait, this.small});

  factory SrcModel.fromMap(Map<String, dynamic> pixelData) {
    return SrcModel(
      portrait: pixelData['portrait'],
      original: pixelData['original'],
      small: pixelData['small'],
    );
  }
}
