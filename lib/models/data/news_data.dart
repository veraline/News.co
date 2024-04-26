import 'package:flutter/material.dart';

class NewsArticles {
  final String title;
  final String description;
  final String content;
  final String imageUrl;
  final DateTime publishedAt;

  NewsArticles(
      {required this.title,
      required this.description,
      required this.content,
      required this.publishedAt,
      required this.imageUrl});

  factory NewsArticles.fromJson(Map<String, dynamic> json) {
    return NewsArticles(
        title: json['title'],
        description: json['description'],
        content: json['content'],
        publishedAt: DateTime.parse(json['publishedAt']),
        imageUrl: json['imageUrl']);
  }
}
