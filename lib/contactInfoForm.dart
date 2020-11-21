import 'package:businessCardReader/contact.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';

class ContactInfoForm extends StatefulWidget {
  Contact _contact = new Contact();

  ContactInfoForm(this._contact);

  @override
  _ContactInfoFormState createState() => _ContactInfoFormState();
}

class _ContactInfoFormState extends State<ContactInfoForm> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _occupationController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _companyController = new TextEditingController();
  TextEditingController _websiteController = new TextEditingController();
  String finalAddress = '',
      finalName = '',
      finalPhoneNo = '',
      finaloccupation = '',
      finalEmail = '',
      finalCompany = '',
      finalWebsite = '';

  String _getText(List<String> textList) {
    String displayText = '';
    for (var text in textList) {
      displayText = displayText + text + '\n';
    }
    return displayText;
  }

  @override
  void initState() {
    _nameController.text = (widget._contact.name.length > 0)
        ? _getText(widget._contact.name)
        : '-';
    _occupationController.text = (widget._contact.occupation.length > 0)
        ? _getText(widget._contact.occupation)
        : '-';
    _companyController.text = (widget._contact.companyName.length > 0)
        ? _getText(widget._contact.companyName)
        : '-';
    _phoneController.text = (widget._contact.phoneNo.length > 0)
        ? _getText(widget._contact.phoneNo)
        : '-';
    _emailController.text = (widget._contact.email.length > 0)
        ? _getText(widget._contact.email)
        : '-';
    _websiteController.text = (widget._contact.website.length > 0)
        ? _getText(widget._contact.website)
        : '-';
    _addressController.text = (widget._contact.address.length > 0)
        ? _getText(widget._contact.address)
        : '-';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFF3F3F3),
              labelText: "Person Name",
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
            ),
            minLines: (widget._contact.name.length > 0)
                ? widget._contact.name.length
                : 1,
            maxLines: (widget._contact.name.length > 0)
                ? widget._contact.name.length
                : 1,
            autocorrect: false,
            onChanged: (value) {
              finalName = value;
            },
          ),
          SizedBox(height: 20,),
          TextField(
            controller: _occupationController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFF3F3F3),
              labelText: "Job Title",
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
            ),
            minLines: (widget._contact.occupation.length > 0)
                ? widget._contact.occupation.length
                : 1,
            maxLines: (widget._contact.occupation.length > 0)
                ? widget._contact.occupation.length
                : 1,
            autocorrect: false,
            onChanged: (value) {
              finaloccupation = value;
            },
          ),
          SizedBox(height: 20,),
          TextField(
            controller: _companyController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFF3F3F3),
              labelText: "Company",
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
            ),
            minLines: (widget._contact.companyName.length > 0)
                ? widget._contact.companyName.length
                : 1,
            maxLines: (widget._contact.companyName.length > 0)
                ? widget._contact.companyName.length
                : 1,
            autocorrect: false,
            onChanged: (value) {
              finalCompany = value;
            },
          ),
          SizedBox(height: 20,),
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFF3F3F3),
              labelText: "Phone Number",
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
            ),
            minLines: (widget._contact.phoneNo.length > 0)
                ? widget._contact.phoneNo.length
                : 1,
            maxLines: (widget._contact.phoneNo.length > 0)
                ? widget._contact.phoneNo.length
                : 1,
            autocorrect: false,
            onChanged: (value) {
              finalPhoneNo = value;
            },
          ),
          SizedBox(height: 20,),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFF3F3F3),
              labelText: "Email",
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
            ),
            minLines: (widget._contact.email.length > 0)
                ? widget._contact.email.length
                : 1,
            maxLines: (widget._contact.email.length > 0)
                ? widget._contact.email.length
                : 1,
            autocorrect: false,
            onChanged: (value) {
              finalEmail = value;
            },
          ),
          SizedBox(height: 20,),
          TextField(
            controller: _websiteController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFF3F3F3),
              labelText: "Website",
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
            ),
            minLines: (widget._contact.website.length > 0)
                ? widget._contact.website.length
                : 1,
            maxLines: (widget._contact.website.length > 0)
                ? widget._contact.website.length
                : 1,
            autocorrect: false,
            onChanged: (value) {
              finalWebsite = value;
            },
          ),
          SizedBox(height: 20,),
          TextField(
            controller: _addressController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFF3F3F3),
              labelText: "Address",
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
            ),
            minLines: (widget._contact.address.length > 0)
                ? widget._contact.address.length
                : 1,
            maxLines: (widget._contact.address.length > 0)
                ? widget._contact.address.length
                : 1,
            autocorrect: false,
            onChanged: (value) {
              print(value);
            },
          ),
          SizedBox(height: 20,),
          Center(
            child: RaisedButton(
              onPressed: () {
                print("Name: " + ((finalName == '') ? _nameController.text : finalName));
                print("Job Title: " + ((finaloccupation == '') ? _occupationController.text: finaloccupation));
                print("Company: " + ((finalCompany == '') ? _companyController.text : finalCompany));
                print("Phone numbers: " + ((finalPhoneNo == '') ? _phoneController.text : finalPhoneNo));
                print("Email: " + ((finalEmail == '') ? _emailController.text : finalEmail));
                print("Website: " + ((finalWebsite == '') ? _websiteController.text : finalWebsite));
                print("Address: " + ((finalAddress == '') ? _addressController.text : finalAddress));
              },
              child: Text("Save"),
            ),
          ),
        ],
      ),
    );
  }
}
