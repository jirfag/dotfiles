#CPU_USAGE=$(fgrep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf("%.1f%%", usage)}')
CPU_USAGE=$(top -bn 2 -d 0.01 | fgrep "Cpu(s):" | tail -1 | gawk '{print $2+$4+$6}')
MEM_USAGE=$(top -Mbn 2 -d 0.01 | fgrep "Mem:" | tail -1 | gawk '{ print $4 }')
echo "CPU: ${CPU_USAGE}%, MEM: $MEM_USAGE"
