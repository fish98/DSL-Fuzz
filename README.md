# Fuzzing DSL Projects for Fun and Bugs

## Prerequisites

1. [AFLplusplus](https://github.com/AFLplusplus/AFLplusplus)

## Targets

```bash
git submodule update --init --recursive
```

1. [AWK](https://github.com/onetrueawk/awk)

2. [GAWK](https://savannah.gnu.org/projects/gawk)

3. [VIM](https://github.com/vim/vim)

**TODO**

1. TOML

## Data Processing

1. Collect all the distributed results

ensure dir `hang_collect_{package_name}`, `queue_collect_{package_name}` and dir `crashes_collect_{package_name}` has collected all the related data.

Move all the related subdirs into the corresponding result dir (e.g., {package_name}-1, {package_name}-2)

2. Gather

```bash
python collect_result.py
bash gather_result.sh
```

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
