# Bluebutton

Simple daemon that allows you to execute action when bluetooth button shutter pressed. So you can control your PC by low energy button device and few scripts.

![Bluetooth Remote Shutter](https://github.com/kinnalru/bluebutton/blob/master/button.jpg)


# Usage

```shell
$ bluebutton -d="Shutter3" # sudo as necessary
```

**With config**
```shell
$ cat /home/.config/bluebutton
keyup=echo UP
keydown=echo down; echo DOWN
longup=echo LONG UP
longdown=echo LONG DOWN
```

```shell
$ bluebutton -d="Shutter3" -c /home/.config/bluebutton # sudo as necessary
```

# Installation

**REQUIREMENTS**

* Ruby >= 2.0

* Kernel config
![Kernel config](https://github.com/kinnalru/bluebutton/blob/master/kernel.png)

* BlueZ

Install the gem:
```shell
$ gem install bluebutton # sudo as necessary
```

## Bluetooth button manual installation

You must setup bluetooth stack manually.
* Start scanning mode:

```shell
$ bluetoothctl
[bluetooth]$ power on
[bluetooth]$ scan on
```
* Enable Buetooth Button and wait while it will be found:
```shell
[NEW] Device FF:FF:1D:14:79:80 AB Shutter3
```

* Now you can pair Bluetooth Button and trust to it:
```shell
[bluetooth]$ pair FF:FF:1D:14:79:80
[CHG] Device FF:FF:1D:14:79:80 Paired: yes
Pairing successful
[AB Shutter3            ]$ trust FF:FF:1D:14:79:80
[CHG] Device FF:FF:1D:14:79:80 Trusted: yes
[AB Shutter3            ]$ quit
```
