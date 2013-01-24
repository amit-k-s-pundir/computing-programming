#!/bin/bash

VBoxManage setextradata debian "VBoxInternal/Devices/pcnet/0/LUN#0/Config/ssh/HostPort" 2222
VBoxManage setextradata debian "VBoxInternal/Devices/pcnet/0/LUN#0/Config/ssh/GuestPort" 22
VBoxManage setextradata debian "VBoxInternal/Devices/pcnet/0/LUN#0/Config/ssh/Protocol" TCP


