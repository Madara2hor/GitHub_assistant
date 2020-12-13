import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_assistant/Models/search_model.dart';
import 'package:github_assistant/Views/user_page.dart';
import 'package:http/http.dart' as http;

import '../Helpers/app_colors.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  SearchModel searchModel = SearchModel();
  String resultMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        title: Text("GitHub Assistant"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildSearchBar(),
          Flexible(
            flex: 2,
            child: buildUsersList(),
          ),
        ],
      ),
    );
  }

  Widget buildUsersList() {
    return searchModel.items != null && searchModel.items.length != 0
        ? ListView.builder(
            itemCount: searchModel.items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserPage(
                                user: searchModel.items[index],
                              )))
                },
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: AppColors.mainColor,
                  shadowColor: AppColors.textColor,
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    height: 25,
                    child: Text(searchModel.items[index].login,
                        style: TextStyle(
                            color: AppColors.textColor, fontSize: 18)),
                  ),
                ),
              );
            })
        : Center(
            child: Text(resultMessage,
                style: TextStyle(color: AppColors.textColor, fontSize: 24)));
  }

  Widget buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 10),
            child: TextField(
              controller: searchController,
              textInputAction: TextInputAction.search,
              style: TextStyle(color: AppColors.textColor),
              onSubmitted: (value) => () {
                searchUser(value);
              },
              decoration: InputDecoration(
                  hintText: 'Поиск...',
                  hintStyle:
                      TextStyle(color: AppColors.textColor, fontSize: 17),
                  border: InputBorder.none),
            ),
          ),
        ),
        Container(
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image(
                    color: AppColors.textColor,
                    height: 24,
                    width: 24,
                    image: AssetImage('assets/icons/magnifying-glass.png')),
              ),
              onTap: () {
                searchUser(searchController.text);
              },
            ),
          ),
        )
      ],
    );
  }

  searchUser(String username) {
    if (username != "") {
      http
          .get('https://api.github.com/search/users?q=$username')
          .then((response) {
        var responseMap = jsonDecode(response.body);
        setState(() {
          searchModel = SearchModel.fromJson(responseMap);
          if (searchModel.items.length == 0) {
            resultMessage = "Ничего не найдено";
          }
        });
      }).catchError((error) {
        print("Error: $error");
      });
    }
  }
}
