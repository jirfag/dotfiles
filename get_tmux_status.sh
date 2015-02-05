CPU_USAGE=$(fgrep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf("%.1f%%", usage)}')
MEM_USAGE=$(top -Mbn 1 | grep "Mem" | awk '{ print $4 }')
echo "CPU: $CPU_USAGE, MEM: $MEM_USAGE"
