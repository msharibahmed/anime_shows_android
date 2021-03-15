import 'package:anime_shows_android/provider/http_calls.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'information_tab.dart';
import 'videos_tab.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName = 'details-screen';
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<HttpCalls>(context, listen: false);
    // final data1 = Provider.of<HttpCalls>(context,);
    final args = ModalRoute.of(context).settings.arguments as List;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            leading: Consumer<HttpCalls>(
              builder: (context, snap, _) => IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  snap.searchDetailsClear();
                  Navigator.pop(context);
                },
              ),
            ),
            backgroundColor: Colors.black,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'Information'),
                Tab(text: 'Videos'),
              ],
            ),
            title: Text(args[0]),
          ),
          body: TabBarView(
              children: [
                FutureBuilder(
                    future: data.showSearchDetails(args[2]),
                    builder: (context, snapshot) =>
                        snapshot.connectionState == ConnectionState.done
                            ? InformationTab(
                                name: args[0],
                                release: args[1],
                                link: args[2],
                                poster: args[3])
                            : Center(
                                child: CircularProgressIndicator(),
                              )),
                              Consumer<HttpCalls>(builder: (context,snap,_)=> 
                              data.searcDetailsModel == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : VideosTab(args[2]),)
             
              ],
            ),
          ),
    );
  }
}