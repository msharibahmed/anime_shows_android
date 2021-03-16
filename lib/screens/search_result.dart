//libraries
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
//packages
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
//widgets
import '../widgets/show_result_card.dart';
//provider
import '../provider/http_calls.dart';

class SearchResult extends StatefulWidget {
  static const routeName = 'search-result-screen';

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  var _loading1 = true;
  var _boolCheck1 = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_boolCheck1) {
      final search = ModalRoute.of(context).settings.arguments as String;

      Provider.of<HttpCalls>(context).showSearchResult(search).then((_) {
        setState(() {
          _loading1 = false;
        });
      });
    }
    _boolCheck1 = false;
  }

  @override
  Widget build(BuildContext context) {
    final searchResultList =
        Provider.of<HttpCalls>(context, listen: false).searchResult;
    final args = ModalRoute.of(context).settings.arguments as String;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Showing Results for ' + '"$args"',
            style: GoogleFonts.openSans(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white)),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.88,
                child: _loading1
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[400],
                        highlightColor: Colors.grey[200],
                        child: ListView.builder(
                          itemBuilder: (context, index) => ShowResultCard(
                              index: index,
                              loading1: _loading1,
                              animeName: '',
                              animeRelease: '',
                              animePoster: '',
                              animeLink: ''),
                          itemCount: 15,
                        ),
                      )
                    : searchResultList.length == 0
                        ? Center(
                            child: Image.network(
                                'https://cdn.dribbble.com/users/1242216/screenshots/9326781/media/6384fef8088782664310666d3b7d4bf2.png'),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) => ShowResultCard(
                                index: index,
                                loading1: _loading1,
                                animeName: searchResultList[index].name,
                                animeRelease: searchResultList[index].release,
                                animePoster: searchResultList[index].poster,
                                animeLink: searchResultList[index].link),
                            itemCount: searchResultList.length,
                          )),
          ],
        ),
      ),
    ));
  }
}
