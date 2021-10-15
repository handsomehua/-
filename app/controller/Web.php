<?php
namespace app\controller;

use app\BaseController;
use think\facade\View;

class Web extends BaseController
{
    public function web()
    {
        return View::fetch("/web/version".input("get.id")."/web");
    }
    public function version()
    {
        return View::fetch("/web/version".input("get.id")."/vscode".input("get.vscode")."/vscode");
    }
    public function vscode()
    {
        return View::fetch("/web/version".input("get.id")."/vscode".input("get.vscode")."/".input("get.vid"));
    }
    public function fast()
    {
        View::assign("status", input('get.status', 0));
        return View::fetch("/common/notes/".input('get.path'));
    }
}
