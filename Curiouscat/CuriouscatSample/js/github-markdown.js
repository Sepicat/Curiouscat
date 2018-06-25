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
document.body.style.background = "#3C3836"
document.body.style.color = "#d5c4a1"
