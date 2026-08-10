<!--
Copyright 2026 Chen Jiaqi (GitHub: @H15teve)
Distributed under LPPL 1.3c or later; maintenance status: maintained.
Current Maintainer: Chen Jiaqi (GitHub: @H15teve).
This work consists of the files listed in LPPL-MANIFEST.txt.
-->

# 变更记录

本项目遵循语义化版本号。日期采用 `YYYY-MM-DD`。

## v0.6.1 - 2026-08-11

### 新增

- 新增 `fontset=overleaf` 选项，与 `fandol` 使用相同的 TeX Live 自带字体，但跳过字体存在性探测，并拆分 `\csee@set@latin@texgyre@base` 不注册示例未使用的等宽西文字体（`texgyrecursor`），避免 Overleaf 免费版 10 秒编译超时。
- 新增 `fastcompile` 选项，启用时不预加载当前论文骨架未使用的 `setspace`、`multirow`、`tabularx`、`makecell` 和 `siunitx`，需要时仍可由论文主文件按需加载。
- `paper-example.tex` 默认使用 `fontset=overleaf,fastcompile`；Windows 金样仍由 `golden-demo.tex` 的 `fontset=windows` 独立保证。
- README 同步更新：本地 Windows 用户应改为 `fontset=auto` 或 `fontset=windows` 获得金样一致的字体和断行。
- 项目正式名称改为 `CSEE_LaTeX_Template`。

### 修复

- 补齐 `fontset=overleaf` 分支缺失的闭合括号，消除 Overleaf 上的 `File ended while scanning use of \@secondoftwo` 错误及后续 `\csee*` 命令的 `Undefined control sequence` 级联报错。
- 消除 `fandol`/`overleaf` 方案中的重复字体注册：`\songti`/`\heiti`/`\cseesongbold` 改用 `\CJKfamily{\CJKrmdefault}` 复用 `\setCJKmainfont`/`\setCJKsansfont` 已注册的字体族，`\cseetnr` 改用 `\rmfamily` 复用 `\setmainfont`，避免同一 OTF 字体在每轮 XeLaTeX 中被注册 2-3 次。

## v0.6.0 - 2026-08-10

### 排版修正

- 恢复原始 Word 模板在附录与作者简介之间的短分割线，规格为 4 cm 长、0.75 bp 粗，并校准到右栏左边界。
- 金样的无照片简介说明和正式模板的照片作者简介共用同一分割线实现，避免重复绘制。
- 金样“作者简介：”标签恢复为黑体，标签后的说明文字继续使用小五宋体，与原始 Word 的混合字形一致。
- 分割线前留白重新按 Word 校准：英文图 A3 图题底边到分割线约 11.07 pt，不再过度压缩。
- 正式空白模板的作者简介改为两段：首行缩进 2 个中文字符的黑体“作者简介：”标签独占一行，下一行照片旁的作者信息首行同样缩进 2 个中文字符。
- 增加分割线后的视觉留白；正式模板的“作者简介：”标签移入照片右侧，与作者信息组成同一个绕排块，标签与信息各占一行。
- 正式示例的作者信息末尾增加示例邮箱 `author@example.com`。
- 恢复空白模板作者照片下方的姓名占位符 `###`，并为 `\cseebiography` 增加可选的照片下姓名参数。
- 篇首 DOI、文章编号和中图分类号采用实际出版页约 18 pt 的两段固定等距间隔，使中图分类号末尾不再顶住右边界；文章编号示例在 `(2026)` 两侧恢复英文空格。
- 金样按原始 Word 第 4 页缩短作者照片与责任编辑之间的一行间距，以补偿作者简介多出的一行文字。

### 验证

- 自动检查增加作者简介分割线规格与调用路径回归项：40 PASS / 0 FAIL。

## v0.5.2 - 2026-08-10

### 排版修正

- 将金样正文中的局部重点由黑体修正为宋体加粗；仅 Windows 的 SimSun 使用仿粗，macOS 的 Songti SC、Linux 的 Noto Serif CJK SC 与 Fandol 均调用真实粗体字面。
- 恢复正文 1.6 的 IGCT 示例为普通宋体／普通 Times New Roman，不再加粗。
- 金样“参考文献”后的两段格式说明恢复段首 2 个中文字符缩进，与 Word 原模板的横向锚点一致。

### 验证

- 自动检查增加宋体重点、1.6 示例字重和参考文献说明缩进回归项：39 PASS / 0 FAIL。

## v0.5.1 - 2026-08-10

### 排版修正

- 金样篇首教学注释改用宋体并恢复 Word 的 16.2pt 行距、左右锚点和行宽；正式模板的 DOI、文章编号、中图分类号标签仍保持黑体。
- 中文标题行距按 Word 调整为 32.4pt，并分别校准信息块到标题、标题到作者姓名、作者姓名到作者单位的可见字框间距。
- 金样恢复 Word 正文中的局部重点加粗，包括自动编号、正文输入、图表公式、变量单位及图形要求等提示。
- 正式示例的作者简介只标出生年份，年份后不再附加横杠。

### 验证

- 自动检查扩展标题区三组间距、宋体注释、正文重点和出生年份格式回归项：38 PASS / 0 FAIL。
- 长基金块流式排版回归：6 PASS / 0 FAIL。
- 逐页视觉检查：`golden-demo.pdf` 4 页，`paper-example.pdf` 2 页。

## v0.5.0 - 2026-08-10

### 排版修正

- 移除元数据精简为单行后为保持旧标题锚点而加入的额外补偿。
- 中文标题上方间距改按原始 Word 模板中“页眉下方注释块末行”到标题的可见字框距离校准，目标约为 15.20pt。
- `golden-demo.tex` 恢复原始 Word 模板的两行篇首教学注释；真实写作示例仍只保留 DOI、文章编号和中图分类号。
- 正式写作入口的 DOI、文章编号和中图分类号改按实际出版论文的三段式坐标定位，不再用 `\hfill` 将末项推到右页边；篇首信息基线同步下移约 1.3pt。

### 验证

- 自动检查新增注释块内容、标题间距及实际出版页元数据锚点回归项：33 PASS / 0 FAIL。
- 长基金块流式排版回归：6 PASS / 0 FAIL。
- 逐页视觉检查：`golden-demo.pdf` 4 页，`paper-example.pdf` 2 页。

## v0.4.1 - 2026-08-10

### 排版修正

- 修正原 Word 模板首页中英文刊名整体向右偏移的问题；两行刊名改为相对于 A4 纸张水平中心真正居中，右侧页码和页眉双线锚点保持不变。

### 验证

- 自动检查新增首页中英文刊名中心误差项：30 PASS / 0 FAIL。
- 逐页视觉检查：`golden-demo.pdf` 4 页，`paper-example.pdf` 2 页。

## v0.4.0 - 2026-08-10

首个采用 LPPL 1.3c 的公开发布版本。

### 许可与发布

- 版权人为 Chen Jiaqi（GitHub: `@H15teve`），Current Maintainer 同为 Chen Jiaqi。
- 新增 LPPL 1.3c 完整许可证及 `LPPL-MANIFEST.txt`，明确 Work 文件范围并排除字体、期刊材料、示例图片和编译产物等第三方或附随材料。
- 发布包、README、样式包和变更记录版本统一升级为 v0.4.0。

### 排版修正

- 基金块按实际内容高度动态占用首页左栏底部，正文自动续排且不碰撞。
- 作者简介接口不再自动添加“作者简介：”前缀。

### 验证

- 自动检查：29 PASS / 0 FAIL；长基金块流式排版回归：6 PASS / 0 FAIL。
- 逐页视觉检查：`golden-demo.pdf` 4 页，`paper-example.pdf` 2 页。

## v0.3.3 - 2026-08-10

### 排版修正

- `\cseebiography` 不再自动添加“作者简介：”前缀，作者照片右侧直接排印用户提供的简介正文，与金样中的实际作者条目一致。

### 验证

- 自动检查：29 PASS / 0 FAIL；新增作者简介宏无自动标签的源码回归项。
- 逐页视觉检查：`golden-demo.pdf` 4 页，`paper-example.pdf` 2 页。

## v0.3.2 - 2026-08-10

### 排版修正

- 基金项目由固定页面坐标改为首页左栏的动态栏底插入；模板按基金块实际高度预留空间，正文自动续排到右栏，避免内容变化时相互覆盖。
- 保持短基金块与 Word 金样的默认纵向锚点，并继续使用正常字距和 `\cseefundbreak` 条件连字符。

### 验证

- 自动检查：28 PASS / 0 FAIL。
- 新增长基金块回归样例，检查左栏栏底位置、正文间距、右栏续排以及无固定 shipout 坐标：6 PASS / 0 FAIL。

## v0.3.1 - 2026-08-10

### 新增

- 新增 `fontset=auto/windows/mac/noto/fandol` 跨平台字体方案；自动探测优先使用原 Word 字体，其次选择 macOS、Noto CJK 或 TeX Live 自带字体。
- 提供只读宏 `\cseeactualfontset` 并在编译日志中记录请求与实际选择的字体方案。

### 兼容性

- `paper-example.tex` 默认使用 `fontset=auto`；`golden-demo.tex` 锁定 `fontset=windows`，保证金样回归仍以原字体为基准。
- Linux/容器可使用 Noto CJK 或无需额外系统字体的 Fandol/TeX Gyre 回退；macOS 使用 Songti SC、Heiti SC、STFangsong 与 Kaiti SC。
- 保留旧版 `\cseefontprofile=gb2312` 接口，并限定其仅作用于 Windows 字体方案。

## v0.3.0 - 2026-08-09

首个整理发布版本。

### 新增

- 提供 `paper-example.tex` 作为真实论文写作入口，并保留 `golden-demo.tex` 作为四页视觉回归样张。
- 提供 DOI、文章编号、中图分类号，中英文标题/作者/单位，摘要、关键词、基金项目、图表、致谢、附录、作者简介和责任编辑等语义接口。
- 基金编号支持 `\cseefundbreak` 条件断点：仅在实际换行时于行末显示半角连字符。
- 提供 Windows 参数化编译脚本与发布包 SHA-256 清单。

### 排版修正

- 校准首页中英文页眉行距、右侧页码、元数据项目及标题/作者/单位间距。
- 校准英文标题前空行及英文作者信息到 `ABSTRACT` 的间距。
- 校准英文摘要、英文关键词、中文摘要和中文关键词的段内行距。
- 重建首页基金项目字体、字号、固定行距、首行缩进和位置；移除项目名称与编号的非必要加宽字距。
- 修正参考文献标题到首条文献的间距、末页责任编辑与编辑说明字体。

### 验证

- 自动检查：26 PASS / 0 FAIL。
- 逐页视觉检查：`golden-demo.pdf` 4 页，`paper-example.pdf` 2 页。
