<?php
namespace app\controller;

use app\BaseController;
use think\facade\View;

class WidGets extends BaseController
{
    public static function www()
    {
        $arr = [
        [
            // "http://99cc.vip/public/tools/vscode_snippet/index.html", //vscode转义
            "http://localhost:89/",
            "/static/images/vscode.png",
            "33",
            "none"
        ],
        [
            "https://github.com/", //github
            "/static/images/github.png",
            "35",
            "none"
        ],
        [
            "http://www.baidu.com", //百度
            "/static/images/baidu.png",
            "26",
            "none"
        ],
        [
            "https://hao.360.com/", //360
            "/static/images/notes/360°.png",
            "26",
            "none"
        ],
        [
            "http://www.topgoer.com/", //go中文文档
            "/static/images/go.png",
            "45",
            "none"
        ],
        [
            "https://studygolang.com/", //go社区
            "/static/images/gosq1.png",
            "35",
            "none"
        ],
        [
            "http://47.112.230.42:8888/001cdf74", //宝塔
            "/static/images/bt.png",
            "35",
            "none"
        ],
        [
            "https://guanfang.ke.qq.com/#tab=1&category=-1", //腾讯课堂
            "/static/images/xwm1.png",
            "35",
            "none"
        ],
        [
            "https://bazhan.me/", //网易云课堂
            "/static/images/zzx.png",
            "35",
            "none"
        ],
    
        [
            "https://www.iconfont.cn/?spm=a313x.7781069.1998910419.d4d0a486a", //阿里云图库
            "/static/images/wxr.png",
            "35",
            "none"
        ],
        [
            "https://www.aliyun.com/activity/618/2021?utm_content=se_1009541079", //阿里云服务器
            "/static/images/阿里云 (3).png",
            "28",
            "none"
        ],
        [
            "https://www.aliyun.com/activity/618/2021?utm_content=se_1009541079", //阿里云服务器
            "/static/images/favicon.ico",
            "19",
            "none"
        ],
        [
            "https://translate.google.cn/", //谷歌翻译
            "/static/images/翻译.png",
            "25",
            "none"
        ],
        ];
        $str = '';
        foreach ($arr as  $k=>$v) {
            $str .= "<a href='{$arr[$k][0]}' target='_blank'><img src=\"{$arr[$k][1]}\" width=\"{$arr[$k][2]}px\"class=\"img_show\" style=\"display:{$arr[$k][3]}\"></a>";
        }
        return $str;
    }



    public static function wwwLeft()
    {
        $arr = [
            [
                "https://tool.lu/timestamp", //时间戳转换
                "/static/images/sjcz.png",
                "28",
                "none",
                "wwwLeft"
            ],
            [
                "https://site.ip138.com/8848.com/", //ip
                "/static/images/ip.png",
                "28",
                "none",
                "wwwLeft"
            ],
            [
                "http://destiny001.gitee.io/color/", //颜色
                "/static/images/颜色.png",
                "25",
                "none",
                "wwwLeft"
            ],
            [
                "https://code.z01.com/v4/docs/index.html", //bootstrap
                "/static/images/Bootstrap (1).png",
                "26",
                "none",
                "wwwLeft"
            ],
            [
                "https://www.layui.com/", //layui
                "/static/images/飞机.png",
                "27",
                "none",
                "www-txsp"
            ],
            [
                "https://layer.layui.com/", //layer
                "/static/images/layer.png",
                "27",
                "none",
                "www-txsp"
            ],
            [
                "https://www.kettle.net.cn/animate/index.html", //animate
                "/static/images/特效.png",
                "27",
                "none",
                "www-txsp"
            ],
            [
                "https://study.163.com/", //网易云
                "/static/images/网易云课堂 (1).png",
                "26",
                "none",
                "www-txsp"
            ],
            [
                "https://www.imooc.com/?utm_term=%E6%85%95%E8%AF%BE%E7%BD%91&utm_campaign=SEM&utm_source=bdpinpai&bd_vid=9697697695921771572", //慕课网
                "/static/images/慕课网 (1).png",
                "30",
                "none",
                "www-txsp"
            ],
            [
                "https://study.163.com/course/courseLearn.htm?courseId=1210123803#/learn/video?lessonId=1281883081&courseId=1210123803", //网易云
                "/static/images/武 (1).png",
                "26",
                "none",
                "www-txsp"
            ],
            [
                "https://www.bilibili.com/video/BV1ME411Y71o?p=172&spm_id_from=pageDriver", //韩
                "/static/images/韩.png",
                "26",
                "none",
                "www-txsp"
            ],
            ];
        
        
        $str = '';
        foreach ($arr as  $k=>$v) {
            $str .= "<a href='{$arr[$k][0]}' target='_blank'><img src=\"{$arr[$k][1]}\" width=\"{$arr[$k][2]}px\"class=\"www-left {$arr[$k][4]}\" style=\"display:{$arr[$k][3]};\"></a>";
        }
        return $str;
    }

    //淘宝京东
    public static function wwwRight()
    {
        $arr = [
            [
                "http://www.szwyxx.com/cmp/135-2-160.html", //斗罗大陆
                "/static/images/dldl.png",
                "28",
                "none",
                "wwwRight"
            ],
            [
                "https://www.jd.com/?cu=true&utm_source=baidu-pinzhuan&utm_medium=cpc&utm_campaign=t_288551095_baidupinzhuan&utm_term=0f3d30c8dba7459bb52f2eb5eba8ac7d_0_bd8e5b1286f74ca58a6db38dc825f5da", //京东
                "/static/images/jd.png",
                "28",
                "none",
                "wwwRight"
            ],
            [
                "https://www.taobao.com/", //淘宝
                "/static/images/tb.png",
                "22",
                "none",
                "wwwRight"
            ],
            [
                "https://v.qq.com/", //腾讯视频
                "/static/images/txsp2.png",
                "30",
                "none",
                "www-txsp"
            ],
            ];
        $str = '';
        foreach ($arr as  $k=>$v) {
            $str .= "<a href='{$arr[$k][0]}' target='_blank'><img src=\"{$arr[$k][1]}\" width=\"{$arr[$k][2]}px\"class=\"www-right {$arr[$k][4]}\" style=\"display:{$arr[$k][3]};float: right;\"></a>";
        }
        return $str;
    }
    //笔记栏
    public static function bjRight()
    {
        $arr = [
            [
                "fast?path=my",
                "/static/images/notes/隐私包装.png",
                "30",
                "none",
                "bjRight bjRight1"
            ],
            [
                "fast?path=hot_key",
                "/static/images/闪电.png",
                "30",
                "none",
                "bjRight bjRight1"
            ],
            [
                "fast?path=password",
                "/static/images/账号 (3).png",
                "26",
                "none",
                "bjRight password"
            ],
            [
                "fast?path=plug_in",
                "/static/images/bj/插件.png",
                "30",
                "none",
                "bjRight bjRight1"
            ],
            [
                "fast?path=browser",
                "/static/images/notes/浏览器.png",
                "33",
                "none",
                "bjRight shit"
            ],
            [
                "fast?path=git",
                "/static/images/notes/ico-git.png",
                "33",
                "none",
                "bjRight shit"
            ],
            [
                "fast?path=golang",
                "/static/images/wwwgo.png",
                "33",
                "none",
                "bjRight shit"
            ],
            [
                "fast?path=music",
                "/static/images/耳机.png",
                "25",
                "none",
                "ycRight bjRight shit"
            ],
            [
                "fast?path=fault",
                "/static/images/故障.png",
                "25",
                "none",
                " bjRight shit"
            ],
            [
                "fast?path=go",
                "/static/images/测试题 (1).png",
                "25",
                "none",
                "ycRight bjRight shit"
            ],
            [
                "fast?path=www",
                "/static/images/notes/搜索 (2).png",
                "25",
                "none",
                "bjRight shit"
            ],
            [
                "fast?path=url",
                "/static/images/URL.png",
                "35",
                "none",
                "bjRight shit"
            ],
            ];
        $str = '';
        foreach ($arr as  $k=>$v) {
            $str .= "<img src=\"{$arr[$k][1]}\" onclick=\"fast('{$arr[$k][0]}')\" width=\"{$arr[$k][2]}px\"class=\"{$arr[$k][4]}\" style=\"display:{$arr[$k][3]};float: right;\">";
        }
        return $str;
    }
    // TODO ：WidGets
}
