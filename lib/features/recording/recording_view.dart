import 'package:flutter/material.dart';
import 'package:smart_care/constants/design/effects.dart';

class RecordingView extends StatelessWidget {
  const RecordingView({Key? key}) : super(key: key);

  Widget _backBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            boxShadow: Effects.boxShadowEffect(context),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 12,
          ),
        ),
        onTap: () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }

  Widget _recordingColumnView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        // Camera
        Expanded(
          flex: 1,
          child: _videoRecordingView(context),
        ),
        Expanded(
          flex: 1,
          child: _sentenceView(context),
        ),
      ],
    );
  }

  Widget _recordingRowView(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        // Camera
        Expanded(
          flex: 1,
          child: _videoRecordingView(context),
        ),
        Expanded(
          flex: 1,
          child: _sentenceView(context),
        ),
      ],
    );
  }

  Widget _videoRecordingView(BuildContext context) {
    return const Text("This is CameraView");
  }

  Widget _sentenceView(BuildContext context) {

    const List<String> sentences = [
      "안녕",
      "너는보니?",
      "반갑다",
      "안녕",
      "너는보니?",
      "반갑다",
      "안녕",
      "너는보니?",
      "반갑다",
      "안녕",
      "너는보니?",
      "반갑다",
      "안녕",
      "너는보니?",
      "반갑다",
      "안녕",
      "너는보니?",
      "반갑다",
      "안녕",
      "너는보니?",
      "반갑다",
      "안녕",
      "너는보니?",
      "반갑다",
      "안녕",
      "너는보니?",
      "반갑다",
      "안녕",
      "너는보니?",
      "반갑다",
      "안녕",
      "너는보니?",
      "반갑다",
      "안녕",
      "너는보니?",
      "반갑다",
      "안녕",
      "너는보니?",
      "반갑다",
      "안녕",
      "너는보니?",
      "반갑다",
      "안녕",
      "너는보니?",
      "반갑다",
      "안녕",
      "너는보니?",
      "반갑다",
    ];

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: sentences.asMap().entries.map((entry) {
          int idx = entry.key;
          String sentence = entry.value;
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              boxShadow: Effects.boxShadowEffect(context),
            ),
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Text(sentence),
          );
        }).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double marginHorizontal = 80.0;
    const double marginVertical = 40.0;

    MediaQueryData mqData = MediaQuery.of(context);
    double height = mqData.size.height;
    double width = mqData.size.width;
    double whRatio = width / height;

    Widget recordingView = (whRatio > 1.2)
        ? _recordingRowView(context)
        : _recordingColumnView(context);

    return Scaffold(
      body: Stack(children: [
        /// Main view (Camera view, contetns view)
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: marginHorizontal,
            vertical: marginVertical,
          ),
          width: double.infinity,
          height: double.infinity,
          child: recordingView,
        ),

        /// Backward Button
        _backBtn(context),
      ]),
    );
  }
}
