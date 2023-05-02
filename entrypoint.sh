#!/bin/bash --login
# The --login ensures the bash configuration is loaded, enabling Conda.

# Enable strict mode to run whatever commands...
set -euo pipefail

# Temporarily disable strict mode and activate conda:
set +euo pipefail
conda activate img2mol
pip install .

# Re-enable strict mode:
set -euo pipefail

# exec the final command:
export FLASK_APP=/app/run.py
exec flask run -h 0.0.0.0 -p 4200