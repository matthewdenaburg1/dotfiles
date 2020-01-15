ora_url='https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html'

cat <<-EOF
Also install oracle connector:
${ora_url}
- Instant Client Basic for version
- sqlplus-10.2.0.5.0-linux-x64.zip

if needed
EOF

mkdir -p /opt/oracle/instantclient_10_2
cd /opt/oracle/instantclient_10_2
mkdir -p bin network/admin sqlplus/admin sqlplus/mesg
cd -
