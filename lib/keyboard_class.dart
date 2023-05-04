import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyboardScreen extends StatefulWidget {
  @override
  _KeyboardScreenState createState() => _KeyboardScreenState();
}

class _KeyboardScreenState extends State<KeyboardScreen> {
  final TextToSpeech tts = TextToSpeech();
  final TextEditingController _textEditingController = TextEditingController();
  final List<String> _bookmarkedItems = [];
  SharedPreferences? _prefs;
  Offset? _position;

  @override
  void initState() {
    //  _position = Offset(0, 0);
    super.initState();
    _loadBookmarks();
  }

  void _loadBookmarks() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _bookmarkedItems.addAll(_prefs!.getStringList('bookmarks') ?? []);
    });
  }

  void _addBookmark(String text) {
    setState(() {
      _bookmarkedItems.add(text);
    });
    _prefs!.setStringList('bookmarks', _bookmarkedItems);
  }

  double _buttonSize = 100.0; // Initial size of the button

  void _clearInput() {
    setState(() {
      _textEditingController.clear();
    });
  }

  void _handleTextInput(String text) {
    setState(() {
      _textEditingController.text += text;
    });
    tts.speak(_textEditingController.text);
  }

  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Stylus Keyboard'),
          actions: [
            IconButton(
              icon: Icon(Icons.bookmark),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookmarksScreen(
                      bookmarks: _bookmarkedItems,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (event) {
            print('enter');
            setState(() {
              _isHovering = true;
            });
          },
          onHover: (event) {
            print('howe');
          },
          onExit: (event) {
            setState(() {
              _isHovering = false;
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            width: _isHovering ? 120.0 : 100.0,
            height: _isHovering ? 120.0 : 100.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Text(
                "Hover over me",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ), //  Listener(
          //   onPointerHover: (event) {
          //     setState(() {
          //       print('event is $event');
          //       _position = event.position;
          //     });
          //   },
          //   child: Container(
          //     padding: EdgeInsets.all(16.0),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Expanded(
          //           child: Center(
          //             child: TextField(
          //               controller: _textEditingController,
          //               decoration: InputDecoration(
          //                 border: OutlineInputBorder(),
          //                 hintText: 'Type here...',
          //               ),
          //               readOnly: true,
          //             ),
          //           ),
          //         ),
          //         SizedBox(height: 16.0),

          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceAround,
          //           children: [
          //             CustomButton(
          //               text: 'Clear',
          //               onTap: _clearInput,
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //             CustomButton(
          //               text: 'A',
          //               onTap: () => _handleTextInput('A'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //             CustomButton(
          //               text: 'B',
          //               onTap: () => _handleTextInput('B'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //             CustomButton(
          //               text: 'C',
          //               onTap: () => _handleTextInput('C'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //           ],
          //         ),
          //         SizedBox(height: 16.0),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceAround,
          //           children: [
          //             CustomButton(
          //               text: 'D',
          //               onTap: () => _handleTextInput('D'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //             CustomButton(
          //               text: 'E',
          //               onTap: () => _handleTextInput('E'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //             CustomButton(
          //               text: 'F',
          //               onTap: () => _handleTextInput('F'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //           ],
          //         ),
          //         SizedBox(height: 16.0),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceAround,
          //           children: [
          //             CustomButton(
          //               text: 'G',
          //               onTap: () => _handleTextInput('G'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //             CustomButton(
          //               text: 'H',
          //               onTap: () => _handleTextInput('H'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //             CustomButton(
          //               text: 'I',
          //               onTap: () => _handleTextInput('I'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //             CustomButton(
          //               text: 'J',
          //               onTap: () => _handleTextInput('J'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //           ],
          //         ),
          //         SizedBox(height: 16.0),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceAround,
          //           children: [
          //             CustomButton(
          //               text: 'K',
          //               onTap: () => _handleTextInput('K'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //             CustomButton(
          //               text: 'L',
          //               onTap: () => _handleTextInput('L'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //             CustomButton(
          //               text: 'M',
          //               onTap: () => _handleTextInput('M'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //             CustomButton(
          //               text: 'N',
          //               onTap: () => _handleTextInput('N'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //           ],
          //         ),
          //         SizedBox(height: 16.0),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceAround,
          //           children: [
          //             CustomButton(
          //               text: 'O',
          //               onTap: () => _handleTextInput('O'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //             CustomButton(
          //               text: 'P',
          //               onTap: () => _handleTextInput('P'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //             CustomButton(
          //               text: 'Q',
          //               onTap: () => _handleTextInput('Q'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //             CustomButton(
          //               text: 'R',
          //               onTap: () => _handleTextInput('R'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //           ],
          //         ),
          //         SizedBox(height: 16.0),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceAround,
          //           children: [
          //             CustomButton(
          //               text: 'S',
          //               onTap: () => _handleTextInput('S'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //             CustomButton(
          //               text: 'T',
          //               onTap: () => _handleTextInput('T'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //             CustomButton(
          //               text: 'T',
          //               onTap: () => _handleTextInput('T'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //             CustomButton(
          //               text: 'U',
          //               onTap: () => _handleTextInput('U'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //             CustomButton(
          //               text: 'V',
          //               onTap: () => _handleTextInput('V'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //             CustomButton(
          //               text: 'W',
          //               onTap: () => _handleTextInput('W'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //           ],
          //         ),
          //         SizedBox(height: 16.0),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceAround,
          //           children: [
          //             CustomButton(
          //               text: 'X',
          //               onTap: () => _handleTextInput('X'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //             CustomButton(
          //               text: 'Y',
          //               onTap: () => _handleTextInput('Y'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //             CustomButton(
          //               text: 'Z',
          //               onTap: () => _handleTextInput('Z'),
          //               size: _position != null ? 64.0 : null,
          //               position: _position,
          //             ),
          //             CustomButton(
          //               text: 'Bookmark',
          //               onTap: () {
          //                 _addBookmark(_textEditingController.text);
          //               },
          //               size: _position != null ? 96.0 : null,
          //               position: _position,
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ));
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final double? size;
  final Offset? position;

  CustomButton({
    required this.text,
    required this.onTap,
    this.size,
    this.position,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class BookmarksScreen extends StatelessWidget {
  final List<String> bookmarks;

  BookmarksScreen({required this.bookmarks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
      ),
      body: ListView.builder(
        itemCount: bookmarks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(bookmarks[index]),
          );
        },
      ),
    );
  }
}

class TextToSpeech {
  FlutterTts _flutterTts = FlutterTts();

  Future<void> speak(String text) async {
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.speak(text);
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }
}
