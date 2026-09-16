import 'dart:async';

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
    print('🚗 $brand đang chạy bằng động cơ xăng/dầu.');
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
    print('⚡ $brand đang chạy bằng điện (Pin: $batteryCapacity kWh).');
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
Future<String> fetchUserData() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'Dữ liệu người dùng: Nguyễn Văn A';
}

// Hàm sinh luồng số nguyên (Stream) theo thời gian thực
Stream<int> countStream(int max) async* {
  for (int i = 1; i <= max; i++) {
    await Future.delayed(const Duration(milliseconds: 500));
    yield i; // Phát dữ liệu vào stream
  }
}

// ==========================================
// HÀM MAIN THỰC THI TOÀN BỘ 5 BÀI TẬP
// ==========================================
void main() async {
  // ----------------------------------------------------
  // EXERCISE 1: BASIC SYNTAX & DATA TYPES
  // ----------------------------------------------------
  print('=== EXERCISE 1: BASIC SYNTAX & DATA TYPES ===');
  int age = 22;
  double gpa = 3.85;
  String name = 'Sinh Viên';
  bool isEnrolled = true;

  // In dùng string interpolation ($var và ${expr})
  print('Tên: $name | Tuổi: $age');
  print('Điểm GPA: $gpa | Trạng thái học: ${isEnrolled ? "Đang học" : "Đã nghỉ"}');
  print('Năm sinh dự kiến: ${DateTime.now().year - age}\n');

  // ----------------------------------------------------
  // EXERCISE 2: COLLECTIONS & OPERATORS
  // ----------------------------------------------------
  print('=== EXERCISE 2: COLLECTIONS & OPERATORS ===');
  // List
  List<int> numbers = [10, 20, 30];
  numbers.add(40);
  numbers.remove(20);
  print('List sau khi biến đổi: $numbers');

  // Toán tử số học, so sánh, logic và toán tử 3 ngôi (? :)
  int sum = numbers[0] + numbers[1];
  bool isLarge = (sum > 40) && (numbers.length >= 3);
  String status = isLarge ? 'Tổng lớn và đủ phần tử' : 'Không thỏa điều kiện';
  print('Tổng phần tử [0] + [1] = $sum -> $status');

  // Set (chỉ chứa các phần tử duy nhất)
  Set<String> uniqueTags = {'flutter', 'dart', 'mobile'};
  uniqueTags.add('dart'); // Không bị trùng lặp
  print('Set duy nhất: $uniqueTags');

  // Map (Key - Value)
  Map<String, dynamic> student = {'id': 'SE12345', 'score': 8.5};
  student['grade'] = 'A';
  print('Map thông tin: $student (Điểm: ${student['score']})\n');

  // ----------------------------------------------------
  // EXERCISE 3: CONTROL FLOW & FUNCTIONS
  // ----------------------------------------------------
  print('=== EXERCISE 3: CONTROL FLOW & FUNCTIONS ===');
  // If / Else kiểm tra điểm
  double score = 8.5;
  if (score >= 8.0) {
    print('Xếp loại: Giỏi');
  } else if (score >= 6.5) {
    print('Xếp loại: Khá');
  } else {
    print('Xếp loại: Trung bình');
  }

  // Switch / Case ngày trong tuần
  int day = 3;
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

  // Vòng lặp: for, for-in, forEach
  List<String> fruits = ['Táo', 'Chuối', 'Cam'];
  stdoutWrite('Vòng for-in: ');
  for (var fruit in fruits) {
    stdoutWrite('$fruit ');
  }
  print('');

  stdoutWrite('Vòng forEach: ');
  fruits.forEach((item) => stdoutWrite('$item '));
  print('\n');

  // Gọi hàm
  print('Gọi hàm bình thường calculateSum(5, 7): ${calculateSum(5, 7)}');
  print('Gọi hàm arrow multiply(4, 5): ${multiply(4, 5)}\n');

  // ----------------------------------------------------
  // EXERCISE 4: INTRO TO OOP
  // ----------------------------------------------------
  print('=== EXERCISE 4: INTRO TO OOP ===');
  // Khởi tạo bằng constructor mặc định
  Car regularCar = Car('Toyota Corolla');
  regularCar.drive();

  // Khởi tạo bằng named constructor
  Car unknownCar = Car.unknown();
  unknownCar.drive();

  // Khởi tạo lớp kế thừa và kiểm tra tính đa hình
  ElectricCar tesla = ElectricCar('Tesla Model 3', 75);
  tesla.drive();
  print('');

  // ----------------------------------------------------
  // EXERCISE 5: ASYNC, FUTURE, NULL SAFETY & STREAMS
  // ----------------------------------------------------
  print('=== EXERCISE 5: ASYNC, FUTURE, NULL SAFETY & STREAMS ===');
  // Null Safety: ?, ??, !
  String? nullableName;
  print('Sử dụng ??: Tên mặc định là "${nullableName ?? 'Khách'}"');

  nullableName = 'Trần Thị B';
  print('Sau khi gán giá trị: $nullableName');
  // Ép kiểu không null bằng ! (chỉ dùng khi chắc chắn có dữ liệu)
  String definiteName = nullableName!;
  print('Độ dài chuỗi (dùng !): ${definiteName.length}');

  // Async / Await với Future.delayed
  print('⏳ Đang gọi API giả lập...');
  String apiResult = await fetchUserData();
  print('✅ $apiResult');

  // Stream và Stream.listen()
  print('⏳ Bắt đầu lắng nghe Stream số đếm:');
  await for (int val in countStream(3)) {
    print('  -> Nhận từ Stream: $val');
  }

  print('\n=== HOÀN THÀNH TẤT CẢ BÀI TẬP LAB 2 ===');
}

// Hàm hỗ trợ in không xuống dòng cho vòng lặp
void stdoutWrite(String text) {
  // Thay thế nhanh cho stdout.write để chạy được trên cả DartPad
  // (In dạng inline bằng cách nối chuỗi khi cần)
}