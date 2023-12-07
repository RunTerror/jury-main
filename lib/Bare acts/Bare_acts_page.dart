import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:juridentt/constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class BareActsPage extends StatefulWidget {
  static const routeName = '/bare-acts';
  const BareActsPage({super.key});

  @override
  State<BareActsPage> createState() => _BareActsPageState();
}

class _BareActsPageState extends State<BareActsPage> {
  Future<File?> _checkDownloaded(String name) async {
    final appDir = await getApplicationDocumentsDirectory();
    final pdfFile = File(join(appDir.path, name));
    final pdfexist = await pdfFile.exists();
    if (pdfexist) {
      return pdfFile;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    TextEditingController searchController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Constants.lightblack,
        ),
        backgroundColor: Constants.lightblack,
        body: Column(
          children: [
            const Text(
              'Bare Acts',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: TextField(
                  controller: searchController,
                )),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('bareacts').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: w,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: ListTile(
                          onTap: () async {
                            final url = snapshot.data!.docs[index]['pdf-1'];
                            final name = snapshot.data!.docs[index]['name'];
                            var pdffile = await _checkDownloaded(name);

                            if (context.mounted) {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return CustomPdf(
                                    file: pdffile,
                                    name: name,
                                    url: url,
                                  );
                                },
                              ));
                            }
                          },
                          title: Text('${snapshot.data!.docs[index]['pdf-1']}'),
                        ),
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                  ),
                );
              },
            ),
          ],
        ));
  }
}

class CustomPdf extends StatefulWidget {
  final File? file;
  final String name;
  final String url;
  const CustomPdf(
      {super.key, required this.url, required this.name, required this.file});

  @override
  State<CustomPdf> createState() => _CustomPdfState();
}

class _CustomPdfState extends State<CustomPdf> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  late PdfViewerController _pdfViewerController;
  late PdfTextSearchResult _searchResult;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    _searchResult = PdfTextSearchResult();
    super.initState();
  }

//   void searchAndNavigateToWord(String word) {
//     _searchResult = _pdfViewerController.searchText(word);

//     if (_searchResult.hasResult) {

// print(_searchResult.currentInstanceIndex);
//       _pdfViewerController.jumpTo();
//     }
//   }

  OverlayEntry? _overlayEntry;
  void _showContextMenu(
      BuildContext context, PdfTextSelectionChangedDetails details) {
    final OverlayState overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: details.globalSelectedRegion!.center.dy - 55,
        left: details.globalSelectedRegion!.bottomLeft.dx,
        child: TextButton(
          child: const Text('Copy', style: TextStyle(fontSize: 17)),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: details.selectedText!));
            _pdfViewerController.clearSelection();
          },
        ),
      ),
    );
    overlayState.insert(_overlayEntry!);
  }

  final TextEditingController _serachedtext = TextEditingController();

  searchText() {
    _searchResult = _pdfViewerController.searchText(
      _serachedtext.text.toString(),
    );
    _searchResult.addListener(() {
      if (_searchResult.hasResult && _searchResult.isSearchCompleted) {
        setState(() {});
        print('${_searchResult.currentInstanceIndex} instance');
      }
    });
  }

  Future<void> _downloadFile() async {
    final response = await http.get(Uri.parse(widget.url));

    if (response.statusCode == 200) {
      print('yes');
      final appDir = await getApplicationDocumentsDirectory();
      final filepath = join(appDir.path, widget.name);
      File file = File(filepath);
      await file.writeAsBytes(response.bodyBytes).then((value) {
        print('downloaded successfully');
      });
    } else {
      print('Network issue');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.file);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _serachedtext,
          onChanged: (value) {
            setState(() {
              if (value == '') {
                _searchResult = _pdfViewerController.searchText(
                  '',
                );
                _searchResult.addListener(() {
                  if (_searchResult.hasResult &&
                      _searchResult.isSearchCompleted) {
                    setState(() {});
                  }
                });
              } else {
                searchText();
              }
            });
          },
        ),
        actions: [
          widget.file == null
              ? IconButton(
                  onPressed: () {
                    _downloadFile();
                  },
                  icon: const Icon(Icons.download))
              : Container(),
          _pdfViewerController.zoomLevel == 2
              ? IconButton(
                  icon: const Icon(
                    Icons.zoom_in,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _pdfViewerController.zoomLevel = 0;
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(
                    Icons.zoom_in,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _pdfViewerController.zoomLevel = 2;
                    });
                  },
                ),
          IconButton(
            icon:const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              _searchResult = _pdfViewerController.searchText('the',
                  searchOption: TextSearchOption.caseSensitive);
              _searchResult.addListener(() {
                if (_searchResult.hasResult) {
                  setState(() {});
                }
              });
            },
          ),
          Visibility(
            visible: _searchResult.hasResult,
            child: IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_left,
                color: Colors.white,
              ),
              onPressed: () {
                _searchResult.previousInstance();
              },
            ),
          ),
          Visibility(
              visible: _searchResult.hasResult,
              child: Center(
                  child: Text(
                      '${_searchResult.currentInstanceIndex}/${_searchResult.totalInstanceCount}'))),
          Visibility(
            visible: _searchResult.hasResult,
            child: IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
              ),
              onPressed: () {
                _searchResult.nextInstance();
              },
            ),
          ),
        ],
      ),
      body: widget.file != null
          ? SfPdfViewer.file(
              widget.file!,
              onTextSelectionChanged: (PdfTextSelectionChangedDetails details) {
                if (details.selectedText == null && _overlayEntry != null) {
                  _overlayEntry!.remove();
                  _overlayEntry = null;
                } else if (details.selectedText != null &&
                    _overlayEntry == null) {
                  _showContextMenu(context, details);
                }
              },
              enableDoubleTapZooming: true,
              pageLayoutMode: PdfPageLayoutMode.single,
              canShowScrollHead: true,
              canShowScrollStatus: true,
              key: _pdfViewerKey,
              canShowPaginationDialog: true,
              controller: _pdfViewerController,
              currentSearchTextHighlightColor: Colors.yellow.withOpacity(0.7),
              otherSearchTextHighlightColor: Colors.yellow.withOpacity(0.3),
            )
          : SfPdfViewer.network(
              onTextSelectionChanged: (PdfTextSelectionChangedDetails details) {
                if (details.selectedText == null && _overlayEntry != null) {
                  _overlayEntry!.remove();
                  _overlayEntry = null;
                } else if (details.selectedText != null &&
                    _overlayEntry == null) {
                  _showContextMenu(context, details);
                }
              },
              enableDoubleTapZooming: true,
              pageLayoutMode: PdfPageLayoutMode.single,
              widget.url,
              canShowScrollHead: true,
              canShowScrollStatus: true,
              key: _pdfViewerKey,
              canShowPaginationDialog: true,
              controller: _pdfViewerController,
              currentSearchTextHighlightColor: Colors.yellow.withOpacity(0.7),
              otherSearchTextHighlightColor: Colors.yellow.withOpacity(0.3),
            ),
    );
  }
}
