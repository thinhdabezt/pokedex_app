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
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("ITEMS"),
        elevation: 4,
      ),
      body: Consumer<ItemListProvider>(
        builder: (context, provider, _) {
          return Column(
            children: [
              // Pixel-styled search bar
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'SEARCH ITEMS...',
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: theme.primaryColor,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, 
                      vertical: 12,
                    ),
                  ),
                  style: theme.textTheme.bodyLarge,
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
                      return Container(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: theme.primaryColor,
                          ),
                        ),
                      );
                    }
                    final item = provider.displayItems[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16, 
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.primaryColor.withOpacity(0.3), 
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: theme.cardColor,
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: theme.primaryColor, 
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(6),
                            color: theme.scaffoldBackgroundColor,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/${item.toLowerCase().replaceAll(' ', '-')}.png',
                              width: 44,
                              height: 44,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.inventory_2,
                                  color: theme.primaryColor,
                                  size: 24,
                                );
                              },
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: theme.primaryColor,
                                      strokeWidth: 2,
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        title: Text(
                          item.toUpperCase(),
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                        subtitle: Text(
                          'TAP TO VIEW DETAILS',
                          style: theme.textTheme.bodySmall?.copyWith(
                            letterSpacing: 0.5,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: theme.primaryColor,
                          size: 16,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ItemDetailScreen(itemName: item),
                            ),
                          );
                        },
                      ),
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
