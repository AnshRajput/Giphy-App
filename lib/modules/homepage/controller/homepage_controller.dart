import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giphyapp/data/models/giphy_search_model.dart';
import 'package:giphyapp/data/models/giphy_trending_model.dart';
import 'package:giphyapp/data/repositories/giphy_repository.dart';

class HomePageController extends GetxController {
  var isLoading = true.obs;
  var isPaginationLoading = false.obs;
  var isSearching = false.obs;
  TextEditingController searchtextController = TextEditingController();
  var searchPageNo = 0.obs;
  var trendingPageNo = 0.obs;
  GiphyRepository giphyRepository = GiphyRepository();
  Rx<GiphySearchModel> giphySearchModelData = GiphySearchModel().obs;
  Rx<GiphyTrendingModel> giphyTrendingdata = GiphyTrendingModel().obs;
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  gettrendingGiphyList() async {
    isLoading.value = true;
    giphyTrendingdata.value = await giphyRepository.getTrendingList(0);
    isLoading.value = false;
  }

  searchGiphyList(String keyword) async {
    isLoading.value = true;
    giphySearchModelData.value = await giphyRepository.getGiphyList(keyword, 0);
    isLoading.value = false;
  }

  getTrendingpaginationData(pageNo) async {
    isPaginationLoading.value = true;

    trendingPageNo.value = pageNo;
    GiphyTrendingModel data = await giphyRepository.getTrendingList(pageNo);
    giphyTrendingdata.value.data!.addAll(data.data!);
    giphyTrendingdata.refresh();
    isPaginationLoading.value = false;
  }

  getSearchpaginationData(pageNo) async {
    isPaginationLoading.value = true;

    searchPageNo.value = pageNo;
    GiphySearchModel data =
        await giphyRepository.getGiphyList(searchtextController.text, pageNo);

    giphySearchModelData.value.data!.addAll(data.data!);

    giphySearchModelData.refresh();
    isPaginationLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    gettrendingGiphyList();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        isSearching.value
            ? getSearchpaginationData(searchPageNo.value + 10)
            : getTrendingpaginationData(trendingPageNo.value + 10);
      }
    });
  }
}
