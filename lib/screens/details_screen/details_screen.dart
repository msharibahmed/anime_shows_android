import 'package:anime_shows_android/provider/http_calls.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'information_tab.dart';
import 'videos_tab.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = 'details-screen';

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var _didChange = true;
  var _informationTabLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didChange) {
      final httpCallsObject = Provider.of<HttpCalls>(context, listen: false);
      final args = ModalRoute.of(context).settings.arguments
          as List; //args=[animeName,animeRelease,animeLink,animePoster]
      httpCallsObject.showSearchDetails(args[2]).then((_) {
        setState(() {
          _informationTabLoading = false;
        });
      });
    }
    _didChange = false;
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<HttpCalls>(context, listen: false);
    final args = ModalRoute.of(context).settings.arguments
        as List; //args=[animeName,animeRelease,animeLink,animePoster]
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: Consumer<HttpCalls>(
              builder: (context, snap, _) => IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  snap.searchDetailsClear();
                  Navigator.pop(context);
                },
              ),
            ),
            backgroundColor: Colors.black45,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                const Tab(text: 'Information'),
                const Tab(text: 'Videos'),
              ],
            ),
            title: Text(args[0]),
          ),
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: TabBarView(
              children: [
                _informationTabLoading
                    ? const Center(
                        child: const CircularProgressIndicator(),
                      )
                    : InformationTab(
                        name: args[0],
                        release: args[1],
                        link: args[2],
                        poster: args[3]),
                data.searcDetailsModel == null
                    ? const Center(
                        child: const CircularProgressIndicator(),
                      )
                    : data.searcDetailsModel.totalEpisode == '0'
                        ? const Center(
                            child: const Text('No new Episodes!'),
                          )
                        : VideosTab(args[2])
              ],
            ),
          ),
        ));
  }
}
