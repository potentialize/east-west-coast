# Intro
Hello guys.
My name is Bruno.
As you can imagine, I played around with ping.

[slide]

Well, that's pretty boring I hear you think.

NO, ping is crucial!

You see, these kids are having a lazy sunday afternoon.
They're playing their favorite game on the PlayStation.
They're having fun.

THEN their little sister starts watching some Max and
Ruby on the internet. God forbid Dora.
The latency spikes.
These fellows lose their game.
THEY ARE DEVASTATED!

Look, if response time drives me to block my siblings
in the firewall, you can be sure that response time is important.

# Project Setup
SO I collected those children's tears and spun them into Droplets.
Muahaha...

A droplet is a part of a server you can rent at DigitalOcean.
It's much like AWS, Azure or Google Cloud.

I started a droplet in each of these locations:
San Francisco, New York City and Amsterdam.

Note that the locations are quite distant form each other.
The direct distance between New York City and San Francisco
is 2570 mi. A photon of light takes about 14ms to cover that
distance.
The direct distance between New York City and Amsterdam is
3650 mi. For a photon, that is a 20ms journey.

So, if we get a response time below 20ms, something is
definitely wrong! These numbers also serve as an ideal case
to which we can compare the results.

[slide]
Every Droplet ran Ubuntu with Docker installed.
At start, entrypoint.sh is executed and spawns a process
for each ip address in a text file that is not its own.
For example, the container in New York creates a process that
pings the container in San Francisco and a process that
pings the container in Amsterdam.
This means that every connection is tested both ways.
6 log files were created.

[slide]
ping_ip.sh consists of an infinite loop that pings the
destination once, then pipes the data to awk for processing.
A package is considered lost if a response is not received
after 2s.

After each ping, the program goes to sleep for 2s.

[slide]
I let the three locations ping each other for over 6 days.
In total around 30 megabytes was generated.
This corresponds to more than 1.5 million pairs (time stamp + RTT) of data.

# Results
Now, before we start looking at the data, what do you guys guess,
will the ping remain stable over time, or will there be a lot of
spikes?

[slide]

I'm going to ask the same question again: stable or lots of spikes?

[slide]

Well, truth is the previous graph looks rather deceiving.
In reality the connection is pretty stable.
Problem with the previous graph is, every time a spike is drawn,
the line is big that it also covers the neighboring tens of minutes.
