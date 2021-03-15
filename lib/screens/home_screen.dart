import '../screens/search_result.dart';
import '../widgets/latest_release_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../provider/http_calls.dart';

class Home extends StatefulWidget {
  static const routeName = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var page = 1;
  var _boolCheck1 = true;
  var _loading1 = true;
  final ctrl = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    ctrl.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_boolCheck1) {
      print('did change dependices');
      Provider.of<HttpCalls>(context).showLatestRelease(page).then((_) {
        setState(() {
          _loading1 = false;
        });
      });
    }
    _boolCheck1 = false;
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<HttpCalls>(context, listen: false).latestRelaease;
    // final data1 = Provider.of<HttpCalls>(context);
    final mediaQueryH = MediaQuery.of(context).size.height;
    // print(data1.showLatestRelease('1'));

    return  Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
                      child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: ctrl.text.length > 0
                        ? mediaQueryH * 0.235
                        : mediaQueryH * 0.170,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: TextField(
                              controller: ctrl,
                              decoration: InputDecoration(
                                hintText: 'search here',
                                prefixIcon: Icon(Icons.search),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                              )),
                        ),
                        if (ctrl.text.length > 0)
                          Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: ElevatedButton(
                                  //color: Colors.black,
                                  onPressed: () {
                                    if (ctrl.text.isNotEmpty) {
                                      FocusScope.of(context).unfocus();
                                      Navigator.pushNamed(
                                          context, SearchResult.routeName,
                                          arguments: ctrl.text);
                                    }
                                  },
                                  child: Text(
                                    'Search',
                                    style:
                                        GoogleFonts.openSans(color: Colors.white),
                                  ),
                                  //shape: RoundedRectangleBorder(
                                    //  borderRadius: BorderRadius.circular(10)),
                                ),
                              )),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('Latest Release',
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Container(
                      height: ctrl.text.length > 0
                          ? mediaQueryH * 0.682
                          : mediaQueryH * 0.747,
                      child: Stack(
                        children: [
                          _loading1
                              ? Shimmer.fromColors(
                                  baseColor: Colors.grey[400],
                                  highlightColor: Colors.grey[200],
                                  child: ListView.builder(
                                    itemBuilder: (context, index) => ReuseCard(
                                        loading1: _loading1,
                                        text1: '',
                                        text2: '',
                                        poster: '',
                                        link: '',
                                        index: index),
                                    itemCount: 15,
                                  ),
                                )
                              : ListView.builder(
                                  itemBuilder: (context, index) =>
                                      LatestReleaseCard(index, _loading1),
                                  itemCount: data.length,
                                ),
                          Positioned(
                            bottom: 0,
                            left: MediaQuery.of(context).size.width*0.2,
                            

                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  PaginationButton(
                                      'Previous',
                                      page == 1
                                          ? () {}
                                          : () {
                                              setState(() {
                                                page -= page;
                                                _boolCheck1 = true;
                                                _loading1 = true;
                                              });
                                            }),
                                  PaginationButton(page.toString(), () {}),
                                  PaginationButton('   Next   ', () {
                                    setState(() {
                                      page += page;
                                      _boolCheck1 = true;
                                      _loading1 = true;
                                    });
                                  })
                                ]),
                          )
                        ],
                      )),
                  // SizedBox(height: 10),
                ],
              ),
            ),
          ),
    );
  }
}

class PaginationButton extends StatelessWidget {
  final String text;
  final Function func;
  PaginationButton(this.text, this.func);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: func,
        child: Card(

          color: Colors.black,
          elevation: 5,
          shadowColor: Colors.green,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text,style: GoogleFonts.openSans(color: Colors.white,)
          ),
        )));
  }
}