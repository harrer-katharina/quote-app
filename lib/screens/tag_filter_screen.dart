import 'package:flutter/material.dart';
import '../services/quote_service.dart';

class TagFilterScreen extends StatefulWidget {
  final List<String> selectedTags;

  TagFilterScreen({required this.selectedTags});

  @override
  _TagFilterScreenState createState() => _TagFilterScreenState();
}

class _TagFilterScreenState extends State<TagFilterScreen> {
  final QuoteService _quoteService = QuoteService();
  List<String> _availableTags = [];
  late List<String> _selectedTags;

  @override
  void initState() {
    super.initState();
    _selectedTags = List<String>.from(widget.selectedTags);
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

  /*
  Future<void> _loadQuotesByTags() async {
    if (_selectedTags.isNotEmpty) {
      try {
        final quotes = await _quoteService.fetchQuotesByTags(_selectedTags);
        setState(() {
          _filteredQuotes = quotes.isNotEmpty ? quotes : [];
        });
        print('Selected tags: $_selectedTags');
        print('Selected quote: $quotes');
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
*/

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
                onPressed: () {
                  Navigator.of(context).pop(_selectedTags);
                },
                child: const Text('Apply Filters'),
              ),
            ],
          ),

    );
  }
}
