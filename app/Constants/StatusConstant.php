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
    const PENDING   = 'Pending';
    const HAPPENING = 'Happening';
    const PAUSE     = 'Pause';

    // course_student
    const CANCELED     = 'Canceled';
    const CANCELEDBYPT = 'CanceledByPt';
    const UNSCHEDULED  = 'Unscheduled';
    const SCHEDULE     = 'Schedule';
    const COMPLETE     = 'Complete';

    // payments
    const RECHARGE = 'Nap tien';
    const PAY = 'Thanh toan khoa hoc';

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
        ];
}
