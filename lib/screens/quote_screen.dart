import 'package:flutter/material.dart';
import '../services/quote_service.dart';

class QuoteScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) addToFavorites;

  QuoteScreen({required this.addToFavorites});

  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final QuoteService _quoteService = QuoteService();
  String _quote = '';
  String _author = '';
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadQuote();
  }

  Future<void> _loadQuote() async {
    try {
      final quoteData = await _quoteService.fetchRandomQuote();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Quote'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _quote,
                style:
                    const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                '- $_author',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loadQuote,
                child: const Text('New Quote'),
              ),
              IconButton(
                icon: const Icon(Icons.star_border),
                onPressed: () {
                  widget.addToFavorites({
                    'quote': _quote,
                    'author': _author,
                    'categories': _categories.join(', ')
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to favorites!')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
