# Docker Container for Steam - Selfhosted Cloud Gaming

Steam client running on Linux, inside a Docker Container.  
The objective is to play games (native Linux and Proton) via Steam Remote Play.  

This container builds upon the excellent work done in the [jlesage/baseimage-gui](https://hub.docker.com/r/jlesage/baseimage-gui) container.  
And is a fork of the original work done by [mikenye/docker-steam](https://github.com/mikenye/docker-steam)  
  
## PROJECT STATUS
* ~Currently looking into Lutris (on Steam).~
* Maybe I'll change base image, build my own (for control, security, stability, updates, etc...).

### This is a work in progress.
* Steam launches, and I can log in and install games.
* Some games runs (native linux).
* No audio.
* No support for gamepads.
* No HW acceleration (low fps, high CPU usage).

### TO DO LIST:  
-> Work on gpu drivers (INTEL)  
-> Make VAAPI work!  
-> Make touch controls/gamepads work!  
-> Get audio working  
-> Get Vulkan working  
-> Build script to disable novnc and save resources.  
-> Maybe: Disable novnc entirely (security, nginx, etc...), replace with proper vnc (wich will be disabled after setting steam acc).  
-> Set max resolution to 720p.  
-> Set max upload speed to 10Mbit/s.  
-> Work on gpu drivers (NVIDIA)  
-> Work on gpu drivers (AMD)  

### Running

So far, I've been testing this on my humble homelab machine.  
(HP Prodesk 600 G1 DM - i3-4150T - 4GB DDR3L - 240GB SATA SSD).  
This build is geared towards Intel iGPU, for now at least.  


For debug I recomend just `run -it` so you can actually see any error codes.
```
docker run \
    --rm \
    -it \
    --name steamcg \
    --shm-size 256M \
    -p 15800:5800 \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --device /dev/dri:/dev/dri \
    --device /dev/dri/card0:/dev/dri/card0 \
    --device /dev/dri/renderD128:/dev/dri/renderD128 \
    --privileged \
    -v steam:/steam \
    veckia9x/mjsvcg
```
For `let it run until it brake itself` status I recomend just `run -dit` and `--restart=unless-stopped` so you can close the ssh/local session and/or restart your PC/server and the container start itself again.

```
docker run \
    --rm \
    -dit \
    --name steamcg \
    --shm-size 256M \
    -p 15800:5800 \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --device /dev/dri:/dev/dri \
    --device /dev/dri/card0:/dev/dri/card0 \
    --device /dev/dri/renderD128:/dev/dri/renderD128 \
    --privileged \
    --restart=unless-stopped \
    -v steam:/steam \
    veckia9x/mjsvcg
```

You can then browse to http://[SERVERIP]:15800/, log in as yourself, set up remote play, you can use [pretty much any common pc/smartphone/smart device to remoteplay](https://store.steampowered.com/remoteplay), install a game and try it out.  
  
You may need to run `modprobe uinput` on the docker host prior... See how you go.  


### Know Issues

- On subsequent runs, a segmentation fault occurs. Deleting the `steam` volume and having Steam re-install seems to fix it up. It's annoying but I haven't figured out a fix yet.


### Games tested.

* [PixelJunk Monsters via NoVNC](https://i.imgur.com/7FVqXm5.mp4)
* Limbo [noVNC] (LOW FPS, 4~5fps)
* SpeedRunners [noVNC] (playable)
* Poly Bridge [noVNC] (playable)

### Comments

"I don't think I'm good enough to get this running perfectly on my own. :-)"  
mikenye, trust yourself! <3
