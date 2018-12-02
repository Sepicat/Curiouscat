var debug = false;

// 删除样式标签
function removeTag(tagName) {
    var tag = document.getElementsByTagName(tagName)[0];
    var tagParent = tag.parentElement;
    tagParent.removeChild(tag);
};

removeTag('header');
removeTag('nav');
removeTag('footer');

// 删除 Title Label
var titleLabel = document.getElementsByClassName("breadcrumb blob-breadcrumb")[0];
var parentTitleLabel = titleLabel.parentElement;
parentTitleLabel.removeChild(titleLabel);

var backgroundColor = "%@";
var textColor = "%@";
var aColor = "%@";
var blockquoteColor = "%@";

// Style 样式修改
/// 常规
if (debug) {
    document.body.style.background = "#3C3836";
    document.body.style.color = "#d5c4a1";
} else {
    document.body.style.background = backgroundColor; // "#3C3836"
    document.body.style.color = textColor; // #d5c4a1"
}

/// a 标签
var as = document.getElementsByTagName("a");
for (var i = 0; i < as.length; ++ i) {
    if (debug) {
        as[i].style.color = "#b8bb26";
    } else {
        as[i].style.color = aColor; // #b8bb26
    }
}

/// 修改代码的主体颜色
var pres = document.getElementsByTagName("pre");
for (var i = 0; i < pres.length; ++ i) {
    pres[i].style.color = "black";
}

/// 修改表格中的主体颜色
var tables = document.getElementsByTagName("table");
for (var i = 0; i < tables.length; ++ i) {
    tables[i].style.color = "black";
}

/// 修改引用的颜色
var blockquotes = document.getElementsByTagName("blockquote")
for (var i = 0; i < blockquotes.length; ++ i) {
    if (debug) {
        blockquotes[i].style.color = "#d5c4a1";
    } else {
        blockquotes[i].style.color = blockquoteColor; // #d5c4a1"
    }
}

/// 修改 h2 下划线
var h2s = document.getElementsByTagName("h2");
for (var i = 0; i < h2s.length; ++ i) {
    if (debug) {
        h2s[i].style.borderBottomColor = backgroundColor;
    } else {
        h2s[i].style.borderBottomColor = "#3C3836";
    }
}

/// 修改 h1 下划线样式
var h1s = document.getElementsByTagName("h1");
for (var i = 0; i < h1s.length; ++ i) {
    if (debug) {
        h1s[i].style.borderBottomColor = backgroundColor;
    } else {
        h1s[i].style.borderBottomColor = "#3C3836";
    }
}

/// 更换字体
var articles = document.getElementsByTagName("article")
for (var i = 0; i < articles.length; ++ i) {
    articles[i].style = "font-family: GurmukhiMN;"
}

/// 切圆角
var imgs = document.getElementsByTagName("img");
for (var i = 0; i < imgs.length; ++ i) {
    imgs[i].style = "border-radius: 6px;";
}

// 对于 bg-white 的处理
tem = document.getElementsByClassName("bg-white")
if (tem.length > 0) {
    tem[0].className = "";
}
