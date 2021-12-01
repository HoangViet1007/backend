<?php

namespace App\Imports;

use App\Models\Permission;
use Maatwebsite\Excel\Concerns\Importable;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;

class ImportPermission implements ToModel, withHeadingRow
{
    use Importable;

    public function model(array $row)
    {
       return new Permission([
                                'name' => $row['name'],
                                'display_name' => $row['display']
                             ]);
    }
}
