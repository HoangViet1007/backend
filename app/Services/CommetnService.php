<?php

namespace App\Services;

use App\Constants\ActionConstant;
use App\Constants\PermissionConstant;
use App\Constants\StatusConstant;
use App\Exceptions\BadRequestException;
use App\Exceptions\ForbiddenException;
use App\Helpers\QueryHelper;
use App\Models\Comment;
use App\Models\CourseStudent;
use App\Trait\RoleAndPermissionTrait;
use Illuminate\Validation\Rule;
use Exception;

class CommetnService extends BaseService
{
    protected array $status = [StatusConstant::ACTIVE, StatusConstant::INACTIVE];

    use RoleAndPermissionTrait;
    function createModel(): void
    {
        $this->model = new Comment();
    }

    public function storeRequestValidate(object $request, array $rules = [], array $messages = []): bool|array
    {
        $rules = [

            'id_course' => 'required|exists:courses,id',
            'user_id' => 'required|exists:users,id',
            'content' => 'required|max:255',
            'number_stars' => 'bail|required|numeric'
        ];
        $messages = [
            'id_course.required' => 'Hãy chọn khóa học !',
            'id_course.exists' => 'Khóa học này không tồn tại tồn tại !',
            'user_id.required' => 'Xin mời bạn đăng nhấp !',
            'user_id.exists' => 'Người dùng không tồn tại !',
            'content.required' => 'Hãy nhập nội dung cho bình luận !',
            'content.max' => 'Nội dung không được quá 255 ký tự  !',
            'number_stars.required' => 'Hãy đánh giá sao cho khóa học !',
            'number_stars.numeric' => 'Bạn nhập số sao không đúng giá trị !',
        ];

        return parent::storeRequestValidate($request, $rules, $messages); // TODO: Change the autogenerated stub
    }

    public function preAdd(object $request)
    {
        if ($request != "") {
            $check = CourseStudent::where('user_id', $request->user_id)->where('course_id', $request->id_course)->where('status', StatusConstant::COMPLETE)->first();
            if (!$check) {
                throw new BadRequestException(
                    ['message' => __("Bạn không thể đánh giá được khóa học này do bạn chưa học khóa học này !")],
                    new Exception()
                );
            }
        }
    }

    public function listComment()
    {
        if (!$this->hasPermission(PermissionConstant::comment(ActionConstant::LIST)))
            throw new ForbiddenException(__('Access denied'), new Exception());

        $data = $this->queryHelper->buildQuery($this->model)->with('course.teacher','user_comment');
        return $data->paginate(QueryHelper::limit());
    }

    public function changeStatus($request)
    {
        if (!$this->hasPermission(PermissionConstant::comment(ActionConstant::EDITSTATUS)))
            throw new ForbiddenException(__('Access denied'), new Exception());

        $this->doValidate($request,
            [
                'status' => 'in:' . implode(',', $this->status),
            ],
            [
                'status.in' => 'Trạng thái không hợp lệ !',
            ]
        );
        $comment = Comment::find($request->id);
        if ($comment) {
            if ($request['status'] == StatusConstant::ACTIVE) {
                return $comment->update(['status' => StatusConstant::ACTIVE]);
            } else {
                return $comment->update(['status' => StatusConstant::INACTIVE]);
            }

        } else {
            throw new BadRequestException(
                ['message' => __("Không thể thay đổi trạng thái của bình luận !")], new Exception()
            );
        }
    }

}
