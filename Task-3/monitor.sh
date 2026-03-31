#!/usr/bin/env bash

# Exit immediately if a command fails, and fail on unset variables.
set -euo pipefail

# Name of the running container to monitor.
CONTAINER_NAME="${1:-custom-web}"

# Base directory for monitoring assets.
MONITOR_DIR="/opt/container-monitor"

# Directory where log file is stored.
LOG_DIR="${MONITOR_DIR}/logs"

# Log file path for metrics.
LOG_FILE="${LOG_DIR}/monitor.log"

# Ensure log directory exists before writing logs.
mkdir -p "${LOG_DIR}"

# In cron, PATH can be minimal, so resolve the docker binary explicitly.
DOCKER_BIN="$(command -v docker 2>/dev/null || true)"
if [[ -z "${DOCKER_BIN}" && -x /usr/bin/docker ]]; then
  DOCKER_BIN="/usr/bin/docker"
fi

# Capture container stats in a single line without stream.
# Capture container stats in a single line without stream.
# --format outputs: "<container_name>,<cpu_percent>,<memory_usage>"
if [[ -z "${DOCKER_BIN}" ]]; then
  TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"
  echo "${TIMESTAMP} | container=${CONTAINER_NAME} | status=docker_command_not_found" >> "${LOG_FILE}"
  exit 0
fi

STATS_LINE="$("${DOCKER_BIN}" stats --no-stream --format '{{.Name}},{{.CPUPerc}},{{.MemUsage}}' "${CONTAINER_NAME}" 2>/dev/null || true)"

# If container is not running or not found, write an informative log line.
if [[ -z "${STATS_LINE}" ]]; then
  TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"
  echo "${TIMESTAMP} | container=${CONTAINER_NAME} | status=not_running_or_not_found" >> "${LOG_FILE}"
  exit 0
fi

# Parse CSV-like output into separate variables.
CONTAINER="$(echo "${STATS_LINE}" | cut -d',' -f1)"
CPU="$(echo "${STATS_LINE}" | cut -d',' -f2)"
MEMORY="$(echo "${STATS_LINE}" | cut -d',' -f3)"

# Create a timestamp in local server time.
TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"

# Append one structured log entry per execution.
echo "${TIMESTAMP} | container=${CONTAINER} | cpu=${CPU} | memory=${MEMORY}" >> "${LOG_FILE}"
