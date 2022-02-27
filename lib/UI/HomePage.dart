import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dictionary_app_flutter/providers/DictionaryProvider.dart';

class HomePage extends StatelessWidget {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Center(child: Text("Dictionary",style: TextStyle(fontSize: 30,color: Colors.black),)),
        ),
        body: Consumer(builder: (context, ref, child) {
            final dictionary = ref.watch(dictionaryProvider);
          return Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 22, left: 12),
                    child: Container(
                      height: 70,
                      width: 280,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 7),
                        child: TextFormField(
                          controller: searchController,
                          onFieldSubmitted: (val){
                            ref.read(dictionaryProvider.notifier).searchWord(val);
                          },

                          style: TextStyle(fontSize: 25),
                          decoration: InputDecoration(

                            border: InputBorder.none,
                            hintStyle:
                                TextStyle(color: Colors.red, fontSize: 25),
                            hintText: 'Search for a word',
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        String value = searchController.text.trim();
                        ref.watch(dictionaryProvider.notifier).searchWord(value);
                      },
                      icon: Icon(
                        Icons.search,
                        size:55,
                        color: Colors.purple,
                      )
                  ),
                ],
              ),
              SizedBox(height: 12,),
              SafeArea(
                child: Container(
                height: 480,

                  child: ListView.builder(
                    itemCount: dictionary.length,
                    itemBuilder: (BuildContext context, int index) {
                      final dictData = dictionary[index];
                      return ListBody(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0,right: 50),
                            child: Container(

                              decoration: BoxDecoration(
                                color:Colors.blueGrey,
                                borderRadius: BorderRadius.circular(24.0),

                              ),

                              child: ListTile(
                                leading: dictData.image_url == null
                                    ? null
                                    :Padding(
                                      padding: const EdgeInsets.only(top: 14.0),
                                      child: CircleAvatar(

                                  backgroundColor: Color(0xffFDCF09),
                                  child: CircleAvatar(

                                      backgroundImage: NetworkImage("${dictData.image_url}"),
                                  ),
                                ),
                                    ),

                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Text('\nWord : ${searchController.text.trim()}'  + '\nPart of speech : ${dictData.type}',style: TextStyle(fontSize: 20), ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color:Colors.orange,
                                  borderRadius: BorderRadius.circular(24.0),

                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Definition:\n${dictData.definition}',style: TextStyle(fontSize: 20),),
                                )),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        })
    );
  }
}
