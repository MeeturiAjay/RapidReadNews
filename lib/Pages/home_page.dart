import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rapid_read/constants.dart';
import 'package:rapid_read/widgets/news_container.dart';
import 'dart:math';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  List<dynamic> _newsData = [];

  Future<void> _getnews() async {
    final Uri url = Uri.parse(
        "https://newsapi.org/v2/everything?q=tesla&from=2025-03-13&sortBy=publishedAt&apiKey=6722174450e74604989e72805f665b74");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        _newsData = jsonDecode(response.body)["articles"];
        _newsData = _newsData.reversed.toList();
      });
    } else {
      debugPrint("Failed to load news");
    }
  }

  @override
  void initState() {
    _getnews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Constants.appbarfgcolor),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min, // Prevents full width usage
          children: [
            Icon(Icons.flash_on, color: Constants.appbarfgcolor),
            SizedBox(width: 8),
            Text(
              "Rapid Read News",
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.newspaper, color: Constants.appbarfgcolor),
          ],
        ),
      ),
      body: _newsData.isEmpty
          ? Center(child: CircularProgressIndicator(color: Constants.appbarbgcolor)) // Show loading indicator
          : PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: _newsData.length,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double pageOffset = 0;
                    if (_pageController.position.haveDimensions) {
                      pageOffset = _pageController.page! - index;
                    }

                    double foldAngle =
                        pi * pageOffset.clamp(-1, 1); // Fold effect

                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001) // Perspective effect
                        ..rotateX(foldAngle),
                      child: NewsContainer(
                        imgUrl: _newsData[index]["urlToImage"] ??
                            "https://via.placeholder.com/150",
                        headlines: _newsData[index]["title"] ?? "No Title",
                        description: _newsData[index]["description"]?.replaceAll(RegExp(r'\s+'), ' ').trim() ?? "No Description",
                        weburl: _newsData[index]["url"] ?? "#",
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
