import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Storage_Provider/DuaProvider.dart';

class ExploreDua extends StatefulWidget {
  const ExploreDua({super.key});

  @override
  State<ExploreDua> createState() => _ExploreDuaState();
}

class _ExploreDuaState extends State<ExploreDua> {

  @override
  Widget build(BuildContext context) {
    var duaProvider = Provider.of<DuaProvider>(context);
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
                          Text('Dua of the day',
                            style: TextStyle(
                                fontSize: width / 25,
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
                          child: Text(duaProvider.duaList[duaProvider.currentIndex],
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
            ],
          ),
        ),
      ),
    );
  }
}