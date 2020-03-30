## EC2 Notes

## Instance Launch Types
- On demand: short workload, predictable pricing
- Reserved (MINIMUM 1 year): long workloads (database, static server)
    - Convertible Reserved Instances: long workloads with flexible
    instances
    - Scheduled Reserved Instances: i.e. every Friday from 5-7pm
- Spot instances: short workloads, cheap, caveat can lose instances (not as reliable)
- Dedicated Instances: hardware is reserved for you exclusively
- Dedicated Hosts: book an entire physical server

#### On Demand
- Pay for what you use (billed per second of usage)
- No commitment like a reserved instance
- Highest cost
- Good for elastic workloads

#### Reserved Instance
- up to 75% discount compared to on demand
- These are good for long-running processes like
a database or similar as they'll stay up for the allotted
time

#### Spot instance
Max Spot Price:
- allows you to set a max amount ($0.50 / hour) you
are willing to pay for the instance
- if spot prices are below that amount, you'll get an instance
- if prices then go up above your threshold, the instance will be reclaimed
by AWS

Spot Block:
- set a time frame (1 to 6 hours) that you want to have an instance and 
you'll get the instance for that amount of time before it's reclaimed
- there are *very rare* cases where they can get reclaimed during your 
time frame

These are good ways to get discounts on your instances, **but you
need to be careful with these because there is no guarantee the instance will
stay up**

Workloads should be failure resistant.

#### Dedicated Hosts
These are generally used for software with specific licencing requirements
or criteria about number of sockets or cores the software is running on.

Definitely more expensive and the reservation is for 3 years.

## Instance Types
R: RAM - high memory instances

I: I/O - high local I/O (database)

C: CPU

M: General purpose (Medium)

G: GPU - machine learning, graphics rendering

T: Burstable
 - CPU is good under normal conditions
 - When a high-CPU process comes along, the instance can "burst" for 
 some added speed and performs very highly
 - Doing so uses "burst credits", once all the burst credits are 
 used up, the CPU performance is *terrible*
 - Over time, as long as the CPU is under normal usage the credits will 
 build back up.
 - Different instance types have different rates of credits earned per hour,
 maximum credit balance, credits at launch, etc.
 - Credits are on a per-instance basis? Need to double check that.
 - There's a new unlimited offering where the CPU performance won't degrade after 
 using all credits, but you will pay a lot more when you do
 
Real-world Tip: ec2instances.info is a really good way to view differences between all
instance types
 
## AMIs
A custom image to run on your instance.

You can create your own or use someone else's AMI that they've put on the marketplace

Need to be careful as AMIs can be created with bad intent
and include malware.

Real-world tip: You can very easily create AMIs by simply
right-clicking an instance, Image > Create Image

#### Copying AMIs
There is a utility in the AMI Dashboard that will allow you to copy
and AMI.

AMIs that are shared across AWS accounts have the option to restrict copying
directly. AMIs bought from the Amazon Marketplace or Windows AMI and have an associated
billingProduct code do not have this permission enabled.

To copy these AMIs, you first need to launch and EC2 instance using the AMI
and then create a new AMI from that instance.

## Placement Groups
- Cluster
    - all instance are in the same rack in the same AZ
    - Pros: great inter-instance network performance
    - Cons: Disaster scenario, one rack goes down, all your instances go down
    - High performance, high risk
- Spread
    - Instances are spread across different hardware, racks, and AZs
    - Pros: Reliability, one rack goes down, still have other instance running
    - Cons: Limited to 7 instance per AZ 
- Partition
    - Multiple instances per partition/rack
    - Example: 12 instances, three racks with 4 instances each
    - Strikes a balance between Cluster and Spread for reliability
    (one rack can go down but others are still up)
    - 7 partitions per AZ, but can have 100s of instances
    - Use cases: distributed big data

Real-world note: t2.micro (free tier eligible) instances cannot be
launched in a cluster placement group, you have to go with something a bit bigger

