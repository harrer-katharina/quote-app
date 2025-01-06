import 'dart:ui';

import 'package:flutter/material.dart';
import '../services/quote_service.dart';
import 'tag_filter_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuoteScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) addToFavorites;
  final List<Map<String, dynamic>> favorites;

  QuoteScreen({
    required this.addToFavorites,
    required this.favorites,
  });

  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final QuoteService _quoteService = QuoteService();
  String _quote = '';
  String _author = '';
  List<String> _categories = [];
  List<String> _selectedTags = [];

  @override
  void initState() {
    super.initState();
    _loadQuote();
  }

  Future<void> _loadQuote() async {
    try {
      final quoteData = await _quoteService.fetchRandomQuote(
          tags: _selectedTags.isNotEmpty ? _selectedTags.join(',') : null
      );
      setState(() {
        _quote = quoteData['quote'];
        _author = quoteData['author'];
        _categories = List<String>.from(quoteData['tags'] ?? []);
      });
    } catch (e) {
      setState(() {
        _quote = 'Failed to load quote.';
        _author = '';
        _categories = [];
      });
    }
  }

  bool _isFavorite() {
    return widget.favorites.any((favorite) =>
    favorite['quote'] == _quote && favorite['author'] == _author);
  }

  void _addFavorite() {
    final quoteData = {
      'quote': _quote,
      'author': _author,
      'categories': _categories.join(', '),
    };

    if (!_isFavorite()) {
      widget.addToFavorites(quoteData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Added to favorites!')),
      );
    }
  }

  void _openTagFilter() async {
    final selectedTags = await showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return TagFilterScreen(selectedTags: _selectedTags);
      },
    );

    if (selectedTags != null) {
      setState(() {
        _selectedTags = selectedTags;
      });
      _loadQuote();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Quote'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _openTagFilter,
          ),
        ],
      ),
      body: Stack (
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/quote_screen_background.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Blurred card
                  ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.6),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _quote,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                '$_author',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Favorite button
                  Positioned(
                    bottom: 12.0,
                    right: 12.0,
                    child: IconButton(
                      icon: Icon(
                        _isFavorite() ? Icons.star : Icons.star_border,
                      ),
                      onPressed: _addFavorite,
                    ),
                  ),
                  Positioned(
                    top: -30,
                    left: 0,
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: SvgPicture.asset(
                        'assets/quote_icon.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 48.0,
            left: 96.0,
            right: 96.0,
            child: FilledButton.tonal(
              onPressed: _loadQuote,
              child: const Text('New Quote'),
            ),
          ),
        ],
      ),
    );
  }
}
