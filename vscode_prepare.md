# this is simple preparation for vs code
## step 1
install mingw

## step 2
install vs code

## step 3
gedit the following file

### task.json

```json
{
    "tasks": [
        {
            "type": "shell",
            "label": "compile",
            "command": "g++.exe",
            "args": [
                "-g",
                "${file}",
                "-o",
                "${fileDirname}\\${fileBasenameNoExtension}.exe"
            ],
            "options": {
                "cwd": "${workspaceFolder}"
            },
            "problemMatcher": [
                "$gcc"
            ],
            "group": {
                "kind": "build",
                "isDefault": true
            }
        }
    ],
    "version": "2.0.0"
}
```



### launch.json

```json
{
    // 使用 IntelliSense 了解相关属性。 
    // 悬停以查看现有属性的描述。
    // 欲了解更多信息，请访问: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "g++.exe - 生成和调试活动文件",
            "type": "cppdbg",
            "request": "launch",
            "program": "${fileDirname}\\${fileBasenameNoExtension}.exe",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${workspaceFolder}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "miDebuggerPath": "gdb.exe",
            "setupCommands": [
                {
                    "description": "为 gdb 启用整齐打印",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ],
            "preLaunchTask": "compile"
        }
    ]
}
```



### c_cpp_properties.json

```json
{
    "configurations": [
        {
            "name": "Win32",
            "includePath": [
                "${workspaceFolder}/**"
            ],
            "defines": [
                "_DEBUG",
                "UNICODE",
                "_UNICODE"
            ],
            "cStandard": "c11",
            "compilerPath": "D:\\LLVM\\bin\\g++.exe",
            "intelliSenseMode": "gcc-x64"
            
        }
    ],
    "version": 4
}
```

> Notice: you should add you compiler's path in your system path.
>
> If you use "mingw", you can choose the intelliSenseMode "gcc-x64".
>
> If you use "mingw" and put it into the clang, you can choose the intelliSenseMode "clang-x64" and you should install the visual studio before because of the miss of the header file.