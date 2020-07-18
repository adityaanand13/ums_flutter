import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/bloc.dart';
import 'package:ums_flutter/components/components.dart';
import 'package:ums_flutter/models/models.dart';
import 'package:ums_flutter/utils/utils.dart';

class AddEditCourseScreen extends StatefulWidget {
  final SideDrawer sideDrawer;
  final CourseResponse courseResponse;
  final String collegeCode;
  final String collegeName;
  final int collegeId;
  final bool isEditing;

  const AddEditCourseScreen({
    Key key,
    @required this.sideDrawer,
    this.courseResponse,
    this.isEditing = false,
    @required this.collegeCode,
    @required this.collegeName,
    @required this.collegeId,
  })  : assert(sideDrawer != null),
        assert(collegeId != null),
        assert(collegeName != null),
        super(key: key);

  @override
  _AddEditCourseScreenState createState() => _AddEditCourseScreenState();
}

class _AddEditCourseScreenState extends State<AddEditCourseScreen> {
  final _nameFocus = FocusNode();
  final _codeFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _durationFocus = FocusNode();
  final _semesterPerYearFocus = FocusNode();

  CourseRequest _courseRequest;
  bool _autoValidate;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _courseRequest = widget.courseResponse != null
        ? CourseRequest.fromResponse(courseResponse: widget.courseResponse)
        : CourseRequest();
    _autoValidate = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: widget.sideDrawer,
      floatingActionButton: CustomFloatingActionButton(
        label: "Save",
        icon: Icon(Icons.cloud_done, color: Colors.white),
        color: Colors.green,
        onPressed: () {
          HapticFeedback.lightImpact();
          //todo refactor with blocLListener or change the implementation in bloc
          _onSubmit(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavigationBar(
          icon: Icon(Icons.close),
          color: Colors.red,
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.of(context).pop();
          }),
      body: BlocListener<CourseBloc, CourseState>(
        listener: (BuildContext context, state) {
          if (state is CourseLoadSuccess) {
          } else if (state is CourseLoadError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Container(
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ImagedHeader(
                    header1: widget.isEditing ? "Edit":  "Add",
                    header2: "Course",
                    header3: widget.collegeCode,
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    child: _form(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _form(BuildContext context) {
    return Form(
      autovalidate: _autoValidate,
      key: formKey,
      child: Column(
        children: <Widget>[
          TextFormFieldValidation(
            label: "Course Code",
            focusNode: _codeFocus,
            autofocus: true,
            initialValue: _courseRequest?.code,
            onValueChanged: (val) {
              _courseRequest.code = val.trim().toUpperCase();
            },
            onFieldSubmit: (val) =>
                {FocusScope.of(context).requestFocus(_nameFocus)},
          ),
          TextFormFieldValidation(
            label: "Course Name",
            focusNode: _nameFocus,
//            controller: _nameController,
            initialValue: _courseRequest?.name,
            validator: (String arg) {
              if (arg.length < 6)
                return 'Name must be more than 6 character';
              else
                return null;
            },
            onValueChanged: (val) {
              _courseRequest.name = val.trim();
            },
            onFieldSubmit: (val) =>
                {FocusScope.of(context).requestFocus(_descriptionFocus)},
          ),
          TextFormFieldValidation(
            label: "Description",
            focusNode: _descriptionFocus,
            initialValue: _courseRequest?.description,
            onValueChanged: (val) {
              _courseRequest.description = val.trim();
            },
            onFieldSubmit: (val) =>
                {FocusScope.of(context).requestFocus(_durationFocus)},
          ),
          TextFormFieldValidation(
            label: "Duration in Years",
            focusNode: _durationFocus,
            initialValue: _courseRequest.duration?.toString(),
            //fields cannot be changed
            enabled: !widget.isEditing,
            keyboardType:
                TextInputType.numberWithOptions(signed: false, decimal: false),
            textInputFormatter: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(1)
            ],
            validator: (val) {
              try {
                if (int.parse(val) < 1 && int.parse(val) > 9) {
                  return "value must be in range 0-9";
                } else {
                  return null;
                }
              } catch (e) {
                return "Only digits allowed";
              }
            },
            onValueChanged: (val) {
              _courseRequest.duration = int.tryParse(val.trim());
            },
            onFieldSubmit: (val) =>
                {FocusScope.of(context).requestFocus(_semesterPerYearFocus)},
          ),
          TextFormFieldValidation(
            label: "Semesters Per Year",
            focusNode: _semesterPerYearFocus,
            initialValue: _courseRequest.semesterPerYear?.toString(),
            //fields cannot be changed
            enabled: !widget.isEditing,
            keyboardType:
                TextInputType.numberWithOptions(signed: false, decimal: false),
            onFieldSubmit: (val) {
              FocusScope.of(context).unfocus();
              _onSubmit(context);
            },
            textInputFormatter: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(1)
            ],
            validator: (val) {
              try {
                if (int.parse(val) < 1 && int.parse(val) > 9) {
                  return "value must be in range 0-9";
                } else {
                  return null;
                }
              } catch (e) {
                return "Only digits allowed";
              }
            },
            onValueChanged: (val) {
              _courseRequest.semesterPerYear = int.tryParse(val.trim());
            },
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  _onSubmit(BuildContext context) {
    if (formKey.currentState.validate()) {
      BlocProvider.of<CourseBloc>(context).add(
        CourseCreate(
            collegeId: widget.collegeId, courseRequest: _courseRequest),
      );
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  void dispose() {
    _nameFocus.dispose();
    _codeFocus.dispose();
    _descriptionFocus.dispose();
    _durationFocus.dispose();
    _semesterPerYearFocus.dispose();
    super.dispose();
  }
}
