# Fuzzing DSL Projects for Fun and Bugs

## Run in docker

1. Build the Dockerfile
2. Enter each project and run `build.sh` and `fuzz.sh`, respectively

## Local deployment

### Prerequisites

1. [AFLplusplus](https://github.com/AFLplusplus/AFLplusplus)

### Targets

```bash
git submodule update --init --recursive
```

1. [AWK](https://github.com/onetrueawk/awk)

2. [GAWK](https://savannah.gnu.org/projects/gawk)

3. [VIM](https://github.com/vim/vim)

**TODO**

1. TOML

## Reproduce and Triage

1. [CrashWalk](https://github.com/bnagy/crashwalk)

```bash
cwtriage --root crashes_collect_dir/ -afl > triage.log
```

2. GDB

## Records and Progress

Google Sheet

Huntr Link

## LICENSE

GPL
