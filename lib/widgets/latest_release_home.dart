//libraries
import 'package:flutter/material.dart';
//models
import '../model/latest_model.dart';

class LatestReleaseHome extends StatelessWidget {
  final LatestModel latestRelease;
  final bool lazyLoading;
  LatestReleaseHome({this.latestRelease, this.lazyLoading});
  Widget _animePoster() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(const Radius.circular(10)),
      child: Image.network(
        latestRelease.poster,
        fit: BoxFit.contain,
      ),
    );

    // Card(
    //   elevation: 50,
    //   shadowColor: Colors.black,
    //   child: Image.network(
    //     latestRelease.poster,
    //     fit: BoxFit.contain,
    //   ),
    // );
  }

  Widget _animeDetails() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: const BorderRadius.only(
                bottomLeft: const Radius.circular(10),
                bottomRight: const Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                    text: 'Title: ',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 13),
                    children: [
                      TextSpan(
                          text: latestRelease.name,
                          style: const TextStyle(fontWeight: FontWeight.w400))
                    ]),
              ),
              RichText(
                text: TextSpan(
                    text: 'Episode: ',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 13),
                    children: [
                      TextSpan(
                          text: latestRelease.episode,
                          style: const TextStyle(fontWeight: FontWeight.w400))
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _animePoster(),
        _animeDetails(),
      ],
    );
  }
}
