<?php

namespace App\Constants;
/**
 * @Author apple
 * @Date   Sep 29, 2021
 */
class StatusConstant
{
    const ACTIVE = 'Active';
    const INACTIVE = 'Inactive';
    const PROCESS = 'Process';
    const PROCESSED = 'Processed';

    // status course
    const PENDING = 'Pending';
    const HAPPENING = 'Happening';
    const PAUSE = 'Pause';

    // gửi yêu cầu
    const REQUEST = 'Request';

    // course_student
    const CANCELED = 'Canceled';
    const CANCELEDBYPT = 'CanceledByPt';
    const UNSCHEDULED = 'Unscheduled';
    const SCHEDULE = 'Schedule';
    const REQUESTADMIN = 'RequestAdmin'; // gửi yêu cầu cho admin khi hoàn thành khoá dạy
    const COMPLETE = 'Complete';

    // user_consent in course_student
    const UNSENT = 'Unsent'; // chua gui yeu cau cho nguoi dung
    const SENT = 'Sent'; // da gui yeu cau cho nguoi dung
    const USERAGREES = 'UserAgrees'; // nguoi dung dong y
    const USERDISAGREES = 'UserDisAgrees'; // nguoi dung khong dong y

    // status schedule hoan thanh và chua hoan thanh (complete)
    const UNFINISHED = 'unfinished';
    const HAPPENNING = 'happenning';

    // complain schedules (khiếu nại và không khiếu nại - complain và no_complaints)
    const COMPLAIN = 'Complain';
    const NOCOMPLAINTS = 'NoComplaints';

    // participation schedules (tham gia và không tham gia - join và no_join)
    const JOIN = 'Join';
    const NOJOIN = 'NoJoin';

    // payments
    const RECHARGE = 'Rechage'; // nạp tiền
    const COURSEPAYMENT = 'CoursePayment'; // thanh toán khóa học

    // bills
    const WALLET = 'Wallet'; // mua khoa hoc bang vi
    const DIRECT = 'Direct'; // mua khoa hoc thanh toan truc tiep bang vnpay
// trạng thái check_link_record
    const SENTSUCCESS = 0;
    const SENTFALSE = 1;
    const All
        = [
            self::ACTIVE,
            self::INACTIVE,
            self::PROCESS,
            self::PROCESSED,
            self::HAPPENING,
            self::PENDING,
            self::PAUSE,
            self::CANCELED,
            self::CANCELEDBYPT,
            self::UNSCHEDULED,
            self::SCHEDULE,
            self::COMPLETE,
            self::RECHARGE,
            self::COURSEPAYMENT,
            self::WALLET,
            self::DIRECT,
            self::COMPLETE,
            self::UNFINISHED,
            self::REQUEST,
            self::HAPPENNING,
            self::COMPLAIN,
            self::NOCOMPLAINTS,
            self::JOIN,
            self::NOJOIN
        ];
}
