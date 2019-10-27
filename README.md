# br_nanopi_neo_plus2

Linux distribution for FriendlyARM Nanopi NEO Plus2 built with Buildroot.

don't forget to check [friendlyarm wiki](http://wiki.friendlyarm.com/wiki/index.php/NanoPi_NEO_Plus2) or [buildroot site](https://buildroot.org/) !

## Installation

```
git clone https://github.com/aussedatlo/br_nanopi_neo_plus2.git
cd br_nanopi_neo_plus2
git submodule init
git submodule update
```

## Usage

To build a basic distribution for Nanopi NEO Plus2, run:
```
make nanopi_neo_plus2_defconfig
make
```

you can see other defconfig using the command:
```
make target-list
```

