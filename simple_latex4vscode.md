# this is a simple preparation for latex of vs code
## setting.json
```json
{
    "latex-workshop.latex.tools": [
        {
            // 编译工具和命令
            "name": "xelatex",
            "command": "xelatex",
            "args": [
                "%DOCFILE%"
            ]
        }
    ],
    "latex-workshop.latex.recipes": [
        {
            "name": "xelatex",
            "tools": [
                "xelatex"
            ]
        },
        {
            "name": "xe->xe",
            "tools": [
                "xelatex",
                "xelatex"
            ]
        }   
    ], 
    "editor.fontSize": 25,
    "latex-workshop.view.pdf.hand": true, 
    "latex-workshop.view.pdf.viewer": "tab",
    "latex-workshop.synctex.afterBuild.enabled": true, 
}
```