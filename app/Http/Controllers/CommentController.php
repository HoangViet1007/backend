<?php

namespace App\Http\Controllers;

use App\Services\CommetnService;
use Illuminate\Http\Request;

class CommentController extends Controller
{
    protected $commentService;

    public function __construct(CommetnService $commetnService)
    {
        $this->commentService = $commetnService;
    }

    public function addComment(Request $request)
    {

        return response()->json($this->commentService->add($request));
    }

    public function listComment()
    {
        return response()->json($this->commentService->listComment());
    }

    public function changeStatus(Request $request){

        return response()->json($this->commentService->changeStatus($request));

    }
}
