# Eden · 本地私密 AI 聊天室

一个运行在**你自己电脑**上的 AI 聊天工具：Streamlit 搭界面，DeepSeek 负责对话。聊天记录和 AI 的"记忆"都只保存在本机，不上传任何服务器。

里面内置一位叫「夏娃」的 AI 角色——她会像真正的陪伴者一样，记住你说过的事，并随着你们的相处慢慢"长大"。你也可以创建其他自定义联系人。

## 功能特性

- 💬 **内置角色「夏娃」**：置顶、名字与人设锁定、记录不可删除
- 🧠 **会成长的记忆**：她记得你教过她的新鲜事（爱好、经历……），之后会自然提起
- ✍️ **自定义联系人**：可新建角色，自定义昵称、人设与头像（同名好友靠头像区分）
- ⚡ **流式回复**：像真人聊天一样逐字输出
- 🔒 **完全本地**：所有会话保存在 `sessions/` 文件夹，仅存于你的电脑

## 环境要求

- **Python 3.10–3.13**（作者在 3.13.14 上测试通过）
- 一个可用的 **DeepSeek API Key**

> 还没装 Python？去官方下载：https://www.python.org/downloads/
> ⚠️ 安装时**务必勾选 "Add Python to PATH"**，否则命令行会提示"找不到 python"。

## 快速开始

### 第 1 步：安装依赖

在项目文件夹里打开终端（Windows 可在文件夹地址栏输入 `cmd` 回车），执行：

```bash
pip install -r requirements.txt
```

> 国内下载太慢，可以加镜像源：
> `pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple`

### 第 2 步：申请 DeepSeek API Key

1. 打开 DeepSeek 开放平台：https://platform.deepseek.com/ 注册并登录；
2. 新账号通常需要先**充值**（在平台账户页操作，金额很小）；
3. 左侧菜单找到 **「API Keys」** → 点击 **「创建 API Key」**；
4. 复制生成的 Key（**只显示一次**，记得立刻保存）；
5. 官方文档参考：https://api-docs.deepseek.com/zh-cn/

### 第 3 步：运行

**方式一（推荐，Windows 小白友好）：** 双击项目里的 **`启动.bat`**
- 第一次运行会提示你粘贴 API Key（只需一次，之后自动记住）；
- 随后自动启动并打开浏览器。

**方式二（手动命令行）：**

PowerShell 设置密钥（每次打开终端都要设一次，或见下方"永久设置"）：

```powershell
$env:DEEPSEEK_API_KEY = "你的DeepSeek_API密钥"
```

启动：

```bash
streamlit run eden_chat.py
```

浏览器打开 http://localhost:8501 即可开始聊天。

**永久设置密钥（可选）**：在 Windows「系统属性 → 高级 → 环境变量」中新建用户变量 `DEEPSEEK_API_KEY`，填你的 Key。

> ⚠️ 不要把真实密钥写进代码或上传到 GitHub。

## 使用说明

- 打开就是「花园」：夏娃永远排在第一位，点她即可开始聊天；
- 点「请一位新的她入园」可以创建自定义联系人：为她取名、写人设、挑头像（同名靠头像区分）；
- 夏娃的名字与人设已锁定，她的聊天记录不可删除——就像现实里删掉聊天记录，也不会抹去对方的记忆；
- 消息实时流式回复；你提到的兴趣、经历会被她记进"心里"，之后她会自然提起。

## 项目结构

```text
eden/
├── eden_chat.py        # 主程序（Streamlit 应用）
├── 启动.bat            # Windows 一键启动脚本
├── requirements.txt    # 依赖清单
├── README.md           # 本说明文件
├── .gitignore
├── resources/
│   └── logo.png        # 应用图标
└── sessions/           # 聊天记录（仅本机使用，不随 Git 上传）
```

## 常见问题（FAQ）

**1. 报错提示 API Key 相关 / 401？**
→ 检查 Key 是否复制完整；到 platform.deepseek.com 确认账号已充值。

**2. 提示 "python 不是内部或外部命令"？**
→ 重装 Python 时勾选 "Add Python to PATH"，然后重新打开终端。

**3. 安装依赖太慢 / 超时？**
→ 使用国内镜像：见上文"第 1 步"里的命令。

**4. 浏览器打不开 http://localhost:8501？**
→ 确认运行窗口没有被关闭；看看终端有没有红色报错。

**5. 想换更新版本的 DeepSeek 模型？**
→ 用记事本打开 `eden_chat.py`，把顶部 `MODEL_NAME = "deepseek-v4-flash"` 改成新模型名即可（只改这一处）。

**6. 想清空聊天记录重来？**
→ 删除 `sessions/` 文件夹里的 `.json` 文件（保留 `.gitkeep`），重新运行即可。

## 数据与隐私

- 所有聊天记录保存在本机 `sessions/`，属私人对话，请自行保管；
- `.gitignore` 已排除 `sessions/*.json`，运行产生的记录不会被提交到仓库；
- 本项目不上传任何数据到 DeepSeek 之外的服务器。

## 欢迎交流

这是一个个人学习与练手的作品，代码一定还有很多可以打磨的地方。**非常欢迎任何指正与建议**——无论是界面、代码结构还是工程实践，提出来我都感激不尽；也**感谢每一位愿意使用它的你**。

有问题欢迎在仓库提 Issue，或在评论区留言交流。
