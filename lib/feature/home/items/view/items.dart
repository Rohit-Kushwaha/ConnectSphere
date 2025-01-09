import 'package:career_sphere/feature/home/items/bloc/bloc/item_bloc.dart';
import 'package:career_sphere/feature/home/items/repo/items_repo.dart';
import 'package:career_sphere/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemBloc(ItemsRepoImpl())..add(ItemsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Items",
            style: merienda20(context),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<ItemBloc, ItemState>(
                listener: (context, state) {
                  if (state is ItemErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                  // if (state is NoMoreItemState) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: Text(
                  //         "No more data",
                  //         style: merienda16(context).copyWith(
                  //           color: AppColors.whiteColor,
                  //         ),
                  //       ),
                  //     ),
                  //   );
                  // }
                },
                builder: (context, state) {
                  if (state is ItemLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (state is ItemSuccessState) {
                    return NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        // Trigger loading more items when reaching the end of the list
                        if (scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                          // Load more items
                          context.read<ItemBloc>().add(LoadMoreItemsEvent());
                          return true; // Prevent other notifications from being processed
                        }
                        return false;
                      },
                      // NotificationListener<ScrollNotification>(
                      //   onNotification: (ScrollNotification scrollInfo) {
                      //     if (scrollInfo.metrics.pixels >=
                      //             scrollInfo.metrics.maxScrollExtent - 100 &&
                      //         state is! ItemLoadingMoreState) {
                      //       debugPrint("Triggering LoadMoreItemsEvent");
                      //       context.read<ItemBloc>().add(LoadMoreItemsEvent());
                      //       return true;
                      //     }
                      //     return false;
                      //   },
                      child: ListView.separated(
                        itemCount: state.itemsResponse.items!.length +
                            1, // Add one for the loading indicator
                        itemBuilder: (context, index) {
                          // Show a loading spinner when more items are being loaded
                          final items = state.itemsResponse.items!;

                          // If the last index, display the loader
                          if (index == items.length) {
                            debugPrint("${state.hasMoreItems}HasMoreItemValue");
                            if (state.hasMoreItems == true) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state.hasMoreItems == false) {
                              return SizedBox
                                  .shrink(); // Hide loader when no more items
                            } else {}
                          }

                          var item = state.itemsResponse.items![index];
                          return Container(
                            height: 100.h,
                            width: 100.w,
                            decoration: BoxDecoration(color: Colors.red),
                            child: Row(
                              children: [
                                Icon(Icons.flag),
                                Column(
                                  children: [
                                    Text(
                                      "${index + 1}", // Item index
                                      style: merienda14(context),
                                    ),
                                    Text(
                                      item.price.toString(),
                                      style: merienda14(context),
                                    ),
                                    Text(
                                      item.tags.toString(),
                                      style: merienda14(context),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 10.h,
                          );
                        },
                      ),
                    );
                  }

                  return SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
