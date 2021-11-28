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
            <div class="col-md-12"><p  style="font-size: 30px; color: #fff; text-align: center">Website thuê huấn luyện viên thể hình</p> </div>
            <div class="col-md-12">
                <p style="font-weight: bold;">Xin chào {{ $teacher_name }} !</p>
                <p>Tôi là {{$student_name}} học viên đã đăng ký khoá học '{{$name_courser}}' của bạn vào ngày {{ $created_at }}.</p>
                <p>Lý do huỷ khoá học : {{ $description }}.</p>
                <p>Tôi rất xin lỗi vì sự cố này, mong bạn thông cảm.</p>
                <p>Tôi chân thành cảm ơn!</p>
            </div>
        </div>
    </div>
</div>
</body>

</html>
