import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../Lists/AllLists.dart';

class SlidingItems extends StatefulWidget {
  final String items;
  const SlidingItems({super.key,
    required this.items,
  });
  @override
  State<SlidingItems> createState() => _SlidingItemsState();
}

class _SlidingItemsState extends State<SlidingItems> {

  int current = 0;
  late CarouselController _carouselController;
  List<String> englishAlphabets = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L','M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y','Z',
  ];
  List<int> numbers = [
    1,2,3,4,5,6,7,8,9,10,11,
    12,13,14,15,16,17,18,19,20
  ];
  List<String> urduAlphabets = [
    'ا', 'ب', 'پ', 'ت', 'ٹ', 'ث', 'ج', 'چ', 'ح', 'خ', 'د', 'ڈ', 'ذ', 'ر', 'ڑ', 'ز', 'ژ', 'س', 'ش',
    'ص', 'ض', 'ط', 'ظ', 'ع', 'غ', 'ف', 'ق', 'ک', 'گ', 'ل', 'م', 'ن', 'و', 'ہ', 'ھ', 'ء', 'ی', 'ے',
  ];

  List<dynamic> slidingcolorList = [
    const Color(0xffF70C28),
    const Color(0xff0C4EF7),
    const Color(0xff2EF405),
    const Color(0xffF7DF0C),
    const Color(0xff321115),
    const Color(0xff9B09B2),
    const Color(0xffC35E00),
    const Color(0xff4A0293),
  ];

  late List<dynamic> items;
  late String fontFamily;
  bool urdu = false;
  bool isAutoPlayPaused = true;
  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
    switch (widget.items) {
      case 'alphabets':
        items = englishAlphabets;
        fontFamily = 'bungee';
        break;
      case 'numbers':
        items = numbers.map((e) => e.toString()).toList();
        fontFamily = 'bungee';
        break;
      case 'urdu letters':
        items = urduAlphabets;
        fontFamily = 'katibeh';
        urdu = true;
        break;
      default:
        items = [];
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      playAudioForCurrentItem(0);
    });
     clickSound = AudioPlayer();
  }
  final AudioPlayer audioPlayer = AudioPlayer();

  Future<void> playAudioForCurrentItem(int index) async {
    try {
      String audioPath = '';
      if (widget.items == 'alphabets') {
        audioPath = AllLists.simpleAlphabetsAudios[index];
      } else if (widget.items == 'numbers') {
        audioPath = AllLists.simpleNumbersAudios[index];
      } else if (widget.items == 'urdu letters') {
        audioPath = AllLists.simpleUrduAudios[index];
      }
      await audioPlayer.setAsset(audioPath);
      await audioPlayer.play();
    } catch (e) {
      print(',,,,,,,,,,,,,Error playing audio: $e');
    }
  }

  late AudioPlayer clickSound = AudioPlayer();
  Future<void> _playClickSound() async {
    await clickSound.setAsset('assets/ClickSound/clickSound.wav');
    clickSound.play();
  }

  @override
  void dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    clickSound.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0,top: 20),
          child: Text('Learn ${widget.items}',
            style: TextStyle(
                fontFamily: 'inknut',
                fontSize: width / 20,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffFFFFFF),
                  Color(0xffF3FDB7),
                ]
            )
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 3.0),
              child: Container(
                height: height / 3.6,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/SceneriesBack/sceneryBack 2.png',),
                        fit: BoxFit.fill
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        blurRadius: 2,
                        spreadRadius: 2,
                        offset: const Offset(0, 1),
                      )
                    ]
                ),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: SizedBox(
                        height: height / 3.5,
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Image.asset('assets/images/Kids/kid 3.png')
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 13.0,right: 10.0,bottom: 10.0,left: 8.0),
                        child: Text(widget.items == 'alphabets' ? 'Lets Start! Lets Spell alphabets Together. Are You Ready?' :
                        widget.items == 'numbers' ? 'Lets Start! Lets count the numbers Together. Are You Ready?'
                            : 'Lets Start! Lets Spell urdu letters Together. Are You Ready?',
                          style: TextStyle(
                              fontFamily: 'kalam',
                              fontSize: width / 17,
                              fontWeight: FontWeight.values[5]
                          ),
                          softWrap: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height / 2.6,
              child: CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                    autoPlay: isAutoPlayPaused,
                    reverse: urdu ? true : false,
                    aspectRatio: (width / 100) * 0.43,
                    enlargeCenterPage: true,
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                    viewportFraction: 0.7,
                    onPageChanged: (index, reason) async {
                      setState(() {
                        current = index;
                      });
                      await playAudioForCurrentItem(index);
                    }
                ),
                items: items.asMap().entries.map((entry) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: slidingcolorList[entry.key % slidingcolorList.length],
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade600,
                          blurRadius: 4,
                          spreadRadius: 2,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: widget.items == 'urdu letters' ? 15.0 : 0.0 ),
                        child: Text(entry.value.toString(),
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize:  widget.items == 'numbers'
                                ? width / 2.5 : widget.items == 'alphabets'
                                ? width / 2.5 : width / 2.0,
                            fontWeight: FontWeight.w400,
                            color: slidingcolorList[entry.key % slidingcolorList.length],
                            shadows: [
                              Shadow(
                                color: Colors.grey.shade500,
                                blurRadius: 1,
                                offset: const Offset(6, 0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    await _playClickSound();
                    setState(() {
                        _carouselController.animateToPage(
                          current = 0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                    });
                  },
                  child: Container(
                    height: height / 8.9,
                    width: height / 8.9,
                    decoration: BoxDecoration(
                      color: const Color(0xff131CF4),
                        shape: BoxShape.circle,
                        border: Border.all(
                        color: Colors.grey.shade700,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade600,
                          blurRadius: 3,
                          spreadRadius: 1,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset('assets/images/repeat 1.png',scale: height / 150,),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await _playClickSound();
                    setState(() {
                      isAutoPlayPaused = !isAutoPlayPaused;
                      if (isAutoPlayPaused) {
                        _carouselController.stopAutoPlay();
                      } else {
                        _carouselController.startAutoPlay();
                      }
                    });
                  },
                  child: Container(
                    height: height / 9.2,
                    width: height / 9.2,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey.shade700,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade600,
                          blurRadius: 3,
                          spreadRadius: 1,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset(isAutoPlayPaused ? 'assets/images/play.png'
                          : 'assets/images/forward.png', scale: height / 170,),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if(isAutoPlayPaused!= true) {
                      await _playClickSound();
                      await playAudioForCurrentItem(current);
                    }
                  },
                  child: Container(
                    height: height / 8.9,
                    width: height / 8.9,
                    decoration: BoxDecoration(
                      color: const Color(0xff131CF4),
                        shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey.shade700,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade600,
                          blurRadius: 3,
                          spreadRadius: 1,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset('assets/images/volume 1.png',scale: height / 150,),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
