import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageNetwork{
  Widget networkImage(String imageUrl){
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage, // Use a transparent image as a placeholder
      image: imageUrl, // Replace with your actual image URL
      fit: BoxFit.cover, // Adjust the fit as needed
      // Set the desired height
      imageErrorBuilder: (context, error, stackTrace) {
        // Handle image loading errors here, e.g., display an error message or a fallback image
        return Image.asset(
          'assets/light_bg.png', // Replace with the path to your error/fallback image
          fit: BoxFit.cover,

        );
      },
    );

  }
}