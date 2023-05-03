#!/bin/bash --login
# The --login ensures the bash configuration is loaded, enabling Conda.

# Temporarily disable strict mode and activate conda:
set +euo pipefail
conda activate img2mol
pip install .

# Re-enable strict mode:
set -euo pipefail

# If WEB_API_PORT not set or null, set it to 4200.
WEB_API_PORT="${WEB_API_PORT:=4200}"

# exec the final command:
export FLASK_APP=/app/web-api.py
exec flask run -h 0.0.0.0 -p $WEB_API_PORT