import 'package:flutter/material.dart';
import 'package:github_assistant/Helpers/app_colors.dart';
import 'package:github_assistant/Models/repo_model.dart';

class RepoWidget extends StatelessWidget {
  final RepoModel repoData;

  const RepoWidget({this.repoData});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: AppColors.mainColor,
      shadowColor: AppColors.textColor,
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                textWidget(repoData.name),
                textWidget(repoData.language),
                textWidget(repoData.description),
              ],
            ),
          ),
          Container(
            width: 90,
            child: Column(
              children: [
                textWithImageWidget(
                    '${repoData.stargazers_count}', 'assets/icons/star.png'),
                textWithImageWidget(
                    '${repoData.watchers_count}', 'assets/icons/glasses.png'),
                repoData.private
                    ? textWithImageWidget("", 'assets/icons/padlock.png')
                    : textWithImageWidget("", 'assets/icons/padunlock.png'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget textWidget(String text) {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
      alignment: Alignment.centerLeft,
      child: Text(text == null ? "" : text,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: AppColors.textColor, fontSize: 18)),
    );
  }

  Widget textWithImageWidget(String text, String image) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
            margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
            child: Text(text,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: AppColors.textColor, fontSize: 18))),
        Container(
            margin: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
            child: Image(
                height: 20,
                width: 20,
                color: AppColors.textColor,
                image: AssetImage(image)))
      ],
    );
  }
}

// Container(
//         margin: const EdgeInsets.only(left: 8),
//         height: 25,
//         child: Text(repoData.name,
//             style: TextStyle(color: AppColors.textColor, fontSize: 18)),
//       ),
