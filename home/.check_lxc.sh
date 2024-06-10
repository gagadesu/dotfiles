#!/bin/sh
grep -q 'container=lxc' /proc/1/environ && echo true || echo false
