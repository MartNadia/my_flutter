import 'package:flutter/material.dart';

class Structura extends StatefulWidget {
  const Structura({Key? key}) : super(key: key);
  @override
  State<Structura> createState() => MyStructure();
}

class MyStructure extends State<Structura> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Структура'),
      ),
      body: Center(
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 30,
                    width: 1,
                    color: Colors.black,
                  ),
                  Container(
                    height: 30,
                    width: 1,
                    color: Colors.black,
                  ),
                  Container(
                    height: 30,
                    width: 1,
                    color: Colors.black,
                  ),
                  Container(
                    height: 30,
                    width: 1,
                    color: Colors.black,
                  ),
                  Container(
                    height: 30,
                    width: 1,
                    color: Colors.black,
                  ),
                ],
              ),
              Container(
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
                ),
              ),
              Container(
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}