import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
final selectImageProfileProvider=StateProvider<int>((ref) => 0);

final formGroupProvider=Provider<FormGroup>((ref){
return FormGroup({
'FirstName': FormControl<String>(validators: [Validators.required]),
'LastName': FormControl<String>(validators: [Validators.required]),
'Email': FormControl<String>(validators: [Validators.required,Validators.email]),
'Password': FormControl<String>(validators: [Validators.required]),
'DisplayName': FormControl<String>(validators: [Validators.required]),
  'imageUrl': FormControl<String>(value: "images/user1.png",validators: [Validators.required,]),


});});

