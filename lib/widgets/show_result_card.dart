import 'package:anime_shows_android/screens/details_screen/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowResultCard extends StatelessWidget {
  const ShowResultCard({
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
      onTap:_loading1?(){}: () {
        Navigator.pushNamed(context, DetailsScreen.routeName,
            arguments: [text1, text2, link, poster]);
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
                          Text('Release: ',
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