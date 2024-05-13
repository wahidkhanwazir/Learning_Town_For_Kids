import 'package:flutter/material.dart';
import 'package:learning_town_for_kids/Lists/AllLists.dart';

class MoreItemDetail extends StatefulWidget {
  final String title;
  const MoreItemDetail({super.key,
    required this.title,
  });

  @override
  State<MoreItemDetail> createState() => _MoreItemDetailState();
}

class _MoreItemDetailState extends State<MoreItemDetail> {
  
  List<dynamic> colorList = [
    const Color(0xffFEE0A6),
    const Color(0xffFCC6C6),
    const Color(0xffCEFDFA),
    const Color(0xffC3F9CB),
    const Color(0xffD0CFFF),
    const Color(0xffF7C9FF),
  ];

  late List<dynamic> items;
  @override
  void initState() {
    super.initState();
    switch (widget.title) {
      case 'shapes':
        items = AllLists.shapes;
        break;
      case 'animals':
        items = AllLists.animals;
        break;
      case 'trees':
        items = AllLists.trees;
        break;
      case 'colors':
        items = AllLists.colors;
        break;
      case 'vegetables':
        items = AllLists.vegetables;
        break;
      case 'fruits':
        items = AllLists.fruits;
        break;
      default:
        items = [];
        //colorList = [];
    }
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
                          image: AssetImage('assets/images/SceneriesBack/sceneryback 4.png',),
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
                          child: Text(widget.title == 'shapes' ? 'Tap on the shape to start learning'
                              : widget.title == 'animals' ? 'Learn about different animals'
                              : widget.title == 'trees' ? 'You know different types of trees? Learn now'
                              : widget.title == 'colors' ? 'colors,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,'
                              : widget.title == 'vegetables' ? 'vegetables ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,'
                              : 'fruits ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,',
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
                  padding: EdgeInsets.symmetric(horizontal: width / 20,vertical: 20),
                  crossAxisCount: 2,
                  mainAxisSpacing: height / 35,
                  crossAxisSpacing: width / 19,
                  shrinkWrap: true,
                  children: List.generate(items.length, (index) {
                    return InkWell(
                      onTap: (){
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context)=> ItemsDetail(
                        //       index: index,
                        //       title: widget.title,
                        //     )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget.title == 'shapes' ? Colors.white
                          : colorList[index % colorList.length],
                          borderRadius: BorderRadius.circular(20),
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
                            child: SizedBox(
                                height: width / 2.7,
                                width: width / 2.7,
                                child: Image.asset(items[index]))),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
