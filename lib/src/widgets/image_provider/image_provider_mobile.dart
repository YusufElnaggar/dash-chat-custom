import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

ImageProvider getImageProvider(String url, {Uint8List? fileBytes, Map<String, String>? headers}) {
  if (fileBytes != null) {
    return MemoryImage(fileBytes); // bytes (Flutter Web/Desktop)
  } else if (url.startsWith('http') || url.startsWith('blob')) {
    return CachedNetworkImageProvider(url, headers: headers);
  } else if (url.startsWith('assets')) {
    return AssetImage(url);
  } else {
    return FileImage(
      File(url),
    );
  }
}
