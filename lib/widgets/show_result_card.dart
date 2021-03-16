//libraries
import 'package:flutter/material.dart';
//packages
import 'package:google_fonts/google_fonts.dart';
//screens
import '../screens/details_screen/details_screen.dart';

class ShowResultCard extends StatelessWidget {
  const ShowResultCard({
    Key key,
    @required bool loading1,
    @required this.animeName,
    @required this.animeRelease,
    @required this.animeLink,
    @required this.animePoster,
    @required this.index,
  })  : _loading1 = loading1,
        super(key: key);

  final bool _loading1;
  final String animeName;
  final String animeRelease;
  final String animeLink;
  final String animePoster;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _loading1
          ? () {}
          : () {
              Navigator.pushNamed(context, DetailsScreen.routeName,
                  arguments: [animeName, animeRelease, animeLink, animePoster]);
            },
      child: Row(children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[300],
              ),
              borderRadius: const BorderRadius.all(const Radius.circular(20))),
          margin: const EdgeInsets.only(left: 16, top: 16),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(const Radius.circular(20)),
            child: _loading1
                ? Container(
                    //will use this container for shimmering effect
                    height: 130,
                    width: 90,
                    child: Container(
                      color: Colors.grey,
                    ),
                  )
                : Image.network(
                    animePoster,
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
                borderRadius: const BorderRadius.only(
                    topRight: const Radius.circular(20),
                    bottomRight: const Radius.circular(20))),
            margin: const EdgeInsets.only(right: 16, top: 16),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(const Radius.circular(20)),
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
                              child: Text(_loading1 ? '' : animeName,
                                  style: GoogleFonts.montserrat(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400)),
                            )
                          ],
                        )),
                    const SizedBox(
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
                          Text(_loading1 ? '' : animeRelease,
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
