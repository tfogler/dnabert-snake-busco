# dnabert-snake-busco

Requires snakemake >=8.28.0, GNU parallel v20231122, and latest conda

usage
```
>>> nohup parallel --skip-first-line --colsep ',' -j 1 \
"snakemake --use-conda --config link={23} busco_db=viridiplantae_odb10 base={7} dir=busco_results" :::: metadata.csv \
>> parallel.stdout 2>> parallel.stderr &
# no slash on the "--config dir=busco_results"
```
