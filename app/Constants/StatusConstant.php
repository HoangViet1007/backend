<?php

namespace App\Constants;
/**
 * @Author apple
 * @Date   Sep 29, 2021
 */
class StatusConstant
{
    const ACTIVE    = 'Active';
    const INACTIVE  = 'Inactive';
    const PROCESS   = 'Process';
    const PROCESSED = 'Processed';

    // status course
    const PENDING   = 'Pending';
    const HAPPENING = 'Happening';
    const PAUSE     = 'Pause';

    // gửi yêu cầu
    const REQUEST = 'Request';

    // course_student
    const CANCELED     = 'Canceled';
    const CANCELEDBYPT = 'CanceledByPt';
    const UNSCHEDULED  = 'Unscheduled';
    const SCHEDULE     = 'Schedule';
    const COMPLETE     = 'Complete';

    // user_consent in course_student
    const UNSENT        = 'Unsent'; // chua gui yeu cau cho nguoi dung
    const SENT          = 'Sent'; // da gui yeu cau cho nguoi dung
    const USERAGREES    = 'UserAgrees'; // nguoi dung dong y
    const USERDISAGREES = 'UserDisAgrees'; // nguoi dung khong dong y

    // status schedule hoan thanh và chua hoan thanh (complete)
    const UNFINISHED = 'unfinished';
    // payments
    const RECHARGE = 'Nap tien';
    const PAY      = 'Thanh toan khoa hoc';

    // bills
    const WALLET = 'Thanh toan bang vi';
    const DIRECT = 'Thanh toan truc tiep';

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
            self::PAY,
            self::WALLET,
            self::DIRECT,
            self::COMPLETE,
            self::UNFINISHED,
            self::REQUEST
        ];
}
