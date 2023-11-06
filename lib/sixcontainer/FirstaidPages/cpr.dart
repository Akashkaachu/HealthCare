import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DisplayFirstAidScrn extends StatefulWidget {
  const DisplayFirstAidScrn(
      {super.key,
      required this.title,
      required this.imageSrc,
      required this.content,
      required this.siteUrl});
  final String title;
  final String imageSrc;
  final String content;
  final String siteUrl;
  @override
  State<DisplayFirstAidScrn> createState() => _DisplayFirstAidScrnState();
}

class _DisplayFirstAidScrnState extends State<DisplayFirstAidScrn> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        automaticallyImplyLeading: false,
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: const Color(0xff7a73e7),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              width: size.width,
              color: const Color(0xff7a73e7).withOpacity(0.19),
              child: Column(children: [
                Image.asset(
                  widget.imageSrc,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 10),
                Text(widget.content),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xff7a73e7)),
                    ),
                    onPressed: () async {
                      final Uri url = Uri.parse(widget.siteUrl);
                      if (!await launchUrl(url)) {
                        throw Exception('could not lauch');
                      }
                    },
                    child: const Text("See More Details"))
              ]),
            ),
          )),
    );
  }
}
