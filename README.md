# Install Docker on local machine
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04

docker save <my_image> | ssh -C user@my.remote.host.com docker load

# Makefile
1. Build docker image `east_west_coast` with `make build`
2. Deploy docker image `east_west_coast` to droplets in `ip.txt` with `make push`
   - NOTE: uploads latest build from `east_west_coast` on local machine,
     does not build on its own
3. Run image with `make run`

# Hostfile
Ubuntu host file is located at `etc/hosts`, added droplet instances on laptop



ping -n -c 1 -W 1 -q 142.93.240.183


# Normal ip ping: ping -n -c 1 -W 1 -q 142.93.240.183
PING 142.93.240.183 (142.93.240.183) 56(84) bytes of data.

--- 142.93.240.183 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 6.593/6.593/6.593/0.000 ms

# Time out ip ping: ping -n -c 1 -W 1 -q 142.93.240.183
PING 142.93.240.183 (142.93.240.183) 56(84) bytes of data.

--- 142.93.240.183 ping statistics ---
1 packets transmitted, 0 received, 100% packet loss, time 0ms


# Network down ip ping: ping -n -c 1 -W 1 -q 142.93.240.183
connect: Network is unreachable

# Network down dns ping: ping google.com
ping: google.com: Temporary failure in name resolution
