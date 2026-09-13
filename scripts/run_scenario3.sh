#!/bin/bash
# Scenario 3: HAProxy as Load Balancer

SCRIPT_DIR="$(dirname "$0")"
OUTPUT_DIR="$SCRIPT_DIR/../results/scenario3"
mkdir -p "$OUTPUT_DIR"

TARGETS=(
    "direct_nginx:http://localhost:8081"
    "direct_apache:http://localhost:8082"
    "via_haproxy:http://localhost:8083"
)

echo "======================================================"
echo " SKENARIO 3: HAProxy LOAD BALANCER (k6, 300 VU konstan)"
echo "======================================================"

for TARGET in "${TARGETS[@]}"; do
    NAME="${TARGET%%:*}"
    URL="${TARGET#*:}"
    OUTPUT_FILE="$OUTPUT_DIR/${NAME}.txt"

    echo ""
    echo ">>> Testing $NAME -> $URL"
    docker run --rm -i --network host \
        -e TARGET_URL="$URL" \
        grafana/k6 run - < "$SCRIPT_DIR/scenario3.js" \
        > "$OUTPUT_FILE" 2>&1

    echo "    Hasil: $OUTPUT_FILE"
done

echo ""
echo "Skenario 3 selesai. Hasil di: $OUTPUT_DIR"
