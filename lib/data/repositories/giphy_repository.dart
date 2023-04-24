import 'dart:convert';

import 'package:giphyapp/data/models/giphy_search_model.dart';
import 'package:giphyapp/data/models/giphy_trending_model.dart';

import 'package:giphyapp/utils/api/api_service.dart';
import 'package:giphyapp/utils/constants.dart';

class GiphyRepository {
  Future<GiphySearchModel> getGiphyList(String keyword, scroll) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Type": "APP",
    };

    Map<String, dynamic> queryParams = {
      "api_key": Constants.giphyApiKey,
      "q": keyword,
      "limit": "10",
      "offset": scroll.toString(),
      "rating": "r",
      "lang": "en",
    };
    var response = await APIService.getApi("/search", headers, queryParams);

    return GiphySearchModel.fromJson(jsonDecode(response.body));
  }

  Future<GiphyTrendingModel> getTrendingList(scroll) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Type": "APP",
    };

    Map<String, dynamic> queryParams = {
      "api_key": Constants.giphyApiKey,
      "limit": "10",
      "rating": "r",
      "offset": scroll.toString(),
    };
    var response = await APIService.getApi("/trending", headers, queryParams);

    return GiphyTrendingModel.fromJson(jsonDecode(response.body));
  }
}
