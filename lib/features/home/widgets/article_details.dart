import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/models/articles_response.dart';

class ArticleDetails extends StatelessWidget {
  final Article article;

  const ArticleDetails({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage ?? "",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.image_not_supported),
              ),
            ),

            const SizedBox(height: 10),

            /// description
            Text(
              article.description ?? "No description available",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 8),

            /// author + date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  article.author ?? "Unknown",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  timeAgo(article.publishedAt),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String timeAgo(String? dateString) {
    if (dateString == null) return "";

    final date = DateTime.tryParse(dateString);
    if (date == null) return "";

    final diff = DateTime.now().difference(date);

    if (diff.inSeconds < 60) {
      return "just now";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes} minutes ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} hours ago";
    } else if (diff.inDays == 1) {
      return "yesterday";
    } else if (diff.inDays < 7) {
      return "${diff.inDays} days ago";
    } else if (diff.inDays < 30) {
      return "${(diff.inDays / 7).floor()} weeks ago";
    } else if (diff.inDays < 365) {
      return "${(diff.inDays / 30).floor()} months ago";
    } else {
      return "${(diff.inDays / 365).floor()} years ago";
    }
  }
}
