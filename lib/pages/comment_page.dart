import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task9_advanced_provider/models/post_model.dart';
import 'package:task9_advanced_provider/providers/comment_provider.dart';

class CommentPage extends StatelessWidget {
  const CommentPage({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Post Id: ${post.id.toString()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(post.title),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(post.body),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Comment:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: Provider.of<CommentProvider>(context, listen: false)
                  .getComments(post.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return Consumer<CommentProvider>(
                    builder: (context, commentProvider, child) {
                      return ListView.builder(
                        itemCount: commentProvider.comments.length,
                        itemBuilder: (context, index) {
                          final comment = commentProvider.comments[index];
                          return ListTile(
                            title: Text(comment.name),
                            subtitle: Text(comment.body),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
