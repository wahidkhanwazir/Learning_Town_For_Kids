import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:learning_town_for_kids/Combined/ItemsDetail.dart';
import 'package:learning_town_for_kids/Combined/More/More_Item_Detail.dart';
import 'package:learning_town_for_kids/Combined/More/More_main.dart';
import 'package:learning_town_for_kids/Combined/More/Selected_MoreItems.dart';
import 'package:learning_town_for_kids/Home/Explore_Dua.dart';
import 'package:learning_town_for_kids/Lists/AllLists.dart';
import 'package:provider/provider.dart';
import '../Combined/Selected_Item.dart';
import '../Storage_Provider/DuaProvider.dart';
import '../Storage_Provider/Storage_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

@override
class _HomePageState extends State<HomePage> {

  List<dynamic> colorList = [
    const Color(0xffFFB8B8),
    const Color(0xffB5A9FF),
    const Color(0xffFCF207),
    const Color(0xffEF8DFF),
  ];
  List<String> imageList = [
    'assets/images/abc 1.png',
    'assets/images/123 1.png',
    'assets/images/Urdu 1.png',
    'assets/images/more 1.png',
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
    Provider.of<DuaProvider>(context, listen: false).checkForUpdate();
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
          child: Text('Assalamoalaikum !',
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
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                        image: AssetImage('assets/images/masjidBack.png',),
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
                                height: height / 6.3,
                                child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Image.asset('assets/images/Kids/kid.png')))
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 13.0,right: 10.0,bottom: 10.0,left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Learn Dua of the day with me',
                                  style: TextStyle(
                                    fontFamily: 'kalam',
                                    fontSize: width / 17.5,
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
                                          MaterialPageRoute(builder: (context)=> const ExploreDua()));
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
                                        child: Text('Explore',
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
                Padding(
                  padding: EdgeInsets.only(top: height / 55,left: 24.0,bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Continue Learning',
                        style: TextStyle(
                          fontFamily: 'inknut',
                          fontSize: width / 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                  child: InkWell(
                    onTap: () async {
                      await _playClickSound();
                      Navigator.push(context, 
                          MaterialPageRoute(builder: (context)=> 
                              getStorage.getLastImage() == 'assets/images/abc 1.png'
                           || getStorage.getLastImage() == 'assets/images/123 1.png' 
                           || getStorage.getLastImage() == 'assets/images/Urdu 1.png'  
                           ?  ItemsDetail(title: getStorage.getLastCatagory(), index: getStorage.getLastSubCatagory(),) :
                              getStorage.getLastImage() == 'assets/images/Shapes/shapes.png'
                             || getStorage.getLastImage() == 'assets/images/animals/animals.png'
                             || getStorage.getLastImage() == 'assets/images/Trees/Trees.png'
                             || getStorage.getLastImage() == 'assets/images/Colors/colors.png'
                             || getStorage.getLastImage() == 'assets/images/Vegetables/vegatables.png'
                             || getStorage.getLastImage() == 'assets/images/Fruits/fruits.png'
                             ? MoreItemDetail(title: getStorage.getLastCatagory())
                             : SelectedMoreItems(title: getStorage.getLastCatagory(), index: getStorage.getLastSubCatagory()),
                          ));
                    },
                    child: Container(
                      height: height / 10,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xffFF8C3A),
                        borderRadius: BorderRadius.circular(20),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0,top: 4.0,bottom: 4.0),
                            child: Container(
                                height: height / 12,
                                width: width / 3.8,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade700,
                                      blurRadius: 2.5,
                                      spreadRadius: 2,
                                      offset: const Offset(0, 0),
                                    )
                                  ]
                                ),
                                child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Image.asset(getStorage.getLastImage()),
                                    )
                                )
                            ),
                          ),
                          Padding(
                             padding: const EdgeInsets.only(left: 30.0),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(getStorage.getLastCatagory() == 'shapes' ? 'Shapes'
                                    : getStorage.getLastCatagory() == 'animals' ? 'Animals'
                                    : getStorage.getLastCatagory() == 'trees' ? 'Trees'
                                    : getStorage.getLastCatagory() == 'colors' ? 'Colors'
                                    : getStorage.getLastCatagory() == 'vegetables' ? 'Vegetables'
                                    : getStorage.getLastCatagory() == 'fruits' ? 'Fruits'
                                    : getStorage.getLastCatagory(),
                                  style: TextStyle(
                                    fontFamily: 'kalam',
                                    fontSize: width / 18,
                                    fontWeight: FontWeight.w600
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(getStorage.getLastCatagory() == 'alphabets' ?
                                '${getStorage.getLastSubCatagory() + 1} of ${AllLists.allAlphabetsDetail.length} alphabets'
                                  : getStorage.getLastCatagory() == 'numbers' ?
                                '${getStorage.getLastSubCatagory() + 1} of ${AllLists.allNumbersDetail.length} numbers'
                                  : getStorage.getLastCatagory() == 'urdu letters' ?
                                '${getStorage.getLastSubCatagory() + 1} of ${AllLists.allUrduDetail.length} urdu alphabets'
                                  : getStorage.getLastName(),
                                  style: TextStyle(
                                      fontFamily: 'kalam',
                                      fontSize: width / 23,
                                      fontWeight: FontWeight.w500
                                   ),
                                  overflow: TextOverflow.ellipsis,
                                 ),
                               ],
                             ),
                           )
                         ],
                      ),
                    ),
                  ),
                ),
                GridView.count(
                  padding: EdgeInsets.symmetric(vertical: height / 40, horizontal: width / 12),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 20,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    inkwellButton(context, width,0, 'Alphabets', 'alphabets'),
                    inkwellButton(context, width,1, 'Numbers', 'numbers'),
                    inkwellButton(context, width,2, 'Urdu Alphabets', 'urdu letters'),
                    InkWell(
                      onTap: () async {
                        await _playClickSound();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=> const MoreItems()));
                        //getStorage.setLast(0, 'More', imageList[3]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorList[3],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade600,
                                blurRadius: 3,
                                spreadRadius: 1.5,
                                offset: const Offset(0, 0),
                              )
                            ]
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: width / 50,),
                            SizedBox(
                              height: width / 4.8,
                                child: Image.asset(imageList[3])),
                            SizedBox(height: width / 50,),
                            Text('More',
                              style: TextStyle(
                                  fontFamily: 'inknut',
                                  fontSize: width / 25,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                )
              ],
            ),
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
      String passingTitle,
      ) {
    return InkWell(
                  onTap: () async {
                    await _playClickSound();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=> Selecteditem(title: passingTitle,)));
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
                            fontSize: width / 27,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                );
  }
}