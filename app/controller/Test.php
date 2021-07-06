<?php
namespace app\controller;

use app\BaseController;
use think\facade\View;

class Test extends BaseController
{
    public function test()
    {
        return View::fetch();
    }
    public function tools()
    {
        return View::fetch('/test/tools/vscode/index');
    }
}
