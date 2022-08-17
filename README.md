# Network_Monitor
Scan IPs and Ports on a Network\
\
Network Monitor scans a given IP or set of IPs and retrieves any found open ports.\
The results are stored in a logfile. (path: /home/kali/Desktop/logfile.txt) 

There are three ways to run this scanner:
1. ./Network_Monitor\
  Scans all the IPs in the subnet. 192.168.1.2-254
  
2. ./Network_Monitor 192.168.1.x\
  Scans one IP address.
  
3. ./Network_Monitor x y\
  Scans a range of IPs where x is the lower limit and y is the upper limit.

Network Monitor can be used along side Cron Scheduler to automate the scanning of IPs. 
