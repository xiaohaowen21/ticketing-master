# 火车站售票系统

这是一个基于 Java Web 的课程实验项目，使用 JSP + Servlet + JDBC + MySQL 实现了简单的火车票查询、会员登录注册、订票和后台管理功能。

项目已经在本机完成运行验证，适合用作 Java Web 课程作业、实验展示和 IDEA 导入练习。

## 项目简介

本项目采用传统的 Java Web 开发方式，不依赖 Spring 全家桶，代码结构比较直观，适合初学者学习 Servlet、JSP、JDBC 和 MVC 分层思想。

系统分为两个部分：

- 会员端：注册、登录、车次查询、订票、个人中心、乘车人管理
- 管理端：管理员登录、车次管理、会员管理、订单管理、统计查看

## 技术栈

- Java 8
- Servlet 4.0
- JSP / JSTL
- JDBC
- Apache Commons DbUtils
- C3P0 / Druid
- MySQL 5.7 / 8.0
- Maven
- Tomcat 9
- HTML + CSS + JavaScript + jQuery

## 功能说明

### 会员端

- 会员注册
- 会员登录
- 按出发站、终点站、日期查询车次
- 在线订票
- 查看个人信息
- 乘车人信息维护
- 查看我的订单

### 管理端

- 管理员登录
- 车次信息增删改查
- 会员信息管理
- 订单信息管理
- 销售统计
- 数据导出

## 运行环境

- JDK 1.8
- IntelliJ IDEA
- Maven 3.9+
- Tomcat 9
- MySQL 5.7 或 8.0

## 快速开始

### 1. 创建数据库

先在 MySQL 中创建数据库：

```sql
CREATE DATABASE ticketing CHARACTER SET utf8;
```

### 2. 导入数据库脚本

执行仓库中的初始化脚本：

```sql
source sql/ticketing.sql;
```

这个脚本已经包含表结构和一份可直接演示的测试数据。

### 3. 配置数据库连接

公开仓库中不提交本地真实数据库配置，请先复制下面这个文件：

```text
src/main/resources/jdbc.properties.example
```

复制为：

```text
src/main/resources/jdbc.properties
```

然后按自己的 MySQL 环境修改用户名和密码。

示例配置如下：

```properties
jdbc.driver=com.mysql.jdbc.Driver
jdbc.url=jdbc:mysql://localhost:3306/ticketing?useSSL=false&serverTimezone=Asia/Shanghai&characterEncoding=utf8&allowPublicKeyRetrieval=true
jdbc.user=root
jdbc.password=你的数据库密码
```

### 4. 用 IDEA 导入项目

1. 使用 IDEA 打开项目根目录
2. 等待 Maven 依赖自动加载
3. 确认 Project SDK 为 JDK 1.8
4. 配置 Tomcat Local
5. 在 Deployment 中添加 `ticketing:war exploded`
6. Application context 设置为 `/ticketing`

### 5. 启动项目

Tomcat 启动后即可访问系统。

本文档按本机已经验证通过的端口演示：

- 首页：`http://127.0.0.1:8585/ticketing/`
- 会员登录页：`http://127.0.0.1:8585/ticketing/pages/user/memberLogin.jsp`

如果你的 Tomcat 不是 `8585`，把地址中的端口改成你自己的即可。

## 默认测试数据

导入 `sql/ticketing.sql` 后可直接使用下面的测试账号：

- 管理员账号：`admin`
- 管理员密码：`123456`
- 会员账号：`Test1`
- 会员密码：`123456`

数据库中还准备了两条测试车次：

- `G1236`：南京南 -> 上海虹桥
- `D2541`：西安北 -> 成都东

## 项目结构

```text
ticketing-master
├─ sql
│  └─ ticketing.sql
├─ src
│  ├─ main
│  │  ├─ java/com/cn
│  │  │  ├─ dao
│  │  │  ├─ domain
│  │  │  ├─ filter
│  │  │  ├─ listener
│  │  │  ├─ service
│  │  │  ├─ servlet
│  │  │  └─ util
│  │  ├─ resources
│  │  └─ webapp
│  └─ test
└─ pom.xml
```

## 目录说明

- `dao`：数据访问层
- `service`：业务逻辑层
- `servlet`：控制层
- `domain`：实体类
- `filter`：过滤器
- `listener`：监听器
- `sql`：数据库脚本

## 已验证的本地运行环境

为了方便复现，这里记录一下本机测试通过的配置：

- MySQL：`localhost:3306`
- 数据库名：`ticketing`
- Tomcat 端口：`8585`
- 部署路径：`/ticketing`

## 常见问题

### 1. IDEA 导入后提示选择 Eclipse 项目或 Maven 项目

这是因为目录里可能残留旧的 IDE 配置文件。当前仓库已经通过 `.gitignore` 排除了 Eclipse 和 IDEA 的本地配置，公开仓库默认按 Maven 项目导入即可。

### 2. 启动后首页打不开

先检查下面几项：

- MySQL 是否已经启动
- 数据库 `ticketing` 是否已导入
- `jdbc.properties` 是否已经正确配置
- Tomcat 的 Application context 是否为 `/ticketing`

### 3. 登录失败

请确认是否已经导入 `sql/ticketing.sql`，并使用 README 中提供的测试账号登录。

## 说明

这是一个课程实验风格的 Java Web 项目，代码整体保留了传统 JSP/Servlet 的写法，适合作为学习和练手项目使用。

## 安全配置说明

- 支付宝密钥不再写在源码中。启用支付前请设置环境变量 `ALIPAY_APP_ID`、`ALIPAY_APP_PRIVATE_KEY`、`ALIPAY_PUBLIC_KEY`（或用 `-D` 传入同名 JVM 参数）。旧密钥仍留在 Git 历史里，如果它是你自己的应用，请到支付宝开放平台重新生成。
- 后台页面 `/pages/admin/*` 和后台 Servlet 由 `AdminAuthFilter` 保护，未以管理员登录会跳回登录页。
- 依赖统一由 Maven 管理，`WEB-INF/lib` 只保留无法从中央仓库获取的支付宝 SDK。
- 待办：数据库中的密码仍是明文，示例数据自带 `admin / 123456`。上线前请改密码，并把 `password` 字段扩到 60 位以上后改用 BCrypt。
