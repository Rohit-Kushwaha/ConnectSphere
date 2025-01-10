import 'package:career_sphere/feature/home/blog/cubit/cubit/blog_cubit.dart';
import 'package:career_sphere/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlogCubit()..getBlogPlaces(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Blogs",
            style: merienda20(context),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<BlogCubit, BlogState>(
                builder: (context, state) {
                  if (state.blogResponse != null) {
                    return ListView.separated(
                      itemCount: state.blogResponse!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 250,
                          width: double.infinity,
                          decoration: BoxDecoration(color: Colors.amber),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.person_2_outlined,
                                    size: 40,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(state.blogResponse![index].username
                                          .toString()),
                                      Text(state
                                          .blogResponse![index].userId!.name
                                          .toString())
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(),
                                  child: Image.network(
                                    state.blogResponse![index].image.toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                    );
                  } else if (state.error != null) {
                    // An error occurred
                    return Center(
                      child: Text(
                        state.error!,
                        style: TextStyle(color: Colors.red, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    // Loading state
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
