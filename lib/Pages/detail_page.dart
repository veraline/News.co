import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleDetailPage extends StatelessWidget {
  final String name;
  final String title;
  final String image;
  final String content;

  const ArticleDetailPage(
      {required this.name,
      required this.image,
      required this.title,
        required this.content,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              title,
              style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ),
          Image.network(image),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)),

          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(content, style: const TextStyle(fontSize: 16),),
          )
        ],
      ),
    );
  }
}
