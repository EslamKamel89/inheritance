import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:inheritance/core/services/localization/localization_extension.dart';
import 'package:inheritance/features/inheritance/models/grand_children_response_model/grand_children_response_model.dart';

Future<void> showGrandchildrenBottomSheet(
  BuildContext context,
  List<GrandChildrenResponseModel> items,
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => _GrandchildrenSheet(items: items),
  );
}

class _GrandchildrenSheet extends StatelessWidget {
  final List<GrandChildrenResponseModel> items;
  const _GrandchildrenSheet({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final height = media.size.height;

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      expand: false,
      builder:
          (_, controller) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 20,
                  offset: const Offset(0, -6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ).animate().fadeIn(duration: 250.ms).slideY(begin: -0.1, duration: 350.ms),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                                "grandchildren_overview".t(),
                                style: Theme.of(
                                  context,
                                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                              )
                              .animate()
                              .fadeIn(delay: 80.ms, duration: 350.ms)
                              .slideY(begin: 0.1, duration: 350.ms),
                          const SizedBox(height: 4),
                          Text(
                            '${items.length} ${"records".t()}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ).animate().fadeIn(delay: 140.ms, duration: 350.ms),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close_rounded),
                    ).animate().scale(delay: 100.ms, duration: 300.ms),
                  ],
                ),
                const SizedBox(height: 12),

                Expanded(
                  child:
                      items.isEmpty
                          ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.inbox_rounded, size: 48, color: Colors.grey.shade400),
                                const SizedBox(height: 8),
                                Text(
                                  "no_grandchildren".t(),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          )
                          : ListView.separated(
                            controller: controller,
                            physics: const BouncingScrollPhysics(),
                            itemCount: items.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final it = items[index];

                              return _GrandchildCard(item: it, index: index);
                            },
                          ),
                ),

                const SizedBox(height: 14),

                SafeArea(
                  top: false,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            backgroundColor: Colors.green.shade600,
                          ),
                          child: Text("close".t()),
                        ).animate().fadeIn(delay: 200.ms),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }
}

class _GrandchildCard extends StatelessWidget {
  final GrandChildrenResponseModel item;
  final int index;
  const _GrandchildCard({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.6),
                Theme.of(context).colorScheme.surface,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 6),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SECTION 1: gender & status (unchanged)
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            item.gender?.toLowerCase().t() ?? 'Unknown',
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                          ).animate().fadeIn(duration: 350.ms),
                        ),
                        const SizedBox(width: 8),
                        Chip(
                          visualDensity: VisualDensity.compact,
                          label: Text(item.status?.toLowerCase().t() ?? '—'),
                        ).animate().fadeIn(delay: 80.ms),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // MERGED SECTION: counts (males/females), shares (men/women) and total
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Counts column
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("males".t(), style: Theme.of(context).textTheme.bodySmall),
                            const SizedBox(height: 4),
                            Text(
                              '${item.grandChildrenMalesCount ?? 0}',
                              style: Theme.of(
                                context,
                              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 8),
                            Text("females".t(), style: Theme.of(context).textTheme.bodySmall),
                            const SizedBox(height: 4),
                            Text(
                              '${item.grandChildrenFemalesCount ?? 0}',
                              style: Theme.of(
                                context,
                              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),

                        const SizedBox(width: 16),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("men_share".t(), style: Theme.of(context).textTheme.bodySmall),
                            const SizedBox(height: 4),
                            Text(
                              (item.share?.men?.ceil() ?? 0).toString(),
                              style: Theme.of(
                                context,
                              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 8),
                            Text("women_share".t(), style: Theme.of(context).textTheme.bodySmall),
                            const SizedBox(height: 4),
                            Text(
                              (item.share?.women?.ceil() ?? 0).toString(),
                              style: Theme.of(
                                context,
                              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),

                        const Spacer(),

                        // Total column
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("total".t(), style: Theme.of(context).textTheme.bodySmall),
                            const SizedBox(height: 4),
                            Text(
                              '${item.totalShare?.ceil() ?? 0}',
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ).animate().fadeIn(delay: 120.ms),
                      ],
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: (index * 60).ms, duration: 450.ms)
        .slideY(begin: 0.06, duration: 450.ms);
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final int value;
  const _MiniStat({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 4),
        Text(
          '$value',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
