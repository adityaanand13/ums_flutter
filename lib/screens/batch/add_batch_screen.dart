import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/bloc.dart';
import 'package:ums_flutter/components/components.dart';
import 'package:ums_flutter/models/models.dart';
import 'package:ums_flutter/utils/utils.dart';

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

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  void _showDialog(BatchResponse batchResponse) {
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
                                HapticFeedback.lightImpact();
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
    BlocProvider.of<BatchBloc>(context).add(BatchCreate(
        courseId: widget.courseID,
        batchRequest: BatchRequest.create(name: selectedDate.year.toString())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: widget.sideDrawer,
      floatingActionButton: new FloatingActionButton.extended(
        backgroundColor: Colors.green,
        icon: Icon(
          Icons.create_new_folder,
          color: Colors.white70,
        ),
        label: Text(
          'Add',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
        onPressed: () {
          _onCreateButtonPressed(context);
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
                onPressed: () {
                  HapticFeedback.lightImpact();
                  Navigator.of(context).pop();
                }),
          ],
        ),
        color: Color(0xff101010),
      ),
      body: BlocListener<BatchBloc, BatchState>(
        listener: (BuildContext context, state) {
          if (state is BatchLoadSuccess) {
            return _showDialog(state.batchResponse);
          } else if (state is BatchLoadError) {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ImagedHeader(
                  header1: 'Add',
                  header2: 'Batch',
                ),
                Container(
                  padding: EdgeInsets.all(SIDE_MARGIN),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 18),
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
                        height: 300,
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
                            firstDate: DateTime(1998),
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
    );
  }
}
