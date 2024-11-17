import 'package:flutter/material.dart';
import '../services/quote_service.dart';

class QuoteScreen extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final QuoteService _quoteService = QuoteService();
  String _quote = '';
  String _author = '';

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
      });
    } catch (e) {
      setState(() {
        _quote = 'Failed to load quote.';
        _author = '';
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
            ],
          ),
        ),
      ),
    );
  }
}
