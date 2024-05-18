import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:learning_town_for_kids/Combined/More/More_Item_Detail.dart';
import 'package:learning_town_for_kids/Storage_Provider/Storage_provider.dart';
import 'package:provider/provider.dart';

class MoreItems extends StatefulWidget {
  const MoreItems({super.key});

  @override
  State<MoreItems> createState() => _MoreItemsState();
}

class _MoreItemsState extends State<MoreItems> {

  List<String> imageList = [
    'assets/images/Shapes/shapes.png',
    'assets/images/animals/animals.png',
    'assets/images/Trees/Trees.png',
    'assets/images/Colors/colors.png',
    'assets/images/Vegetables/vegatables.png',
    'assets/images/Fruits/fruits.png',
  ];
  List<dynamic> colorList = [
    const Color(0xffFFB8B8),
    const Color(0xffB5A9FF),
    const Color(0xffFCF207),
    const Color(0xffEF8DFF),
    const Color(0xffFFB8B8),
    const Color(0xffB5A9FF),
  ];

  late AudioPlayer clickSound = AudioPlayer();
  @override
  void initState() {
    super.initState();
    clickSound = AudioPlayer();
  }
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
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height / 11,
        backgroundColor: const Color(0xffFFFFFF),
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0,top: 20),
          child: Text('More',
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
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 3.0),
                child: Container(
                  height: height / 5.4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/SceneriesBack/sceneryback 4.png'),
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
                          height: height / 5.4,
                          child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Image.asset('assets/images/Kids/kid 5.png')
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 13.0,right: 10.0,bottom: 10.0,left: 12.0),
                          child: Text('Choose what do you want to learn.',
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
              Expanded(
                child: GridView.count(
                  padding: EdgeInsets.symmetric(vertical: height / 40, horizontal: width / 12),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 20,
                  children: [
                    inkwellButton(context, width,0, 'Shapes', 'shapes'),
                    inkwellButton(context, width,1, 'Animals', 'animals'),
                    inkwellButton(context, width,2, 'Trees', 'trees'),
                    inkwellButton(context, width,3, 'Colors', 'colors'),
                    inkwellButton(context, width,4, 'Vegetables', 'vegetables'),
                    inkwellButton(context, width,5, 'Fruits', 'fruits'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  InkWell inkwellButton(
      BuildContext context,
      double width,
      int index,
      String title,
      String title2,
      ) {
    var getStorage = Provider.of<StorageProvider>(context);
    return InkWell(
      onTap: () async {
        await _playClickSound();
        getStorage.setLast(index, title2, imageList[index]);
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=> MoreItemDetail(title: title2,)));
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorList[index],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade600,
              blurRadius: 3,
              spreadRadius: 1.5,
              offset: const Offset(0, 0),
            )
          ],
        ),
        child: Column(
          children: [
            SizedBox(
                height: width / 5,
                child: Image.asset(imageList[index])),
            SizedBox(height: width / 50,),
            Text(title,
              style: TextStyle(
                  fontFamily: 'inknut',
                  fontSize: width / 21,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}
