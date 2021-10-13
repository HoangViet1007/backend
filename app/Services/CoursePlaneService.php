<?php

namespace App\Services;

use App\Constants\StatusConstant;
use App\Models\CoursePlanes;
<<<<<<< HEAD
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;
use Aws\S3\S3Client;
use Aws\Exception\AwsException;
=======
use App\Services\BaseService;
use App\Models\Stage;
use Illuminate\Database\Eloquent\Model;
>>>>>>> 65474b75a689dd68328775a646690eaab3d27b76

class CoursePlaneService extends BaseService
{
    protected array $status = [StatusConstant::ACTIVE, StatusConstant::INACTIVE];

    function createModel(): void
    {
        $this->model = new CoursePlanes();
    }

    public function storeRequestValidate(object $request, array $rules = [], array $messages = []): bool|array
    {
        $rules = [
            'name' => 'required|unique:course_planes,name',
            'content' => 'required',
            'descreption' => 'required',
            'video_link' => 'required',
<<<<<<< HEAD
            'stage_id' => 'required|exists:stages,id',
            'status' => 'required|in:' . implode(',', $this->status),

=======
            'stage_id' => 'required|exists:stages,id'
>>>>>>> 65474b75a689dd68328775a646690eaab3d27b76
        ];
        $messages = [
            'name.required' => 'Hãy nhập tên kế hoạch khóa học !',
            'name.unique' => 'Tên kế hoạch khóa học đã tồn tại !',
            'content.required' => 'Hãy nhập mô tả cho kế hoạch khóa học !',
            'descreption.required' => 'Hãy nhập mô tả ngắn cho kế hoạch khóa học !',
            'video_link.required' => 'Hãy nhập video cho khóa học !',
            'stage_id.required' => 'Hãy chọn giai đoạn của khóa học  !',
            'stage_id.exists' => 'Giai đoạn của khóa học không tồn tại !',
<<<<<<< HEAD
            'status.required' => 'Hãy chọn trạng thái hoạt động !',
            'status.in' => 'Trạng thái hoạt động không hợp lệ !',
=======
>>>>>>> 65474b75a689dd68328775a646690eaab3d27b76
        ];

        return parent::storeRequestValidate($request, $rules, $messages); // TODO: Change the autogenerated stub
    }


    public function updateRequestValidate(int|string $id, object $request, array $rules = [], array $messages = []): bool|array
    {
        $rules = [
            'name' => "required|unique:course_planes,name,$id",
            'content' => 'required',
            'descreption' => 'required',
            'video_link' => 'required',
<<<<<<< HEAD
            'stage_id' => 'required|exists:stages,id',
            'status' => 'required|in:' . implode(',', $this->status),

=======
            'stage_id' => 'required|exists:stages,id'
>>>>>>> 65474b75a689dd68328775a646690eaab3d27b76
        ];
        $messages = [
            'name.required' => 'Hãy nhập tên kế hoạch khóa học !',
            'name.unique' => 'Tên kế hoạch khóa học đã tồn tại !',
            'content.required' => 'Hãy nhập mô tả cho kế hoạch khóa học !',
            'descreption.required' => 'Hãy nhập mô tả ngắn cho kế hoạch khóa học !',
            'video_link.required' => 'Hãy nhập video cho khóa học !',
            'stage_id.required' => 'Hãy chọn giai đoạn của khóa học  !',
            'stage_id.exists' => 'Giai đoạn của khóa học không tồn tại !',
<<<<<<< HEAD
            'status.required' => 'Hãy chọn trạng thái hoạt động !',
            'status.in' => 'Trạng thái hoạt động không hợp lệ !',
=======
>>>>>>> 65474b75a689dd68328775a646690eaab3d27b76
        ];


        return parent::updateRequestValidate($id, $request, $rules, $messages); // TODO: Change the autogenerated stub
    }

    public function listCoursePlanes($id)
    {
        try {
            $response = CoursePlanes::where('stage_id', $id)->get();
            return $response;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }

    }

<<<<<<< HEAD
    public function add($request): Model
    {
        $disk = Storage::disk('s3');

        $disk->put('aaa/bbb.jpg', file_get_contents($request->file('video_link')));

        dd($disk->allFiles());
        $path = Storage::disk('s3')->put('images/originals', $request->file('video_link'), 'public');
        $request->merge([
            'size' => $request->file->getClientSize(),
            'path' => $path
        ]);
        dd($path);

    }

=======
>>>>>>> 65474b75a689dd68328775a646690eaab3d27b76
}
