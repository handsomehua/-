<?php
namespace app\controller;

use app\BaseController;
use think\facade\View;

class Go extends BaseController
{  //go1
    public function go()
    {
        return View::fetch("/go/version".input("get.id")."/go");
    }
    public function version()
    {
        return View::fetch("/go/version".input("get.id")."/vscode".input("get.vscode")."/vscode");
    }
    public function vscode()
    {
        return View::fetch("/go/version".input("get.id")."/vscode".input("get.vscode")."/".input("get.vid"));
    }
    public function public()
    {
        return View::fetch("/".input("get.name")."/version".input("get.id")."/public");
    }
    public function examination()
    {
        return View::fetch("/".input("get.name")."/version".input("get.id")."/examination");
    }
    public function fast()
    {
        View::assign("status", input('get.status', 0));
        return View::fetch("/common/notes/".input('get.path'));
    }
    public function fast_focus()
    {
        return View::fetch("/common/focus/".input('get.path'));
    }
}
