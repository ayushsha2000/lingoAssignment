import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lingoassignment/constants/k_assets_images.dart';
import 'package:lingoassignment/constants/k_colors.dart';
import 'package:lingoassignment/constants/k_spacing.dart';
import 'package:lingoassignment/constants/k_text_style.dart';
import 'package:lingoassignment/helpers.dart';
import 'package:lingoassignment/screens/widgets/news_card.dart';
import 'package:provider/provider.dart';
import 'package:lingoassignment/providers/news_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<NewsProvider>(context, listen: false).getArticlesListData();

    return Scaffold(
      backgroundColor: AppColors.accentColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "MyNews",
          style: headlineStyle.copyWith(color: AppColors.whiteColor),
        ),
        actions: [
          Consumer<NewsProvider>(builder: (context, newsProvider, child) {
            return Container(
                padding: const EdgeInsets.only(
                  right: Spacing.spacingBase,
                ),
                alignment: Alignment.center,
                child: Text(
                  newsProvider.countryCode.toUpperCase(),
                  style: headlineStyle,
                  textAlign: TextAlign.center,
                ));
          })
        ],
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          if (newsProvider.isArticlesLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ));
          }

          if (newsProvider.articlesList.isEmpty) {
            return const Center(child: Text('No Articles Available'));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: Spacing.spacingBase,
                    top: Spacing.spacingLoose,
                    bottom: Spacing.spacingNano),
                child: Text(
                  "Top Headlines",
                  style: headlineStyle,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: newsProvider.articlesList.length,
                  itemBuilder: (context, index) {
                    final article = newsProvider.articlesList[index];
                    return NewsCard(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(article.source?.name ?? "No Title",
                                    style: headlineStyle),
                                Text(article.title ?? 'No Description',
                                    style: bodyTextStyle),
                                const SizedBox(
                                  height: Spacing.spacingSmall,
                                ),
                                Text(
                                    timeAgoSinceDate(article.publishedAt ?? ''),
                                    style: dateTextStyle.copyWith(
                                        color: AppColors.accentDarkColor)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: Spacing.spacingMedium,
                          ),
                          article.urlToImage != null
                              ? Expanded(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          Spacing.spacingSmall),
                                      child: CachedNetworkImage(
                                          fit: BoxFit.contain,
                                          imageUrl: article.urlToImage!,
                                          placeholder: (context, url) =>
                                              SvgPicture.asset(
                                                  AssetImages.imagePlaceHolder),
                                          )))
                              : Expanded(child: SvgPicture.asset(
                                fit: BoxFit.contain,
                                AssetImages.imagePlaceHolder)),
                        ],
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
