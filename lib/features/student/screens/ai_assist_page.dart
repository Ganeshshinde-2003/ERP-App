import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:erp_app/features/student/controller/ai_assist_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ChatGPTScreen extends ConsumerStatefulWidget {
  const ChatGPTScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatGPTScreen> createState() => _ChatGPTScreenState();
}

class _ChatGPTScreenState extends ConsumerState<ChatGPTScreen> {
  final List<Chat> chats = [];
  SpeechToText speechToText = SpeechToText();
  final flutterTTs = FlutterTts();
  final TextEditingController _text = TextEditingController();

  onSendChat() async {
    setState(() {
      isrecording = false;
      isGenerating = true;
    });

    Chat chat = Chat(text: _text.text, isME: true, isimage: false);
    _text.clear();
    setState(() {
      chats.insert(0, chat);
    });

    if (!isimage) {
      String response = await sendtoGPT(chat.text);
      Chat reply = Chat(text: response, isME: false, isimage: false);
      setState(() {
        chats.insert(0, reply);
        if (!istalking) {
          speak();
        }
      });
    } else {
      String response = await sendtodalle(chat.text);
      Chat reply = Chat(text: response, isME: false, isimage: true);
      setState(() {
        chats.insert(0, reply);
      });
    }

    setState(() {
      isGenerating = false;
    });
  }

  Future<String> sendtoDistil(String input) async {
    return await ref.read(aiAssistControllerProvider).sendToDistil(input);
  }

  Future<String> sendtoFinbertTone(String input) async {
    return await ref.read(aiAssistControllerProvider).sendToFinbertTone(input);
  }

  Future<String> sendtoGPT(String message) async {
    return await ref.read(aiAssistControllerProvider).sendToGPT(message, chats);
  }

  Future<String> sendtoSummary(String input) async {
    return await ref.read(aiAssistControllerProvider).sendToSummary(input);
  }

  Future<String> sendtodalle(String message) async {
    return await ref.read(aiAssistControllerProvider).sentToDalle(message);
  }

  Future<String> sendtoCompVis(String input) async {
    return await ref.read(aiAssistControllerProvider).sendToCompVis(input);
  }

  Future<String> sendtoOpenJourney(String input) async {
    return await ref.read(aiAssistControllerProvider).sendToOpenJourney(input);
  }

  bool isimage = false;
  bool istalking = true;
  bool speechEnabled = false;
  bool isrecording = false;
  bool isSpeaking = false;
  bool isGenerating = false;
  String lastWords = '';

  @override
  void initState() {
    _initSpeech();
    _initTTS();
    super.initState();
  }

  @override
  void dispose() {
    flutterTTs.stop();
    super.dispose();
  }

  void _initTTS() async {
    flutterTTs.setStartHandler(() {
      setState(() {
        isSpeaking = true;
      });
    });
    flutterTTs.setCompletionHandler(() {
      isSpeaking = false;
    });
    flutterTTs.setErrorHandler((message) {
      setState(() {
        isSpeaking = false;
      });
    });
  }

  void _initSpeech() async {
    speechEnabled = await speechToText.initialize();
    setState(() {
      speechEnabled = speechEnabled;
    });
  }

  void _startListening() async {
    setState(() {
      isrecording = true;
    });
    await speechToText.listen(onResult: onSpeechResult);
  }

  void _stopListening() async {
    if (_text.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please try again",
        fontSize: 18,
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white70,
        backgroundColor: Colors.grey,
      );
    }
    setState(() {
      isrecording = false;
    });
    await speechToText.stop();
  }

  void onSpeechResult(var result) {
    setState(() {
      lastWords = result.recognizedWords;
      _text.text = lastWords;
    });
    _startListening();
  }

  void speak() async {
    if (!chats[0].isME) {
      if (chats[0].text.isNotEmpty) {
        setState(() {
          istalking = false;
        });
        await flutterTTs.speak(chats[0].text);
      }
    }
  }

  void stop() async {
    if (_text.toString().isEmpty) {
      const snackBar = SnackBar(
        content: Text('Could not process audio.Please try again'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    await flutterTTs.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: buildBottomNavigationBar(),
      appBar: SubPageAppBar(context, 'Doubts with AI'),
      body: buildBody(),
    );
  }

  Widget buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      height: MediaQuery.of(context).size.height * 0.07,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildMicButton(),
          buildVolumeButton(),
        ],
      ),
    );
  }

  Widget buildMicButton() {
    return AvatarGlow(
      // endRadius: isrecording ? 22 : 22,
      animate: true,
      glowColor: isrecording ? Colors.redAccent : Colors.black,
      child: GestureDetector(
        onTap: () async {
          if (!isrecording) {
            _startListening();
          } else {
            _stopListening();
          }
        },
        child: CircleAvatar(
          backgroundColor: isrecording ? Colors.transparent : Colors.white,
          radius: 20,
          child: Icon(
            isrecording ? Icons.stop : Icons.mic,
            color: isrecording ? Colors.redAccent : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget buildVolumeButton() {
    return AvatarGlow(
      // endRadius: istalking ? 22 : 22,
      animate: !istalking,
      glowColor: istalking ? Colors.redAccent : Colors.black,
      child: GestureDetector(
        onTap: () async {
          setState(() {
            istalking = !istalking;
            flutterTTs.stop();
          });
        },
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          child: Icon(
            istalking ? Icons.volume_mute : Icons.surround_sound,
            color: istalking ? Colors.redAccent : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          children: [
            Expanded(
              child: buildChatList(),
            ),
            buildInputArea(),
          ],
        ),
      ],
    );
  }

  Widget buildChatList() {
    return ListView.builder(
      reverse: true,
      itemCount: chats.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildChat(chats[index]);
      },
    );
  }

  Widget buildInputArea() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          buildInputRow(),
        ],
      ),
    );
  }

  Widget buildInputRow() {
    return Row(
      children: [
        Expanded(
          child: buildInputTextField(),
        ),
        buildSendButton(),
      ],
    );
  }

  Widget buildInputTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade100,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4, left: 10),
          child: TextField(
            controller: _text,
            style: AppTextStyles.bodyText,
            decoration: InputDecoration(
              hintText: '   Send a message...',
              border: InputBorder.none,
              hintStyle: AppTextStyles.bodyText,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSendButton() {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(4),
            bottomRight: Radius.circular(4),
          )),
      child: Padding(
        padding: const EdgeInsets.only(left: 4, right: 8),
        child: !isGenerating
            ? GestureDetector(
                onTap: onSendChat,
                child: CircleAvatar(
                  backgroundColor: Colors.greenAccent.shade100.withOpacity(0.6),
                  child: Image.asset(
                    'assets/send-to-AI.png',
                    height: 20,
                    width: 20,
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                child: SizedBox(
                  height: 30,
                  width: 35,
                  child: LoadingIndicator(
                    indicatorType: Indicator.lineScale,
                    colors: [Colors.grey.shade800],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildChat(Chat chat) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
        child: SizedBox(
          width: chat.text.length * MediaQuery.of(context).size.width * 0.1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment:
                  chat.isME ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  child: !chat.isimage
                      ? buildTextMessage(chat)
                      : buildImageMessage(chat),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextMessage(Chat chat) {
    return Column(
      children: [
        chat.isME
            ? Column(
                children: [
                  Text(
                    'You',
                    style:
                        AppTextStyles.heading1.copyWith(color: Colors.blueGrey),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        chat.text,
                        style: AppTextStyles.bodyText
                            .copyWith(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  )
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 17,
                    backgroundColor: Colors.blueAccent,
                    child: Image.asset('assets/chatgpt.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 2),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.shade200,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: (chat.text == chats[0].text)
                            ? AnimatedTextKit(
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    chat.text,
                                    textStyle: AppTextStyles.bodyText.copyWith(
                                        color: Colors.white, fontSize: 14),
                                    speed: const Duration(milliseconds: 50),
                                  ),
                                ],
                                totalRepeatCount: 1,
                                pause: const Duration(milliseconds: 50),
                                displayFullTextOnTap: true,
                                stopPauseOnTap: true,
                              )
                            : Text(
                                chat.text,
                                style: AppTextStyles.bodyText.copyWith(
                                    color: Colors.white, fontSize: 14),
                              ),
                      ),
                    ),
                  )
                ],
              ),
      ],
    );
  }

  Widget buildImageMessage(Chat chat) {
    return Column(
      children: [
        CircleAvatar(
          radius: 17,
          backgroundColor: Colors.black,
          child: Image.asset('assets/chatgpt.png'),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            height: 280,
            width: 280,
            decoration: BoxDecoration(
                color: Colors.blueAccent.shade200,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  chat.text,
                  height: 270,
                  width: 270,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Chat {
  final String text;
  final bool isME;
  final bool isimage;

  Chat({required this.text, required this.isME, required this.isimage});
}
