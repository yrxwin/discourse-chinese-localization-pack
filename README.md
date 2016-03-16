discourse-chinese-localization-pack
===================

Adding various support to login methods and share links. More incoming.

<strong>将随 Discourse 1.5 正式版取代原来的相关的插件。测试中</strong>

- 该插件包含各国内服务的第三方登录（OAuth）功能。
- 为 Discourse 添加分享到国内的服务的支持。微博和人人的支持。

## 添加功能概况

登录方法：

- 微博
- 人人
- 豆瓣
- QQ

分享链接：

有部分服务的显示尚未有更好的解决办法。

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

Go to Site Settings's basic category, add services in the share_links.

进入站点设置的基本设置分类，在share_links中添加服务。

## 许可协议

GPLv2

<div style="display: none">

<strong>将随 Discourse 1.5 正式版被[集合插件](https://github.com/fantasticfears/discourse-chinese-localization-pack) 取代。Discourse 1.6 正式版后该插件会被删除。</strong>

###微博

# Weibo login plugin for Discourse / Discourse 微博登录插件

<strong>将随 Discourse 1.5 正式版被[集合插件](https://github.com/fantasticfears/discourse-chinese-localization-pack) 取代。Discourse 1.6 正式版后该插件会被删除。</strong>

Authenticate with discourse with Weibo.

通过微博登录 Discourse。

## Register Client Key & Secert / 申请微博接入

1. 登录[微博开发者中心](http://open.weibo.com/connect?bottomnav=1&wvr=5)，注册填写相关信息。
2. 点击`开始接入`。
3. 填写相关信息。`网站域名`可填写根域名或者具体域名。如图所示。（验证所需要的标签可在 Discourse 设置中插入，验证后即可删除；访问 Discourse 管理面板 - 内容 - 页面顶部）
4. 在申请到的后台找到`网站信息`的`基本信息`一栏，获得`key`和`secret`，将其填入Discourse 设置中。

<img src="https://meta.discourse.org/uploads/default/34524/32ac2f59e766ca9f.png" width="527" height="500">

## Installation / 安装

在 `app.yml` 的

    hooks:
      after_code:
        - exec:
            cd: $home/plugins
            cmd:
              - mkdir -p plugins
              - git clone https://github.com/discourse/docker_manager.git

最后一行 `- git clone https://github.com/discourse/docker_manager.git` 后添加：

    - git clone https://github.com/fantasticfears/weibo-login.git

## Usage / 使用

Go to Site Settings's login category, fill in the client id and client secret.

进入站点设置的登录分类，填写 client id 和 client serect。

## Issue / 问题

Visit [topic on Discourse Meta](https://meta.discourse.org/t/weibo-login-plugin/19735) or [GitHub Issues](https://github.com/fantasticfears/weibo-login/issues).

访问[中文论坛的主题](https://meta.discoursecn.org/t/topic/43)或[GitHub Issues](https://github.com/fantasticfears/weibo-login/issues)。

## Changelog

Current version: 0.4.1

0.3.0: 修正没有正确保存 uid 的 bug。
0.4.0: 包含登录策略 gem，去掉下载外部 gem 的步骤。
0.4.1: 限制保存的内容，解决 CookieOverflow 的问题。

### 人人


Authenticate with discourse with Renren.

通过人人登录 Discourse。

## Register Client Key & Secert / 申请人人接入

1. 登录[人人开放平台](http://dev.renren.com/website)，注册填写相关信息。
2. 点击`创建应用`。
3. 填写相关信息。`应用根域名`填写根域名。如图所示。
4. 在申请到的后台找到刚申请到的引用，概览中即可以获得`key`和`secret`，将其填入 Discourse 设置中。

<img src="https://meta.discourse.org/uploads/default/34533/ae6314cb61a93301.png" width="458" height="500">

## Installation / 安装

在 `app.yml` 的

    hooks:
      after_code:
        - exec:
            cd: $home/plugins
            cmd:
              - mkdir -p plugins
              - git clone https://github.com/discourse/docker_manager.git

最后一行 `- git clone https://github.com/discourse/docker_manager.git` 后添加：

    - git clone https://github.com/fantasticfears/renren-login.git

## Usage / 使用

Go to Site Settings's login category, fill in the client id and client secret.

进入站点设置的登录分类，填写 client id 和 client serect。

## Issue / 问题

Visit [topic on Discourse Meta](https://meta.discourse.org/t/renren-login-plugin/19747) or [GitHub Issues](https://github.com/fantasticfears/renren-login/issues).

访问[中文论坛上的主题](https://meta.discoursecn.org/t/topic/45)或[GitHub Issues](https://github.com/fantasticfears/renren-login/issues)。

<img src="https://meta.discourse.org/uploads/default/34534/d837a2a1ef1fcbf3.png" width="690" height="325">

<img src="https://meta.discourse.org/uploads/default/34535/f9d71a6af7263265.png" width="690" height="307">

<img src="https://meta.discourse.org/uploads/default/34536/06c11f5f149450b4.png" width="690" height="326">

<img src="https://meta.discourse.org/uploads/default/34537/2cb707f91db50241.png" width="690" height="312">

## Changelog

Current version: 0.4.0

0.3.0: 修正没有正确保存 uid 的 bug。
0.4.0: 包含登录策略 gem，去掉下载外部 gem 的步骤。

### QQ

# QQ connect plugin for Discourse / Discourse QQ 互联插件

Authenticate with discourse with qq connect.

通过 QQ 互联登陆 Discourse。

## Register Client Key & Secert / 申请 QQ 接入

1. 登录 [QQ Connect](http://connect.qq.com/)，注册填写相关信息。
2. 进入`管理中心`，点击`创建应用`，选择`网站`。
3. 填写相关信息。`网站地址`应填写论坛所处的位置。`回调地址`应填写根域名位置。如图所示。（验证所需要的标签可在 Discourse 设置中插入，验证后即可删除；访问 Discourse 管理面板 - 内容 - 页面顶部）
4. 找到刚申请到的应用，在左上角找到`id`和`key`，分别填入 Discourse 设置中的 `client_key` 和 `client_secret`。

<img src="https://meta.discourse.org/uploads/default/34523/414f622b202bba06.png" width="583" height="500">

## Installation / 安装

在 `app.yml` 的

    hooks:
      after_code:
        - exec:
            cd: $home/plugins
            cmd:
              - mkdir -p plugins
              - git clone https://github.com/discourse/docker_manager.git

最后一行 `- git clone https://github.com/discourse/docker_manager.git` 后添加：

    - git clone https://github.com/fantasticfears/qq_connect.git

## Usage / 使用

Go to Site Settings's login category, fill in the client id and client secret.

进入站点设置的登录分类，填写 client id 和 client serect。

## Issues / 问题

Visit [topic on Discourse Meta](https://meta.discourse.org/t/qq-login-plugin-qq/19718) or [GitHub Issues](https://github.com/fantasticfears/qq_connect/issues).

访问[中文论坛上的主题](https://meta.discoursecn.org/t/qq/42)或[GitHub Issues](https://github.com/fantasticfears/qq_connect/issues)。

## Changelog

Current version: 0.4.0

0.3.0: 修正没有正确保存 uid 的 bug。
0.4.0: 包含登录策略 gem，去掉下载外部 gem 的步骤。

<img src="https://meta.discourse.org/uploads/default/34493/dc792b8ba0ca145a.png" width="690" height="386">

<img src="https://meta.discourse.org/uploads/default/34492/62b8bfde277857af.png" width="690" height="312">

<img src="https://meta.discourse.org/uploads/default/34494/ea6c21600bd68279.png" width="690" height="330">

<img src="https://meta.discourse.org/uploads/default/34495/eaf2d4fae5f6a64c.png" width="690" height="313">

### 豆瓣

# Douban login plugin for Discourse / Discourse 豆瓣登录插件

Authenticate with discourse with Douban.

通过豆瓣登录 Discourse。

## Register Client Key & Secert / 申请豆瓣接入

1. 登录[豆瓣开发者中心](http://developers.douban.com/)，注册填写相关信息。
2. 点击`我的应用`，再点击`创建新应用`。
3. 填写相关信息。`网站域名`可填写根域名或者具体域名。如图所示。（验证所需要的标签可在 Discourse 设置中插入，验证后即可删除；访问 Discourse 管理面板 - 内容 - 页面顶部）回调地址：
  - https 填写：`http://meta.discoursecn.org:443/auth/douban/callback`
  - http 填写：`http://meta.discoursecn.org/auth/douban/callback`
4. 在申请到的后台找到刚申请到的引用，概览中即可以获得`key`和`secret`，将其填入Discourse 设置中。

<img src="https://meta.discourse.org/uploads/default/34525/3041f41ffcde20de.png" width="690" height="463">

## Installation / 安装

在 `app.yml` 的

    hooks:
      after_code:
        - exec:
            cd: $home/plugins
            cmd:
              - mkdir -p plugins
              - git clone https://github.com/discourse/docker_manager.git

最后一行 `- git clone https://github.com/discourse/docker_manager.git` 后添加：

    - git clone https://github.com/fantasticfears/douban-login.git

## Usage / 使用

Go to Site Settings's login category, fill in the client id and client secret.

进入站点设置的登录分类，填写 client id 和 client serect。

## Issue / 问题

Visit [topic on Discourse Meta](https://meta.discourse.org/t/douban-login-plugin/19736) or [GitHub Issues](https://github.com/fantasticfears/douban-login/issues).

访问[中文论坛的主题](https://meta.discoursecn.org/t/topic/44)或[GitHub Issues](https://github.com/fantasticfears/douban-login)。

<img src="https://meta.discourse.org/uploads/default/34526/05ece4662bfe0350.png" width="632" height="500">

<img src="https://meta.discourse.org/uploads/default/34527/fb76e5c6a0e65f66.png" width="690" height="316">

<img src="https://meta.discourse.org/uploads/default/34529/2b2e8e58609dc18f.png" width="690" height="482">

## Changelog

Current version: 0.4.0

0.3.0: 修正没有正确保存 uid 的 bug。
0.4.0: 包含登录策略 gem，去掉下载外部 gem 的步骤。

</div>
