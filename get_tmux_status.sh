#CPU_USAGE=$(fgrep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf("%.1f%%", usage)}')
CPU_USAGE=$(top -bn 2 -d 0.01 | fgrep "Cpu(s):" | tail -1 | gawk '{print $2+$4+$6}')
if uname -v | grep -qi ubuntu; then
	MEM_TOTAL=$(free -m | fgrep Mem: | gawk '{ print $2 }')
	MEM_USED=$(free -m | fgrep Mem: | gawk '{ print $3 }')
	echo "CPU: ${CPU_USAGE}%, MEM: $MEM_USED Mb / $MEM_TOTAL Mb"
else
	MEM_USAGE=$(top -bn 2 -d 0.01 | fgrep "Mem:"    | tail -1 | gawk '{ print $4 }')
	echo "CPU: ${CPU_USAGE}%, MEM: $MEM_USAGE"
fi
