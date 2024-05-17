# Dockerify Minecraft

[English](README.md) | [简体中文](README_cn.md)

## What is this?

This is a project that provides Docker images of the environments necessary for Minecraft servers.

It is mainly used to isolate Docker instances for XiaoNetwork servers, but you can also use it for your own purposes.

**Please note that this project only provides a basic environment for starting a service, you need to prepare a server by yourself**.

## Mirror list

Currently this project provides four versions of Java 8, Java 11, Java 17, Java 21 mirrors, they all use the Zulu JDK in pursuit of better overall performance

- `bluefunny/minecraft:general-j8`.
- `bluefunny/minecraft:general-j11`.
- `bluefunny/minecraft:general-j17`
- `bluefunny/minecraft:general-j21`.

In addition, the project provides `MCDReforged` versions of the above mirrors (and their plugin dependencies).

They both add Python 3.12 to the above mirrors to provide the `MCDReforged` provider environment.

- `bluefunny/minecraft:mcdr-j8-latest`
- `bluefunny/minecraft:mcdr-j11-latest`
- `bluefunny/minecraft:mcdr-j17-latest`
- `bluefunny/minecraft:mcdr-j21-latest`

> This project provides MCDR 2.12, 2.11, 2.10 mirrors, you just need to replace `latest` with `2.12`, `2.11`, `2.10` and you are good to go.

## How does it work?

### 1. Preparation

First, you'll need to install Docker and Docker Compose with the following commands (we're using Debian 12 for this example)

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
sudo apt-get install -y docker-compose
``

Of course, you can also install them manually using the following link

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### 2. Starting your server

You can also run your server directly using the following command

```bash
docker run --net host -v <your Minecraft server folder>:/workspace -e STARTUP_CMD=“java -jar <your Minecraft server core filename>” bluefunny/minecraft:general-j21
```

If you need to use MCDReforged, you can also start your server with the following command

```bash
docker run --net host -v <your Minecraft server folder>:/workspace -e STARTUP_CMD=“python3.12 mcdreforged” bluefunny/minecraft:mcdr-j21-latest
```

## Problems

If you're having problems, please chime in at [GitHub Issues](https://github.com/XiaoNetworkProject/minecraft-docker/issues)

## License

This project is released under the Apachae 2.0 license, see the [LICENSE](LICENSE) file for more information.
