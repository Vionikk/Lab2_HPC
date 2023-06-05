start=$(date +%s.%N)
ping -c 2 localhost >/dev/null
end=$(date +%s.%N)
runtime=$(echo "$end - $start" | bc)
echo "Runtime: $runtime seconds"