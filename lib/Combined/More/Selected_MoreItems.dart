import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import '../../Lists/AllLists.dart';
import '../../Storage_Provider/Storage_provider.dart';

class SelectedMoreItems extends StatefulWidget {
  final String title;
  int index;
  SelectedMoreItems({super.key,
    required this.title,
    required this.index,
  });

  @override
  State<SelectedMoreItems> createState() => _SelectedMoreItemsState();
}

class _SelectedMoreItemsState extends State<SelectedMoreItems> {

  late String itemImage;
  late String itemName;
  late String itemDetail;
  late int listLength;
  @override
  void initState() {
    super.initState();
    updateItems();
    playDetailAudioForCurrentIndex(widget.index);
    clickSound = AudioPlayer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var getStorage = Provider.of<StorageProvider>(context, listen: false);
      getStorage.setLast(
        widget.index,
        widget.title == 'shapes' ? 'shapes'
            : widget.title == 'animals' ? 'animals'
            : widget.title == 'trees' ? 'trees'
            : widget.title == 'colors' ? 'colors'
            : widget.title == 'vegetables' ? 'vegetables'
            : 'fruits',
        itemName,
        itemImage,
      );
    });
  }

  void updateItems() {
    switch (widget.title) {
      case 'shapes':
        itemImage = AllLists.shapesImages[widget.index];
        itemName = AllLists.shapesNames[widget.index];
        itemDetail = AllLists.shapesDetail[widget.index];
        listLength = AllLists.shapesNames.length;
        break;
      case 'animals':
        itemImage = AllLists.animalsImages[widget.index];
        itemName = AllLists.animalNames[widget.index];
        itemDetail = AllLists.animalDetail[widget.index];
        listLength = AllLists.animalNames.length;
        break;
      case 'trees':
        itemImage = AllLists.treesImages[widget.index];
        itemName = AllLists.treesNames[widget.index];
        itemDetail = AllLists.treesDetail[widget.index];
        listLength = AllLists.treesNames.length;
        break;
      case 'colors':
        itemImage = AllLists.colorsImages[widget.index];
        itemName = AllLists.colorsNames[widget.index];
        itemDetail = AllLists.colorsDetail[widget.index];
        listLength = AllLists.colorsNames.length;
        break;
      case 'vegetables':
        itemImage = AllLists.vegetablesImages[widget.index];
        itemName = AllLists.vegetablesNames[widget.index];
        itemDetail = AllLists.vegetablesDetail[widget.index];
        listLength = AllLists.vegetablesNames.length;
        break;
      case 'fruits':
        itemImage = AllLists.fruitsImages[widget.index];
        itemName = AllLists.fruitsNames[widget.index];
        itemDetail = AllLists.fruitsDetail[widget.index];
        listLength = AllLists.fruitsNames.length;
        break;
    }
  }

  final AudioPlayer simpleAudioPlayer = AudioPlayer();
  Future<void> playDetailAudioForCurrentIndex(int index) async {
    try {
      String audioPath = '';
      if (widget.title == 'shapes') {
        audioPath = AllLists.shapesAudios[widget.index];
      } else if (widget.title == 'animals') {
        audioPath = AllLists.animalAudios[widget.index];
      } else if (widget.title == 'trees') {
        audioPath = AllLists.treesAudios[widget.index];
      } else if (widget.title == 'colors') {
        audioPath = AllLists.colorsAudios[widget.index];
      } else if (widget.title == 'vegetables') {
        audioPath = AllLists.vegetablesAudios[widget.index];
      } else if (widget.title == 'fruits') {
        audioPath = AllLists.fruitsAudios[widget.index];
        audioPath = AllLists.fruitsAudios[index];
      }
      await simpleAudioPlayer.setAsset(audioPath);
      await simpleAudioPlayer.play();
    } catch (e) {
      print(',,,,,,,,,,,,,Error playing audio: $e');
    }
  }

  @override
  void dispose() {
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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black, width: 1.8)
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back)),
                            Text(itemName,
                              style: TextStyle(
                                  fontSize: width / 18,
                                  fontFamily: 'inknut',
                                  fontWeight: FontWeight.bold
                              ),),
                            Container(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 11.0),
                  child: Container(
                    height: height / 1.4,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade500, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade600,
                          blurRadius: 2,
                          spreadRadius: 2,
                          offset: const Offset(0, 1),
                        )
                      ],
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: height / 4.3,
                              child: Image.asset(itemImage),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(itemDetail,
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'inknut',
                                fontWeight: FontWeight.bold
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                            playDetailAudioForCurrentIndex(widget.index);
                          });
                        }
                        getStorage.setLast(
                          widget.index,
                          widget.title == 'shapes' ? 'shapes'
                              : widget.title == 'animals' ? 'animals'
                              : widget.title == 'trees' ? 'trees'
                              : widget.title == 'colors' ? 'colors'
                              : widget.title == 'vegetables' ? 'vegetables'
                              : 'fruits',
                          itemName,
                          itemImage,
                        );
                      },
                      child: Container(
                        height: height / 10,
                        width: height / 10,
                        decoration: BoxDecoration(
                          color: const Color(0xff131CF4),
                          borderRadius: BorderRadius.circular(30),
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
                                height: height / 10.2,
                                width: height / 10.2,
                                child: Image.asset('assets/images/backward.png',color: Colors.white,)),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                         await _playClickSound();
                         await playDetailAudioForCurrentIndex(widget.index);
                      },
                      child: Container(
                        height: height / 10,
                        width: height / 10,
                        decoration: BoxDecoration(
                          color: const Color(0xffFF7A00),
                          borderRadius: BorderRadius.circular(30),
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
                              height: height / 12,
                              width: height / 12,
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
                            playDetailAudioForCurrentIndex(widget.index);
                          });
                        }
                        getStorage.setLast(
                          widget.index,
                          widget.title == 'shapes' ? 'shapes'
                              : widget.title == 'animals' ? 'animals'
                              : widget.title == 'trees' ? 'trees'
                              : widget.title == 'colors' ? 'colors'
                              : widget.title == 'vegetables' ? 'vegetables'
                              : 'fruits',
                          itemName,
                          itemImage,
                        );
                      },
                      child: Container(
                        height: height / 10,
                        width: height / 10,
                        decoration: BoxDecoration(
                          color: const Color(0xff131CF4),
                          borderRadius: BorderRadius.circular(30),
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
                                height: height / 10.2,
                                width: height / 10.2,
                                child: Image.asset('assets/images/forward.png',color: Colors.white,)),
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
      ),
    );
  }
}
