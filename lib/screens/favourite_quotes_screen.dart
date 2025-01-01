import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteQuotes;

  FavoritesScreen({required this.favoriteQuotes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Quotes'),
      ),
      body: favoriteQuotes.isEmpty
          ? const Center(
        child: Text('No favorite quotes yet!'),
      )
          : ListView.builder(
        itemCount: favoriteQuotes.length,
        itemBuilder: (context, index) {
          final quote = favoriteQuotes[index];
          return ListTile(
            title: Text(quote['quote']!),
            subtitle: Text('- ${quote['author']}\nCategories: ${quote['categories']}'),
          );
        },
      ),
    );
  }
}
