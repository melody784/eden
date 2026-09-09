@echo off
chcp 65001 >nul
title Eden · 本地私密 AI 聊天室

rem ---- 无论从哪里双击，都先进入脚本所在目录 ----
cd /d "%~dp0"

echo.
echo  ============================================
echo    伊甸园 · 本地私密 AI 聊天室  启动中…
echo  ============================================
echo.

rem ====== 第 1 步：找 Python（优先虚拟环境，没有则询问是否创建）======
set "PYTHON="

if exist ".venv\Scripts\python.exe" set "PYTHON=.venv\Scripts\python.exe"
if exist "venv\Scripts\python.exe"  set "PYTHON=venv\Scripts\python.exe"
if exist "env\Scripts\python.exe"   set "PYTHON=env\Scripts\python.exe"

if defined PYTHON (
    echo 已检测到虚拟环境：%PYTHON%，将使用它启动。
    goto :step2
)

rem ---- 没有虚拟环境：先确认系统 Python 在不在 ----
where python >nul 2>nul
if errorlevel 1 (
    echo.
    echo  [错误] 既没有虚拟环境，也没有系统 Python。
    echo  请先安装 Python：https://www.python.org/downloads/
    echo  安装时务必勾选 "Add Python to PATH"，装完再双击本文件。
    echo.
    pause
    exit /b 1
)

echo.
echo 未检测到虚拟环境。
set /p MAKEVENV=是否现在创建一个？输入 Y 创建 / 输入 N 使用系统 Python ：
if /i "%MAKEVENV%"=="Y" (
    echo 正在创建虚拟环境 .venv …
    python -m venv .venv
    if errorlevel 1 (
        echo.
        echo  [错误] 虚拟环境创建失败，请检查 Python 安装后重试。
        pause
        exit /b 1
    )
    set "PYTHON=.venv\Scripts\python.exe"
    echo 创建完成，将使用 .venv 启动。
) else (
    set "PYTHON=python"
    echo 好的，将使用系统 Python 启动。
)

:step2
rem ====== 第 2 步：检查依赖，缺了就询问是否自动安装 ======
"%PYTHON%" -c "import streamlit" >nul 2>nul
if errorlevel 1 (
    echo.
    echo 当前环境还没有安装运行所需的依赖（streamlit、openai）。
    echo 如果直接启动会报错：ModuleNotFoundError。
    echo.
    set /p INSTALL=是否现在帮你自动安装？输入 Y 安装 / 输入 N 手动安装 ：
    if /i "%INSTALL%"=="Y" (
        echo.
        echo 正在自动安装，请稍候（需要联网）…
        "%PYTHON%" -m pip install -r requirements.txt
        if errorlevel 1 (
            echo.
            echo  [错误] 安装失败。请检查网络后重新双击本文件重试。
            pause
            exit /b 1
        )
        echo 依赖安装完成。
    ) else (
        echo.
        echo 好的。请手动执行下面这行命令安装依赖：
        echo     %PYTHON% -m pip install -r requirements.txt
        echo 安装完成后，再重新双击本文件即可启动。
        echo.
        pause
        exit /b 0
    )
)

rem ====== 第 3 步：读取 / 首次输入 API Key ======
set "KEY="
for /f "tokens=2*" %%a in ('reg query "HKCU\Environment" /v DEEPSEEK_API_KEY 2^>nul') do set "KEY=%%b"
if not defined KEY set "KEY=%DEEPSEEK_API_KEY%"

if not defined KEY (
    echo.
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

rem ====== 第 4 步：启动 ======
echo.
echo 正在启动，浏览器会自动打开 http://localhost:8501
echo （请保持本窗口开启；关闭窗口即停止服务）
echo.
start "" http://localhost:8501
"%PYTHON%" -m streamlit run eden_chat.py

pause
