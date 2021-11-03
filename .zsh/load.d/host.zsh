#!/usr/bin/env zsh

# mpv
case $HOST in
    "hatsune")
        alias mpv="mpv --vo=gpu --gpu-context=x11vk --gpu-api=vulkan --vulkan-queue-count=8 --hwdec=vaapi-copy";;
    "iroh")
        alias mpv="mpv --vo=gpu --profile=gpu-hq --cscale=ewa_lanczossharp --scale=ewa_lanczossharp --video-sync=display-resample --interpolation --tscale=catmull_rom";;
esac
