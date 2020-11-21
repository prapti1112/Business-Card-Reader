import 'package:businessCardReader/contact.dart';
import 'package:businessCardReader/contactInfoForm.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:string_validator/string_validator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File imageFile;
  List<String> extractedText = [];
  String displayText = "";
  String extention = '-';
  List<String> numbers = [], sortedText = [];
  Contact contact = new Contact();
  bool showExtractedDetails = false;
  List<String> possible_occupations = [
    'trainee',
    'senior',
    'analyst',
    'assessor',
    'assessors',
    'surveyor',
    'surveyors',
    'arbitrator',
    'arbitrators',
    'advocate',
    'accountant',
    'actor',
    'actress',
    'air traffic controller',
    'architect',
    'artist',
    'attorney',
    'banker',
    'bartender',
    'barber',
    'bookkeeper',
    'builder',
    'businessman',
    'businesswoman',
    'businessperson',
    'butcher',
    'carpenter',
    'cashier',
    'chef',
    'coach',
    'dental hygienist',
    'dentist',
    'designer',
    'developer',
    'dietician',
    'doctor',
    'economist',
    'editor',
    'electrician',
    'engineer',
    'engineers',
    'farmer',
    'filmmaker',
    'fisherman',
    'flight attendant',
    'jeweler',
    'judge',
    'lawyer',
    'mechanic',
    'musician',
    'nutritionist',
    'nurse',
    'optician',
    'painter',
    'pharmacist',
    'photographer',
    'physician',
    " physician's assistant",
    'pilot',
    'plumber',
    'officer',
    'politician',
    'professor',
    'programmer',
    'psychologist',
    'receptionist',
    'salesman',
    'salesperson',
    'saleswoman',
    'secretary',
    'singer',
    'surgeon',
    'teacher',
    'therapist',
    'undertaker',
    'veterinarian',
    'videographer',
    'waiter',
    'waitress',
    'writer',
    'president',
    'vice-president',
    'director',
    'manager',
    'deputy director',
    'managing director',
    'financial director',
    'marketing director',
    'general manager',
    'assistant manager',
    'manager',
    'production manager',
    'personnel manager',
    'marketing manager',
    'sales manager',
    'project manager',
    'supervisor',
    'inspector',
    'controller',
    'office worker',
    'office employee',
    'office clerk',
    'filing clerk',
    'typist',
    'stenographer',
    'auditor',
    'teller',
    'bank clerk',
    'financier',
    'treasurer',
    'investor',
    'sponsor',
    'stockbroker',
    'pawnbroker',
    'tax collector',
    'sales representative',
    'sales manager',
    'salesgirl',
    'salesclerk',
    'wholesaler',
    'retailer',
    'merchant',
    'distributor',
    'dealer',
    'trader',
    'agent',
    'grocer',
    'baker',
    'butcher',
    'florist',
    'specialist',
    'cardiologist',
    'paediatrician',
    'psychiatrist',
    'psychoanalyst',
    'dietitian',
    'paramedic',
    'principal',
    'dean',
    'teacher',
    'instructor',
    'scientist',
    'scholar',
    'researcher',
    'explorer',
    'inventor',
    'mathematician',
    'physicist',
    'chemist',
    'biologist',
    'botanist',
    'zoologist',
    'historian',
    'archaeologist',
    'geologist',
    'psychologist',
    'sociologist',
    'economist',
    'linguist',
    'astronomer',
    'philosopher',
    'geographer',
    'operator',
    'software',
    'analyst',
    'administrator',
    'web developer',
    'web programmer',
    'webmaster',
    'web designer',
    'sculptor',
    'composer',
    'conductor',
    'pianist',
    'violinist',
    'guitarist',
    'drummer',
    'dancer',
    'singer',
    'film director',
    'producer',
    'art director',
    'cameraman',
    'poet',
    'author',
    'playwright',
    'dramatist',
    'scenarist',
    'publisher',
    'journalist',
    'reporter',
    'correspondent',
    'fashion designer',
    'interior designer',
    'graphic designer',
    'builder',
    'contractor',
    'technician',
    'welder',
    'bricklayer',
    'mason',
    'decorator',
    'housekeeper',
    'janitor',
    'flight engineer',
    'flight navigator',
    'stewardess',
    'dispatcher',
    'worker',
    'driver',
    'chauffeur',
    'captain',
    'skipper',
    'navigator',
    'sailor',
    'adviser',
    'barrister',
    'solicitor',
    'policeman',
    'detective',
    'bodyguard',
    'lifeguard',
    'warden',
    'prison guard',
    'cook',
    'firefighter',
    'fireman',
    'tailor',
    'seamstress',
    'postman',
    'mailman',
    'guide',
    'porter',
    'proofreader',
    'printer',
    'interpreter',
    'librarian',
    'coal miner',
    'hunter',
    'forester',
    'gardener',
    'hairdresser',
    'stylist',
    'beautician',
    'cosmetologist',
    'consultant',
    'priest',
    'clergyman'
  ];

  void isPhoneNo(String text) {
    String originalText = text;
    if (isNumeric(text) ||
        text.contains('✆ ') ||
        text.contains('+91 ') ||
        text.contains('020 ') ||
        text.contains('020-') ||
        text.contains('tel ') ||
        text.contains('mobile ') ||
        text.contains('phone ') ||
        text.contains('mob ') ||
        text.contains('ph ') ||
        text.contains('contact ')) {
      text = (text.contains('mobile '))
          ? text.substring(text.indexOf('mobile'))
          : text;
      text = (text.contains('contact '))
          ? text.substring(text.indexOf('contact'))
          : text;
      text =
          (text.contains('tel ')) ? text.substring(text.indexOf('tel')) : text;
      text = (text.contains('phone '))
          ? text.substring(text.indexOf('phone'))
          : text;
      text =
          (text.contains('mob ')) ? text.substring(text.indexOf('mob')) : text;
      text = (text.contains('ph ')) ? text.substring(text.indexOf('ph')) : text;
      extention = (text.contains('+91 ')) ? '+91' : '-';
      extention = (text.contains('020 ')) ? '020' : '-';
      text = text
          .replaceAll('✆', '')
          .replaceAll('+91 ', '')
          .replaceAll('020 ', '')
          .replaceAll('tel', '')
          .replaceAll('mobile', '')
          .replaceAll(';', '')
          .replaceAll(':', '')
          .replaceAll('phone', '')
          .replaceAll('mob', '')
          .replaceAll('ph', '')
          .replaceAll(' ', '')
          .replaceAll('(', '')
          .replaceAll(')', '')
          .replaceAll('-', '');
      // print("After replacements: $text");

      // if (text.contains('/')) {
      //   numbers = text.split('/'); // 2025561194 and 0195 and 96
      //   String fullNum = numbers[0];
      //   for (var i = 0; i < numbers.length; i++) {
      //     if (numbers[i].length < 6) {
      //       numbers[i] =
      //           fullNum.substring(0, fullNum.length - numbers[i].length - 1) +
      //               numbers[i];
      //     }
      //   }
      // } else if (text.contains(',')) {
      //   numbers = text.split(','); // 2025561194 and 0195 and 96
      //   String fullNum = numbers[0];
      //   for (var i = 0; i < numbers.length; i++) {
      //     if (numbers[i].length < fullNum.length) {
      //       numbers[i] =
      //           fullNum.substring(0, fullNum.length - numbers[i].length - 1) +
      //               numbers[i];
      //     }
      //   }
      // } else {
      //   numbers[0] = text;
      // }

      // checking the final number(s)
      // List<int> removeIndex = [];
      // for (var i = 0; numbers.isNotEmpty && i <  numbers.length; i++) {
      //   if (isNumeric(numbers[i]))
      //     continue;
      //   // else
      //     // removeIndex.add(i);
      // }
      // numbers.removeWhere((item) => removeIndex.contains(numbers.indexOf(item)));
      if (!sortedText.contains(originalText)) {
        // (isNumeric(text) || text.contains('/') || text.contains(',')) &&
        contact.phoneNo.add(text);
        sortedText.add(originalText);
      }
    }
    return;
  }

  void isAddress(String text) {
    String originalText = text;
    if ((!isNumeric(text) ||
            isAlphanumeric(text) ||
            text.contains(',') ||
            text.contains('opp') ||
            text.contains('add.') ||
            text.contains('near') ||
            text.contains('next') ||
            text.contains('left') ||
            text.contains('off') ||
            text.contains('nagar') ||
            text.contains('complex') ||
            text.contains('building') ||
            text.contains('road') ||
            text.contains('office') ||
            text.contains('plaza') ||
            text.contains('colony') ||
            text.contains('behind') ||
            text.contains('park') ||
            text.contains('tower') ||
            text.contains('wing')) &&
        !sortedText.contains(originalText)) {
      contact.address.add(text);
      sortedText.add(originalText);
    }

    return;
  }

  void isEmailId(String text) {
    String originalText = text;
    if (text.replaceAll('-', '').contains('email') ||
        text.contains('e ') ||
        text.contains('@')) {
      text = (text.replaceAll('-', '').contains('email'))
          ? text.substring(text.indexOf('email'))
          : text;
      text = text
          .replaceAll('-', '')
          .replaceAll('email', '')
          .replaceAll(':', '')
          .trim();
      if (text.contains('@') && !sortedText.contains(originalText)) {
        contact.email.add(text);
        sortedText.add(originalText);
      }
    }
    return;
  }

  void isWebsite(String text) {
    String originalText = text;
    if ((text.contains('web') || text.contains('www')) &&
        !sortedText.contains(originalText)) {
      text = text
          .replaceAll('web', '')
          .replaceAll(':', '')
          .replaceAll('-', '')
          .trim();
      contact.website.add(text.substring(text.indexOf('www')));
      sortedText.add(originalText);
    }
    return;
  }

  void isCompanyName(String text) {
    String originalText = text;
    if ((!text.contains('@') ||
            text.contains('associates') ||
            text.contains('limited') ||
            text.contains('private') ||
            text.contains('pvt') ||
            text.contains('ltd') ||
            text.contains('consultancy') ||
            text.contains('corp') ||
            text.contains('group') ||
            text.contains('co')) &&
        !sortedText.contains(originalText)) {
      contact.companyName.add(text);
      sortedText.add(originalText);
    }
  }

  void isPersonName(String text) {
    RegExp name_surname =
        RegExp(r'\w+\s\w+'); // (\w+\s\w+)               Name Surname
    RegExp name_i_surname =
        RegExp(r'\w+\s\w\.\s\w+'); // \w+\s\w\.\s\w+       Name I. Surname
    RegExp i_surname =
        RegExp(r'\w\.\s\w+'); //\w\.\s\w+                 I. Surname
    if (name_surname.hasMatch(text) ||
        name_i_surname.hasMatch(text) ||
        i_surname.hasMatch(text)) {
      contact.name.add(text);
      sortedText.add(text);
    }
    return;
  }

  extractUsefulInformation() {
    // print("In useful info extractor: ");
    print("Occupation For:");
    for (var text in extractedText) {
      text = text.toLowerCase();
      //for occupation
      if (!sortedText.contains(text)) {
        for (var o in possible_occupations) {
          if (text.contains(o)) {
            print(text + " - " + o);
            contact.occupation.add(text);
            sortedText.add(text);
          }
        }
      }
    }

    extractedText
        .removeWhere((element) => sortedText.contains(element.toLowerCase()));
    setState(() {});

    for (var text in extractedText) {
      text = text.toLowerCase();
      isWebsite(text);
    }

    extractedText
        .removeWhere((element) => sortedText.contains(element.toLowerCase()));
    setState(() {});

    for (var text in extractedText) {
      text = text.toLowerCase();
      isEmailId(text);
    }

    extractedText
        .removeWhere((element) => sortedText.contains(element.toLowerCase()));
    setState(() {});

    for (var text in extractedText) {
      text = text.toLowerCase();
      isPhoneNo(text);
    }

    extractedText
        .removeWhere((element) => sortedText.contains(element.toLowerCase()));
    setState(() {});

    print(extractedText);
    for (var text in extractedText) {
      text = text.toLowerCase();
      isAddress(text);
    }

    extractedText
        .removeWhere((element) => sortedText.contains(element.toLowerCase()));
    setState(() {});
    for (var text in extractedText) {
      text = text.toLowerCase();
      isCompanyName(text);
    }

    extractedText.removeWhere((element) => sortedText.contains(element));
    setState(() {});

    for (var text in extractedText) {
      text = text.toLowerCase();
      isPersonName(text);
    }

    print(extractedText);

    showExtractedDetails = true;

    setState(() {});
    print("Contact info:");
    print("Name: ${contact.name}");
    print("Occupation: ${contact.occupation}");
    print("Phone Number: ${contact.phoneNo}");
    print("Email: ${contact.email}");
    print("Company: ${contact.companyName}");
    print("Website: ${contact.website}");
    print("Address: ${contact.address}");
    print("Sorted Text: $sortedText");
  }

  _openGallery(BuildContext context) async {
    PickedFile selectedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    imageFile = File(selectedFile.path);

    setState(() {});
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    PickedFile selectedFile =
        await ImagePicker().getImage(source: ImageSource.camera);
    imageFile = File(selectedFile.path);

    setState(() {});
    Navigator.of(context).pop();
  }

  Widget _decideImageView() {
    if (imageFile == null) {
      return Text('No Image Selected');
    } else {
      Image.file(
        imageFile,
        width: 400,
        height: 400,
      );
    }
  }

  Future _readText() async {
    FirebaseVisionImage image = FirebaseVisionImage.fromFile(imageFile);
    TextRecognizer _recognizer = FirebaseVision.instance.textRecognizer();

    VisionText readText = await _recognizer.processImage(image);
    print("Start");
    for (TextBlock block in readText.blocks) {
      print(block.text);
      extractedText.add(block.text);
      print(block.text);
    }

    setState(() {});
    print("End");

    for (int i = 0; i < extractedText.length; i++) {
      if (!displayText.contains(extractedText[i])) {
        displayText = displayText + extractedText[i] + "\n";
      }
    }
    extractUsefulInformation();
  }

  @override
  Widget build(BuildContext context) {
    print(imageFile);
    return Scaffold(
      appBar: AppBar(
        title: Text('Business Card Reader'),
        backgroundColor: Color(0xFFFF9132),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                (imageFile == null)
                    ? Text('No Image Selected')
                    : Image(
                        image: FileImage(imageFile),
                        height: 200.0,
                        width: 200.0,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      child: Text('Select Image'),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Make a choice'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: [
                                      GestureDetector(
                                        child: Text('Gallery'),
                                        onTap: () {
                                          _openGallery(context);
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                      ),
                                      GestureDetector(
                                        child: Text('Camera'),
                                        onTap: () {
                                          // open camera
                                          _openCamera(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                    SizedBox(width: 20.0),
                    RaisedButton(
                      child: Text('Read text'),
                      onPressed: _readText,
                    ),
                  ],
                ),
                SizedBox(height: 100.0),
                (extractedText.length == null)
                    ? Container()
                    : Text(displayText),
                (showExtractedDetails) ? ContactInfoForm(contact) : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
