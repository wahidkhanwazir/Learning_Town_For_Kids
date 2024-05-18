import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:learning_town_for_kids/Lists/AllLists.dart';
import 'package:provider/provider.dart';

import '../Storage_Provider/Storage_provider.dart';

class ItemsDetail extends StatefulWidget {
  int index;
  final String title;
  ItemsDetail({super.key,
    required this.index,
    required this.title,
  });

  @override
  State<ItemsDetail> createState() => _ItemsDetailState();
}

class _ItemsDetailState extends State<ItemsDetail> {

  late String items;
  late String detail;
  late int listLength;
  @override
  void initState() {
    super.initState();
    updateItems();
    playSimpleAudioForCurrentIndex(widget.index);
    clickSound = AudioPlayer();
  }

  void updateItems() {
    switch (widget.title) {
      case 'alphabets':
        items = AllLists.allAlphabetsDetail[widget.index];
        detail = AllLists.alphabetsImages[widget.index];
        listLength = AllLists.allAlphabetsDetail.length;
        break;
      case 'numbers':
        items = AllLists.allNumbersDetail[widget.index];
        detail = AllLists.numbersImages[widget.index];
        listLength = AllLists.allNumbersDetail.length;
        break;
      case 'urdu letters':
        items = AllLists.allUrduDetail[widget.index];
        detail = AllLists.urduImages[widget.index];
        listLength = AllLists.allUrduDetail.length;
        break;
      default:
    }
  }

  final AudioPlayer simpleAudioPlayer = AudioPlayer();

  Future<void> playSimpleAudioForCurrentIndex(int index) async {
    try {
      String audioPath = '';
      if (widget.title == 'alphabets') {
        audioPath = AllLists.simpleAlphabetsAudios[widget.index];
      } else if (widget.title == 'numbers') {
        audioPath = AllLists.simpleNumbersAudios[widget.index];
      } else if (widget.title == 'urdu letters') {
        audioPath = AllLists.simpleUrduAudios[widget.index];
      }
      await simpleAudioPlayer.setAsset(audioPath);
      await simpleAudioPlayer.play();
    } catch (e) {
      print(',,,,,,,,,,,,,Error playing audio: $e');
    }
  }

  Future<void> playDetailAudioForCurrentIndex(int index) async {
    try {
      String audioPath = '';
      if (widget.title == 'alphabets') {
        audioPath = AllLists.detailAlphabetsAudios[widget.index];
      } else if (widget.title == 'numbers') {
        audioPath = AllLists.detailNumbersAudios[widget.index];
      } else if (widget.title == 'urdu letters') {
        audioPath = AllLists.detailUrduAudios[widget.index];
      }
      await simpleAudioPlayer.setAsset(audioPath);
      await simpleAudioPlayer.play();
    } catch (e) {
      print(',,,,,,,,,,,,,Error playing audio: $e');
    }
  }

  @override
  void dispose() {
    simpleAudioPlayer.stop();
    simpleAudioPlayer.dispose();
    clickSound.dispose();
    super.dispose();
  }

  late AudioPlayer clickSound = AudioPlayer();
  Future<void> _playClickSound() async {
    await clickSound.setAsset('assets/ClickSound/clickSound.wav');
    clickSound.play();
  }

  @override
  Widget build(BuildContext context) {
    var getStorage = Provider.of<StorageProvider>(context);
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
      ),
      body: Center(
        child: Container(
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
                child: Stack(
                  children: [
                    Container(
                     height: height / 5,
                     width: double.infinity,
                     decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                        image: const DecorationImage(
                            image: AssetImage('assets/images/SceneriesBack/sceneryBack 3.png',),
                            fit: BoxFit.cover
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
                            height: height / 5,
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Image.asset('assets/images/Kids/kid 4.png')
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0,right: 5.0,),
                            child: Column(
                              children: [
                                Text(items,
                                  style: TextStyle(
                                      fontFamily: 'kalam',
                                      fontSize: width / 19,
                                      fontWeight: FontWeight.values[5],
                                  ),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                    Positioned(
                      bottom: 5,
                      right: 10,
                      child: InkWell(
                        onTap: () async {
                          await _playClickSound();
                          await playDetailAudioForCurrentIndex(widget.index);
                        },
                        child: Container(
                          height: height / 22,
                          width: width / 2.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 2,
                                    offset: Offset(0,0)
                                )
                              ]
                          ),
                          child: Center(
                            child: Text('Learn More',
                              style: TextStyle(
                                  fontFamily: 'kalam',
                                  fontSize: width / 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                 ]
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: height / 30, bottom: height / 40, left: width / 15, right: width / 15),
                child: Container(
                  height: height / 2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        blurRadius: 2,
                        spreadRadius: 2,
                      )
                    ]
                  ),
                  child: Center(
                      child: Image.asset(detail,fit: BoxFit.fitHeight,)),
                  // child: Column(
                  //   children: [
                  //     Text('Aa',
                  //       style: TextStyle(
                  //         fontFamily: 'alfaSlabOne',
                  //         fontSize: width / 4.5,
                  //         fontWeight: FontWeight.w400,
                  //         color: const Color(0xffF70C28),
                  //         shadows: [
                  //           Shadow(
                  //             color: Colors.grey.shade400,
                  //             blurRadius: 1,
                  //             offset: const Offset(5, 0),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       height: height / 5,
                  //         child: Image.asset('assets/images/Allah.png')),
                  //     Text('Allah',
                  //       style: TextStyle(
                  //         fontFamily: 'abeezee',
                  //         fontSize: width / 6,
                  //         fontWeight: FontWeight.w400,
                  //         shadows: [
                  //           Shadow(
                  //             color: Colors.grey.shade400,
                  //             blurRadius: 1,
                  //             offset: const Offset(5, 0),
                  //           ),
                  //         ],
                  //       ),
                  //     )
                  //   ],
                  // ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      await _playClickSound();
                      if (widget.index >= 1) {
                        setState(() {
                          widget.index--;
                          updateItems();
                          playSimpleAudioForCurrentIndex(widget.index);
                        });
                      }
                      getStorage.setLast(
                        widget.index,
                        widget.title == 'alphabets' ? 'alphabets'
                            : widget.title == 'numbers' ? 'numbers'
                            : widget.title == 'urdu letters' ? 'urdu letters'
                            : 'More',
                        widget.title == 'alphabets' ? 'assets/images/abc 1.png'
                            : widget.title == 'numbers' ? 'assets/images/123 1.png'
                            : widget.title == 'urdu letters' ? 'assets/images/Urdu 1.png'
                            : 'assets/images/more 1.png',);
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
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: SizedBox(
                              height: height / 9.8,
                              width: height / 9.8,
                              child: Image.asset('assets/images/backward.png')),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await _playClickSound();
                      await playSimpleAudioForCurrentIndex(widget.index);
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
                        child: SizedBox(
                            height: height / 10,
                            width: height / 10,
                            child: Image.asset('assets/images/volume 1.png')),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await _playClickSound();
                      if (widget.index < listLength - 1) {
                        setState(() {
                          widget.index++;
                          updateItems();
                          playSimpleAudioForCurrentIndex(widget.index);
                        });
                      }
                      getStorage.setLast(
                        widget.index,
                        widget.title == 'alphabets' ? 'alphabets'
                            : widget.title == 'numbers' ? 'numbers'
                            : widget.title == 'urdu letters' ? 'urdu letters'
                            : 'More',
                        widget.title == 'alphabets' ? 'assets/images/abc 1.png'
                            : widget.title == 'numbers' ? 'assets/images/123 1.png'
                            : widget.title == 'urdu letters' ? 'assets/images/Urdu 1.png'
                            : 'assets/images/more 1.png',);
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
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: SizedBox(
                              height: height / 9.8,
                              width: height / 9.8,
                              child: Image.asset('assets/images/forward.png')),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
