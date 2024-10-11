#!/bin/bash
TEST=false
fasm src/boot.asm build/boot
if [ $# -gt 0 ]; then
    for i in $@; do
        case $i in
            "--test") TEST=true;;
        esac
    done
fi

if [ "$TEST" = true ]; then
    qemu-system-x86_64 -drive file=build/boot,format=raw
fi
