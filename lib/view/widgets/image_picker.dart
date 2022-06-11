
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class ImagePick extends StatefulWidget {
      const ImagePick(this.pickedImgFunc, {Key? key}) : super(key: key);

  final  Function(File pickedImgae) pickedImgFunc;

  @override
  State<ImagePick> createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {
    File? imageselected;
    final ImagePicker _picker = ImagePicker();
   
    void pickedImage(ImageSource src) async{
     final imagePath = await _picker.pickImage(source:src,maxHeight: 150,imageQuality: 50);
    //  print(":::::::::::::::$imagePath");
     if(imagePath!=null)
     {
       setState(() {
         imageselected=File(imagePath.path);
       });
       widget.pickedImgFunc(imageselected!);
     }
     else{
       print('No Image Selected');
     }
   }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         CircleAvatar(
           radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: imageselected!=null?FileImage(imageselected!):null,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
               onPressed:()=>pickedImage(ImageSource.gallery),
              icon:const Icon(Icons.image_search),
              label:const Text('Pick Image\nfrom gallery'),
              ),
            TextButton.icon(
              onPressed:()=>pickedImage(ImageSource.camera),
              icon:const Icon(Icons.photo_camera),
              label:const Text('pick Image\nfrom camera',textAlign: TextAlign.center,),
              ),
          ],
        )


      ],
    );
  }
}