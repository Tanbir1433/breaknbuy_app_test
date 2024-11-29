import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import '../../const_config/color_config.dart';
import '../../const_config/const_config.dart';

import '../buttons/simple_button.dart';
import '../buttons/simple_icon_button.dart';
import '../global_widgets/custom_snack_bar.dart';

class WebImagePicker extends StatefulWidget {
  final String title;
  final double imageWidth;
  final double imageHeight;
  final TextEditingController imageUrl;

  const WebImagePicker({
    super.key,
    required this.imageWidth,
    required this.imageHeight,
    required this.title,
    required this.imageUrl,
  });

  @override
  State<WebImagePicker> createState() => _WebImagePickerState();
}

class _WebImagePickerState extends State<WebImagePicker> {
  late bool imageIsUpLoaded = false;

  XFile? _image;
  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  @override
  void initState() {
    widget.imageUrl.text = 'null';
    super.initState();
    // Initialize your state here
  }

  Future<bool> uploadImage(String userKey) async {
    try {
      if (_image == null) {
        print('No image selected.');
        return false;
      }

      final url = Uri.parse('$baseUrl/image_uploading/image_uploading.php');
      var request = http.MultipartRequest('POST', url)
        ..fields['user_key'] = userKey
        ..files.add(http.MultipartFile.fromBytes(
          'image',
          await _image!.readAsBytes(),
          filename: 'image.jpg',
        ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var parsedData = json.decode(response.body);
        if (parsedData.containsKey('success')) {
          String successUrl = parsedData['success'];
          widget.imageUrl.text = successUrl;

          setState(() {
            imageIsUpLoaded = true;
          });
          return true;
        } else {
          widget.imageUrl.text = 'null';

          print('Upload failed. No success URL found.');
          return false;
        }
      } else {
        widget.imageUrl.text = 'null';
        print('Upload failed with status ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Exception during image upload: $e');
      widget.imageUrl.text = 'null';
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_image != null)
          FutureBuilder<Uint8List>(
            future: _image!.readAsBytes(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  children: [
                    Image.memory(
                      snapshot.data!,
                      width: widget.imageWidth,
                      height: widget.imageHeight,
                    ),
                    imageIsUpLoaded
                        ?  const Positioned(
                            right: 0,
                            top: 0,
                            child: FaIcon(
                              FontAwesomeIcons.circleCheck,
                              color: MyColor.mtMainGreen,
                            ))
                        : const SizedBox(
                            height: 0,
                            width: 0,
                          )
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          )
        else
          SizedBox(
              width: widget.imageWidth,
              height: widget.imageHeight,
              child: const Placeholder()),
        const SizedBox(
          height: 15,
        ),
       Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SimpleButton(
                    text: widget.title,
                    onClick: getImage,
                  ),
                  SizedBox(
                    width: imageIsUpLoaded ? 0 : 15,
                    height: imageIsUpLoaded ? 0 : 15,
                  ),
                  imageIsUpLoaded
                      ? const SizedBox(
                          height: 0,
                          width: 0,
                        )
                      : SimpleIconButton(
                          backGroundColor: MyColor.vdCharcoal,
                          icon: FontAwesomeIcons.upload,
                          onClick: () {
                            uploadImage(
                                    'yeardll??908<@>&&&gggggdd8j??{]}p}jtygghgghhgsf')
                                .then((value) {
                              if (value) {
                              } else {
                                CustomSnackBar.showSnackBar(
                                    context: context,
                                    message: 'Net Error',
                                    color: MyColor.red);
                              }
                            });
                          }),
                ],
              )

      ],
    );
  }
}
