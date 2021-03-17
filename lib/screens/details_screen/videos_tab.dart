//libraries
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//packages
import 'package:device_apps/device_apps.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
//widgets
//provider
import '../../provider/http_calls.dart';

class VideosTab extends StatelessWidget {
  final String titleName;
  VideosTab(this.titleName);
  Widget _animeEpisodeOnTap(
      {BuildContext context, int index, bool download, IconData icon}) {
    //download is false if user wants to download the anime episode
    return TextButton(
        child: Icon(icon),
        onPressed: () async {
          Navigator.pop(context);
          print(titleName + index.toString());
          await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    scrollable: true,
                    title: Text('choose one of the links:'),
                    content: VideoLinks(
                        episodeEndPoint:
                            titleName + "-episode-" + (index + 1).toString(),
                        download: download),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('close'))
                    ],
                  ));
        });
  }

  @override
  Widget build(BuildContext context) {
    final searchDetailsModel =
        Provider.of<HttpCalls>(context, listen: false).searcDetailsModel;
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
                      _animeEpisodeOnTap(
                          context: context,
                          index: index,
                          download: false,
                          icon: Icons.slow_motion_video),
                      _animeEpisodeOnTap(
                          context: context,
                          index: index,
                          download: true,
                          icon: Icons.download_sharp),
                    ],
                  ));
        },
      ),
      itemCount: searchDetailsModel.totalEpisode == ''
          ? 0
          : int.parse(searchDetailsModel.totalEpisode),
    );
  }
}

class VideoLinks extends StatefulWidget {
  final String episodeEndPoint;
  final bool download;
  VideoLinks({@required this.episodeEndPoint, @required this.download});

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

  _episodeStreamOnTap(int index) async {
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

  void _episodeDownloadOnTap(String url) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final externalDir = await getExternalStorageDirectory();
      final id = await FlutterDownloader.enqueue(
          url: url,
          savedDir: externalDir.path,
          showNotification: true,
          fileName: widget.episodeEndPoint,
          openFileFromNotification: true);
    } else {
      print('Storage Read/Write Permission denied.');
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final episodeLinks =
        Provider.of<HttpCalls>(context, listen: false).episodeLinks;
    return _loading
        ? Center(
            child: Text('Be patient, fetching links...'),
          )
        : episodeLinks.length == 0
            ? const Center(
                child: const Text(
                    'Sorry, zero links for this video or server issue!'))
            : Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ListTile(
                          title: Text(episodeLinks[index].quality),
                          leading: Text((index + 1).toString() + '.'),
                          onTap: widget.download
                              ? () {
                                  _episodeDownloadOnTap(
                                      episodeLinks[index].link);
                                }
                              : () {
                                  _episodeStreamOnTap(index);
                                },
                        ),
                    itemCount: episodeLinks.length),
              );
  }
}
