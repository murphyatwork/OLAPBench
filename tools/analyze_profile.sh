


#!/usr/bin/env bash
set -euo pipefail

# Usage: analyze_profile.sh [-u <hint>] -f <profile_file>
#        analyze_profile.sh [-u <hint>] <profile_file>
# Notes:
#  - Use '-' as <profile_file> to read profile content from STDIN

PROFILE_FILE=""
USER_HINT="don't change the schema, don't change the sql, just tell me the bottleneck of the query, tell me at most three suggestions"

usage() {
  echo "Usage: $0 -f <profile_file> | $0 <profile_file>" 1>&2
  exit 1
}

while getopts ":f:u:h" opt; do
  case "$opt" in
    f)
      PROFILE_FILE="$OPTARG"
      ;;
    u)
      USER_HINT="$OPTARG"
      ;;
    h)
      usage
      ;;
    \?)
      usage
      ;;
    :)
      usage
      ;;
  esac
done
shift $((OPTIND - 1))

if [[ -z "${PROFILE_FILE}" && $# -ge 1 ]]; then
  PROFILE_FILE="$1"
fi

if [[ -z "${PROFILE_FILE}" ]]; then
  usage
fi

if [[ "${PROFILE_FILE}" != "-" ]]; then
  if [[ ! -f "${PROFILE_FILE}" ]]; then
    echo "File not found: ${PROFILE_FILE}" 1>&2
    exit 1
  fi
fi

USER_HINT="$USER_HINT" python3 - "${PROFILE_FILE}" <<'PY' | curl -N 'https://ai-agent.starrocks.com/api/optimize_table_stream' \
  -H 'Accept: */*' \
  -H 'Accept-Language: en-US,en;q=0.9' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'DNT: 1' \
  -H 'Origin: https://ai-agent.starrocks.com' \
  -H 'Referer: https://ai-agent.starrocks.com/' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36' \
  -H 'sec-ch-ua: "Chromium";v="139", "Not;A=Brand";v="99"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  --data-binary @-
import json, os, sys
path = sys.argv[1]
if path == '-':
    profile = sys.stdin.read()
else:
    with open(path, 'r', encoding='utf-8', errors='ignore') as f:
        profile = f.read()
user_hint = os.environ.get('USER_HINT', "")
print(json.dumps({"profile": profile, "user_hint": user_hint}))
PY