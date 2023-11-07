import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:juridentt/addcase/provider.dart';
import 'package:juridentt/news/news.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';



class JudicialNews extends StatelessWidget {
  const JudicialNews({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NewsApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  _NewsAppState createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  List<dynamic> articles = [];
  int currentPage = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchNews();
    _scrollController.addListener(_scrollListener);
    checkInternetConnectivity();
  }
  Future<void> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      showNoInternetDialog();
    }
  }

  void showNoInternetDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text('Failed to fetch news articles. Please check your internet connection.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const NewsPage()));
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchNews() async {
    const apiKey = '5d53fbf398fe4361a267e25848e6d422';
    final url =
        'https://newsapi.org/v2/everything?q=indian judicial&apiKey=$apiKey&page=$currentPage';
    //'https://newsapi.org/v2/top-headlines?country=in&category=general&apiKey=$apiKey&page=$currentPage';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        articles.addAll(jsonData['articles']);
        currentPage++;
      });
    } else {
      // Handle API error here
      print('Failed to load news');
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      fetchNews();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:themeProvider.newsbar,
        leading: IconButton(
          onPressed:(){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const NewsPage()));
          }, 
          icon: const Icon(Icons.arrow_back,color: Colors.black)),
      ),
      body: 
      Container(
        decoration: BoxDecoration(gradient: themeProvider.scaffoldGradient),
        child: articles.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                controller: _scrollController,
                itemCount: articles.length + 1, // Add 1 for the loading indicator
                itemBuilder: (context, index) {
                  if (index < articles.length) {
                    final article = articles[index];
                    return GestureDetector(
                      onTap: () {
                        launch(article['url']);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            article['urlToImage'] != null
                                ? Image.network(
                                    article['urlToImage'],
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  )
                                : const SizedBox(
                                    width: double.infinity,
                                    height: 200,
                                    child: Icon(Icons.image),
                                  ),
                            const SizedBox(height: 8),
                            Text(
                              article['title'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: themeProvider.casestext
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              article['description'] ?? '',
                              style: TextStyle(fontSize: 14,color: themeProvider.casestext),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
      ),
    );
  }
}
