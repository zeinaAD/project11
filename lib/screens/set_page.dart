import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetPage extends StatefulWidget {
  const SetPage({super.key});

  @override
  State<SetPage> createState() => _SetPageState();
}

class _SetPageState extends State<SetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rings'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    label: Text('NEW'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    label: Text('POPULAR'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    label: Text('BRANDS'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    label: Text('BESTSELL'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                Container(
                  height: 2000,
                  width: 500,
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Image.asset(
                          "images/ring3.jpg",
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Silver Ring'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('\$2499'),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Image.asset("images/ring3.jpg",
                              fit: BoxFit.cover)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Silver Ring'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('\$2499'),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Image.asset("images/ring3.jpg",
                              fit: BoxFit.cover)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Silver Ring'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('\$2499'),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Image.asset("images/ring3.jpg",
                              fit: BoxFit.cover)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Silver Ring'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('\$2499'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
