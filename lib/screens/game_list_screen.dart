import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_list_provider.dart';
import 'game_detail_screen.dart';

class GameListScreen extends StatefulWidget {
  const GameListScreen({super.key});

  @override
  State<GameListScreen> createState() => _GameListScreenState();
}

class _GameListScreenState extends State<GameListScreen> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<GameListProvider>(context, listen: false);
    provider.loadMore();

    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent - 200) {
        provider.loadMore();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mainline Games")),
      body: Consumer<GameListProvider>(
        builder: (context, provider, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search Games',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: provider.setSearchQuery,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemCount: provider.displayGames.length + (provider.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == provider.displayGames.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final game = provider.displayGames[index];
                    return ListTile(
                      title: Text(game.toUpperCase()),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => GameDetailScreen(gameName: game),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
