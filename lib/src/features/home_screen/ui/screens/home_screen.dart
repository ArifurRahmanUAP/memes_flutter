import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_app/src/core/di/app_component.dart';
import 'package:meme_app/src/core/routes/route_name.dart';
import 'package:meme_app/src/core/routes/router.dart';
import 'package:meme_app/src/features/home_screen/ui/controller/home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeScreenController = locator<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Meme",
          style: TextStyle(),
        ),
      ),
      body: Center(
        child: GetBuilder<HomeScreenController>(initState: (state) {
          homeScreenController.getMemesApiCall().then(
                (value) {
              homeScreenController.filteredMemes.value =
              homeScreenController.memesResponseModel.value.data!.memes!;
            },
          );
        }, builder: (logic) {
          return Obx(() {
            return Column(
              children: [
                TextField(
                  controller: homeScreenController.controller.value,
                  onChanged: (value) {
                    final filtereds =
                    homeScreenController.filteredMemes.where((filterText) {
                      return filterText.name!.contains(value) ||
                          filterText.name!.contains(value);
                    }).toList();
                    homeScreenController.filteredMemes.value = filtereds;
                    homeScreenController.update(["searchUpdate"]);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    hintText: 'Search by name',
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 20,),
                Expanded(
                  child: homeScreenController.isLoginLoading.value
                      ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.pink,
                    ),
                  )
                      : GetBuilder<HomeScreenController>(
                      id: "searchUpdate",
                      builder: (logic) {
                        return homeScreenController.filteredMemes.isEmpty
                            ? const Center(
                              child: Text("Nothing Found"),
                            )
                            : Container(
                          color: const Color(0xff2b2b34),
                          child: ListView.builder(
                            itemCount: homeScreenController.filteredMemes.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  RouteGenerator.pushNamed(
                                      context, Routes.memeDetailsScreen,
                                      arguments: [
                                        homeScreenController
                                            .filteredMemes[index]
                                      ]);
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Color(0xff444155),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(25),
                                          bottomLeft:
                                          Radius.circular(10),
                                          bottomRight:
                                          Radius.circular(10))),
                                  margin: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    bottom: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          //set border radius more than 50% of height and width to make circle
                                        ),
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                              const BorderRadius
                                                  .all(
                                                Radius.circular(15),
                                              ),
                                              child: Image.network(
                                                homeScreenController
                                                    .filteredMemes[
                                                index]
                                                    .url!,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding:
                                        const EdgeInsets.all(10),
                                        child: Text(
                                          homeScreenController
                                              .filteredMemes[index]
                                              .name!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                ),
              ],
            );
          });
        }),
      ),
    );
  }
}
