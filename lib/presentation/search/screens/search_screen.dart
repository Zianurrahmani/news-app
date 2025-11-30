import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/presentation/search/bloc/search_bloc.dart';
import 'package:news_app/presentation/search/bloc/search_event.dart';
import 'package:news_app/presentation/search/bloc/search_state.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final keywordController = TextEditingController();
  String selectedCategory = "Title";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search News")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: keywordController,
              decoration: const InputDecoration(
                labelText: "Keyword",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Search By",
              ),
              items: const [
                DropdownMenuItem(value: "Title", child: Text("Title")),
                DropdownMenuItem(value: "Description", child: Text("Description")),
                DropdownMenuItem(value: "Both", child: Text("Both")),
              ],
              onChanged: (v) => setState(() => selectedCategory = v!),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                context.read<SearchBloc>().add(
                      SearchKeywordEvent(
                        keywordController.text.trim(),
                        selectedCategory,
                      ),
                    );
              },
              child: const Text("Search"),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.error != null) {
                    return Center(child: Text(state.error!));
                  }

                  if (state.results.isEmpty) {
                    return const Center(child: Text("No results found"));
                  }

                  return ListView.builder(
                    itemCount: state.results.length,
                    itemBuilder: (_, i) {
                      final article = state.results[i];

                      return ListTile(
                        title: Text(article.title),
                        subtitle: Text(article.source.name),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
