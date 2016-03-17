Discourse 中文本地化服务集合
===================

Adding various support to login methods and share links. More incoming.

<strong>将随 Discourse 1.5 正式版取代原来的相关的插件，Discourse 1.6 版本发布时原先的几个相关插件将被删除。测试中</strong>

这是一个 Discourse 中文本地化插件的集合，一些特性适合增加到 [Discourse 的核心代码库][dsg]中，而这个插件专注于不适用于 Discourse 核心的功能。

- 包含各国内服务的第三方登录（OAuth）功能。
- 添加分享到国内的服务的支持。

更多技术支持或者意见问题，可以参考[中文论坛的帮助贴][dsch]。

## 功能概况

登录方法：

- 微博
- 人人
- 豆瓣
- QQ

分享链接：

（有部分服务的显示尚未有更好的解决办法）

- 微博（weibo）
- 人人（renren）
- 腾讯微博（tencent_weibo）
- 豆瓣（douban）：需要图标
- 微信（wechat）：第三方服务，需要替代品
- QQ 空间（qzone）：需要图标

## 安装

在 `app.yml` 的

    hooks:
      after_code:
        - exec:
            cd: $home/plugins
            cmd:
              - mkdir -p plugins
              - git clone https://github.com/discourse/docker_manager.git

最后一行 `- git clone https://github.com/discourse/docker_manager.git` 后添加：

    - git clone https://github.com/fantasticfears/discourse-chinese-localization-pack.git

## 使用

进入站点设置的插件设置项里按照提示设置，或按照[中文论坛的帮助贴][dsch]。

另外在 `share_links` 设置项中输入对应的名字（括号内）添加分享服务。

## 许可协议

GPLv2

## 贡献

欢迎你参与这样本地化服务插件的开发，

- 前往[中文论坛][discn]讨论任何可能的想法，尽可能地列举出具体的做法或详情。
- 提交 Pull Request。
- 修缮相关的翻译。

## 发行注记

| 版本 |     时间    |       内容       |             迁移说明             |
| --- | ---------- | --------------- | ------------------------------ |
| 0.5 | 2016-03-16 | 将各个插件聚合而来 | [#迁移至 0.5 版本](#迁移至-05-版本) |

### 迁移至 0.5 版本

1. 从已有的设置项中抄录相关登录插件的 client id 和 secret。
2. 将原有插件从 `app.yml` 中删除并安装该插件。
3. 重新配置插件的各个项目以生效。

至此，迁移就完成了，所有原来保存的登录数据都不会受到影响。

## TODO

合并微信插件 https://github.com/mooosu/wechat_qrconnect

[discn]: https://meta.discoursecn.org/
[dsg]: https://github.com/discourse/discourse
[dsch]: https://meta.discoursecn.org/t/Discourse-%E4%B8%AD%E6%96%87%E6%9C%AC%E5%9C%B0%E5%8C%96%E6%9C%8D%E5%8A%A1%E9%9B%86%E5%90%88/1012
