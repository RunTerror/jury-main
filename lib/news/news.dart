import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:http/http.dart' as http;
import 'package:juridentt/addcase/provider.dart';
import 'package:juridentt/hamburgerMenu/hamburgerIcon.dart';
import 'package:juridentt/news/newslist.dart';
import 'package:juridentt/models/userprovider.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'newslist_law.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late int currentPage = 1; // Current page number
  final String _searchKeyword = '';
  bool isLoading = false; // Loading indicator flag
  List<dynamic> _filteredArticles = [];
  final apiKey = '5d53fbf398fe4361a267e25848e6d422';
  final apiUrl =
      'https://newsapi.org/v2/everything?q=indian law&apiKey='; // News API URL
  final int articlesPerPage = 10; // Number of articles to fetch per page
  final String name = "pranav";

  final ScrollController _scrollController = ScrollController();
  bool _isShowScrollButton = false;

  @override
  void initState() {
    super.initState();
    // Attach a scroll listener to the scroll controller
    _scrollController.addListener(_scrollListener);
    // Fetch the initial set of articles
    _fetchArticles();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    // When the user reaches the end of the current article list,
    // load the next page of articles
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isLoading) {
      _fetchArticles();
    }
    if (_scrollController.position.pixels > 200) {
      setState(() {
        _isShowScrollButton = true;
      });
    } else {
      setState(() {
        _isShowScrollButton = false;
      });
    }
  }

  var timestring = "";
  String _getGreeting() {
    var now = DateTime.now();
    if (now.hour >= 0 && now.hour < 11) {
      return 'Good Morning';
    } else if (now.hour >= 11 && now.hour < 17) {
      return 'Good Afternoon';
    } else if (now.hour >= 17 && now.hour < 8) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  Future<List<dynamic>> fetchNews(String searchKeyword, int page) async {
    final String url = apiUrl + apiKey;

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> articles = data['articles'];
        return articles
            .where((article) => article['title']
                .toLowerCase()
                .contains(searchKeyword.toLowerCase()))
            .toList();
      } else {
        //throw 'Failed to fetch news: ${response.statusCode}';
        throw 'Failed to fetch news: Please try again later';
      }
    } catch (e) {
      throw 'Error fetching news: $e';
    }
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to launch the URL.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _refreshNews() async {
    setState(() {
      _filteredArticles = [];
    });

    try {
      final List<dynamic> refreshedArticles =
          await fetchNews(_searchKeyword, currentPage);

      setState(() {
        _filteredArticles = refreshedArticles;
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Failed to fetch articles. Please check your internet connection'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _fetchArticles() async {
    setState(() {
      isLoading = true;
    });

    try {
      final List<dynamic> fetchedArticles =
          await fetchNews(_searchKeyword, currentPage);

      setState(() {
        _filteredArticles.addAll(fetchedArticles);
        currentPage++;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Failed to fetch articles. Either check your internet connection or come again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Widget _buildNewsList() {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _filteredArticles.length + 1,
      itemBuilder: (context, index) {
        if (index == _filteredArticles.length) {
          // Show a loading indicator at the end of the list while fetching more articles
          return isLoading
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox.shrink();
        }

        final article = _filteredArticles[index];
        if (article['urlToImage'] != null) {
          return GestureDetector(
            onTap: () {
              launchURL(article['url']);
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.0.w),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 80.w,
                    height: 65.h,
                    child: Image.network(
                      article['urlToImage'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0.w),
                      child: Text(
                        article['title'],
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w500,
                          color: themeProvider.casestext,
                          height: 1.25.h,
                          letterSpacing: -0.356,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildAnnouncements() {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      margin: EdgeInsets.only(left: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'New Announcement',
            style: TextStyle(
              fontSize: 22.sp,
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.w500,
              color: themeProvider.casestext,
              height: 1.25.h,
              letterSpacing: -0.356,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 250.h, // Height of the horizontal images
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _filteredArticles.length,
              itemBuilder: (context, index) {
                final article = _filteredArticles[index];
                if (article['urlToImage'] != null) {
                  return GestureDetector(
                    onTap: () {
                      launchURL(article['url']);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      width: 130.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          article['urlToImage'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userDetailProvider = Provider.of<UserDetailProvider>(context);
    userDetailProvider.fetchUserDetail();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: themeProvider.casestext),
        elevation: 0,
        // backgroundColor: Colors.transparent,
        backgroundColor: themeProvider.newsbar,
        // leading: IconButton(
        //   onPressed:(){
        //     Navigator.push(context, MaterialPageRoute(builder: (context)=> NewsPage()));
        //   },
        //   icon: Icon(Icons.arrow_back, color: themeProvider.casestext,)),
      ),
      drawer: const HamburgerIcon(),
      body: SafeArea(
        child: Column(
          children: [
            RefreshIndicator(
              onRefresh: _fetchArticles,
              child: Flexible(
                child: Container(
                  height: 750.h,
                  decoration:
                      BoxDecoration(gradient: themeProvider.scaffoldGradient),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 16.w, top: 16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 30.h),
                              Text(
                                'Hi,${userDetailProvider.userDetail?.displayName}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.w400,
                                  color: themeProvider.casestext,
                                  height: 1.25.h,
                                  letterSpacing: -0.356,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                _getGreeting(),
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.w400,
                                  color: themeProvider.casestext,
                                  height: 1.25.h,
                                  letterSpacing: -0.356,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 8.0.w,
                                          right: 8.0.w,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.feed_rounded),
                                  iconSize: 50,
                                  onPressed: _refreshNews,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'My Feed',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                    color: themeProvider.casestext,
                                    height: 1.25.h,
                                    letterSpacing: -0.356,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.newspaper_rounded),
                                  iconSize: 50,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LawNews(),
                                        settings: RouteSettings(
                                          arguments: _filteredArticles,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'All News',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                    color: themeProvider.casestext,
                                    height: 1.25.h,
                                    letterSpacing: -0.356,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.star),
                                  iconSize: 50,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const JudicialNews(),
                                        settings: RouteSettings(
                                          arguments: _filteredArticles,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'Judiciary News',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                    color: themeProvider.casestext,
                                    height: 1.25.h,
                                    letterSpacing: -0.356,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 28.h),
                        _buildAnnouncements(),
                        SizedBox(height: 16.h),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (var article in _filteredArticles)
                                if (article['image'] != null)
                                  GestureDetector(
                                    onTap: () {
                                      launchURL(article['url']);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 16.w),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 15.w),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: SizedBox(
                                            width: 130.w,
                                            height: 250.h,
                                            child: Image.network(
                                              article['image'],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 16),
                              child: Text(
                                'Notifications',
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.w500,
                                  color: themeProvider.casestext,
                                  height: 1.25.h,
                                  letterSpacing: -0.356,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LawNews(),
                                    settings: RouteSettings(
                                      arguments: _filteredArticles,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'VIEW ALL',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: const Color(0xFFC99F4A),
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.w500,
                                  height: 1.25.h,
                                  letterSpacing: -0.356,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        _buildNewsList(),

                        // Show a loading indicator at the end of the list while fetching more articles
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
