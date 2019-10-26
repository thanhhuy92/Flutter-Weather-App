# APP WEATHER

## Giới Thiệu

* App được xây dựng bằng framework flutter (ngôn ngữ dart) và app chạy được cả Android và IOS.

* App thiết kế đơn giản với một số thông tin như nhiệt độ, độ ẩm, gió, sức ép.

* App có chức năng cho người dùng biết được thông tin thời tiết hiện tại ở nơi mình đang sống hoặc ở bất kì một nước nào đó trên trái đất chỉ cần GPS định vị được.

## Thiết Lập Dự Án

* Mở Android Studio và tạo flutter mới với tên flutter-appweather.

<img src= "Images/img-weather1.jpg" />

* Sau khi hoàn tất tạo mới thì đã có sẵn một demo flutter.

<img src= "Images/img-weather2.jpg" />

## Lấy Dữ Liệu Weather Từ API

* Vào trang https://openweathermap.org.

* Tạo tài khoản, sau khi tạo xong nó sẽ cấp cho tài khoản đó một API.

<img src= "Images/img-weather3.jpg" />

* Click vào API trên thanh menu, sau đó click vào API doc tại "Current weather data".

<img src= "Images/img-weather4.jpg" />

* Ở đây mình chọn API "By geographic coordinates" tức là lấy dữ liệu thời tiết thông qua tọa độ (lat, lon) và click vào dòng chữ được đánh khung.

<img src= "Images/img-weather5.jpg" />

* Ta sẽ thay đổi thanh địa chỉ tại vị trí được khoanh

<img src= "Images/img-weather6.jpg" />

* Thay đổi ở phần trước.

<img src= "Images/img-weather7.jpg" />

* Ở phần sau ta lấy API ở tài khoản gán vào phần sau thanh địa chỉ.

<img src= "Images/img-weather8.jpg" />

* Và ta có kết quả.

<img src= "Images/img-weather9.jpg" />

* Copy hết nội dung bên dưới, vào trang http://json2csharp.com/, paste vào "Enter JSON or a URL to JSON" và click vào "Generate".

* Được kết quả như hình dưới.

* Quay lại Android Studio, ta tạo một package tên Models (chuột phải vào lib -> New -> Package).

* Tạo một file dart tên WeatherModels trong Models (chuột phải Models -> New -> Dart File).

* Bên Json2csharp, ta copy class Coord và Weather gán vào trong file dart WeatherModels.

* Thay public -> final, thay { get; set;} -> ;.

* Thêm constructor cho class và tạo lớp mô hình theo json_serializable.




