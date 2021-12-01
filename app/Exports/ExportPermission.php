<?php

namespace App\Exports;

use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithEvents;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithTitle;
use Maatwebsite\Excel\Events\AfterSheet;
use Maatwebsite\Excel\Excel;

class ExportPermission implements FromCollection, WithTitle, WithHeadings, WithEvents
{
    public function title(): string
    {
        return 'data';
    }

    /**
     * It's required to define the fileName within
     * the export class when making use of Responsible.
     */
    private string $fileName = 'Template_permission.xlsx';

    /**
     * Optional Writer Type
     */
    private string $writerType = Excel::XLSX;

    /**
     * Optional headers
     */
    private array $headers
        = [
            'Content-Type' => 'text/csv',
        ];

    /**
     * @return \Illuminate\Support\Collection
     */
    public function collection()
    {
        return collect([
                           ['course:list', 'Danh sách khoá học'],
                           ['course:add', 'Thêm mới khoá học'],
                           ['course:edit', 'Chỉnh sửa khoá học'],
                           ['course:delete', 'Xoá khoá học'],
                       ]);
    }

    public function registerEvents(): array
    {
        return [
            AfterSheet::class => function (AfterSheet $event) {
                $event->sheet->getDelegate()->getStyle('A1:B1')
                             ->getFill()
                             ->setFillType(\PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID)
                             ->getStartColor()
                             ->setARGB('f1c232');
            },
        ];
    }

    public function headings(): array
    {
        return ["Name", "Display"];
    }
}
