import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteQuotes;
  final Function(Map<String, dynamic>) removeFromFavorites;

  FavoritesScreen({
    required this.favoriteQuotes,
    required this.removeFromFavorites,
  });

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  void _removeFavorite(Map<String, dynamic> quote) {
    widget.removeFromFavorites(quote);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Removed from favorites!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Quotes'),
      ),
      body: widget.favoriteQuotes.isEmpty
          ? const Center(
        child: Text('No favorite quotes yet!'),
      )
          : ListView.builder(
        itemCount: widget.favoriteQuotes.length,
        itemBuilder: (context, index) {
          final quote = widget.favoriteQuotes[index];
          return ListTile(
            title: Text(quote['quote']!),
            subtitle: Text('- ${quote['author']}\nCategories: ${quote['categories']}'),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: () => _removeFavorite(quote),
            ),
          );
        },
      ),
    );
  }
}
