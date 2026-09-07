@echo off
chcp 65001 >nul
title Eden · 本地私密 AI 聊天室

echo.
echo  ============================================
echo    伊甸园 · 本地私密 AI 聊天室  启动中…
echo  ============================================
echo.

rem 检查 Python 是否安装
where python >nul 2>nul
if errorlevel 1 (
    echo  [错误] 没有检测到 Python。
    echo  请先到这里安装：https://www.python.org/downloads/
    echo  安装时务必勾选 "Add Python to PATH"。
    echo.
    pause
    exit /b 1
)

rem 读取已保存的 API Key（用户级环境变量）
set "KEY="
for /f "tokens=2*" %%a in ('reg query "HKCU\Environment" /v DEEPSEEK_API_KEY 2^>nul') do set "KEY=%%b"
if not defined KEY set "KEY=%DEEPSEEK_API_KEY%"

rem 没有 Key 就询问一次并保存
if not defined KEY (
    echo 第一次使用：请先申请 DeepSeek API Key
    echo 申请地址：https://platform.deepseek.com/  （注册后左侧 API Keys 创建）
    echo.
    set /p KEY=请把 Key 粘贴到这里后按回车：
    if not defined KEY (
        echo.
        echo  [提示] 未输入 Key，本次启动可能无法对话。
        echo  之后可双击本文件重新设置。
    ) else (
        setx DEEPSEEK_API_KEY "%KEY%" >nul
        echo 已保存到本机，下次启动无需再输入。
    )
)
set "DEEPSEEK_API_KEY=%KEY%"

echo.
echo 正在启动，浏览器会自动打开 http://localhost:8501
echo （请保持本窗口开启；关闭窗口即停止服务）
echo.
start "" http://localhost:8501
python -m streamlit run eden_chat.py
pause
