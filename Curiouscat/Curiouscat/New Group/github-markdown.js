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

// Style 样式修改
/// 常规
document.body.style.background = "%@"; // "#3C3836"
document.body.style.color = "%@"; // #d5c4a1"

/// a 标签
var as = document.getElementsByTagName("a");
for (var i = 0; i < as.length; ++ i) {
    as[i].style.color = "%@"; // #b8bb26
}

/// 修改代码的主体颜色
var pres = document.getElementsByTagName("pre");
for (var i = 0; i < pres.length; ++ i) {
    pres[i].style.color = "black";
}

/// 修改引用的颜色
var blockquotes = document.getElementsByTagName("blockquote")
for (var i = 0; i < blockquotes.length; ++ i) {
    blockquotes[i].style.color = "%@"; // #d5c4a1"
}
