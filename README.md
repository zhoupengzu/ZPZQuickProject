# ZPZQuickProject
快速搭建工程

该项目是个底部为Tabbar的快速项目，整个项目都以模型为主。
已经封装好的有：
1、网络请求。可以按照要求再做处理，比如登录过期需要重新自动登录等
2、带PlaceHolder的ZPZUITextView
3、可以定义文字垂直对齐方式的ZPZUILabel
4、可设置时间和带回调的ZPZToastView，目前只有文字和文字+图片两种样式
5、倒计时按钮ZPZCountTimeButton
6、带时间滚轮的ZPZPickerView和ZPZSinglePickerView，前者的的数据通过block回调获取，只是封装了UI，后者则只关心最后的选中状态即可
7、弹窗ZPZAlertView，可以自定义按钮的排列方式（水平或者垂直），可以定义内容是否带Tip
8、弹窗带输入框的ZPZAlertField，其中输入框的个数由编码人员自己决定，对于键盘事件，已经做了处理
9、带输入框的ZPZCustomField，左中右紧凑型的样式，目前已经实现了几种样式，可以根据需要再进行扩展：
typedef NS_ENUM(NSInteger, ZPZCustomFieldType) {
    ZPZCustomFieldTypeDefault = 10,  // 默认只有编辑框
    ZPZCustomFieldTypeTitle,    // 主标题 + 编辑框
    ZPZCustomFieldTypeTitle_Img,  // 主标题 + 编辑框 + 图片（带手势）
    ZPZCustomFieldTypeTitle_ImgCode = ZPZCustomFieldTypeTitle_Img,  //主标题 + 编辑框 + 图片验证码，和MYCustomFieldTypeTitle_Img相同
    ZPZCustomFieldTypeTitle_Msg,
    ZPZCustomFieldTypeTitle_MsgCode = ZPZCustomFieldTypeTitle_Msg,   // 主标题 + 编辑框 + 手机验证码
    ZPZCustomFieldTypeTitle_MsgCode_Bac, // 主标题 + 编辑框 + 手机验证码(带定制背景)
    
    ZPZCustomFieldTypeField_MsgCode, // 编辑框 + 手机验证码
};
