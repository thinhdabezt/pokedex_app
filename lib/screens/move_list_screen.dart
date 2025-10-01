import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/move_list_provider.dart';
import 'move_detail_screen.dart';

class MoveListScreen extends StatefulWidget {
  const MoveListScreen({super.key});

  @override
  State<MoveListScreen> createState() => _MoveListScreenState();
}

class _MoveListScreenState extends State<MoveListScreen> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<MoveListProvider>(context, listen: false);
      provider.loadMore();

      controller.addListener(() {
        if (controller.position.pixels >=
            controller.position.maxScrollExtent - 200) {
          provider.loadMore();
        }
      });
    });
    // final provider = Provider.of<MoveListProvider>(context, listen: false);
    // provider.loadMore();

    // controller.addListener(() {
    //   if (controller.position.pixels >=
    //       controller.position.maxScrollExtent - 200) {
    //     provider.loadMore();
    //   }
    // });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Moves")),
      body: Consumer<MoveListProvider>(
        builder: (context, provider, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search Moves',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: provider.setSearchQuery,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemCount: provider.displayMoves.length + (provider.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == provider.displayMoves.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final move = provider.displayMoves[index];
                    return ListTile(
                      title: Text(move.toUpperCase()),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MoveDetailScreen(moveName: move),
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
