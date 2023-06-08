import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/utils/values_manager.dart';
import '../../../domain/entities/image.dart';
import '../image_viewer_page.dart';

class GeneratedImageWidget extends StatelessWidget {
  final ImageModel imageGenerationModelData;
  const GeneratedImageWidget({Key? key, required this.imageGenerationModelData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: imageGenerationModelData.imageUrl.length,
      itemBuilder: (context, index) {
        final generatedImage = imageGenerationModelData.imageUrl[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ImageViewerPage(
                        imageUrl: generatedImage.url,
                      ),
                    );
                  },
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl: generatedImage.url,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    SizedBox(
                  height: AppSize.s150,
                  width: AppSize.s150,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.withOpacity(.3),
                    highlightColor: Colors.grey,
                    child: Container(
                      height: AppSize.s220,
                      width: AppSize.s130,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        );
      },
    );
  }
}
