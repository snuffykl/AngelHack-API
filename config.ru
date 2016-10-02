#\ -p 8089 -o 0 -s puma -E production -O Threads=1:1

require "./lib/angelhack"

run API::Endpoints
