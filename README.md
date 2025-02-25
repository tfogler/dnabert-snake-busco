# dnabert-snake-busco

Requires snakemake >=8.28.0, GNU parallel v20231122, and latest conda

usage
>>> nohup parallel --skip-first-line --colsep ',' -j 1 \
>>> "snakemake --use-conda --config link={17} busco_db=viridiplantae_odb10 base={7}" :::: metadata.csv \
>>> >> parallel.stdout 2>> parallel.stderr &
