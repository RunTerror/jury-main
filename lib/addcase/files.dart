// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class Downloadfiles extends StatefulWidget {
  const Downloadfiles({super.key});

  @override
  State<Downloadfiles> createState() => _DownloadfilesState();
}

class _DownloadfilesState extends State<Downloadfiles> {
  late Future<ListResult> futureFiles;
  Map<int, double> downloadProgress = {};

  @override
  void initState() {
    futureFiles = FirebaseStorage.instance.ref().listAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<ListResult>(
          future: futureFiles,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final files = snapshot.data!.items;
              return ListView.builder(
                itemCount: files.length,
                itemBuilder: (context, index) {
                  final file = files[index];
                  double? progress = downloadProgress[index];
                  return ListTile(
                    title: (Text(
                      file.name,
                    )),
                    subtitle: progress != null
                        ? LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.black26,
                          )
                        : null,
                    trailing: IconButton(
                      onPressed: () {
                        downloadFile(index, file);
                      },
                      icon: const Icon(
                        Icons.download,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Future downloadFile(int index, Reference ref) async {
    final url = await ref.getDownloadURL();

    // Visible to user inside gallery.
    // final tempDir = await getTemporaryDirectory();
    final tempDir = await getExternalStorageDirectory();
    // final path = '${tempDir.path}/${ref.name}';
    final path = '${tempDir!.path}/${ref.name}';
    await Dio().download(url, path, onReceiveProgress: (received, total) {
      double progress = received / total;
      setState(() {
        downloadProgress[index] = progress;
      });
    });

    // if (url.contains('.mp4')) {
    //   await GallerySaver.saveVideo(path, toDcim: true);
    // } else if (url.contains('.jpg') || url.contains('.png')) {
    //   await GallerySaver.saveImage(path, toDcim: true);
    // }

    if (url.contains('.pdf')) {
      final downloadsDir = await getExternalStorageDirectory();
      final downloadsPath = '${downloadsDir!.path}/${ref.name}';
      // print('the download path is $downloadsPath');
      await Dio().download(url, downloadsPath);
    } else if (url.contains('.mp4')) {
      await GallerySaver.saveVideo(path, toDcim: true);
    } else if (url.contains('.jpg') || url.contains('.png')) {
      await GallerySaver.saveImage(path, toDcim: true);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'File downloaded ${ref.name} successfully!',
        ),
      ),
    );
  }
}
