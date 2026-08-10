<!--
Copyright 2026 Chen Jiaqi (GitHub: @H15teve)
Distributed under LPPL 1.3c or later; maintenance status: maintained.
Current Maintainer: Chen Jiaqi (GitHub: @H15teve).
This work consists of the files listed in LPPL-MANIFEST.txt.
-->

# CSEE_TPL

`CSEE_TPL` 是《中国电机工程学报》Word 模板的非官方 LaTeX 复刻，目标是在保留中文论文写作便利性的同时，尽量还原标题页、双栏正文、摘要与关键词、基金项目、图表、参考文献、附录和作者简介等版式。

**模板用途：本模板适合先用中文完成电气工程论文，再将内容迁移到 IEEE Transactions 等英文期刊模板。它不是《中国电机工程学报》官方发布的模板，也不能替代投稿前对期刊最新要求的核对。**

当前测试版本：**v0.6.1-rc1**（Overleaf 免费版编译优化候选）。

> **许可证：**本项目的原创模板实现采用 LaTeX Project Public License 1.3c 或更高版本发布，维护状态为 `maintained`。版权人及当前维护者为 Chen Jiaqi（GitHub: `@H15teve`）。准确的授权文件范围见 `LPPL-MANIFEST.txt`；第三方字体、期刊材料、示例图片及编译产物不因此获得授权。

## 发布包内容

| 文件或目录 | 用途 |
|---|---|
| `csee.sty` | 模板核心样式包 |
| `paper-example.tex` | 推荐复制并改写的论文骨架 |
| `paper-example.bbl` | Overleaf 免费版快速预览所用的已生成参考文献 |
| `refs.bib` | GB/T 7714 参考文献示例数据 |
| `golden-demo.tex` | 与 Word 模板逐页对照的排版样张源码 |
| `figures/` | 示例图、作者照片及金样所需素材 |
| `preview/paper-example.pdf` | 写作骨架的编译预览 |
| `preview/golden-demo.pdf` | 四页金样的编译预览 |
| `build.cmd` | Windows 一键编译入口 |
| `latexmkrc` | Overleaf/latexmk 编译轮次优化配置 |
| `CHANGELOG.md` | 版本变更记录 |
| `NOTICE.md` | 非官方声明、字体与许可证注意事项 |
| `LICENSE` | LPPL 1.3c 完整许可证文本 |
| `LPPL-MANIFEST.txt` | LPPL Work 文件范围、版权人和维护者声明 |
| `MANIFEST.sha256` | 发布包内文件的 SHA-256 校验清单 |

原始 Word/PDF 模板、测试数据、渲染截图和 LaTeX 中间文件不包含在发布包中。

## 环境要求

推荐使用 TeX Live 2025、XeLaTeX 与 Biber，并安装完整 TeX Live。模板直接使用 `ctex`、`biblatex`、`biblatex-gb7714-2015`、`newtx`、`geometry`、`siunitx`、`flushend`、`needspace`、`eso-pic` 等宏包。

### 跨平台字体方案

字体配置参考 ThuThesis 的做法：模板将操作系统自带字体、可选的 Noto CJK 字体和 TeX Live 随附字体组织为若干方案。论文骨架默认使用面向 Overleaf 免费版的轻量配置：

```tex
\usepackage[fontset=overleaf,fastcompile]{csee}
```

`overleaf` 与 `fandol` 使用相同的中文和正文西文字体，但不重复注册论文模板未使用的专用西文等宽字体；`fastcompile` 还停止预加载论文骨架未使用的 `setspace`、`multirow`、`tabularx`、`makecell` 和 `siunitx`。需要其中某个宏包时，可在主文件中自行 `\usepackage`；需要自动适应本地操作系统并恢复全部预加载宏包时，可改用：

```tex
\usepackage[fontset=auto]{csee}
```

| 方案 | 中文字体映射 | 西文字体映射 | 适用场景 |
|---|---|---|---|
| `windows` | SimSun、SimHei、FangSong、KaiTi | Times New Roman、Arial | 与原 Word 模板最接近；金样回归基准 |
| `mac` | Songti SC、Heiti SC、STFangsong、Kaiti SC | Times New Roman、Arial | macOS 原生字体环境 |
| `noto` | Noto Serif/Sans CJK SC；仿宋、楷体使用 Fandol | TeX Gyre Termes、Heros、Cursor | 已安装 Noto CJK 的 Linux/容器环境 |
| `fandol` | FandolSong、FandolHei、FandolFang、FandolKai | TeX Gyre Termes、Heros、Cursor | 仅依赖完整 TeX Live 的通用回退方案 |
| `overleaf` | 与 `fandol` 相同 | TeX Gyre Termes、Heros；等宽字体沿用发行版默认值 | Overleaf 免费版及受限 CI 环境 |

模板本身不附带字体文件。`windows` 是排版验收方案；其他方案保持宋体、黑体、仿宋、楷体等语义角色和字号、行距，但由于字面宽度不同，断行与分页不保证和 Word 金样完全一致。宋体重点字在 Windows 下因 SimSun 没有独立粗体字面而使用 `FakeBold`；macOS 的 Songti SC、Linux 推荐的 Noto Serif CJK SC 和 Fandol 则直接使用各自真实的 Bold 字面，不叠加仿粗。若 `auto` 的结果与预期不符，可在 `.log` 中搜索 `Requested fontset`，或在文档中查看只读宏 `\cseeactualfontset` 的值。

如已合法安装 `FangSong_GB2312` 和 `KaiTi_GB2312`，可在 `windows` 方案下启用更接近原 Word 模板的仿宋、楷体配置：

```tex
\newcommand{\cseefontprofile}{gb2312}
\usepackage[fontset=windows]{csee}
```

若显式选择的方案缺少所需字体，XeLaTeX 会报错；此时应安装对应字体，或改用 `auto`/`fandol`。商业字体、系统字体的使用和嵌入权限由用户自行确认。

## 快速开始

1. 复制 `paper-example.tex`，例如重命名为 `paper.tex`。
2. 保留 `csee.sty`、`refs.bib` 和 `figures/` 的相对位置。
3. 替换篇首信息、摘要、正文、图表、参考文献与作者简介。
4. 使用 XeLaTeX 和 Biber 编译。

### Overleaf 免费版（10 秒编译限制）

1. 将发布包内容直接放在 Overleaf 项目根目录，不要再套一层文件夹。
2. 主文件选择 `paper-example.tex`，编译器选择 XeLaTeX，TeX Live 版本选择 2025。
3. 保留根目录中的 `latexmkrc` 和 `paper-example.bbl`；Overleaf 会自动读取配置并复用已生成的参考文献。
4. 保持论文骨架的 `fontset=overleaf,fastcompile`。如需 `siunitx`、`multirow`、`tabularx`、`makecell` 或 `setspace`，请在主文件中按需加载。如需 Windows 金样字体，应在本地改用 `fontset=windows` 完成最终检查。

`latexmkrc` 只忽略 `biblatex/logreq` 在排版已经稳定后对 `.run.xml` 中单个状态位的修改，避免一次无视觉变化的 XeLaTeX 重跑；`.aux`、`.bcf`、交叉引用以及其他 XML 内容仍会被检查。本配置不限制最大编译轮数，也不会把未稳定的构建伪装为成功。

为避开免费版首次启动 Biber 的时间开销，`latexmkrc` 默认令 `$csee_run_biber = 0` 并读取随包提供的 `paper-example.bbl`。修改正文、公式、图表和已有引用不需要改变该值。修改 `refs.bib` 或新增引用后，可临时将其改成 `1` 编译一次；成功刷新参考文献后再改回 `0`。也可以在本地运行 `build.cmd paper-example`，或交由 GitHub Actions 使用 `CSEE_RUN_BIBER=1` 完成最终构建。

本地 TeX Live 2025 的免费版预览模式干净项目基准约为 8–9 秒；启用 Biber 的最终模式约为 10–11 秒。实际云端时间取决于 Overleaf 当时的执行节点；若首次编译仍超时，请保留生成文件并再次点击 Recompile，不要立即选择 Recompile from scratch。

在 Windows 发布包根目录中，可运行：

```powershell
cmd /c build.cmd paper-example
```

若已把源码重命名为 `paper.tex`，则运行 `cmd /c build.cmd paper`。脚本会自动检测是否需要 Biber。

手动编译顺序为：

```text
xelatex paper-example.tex
biber paper-example
xelatex paper-example.tex
xelatex paper-example.tex
```

重命名后，应把上述四条命令中的 `paper-example` 全部换成新的主文件基名，例如 `paper`。Biber 读取 XeLaTeX 生成的 `.bcf` 和 `refs.bib`，再生成参考文献数据；因此使用当前 `backend=biber` 配置时不能用 BibTeX 代替。

`golden-demo.tex` 锁定 `fontset=windows`，用于复现 Word 金样，不使用 Biber。具备 Windows 基准字体时连续运行三次 XeLaTeX 即可；也可执行：

```powershell
cmd /c build.cmd golden-demo
```

## 篇首与摘要

推荐保留语义化接口，不要在正文中手动调整字号、页边距或页眉坐标：

```tex
\begin{cseefrontmatter}
  \cseearticlemeta{DOI}{文章编号}{中图分类号}
  \cseetitle{中文标题}
  \cseeauthor{作者姓名}
  \cseeaffiliation{（1．作者单位，地址　邮编）}
  \cseetitleEN{English Title}
  \cseeauthorEN{AUTHOR Name}
  \cseeaffiliationEN{(Author Affiliation)}
\end{cseefrontmatter}

\begin{cseeabstractEN}
English abstract.
\end{cseeabstractEN}
\cseekeywordsEN{keyword1; keyword2; keyword3}

\begin{cseeabstract}
中文摘要。
\end{cseeabstract}
\cseekeywords{关键词1；关键词2；关键词3}
```

篇首元数据只保留 DOI、文章编号和中图分类号。英文标题前的空行以及英文作者信息至 `ABSTRACT` 的间距已由模板统一设置，请勿再插入空段落或 `\vspace`。


## 基金项目

基金项目位于首页左栏底部：

```tex
\cseefund
  {基金项目名称（项目编号：2006CB200303）}
  {Fund project name (Grant No. 2006CB200303).}
```

请在 `cseefrontmatter` 结束后、首页摘要和正文之前调用一次 `\cseefund`。模板会按基金块的实际高度预留首页左栏底部空间；内容增多时，左栏正文会提前续排到右栏，不会覆盖基金文字。若在右栏或后续页面才调用，编译日志会给出位置警告。

项目名称和编号使用正常字距，不要用空格或 `\hspace` 拉宽文字。若较长编号允许在某一位置跨行，请在该位置插入 `\cseefundbreak`：

```tex
2006CB2003\cseefundbreak 03
```

不换行时输出为 `2006CB200303`；实际换行时，上一行末尾显示半角连字符 `2006CB2003-`，下一行从 `03` 开始。

基金块不使用固定页面坐标。较长内容会改变首页分栏和后续分页，因此仍应逐页检查最终 PDF；极端长度的项目清单宜按期刊要求精简，而不要用负间距压缩或覆盖正文。

## 常用写作接口

| 内容 | 接口 |
|---|---|
| DOI、文章编号、中图分类号 | `\cseearticlemeta{DOI}{文章编号}{中图分类号}` |
| 中英文摘要、关键词 | `cseeabstract`、`cseeabstractEN`、`\cseekeywords`、`\cseekeywordsEN` |
| 基金项目 | `\cseefund{中文}{English}` |
| 双语表题 | `\cseetablecaption{中文}{English}` |
| 双语图题 | `\cseefigurecaption{中文}{English}` |
| 致谢 | `\cseeacknowledgment{正文}` |
| 附录标题 | `\cseeappendixhead[A]` |
| 作者简介 | `\cseebiography[照片下姓名]{照片文件}{简介}` |
| 带姓名标签的作者简介 | `\cseeauthorbio[姓名]{照片文件}{简介}` |
| 责任编辑 | `\cseeeditor{姓名}` |

章节、公式、标签、交叉引用、表格与图片仍使用标准 LaTeX 写法。

## 图表、参考文献与文末结构

- `paper-example.tex` 使用包内的 `figures/figA1.jpg` 演示插图。把自己的 PDF、PNG 或 JPG 图片放入 `figures/`，并将 `\includegraphics` 的参数改为相应文件名。
- 用自己的照片替换 `figures/author_photo.jpg`。作者照片宏按 2.2 cm × 2.8 cm 排版；比例不同的照片会被拉伸，应预先裁剪为接近该比例。建议分辨率不低于约 260 × 330 像素。
- `\cseebiography[照片下姓名]{照片}{简介}` 在照片下方排印可选的姓名，在照片右侧排印作者简介块：第一行是缩进 2 个中文字符的黑体“作者简介：”标签，第二行是同样缩进 2 个中文字符的作者信息。第三个参数请填写姓名、出生年份、职称、研究方向和邮箱等内容，不要重复标签；不需要照片下姓名时可省略方括号参数。
- 参考文献由 Biber 处理；修改 `.bib` 后必须重新运行 Biber。
- 当前示例使用 `biblatex-gb7714-2015` 提供的 `gb7714-2005` 样式。条目是否完整、文献类型是否准确仍取决于 `.bib` 数据。
- 在致谢、参考文献和附录之前使用 `\clearpage` 或等效浮动体屏障，避免尚未排出的图表越过参考文献。
- 模板默认不加载 `hyperref`；确需链接时可在主文件中加入 `\usepackage[hidelinks]{hyperref}`，并重新检查字体和版面。

## 迁移到 IEEE Transactions

模板把论文内容与视觉样式分开。迁移时通常可以保留章节、公式、图表、标签、引用和 `.bib` 数据，只需替换文档类与篇首接口：

| 本模板 | IEEEtran 中的对应内容 |
|---|---|
| `\cseetitle` | `\title` |
| `\cseeauthor`、`\cseeaffiliation` | `\author` 与作者单位块 |
| `cseeabstractEN` | `abstract` |
| `\cseekeywordsEN` | `IEEEkeywords` |
| `\cseetablecaption`、`\cseefigurecaption` | 标准单语 `\caption` |

不要把 `csee.sty` 的页面参数复制到目标期刊模板中；目标期刊类文件应接管字体、栏宽、题注与参考文献格式。

## 已知限制与投稿注意事项

- **本项目是非官方复刻，主要用途是论文草稿写作，根据《中国电机工程学报》的投稿要求，该期刊当前仅接受 Word 文件。**
- 期刊要求、DOI 格式、文章编号、分类号和参考文献规则可能变化，投稿前必须以期刊当前说明为准。
- Word 文档网格、文本框、MathType 对象锚点与 LaTeX 分页算法并不完全等价；内容长度变化后分页可能不同。
- 浮动体、长公式、长英文单词、作者数量和单位数量可能改变首页与双栏布局，作者必须检查最终 PDF 的每一页。
- Word 金样仅在 Windows、TeX Live 2025 和 `fontset=windows` 环境中做像素级验收；macOS/Linux 兼容方案不承诺相同的断行和分页。
- 字体、期刊名称和其他第三方素材的使用责任由发布者及论文作者自行承担。

发布 PDF 前至少检查：字体是否正确嵌入、首页基金块是否保持在左栏底部且正文正常续排、图表是否清晰、参考文献是否完整、页码和页眉是否正确，以及是否存在 `Overfull \hbox` 或缺字警告。

## 验证状态

v0.6.1-rc1 已完成 TeX Live 2025 干净项目计时、XeLaTeX + Biber 全流程编译、`fontset=overleaf` 字体复用回归，以及优化前后逐页像素对比。`golden-demo.tex` 继续使用 `fontset=windows`，不受 Overleaf 优化影响。该候选版本仍需在 Overleaf 免费版真实环境中确认首次编译时间。

## 许可证

本项目的原创模板实现按 LPPL 1.3c 或更高版本发布。完整条款见 `LICENSE`，构成 LPPL Work 的准确文件清单见 `LPPL-MANIFEST.txt`。期刊名称、官方模板相关材料、字体、示例图片与其他第三方内容不属于该授权范围；详见 `NOTICE.md`。
