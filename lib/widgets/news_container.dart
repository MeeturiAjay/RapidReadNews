import 'package:flutter/material.dart';
import 'package:rapid_read/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsContainer extends StatelessWidget {
  String imgUrl;
  String headlines;
  String description;
  String weburl;

  NewsContainer(
      {super.key,
      required this.imgUrl,
      required this.headlines,
      required this.description,
      required this.weburl});

  Future<void> _LaunchURL() async {
    final Uri url = Uri.parse(weburl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $weburl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                    onTap: _LaunchURL,
                    child: Image.network(
                      imgUrl, //width: 350,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 300,
                          width: 350,
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
                          child: Center(
                            child: Text(
                              "No Image",
                              style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                      height: 300,
                      fit: BoxFit.cover,
                    ))),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              headlines,
              style: TextStyle(
                  color: Constants.appbarbgcolor,
                  fontWeight: FontWeight.bold,
              fontSize: 22.0),
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(description, style: TextStyle(color: Constants.appbarbgcolor,
              fontSize: 16
              ))),
          Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("developed by",
                  style: TextStyle(color: Constants.appbarbgcolor)),
              Text(" Meeturi",
                  style: TextStyle(color: Constants.appbarbgcolor, fontWeight: FontWeight.bold))
            ],
          ),
        ],
      ),
    );
  }
}
