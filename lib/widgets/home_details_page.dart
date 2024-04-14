import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/Pages/detail_page.dart';
import '../models/colors.dart';
import '../models/api_key.dart';
import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart' as timeago;
import 'dart:ui';

class HomePageDetails extends StatefulWidget {
  final VoidCallback onRefresh;
  const HomePageDetails({super.key, required this.onRefresh});

  @override
  State<HomePageDetails> createState() => _HomePageDetailsState();
}

class _HomePageDetailsState extends State<HomePageDetails> {
  bool isClicked = false;
  final List<String> topics = ['For You', 'Technology', 'Politics', 'Business'];
  int selectedTopic = 0;
  late Future<Map<String, dynamic>> newsUpdates;
  List<bool> bookmarkStates =
      List.generate(8, (index) => false); // Initialize bookmark states

  Future<Map<String, dynamic>> getNewsUpdates() async {
    try {
      String countryName = 'nigeria';
      final res = await http.get(Uri.parse(
          'https://gnews.io/api/v4/top-headlines?category=general&lang=en&country=$countryName&max=10&apikey=$gNewsApiKey'));
      final data = jsonDecode(res.body);
      print(jsonDecode(res.body));
      print('apistarted');
      // if (data['cod'] != '200') {
      //   throw 'No network available';
      // }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getNewsUpdates(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Colors.black,
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        final data = snapshot.data!;
        if (data['articles'] == null) {
          return const  Padding(
            padding:  EdgeInsets.all(8.0),
            child:  Center(
              child: Text('No articles available, You have reached your limit for the day Or no internet connection'),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final article = data['articles'][index];
                    final title = article['title'].toString();
                    final image = article['image'].toString();
                    final name = article['source']['name'];
                    final content = article['content'].toString();
                    final time = article['publishedAt'];

                    DateTime dateTime = DateTime.parse(time);

                    String timeAgo = timeago.format(dateTime);

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ArticleDetailPage(
                                    name: name,
                                    image: image,
                                    title: title,
                                    content: content)));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                color: Colors.black.withOpacity(0.5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          '$name',
                                          style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          '-',
                                          style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          timeAgo,
                                          style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              //Tabs
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final topic = topics[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTopic = index;
                          });
                        },
                        child: Chip(
                          backgroundColor:
                              selectedTopic == index ? myColor : null,
                          label: selectedTopic == index
                              ? Text(topic,
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))
                              : Text(
                                  topic,
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: BorderSide.none,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    final article = data['articles'][index + 2];
                    final title = article['title'].toString();
                    final image = article['image'].toString();
                    final name = article['source']['name'];
                    final content = article['content'].toString();

                    final time = article['publishedAt'];

                    DateTime dateTime = DateTime.parse(time);

                    String timeAgo = timeago.format(dateTime);

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ArticleDetailPage(
                                    name: name,
                                    image: image,
                                    title: title,
                                    content: content)));
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            // Image on the left side
                            Container(
                              width: 120.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: NetworkImage(image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            // Column of texts beside the image
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('$name',
                                      style: GoogleFonts.roboto(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 3.0),
                                  Text(title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.roboto(fontSize: 16)),
                                  const SizedBox(height: 3.0),
                                  Text(
                                    timeAgo,
                                    style: GoogleFonts.roboto(
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
