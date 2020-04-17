import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ums_flutter/bloc/navigation/navigation_bloc.dart';
import 'package:ums_flutter/utils/sizeConfig.dart';

class AddCourses extends StatefulWidget with NavigationStates {
  @override
  _AddCoursesState createState() => _AddCoursesState();
}

class _AddCoursesState extends State<AddCourses> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _courseNameController = TextEditingController();
  TextEditingController _courseIdController = TextEditingController();
  TextEditingController _courseDescriptionController = TextEditingController();
  TextEditingController _courseCodeController = TextEditingController();
  TextEditingController _courseDurationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(16, 16, 16, 1),
      body: Column(
        children: <Widget>[
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent])
                  .createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            //todo change image
            child: Image.asset('images/university.jpg',
                alignment: Alignment.topCenter,
                width: SizeConfig.screenWidth,
                height: SizeConfig.blockSizeVertical * 33,
                fit: BoxFit.fill),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Colleges',
                style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: SizeConfig.blockSizeHorizontal * 9,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              Row(
                children: <Widget>[
                  Text('MMDU',
                      style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: SizeConfig.blockSizeHorizontal * 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFD3664))),
                  Text(',',
                      style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: SizeConfig.blockSizeHorizontal * 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  SizedBox(width: 10.0),
                  Text(
                    'Mullana',
                    style: TextStyle(
                        fontFamily: 'Oswald',
                        fontSize: SizeConfig.blockSizeHorizontal * 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              )
            ],
          ),
          new SafeArea(
            top: true,
            bottom: true,
            child: new Form(
                key: _formKey,
                autovalidate: true,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: <Widget>[
                    new TextFormField(
                      controller: _courseIdController,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.white),
                        icon: const Icon(Icons.person_outline),
                        hintText: 'Enter Course ID',
                        labelText: 'ID',
                      ),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                    ),
                    new TextFormField(
                      controller: _courseNameController,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      decoration: const InputDecoration(
                          icon: const Icon(Icons.person),
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Enter Course name',
                          labelText: 'Course'),
                    ),
                    new TextFormField(
                      controller: _courseCodeController,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      decoration: const InputDecoration(
                          icon: const Icon(Icons.person),
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Enter Course Code',
                          labelText: 'Code'),
                    ),
                    new TextFormField(
                      controller: _courseDescriptionController,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      decoration: const InputDecoration(
                          icon: const Icon(Icons.person),
                          labelStyle: TextStyle(color: Colors.white,
                              fontSize: 23),
                          hintText: 'Enter Course description',
                          labelText: 'Description'),
                    ),
                    new TextFormField(
                      controller: _courseDurationController,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      decoration: const InputDecoration(
                          icon: const Icon(Icons.person),
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 23
                          ),
                          hintText: 'Enter Course duration',
                          labelText: 'Duration'),
                    ),
                    SizedBox(height: 30.0),
                    Container(
                      height: 50.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: Center(
                          child: Text(
                            'SUBMIT',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
