<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Lịch khóa học</title>
    <style>
        table{
            border:1px solid white;
            border-collapse:collapse;

        }
        th,td{
            border:1px solid white;
            padding:10px;
        }
    </style>
</head>

<body>
<div class="container" style="background-color: #222; border-radius: 12px;padding: 15px">
    <div class="col-md-12">
        <p style="text-align: center; color: #fff">Đây là email tự động, quý khách vui lòng không phản hồi luồng
            email này !</p>
        <div class="row" style="background-color: cadetblue;padding: 15px">
            <div class="col-md-12" style="font-size: 30px; color: #fff; text-align: center">Website thuê huấn luyện viên
                thể hình
            </div>
            <div class="col-md-12">
                <p style="font-weight: bold;">Xin chào st {{$name_student}} !</p>
                <p>Thời khóa biểu</p>
                <table>
                    <thead>
                    <tr>
                        <th>Khóa học</th>
                        <th>Giai đoạn</th>
                        <th>Kế hoạch</th>
                        <th>Thời gian học</th>
                        <th>Tên PT</th>
                        <th>Email</th>
                        <th>Số điện thoại</th>
                        <th>Link phòng học</th>
                    </tr>
                    </thead>
                    <tbody>
                    @foreach($arr_schedule as $value)
                        <tr>
                            <td>{{$value['name_course']}}</td>
                            <td>{{$value['name_stage']}}</td>
                            <td>{{$value['name_course_plane']}}</td>
                            <td>{{$value['time_start']}} - {{$value['time_end']}}</td>
                            <td>{{$value['name_teacher']}}</td>
                            <td>{{$value['email_teacher']}}</td>
                            <td>{{$value['phone_teacher']}}</td>
                            <td>{{$value['link_room']}}</td>
                        </tr>
                    @endforeach
                    </tbody>
                </table>
                <br>
                <i>Mọi thắc mắc về buổi học quý khách vui lòng liên hệ đến số điện thoại 0828890896 ! Một lần nữa cảm ơn quý khách
                    đã tin tưởng !</i>
            </div>
        </div>
    </div>
</div>
</body>

</html>
