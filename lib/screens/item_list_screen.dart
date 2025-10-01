import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/item_list_provider.dart';
import 'item_detail_screen.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ItemListProvider>(context, listen: false);
      provider.loadMore();

      controller.addListener(() {
        if (controller.position.pixels >=
            controller.position.maxScrollExtent - 200) {
          provider.loadMore();
        }
      });
    });
    // final provider = Provider.of<ItemListProvider>(context, listen: false);
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
      appBar: AppBar(title: const Text("Items")),
      body: Consumer<ItemListProvider>(
        builder: (context, provider, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search Items',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: provider.setSearchQuery,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemCount:
                      provider.displayItems.length + (provider.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == provider.displayItems.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final item = provider.displayItems[index];
                    return ListTile(
                      title: Text(item.toUpperCase()),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ItemDetailScreen(itemName: item),
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
