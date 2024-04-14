import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/Pages/detail_page.dart';
import '../models/api_key.dart';
import '../models/colors.dart';
import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart'as timeago;

class DiscoverPage extends StatefulWidget {


   const DiscoverPage({ Key? key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final List<String> topics = ['For You', 'Technology', 'Politics', 'Business'];
  int selectedTopic = 0;
  late Future<Map<String, dynamic>> newsUpdates;
  List<bool> bookmarkStates =
      List.generate(8, (index) => false); // Initialize bookmark states
  List<dynamic> allArticles = []; // List to store all articles
  List<dynamic> filteredArticles = []; // List to store filtered articles

  @override
  void initState() {
    super.initState();
    newsUpdates = getNewsUpdates();
  }

  Future<Map<String, dynamic>> getNewsUpdates() async {
    try {
      String countryName = 'nigeria';
      final res = await http.get(Uri.parse(
          'https://gnews.io/api/v4/top-headlines?category=general&lang=en&country=$countryName&max=10&apikey=$gNewsApiKey'));
      final data = jsonDecode(res.body);
      print(jsonDecode(res.body));
      print('apistarted');
      setState(() {
        allArticles = data['articles'];
        filteredArticles =
            allArticles; // Initialize filtered articles with all articles
      });
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  void filterArticles(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredArticles =
            allArticles; // Reset to display all articles if query is empty
      } else {
        filteredArticles = allArticles.where((article) {
          final name = article['source']['name'].toString().toLowerCase();
          return name.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
         leading: IconButton(
           onPressed: (){
             Navigator.pop(context);
           },
           icon: const Icon(Icons.arrow_back_ios),
         ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder(
          future: newsUpdates,
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

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Discover',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Text(
                  'News from around the world',
                  style: GoogleFonts.roboto(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  onChanged: (value) {
                    filterArticles(value);
                  },
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: 'Search items, collections, and accounts',
                      hintStyle: TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey), // Border when focused
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      )),
                ),

                // tabs
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
                                ? Text('$topic',
                                    style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))
                                : Text(
                                    '$topic',
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

                // list of news articles
                Expanded(
                  child: ListView.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      if (index >= filteredArticles.length) {
                        return Container(); // Return an empty container if index is out of range
                      }
                      final article = filteredArticles[index];
                      final title = article['title'].toString();
                      final image = article['image'].toString();
                      final name = article['source']['name'];
                      final content = article['content'].toString();
                      final time = article['publishedAt'];

                      DateTime dateTime = DateTime.parse(time);

                      String timeAgo = timeago.format(dateTime);

                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ArticleDetailPage(name: '${name} Channel', image: image, title: title, content: content,)),
                          );
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
                                    image: NetworkImage('$image'),
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
                                    Text(name,
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
                                        color: Colors.black,
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
            );
          },
        ),
      ),
    );
  }
}
