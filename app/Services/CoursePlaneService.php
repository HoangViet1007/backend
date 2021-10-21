<?php

namespace App\Services;

use App\Constants\StatusConstant;
use App\Models\CoursePlanes;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Aws\S3\S3Client;
use Aws\Exception\AwsException;
use App\Services\BaseService;
use App\Models\Stage;

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
            'video_link' => 'required|file|mimes:mp4|max:1048576',
            'stage_id' => 'required|exists:stages,id',
            'status' => 'required|in:' . implode(',', $this->status),


        ];
        $messages = [
            'name.required' => 'Hãy nhập tên kế hoạch khóa học !',
            'name.unique' => 'Tên kế hoạch khóa học đã tồn tại !',
            'content.required' => 'Hãy nhập mô tả cho kế hoạch khóa học !',
            'descreption.required' => 'Hãy nhập mô tả ngắn cho kế hoạch khóa học !',
            'video_link.required' => 'Hãy nhập video cho khóa học !',
            'video_link.file' => 'Hãy nhập video phải là một tệp được tải lên thành công. !',
            'video_link.mimes' => 'Xin mời bạn nhập video !',
            'video_link.max' => 'Video nhập quá dung lượng !',
            'stage_id.required' => 'Hãy chọn giai đoạn của khóa học  !',
            'stage_id.exists' => 'Giai đoạn của khóa học không tồn tại !',
            'status.required' => 'Hãy chọn trạng thái hoạt động !',
            'status.in' => 'Trạng thái hoạt động không hợp lệ !',

        ];

        return parent::storeRequestValidate($request, $rules, $messages); // TODO: Change the autogenerated stub
    }


    public function updateRequestValidate(int|string $id, object $request, array $rules = [], array $messages = []): bool|array
    {
        $rules = [
            'name' => "required|unique:course_planes,name,$id",
            'content' => 'required',
            'descreption' => 'required',
            'video_link' => 'required|file|mimes:mp4|max:1048576',
            'stage_id' => 'required|exists:stages,id',
            'status' => 'required|in:' . implode(',', $this->status),

        ];
        $messages = [
            'name.required' => 'Hãy nhập tên kế hoạch khóa học !',
            'name.unique' => 'Tên kế hoạch khóa học đã tồn tại !',
            'content.required' => 'Hãy nhập mô tả cho kế hoạch khóa học !',
            'descreption.required' => 'Hãy nhập mô tả ngắn cho kế hoạch khóa học !',
            'video_link.required' => 'Hãy nhập video cho khóa học !',
            'video_link.file' => 'Hãy nhập video phải là một tệp được tải lên thành công. !',
            'video_link.mimes' => 'Xin mời bạn nhập video !',
            'video_link.max' => 'Video nhập quá dung lượng !',
            'stage_id.required' => 'Hãy chọn giai đoạn của khóa học  !',
            'stage_id.exists' => 'Giai đoạn của khóa học không tồn tại !',
            'status.required' => 'Hãy chọn trạng thái hoạt động !',
            'status.in' => 'Trạng thái hoạt động không hợp lệ !',

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


    public function preAdd(object $request)
    {
        $url = '';
        if (!empty($request->file('video_link'))) {
            $path = Storage::disk('s3')->put('images/originals', $request->file('video_link'), 'public');
            $url = env('S3_URL') . $path;

        }
        $request->video_link = $url;
        parent::preAdd($request);
    }

    public function preUpdate($id, $request)
    {
        $item = $this->get($id);

        $url = '';
        if ($item) {
            $result = str_replace(env('S3_URL'), '', $item->video_link);
            Storage::disk('s3')->delete($result);
            if (!empty($request->file('video_link'))) {
                $path = Storage::disk('s3')->put('images/originals', $request->file('video_link'), 'public');
                $url = env('S3_URL') . $path;
            }
            $request->video_link = $url;
            parent::preUpdate($id, $request);

        }else{
            parent::preUpdate($id, $request);

        }


    }


    public function preDelete($id)
    {
        $item = $this->get($id);
        if ($item) {
            $result = str_replace(env('S3_URL'), '', $item->video_link);
            Storage::disk('s3')->delete($result);
            parent::preDelete($id);

        }
        parent::preDelete($id);


    }
}
