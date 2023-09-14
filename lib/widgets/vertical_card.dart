import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/models/getx_atributes_model.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';

class VerticalCard extends StatelessWidget {
  final int id;
  final String posterPath;
  final String title;
  final double voteAverage;

  const VerticalCard({
    Key? key,
    required this.id,
    required this.posterPath,
    required this.title,
    required this.voteAverage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          'moviedetail',
          arguments: GetxAtributes(id: id, mediaType: "", title: title),
        );
      },
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: width * 0.64,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: "https://image.tmdb.org/t/p/w500$posterPath",
                      placeholder: (context, url) => Container(
                        height: width * 0.64,
                        width: width,
                        decoration: BoxDecoration(
                          color: Pallete.preLoad,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: width * 0.64,
                        width: width,
                        decoration: const BoxDecoration(
                          color: Pallete.preLoad,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.image_outlined,
                            size: 50,
                            color: Pallete.grayLight,
                          ),
                        ),
                      ),
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          width: width,
                          height: width * 0.64,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  height: width * 0.64,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Pallete.transparent20,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    decoration: const BoxDecoration(
                      color: Pallete.yellow,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Text(
                      voteAverage.toStringAsFixed(1),
                      style: StyleFont.bold
                          .copyWith(color: Pallete.grayDark, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
