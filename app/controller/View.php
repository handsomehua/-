<?php
namespace app\controller;

use app\BaseController;

class View extends BaseController
{
    public static function fdImg($arr)
    {
        return "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style=\"position:relative;top:3.5px; \"><img onclick=\"fyImg('{$arr[0]}')\" style=\"vertical-align:top;\" src=\"/static/images/tp.png\" width=\"22px\" height=\"17px;\" /></span>";
    }

    public static function nbsp($arr)
    {
        return str_repeat("&nbsp;", $arr[0]);
    }
}
