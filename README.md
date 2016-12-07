# gobgp-tutorial

This repository provides Vagrantfile to build the tutorial environment which is described in the following slide:

[Tutorial: Using GoBGP as an IXP connecting router](http://www.slideshare.net/shusugimoto1986/tutorial-using-gobgp-as-an-ixp-connecting-router)

This was presented at IX.br Forum 10 (Sao Paulo, Dec 2016)


## About tutorial

- This tutorial focuses on using GoBGP as an IXP connection router
    - For FIB manipulation it will use quagga integration built in GoBGP
- It covers following topics:
    - Installation of GoBGP
    - gobgpd administration via systemd
    - Writing configuration file
    - Adding eBGP/iBGP peers
    - Applying policy
        - Including example use case to control route advertising over Route Server
    - FIB manipulation with zebra integration
    - RPKI setup
    - MRT/BMP setup
    - InfluxDB integration setup


## Prerequisites

- VirtualBox
- Vagrant
- following Vagrant plugins (for vSRX box)
    - vagrant-host-shell
    - vagrant-junos

Tested on Mac OS X but should work on both Windows/Linux too. If you find any problem, please report it through opening an issue.


## Getting started

1. clone the repository
    - `git clone https://github.com/s2ugimot/gobgp-tutorial.git`
2. `cd gobgp-tutorial`
3. `vagrant up`
    - Take a while...
4. Configure three vSRX routers (r1,r3,r4)
    - run `util/upload_junos_configs.sh`

If you encounter "time delay" problem with vSRX boxes (most likely to happen when you are using laptop pc and the host machine get into sleep mode) you can setup periodically (every 10 min) `ntpdate` with cron by running `util/set_junos_ntpdate.sh` onto those boxes.


## What should do next?

You will configure GoBGP installed on **g2** so login to g2 by `vagrant ssh g2` and be root `sudo su -` then create first configuration at `/etc/gobgp/gobgpd.conf` as described in slides, then boot it `systemctl start gobgpd`

After that you can modify it following the step by step instruction in the slide, or try out whatever you want to.

You can find the final configuration for **g2** under `configs/g2/gobgpd.conf`
