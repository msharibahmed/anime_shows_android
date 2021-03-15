import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../provider/http_calls.dart';

class VideosTab extends StatelessWidget {
  final String titleName;
  VideosTab(this.titleName);
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<HttpCalls>(context).searcDetailsModel;
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Text('Episode: ' + (index + 1).toString(),
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.bold,
            )),
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                    title: Text('Choose Below'),
                    actions: [
                      TextButton(
                          child: Icon(Icons.slow_motion_video),
                          onPressed: () async {
                            Navigator.pop(context);
                            print(titleName + index.toString());
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
                                        title: Text('choose one of the links:'),
                                        content: VideoLinks(
                                            episodeEndPoint: titleName +
                                                "-episode-" +
                                                (index + 1).toString(),
                                            webViewBool: false)));
                          }),
                      TextButton(
                        child: Icon(Icons.download_sharp),
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
                                      title: Text('choose one of the links:'),
                                      content: VideoLinks(
                                          episodeEndPoint: titleName +
                                              "-episode-" +
                                              (index + 1).toString(),
                                          webViewBool: true)));
                        },
                      )
                    ],
                  ));
        },
      ),
      itemCount: data.totalEpisode == '' ? 0 : int.parse(data.totalEpisode),
    );
  }
}

class VideoLinks extends StatefulWidget {
  final String episodeEndPoint;
  final bool webViewBool;
  VideoLinks({@required this.episodeEndPoint, @required this.webViewBool});

  @override
  _VideoLinksState createState() => _VideoLinksState();
}

class _VideoLinksState extends State<VideoLinks> {
  var _didChangeBool = true;
  var _loading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didChangeBool) {
      Provider.of<HttpCalls>(context)
          .showEpisodelinks(widget.episodeEndPoint)
          .then((_) {
        setState(() {
          _loading = false;
        });
      });
    }
    _didChangeBool = false;
  }

  var playStoreUrlFreeVersion =
      'https://play.google.com/store/apps/details?id=com.mxtech.videoplayer.ad&hl=en_IN&gl=US';
  var playStorePaidVersion =
      'https://play.google.com/store/apps/details?id=com.mxtech.videoplayer.pro&hl=en_IN&gl=US';

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  _episodeLinkOnTap(int index) async {
    final prov = Provider.of<HttpCalls>(context, listen: false).episodeLinks;

    bool freeIsInstalled =
        await DeviceApps.isAppInstalled('com.mxtech.videoplayer.ad');

    bool paidIsInstalled =
        await DeviceApps.isAppInstalled(' com.mxtech.videoplayer.pro');

    print("freeVersionMXPlayer: " +
        freeIsInstalled.toString() +
        ", " +
        "PaidVersionMXPlayer: " +
        paidIsInstalled.toString());

    freeIsInstalled
        ? _launchURL(
            prov[index].link,
          )
        : _launchURL(
            playStoreUrlFreeVersion,
          );
  }

  _downloadURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<HttpCalls>(context, listen: false).episodeLinks;
    return _loading
        ? CircularProgressIndicator(
            backgroundColor: Colors.black,
          )
        : prov.length == 0
            ? Center(child: Text('Sorry, zero links for this video'))
            : Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.5,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ListTile(
                          onTap: widget.webViewBool
                              ? () {
                                  _downloadURL(prov[index].link);
                                }
                              : () {
                                  _episodeLinkOnTap(index);
                                },
                          title: Text(prov[index].quality),
                        ),
                    itemCount: prov.length),
              );
  }
}
