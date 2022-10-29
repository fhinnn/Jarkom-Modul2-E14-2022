echo 'nameserver 192.168.122.1' > /etc/resolv.conf

apt update
apt install bind9 -y

echo 'zone "wise.E14.com" {
    type master;
    notify yes;
    also-notify {192.199.1.2; }; 
    allow-transfer { 192.199.1.2; };  
    file "/etc/bind/jarkom/wise.E14.com";
};
zone "3.199.192.in-addr.arpa" {
    type master;
    file "/etc/bind/jarkom/3.199.192.in-addr.arpa";
}; ' >  /etc/bind/named.conf.local

mkdir /etc/bind/jarkom
mkdir /etc/bind/operation

cp /etc/bind/db.local /etc/bind/jarkom/wise.E14.com
cp /etc/bind/db.local /etc/bind/jarkom/3.199.192.in-addr.arpa

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     wise.E14.com. root.wise.E14.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@        IN      NS      wise.E14.com.
@        IN      A       192.199.1.3
www      IN      CNAME   wise.E14.com.
eden     IN      A       192.199.1.3
www.eden IN      A      192.199.1.3
ns1      IN     A       192.199.1.3
operation IN    NS      ns1
@        IN      AAAA    ::1 ' > /etc/bind/jarkom/wise.E14.com

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     wise.E14.com. root.wise.E14.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
1.199.192.in-addr.arpa. IN      NS      wise.E14.com.
3                       IN      PTR     wise.E14.com. ' > /etc/bind/jarkom/3.199.192.in-addr.arpa

echo 'options {
        directory "/var/cache/bind";
        allow-query{ any; };

        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
}; ' > /etc/bind/named.conf.options

service bind9 restart