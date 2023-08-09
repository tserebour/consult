import 'dart:io';

import 'package:consult/models/conversation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/Material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/Human.dart';
import '../models/encrypt_decrypt.dart';
import '../models/message.dart';

class DMScreen extends StatefulWidget {
  late Human sender;
  late Human receiver;
  late Conversation conversation;

  DMScreen({
    Key? key, required this.conversation, required this.sender, required this.receiver
  }) : super(key: key);

  @override
  State<DMScreen> createState() => _DMScreenState();
}

class _DMScreenState extends State<DMScreen> {

  Message message = Message();
  bool sent_by_owner = false;

  ScrollController scrollController = ScrollController();

  bool isEmpty = true;

 List<XFile> images = [];

  final ImagePicker picker = ImagePicker();

  TextEditingController messageContentController = TextEditingController();



  Future getImage(ImageSource media) async {
    List<XFile> selectedImage;
    if(media.toString() == 'ImageSource.gallery'){
      selectedImage = await picker.pickMultiImage();
      if(selectedImage.isNotEmpty){
        images.addAll(selectedImage);
      }

    }else{
      var img = await picker.pickImage(source: media);
      if(img != null){
        images.add(img);
      }

    }




    setState(() {

    });
  }



  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "${widget.receiver.user_type == 'Doctor' ? 'Dr.':'' }${widget.receiver.fullname}",
          style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: widget.conversation.getMessages(),
                builder: (context, snapshot) {

                  if(snapshot.hasData){

                    return ListView(
                        controller: scrollController,
                        children: snapshot.data!.docs.map<Widget>((doc){
                          sent_by_owner = widget.sender.id == doc.data()['sender_id'];
                          return Container(
                            padding: EdgeInsets.only(
                              top: 4,
                              bottom: 4,
                              left: sent_by_owner? 0 : 24,
                              right: sent_by_owner? 24 : 0,
                            ),
                            alignment: sent_by_owner? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              margin: sent_by_owner
                                  ?const EdgeInsets.only(left: 30)
                                  : const  EdgeInsets.only(right: 30),


                              padding: const EdgeInsets.only(
                                  top: 17,
                                  bottom: 17,
                                  left: 20,
                                  right: 20
                              ),

                              decoration:  BoxDecoration(
                                  borderRadius: sent_by_owner
                                      ?const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  )
                                      : const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),




                                  ),

                                  color: sent_by_owner
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey

                              ),

                              child: Container(
                                width: MediaQuery.of(context).size.width /2,

                                child: Column(
                                  children: [
                                    doc.data()['attachments'] != null && doc.data()['attachments'].isNotEmpty
                                        ? Container(
                                      height: 150,

                                      child: GridView.builder(
                                        itemCount: doc.data()['attachments'].length,
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 0.5,
                                            mainAxisSpacing: 0.5
                                        ),
                                        itemBuilder: (BuildContext context, int index) {
                                          return Container(
                                            child: Image.network(
                                              // height: 80,
                                                doc.data()['attachments'][index].toString()
                                            ),
                                          );


                                        },

                                      ),

                                    )
                                        : Container(),
                                    Text(
                                      EcryptDecrypt.decrypt(doc.data()["content"]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );

                        }).toList()
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );




                }
            ),
          ),
          Container(
            color: Colors.black,

          ),

          Container(

            height: 80,
            child: images.isNotEmpty ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(



                  children: [

                    Row(
                      children: [
                        Container(
                          width: 50,
                          color: Colors.blue,

                          child: Image.file(
                            File(images[index]!.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        )





                      ],
                    ),
                    IconButton(


                        onPressed: (){
                          images.removeAt(index);
                          setState(() {

                          });

                        },
                        icon: const Icon(Icons.cancel)
                    ),
                  ],
                );

              },

            ) : Container(),
          ),

          Container(
            height: 70,
            color: Colors.grey,

            child: Row(
              children: [
                Expanded(
                    child: TextField(
                      controller: messageContentController,
                      onChanged: (value){
                        setState(() {

                          if (value.isEmpty){
                            isEmpty = true;

                          }else{
                            isEmpty = false;
                          }
                        });
                      },


                      style:  const TextStyle(
                        color: Colors.white,

                      ),
                      decoration: const InputDecoration(
                          hintText: "Type a message...",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,

                          ),
                          border: InputBorder.none

                      ),

                    )
                ),
                const SizedBox(width: 12,),
                 InkWell(

                  onTap: () async {
                    print('ie');



                    myAlert();



                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30)
                    ),

                    child: const Center(
                      child: Icon(
                          Icons.attachment,
                          color: Colors.white
                      ),

                    ),
                  ),
                ),
                const SizedBox(width: 12,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {

                      message.content = messageContentController.text;

                      if(images.isNotEmpty){
                        message.attachments = images;
                      }


                      if(message.content.isNotEmpty || images.isNotEmpty){
                        message.sender = widget.sender;

                        message.conversation_id = widget.conversation.conversation_id;



                        await widget.sender.sendMessage(message).then((value){

                          if(value != null && value.isNotEmpty){
                            message.message_id = value.id;
                            print(message.message_id);
                            messageContentController.clear();
                            images = [];
                            setState(() {

                            });
                          }




                        });

                      }







                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30)
                      ),

                      child: const Center(
                        child: Icon(
                            Icons.send,
                            color: Colors.white
                        ),

                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),

        ],
      ),


    );



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "${widget.receiver.user_type == 'Doctor' ? 'Dr.':'' }${widget.receiver.fullname}",
          style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
      ),
      body: Column(
        children: [

          Expanded(
            child: SafeArea(
              child: StreamBuilder(
                  stream: widget.conversation.getMessages(),
                  builder: (context, snapshot) {

                    if(snapshot.hasData){

                      return ListView(
                          controller: scrollController,
                          children: snapshot.data!.docs.map<Widget>((doc){
                            sent_by_owner = widget.sender.id == doc.data()['sender_id'];
                            return Container(
                              padding: EdgeInsets.only(
                                top: 4,
                                bottom: 4,
                                left: sent_by_owner? 0 : 24,
                                right: sent_by_owner? 24 : 0,
                              ),
                              alignment: sent_by_owner? Alignment.centerRight : Alignment.centerLeft,
                              child: Container(
                                margin: sent_by_owner
                                    ?const EdgeInsets.only(left: 30)
                                    : const  EdgeInsets.only(right: 30),


                                padding: const EdgeInsets.only(
                                    top: 17,
                                    bottom: 17,
                                    left: 20,
                                    right: 20
                                ),

                                decoration:  BoxDecoration(
                                    borderRadius: sent_by_owner
                                        ?const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                    )
                                        : const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20),




                                    ),

                                    color: sent_by_owner
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey

                                ),

                                child: Container(
                                  width: MediaQuery.of(context).size.width /3,
                                  height: 80,
                                  child: Column(
                                    children: [
                                      doc.data()['attachments'] != null
                                          ? Container(
                                        height: 50,

                                        child: GridView.builder(
                                          itemCount: doc.data()['attachments'].length,
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 1.0,
                                              mainAxisSpacing: 1.0
                                          ),
                                          itemBuilder: (BuildContext context, int index) {
                                            return Container(
                                              child: Image.network(doc.data()['attachments'][index]),
                                            );


                                          },

                                        ),

                                      )
                                          : Container(),
                                      Text(
                                        EcryptDecrypt.decrypt(doc.data()["content"]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );

                          }).toList()
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );




                  }
              ),
            ),
          ),


          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              color: Colors.grey[700],
              height: images.isNotEmpty ? MediaQuery.of(context).size.height  / 5 : 100,
              child:  Column(

                children: [

                  images.isNotEmpty ?Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(



                            children: [

                              Row(
                                children: [
                                  Container(
                                    width: 50,
                                    color: Colors.blue,

                                    child: Image.file(
                                      File(images[index]!.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  )





                                ],
                              ),
                              IconButton(


                                  onPressed: (){
                                    images.removeAt(index);
                                    setState(() {

                                    });

                                  },
                                  icon: const Icon(Icons.cancel)
                              ),
                            ],
                          );

                        },

                      )
                  ) : Container(),
                  Container(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                              controller: messageContentController,
                              onChanged: (value){
                                setState(() {

                                  if (value.isEmpty){
                                    isEmpty = true;

                                  }else{
                                    isEmpty = false;
                                  }
                                });
                              },


                              style:  const TextStyle(
                                color: Colors.white,

                              ),
                              decoration: const InputDecoration(
                                  hintText: "Type a message...",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,

                                  ),
                                  border: InputBorder.none

                              ),

                            )
                        ),
                        const SizedBox(width: 12,),
                        isEmpty ? InkWell(

                          onTap: () async {
                            print('ie');



                            myAlert();



                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(30)
                            ),

                            child: const Center(
                              child: Icon(
                                  Icons.attachment,
                                  color: Colors.white
                              ),

                            ),
                          ),
                        ): Container(height:50),
                        const SizedBox(width: 12,),
                        InkWell(
                          onTap: () async {

                            message.content = messageContentController.text;

                            if(images.isNotEmpty){
                              message.attachments = images;
                            }


                            if(message.content.isNotEmpty){
                              message.sender = widget.sender;

                              message.conversation_id = widget.conversation.conversation_id;



                              await widget.sender.sendMessage(message).then((value){

                                message.message_id = value.id;
                                print(message.message_id);
                                messageContentController.clear();




                              });

                            }







                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(30)
                            ),

                            child: const Center(
                              child: Icon(
                                  Icons.send,
                                  color: Colors.white
                              ),

                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),

          )
        ],
      ),
    );








  }




}



