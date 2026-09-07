# 本地运行的 AI 聊天工具

这是一个基于 Streamlit 和 DeepSeek API 的本地 AI 聊天应用。应用支持流式回复、可自定义昵称和人设，并会将聊天会话保存到本地。

## 功能

- 使用 DeepSeek API 进行对话
- 流式显示 AI 回复
- 自定义 AI 昵称和人设
- 创建、切换和删除多个本地会话
- 将会话数据保存为 `sessions/` 目录下的 JSON 文件

## 项目结构

```text
python_study/
├── streamlit_ai-chat.py   # Streamlit 应用入口
├── README.md              # 项目说明
├── resources/
│   └── logo.png           # 应用图标
└── sessions/              # 本地聊天会话数据
```

## 环境要求

- 目前只在 Python 3.13.14测试过
- 一个可用的 DeepSeek API 密钥

## 环境配置（两步）

### 第一步：安装依赖

在项目目录中打开终端，分两次执行以下命令：

```bash
pip install streamlit
pip install openai
```

### 第二步：配置 API 密钥

程序从环境变量 `DEEPSEEK_API_KEY` 中读取 API 密钥。根据你使用的终端选择一种方式。

Windows 命令提示符（CMD）中可以临时设置：

```cmd
set DEEPSEEK_API_KEY=你的DeepSeek_API密钥
```

PowerShell 中可以临时设置：

```powershell
$env:DEEPSEEK_API_KEY = "你的DeepSeek_API密钥"
```

如果希望长期保存环境变量，可以在 Windows 的“环境变量”设置中添加 `DEEPSEEK_API_KEY`。

不要把真实 API 密钥直接写入 Python 文件，也不要将密钥提交到 GitHub。

## 运行项目

在项目根目录执行：

```bash
streamlit run streamlit_ai-chat.py
```

启动后，Streamlit 通常会在浏览器中打开本地地址：

```text
http://localhost:8501
```

## 会话数据说明

聊天记录会保存在 `sessions/` 目录中。该目录属于本地运行数据，可能包含私人对话，建议不要上传到 GitHub。

如果 Git 没有跟踪 `sessions/`，这是正常的。应用启动时会自动创建该目录：

```python
os.makedirs("sessions", exist_ok=True)
```

## Git 常用命令

提交并上传代码：

```bash
git add .
git commit -m "更新项目"
git push
```

从 GitHub 获取最新代码：

```bash
git pull
```

## 注意事项

- 请确认 API 密钥已经正确配置，否则应用无法调用模型。
- `sessions/` 中的聊天记录不会自动同步到 GitHub。
- 如果 DeepSeek API 的模型名称发生变化，需要同步修改 `streamlit_ai-chat.py` 中的 `model` 配置。