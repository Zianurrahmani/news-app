import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/presentation/home/bloc/home_bloc.dart';
import 'package:news_app/presentation/home/bloc/home_state.dart';
import 'package:news_app/presentation/home/widgets/home_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 50) {
        context.read<HomeCubit>().loadMore();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Headlines (US)"),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () => context.read<HomeCubit>().refresh(),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: state.itemCount,
              itemBuilder: (context, index) {
                if (state.isLoaderIndex(index)) {
                  return const Center(child: CircularProgressIndicator());
                }

                final article = state.visibleArticles[index];

                return HomeCard(article: article);
              },
            ),
          );
        },
      ),
    );
  }
}
