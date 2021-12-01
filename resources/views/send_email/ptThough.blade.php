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
            <div class="col-md-12"><p style="font-size: 30px; color: #fff; text-align: center">Website thuê huấn luyện
                    viên thể hình</p></div>
            <div class="col-md-12">
                <p style="font-weight: bold;">Xin chào {{ $student_name }} !</p>
                <p>Bạn có khóa học '{{$name_course}}' đăng ký vào ngày {{ $created_at }}.</p>
                <p>Khoá học của ban đã được PT : '{{ $teacher_name }}' duyệt . Hãy truy cập website để xem lịch học cụ thể nha.</p>
                <p>Chân thành cảm ơn bạn đã tin tưởng và sử dụng website của chúng tôi.</p>
                <i>Mọi thắc mắc về khoá học vui lòng liên hệ đến 0828890896.</i>
            </div>
        </div>
    </div>
</div>
</body>

</html>
