import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/colleges/bloc.dart';
import 'package:ums_flutter/components/components.dart';
import 'package:ums_flutter/models/models.dart';
import 'package:ums_flutter/screens/college/assign_edit_principal.dart';
import 'package:ums_flutter/validator/validator.dart';

class AddEditCollegeScreen extends StatefulWidget {
  final SideDrawer sideDrawer;
  final bool isEditing;
  final CollegeResponse collegeResponse;

  const AddEditCollegeScreen(
      {Key key,
      @required this.sideDrawer,
      this.isEditing = false,
      this.collegeResponse})
      : assert(sideDrawer != null),
        super(key: key);

  @override
  _AddEditCollegeScreenState createState() => _AddEditCollegeScreenState();
}

class _AddEditCollegeScreenState extends State<AddEditCollegeScreen> {
  final _nameFocus = FocusNode();
  final _codeFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _addressFocus = FocusNode();
  final formKey = GlobalKey<FormState>();

  CollegeRequest _collegeRequest;
  bool _autoValidate;
  bool _reqSubmitted;

  @override
  void initState() {
    _collegeRequest = widget.collegeResponse != null
        ? CollegeRequest.fromResponse(collegeResponse: widget.collegeResponse)
        : CollegeRequest();
    _autoValidate = false;
    _reqSubmitted = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: widget.sideDrawer,
      floatingActionButton: CustomFloatingActionButton(
          label: 'Save',
          color: Colors.green,
          icon: Icon(
            Icons.cloud_upload,
            color: Colors.white,
          ),
          onPressed: () {
            HapticFeedback.lightImpact();
            _onSubmit(context);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavigationBar(
        icon: Icon(Icons.close),
        color: Colors.red,
        onPressed: () {
          HapticFeedback.lightImpact();
          CollegesState state = BlocProvider.of<CollegesBloc>(context).state;
          if (state is CollegesLoadError) {
            BlocProvider.of<CollegesBloc>(context).add(CollegesLoaded());
          } else if (state is CollegesLoadInProgress) {
            BlocProvider.of<CollegesBloc>(context).add(CollegesUpdated());
          }
          Navigator.of(context).pop();
        },
      ),
      body: BlocListener<CollegesBloc, CollegesState>(
        listener: (BuildContext context, state) {
          if (state is CollegesLoadSuccess && _reqSubmitted) {
            CollegeResponse collegeResponse = state.collegesResponse.firstWhere(
                (v) => (v.name == _collegeRequest.name &&
                    v.email == _collegeRequest.email &&
                    v.address == _collegeRequest.address),
                orElse: () => null);
            if (collegeResponse != null) {
              return customButtonDialog(
                  context: context,
                  header: "College Created",
                  data:
                      "College Has been created, press continue to Assign principle",
                  onPressed: () {
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new AssignEditPrincipalScreen(
                          sideDrawer: widget.sideDrawer,
                          collegeResponse: collegeResponse,
                        ),
                      ),
                    );
                  });
            } else {
              //todo show error dialog
              _reqSubmitted = false;
            }
          } else if (state is CollegesLoadError) {
            _reqSubmitted = false;
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 6),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Container(
            child: GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.375,
                    width: double.infinity,
                    child: Stack(
                      children: <Widget>[
                        ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black, Colors.transparent],
                            ).createShader(
                                Rect.fromLTRB(0, 0, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstIn,
                          //todo change image
                          child: Image.asset('images/university.jpg',
                              alignment: Alignment.topCenter,
                              width: double.infinity,
                              height:
                                  MediaQuery.of(context).size.height * 0.375,
                              fit: BoxFit.fill),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 18,
                          child: PageHeader(
                            line1: widget.isEditing ? "Edit":  "Add",
                            line2: "College",
                            marginBottom: 0,
                          ), //move to a function
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(18),
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

  Widget _form(BuildContext context){
    return Form(
      autovalidate: _autoValidate,
      key: formKey,
      child: Column(
        children: <Widget>[
          TextFormFieldValidation(
            label: "College Code",
            initialValue: widget.isEditing? _collegeRequest.code : "MM",
            focusNode: _codeFocus,
            autofocus: true,
            onFieldSubmit: (val) => {
              FocusScope.of(context).requestFocus(_nameFocus)
            },
            onValueChanged: (val) {
              _collegeRequest.code = val.trim().toUpperCase();
            },
            prefixIcon: Icons.confirmation_number,
          ),
          TextFormFieldValidation(
            label: "College Name",
            initialValue: widget.isEditing? _collegeRequest.name : "MM ",
            focusNode: _nameFocus,
            onFieldSubmit: (val) => {
              FocusScope.of(context).requestFocus(_phoneFocus)
            },
            validator: (String arg) {
              if (arg.length < 6)
                return 'Name must be more than 6 character';
              else
                return null;
            },
            onValueChanged: (val) {
              _collegeRequest.name = val.trim();
            },
            prefixIcon: Icons.location_city,
          ),
          TextFormFieldValidation(
            label: "Phone Number",
            focusNode: _phoneFocus,
            initialValue: _collegeRequest.phone,
            onFieldSubmit: (val) => {
              FocusScope.of(context).requestFocus(_emailFocus)
            },
            textInputFormatter: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(13)
            ],
            keyboardType:
            TextInputType.numberWithOptions(signed: true),
            validator: Validator.validateMobile,
            onValueChanged: (val) {
              _collegeRequest.phone = val.trim();
            },
            prefixIcon: Icons.phone_iphone,
          ),
          TextFormFieldValidation(
            label: "Email Address",
            focusNode: _emailFocus,
            initialValue: _collegeRequest.email,
            keyboardType: TextInputType.emailAddress,
            onFieldSubmit: (val) => {
              FocusScope.of(context).requestFocus(_addressFocus)
            },
            validator: Validator.validateEmail,
            onValueChanged: (val) {
              _collegeRequest.email = val.trim().toLowerCase();
            },
            prefixIcon: Icons.alternate_email,
          ),
          TextFormFieldValidation(
            label: "Address",
            focusNode: _addressFocus,
            initialValue: _collegeRequest.address,
            keyboardType: TextInputType.multiline,
            isLastEntry: true,
            onValueChanged: (val) {
              _collegeRequest.address = val.trim();
            },
            onFieldSubmit: (val) {
              _onSubmit(context);
            },
            prefixIcon: Icons.add_location,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  _onSubmit(BuildContext context) {
    if (formKey.currentState.validate()) {
      _reqSubmitted = true;
      BlocProvider.of<CollegesBloc>(context).add(
        CollegeCreated(collegeRequest: _collegeRequest),
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
    _phoneFocus.dispose();
    _emailFocus.dispose();
    _addressFocus.dispose();
    super.dispose();
  }
}
