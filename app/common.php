<?php
use app\controller\WidGets;
use app\controller\View;
// 应用公共文件
if (!function_exists('widget')) {
	function widget($func,$parameter1='')
	{
		$url = 'http://localhost:88/index.php/apiAdminXzj/'.$func.'?parameter1='.$parameter1;
		return file_get_contents($url); 
	}
}

if (!function_exists('widgets')) {
	function widgets($func)
	{
	   return WidGets::$func();
	}
}

if (!function_exists('view')) {
	function admin($func,$arr)
	{
	   return View::$func($arr);
	}
}