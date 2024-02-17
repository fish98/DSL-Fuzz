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

## Data Processing

1. Collect all the distributed results

ensure dir `hang_collect_{package_name}`, `queue_collect_{package_name}` and dir `crashes_collect_{package_name}` has collected all the related data.

Move all the related subdirs into the corresponding result dir (e.g., {package_name}-1, {package_name}-2)

2. Gather Data

```bash
python collect_result.py
bash gather_result.sh
```

## Reproduce and Triage

0. AFLPlusplus

```bash
docker run -ti --privileged --net=host -v ${SOURCE}:/src aflplusplus/aflplusplus

export CC=afl-clang-fast
sed -i "s/gcc/${CC}/g" makefile
```

1. [CrashWalk](https://github.com/bnagy/crashwalk)

```bash
apt update
apt install golang # important !!

wget https://dl.google.com/go/go1.12.1.linux-amd64.tar.gz
tar -xzf go1.12.1.linux-amd64.tar.gz -C /usr/local

mkdir /go
export GOPATH=/go
export GOROOT=/usr/local/go
export PATH=$GOROOT/bin:$PATH:/go/bin

go get -u github.com/bnagy/crashwalk/cmd/...

mkdir ~/src
git clone https://github.com/jfoote/exploitable.git ~/src/exploitable

cwtriage --root crashes_collect_dir/ -afl > triage.log
```

2. GDB

Ensure the source code is compiled properly.

3. Non Termination Analysis

TBD

## Records and Progress

Google Sheet

Huntr Link

## LICENSE

GPL
