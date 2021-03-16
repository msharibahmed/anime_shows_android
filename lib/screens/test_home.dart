//libraries
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//packages
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
//screens
import 'downloads.dart';
import 'search_result.dart';
//widgets
import '../widgets/latest_release_home.dart';
//provider
import '../provider/http_calls.dart';

class HomeTest extends StatefulWidget {
  @override
  _HomeTestState createState() => _HomeTestState();
}

class _HomeTestState extends State<HomeTest> {
  final ctrl = TextEditingController();

  var page = 1;
  var _boolCheck1 = true;
  var _loading1 = true;
  @override
  void dispose() {
    super.dispose();
    ctrl.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_boolCheck1) {
      print('fetching latest release');
      Provider.of<HttpCalls>(context).showLatestRelease(page).then((_) {
        setState(() {
          _loading1 = false;
        });
      });
    }
    _boolCheck1 = false;
  }

  Widget _searchTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10, right: 10),
      child: TextField(
          controller: ctrl,
          decoration: InputDecoration(
            hintText: 'Search Here',
            prefixIcon: const Icon(CupertinoIcons.search),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.black,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.black,
                )),
          )),
    );
  }

  Widget _searchButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
          onPressed: () {
            if (ctrl.text.isNotEmpty) {
              FocusScope.of(context).unfocus();
              Navigator.pushNamed(context, SearchResult.routeName,
                  arguments: ctrl.text);
            }
          },
          child: const Text('Search'),
        ),
      ),
    );
  }

  Widget _latestReleaseHome() {
    return Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: const Radius.circular(5),
                bottomLeft: const Radius.circular(5)),
          ),
          height: 210,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text('Latest Release(SUB)',
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600, fontSize: 20)),
              ),
              Consumer<HttpCalls>(
                builder: (context, httpCallsObject, _) => _loading1
                    ? const Center(
                        child: const Text('Fetching Data, please wait...'))
                    : Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: LatestReleaseHome(
                                latestRelease:
                                    httpCallsObject.latestRelease[index],
                                lazyLoading:
                                    _loading1), //will use this lazy loading to shimmer effect
                          ),
                          itemCount: httpCallsObject.latestRelease.length,
                        ),
                      ),
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: Image.asset('android/app/src/main/res/drawable/icon.png'),
        title: Text(
          'Stream/Download Anime',
          style: GoogleFonts.montserrat(),
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, DownloadScreen.routeName);
          },
          child: const Icon(Icons.file_download)),
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_searchTextField(), _searchButton(), _latestReleaseHome()],
        ),
      ),
    ));
  }
}
