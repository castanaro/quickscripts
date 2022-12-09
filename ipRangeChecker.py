import sys

from netaddr import IPNetwork, IPAddress

print("ipcheck.py takes a supplied file of IP addresses and either a CIDR range (e.g., 192.168.10.0/24) or a file containing CIDR ranges")

if len(sys.argv) != 3:
    print("Please provide a file of IP  addresses and a CIDR range (or file containing CIDR ranges).")
    print("Usage: python3 ipcheck.py range.txt 192.168.10.0/24 (or cidr.txt)")

ipfile = sys.argv[1]
netrange = sys.argv[2]

if "/" in sys.argv[2]:
    f = open(ipfile, "r+")
    for i in f:
        if i in IPNetwork(netrange):
            print(i)
        else:
            continue
    f.close()

else:
    hold = []
    f = open(ipfile, "r+")
    for i in f:
        hold.append(i)

    f.close()

    hold2 = []
    t = open(netrange, "r+")
    for i in t:
        hold2.append(i)

    t.close()

    print(hold2)

    for i in hold:
        for p in hold2:
            if i in IPNetwork(p):
                print(i)
            else:
                continue
