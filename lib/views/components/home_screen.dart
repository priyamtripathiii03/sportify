import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportify/views/components/search_screen.dart';
import 'package:sportify/views/components/shimmer_effect.dart';

import '../../provider/music_provider.dart';
import '../../utils/colors.dart';
import 'custom_button_navigation_bar.dart';
import 'custom_row.dart';
import 'drawer.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getObject();
  }

  // GlobalKey to manage the drawer
  @override
  Widget build(BuildContext context) {
    // instance of the provider
    final providerTrue = Provider.of<MusicProvider>(context);
    final providerFalse = Provider.of<MusicProvider>(context, listen: false);
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: const MyDrawer(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [black1, black2],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Builder(builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        // opening drawer
                        Scaffold.of(context).openDrawer();
                      },
                      child:
                      const Icon(Icons.menu, size: 30, color: Colors.white),
                    );
                  }),
                  SizedBox(height: height * 0.02),
                  Text(
                    'Hi There,',
                    style: TextStyle(
                      color: green,
                      letterSpacing: 1.5,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Priyam Tripathi',
                    style: TextStyle(
                      letterSpacing: 1.5,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: height * 0.065,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: green,
                          ),
                          SizedBox(
                            width: height * 0.01,
                          ),
                          Text(
                            'Songs, albums or artists',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  FutureBuilder(
                    future: providerFalse.fetchApiData("Pritam"),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CustomRows(
                          text: 'Trending Now',
                          result: providerTrue.artistData!.data.result,
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            snapshot.error.toString(),
                          ),
                        );
                      } else {
                        return const ShimmerEffect();
                      }
                    },
                  ),

                  SizedBox(height: height * 0.03),
                  FutureBuilder(
                    future: providerFalse.fetchPunjabiApiData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CustomRows(
                          text: 'Hindi Hits',
                          result: providerTrue.hindiSongs!.data.result,
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        return const ShimmerEffect();
                      }
                    },
                  ),
                  SizedBox(height: height * 0.03),
                  FutureBuilder(
                    future: providerFalse.fetchHindi(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CustomRows(
                          text: 'Punjabi Hits',
                          result: providerTrue.punjabiSongs!.data.result,
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        return const ShimmerEffect();
                      }
                    },
                  ),
                  SizedBox(height: height * 0.03),
                  FutureBuilder(
                    future: providerFalse.fetchHaryanaApiData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CustomRows(
                          text: 'Haryanvi Hits',
                          result: providerTrue.haryanaSongs!.data.result,
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        return const ShimmerEffect();
                      }
                    },
                  ),
                  SizedBox(height: height * 0.03),
                  FutureBuilder(
                    future: providerFalse.fetchTopApiData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CustomRows(
                          text: 'Lofi Songs',
                          result: providerTrue.topData!.data.result,
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        return const ShimmerEffect();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Future<void> getObject() async {
    var provider = Provider.of<MusicProvider>(context, listen: false);
    provider.artistData = await provider.fetchApiData("Pritam");
    provider.topData = await provider.fetchTopApiData();
    provider.punjabiSongs = await provider.fetchPunjabiApiData();
    provider.hindiSongs = await provider.fetchPunjabiApiData();
    provider.haryanaSongs = await provider.fetchPunjabiApiData();
  }
}
