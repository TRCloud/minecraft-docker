# Dockerify Minecraft

[English](README.md) | [简体中文](README_cn.md)

## 这是什么?

这是一个提供 Minecraft 服务端所必须的环境的 Docker 镜像的项目

它主要是用于为 XiaoNetwork 服务器进行 Docker 实例隔离使用, 当然, 你也可以拿来自己用

**请注意, 本项目仅提供了一个开服所需的基础环境, 你还需要自行准备一个服务端**

## 镜像列表

目前本项目提供了 Java 8, Java 11, Java 17, Java 21 四个版本的镜像, 他们均采用 Zulu JDK 以追求更好的综合性能

- `bluefunny/minecraft:general-j8`
- `bluefunny/minecraft:general-j11`
- `bluefunny/minecraft:general-j17`
- `bluefunny/minecraft:general-j21`

此外, 本项目还提供了上述镜像的涵 `MCDReforged` (以及其插件常用依赖) 版本

它们均在上述镜像内额外添加了 Python 3.12 用于提供 `MCDReforged` 提供环境

- `bluefunny/minecraft:mcdr-j8-latest`
- `bluefunny/minecraft:mcdr-j11-latest`
- `bluefunny/minecraft:mcdr-j17-latest`
- `bluefunny/minecraft:mcdr-j21-latest`

> 本项目提供了 MCDR 的 2.12, 2.11, 2.10 三个版本的镜像, 你只需要将 `latest` 替换为 `2.12`, `2.11`, `2.10` 即可

## 如何使用?

### 1. 准备工作

首先, 你需要使用下面的命令安装 Docker 和 Docker Compose (示例用的是 Debian 12 系统)

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
sudo apt-get install -y docker-compose
```

当然, 你也可以使用下面的链接来手动安装它们

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### 2. 启动你的服务器

你也可以直接使用下面的命令来运行你的服务器

```bash
docker run --net host -v <你的 Minecraft 服务器文件夹>:/workspace -e STARTUP_CMD="java -jar <你的 Minecraft 服务端核心文件名>" bluefunny/minecraft:general-j21
```

如果你需要使用 MCDReforged 的话, 你也可以使用下面的命令来启动你的服务器

```bash
docker run --net host -v <你的 Minecraft 服务器文件夹>:/workspace -e STARTUP_CMD="python3.12 mcdreforged" bluefunny/minecraft:mcdr-j21-latest
```

## 问题

如果你在使用过程中遇到了问题, 请在 [GitHub Issues](https://github.com/XiaoNetworkProject/minecraft-docker/issues) 中反馈

## 许可证

这个项目是在 Apachae 2.0 许可证下发布的, 请查看 [LICENSE](LICENSE) 文件以获取更多信息
