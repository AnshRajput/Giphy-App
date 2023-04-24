import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giphyapp/modules/homepage/controller/homepage_controller.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageController homePageController = Get.put(HomePageController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Giphy App"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: homePageController.scrollController,
        child: Column(
          children: [
            //------- Search ----- Bar ------
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search GIF\'s',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  value.isNotEmpty
                      ? homePageController.isSearching.value = true
                      : homePageController.isSearching.value = false;
                  homePageController.searchGiphyList(
                      homePageController.searchtextController.text);
                },
                controller: homePageController.searchtextController,
              ),
            ),
            //------- Giphy ----- List ------

            Obx(
              () => homePageController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : homePageController.isSearching.value
                      ? Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10),
                              alignment: Alignment.bottomLeft,
                              child: const Text(
                                "Search Result",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: homePageController
                                  .giphySearchModelData.value.data!.length,
                              itemBuilder: ((context, index) {
                                var data = homePageController
                                    .giphySearchModelData.value.data![index];
                                return Image.network(
                                    data.images!.original!.url!);
                              }),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10),
                              alignment: Alignment.bottomLeft,
                              child: const Text(
                                "Trending Now",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: homePageController
                                  .giphyTrendingdata.value.data!.length,
                              itemBuilder: ((context, index) {
                                var data = homePageController
                                    .giphyTrendingdata.value.data![index];
                                return Image.network(
                                    data.images!.original!.url!);
                              }),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            homePageController.isPaginationLoading.value
                                ? const CircularProgressIndicator()
                                : Container(),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
            )
          ],
        ),
      ),
    );
  }
}
