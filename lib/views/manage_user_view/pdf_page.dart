import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfPage extends StatefulWidget {
  final String? path;

  PdfPage({Key? key, this.path}) : super(key: key);

  @override
  _PdfPage createState() => _PdfPage();
}

class _PdfPage extends State<PdfPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  PdfViewerController _pdfViewerController = PdfViewerController();
  String? fileName;

  @override
  void initState() {
    super.initState();
    Uri uri = Uri.parse(widget.path ?? '');
    fileName = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : 'PDF Document';
    print('Loading PDF from: ${widget.path}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fileName ?? 'PDF Document'),
        titleTextStyle: TextStyle(
          color: Colors.blueAccent,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.blueAccent),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: widget.path != null
          ? SfPdfViewer.network(
        widget.path!,
        controller: _pdfViewerController,
        canShowPageLoadingIndicator: true,
        canShowHyperlinkDialog: true,
        canShowPaginationDialog: true,
        canShowScrollStatus: true,
        onHyperlinkClicked: (hyperlink) async {
          if (!await launchUrl(hyperlink as Uri)) {
            throw Exception('Could not launch $hyperlink');
          }
          print('Hyperlink clicked $hyperlink');
        },
        canShowScrollHead: true,
        currentSearchTextHighlightColor: Colors.blueAccent,
        enableHyperlinkNavigation: true,
        onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
          print('Document Load Failed: ${details.description}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to load document: ${details.description}'),
              backgroundColor: Colors.red,
            ),
          );
        },
        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Document Loaded'),
            ),
          );
          print('Document Loaded');
        },
        onTap: (details) {
          print('Tapped at page - ${details.pageNumber}');
        },
        enableTextSelection: true,
        enableDoubleTapZooming: true,
        onPageChanged: (details) {
          print('Page Changed: ${details.newPageNumber}');
        },
        key: _pdfViewerKey,
      )
          : Center(
        child: Text(
          'No PDF path provided.',
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      ),
    );
  }
}
