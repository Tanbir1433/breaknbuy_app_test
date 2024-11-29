// import 'package:flutter/material.dart';
//
// class CustomImageNetworkCard extends StatelessWidget {
//   final double? imageHeight;
//   final double? imageWidth;
//   final String imagePath;
//   final BoxFit? boxFit;
//   const CustomImageNetworkCard({super.key, this.imageHeight, this.imageWidth, required this.imagePath, this.boxFit});
//
//   @override
//   Widget build(BuildContext context) {
//     return Image.network(
//       fit: boxFit?? BoxFit.fill,
//       imagePath,
//       height: imageHeight ?? 250,
//       width: imageWidth ?? 250,
//       loadingBuilder: (context, child, progress) {
//         if (progress == null) return child;
//         return CircularProgressIndicator(
//           value: progress.expectedTotalBytes != 0
//               ? progress.cumulativeBytesLoaded / 2
//               : 0,
//         );
//       },
//       errorBuilder: (context, error, stackTrace) {
//         return const Text('N Error');
//       },
//     );
//   }
// }
//
//
//

import 'package:flutter/material.dart';

class CustomImageNetworkCard extends StatelessWidget {
  final double? imageHeight;
  final double? imageWidth;
  final String imagePath;
  final BoxFit? boxFit;

  const CustomImageNetworkCard({
    super.key,
    this.imageHeight,
    this.imageWidth,
    required this.imagePath,
    this.boxFit,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imagePath,
      fit: boxFit ?? BoxFit.fill,
      height: imageHeight ?? 250,
      width: imageWidth ?? 250,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return const Center(
          child: Text('Error image', style: TextStyle(color: Colors.red)),
        );
      },
    );
  }
}
