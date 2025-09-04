## Comparison (StarRocks vs DuckDB)

Sample size: 100, matched rows: 100

### Summary
- StarRocks: success=70, error=30, timeout=0, other=0, sum=140688.00 ms, geomean=1382.84 ms, median=1676.00 ms
- DuckDB: success=79, error=21, timeout=0, other=0, sum=77488.92 ms, geomean=661.91 ms, median=747.43 ms

### Per-query (name, state/median_ms/ratio)

| name | StarRocks state | StarRocks median_ms | DuckDB state | DuckDB median_ms | ratio(StarRocks/DuckDB) | Reason |
|---|---|---:|---|---:|---:| --- |
| 14138.sql | success | 2289.00 | success | 260.48 | 8.79 |
| 14155.sql | success | 2193.00 | success | 255.68 | 8.58 |
| 10555.sql | success | 2183.00 | success | 261.28 | 8.35 |
| 11829.sql | success | 941.00 | success | 128.68 | 7.31 |
| 26967.sql | success | 1691.00 | success | 257.86 | 6.56 |
| 5412.sql | success | 1196.00 | success | 197.77 | 6.05 |
| 25109.sql | success | 7231.00 | success | 1369.14 | 5.28 |
| 18940.sql | success | 832.00 | success | 176.16 | 4.72 |
| 28925.sql | success | 361.00 | success | 83.99 | 4.30 |
| 10711.sql | success | 949.00 | success | 251.03 | 3.78 |
| 10578.sql | success | 2117.00 | success | 573.16 | 3.69 |
| 14780.sql | success | 2407.00 | success | 690.74 | 3.48 |
| 10530.sql | success | 4367.00 | success | 1258.14 | 3.47 |
| 10911.sql | success | 2286.00 | success | 670.30 | 3.41 |
| 12560.sql | success | 2500.00 | success | 748.50 | 3.34 |
| 8336.sql | success | 2945.00 | success | 892.94 | 3.30 |
| 28279.sql | success | 1438.00 | success | 445.72 | 3.23 |
| 11442.sql | success | 2262.00 | success | 724.42 | 3.12 |
| 8503.sql | success | 5965.00 | success | 1971.81 | 3.03 |
| 10020.sql | success | 4865.00 | success | 1624.94 | 2.99 |
| 9946.sql | success | 2218.00 | success | 747.43 | 2.97 |
| 7266.sql | success | 1906.00 | success | 657.01 | 2.90 |
| 28070.sql | success | 1113.00 | success | 383.86 | 2.90 |
| 12870.sql | success | 3576.00 | success | 1256.97 | 2.84 |
| 12187.sql | success | 2013.00 | success | 727.67 | 2.77 |
| 11810.sql | success | 595.00 | success | 224.15 | 2.65 |
| 7624.sql | success | 2961.00 | success | 1136.89 | 2.60 |
| 28069.sql | success | 2620.00 | success | 1047.17 | 2.50 |
| 26745.sql | success | 612.00 | success | 254.74 | 2.40 |
| 13045.sql | success | 1691.00 | success | 740.76 | 2.28 |
| 12742.sql | success | 383.00 | success | 169.04 | 2.27 |
| 16393.sql | success | 381.00 | success | 171.96 | 2.22 |
| 7248.sql | success | 2321.00 | success | 1095.60 | 2.12 |
| 25916.sql | success | 2798.00 | success | 1381.56 | 2.03 |
| 10748.sql | success | 1101.00 | success | 543.84 | 2.02 |
| 22909.sql | success | 3246.00 | success | 1633.08 | 1.99 |
| 21930.sql | success | 5348.00 | success | 2716.94 | 1.97 |
| 15049.sql | success | 5913.00 | success | 3010.07 | 1.96 |
| 16791.sql | success | 571.00 | success | 296.46 | 1.93 |
| 25448.sql | success | 376.00 | success | 196.99 | 1.91 |
| 12737.sql | success | 990.00 | success | 526.09 | 1.88 |
| 13771.sql | success | 1778.00 | success | 947.65 | 1.88 |
| 13004.sql | success | 1367.00 | success | 737.49 | 1.85 |
| 25150.sql | success | 562.00 | success | 305.92 | 1.84 |
| 8729.sql | success | 1100.00 | success | 602.57 | 1.83 |
| 17679.sql | success | 1774.00 | success | 983.91 | 1.80 |
| 14607.sql | success | 791.00 | success | 439.35 | 1.80 |
| 5773.sql | success | 2244.00 | success | 1255.45 | 1.79 |
| 5904.sql | success | 5403.00 | success | 3116.71 | 1.73 |
| 7321.sql | success | 1306.00 | success | 791.23 | 1.65 |
| 6876.sql | success | 1488.00 | success | 915.99 | 1.62 |
| 6021.sql | success | 1700.00 | success | 1204.47 | 1.41 |
| 32637.sql | success | 1661.00 | success | 1177.02 | 1.41 |
| 6725.sql | success | 1267.00 | success | 903.92 | 1.40 |
| 6793.sql | success | 1658.00 | success | 1222.79 | 1.36 |
| 28982.sql | success | 186.00 | success | 137.20 | 1.36 |
| 15139.sql | success | 72.00 | success | 61.63 | 1.17 |
| 10229.sql | success | 2086.00 | success | 1813.72 | 1.15 |
| 14703.sql | success | 855.00 | success | 780.64 | 1.10 |
| 452.sql | success | 4182.00 | success | 3868.20 | 1.08 |
| 9453.sql | success | 519.00 | success | 506.02 | 1.03 |
| 29404.sql | success | 172.00 | success | 179.75 | 0.96 |
| 5567.sql | success | 783.00 | success | 834.29 | 0.94 |
| 19266.sql | success | 2515.00 | success | 2986.28 | 0.84 |
| 28161.sql | success | 195.00 | success | 237.25 | 0.82 |
| 27481.sql | success | 285.00 | success | 351.53 | 0.81 |
| 2855.sql | success | 1351.00 | success | 1848.11 | 0.73 |
| 3811.sql | success | 703.00 | success | 3231.93 | 0.22 |
| 21100.sql | error | nan | success | 437.29 | nan |
| 26385.sql | error | nan | success | 114.80 | nan |
| 27453.sql | error | nan | success | 380.85 | nan |
| 563.sql | error | nan | error | 5619.55 | nan |
| 30758.sql | error | nan | error | 48.52 | nan |
| 28957.sql | error | nan | error | 6186.23 | nan |
| 464.sql | error | nan | success | 747.86 | nan |
| 25963.sql | error | nan | error | 5562.63 | nan |
| 2333.sql | error | nan | error | 5612.14 | nan |
| 11081.sql | error | nan | error | 6825.07 | nan |
| 15722.sql | success | 8376.00 | error | 5330.96 | nan |
| 33704.sql | error | nan | success | 917.14 | nan |
| 9422.sql | error | nan | error | 5177.39 | nan |
| 4938.sql | error | nan | error | 47.10 | nan |
| 5143.sql | error | nan | error | 7037.76 | nan |
| 9037.sql | error | nan | success | 2211.82 | nan |
| 1563.sql | error | nan | error | 5225.40 | nan |
| 32192.sql | error | nan | error | 5270.17 | nan |
| 27656.sql | error | nan | error | 6233.84 | nan |
| 8747.sql | error | nan | success | 1249.39 | nan |
| 29211.sql | error | nan | error | 6906.20 | nan |
| 10247.sql | error | nan | error | 5113.49 | nan |
| 10455.sql | error | nan | error | 5814.41 | nan |
| 29462.sql | error | nan | error | 6721.71 | nan |
| 6366.sql | error | nan | success | 1967.89 | nan |
| 1722.sql | success | 558.00 | error | 47.89 | nan |
| 3953.sql | error | nan | error | 47.02 | nan |
| 25348.sql | error | nan | success | 3464.55 | nan |
| 33071.sql | error | nan | success | 1610.81 | nan |
| 25157.sql | error | nan | error | 5892.14 | nan |
| 32345.sql | error | nan | success | 1184.54 | nan |
| 27259.sql | error | nan | error | 5790.03 | nan |
