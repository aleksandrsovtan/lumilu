import 'package:flutter/material.dart';

import 'lumi_list_item.dart';

class LumiItemList<T> extends StatelessWidget {
  const LumiItemList({
    required this.items,
    required this.selectedItem,
    required this.assetPathOf,
    required this.idOf,
    required this.onSelected,
    super.key,
  });

  final List<T> items;
  final T selectedItem;
  final String? Function(T item) assetPathOf;
  final String Function(T item) idOf;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return LumiListItem(
          key: Key('lumi-${idOf(item)}-option'),
          assetPath: assetPathOf(item),
          isSelected: selectedItem == item,
          onTap: () => onSelected(item),
        );
      },
    );
  }
}
