FROM openjdk:22-slim

WORKDIR /minecraft

RUN apt-get update -q --fix-missing
RUN apt-get install --no-install-recommends -y curl
RUN apt-get autoremove -y
RUN apt-get autoclean -y

# get minecraft server 1.20.4
# RUN curl -o server.jar https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar

# get minecraft spigot 1.20.4
RUN curl -o server.jar https://download.getbukkit.org/spigot/spigot-1.20.4.jar

# extract server config
RUN java -Xmx512M -Xms128M -jar ./server.jar nogui

# edit config
RUN sed -i '$d' eula.txt
RUN echo 'eula=true' >> eula.txt

RUN echo '\
allow-flight=false\n\
allow-nether=true\n\
broadcast-console-to-ops=true\n\
broadcast-rcon-to-ops=true\n\
debug=false\n\
difficulty=hard\n\
enable-command-block=false\n\
enable-jmx-monitoring=false\n\
enable-query=false\n\
enable-rcon=false\n\
enable-status=true\n\
enforce-secure-profile=true\n\
enforce-whitelist=false\n\
entity-broadcast-range-percentage=100\n\
force-gamemode=false\n\
function-permission-level=2\n\
gamemode=survival\n\
generate-structures=true\n\
generator-settings={}\n\
hardcore=false\n\
hide-online-players=false\n\
initial-disabled-packs=\n\
initial-enabled-packs=vanilla\n\
level-name=world\n\
level-seed=\n\
level-type=minecraft\:normal\n\
log-ips=true\n\
max-chained-neighbor-updates=1000000\n\
max-players=10\n\
max-tick-time=60000\n\
max-world-size=29999984\n\
motd=A Minecraft Server\n\
network-compression-threshold=256\n\
online-mode=true\n\
op-permission-level=4\n\
player-idle-timeout=0\n\
prevent-proxy-connections=false\n\
pvp=true\n\
query.port=25565\n\
rate-limit=0\n\
rcon.password=\n\
rcon.port=25575\n\
require-resource-pack=false\n\
resource-pack=\n\
resource-pack-id=\n\
resource-pack-prompt=\n\
resource-pack-sha1=\n\
server-ip=\n\
server-port=25565\n\
simulation-distance=10\n\
spawn-animals=true\n\
spawn-monsters=true\n\
spawn-npcs=true\n\
spawn-protection=16\n\
sync-chunk-writes=true\n\
text-filtering-config=\n\
use-native-transport=true\n\
view-distance=24\n\
white-list=false\n' > server.properties

EXPOSE 25565

CMD ["java", "-XX:ParallelGCThreads=4", "-Xmx4096M", "-Xms128M", "-jar", "/minecraft/server.jar", "nogui"]