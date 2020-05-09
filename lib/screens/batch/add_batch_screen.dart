import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/batch_bloc.dart';
import 'package:ums_flutter/components/buttons/flat_button_custom.dart';
import 'package:ums_flutter/components/drawer/Side_drawer.dart';
import 'package:ums_flutter/components/header/page_header.dart';
import 'package:ums_flutter/components/input/text_form_field_validation.dart';
import 'package:ums_flutter/event_state/batch/batch_event.dart';
import 'package:ums_flutter/event_state/batch/batch_state.dart';
import 'package:ums_flutter/models/request/batch_request.dart';
import 'package:ums_flutter/models/response/course_response.dart';
import 'package:ums_flutter/utils/sizeConfig.dart';

class AddBatchScreen extends StatefulWidget {
  final SideDrawer sideDrawer;
  final int courseID;

  const AddBatchScreen(
      {Key key, @required this.sideDrawer, @required this.courseID})
      : assert(sideDrawer != null),
        assert(courseID != null),
        super(key: key);

  @override
  _AddBatchScreenState createState() => _AddBatchScreenState();
}

class _AddBatchScreenState extends State<AddBatchScreen> {
  BatchRequest _batchRequest = BatchRequest();
  final formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  void _showDialog(CourseResponse courseResponse) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Color.fromRGBO(16, 16, 16, 1),
              ),
              width: SizeConfig.blockSizeHorizontal * 80,
              height: SizeConfig.blockSizeVertical * 30,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18)),
                      color: Color.fromRGBO(32, 32, 32, 1),
                    ),
                    height: SizeConfig.blockSizeVertical * 10,
                    padding: EdgeInsets.all(22),
                    child: Center(
                      child: Text(
                        'Course Added',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.blockSizeHorizontal * 7,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Color.fromRGBO(16, 16, 16, 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Course Added Successfully\nPress Continue to go back to College Screen',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: SizeConfig.blockSizeHorizontal * 3.75,
                          ),
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical * 2),
                        Center(
                          child: RaisedButton(
                              color: Colors.lightGreen,
                              child: Text(
                                "Continue",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _onCreateButtonPressed(BuildContext context) {
    BlocProvider.of<BatchBloc>(context).add(
        CreateBatch(courseId: widget.courseID, batchRequest: _batchRequest));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.black,
      drawer: widget.sideDrawer,
      floatingActionButton: new FloatingActionButton.extended(
        backgroundColor: Colors.green,
        icon: Icon(Icons.cloud_done),
        label: Text(
          'Save',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
        onPressed: () {
          if (formKey.currentState.validate()) {
            _onCreateButtonPressed(context);
          } else {
            //    If all data are not valid then start auto validation.
            setState(
              () {
                _autoValidate = true;
              },
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.list),
                color: Colors.white,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.close),
              color: Colors.red,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        color: Color(0xff101010),
      ),
      body: BlocListener<BatchBloc, BatchState>(
        listener: (BuildContext context, state) {
          if (state is BatchCreated) {
            return _showDialog(state.courseResponse);
          } else if (state is BatchError) {
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
                  Container(
                    height: SizeConfig.blockSizeVertical * 37.5,
                    width: SizeConfig.screenWidth,
                    child: Stack(
                      children: <Widget>[
                        ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black,
                                  Colors.transparent
                                ]).createShader(
                                Rect.fromLTRB(0, 0, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstIn,
                          //todo change image
                          child: Image.asset('images/university.jpg',
                              alignment: Alignment.topCenter,
                              width: SizeConfig.screenWidth,
                              height: SizeConfig.blockSizeVertical * 37.5,
                              fit: BoxFit.fill),
                        ),
                        Positioned(
                          bottom: SizeConfig.blockSizeVertical * 2,
                          left: 18,
                          child: PageHeader(
                            line1: "Add",
                            line2: "Batch",
                            marginBottom: 0,
                          ), //move to a function
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(18),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 18
                          ),
                          child: Text(
                            "Select the batch starting year",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 150,
                          margin: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Color(0xFF0D0D0D),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            border: Border.all(
                              width: 1,
                              color: Colors.white.withOpacity(.8),
                            ),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              //light theme
                              primaryColor: Color(0xFF0D0D0D),
                              accentColor: Color(0xFFFD3664),
                              //dark theme
                              backgroundColor: Color(0xFF0D0D0D),
                              textTheme: TextTheme(
                                body1: TextStyle(
                                  color: Colors.white70,
                                  height: 0,
                                ),
                              ),
                            ),
                            child: YearPicker(
                              lastDate: DateTime(DateTime.now().year + 1),
                              firstDate: DateTime(2000),
                              selectedDate: selectedDate ?? DateTime.now(),
                              onChanged: (DateTime value) {
                                setState(() {
                                  selectedDate = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
