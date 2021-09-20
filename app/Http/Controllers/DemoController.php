<?php

namespace App\Http\Controllers;

use App\Services\DemoService;

class DemoController extends BaseController
{
    public function __construct()
    {
        $this->service = new DemoService();
        parent::__construct();
    }


}
