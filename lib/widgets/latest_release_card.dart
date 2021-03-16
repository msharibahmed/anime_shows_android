import 'package:anime_shows_android/provider/http_calls.dart';
import 'package:anime_shows_android/screens/details_screen/videos_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LatestReleaseCard extends StatelessWidget {
  final int index;
  final bool _loading1;
  LatestReleaseCard(this.index, this._loading1);
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<HttpCalls>(context, listen: false).latestRelease;
    return ReuseCard(
        loading1: _loading1,
        text1: data[index].name,
        link: data[index].link,
        poster: data[index].poster,
        text2: data[index].episode,
        index: index);
  }
}

class ReuseCard extends StatelessWidget {
  const ReuseCard({
    Key key,
    @required bool loading1,
    @required this.text1,
    @required this.text2,
    @required this.poster,
    @required this.link,
    @required this.index,
  })  : _loading1 = loading1,
        super(key: key);

  final bool _loading1;
  final String text1;
  final String text2;
  final String link;
  final String poster;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _loading1
          ? () {}
          : () {
              showDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                        title: Text('Choose Below'),
                        actions: [
                          TextButton(
                              child: Row(
                                children: [
                                  Text(
                                    'Stream Now',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  Icon(Icons.slow_motion_video)
                                ],
                              ),
                              onPressed: () async {
                                print(
                                  link.replaceFirst(
                                      RegExp(r'https://gogoanime.so/'), ''),
                                );
                                Navigator.pop(context);
                                await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('close'))
                                            ],
                                            title: Text(
                                                'choose one of the links:'),
                                            content: VideoLinks(
                                                episodeEndPoint: link.replaceFirst(
                                                    RegExp(
                                                        r'https://gogoanime.so/'),
                                                    ''),
                                                download: false)));
                              }),
                          TextButton(
                            child: Row(
                              children: [
                                Text(
                                  'Download Now',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                Icon(Icons.download_sharp)
                              ],
                            ),
                            onPressed: () async {
                              Navigator.pop(context);
                              await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('close'))
                                          ],
                                          title:
                                              Text('choose one of the links:'),
                                          content: VideoLinks(
                                              episodeEndPoint: link,
                                              download: true)));
                            },
                          )
                        ],
                      ));
            },
      child: Row(children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[300],
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          margin: const EdgeInsets.only(left: 16, top: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: _loading1
                ? Container(
                    height: 130,
                    width: 90,
                    child: Container(
                      color: Colors.grey,
                    ),
                  )
                : Image.network(
                    poster,
                    height: 130,
                    width: 90,
                    fit: BoxFit.fitHeight,
                  ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey[300],
                ),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            margin: const EdgeInsets.only(right: 16, top: 16),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Title: ',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600),
                            ),
                            Expanded(
                              child: Text(_loading1 ? '' : text1,
                                  style: GoogleFonts.montserrat(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400)),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8, left: 8.0, bottom: 8),
                      child: Row(
                        children: [
                          Text('Episode: ',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600)),
                          Text(_loading1 ? '' : text2,
                              style: GoogleFonts.montserrat(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400))
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ),
      ]),
    );
  }
}
