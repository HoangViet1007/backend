<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Xác nhận nạp tiền</title>
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
                <h4>THÔNG TIN NẠP TIỀN</h4>
                <p>Ngân hàng: <span style="color: #fff">{{ $code_bank }}</span></p>
                <p>Tên khách hàng: <span style="color: #fff">{{ $nameUser }}</span></p>
                <p>Mã vnpay: <span style="color: #fff">{{ $code_vnp }}</span></p>
                <p>Số tiền: <span style="color: #fff">{{ number_format($money) }} Đ</span></p>
                <p>Thời gian: <span style="color: #fff">{{ $time }}</span></p>
                <p>Loại thanh toán: <span style="color: #fff">{{ $note }}</span></p>
                -----------------------------------------------------
                <h4>TỔNG TIỀN: {{ number_format($money) }} Đ</h4>
                -----------------------------------------------------
                <br>
                <i>Mọi thắc mắc về đơn hàng quý khách vui lòng liên hệ đến 0853009301 ! Một lần nữa cảm ơn quý khách
                    đã tin tưởng YM !</i>
            </div>
        </div>
    </div>
</div>
</body>

</html>
