__CreateJSPath = function (js) {
    var scripts = document.getElementsByTagName("script");
    var path = "";
    for (var i = 0, l = scripts.length; i < l; i++) {
        var src = scripts[i].src;
        if (src.indexOf(js) != -1) {
            var ss = src.split(js);
            path = ss[0];
            break;
        }
    }
    var href = location.href;
    href = href.split("#")[0];
    href = href.split("?")[0];
    var ss = href.split("/");
    ss.length = ss.length - 1;
    href = ss.join("/");
    if (path.indexOf("https:") == -1 && path.indexOf("http:") == -1 && path.indexOf("file:") == -1 && path.indexOf("\/") != 0) {
        path = href + "/" + path;
    }
    return path;
}

var bootPATH = __CreateJSPath("boot.js");

//debugger
mini_debugger = true;

//miniui
document.write('<script src="' + bootPATH + 'jquery-1.6.2.min.js" type="text/javascript"></sc' + 'ript>');
document.write('<script src="' + bootPATH + 'miniui/miniui.js" type="text/javascript" ></sc' + 'ript>');
document.write('<link href="' + bootPATH + 'miniui/themes/default/miniui.css" rel="stylesheet" type="text/css" />');
document.write('<link href="' + bootPATH + 'miniui/themes/icons.css" rel="stylesheet" type="text/css" />');
document.write('<link href="' + bootPATH + 'miniui/themes/blue/skin.css" rel="stylesheet" type="text/css" />');

//skin
var skin = getCookie("miniuiSkin");
if (skin) {
    document.write('<link href="' + bootPATH + 'miniui/themes/' + skin + '/skin.css" rel="stylesheet" type="text/css" />');
}



////////////////////////////////////////////////////////////////////////////////////////
function getCookie(sName) {
    var aCookie = document.cookie.split("; ");
    var lastMatch = null;
    for (var i = 0; i < aCookie.length; i++) {
        var aCrumb = aCookie[i].split("=");
        if (sName == aCrumb[0]) {
            lastMatch = aCrumb;
        }
    }
    if (lastMatch) {
        var v = lastMatch[1];
        if (v === undefined) return v;
        return unescape(v);
    }
    return null;
}

//gry
function onSkinChange(skin) {
    //debugger;
    var skinEl = document.getElementById("miniuiSkin");
    if (skinEl) {
        skinEl.parentNode.removeChild(skinEl);
    }
    var url = "../scripts/miniui/themes/" + skin + "/skin.css";
    var nowdate = new Date();
    mini.Cookie.set('miniuiSkin', skin, 100);
    AddCSSLink("miniuiSkin", url);
}
function AddCSSLink(id, url, doc) {
    //debugger;
    doc = doc || document;
    var link = doc.createElement("link");
    link.id = id;
    link.setAttribute("rel", "stylesheet");
    link.setAttribute("type", "text/css");
    link.setAttribute("href", url);

    var heads = doc.getElementsByTagName("head");
    if (heads.length) {
        heads[0].appendChild(link);
    }
    else {
        doc.documentElement.appendChild(link);
    }
}
window.onload = function onLoad() {
    //debugger;
    var skin = mini.Cookie.get("miniuiSkin");
    if (skin) {
        var selectSkin = document.getElementById("selectSkin");
        if (selectSkin != null) {
            selectSkin.value = skin;
        }
        onSkinChange(skin);
    }
}
function onMenuChange(_Menu) {
    mini.Cookie.set('Menu', _Menu, 100);
    mini.alert("设置成功:请注销系统重新登录!");
}
