<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title></title>
</head>

<body>
<div class="container" style="background-color: #222; border-radius: 12px;padding: 15px">
    <div class="col-md-12">
        <p style="text-align: center; color: #fff">Đây là email tự động, quý khách vui lòng không phản hồi luồng
            emai này !</p>
        <div class="row" style="background-color: cadetblue;padding: 15px">
            <div class="col-md-12" style="font-size: 30px; color: #fff; text-align: center">Website thuê huấn luyện
                viên cá nhân</div>
            <div class="col-md-12">
                <p style="font-weight: bold;">Xin chào {{ $nameUser }} !</p>
                <p>Cảm ơn bạn đã tin tưởng YM !</p>
                <h4>THÔNG BÁO HỌC VIÊN XÁC NHẬN THAM GIA BUỔI HỌC</h4>
                <p>Thời gian bắt đầu: <span style="color: #fff">{{ $time_start }}</span></p>
                <p>Thời gian kết thúc: <span style="color: #fff">{{ $time_end }}</span></p>
                <p>Tên buổi học: <span style="color: #fff">{{ $nameCourse }}</span></p>
                <p>Tên học viên: <span style="color: #fff">{{ $nameUserCustomer }}</span></p>
                <i>Bạn vui lòng để ý thới gian và bắt đầu buổi học đúng giờ ! </i>
                <br>
                <i>Mọi thắc mắc về đơn hàng quý khách vui lòng liên hệ đến 0853009301 ! Một lần nữa cảm ơn quý khách
                    đã tin tưởng YM !</i>
            </div>
        </div>
    </div>
</div>
</body>

</html>
