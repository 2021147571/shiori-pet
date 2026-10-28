# 水产 · Shiori Pet

近江汐莉的黑白漫画风 Codex 桌面宠物。已移除左右跑步，移动时保持站姿。

![动作预览](preview.gif)

## 一键安装

**Windows：**打开 PowerShell，粘贴运行：

```powershell
irm https://raw.githubusercontent.com/2021147571/shiori-pet/main/install.ps1 | iex
```

**macOS / Linux：**打开终端，粘贴运行：

```sh
curl -fsSL https://raw.githubusercontent.com/2021147571/shiori-pet/main/install.sh | sh
```

安装后在 Codex 的 **Settings → Pets** 中刷新并选择 **水产**。若列表未更新，重启应用。安装无需 API Key，也不会修改其他设置。

也可以把本仓库的 `pet.json` 和 `spritesheet.webp` 放到 `~/.codex/pets/shiori/`；设置了 `CODEX_HOME` 时，使用该目录下的 `pets/shiori/`。

## 文件

- `pet.json`、`spritesheet.webp`：Codex 本地安装包，采用兼容的九行动画格式。
- `source/spritesheet-v2.png`：完整十一行原图备份，包含十六个视线方向。
- `preview.gif`：修改后的基础动作预览。

角色出自苗川采《私を喰べたい、ひとでなし》（《对我垂涎欲滴的非人少女》）。本项目为非官方同人宠物，图像由 AI 辅助制作。

[官方角色介绍](https://wata-tabe.com/character/) · [Pets 使用说明](https://learn.chatgpt.com/docs/pets)
