import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/network_model.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';

class Networks extends StatelessWidget {
  final List<Network> networks;
  final double width;

  const Networks({Key? key, required this.networks, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Text(
            "Disponivel em:",
            style: StyleFont.bold.copyWith(color: Pallete.white, fontSize: 24),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: width,
          height: 50.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: networks.length,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            itemBuilder: (BuildContext context, int index) {
              final network = networks[index];
              return Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Pallete.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://image.tmdb.org/t/p/w500${network.logoPath}",
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        color: Pallete.white,
                        size: 24,
                      ),
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.contain),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
