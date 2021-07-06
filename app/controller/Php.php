<?php
namespace app\controller;

use app\BaseController;
use think\facade\View;

class Php extends BaseController
{
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
    public function error()
    {
        return View::fetch("/".input("get.name")."/version".input("get.id")."/error");
    }
    public function examination()
    {
        return View::fetch("/".input("get.name")."/version".input("get.id")."/examination");
    }
}
