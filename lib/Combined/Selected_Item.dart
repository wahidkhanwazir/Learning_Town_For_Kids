import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:learning_town_for_kids/Combined/ItemsDetail.dart';
import 'package:learning_town_for_kids/Lists/AllLists.dart';
import 'package:provider/provider.dart';
import '../Storage_Provider/Storage_provider.dart';
import 'Sliding_Items.dart';

class Selecteditem extends StatefulWidget {
  final String title;
  const Selecteditem({super.key,
    required this.title,
  });

  @override
  State<Selecteditem> createState() => _SelecteditemState();
}

class _SelecteditemState extends State<Selecteditem> {

  List<String> englishAlphabets = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L','M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y','Z',
  ];
  List<int> numbers = [
    1,2,3,4,5,6,7,8,9,10,11,
    12,13,14,15,16,17,18,19,20
  ];

  List<dynamic> colorList = [
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
  @override
  void initState() {
    super.initState();
    switch (widget.title) {
      case 'alphabets':
        items = englishAlphabets;
        fontFamily = 'bungee';
        break;
      case 'numbers':
        items = numbers.map((e) => e.toString()).toList();
        fontFamily = 'bungee';
        break;
      case 'urdu letters':
        items = AllLists.urduLetters;
        fontFamily = 'katibeh';
        break;
      default:
        items = [];
        colorList = [];
    }
    clickSound = AudioPlayer();
  }

  late AudioPlayer clickSound = AudioPlayer();
  @override
  void dispose() {
    clickSound.dispose();
    super.dispose();
  }
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
        toolbarHeight: height / 11,
        backgroundColor: const Color(0xffFFFFFF),
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0,top: 20),
          child: Text('Learn ${widget.title}',
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
                height: height / 5.6,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/SceneriesBack/sceneryBack1.png',),
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
                        height: height / 5.8,
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Image.asset('assets/images/Kids/kid 2.png',)
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 13.0,right: 10.0,bottom: 10.0,left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Learn ${widget.title} with me. Repeat with me',
                              style: TextStyle(
                                  fontFamily: 'kalam',
                                  fontSize: width / 21,
                                  fontWeight: FontWeight.values[5]
                              ),
                              softWrap: true,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () async {
                                  await _playClickSound();
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context)=> SlidingItems(
                                        items: widget.title,
                                      )));
                                },
                                child: Container(
                                  height: height / 22,
                                  width: width / 3.1,
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
                                    child: Text('Start',
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                padding: EdgeInsets.symmetric(horizontal: width / 20,vertical: 20),
                crossAxisCount: 2,
                mainAxisSpacing: height / 25,
                crossAxisSpacing: width / 12,
                shrinkWrap: true,
                children: List.generate(items.length, (index) {
                  return InkWell(
                    onTap: () async {
                      await _playClickSound();
                      getStorage.setLast(
                        index,
                          widget.title == 'alphabets' ? 'alphabets'
                              : widget.title == 'numbers' ? 'numbers'
                              : widget.title == 'urdu letters' ? 'urdu letters'
                              : 'More',
                          '',
                        widget.title == 'alphabets' ? 'assets/images/abc 1.png'
                            : widget.title == 'numbers' ? 'assets/images/123 1.png'
                            : widget.title == 'urdu letters' ? 'assets/images/Urdu 1.png'
                            : 'assets/images/more 1.png',
                      );
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> ItemsDetail(
                            index: index,
                            title: widget.title,
                          )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade600,
                            blurRadius: 3,
                            spreadRadius: 1.5,
                            offset: const Offset(0, 0),
                          )
                        ],
                      ),
                      child: Center(
                          child: widget.title == 'numbers' || widget.title == 'alphabets' ?
                          Text(items[index],
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: widget.title == 'numbers'
                                ? width / 4.4 : widget.title == 'alphabets'
                                ? width / 3.8 : width / 3.5,
                            fontWeight: FontWeight.w400,
                            color: colorList[index % colorList.length],
                            shadows: [
                              Shadow(
                                color: Colors.grey.shade400,
                                blurRadius: 1,
                                offset: const Offset(5, 0),
                              ),
                            ],
                          )
                        )
                        : SizedBox(
                              height: width / 4.5,
                              width: width / 4.5,
                              child: Image.asset(items[index],))
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
