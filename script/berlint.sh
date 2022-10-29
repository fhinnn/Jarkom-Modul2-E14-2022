echo 'nameserver 192.199.3.2' > /etc/resolv.conf

apt update
apt install bind9 -y

echo '
zone "wise.E14.com" {
    type slave;
    masters { 192.199.3.2; };
    file "/var/lib/bind/wise.E14.com";
};
zone "operation.wise.E14.com" {
    type master;
    file "/etc/bind/operation/operation.wise.E14.com";
}; ' > /etc/bind/named.conf.local

echo '
options {
        directory "/var/cache/bind";
        allow-query{any;};

        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
}; ' > /etc/bind/named.conf.options

mkdir /etc/bind/operation
cp /etc/bind/db.local /etc/bind/operation/operation.wise.E14.com

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     operation.wise.E14.com. root.operation.wise.E14.com. (
                                2         ; Serial
                             604800         ; Refresh
                            86400         ; Retry
                            2419200         ; Expire
                             604800 )       ; Negative Cache TTL                                            
;
@       IN      NS      operation.wise.E14.com.
@       IN      A       192.199.1.3
www     IN      CNAME   operation.wise.E14.com.
strix           IN      A       192.199.1.3
www.strix       IN      A       192.199.1.3 ' > /etc/bind/operation/operation.w$

service bind9 restart
