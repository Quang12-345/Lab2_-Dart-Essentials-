import 'dart:async';
import 'dart:io';

// ==========================================
// EXERCISE 4: INTRO TO OOP
// ==========================================

// Lớp cơ sở Car với thuộc tính và constructor
class Car {
  String brand;

  // Constructor mặc định
  Car(this.brand);

  // Named constructor
  Car.unknown() : brand = 'Unknown Brand';

  // Phương thức mô tả hoạt động
  void drive() {
    print(' $brand đang chạy bằng động cơ xăng/dầu.');
  }
}

// Lớp con ElectricCar kế thừa từ Car
class ElectricCar extends Car {
  int batteryCapacity;

  // Gọi constructor của lớp cha thông qua super
  ElectricCar(String brand, this.batteryCapacity) : super(brand);

  // Override phương thức drive của lớp cha
  @override
  void drive() {
    print(' $brand đang chạy bằng điện (Pin: $batteryCapacity kWh).');
  }
}

// ==========================================
// EXERCISE 3: FUNCTIONS
// ==========================================

// Hàm thông thường (Block body)
int calculateSum(int a, int b) {
  return a + b;
}

// Hàm cú pháp rút gọn (Arrow syntax =>)
int multiply(int a, int b) => a * b;

// ==========================================
// EXERCISE 5: ASYNC & STREAM
// ==========================================

// Hàm bất đồng bộ mô phỏng gọi API mất 1 giây
Future<String> fetchUserData(String userName) async {
  await Future.delayed(const Duration(seconds: 1));
  return 'Dữ liệu người dùng: $userName';
}

// Hàm sinh luồng số nguyên (Stream) theo thời gian thực
Stream<int> countStream(int max) async* {
  for (int i = 1; i <= max; i++) {
    await Future.delayed(const Duration(milliseconds: 500));
    yield i; // Phát dữ liệu vào stream
  }
}

// ==========================================
// MENU CHÍNH VÀ CÁC HÀM THỰC THI BÀI TẬP
// ==========================================
void main() async {
  while (true) {
    print('\n=== MENU LAB 2 ===');
    print('1. Basic Syntax & Data Types');
    print('2. Collections & Operators');
    print('3. Control Flow & Functions');
    print('4. Intro to OOP');
    print('5. Async, Future, Null Safety & Streams');
    print('0. Thoát chương trình');

    final choice = readInt('Chọn bài muốn chạy: ', defaultValue: 0);
    if (choice == 0) {
      print('Đã thoát chương trình.');
      return;
    }

    if (choice < 1 || choice > 5) {
      print('Lựa chọn không hợp lệ. Vui lòng chọn từ 0 đến 5.');
      continue;
    }

    do {
      await runExercise(choice);
    } while (readBool(
      'Bạn có muốn chạy lại bài này không? (y/n): ',
      defaultValue: false,
    ));
  }
}

Future<void> runExercise(int choice) async {
  switch (choice) {
    case 1:
      runExercise1();
      break;
    case 2:
      runExercise2();
      break;
    case 3:
      runExercise3();
      break;
    case 4:
      runExercise4();
      break;
    case 5:
      await runExercise5();
      break;
  }
}

void runExercise1() {
  print('=== EXERCISE 1: BASIC SYNTAX & DATA TYPES ===');
  String name = readText('Vui lòng nhập tên của bạn: ', defaultValue: 'Khách');
  int age = readInt('Nhập tuổi: ', defaultValue: 18);
  double gpa = readDouble('Nhập GPA: ', defaultValue: 0.0);
  bool isEnrolled = readBool('Bạn còn đang học? (y/n): ', defaultValue: true);

  // In dùng string interpolation ($var và ${expr})
  print('Tên: $name | Tuổi: $age');
  print(
    'Điểm GPA: $gpa | Trạng thái học: ${isEnrolled ? "Đang học" : "Đã nghỉ"}',
  );
  print('Năm sinh dự kiến: ${DateTime.now().year - age}\n');
}

void runExercise2() {
  print('=== EXERCISE 2: COLLECTIONS & OPERATORS ===');
  List<int> numbers = readIntList(
    'Nhập danh sách số nguyên, cách nhau bằng dấu phẩy: ',
    defaultValue: [10, 20, 30],
  );
  numbers.add(readInt('Nhập một số để add(): ', defaultValue: 40));
  numbers.remove(readInt('Nhập một số để remove(): ', defaultValue: 20));
  print('List sau khi biến đổi: $numbers');

  // Toán tử số học, so sánh, logic và toán tử 3 ngôi (? :)
  int sum = numbers[0] + numbers[1];
  bool isLarge = (sum > 40) && (numbers.length >= 3);
  String status = isLarge ? 'Tổng lớn và đủ phần tử' : 'Không thỏa điều kiện';
  print('Tổng phần tử [0] + [1] = $sum -> $status');

  // Set (chỉ chứa các phần tử duy nhất)
  Set<String> uniqueTags = readTextSet(
    'Nhập các tag, cách nhau bằng dấu phẩy: ',
    defaultValue: {'flutter', 'dart', 'mobile'},
  );
  uniqueTags.add(readText('Nhập tag để thêm: ', defaultValue: 'dart'));
  print('Set duy nhất: $uniqueTags');

  // Map (Key - Value)
  String studentId = readText('Nhập mã sinh viên: ', defaultValue: 'SE12345');
  double studentScore = readDouble('Nhập điểm sinh viên: ', defaultValue: 8.5);
  Map<String, dynamic> student = {'id': studentId, 'score': studentScore};
  student['grade'] = 'A';
  print('Map thông tin: $student (Điểm: ${student['score']})\n');
}

void runExercise3() {
  print('=== EXERCISE 3: CONTROL FLOW & FUNCTIONS ===');
  double score = readDouble('Nhập điểm để xếp loại: ', defaultValue: 8.5);
  if (score >= 8.0) {
    print('Xếp loại: Giỏi');
  } else if (score >= 6.5) {
    print('Xếp loại: Khá');
  } else {
    print('Xếp loại: Trung bình');
  }

  int day = readInt('Nhập ngày trong tuần (1-7): ', defaultValue: 3);
  switch (day) {
    case 1:
      print('Hôm nay: Thứ Hai');
      break;
    case 3:
      print('Hôm nay: Thứ Tư');
      break;
    default:
      print('Ngày khác trong tuần');
  }

  List<String> fruits = readTextList(
    'Nhập danh sách trái cây, cách nhau bằng dấu phẩy: ',
    defaultValue: ['Táo', 'Chuối', 'Cam'],
  );
  stdoutWrite('Vòng for-in: ');
  for (var fruit in fruits) {
    stdoutWrite('$fruit ');
  }
  print('');

  stdoutWrite('Vòng forEach: ');
  fruits.forEach((item) => stdoutWrite('$item '));
  print('\n');

  int firstNumber = readInt('Nhập số thứ nhất để tính hàm: ', defaultValue: 5);
  int secondNumber = readInt('Nhập số thứ hai để tính hàm: ', defaultValue: 7);
  print(
    'Gọi hàm bình thường calculateSum: ${calculateSum(firstNumber, secondNumber)}',
  );
  print('Gọi hàm arrow multiply: ${multiply(firstNumber, secondNumber)}\n');
}

void runExercise4() {
  print('=== EXERCISE 4: INTRO TO OOP ===');
  String carBrand = readText(
    'Nhập tên xe xăng/dầu: ',
    defaultValue: 'Toyota Corolla',
  );
  Car regularCar = Car(carBrand);
  regularCar.drive();

  String electricBrand = readText(
    'Nhập tên xe điện: ',
    defaultValue: 'Tesla Model 3',
  );
  int batteryCapacity = readInt(
    'Nhập dung lượng pin (kWh): ',
    defaultValue: 75,
  );
  ElectricCar tesla = ElectricCar(electricBrand, batteryCapacity);
  tesla.drive();
  print('');
}

Future<void> runExercise5() async {
  print('=== EXERCISE 5: ASYNC, FUTURE, NULL SAFETY & STREAMS ===');
  String? nullableName = readNullableText(
    'Nhập tên cho dữ liệu bất đồng bộ (để trống để dùng Khách): ',
  );
  print('Sử dụng ??: Tên mặc định là "${nullableName ?? 'Khách'}"');

  nullableName ??= 'Trần Thị B';
  print('Sau khi gán giá trị mặc định nếu cần: $nullableName');
  // Ép kiểu không null bằng ! (chỉ dùng khi chắc chắn có dữ liệu)
  String definiteName = nullableName!;
  print('Độ dài chuỗi (dùng !): ${definiteName.length}');

  print('⏳ Đang gọi API giả lập...');
  String apiResult = await fetchUserData(nullableName);
  print('✅ $apiResult');

  print('⏳ Bắt đầu lắng nghe Stream số đếm:');
  int streamMax = readInt(
    'Nhập số phần tử Stream muốn nhận: ',
    defaultValue: 3,
  );
  await for (int val in countStream(streamMax)) {
    print('  -> Nhận từ Stream: $val');
  }
}

// Hàm hỗ trợ in không xuống dòng cho vòng lặp
void stdoutWrite(String text) {
  stdout.write(text);
}

// Đọc chuỗi và dùng giá trị mặc định khi người dùng bỏ trống.
String readText(String prompt, {required String defaultValue}) {
  stdout.write(prompt);
  final input = stdin.readLineSync()?.trim();
  return input == null || input.isEmpty ? defaultValue : input;
}

// Đọc số nguyên, lặp lại đến khi nhận được dữ liệu hợp lệ.
int readInt(String prompt, {required int defaultValue}) {
  while (true) {
    final input = readText(prompt, defaultValue: '');
    if (input.isEmpty) return defaultValue;
    final value = int.tryParse(input);
    if (value != null) return value;
    print('Vui lòng nhập một số nguyên hợp lệ.');
  }
}

// Đọc số thực, lặp lại đến khi nhận được dữ liệu hợp lệ.
double readDouble(String prompt, {required double defaultValue}) {
  while (true) {
    final input = readText(prompt, defaultValue: '');
    if (input.isEmpty) return defaultValue;
    final value = double.tryParse(input);
    if (value != null) return value;
    print('Vui lòng nhập một số thực hợp lệ.');
  }
}

// Chuyển câu trả lời y/yes hoặc n/no thành kiểu bool.
bool readBool(String prompt, {required bool defaultValue}) {
  while (true) {
    final input = readText(prompt, defaultValue: '').toLowerCase();
    if (input.isEmpty) return defaultValue;
    if (input == 'y' || input == 'yes') return true;
    if (input == 'n' || input == 'no') return false;
    print('Vui lòng nhập y/yes hoặc n/no.');
  }
}

// Tách dữ liệu nhập bằng dấu phẩy thành danh sách số nguyên.
List<int> readIntList(String prompt, {required List<int> defaultValue}) {
  while (true) {
    final input = readText(prompt, defaultValue: '');
    if (input.isEmpty) return [...defaultValue];
    final values = input
        .split(',')
        .map((item) => int.tryParse(item.trim()))
        .toList();
    if (values.length >= 2 && values.every((value) => value != null)) {
      return values.cast<int>();
    }
    print('Vui lòng nhập ít nhất hai số nguyên, ví dụ: 10, 20, 30.');
  }
}

// Tách dữ liệu nhập bằng dấu phẩy thành danh sách chuỗi.
List<String> readTextList(String prompt, {required List<String> defaultValue}) {
  final input = readText(prompt, defaultValue: '');
  if (input.isEmpty) return [...defaultValue];
  return input
      .split(',')
      .map((item) => item.trim())
      .where((item) => item.isNotEmpty)
      .toList();
}

Set<String> readTextSet(String prompt, {required Set<String> defaultValue}) {
  return readTextList(prompt, defaultValue: defaultValue.toList()).toSet();
}

String? readNullableText(String prompt) {
  stdout.write(prompt);
  final input = stdin.readLineSync()?.trim();
  return input == null || input.isEmpty ? null : input;
}
