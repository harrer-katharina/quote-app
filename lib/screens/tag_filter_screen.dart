import 'package:flutter/material.dart';
import '../services/quote_service.dart';

class TagFilterScreen extends StatefulWidget {
  @override
  _TagFilterScreenState createState() => _TagFilterScreenState();
}

class _TagFilterScreenState extends State<TagFilterScreen> {
  final QuoteService _quoteService = QuoteService();
  List<String> _availableTags = [];
  final List<String> _selectedTags = [];
  List<Map<String, dynamic>> _filteredQuotes = [];

  @override
  void initState() {
    super.initState();
    _loadAvailableTags();
  }

  Future<void> _loadAvailableTags() async {
    try {
      final tags = await _quoteService.fetchAvailableTags();
      setState(() {
        _availableTags = tags;
      });
    } catch (e) {
      print('Failed to load tags');
    }
  }

  Future<void> _loadQuotesByTags() async {
    if (_selectedTags.isNotEmpty) {
      try {
        final quotes = await _quoteService.fetchQuotesByTags(_selectedTags);
        setState(() {
          _filteredQuotes = quotes.isNotEmpty ? quotes : [];
        });
      } catch (e) {
        print('Failed to load quotes by tags');
        setState(() {
          _filteredQuotes = [];
        });
      }
    } else {
      setState(() {
        _filteredQuotes = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Quotes by Tags'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select Tags:', style: TextStyle(fontSize: 18)),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _availableTags.map((tag) {
                  return FilterChip(
                    label: Text(tag),
                    selected: _selectedTags.contains(tag),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _selectedTags.add(tag);
                        } else {
                          _selectedTags.remove(tag);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loadQuotesByTags,
                child: const Text('Get Quotes'),
              ),
              const SizedBox(height: 20),
              _filteredQuotes.isEmpty
                  ? const Center(
                      child: Text(
                        'No quotes match the selected tags.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _filteredQuotes.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_filteredQuotes[index]['quote']),
                          subtitle:
                              Text('- ${_filteredQuotes[index]['author']}'),
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
