part of 'blog_cubit.dart';

class BlogState extends Equatable {
  final List<BlogResponse>? blogResponse;
  final String? error;

  const BlogState({this.blogResponse, this.error});

  BlogState copyWith({List<BlogResponse>? blogResponse, String? error}) {
    return BlogState(
        blogResponse: blogResponse ?? this.blogResponse, error: error ?? error);
  }

  @override
  List<Object?> get props => [blogResponse, error];
}
