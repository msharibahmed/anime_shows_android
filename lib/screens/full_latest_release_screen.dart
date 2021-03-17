import 'package:anime_shows_android/widgets/latest_release_card.dart';
import 'package:flutter/material.dart';

class FullLatestRelease extends StatelessWidget {
  static const routeName = 'full-lastest-release-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
              itemBuilder: (context, index) => LatestReleaseCard(index, false)),
          Positioned(
            bottom: 0,
            child: Row(
              children: [
                const SizedBox(width: 10),
                ElevatedButton(onPressed: () {}, child: const Text('Previous')),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: () {}, child: Text('1')),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Next'),
                ),
                const SizedBox(width: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
