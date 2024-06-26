FROM openjdk:22-slim

WORKDIR /minecraft

RUN apt-get update -q --fix-missing
RUN apt-get install --no-install-recommends -y curl
RUN apt-get autoremove -y
RUN apt-get autoclean -y

# get minecraft server 1.20.4
# RUN curl -o server.jar https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar

# get minecraft spigot 1.20.4
# RUN curl -o server.jar https://download.getbukkit.org/spigot/spigot-1.20.4.jar

# get minecraft paper-mc 1.20.4
RUN curl -o server.jar https://api.papermc.io/v2/projects/paper/versions/1.20.4/builds/496/downloads/paper-1.20.4-496.jar

# extract server config
RUN java -Xmx512M -Xms128M -jar ./server.jar nogui

# install plugins
RUN curl -o /minecraft/plugins/spark-bukkit.jar https://ci.lucko.me/job/spark/410/artifact/spark-bukkit/build/libs/spark-1.10.65-bukkit.jar

# edit config
RUN sed -i '$d' eula.txt
RUN echo 'eula=true' >> eula.txt

RUN echo -e '\
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
gamemode=creative\n\
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
max-players=4\n\
max-tick-time=60000\n\
max-world-size=29999984\n\
motd=A Minecraft Server\n\
network-compression-threshold=256\n\
online-mode=false\n\
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
simulation-distance=2\n\
spawn-animals=true\n\
spawn-monsters=true\n\
spawn-npcs=true\n\
spawn-protection=16\n\
sync-chunk-writes=true\n\
text-filtering-config=\n\
use-native-transport=true\n\
view-distance=8\n\
white-list=false\n' > server.properties

RUN echo -e '\
_version: 30 \n\
anticheat: \n\
  anti-xray: \n\
    enabled: false \n\
    engine-mode: 1 \n\
    hidden-blocks: \n\
    - copper_ore \n\
    - deepslate_copper_ore \n\
    - raw_copper_block \n\
    - gold_ore \n\
    - deepslate_gold_ore \n\
    - iron_ore \n\
    - deepslate_iron_ore \n\
    - raw_iron_block \n\
    - coal_ore \n\
    - deepslate_coal_ore \n\
    - lapis_ore \n\
    - deepslate_lapis_ore \n\
    - mossy_cobblestone \n\
    - obsidian \n\
    - chest \n\
    - diamond_ore \n\
    - deepslate_diamond_ore \n\
    - redstone_ore \n\
    - deepslate_redstone_ore \n\
    - clay \n\
    - emerald_ore \n\
    - deepslate_emerald_ore \n\
    - ender_chest \n\
    lava-obscures: false \n\
    max-block-height: 64 \n\
    replacement-blocks: \n\
    - stone \n\
    - oak_planks \n\
    - deepslate \n\
    update-radius: 2 \n\
    use-permission: false \n\
  obfuscation: \n\
    items: \n\
      hide-durability: false \n\
      hide-itemmeta: false \n\
      hide-itemmeta-with-visual-effects: false \n\
chunks: \n\
  auto-save-interval: default \n\
  delay-chunk-unloads-by: 10s \n\
  entity-per-chunk-save-limit: \n\
    arrow: -1 \n\
    ender_pearl: -1 \n\
    experience_orb: -1 \n\
    fireball: -1 \n\
    small_fireball: -1 \n\
    snowball: -1 \n\
  fixed-chunk-inhabited-time: -1 \n\
  flush-regions-on-save: false \n\
  max-auto-save-chunks-per-tick: 24 \n\
  prevent-moving-into-unloaded-chunks: false \n\
collisions: \n\
  allow-player-cramming-damage: false \n\
  allow-vehicle-collisions: true \n\
  fix-climbing-bypassing-cramming-rule: false \n\
  max-entity-collisions: 8 \n\
  only-players-collide: false \n\
command-blocks: \n\
  force-follow-perm-level: true \n\
  permissions-level: 2 \n\
entities: \n\
  armor-stands: \n\
    do-collision-entity-lookups: true \n\
    tick: true \n\
  behavior: \n\
    allow-spider-world-border-climbing: true \n\
    baby-zombie-movement-modifier: 0.5 \n\
    disable-chest-cat-detection: false \n\
    disable-creeper-lingering-effect: false \n\
    disable-player-crits: false \n\
    door-breaking-difficulty: \n\
      husk: \n\
      - HARD \n\
      vindicator: \n\
      - NORMAL \n\
      - HARD \n\
      zombie: \n\
      - HARD \n\
      zombie_villager: \n\
      - HARD \n\
      zombified_piglin: \n\
      - HARD \n\
    ender-dragons-death-always-places-dragon-egg: false \n\
    experience-merge-max-value: -1 \n\
    mobs-can-always-pick-up-loot: \n\
      skeletons: false \n\
      zombies: false \n\
    nerf-pigmen-from-nether-portals: false \n\
    parrots-are-unaffected-by-player-movement: false \n\
    phantoms-do-not-spawn-on-creative-players: true \n\
    phantoms-only-attack-insomniacs: true \n\
    phantoms-spawn-attempt-max-seconds: 119 \n\
    phantoms-spawn-attempt-min-seconds: 60 \n\
    piglins-guard-chests: true \n\
    pillager-patrols: \n\
      disable: false \n\
      spawn-chance: 0.2 \n\
      spawn-delay: \n\
        per-player: false \n\
        ticks: 12000 \n\
      start: \n\
        day: 5 \n\
        per-player: false \n\
    player-insomnia-start-ticks: 72000 \n\
    should-remove-dragon: false \n\
    spawner-nerfed-mobs-should-jump: false \n\
    zombie-villager-infection-chance: default \n\
    zombies-target-turtle-eggs: true \n\
  entities-target-with-follow-range: false \n\
  markers: \n\
    tick: true \n\
  mob-effects: \n\
    immune-to-wither-effect: \n\
      wither: true \n\
      wither-skeleton: true \n\
    spiders-immune-to-poison-effect: true \n\
    undead-immune-to-certain-effects: true \n\
  sniffer: \n\
    boosted-hatch-time: default \n\
    hatch-time: default \n\
  spawning: \n\
    all-chunks-are-slime-chunks: false \n\
    alt-item-despawn-rate: \n\
      enabled: false \n\
      items: \n\
        cobblestone: 300 \n\
    count-all-mobs-for-spawning: false \n\
    creative-arrow-despawn-rate: default \n\
    despawn-ranges: \n\
      ambient: \n\
        hard: 128 \n\
        soft: 32 \n\
      axolotls: \n\
        hard: 128 \n\
        soft: 32 \n\
      creature: \n\
        hard: 128 \n\
        soft: 32 \n\
      misc: \n\
        hard: 128 \n\
        soft: 32 \n\
      monster: \n\
        hard: 128 \n\
        soft: 32 \n\
      underground_water_creature: \n\
        hard: 128 \n\
        soft: 32 \n\
      water_ambient: \n\
        hard: 64 \n\
        soft: 32 \n\
      water_creature: \n\
        hard: 128 \n\
        soft: 32 \n\
    disable-mob-spawner-spawn-egg-transformation: false \n\
    duplicate-uuid: \n\
      mode: SAFE_REGEN \n\
      safe-regen-delete-range: 32 \n\
    filter-bad-tile-entity-nbt-from-falling-blocks: true \n\
    filtered-entity-tag-nbt-paths: \n\
    - Pos \n\
    - Motion \n\
    - SleepingX \n\
    - SleepingY \n\
    - SleepingZ \n\
    iron-golems-can-spawn-in-air: false \n\
    monster-spawn-max-light-level: default \n\
    non-player-arrow-despawn-rate: default \n\
    per-player-mob-spawns: true \n\
    scan-for-legacy-ender-dragon: true \n\
    skeleton-horse-thunder-spawn-chance: default \n\
    slime-spawn-height: \n\
      slime-chunk: \n\
        maximum: 40.0 \n\
      surface-biome: \n\
        maximum: 70.0 \n\
        minimum: 50.0 \n\
    spawn-limits: \n\
      ambient: -1 \n\
      axolotls: -1 \n\
      creature: -1 \n\
      monster: -1 \n\
      underground_water_creature: -1 \n\
      water_ambient: -1 \n\
      water_creature: -1 \n\
    ticks-per-spawn: \n\
      ambient: -1 \n\
      axolotls: -1 \n\
      creature: -1 \n\
      monster: -1 \n\
      underground_water_creature: -1 \n\
      water_ambient: -1 \n\
      water_creature: -1 \n\
    wandering-trader: \n\
      spawn-chance-failure-increment: 25 \n\
      spawn-chance-max: 75 \n\
      spawn-chance-min: 25 \n\
      spawn-day-length: 24000 \n\
      spawn-minute-length: 1200 \n\
    wateranimal-spawn-height: \n\
      maximum: default \n\
      minimum: default \n\
  tracking-range-y: \n\
    animal: default \n\
    display: default \n\
    enabled: false \n\
    misc: default \n\
    monster: default \n\
    other: default \n\
    player: default \n\
environment: \n\
  disable-explosion-knockback: false \n\
  disable-ice-and-snow: false \n\
  disable-teleportation-suffocation-check: false \n\
  disable-thunder: false \n\
  fire-tick-delay: 30 \n\
  frosted-ice: \n\
    delay: \n\
      max: 40 \n\
      min: 20 \n\
    enabled: true \n\
  generate-flat-bedrock: false \n\
  locate-structures-outside-world-border: false \n\
  max-block-ticks: 65536 \n\
  max-fluid-ticks: 65536 \n\
  nether-ceiling-void-damage-height: disabled \n\
  optimize-explosions: false \n\
  portal-create-radius: 16 \n\
  portal-search-radius: 128 \n\
  portal-search-vanilla-dimension-scaling: true \n\
  treasure-maps: \n\
    enabled: true \n\
    find-already-discovered: \n\
      loot-tables: default \n\
      villager-trade: false \n\
  water-over-lava-flow-speed: 5 \n\
feature-seeds: \n\
  generate-random-seeds-for-all: false \n\
fishing-time-range: \n\
  maximum: 600 \n\
  minimum: 100 \n\
fixes: \n\
  disable-unloaded-chunk-enderpearl-exploit: true \n\
  falling-block-height-nerf: disabled \n\
  fix-items-merging-through-walls: false \n\
  prevent-tnt-from-moving-in-water: false \n\
  split-overstacked-loot: true \n\
  tnt-entity-height-nerf: disabled \n\
hopper: \n\
  cooldown-when-full: true \n\
  disable-move-event: false \n\
  ignore-occluding-blocks: false \n\
lootables: \n\
  auto-replenish: false \n\
  max-refills: -1 \n\
  refresh-max: 2d \n\
  refresh-min: 12h \n\
  reset-seed-on-fill: true \n\
  restrict-player-reloot: true \n\
  restrict-player-reloot-time: disabled \n\
maps: \n\
  item-frame-cursor-limit: 128 \n\
  item-frame-cursor-update-interval: 10 \n\
max-growth-height: \n\
  bamboo: \n\
    max: 16 \n\
    min: 11 \n\
  cactus: 3 \n\
  reeds: 3 \n\
misc: \n\
  disable-end-credits: false \n\
  disable-relative-projectile-velocity: false \n\
  disable-sprint-interruption-on-attack: false \n\
  light-queue-size: 20 \n\
  max-leash-distance: 10.0 \n\
  redstone-implementation: VANILLA \n\
  shield-blocking-delay: 5 \n\
  show-sign-click-command-failure-msgs-to-player: false \n\
  update-pathfinding-on-block-update: true \n\
scoreboards: \n\
  allow-non-player-entities-on-scoreboards: true \n\
  use-vanilla-world-scoreboard-name-coloring: false \n\
spawn: \n\
  allow-using-signs-inside-spawn-protection: false \n\
  keep-spawn-loaded: true \n\
  keep-spawn-loaded-range: 8 \n\
tick-rates: \n\
  behavior: \n\
    villager: \n\
      validatenearbypoi: -1 \n\
  container-update: 1 \n\
  dry-farmland: 1 \n\
  grass-spread: 1 \n\
  mob-spawner: 1 \n\
  sensor: \n\
    villager: \n\
      secondarypoisensor: 40 \n\
  wet-farmland: 1 \n\
unsupported-settings: \n\
  disable-world-ticking-when-empty: false \n\
  fix-invulnerable-end-crystal-exploit: true' > paper-world.yml

# edit paper config (optimization)
RUN sed 's/anti-xray:    \nenabled: false/anti-xray:    \nenabled: true/g' paper-world.yml
RUN sed 's/max-auto-save-chunks-per-tick: 24/max-auto-save-chunks-per-tick: 8/g' paper-world.yml
RUN sed 's/prevent-moving-into-unloaded-chunks: false/prevent-moving-into-unloaded-chunks: true/g' paper-world.yml
RUN sed 's/entity-per-chunk-save-limit:/entity-per-chunk-save-limit:\n    area_effect_cloud: 8\n    egg: 8\n    experience_bottle: 3\n    eye_of_ender: 8\n    firework_rocket: 8\n    llama_spit: 3\n    potion: 8\n    shulker_bullet: 8\n    spectral_arrow: 16\n    trident: 16\n    wither_skull: 4/g' paper-world.yml
RUN sed 's/hard: 128/hard: 72/g' paper-world.yml
RUN sed 's/soft: 32/soft: 30/g' paper-world.yml
RUN sed 's/max-entity-collisions: 8/max-entity-collisions: 2/g' paper-world.yml
RUN sed 's/update-pathfinding-on-block-update: true/update-pathfinding-on-block-update: false/g' paper-world.yml
RUN sed 's/redstone-implementation: VANILLA/redstone-implementation: ALTERNATE_CURRENT/g' paper-world.yml
RUN sed 's/optimize-explosions: false/optimize-explosions: true/g' paper-world.yml
RUN sed 's/non-player-arrow-despawn-rate: default/non-player-arrow-despawn-rate: 20/g' paper-world.yml
RUN sed 's/creative-arrow-despawn-rate: default/creative-arrow-despawn-rate: 20/g' paper-world.yml

RUN chmod 644 /minecraft/paper-world.yml

RUN mkdir ./world ./world_nether ./world_the_end
RUN mv /minecraft/paper-world.yml /minecraft/world/paper-world.yml
RUN cp /minecraft/world/paper-world.yml /minecraft/world_nether/paper-world.yml
RUN cp /minecraft/world/paper-world.yml /minecraft/world_the_end/paper-world.yml

EXPOSE 25565

CMD ["java", "-Xmx8192M", "-Xms128M", "-Dterminal.jline=false", "-Dterminal.ansi=true", "-XX:+UseG1GC", "-XX:+ParallelRefProcEnabled", "-XX:MaxGCPauseMillis=200", "-XX:+UnlockExperimentalVMOptions", "-XX:+DisableExplicitGC", "-XX:+AlwaysPreTouch", "-XX:G1HeapWastePercent=5", "-XX:G1MixedGCCountTarget=4", "-XX:G1MixedGCLiveThresholdPercent=90", "-XX:G1RSetUpdatingPauseTimePercent=5", "-XX:SurvivorRatio=32", "-XX:+PerfDisableSharedMem", "-XX:MaxTenuringThreshold=1", "-XX:G1NewSizePercent=30", "-XX:G1MaxNewSizePercent=40", "-XX:G1HeapRegionSize=8M", "-XX:G1ReservePercent=20", "-XX:InitiatingHeapOccupancyPercent=15", "-Dusing.aikars.flags=https://mcflags.emc.gs", "-Daikars.new.flags=true", "-jar", "server.jar"]
