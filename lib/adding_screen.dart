import 'package:flutter/material.dart';
import 'db/database_helper.dart';

class AddingScreen extends StatefulWidget {
  final int userId; // Pass the userId to link the customer to a user
  AddingScreen({required this.userId});

  @override
  _AddingScreenState createState() => _AddingScreenState();
}

class _AddingScreenState extends State<AddingScreen> {
  final _formKey = GlobalKey<FormState>();

  // TextEditingControllers for all the fields
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  // Controllers for Miền Nam
  TextEditingController _mienNamCoHaiConBaoController = TextEditingController();
  TextEditingController _mienNamHaiConDauDoiController = TextEditingController();
  TextEditingController _mienNamCoDaThangController = TextEditingController();
  TextEditingController _mienNamCachTrungDaThangController = TextEditingController();
  TextEditingController _mienNamCoDaXienController = TextEditingController();
  TextEditingController _mienNamCachTrungDaXienController = TextEditingController();
  TextEditingController _mienNamCoBaConController = TextEditingController();
  TextEditingController _mienNamCoBonConController = TextEditingController();

  // Controllers for Miền Trung
  TextEditingController _mienTrungCoHaiConBaoController = TextEditingController();
  TextEditingController _mienTrungHaiConDauDoiController = TextEditingController();
  TextEditingController _mienTrungCoDaThangController = TextEditingController();
  TextEditingController _mienTrungCachTrungDaThangController = TextEditingController();
  TextEditingController _mienTrungCoDaXienController = TextEditingController();
  TextEditingController _mienTrungCachTrungDaXienController = TextEditingController();
  TextEditingController _mienTrungCoBaConController = TextEditingController();
  TextEditingController _mienTrungCoBonConController = TextEditingController();

  // Controllers for Miền Bắc
  TextEditingController _mienBacCoHaiConBaoController = TextEditingController();
  TextEditingController _mienBacHaiConDauDoiController = TextEditingController();
  TextEditingController _mienBacCoDaThangController = TextEditingController();
  TextEditingController _mienBacCachTrungDaThangController = TextEditingController();
  TextEditingController _mienBacCoDaXienController = TextEditingController();
  TextEditingController _mienBacCachTrungDaXienController = TextEditingController();
  TextEditingController _mienBacCoBaConController = TextEditingController();
  TextEditingController _mienBacCoBonConController = TextEditingController();

  // Role selection
  String role = 'Khách'; // For radio button selection

  // Radio group selections for each section
  String? mienNamRadioGroup;
  String? mienTrungRadioGroup;
  String? mienBacRadioGroup;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Function to save customer data
  void _saveCustomer() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> newCustomer = {
        'name': _nameController.text,
        'phone': _phoneController.text,
        'role': role,
        // Miền Nam fields
        'mienNamCoHaiConBao': _mienNamCoHaiConBaoController.text,
        'mienNamHaiConDauDoi': _mienNamHaiConDauDoiController.text,
        'mienNamCoDaThang': _mienNamCoDaThangController.text,
        'mienNamCachTrungDaThang': _mienNamCachTrungDaThangController.text,
        'mienNamCoDaXien': _mienNamCoDaXienController.text,
        'mienNamCachTrungDaXien': _mienNamCachTrungDaXienController.text,
        'mienNamCoBaCon': _mienNamCoBaConController.text,
        'mienNamCoBonCon': _mienNamCoBonConController.text,
        'mienNamRadioGroup': mienNamRadioGroup,
        // Miền Trung fields
        'mienTrungCoHaiConBao': _mienTrungCoHaiConBaoController.text,
        'mienTrungHaiConDauDoi': _mienTrungHaiConDauDoiController.text,
        'mienTrungCoDaThang': _mienTrungCoDaThangController.text,
        'mienTrungCachTrungDaThang': _mienTrungCachTrungDaThangController.text,
        'mienTrungCoDaXien': _mienTrungCoDaXienController.text,
        'mienTrungCachTrungDaXien': _mienTrungCachTrungDaXienController.text,
        'mienTrungCoBaCon': _mienTrungCoBaConController.text,
        'mienTrungCoBonCon': _mienTrungCoBonConController.text,
        'mienTrungRadioGroup': mienTrungRadioGroup,
        // Miền Bắc fields
        'mienBacCoHaiConBao': _mienBacCoHaiConBaoController.text,
        'mienBacHaiConDauDoi': _mienBacHaiConDauDoiController.text,
        'mienBacCoDaThang': _mienBacCoDaThangController.text,
        'mienBacCachTrungDaThang': _mienBacCachTrungDaThangController.text,
        'mienBacCoDaXien': _mienBacCoDaXienController.text,
        'mienBacCachTrungDaXien': _mienBacCachTrungDaXienController.text,
        'mienBacCoBaCon': _mienBacCoBaConController.text,
        'mienBacCoBonCon': _mienBacCoBonConController.text,
        'mienBacRadioGroup': mienBacRadioGroup,
      };

      // Insert customer into the database
      await _dbHelper.insertCustomer(widget.userId, newCustomer);

      // Navigate back to the dashboard after saving
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo khách hàng'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveCustomer, // Save customer when pressed
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Field for customer name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Tên'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Field for customer phone
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'SĐT'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số điện thoại';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Role (Khách or Chủ)
              Text('Khách hay Chủ'),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text('Khách'),
                      leading: Radio<String>(
                        value: 'Khách',
                        groupValue: role,
                        onChanged: (value) {
                          setState(() {
                            role = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text('Chủ'),
                      leading: Radio<String>(
                        value: 'Chủ',
                        groupValue: role,
                        onChanged: (value) {
                          setState(() {
                            role = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // **Miền Nam**
              Text(
                '**Miền Nam**',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              _buildTextField(_mienNamCoHaiConBaoController, 'Cò hai con bao:'),
              _buildTextField(_mienNamHaiConDauDoiController, 'Hai con đầu đuôi:'),
              _buildTextField(_mienNamCoDaThangController, 'Cò đá thẳng:'),
              _buildTextField(_mienNamCachTrungDaThangController, 'Cò Đá Thẳng Trúng Đá Thẳng:'),
              _buildRadioGroup(
                title: 'Chọn tùy chọn:',
                option1: 'Một lần',
                option2: 'Kỳ rưỡi',
                option3: 'Nhiều cặp',
                groupValue: mienNamRadioGroup,
                onChanged: (value) {
                  setState(() {
                    mienNamRadioGroup = value;
                  });
                },
              ),
              _buildTextField(_mienNamCoDaXienController, 'Cò đá xiên:'),
              _buildTextField(_mienNamCachTrungDaXienController, 'Cò Đá Xiên Trúng Đá Xiên:'),
              _buildRadioGroup(
                title: 'Chọn tùy chọn:',
                option1: 'Một lần',
                option2: 'Kỳ rưỡi',
                option3: 'Nhiều cặp',
                groupValue: mienNamRadioGroup,
                onChanged: (value) {
                  setState(() {
                    mienNamRadioGroup = value;
                  });
                },
              ),
              _buildTextField(_mienNamCoBaConController, 'Cò ba con:'),
              _buildTextField(_mienNamCoBonConController, 'Cò bốn con:'),
              SizedBox(height: 20),

              // **Miền Trung**
              Text(
                '**Miền Trung**',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              _buildTextField(_mienTrungCoHaiConBaoController, 'Cò hai con bao:'),
              _buildTextField(_mienTrungHaiConDauDoiController, 'Hai con đầu đuôi:'),
              _buildTextField(_mienTrungCoDaThangController, 'Cò đá thẳng:'),
              _buildTextField(_mienTrungCachTrungDaThangController, 'Cò Đá Thẳng Trúng Đá Thẳng:'),
              _buildRadioGroup(
                title: 'Chọn tùy chọn:',
                option1: 'Một lần',
                option2: 'Kỳ rưỡi',
                option3: 'Nhiều cặp',
                groupValue: mienTrungRadioGroup,
                onChanged: (value) {
                  setState(() {
                    mienTrungRadioGroup = value;
                  });
                },
              ),
              _buildTextField(_mienTrungCoDaXienController, 'Cò đá xiên:'),
              _buildTextField(_mienTrungCachTrungDaXienController, 'Cò Đá Xiên Trúng Đá Xiên:'),
              _buildRadioGroup(
                title: 'Chọn tùy chọn:',
                option1: 'Một lần',
                option2: 'Kỳ rưỡi',
                option3: 'Nhiều cặp',
                groupValue: mienTrungRadioGroup,
                onChanged: (value) {
                  setState(() {
                    mienTrungRadioGroup = value;
                  });
                },
              ),
              _buildTextField(_mienTrungCoBaConController, 'Cò ba con:'),
              _buildTextField(_mienTrungCoBonConController, 'Cò bốn con:'),
              SizedBox(height: 20),

              // **Miền Bắc**
              Text(
                '**Miền Bắc**',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              _buildTextField(_mienBacCoHaiConBaoController, 'Cò hai con bao:'),
              _buildTextField(_mienBacHaiConDauDoiController, 'Hai con đầu đuôi:'),
              _buildTextField(_mienBacCoDaThangController, 'Cò đá thẳng:'),
              _buildTextField(_mienBacCachTrungDaThangController, 'Cò Đá Thẳng Trúng Đá Thẳng:'),
              _buildRadioGroup(
                title: 'Chọn tùy chọn:',
                option1: 'Một lần',
                option2: 'Kỳ rưỡi',
                option3: 'Nhiều cặp',
                groupValue: mienBacRadioGroup,
                onChanged: (value) {
                  setState(() {
                    mienBacRadioGroup = value;
                  });
                },
              ),
              _buildTextField(_mienBacCoDaXienController, 'Cò đá xiên:'),
              _buildTextField(_mienBacCachTrungDaXienController, 'Cò Đá Xiên Trúng Đá Xiên:'),
              _buildRadioGroup(
                title: 'Chọn tùy chọn:',
                option1: 'Một lần',
                option2: 'Kỳ rưỡi',
                option3: 'Nhiều cặp',
                groupValue: mienBacRadioGroup,
                onChanged: (value) {
                  setState(() {
                    mienBacRadioGroup = value;
                  });
                },
              ),
              _buildTextField(_mienBacCoBaConController, 'Cò ba con:'),
              _buildTextField(_mienBacCoBonConController, 'Cò bốn con:'),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to build text fields with controller
  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          // Optionally add validation if needed
          return null;
        },
      ),
    );
  }

  // Helper widget to build radio button groups with dynamic groupValue and onChanged
  Widget _buildRadioGroup({
    required String title,
    required String option1,
    required String option2,
    required String option3,
    required String? groupValue,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text(option1),
                leading: Radio<String>(
                  value: option1,
                  groupValue: groupValue,
                  onChanged: onChanged,
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(option2),
                leading: Radio<String>(
                  value: option2,
                  groupValue: groupValue,
                  onChanged: onChanged,
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(option3),
                leading: Radio<String>(
                  value: option3,
                  groupValue: groupValue,
                  onChanged: onChanged,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
