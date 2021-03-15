import 'dart:convert';

import '../model/episode_links_model.dart';
import '../model/search_details_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../model/latest_model.dart';
import '../model/search_result_model.dart';

class HttpCalls with ChangeNotifier {
  List<LatestModel> _latestRelease = [];

  List<SearchResultModel> _searchResult = [];

  SearchDetailsModel _searchDetailsModel;

  List<EpisodeLinksModel> _episodeLinks = [];

  List<EpisodeLinksModel> get episodeLinks {
    return [..._episodeLinks];
  }

  List<LatestModel> get latestRelaease {
    return [..._latestRelease];
  }

  SearchDetailsModel get searcDetailsModel {
    return _searchDetailsModel;
  }

  List<SearchResultModel> get searchResult {
    return [..._searchResult];
  }

  void searchDetailsClear() {
    _searchDetailsModel = null;
    // notifyListeners();
  }

  Future<void> showEpisodelinks(String episodeEndPoint) async {
    final url = 'https://anime-rest-api.herokuapp.com/episode/$episodeEndPoint';
    print(url);

    print('function executed');
    try {
      final response = await http.get(Uri.parse(url));
      // print(response);

      final _jsonDecode = jsonDecode(response.body);
      // print(_jsonDecode);
      List<EpisodeLinksModel> _loadedData = [];
      _jsonDecode.forEach((element) {
        _loadedData.add(EpisodeLinksModel(
            link: element['link'], quality: element['quality']));
      });
      _episodeLinks = _loadedData;
      print(_episodeLinks);
    } catch (error) {
      print('error while calling show episode link http call');
      print(error);
    }

    notifyListeners();
  }

  Future<void> showLatestRelease(int page) async {
    final url = 'https://anime-rest-api.herokuapp.com/home/$page';
    print('function executed');
    try {
      final response = await http.get(Uri.parse(url));

      final _jsonDecode = jsonDecode(response.body);
      List<LatestModel> _loadedData = [];
      _jsonDecode.forEach((element) {
        _loadedData.add(LatestModel(
            name: element['name'],
            poster: element['poster'],
            episode: element['episode'],
            link: element['link']));
      });
      _latestRelease = _loadedData;
    } catch (error) {
      print('error while calling show latest release http call');
      print(error);
    }

    notifyListeners();
  }

  Future<void> showSearchDetails(String link) async {
    final url = 'https://anime-rest-api.herokuapp.com/searchdetails/$link';

    print('function executed');
    try {
      final response = await http.get(Uri.parse(url));
      // print(response);

      final _jsonDecode = jsonDecode(response.body)[0];
      print(_jsonDecode);
      final _loadedData = SearchDetailsModel(
          type: _jsonDecode['type'],
          summary: _jsonDecode['summary'],
          genre: _jsonDecode['genre'],
          status: _jsonDecode['status'],
          otherName: _jsonDecode['other'],
          totalEpisode: _jsonDecode['totalEpisode']);

      _searchDetailsModel = _loadedData;
      // print(_searchDetailsModel);
    } catch (error) {
      print('error while calling show search details http call');
      print(error);
    }

    notifyListeners();
  }

  Future<void> showSearchResult(String search) async {
    final url = 'https://anime-rest-api.herokuapp.com/search/$search';

    print('function executed');
    try {
      final response = await http.get(Uri.parse(url));
      // print(response);

      final _jsonDecode = jsonDecode(response.body);
      // print(_jsonDecode);
      if (_jsonDecode[0] != {'status_code': '404'}) {
        List<SearchResultModel> _loadedData = [];
        _jsonDecode.forEach((element) {
          _loadedData.add(SearchResultModel(
              name: element['name'],
              poster: element['poster'],
              release: element['release'],
              link: element['link']));
        });
        _searchResult = _loadedData;
      } else if (_jsonDecode[0] == {'status_code': '404'}) {
        _searchResult.clear();
      }
    } catch (error) {
      print('error while calling show search result http call');
      print(error);
    }

    notifyListeners();
  }
}
