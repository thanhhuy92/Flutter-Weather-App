# APP WEATHER

## Giới Thiệu

* App được xây dựng bằng framework flutter (ngôn ngữ dart) và app chạy được cả Android và IOS.

* App thiết kế đơn giản với một số thông tin như nhiệt độ, độ ẩm, gió, sức ép.

* App có chức năng cho người dùng biết được thông tin thời tiết hiện tại ở nơi mình đang sống hoặc ở bất kì một nước nào đó trên trái đất chỉ cần GPS định vị được.

## Thiết Lập Dự Án

* Mở Android Studio và tạo flutter mới với tên flutter-appweather.

* Sau khi hoàn tất tạo mới thì đã có sẵn một demo flutter.

## Lấy Dữ Liệu Weather Từ API

* Vào trang https://openweathermap.org.

* Tạo tài khoản, sau khi tạo xong nó sẽ cấp cho tài khoản đó một API.

* Click vào API trên thanh menu, sau đó click vào API doc tại "Current weather data".

* Ở đây mình chọn API "By geographic coordinates" tức là lấy dữ liệu thời tiết thông qua tọa độ (lat, lon) và click vào dòng "api.openweathermap.org/data/2.5/weather?lat=35&lon=139"

