#!/bin/bash
# Skenario 1: Uji Beban Bertahap menggunakan k6
# Menguji Nginx, Apache, dan HAProxy secara langsung.

OUTPUT_DIR="$(dirname "$0")/../results/scenario1"
mkdir -p "$OUTPUT_DIR"

TARGETS=(
    "nginx:http://localhost:8081"
    "apache:http://localhost:8082"
    "haproxy:http://localhost:8083"
)

echo "======================================================"
echo " SKENARIO 1: UJI BEBAN BERTAHAP (k6) - 100 s/d 1000 req/s"
echo "======================================================"

for TARGET in "${TARGETS[@]}"; do
    NAME="${TARGET%%:*}"
    URL="${TARGET#*:}"

    echo ""
    echo ">>> Testing $NAME -> $URL"
    OUTPUT_FILE="$OUTPUT_DIR/${NAME}_gradual_load.txt"

    # Jalankan k6 via Docker
    docker run --rm -i --network host \
        -e TARGET_URL="$URL" \
        grafana/k6 run - < "$(dirname "$0")/scenario1.js" \
        > "$OUTPUT_FILE" 2>&1

    echo "    Hasil disimpan di: $OUTPUT_FILE"
done

echo ""
echo "Skenario 1 selesai."
