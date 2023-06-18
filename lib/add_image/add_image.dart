import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatefulWidget {
  const AddImage(this.addImageFunc, {super.key});

  final Function(File pickedImage) addImageFunc;

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {

  File? pickedImage;

  void _pickimage_camera()async{
    final imagePicker = ImagePicker(); // 이미지 피커 객체 생성
    final pickedImageFile = await imagePicker.pickImage( // 이미지 피커로 이미지를 선택
      source: ImageSource.camera, // 이미지 피커의 소스 설정
      imageQuality: 50, // 이미지 품질
      maxHeight: 150, // 이미지 최대 높이
    );
    setState(() {
      if(pickedImageFile != null){ // 이미지가 선택되었다면
        pickedImage = File(pickedImageFile.path); // pickedImage에 선택된 이미지를 넣어줌
      }
    });
    widget.addImageFunc(pickedImage!);
  }

  void _pickimage_gallary()async{
    final imagePicker = ImagePicker(); // 이미지 피커 객체 생성
    final pickedImageFile = await imagePicker.pickImage( // 이미지 피커로 이미지를 선택
      source: ImageSource.gallery, // 이미지 피커의 소스 설정
      imageQuality: 50, // 이미지 품질
      maxHeight: 150, // 이미지 최대 높이
    );
    setState(() {
      if(pickedImageFile != null){ // 이미지가 선택되었다면
        pickedImage = File(pickedImageFile.path); // pickedImage에 선택된 이미지를 넣어줌
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.only(top:20), // 상단 패딩
            width: 150,
            height: 350,
            child:  Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue,
                  backgroundImage: pickedImage !=null ? FileImage(pickedImage!) : null // 이미지가 있으면 이미지를 넣고 없으면 null
                ),
                SizedBox(height: 20,),
                OutlinedButton.icon(
                  onPressed: (){
                    _pickimage_camera();
                  }, 
                  icon: Icon(Icons.camera_alt_sharp),
                  label: Text('카메라 추가'),
                ),
                SizedBox(height: 10,),
                OutlinedButton.icon(
                  onPressed: (){
                    _pickimage_gallary();
                  }, 
                  icon: Icon(Icons.image),
                  label: Text('갤러리 추가'),
                ),
                SizedBox(height: 30),
                TextButton.icon(
                  onPressed: (){
                    Navigator.pop(context);
                  }, 
                  icon: Icon(Icons.close), 
                  label: Text('닫기')
                )
              ],
            ),
          );
  }
}