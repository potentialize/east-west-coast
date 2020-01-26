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
to which we can compare the results.)


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
will the ping remain stable over time, or will there be a lot of spikes?


[slide]


I'm going to ask the same question again: stable or lots of spikes?


[slide]


Well, truth is the previous graph looks rather deceiving.
In reality the connection is pretty stable.
Problem with the previous graph is, every time a spike is drawn,
the line is so big that it also covers the neighboring tens of minutes.


[slide]


So I tinkered around a bit and settled on using a floating average for the 100 most recent points. It is still not perfect, but it shows a more nuanced image without hiding all the spikes.


[slide]


Before we will look at the data, a little reminder:
The graphs display UTC time.
Amsterdam is one hour ahead of UTC. (Days start little bit before label)
New York is five hours behind UTC. (Days start almost at the next mark)
San Francisco is 8 hours behind UTC. (Days start in between next two marks)


[slide]


This is the data between AMS and NYC, and vice versa.
The elapsed time between two markings is 6 hours.
The first observation is that most peaks correspond.

[click]
These peaks occur at 7pm New York time. It looks like a fairly
constant pattern, except for the weekend. My guess is that
business traffic dies down over the weekend. Also, since it was
Thanksgiving weekend, most people wanted to be with their family,
instead of spending time on their electronic devices, I HOPE.

[click]
These lines occur at 7am Amsterdam time (1am NYC). I cannot
explain why the peaks die out at (Thanksgiving) Thursday
and Friday, since The Nederlands does not observe Thanksgiving.
(Maybe the cable is less congested because the USA does use
less internet for once.)

[click]
This peak occurs when the day starts in NYC.


[slide]


On the NYC and SFO graph, it is notable that downward spikes
are possible. What this means is not clear to me, since
the reduced ping level is not sustained.

[click]
Again some spikes occur on both graphs. This time the graph
is a little more chaotic. This is a land line and therefore
probably has multiple junctions along it's path that can
influence traffic.

[click]
The red lines shown here are 7pm NYC. To mornings are two
markings to the right (7am).

[click]
The blue lines indicate 7pm in SFO.


[slide]


Do you guys remember the map from the beginning?
Turns out packets travel at a higher speed between
NYC and AMS, than between NYC and SFO.

- A possible factor could be that the land line
between NYC and SFO does not follow a straight path.

- If the land line has junctions along its path, then
those switches add ms each time a packet travels through.

- There may be more congestion at the endpoints.


[slide]


This graph has by far the least intense spikes.
(As testified by the standard deviation.)
The packets for this connection likely do not pass through NYC.

The green line is interesting, since it is the only instance
I found where the latency in one direction decreases, while it
increases in the other direction.


[slide]


You may be wondering, what about package loss? VERY LITTLE.
Between NYC and AMS, not a single package was lost during 6 days!
Between NYC and SFO, more packages were lost, but even then
the damage remains under 0.012%. [click]
All package loss happened on spikes, as to be expected.
(No need to include graph)


# conclusion
[slide]


So what have we learned?
- DigitalOcean has a very stable connection between data centers
  (Most likely rent their own cable.)
  - they rent bare metal in colocating facilities. The same companies
    that provide these facilities also posess physical internet cables.
- sea cable more reliable than land cable
  (most likely because no junctions)
  - higher speed
  - less package loss
- different routes


# outro
[slide]
