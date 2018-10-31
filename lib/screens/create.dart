import 'dart:io';

import 'package:fight2feed/widgets/card.dart';
import 'package:fight2feed/widgets/submit-button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

const DATE_DISPLAY_FORMAT = 'M/d/y @ h:mm a';

class CreatePage extends StatefulWidget {
  CreatePage({Key key}) : super(key: key);

  @override
  _CreatePageState createState() => new _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  File photo;
  CreateDonationFormData formData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("New Donation"),
      ),
      body: ListView(
        padding: EdgeInsets.all(24.0),
        children: <Widget>[
          F2FCard(
            children: <Widget>[
              _photoArea(),
              _titleField(),
              _descriptionField(),
              _expirationField(),
              _addressField(),
              _submitButton(),
            ],
          )
        ],
      ),
    );
  }

  F2FSubmitButton _submitButton() {
    return F2FSubmitButton(
      text: 'SUBMIT',
      iconData: Icons.playlist_add,
      isLoading: false,
      onPressed: () {},
    );
  }

  Widget _titleField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Title',
      ),
      validator: (val) {
        if (val.length == 0) return 'Please give your donation a title.';
        if (val.length > 255) return 'This field is limited to 255 characters.';
      },
      onSaved: (val) {
        this.formData.title = val.trim();
      },
    );
  }

  Widget _descriptionField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Description',
      ),
      maxLines: 3,
      validator: (val) {
        if (val.length == 0) return 'Please give your donation a description.';
        if (val.length > 1000)
          return 'This field is limited to 1000 characters.';
      },
      onSaved: (val) {
        this.formData.description = val.trim();
      },
    );
  }

  Widget _expirationField() {
    TextEditingController textEditingController = new TextEditingController();
    textEditingController.text = new DateFormat(DATE_DISPLAY_FORMAT).format(
      new DateTime.now().add(
        new Duration(
          hours: 12,
        ),
      ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: textEditingController,
            enabled: false,
            decoration: InputDecoration(
              labelText: 'Expiration',
            ),
            onSaved: (val) {},
          ),
        ),
        IconButton(
          onPressed: () async {
            DateTime dateTime = await showDatePicker(
              context: context,
              initialDate: DateTime.now().add(
                Duration(
                  hours: 12,
                ),
              ),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(
                Duration(
                  days: 365,
                ),
              ),
            );

            if (dateTime == null) return;

            TimeOfDay time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );

            if (time == null) return;

            DateTime combinedDateTime = new DateTime(
              dateTime.year,
              dateTime.month,
              dateTime.day,
              time.hour,
              time.minute,
              0,
            );

            textEditingController.text =
                DateFormat(DATE_DISPLAY_FORMAT).format(combinedDateTime);
          },
          icon: Icon(
            Icons.date_range,
            size: 32.0,
          ),
        ),
      ],
    );
  }

  Widget _addressField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Address',
      ),
      validator: (val) {
        if (val.length == 0) return 'Please enter an address.';
      },
      onSaved: (val) {
        // todo
      },
    );
  }

  GestureDetector _photoArea() {
    return GestureDetector(
      onTap: () async {
        File image = await ImagePicker.pickImage(
          source: ImageSource.camera,
        );
        setState(() {
          photo = image;
        });
      },
      child: Container(
        height: 232.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(5.0),
          // border: Border.all(
          //   color: Colors.grey.shade300,
          // ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: photo == null
              ? <Widget>[
                  Icon(
                    Icons.add_a_photo,
                    size: 48.0,
                    color: Colors.black,
                  ),
                  Text(
                    'Take a Photo',
                    textAlign: TextAlign.center,
                  ),
                ]
              : <Widget>[
                  Image.file(
                    photo,
                    height: 232.0,
                    fit: BoxFit.fitHeight,
                  ),
                ],
        ),
      ),
    );
  }
}

class MediaPhotoData {}

class CreateDonationFormData {
  String title;
  String description;
  DateTime expirationDate;
  bool active = true;
}
