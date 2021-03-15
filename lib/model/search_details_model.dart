import 'package:flutter/foundation.dart';

class SearchDetailsModel {
  final String type;
  final String summary;
  final String genre;
  final String otherName;
  final String status;
  final String totalEpisode;
  SearchDetailsModel(
      {@required this.type,
      @required this.summary,
      @required this.status,
      @required this.genre,
      @required this.otherName,
      @required this.totalEpisode
      });
}