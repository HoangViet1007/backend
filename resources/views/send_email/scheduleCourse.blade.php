<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Lịch khóa học</title>
</head>

<body>
<div class="container" style="background-color: #222; border-radius: 12px;padding: 15px">
    <div class="col-md-12">
        <p style="text-align: center; color: #fff">Đây là email tự động, quý khách vui lòng không phản hồi luồng
            email này !</p>
        <div class="row" style="background-color: cadetblue;padding: 15px">
            <div class="col-md-12" style="font-size: 30px; color: #fff; text-align: center">Website thuê huấn luyện viên thể hình</div>
            <div class="col-md-12">
                <p style="font-weight: bold;">Xin chào {{ $name_student }} !</p>
                <p>Hôm nay ngày {{$date_study}} .  Bạn có khóa học {{$name_couser}} vào lúc {{$time_hour}} với {{$name_pt}}</p>
                <p>Link phòng room : {{$link_room}} </p>
                <br>
                <i>Mọi thắc mắc về buổi học quý khách vui lòng liên hệ đến {{$phone_pt}} ! Một lần nữa cảm ơn quý khách
                    đã tin tưởng !</i>
            </div>
        </div>
    </div>
</div>
</body>

</html>
