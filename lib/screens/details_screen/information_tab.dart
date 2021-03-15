import 'package:anime_shows_android/provider/http_calls.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InformationTab extends StatefulWidget {
  final String name;
  final String release;
  final String link;
  final String poster;
  InformationTab(
      {@required this.name,
      @required this.release,
      @required this.link,
      @required this.poster});
  @override
  _InformationTabState createState() => _InformationTabState();
}

class _InformationTabState extends State<InformationTab> {
  // var _didChangeBool = true;
  // var _loadingBool = true;
  // @override
  // void didChangeDependencies() {
  //   if (_didChangeBool) {
  //     Provider.of<HttpCalls>(context, listen: false)
  //         .showSearchDetails(widget.link)
  //         .then((_) {
  //       setState(() {
  //         _loadingBool = false;
  //       });
  //     });
  //   }
  //   _didChangeBool = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final data = Provider.of<HttpCalls>(context).searcDetailsModel;
    return
    //  _loadingBool
    //     ? Center(child: CircularProgressIndicator())
    //     :
         SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      widget.poster,
                      fit: BoxFit.fitHeight,
                      width: mq.width * 0.5,
                      height: mq.height * 0.5,
                    ),
                    Container(
                      width: mq.width * 0.5,
                      height: mq.height * 0.5,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InformationRowReuse(
                                category: 'Type: ', value: data.type),
                            const SizedBox(
                              height: 2,
                            ),
                            InformationRowReuse(
                                category: 'Genre: ', value: data.genre),
                            const SizedBox(
                              height: 2,
                            ),
                            InformationRowReuse(
                                category: 'Status: ', value: data.status),
                            const SizedBox(
                              height: 2,
                            ),
                            InformationRowReuse(
                                category: 'Other Name: ',
                                value: data.otherName==''?'None':data.otherName),
                            const SizedBox(
                              height: 2,
                            ),
                            InformationRowReuse(
                                category: 'Release: ', value: widget.release),
                            const SizedBox(
                              height: 2,
                            ),
                            InformationRowReuse(
                                category: 'Total Episodes: ', value: data.totalEpisode),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Summary: ',
                    style: GoogleFonts.montserrat(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,bottom: 10),
                  child: Text(
                    data.summary,
                    style: GoogleFonts.montserrat(
                        fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          );
  }
}

class InformationRowReuse extends StatelessWidget {
  final String category;
  final String value;

  const InformationRowReuse({this.category, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              category,
              style: GoogleFonts.montserrat(
                  fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(value,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400, color: Colors.grey[600])),
          ),
        ],
      ),
    );
  }
}