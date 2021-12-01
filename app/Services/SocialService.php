<?php

namespace App\Services;

use App\Models\Social;

class SocialService extends BaseService
{

    function createModel(): void
    {
        $this->model = new Social();
    }

    public function getAllSocial()
    {
         $data = Social::all();
         return $data;
    }
}

?>
