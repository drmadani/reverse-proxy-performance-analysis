#!/bin/bash
# Skenario 2: Resource Limiting (CPU & Memory)
# Deploy ulang Swarm stack dengan limit berbeda, lalu uji dengan k6.

SCRIPT_DIR="$(dirname "$0")"
STACK_FILE="$SCRIPT_DIR/../docker-swarm.yml"
OUTPUT_DIR="$SCRIPT_DIR/../results/scenario2"
mkdir -p "$OUTPUT_DIR"

# Variasi limit: "nama:cpu:memory"
LIMITS=(
    "low:0.25:128M"
    "medium:0.50:256M"
    "high:1.00:512M"
)

TARGETS=(
    "nginx:http://localhost:8081"
    "apache:http://localhost:8082"
    "haproxy:http://localhost:8083"
)

echo "======================================================"
echo " SKENARIO 2: RESOURCE LIMITING (k6, 500 VU konstan)"
echo "======================================================"

for LIMIT in "${LIMITS[@]}"; do
    NAME="${LIMIT%%:*}"
    REST="${LIMIT#*:}"
    CPU="${REST%%:*}"
    MEM="${REST##*:}"

    echo ""
    echo ">>> Limit: $NAME (CPU=$CPU, Memory=$MEM)"

    # Generate stack file sementara dengan limit baru
    TMP_STACK="/tmp/docker-swarm-${NAME}.yml"
    sed "s/cpus: '0.50'/cpus: '$CPU'/g; s/memory: 256M/memory: $MEM/g" \
        "$STACK_FILE" > "$TMP_STACK"

    # Redeploy stack
    docker stack rm webstack > /dev/null 2>&1
    sleep 8
    docker stack deploy -c "$TMP_STACK" webstack > /dev/null 2>&1

    echo "    Menunggu service siap..."
    sleep 25

    # Uji tiap server
    for TARGET in "${TARGETS[@]}"; do
        SVC="${TARGET%%:*}"
        URL="${TARGET#*:}"
        OUTPUT_FILE="$OUTPUT_DIR/${SVC}_${NAME}_${CPU}cpu_${MEM}.txt"

        echo "    - $SVC -> $OUTPUT_FILE"
        docker run --rm -i --network host \
            -e TARGET_URL="$URL" \
            grafana/k6 run - < "$SCRIPT_DIR/scenario2.js" \
            > "$OUTPUT_FILE" 2>&1
    done

    rm -f "$TMP_STACK"
done

docker stack rm webstack > /dev/null 2>&1

echo ""
echo "Skenario 2 selesai. Hasil di: $OUTPUT_DIR"
