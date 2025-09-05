## Comparison (StarRocks vs DuckDB)

Sample size: 100, matched rows: 100

### Summary
- StarRocks: success=75, error=25, timeout=0, other=0, sum=78367.00 ms, geomean=511.59 ms, median=513.00 ms
- DuckDB: success=79, error=21, timeout=0, other=0, sum=77948.63 ms, geomean=665.39 ms, median=745.11 ms

### Per-query (name, state/median_ms/ratio)

| name | StarRocks state | StarRocks median_ms | DuckDB state | DuckDB median_ms | ratio(StarRocks/DuckDB) |
|---|---|---:|---|---:|---:|
| 5412.sql | success | 636.00 | success | 198.41 | 3.21 |
| 11829.sql | success | 400.00 | success | 127.98 | 3.13 |
| 26967.sql | success | 556.00 | success | 257.28 | 2.16 |
| 14155.sql | success | 513.00 | success | 258.17 | 1.99 |
| 28070.sql | success | 887.00 | success | 457.94 | 1.94 |
| 10555.sql | success | 459.00 | success | 258.59 | 1.77 |
| 14138.sql | success | 444.00 | success | 260.33 | 1.71 |
| 13045.sql | success | 1150.00 | success | 720.96 | 1.60 |
| 8503.sql | success | 2987.00 | success | 2000.72 | 1.49 |
| 10530.sql | success | 1945.00 | success | 1304.40 | 1.49 |
| 10020.sql | success | 2454.00 | success | 1665.77 | 1.47 |
| 11442.sql | success | 1083.00 | success | 773.87 | 1.40 |
| 28925.sql | success | 115.00 | success | 84.23 | 1.37 |
| 14780.sql | success | 922.00 | success | 696.23 | 1.32 |
| 10578.sql | success | 716.00 | success | 567.99 | 1.26 |
| 12187.sql | success | 838.00 | success | 738.09 | 1.14 |
| 10911.sql | success | 747.00 | success | 671.45 | 1.11 |
| 7266.sql | success | 726.00 | success | 659.03 | 1.10 |
| 25448.sql | success | 215.00 | success | 197.37 | 1.09 |
| 7624.sql | success | 1107.00 | success | 1149.15 | 0.96 |
| 12742.sql | success | 178.00 | success | 194.93 | 0.91 |
| 22909.sql | success | 1434.00 | success | 1610.02 | 0.89 |
| 5904.sql | success | 2510.00 | success | 3068.72 | 0.82 |
| 12560.sql | success | 619.00 | success | 763.77 | 0.81 |
| 10711.sql | success | 198.00 | success | 253.39 | 0.78 |
| 16393.sql | success | 131.00 | success | 169.36 | 0.77 |
| 18940.sql | success | 131.00 | success | 174.61 | 0.75 |
| 28982.sql | success | 97.00 | success | 136.65 | 0.71 |
| 25109.sql | success | 979.00 | success | 1381.05 | 0.71 |
| 32637.sql | success | 897.00 | success | 1312.64 | 0.68 |
| 25348.sql | success | 2328.00 | success | 3496.16 | 0.67 |
| 9946.sql | success | 477.00 | success | 747.10 | 0.64 |
| 19266.sql | success | 1922.00 | success | 3011.89 | 0.64 |
| 12870.sql | success | 791.00 | success | 1255.73 | 0.63 |
| 13771.sql | success | 566.00 | success | 944.54 | 0.60 |
| 10229.sql | success | 1101.00 | success | 1843.62 | 0.60 |
| 28161.sql | success | 137.00 | success | 237.22 | 0.58 |
| 5773.sql | success | 722.00 | success | 1260.12 | 0.57 |
| 13004.sql | success | 426.00 | success | 745.11 | 0.57 |
| 5567.sql | success | 451.00 | success | 808.37 | 0.56 |
| 28069.sql | success | 635.00 | success | 1151.91 | 0.55 |
| 8729.sql | success | 358.00 | success | 661.44 | 0.54 |
| 6876.sql | success | 496.00 | success | 925.81 | 0.54 |
| 15049.sql | success | 1584.00 | success | 2997.50 | 0.53 |
| 17679.sql | success | 504.00 | success | 969.57 | 0.52 |
| 7321.sql | success | 395.00 | success | 790.59 | 0.50 |
| 15139.sql | success | 30.00 | success | 60.87 | 0.49 |
| 6021.sql | success | 597.00 | success | 1254.01 | 0.48 |
| 6793.sql | success | 561.00 | success | 1181.46 | 0.47 |
| 16791.sql | success | 137.00 | success | 293.66 | 0.47 |
| 14607.sql | success | 197.00 | success | 439.71 | 0.45 |
| 26745.sql | success | 112.00 | success | 250.50 | 0.45 |
| 11810.sql | success | 96.00 | success | 224.14 | 0.43 |
| 29404.sql | success | 76.00 | success | 177.69 | 0.43 |
| 7248.sql | success | 460.00 | success | 1079.60 | 0.43 |
| 25150.sql | success | 118.00 | success | 291.07 | 0.41 |
| 10748.sql | success | 216.00 | success | 535.59 | 0.40 |
| 25916.sql | success | 553.00 | success | 1394.79 | 0.40 |
| 12737.sql | success | 192.00 | success | 502.71 | 0.38 |
| 452.sql | success | 1460.00 | success | 3844.73 | 0.38 |
| 28279.sql | success | 163.00 | success | 436.83 | 0.37 |
| 8336.sql | success | 355.00 | success | 965.83 | 0.37 |
| 6725.sql | success | 333.00 | success | 917.45 | 0.36 |
| 9453.sql | success | 182.00 | success | 518.30 | 0.35 |
| 14703.sql | success | 212.00 | success | 741.50 | 0.29 |
| 27481.sql | success | 99.00 | success | 346.50 | 0.29 |
| 2855.sql | success | 524.00 | success | 1854.71 | 0.28 |
| 21930.sql | success | 324.00 | success | 2701.16 | 0.12 |
| 3811.sql | success | 188.00 | success | 3219.00 | 0.06 |
| 21100.sql | error | nan | success | 443.24 | nan |
| 26385.sql | error | nan | success | 114.81 | nan |
| 27453.sql | error | nan | success | 330.76 | nan |
| 563.sql | error | nan | error | 5671.62 | nan |
| 30758.sql | error | nan | error | 45.70 | nan |
| 28957.sql | error | nan | error | 6162.05 | nan |
| 464.sql | error | nan | success | 683.98 | nan |
| 25963.sql | success | 7512.00 | error | 5525.73 | nan |
| 2333.sql | error | nan | error | 5582.40 | nan |
| 11081.sql | error | nan | error | 6813.03 | nan |
| 15722.sql | success | 4548.00 | error | 5370.30 | nan |
| 33704.sql | error | nan | success | 918.51 | nan |
| 9422.sql | error | nan | error | 5169.81 | nan |
| 4938.sql | error | nan | error | 50.41 | nan |
| 5143.sql | error | nan | error | 7025.70 | nan |
| 9037.sql | error | nan | success | 2256.39 | nan |
| 1563.sql | error | nan | error | 5226.52 | nan |
| 32192.sql | error | nan | error | 5255.76 | nan |
| 27656.sql | error | nan | error | 6293.57 | nan |
| 8747.sql | error | nan | success | 1282.29 | nan |
| 29211.sql | error | nan | error | 6943.81 | nan |
| 10247.sql | success | 9795.00 | error | 5116.10 | nan |
| 10455.sql | success | 7149.00 | error | 5840.16 | nan |
| 29462.sql | error | nan | error | 6702.99 | nan |
| 6366.sql | error | nan | success | 1923.86 | nan |
| 1722.sql | success | 136.00 | error | 46.70 | nan |
| 3953.sql | error | nan | error | 46.41 | nan |
| 33071.sql | error | nan | success | 1622.34 | nan |
| 25157.sql | error | nan | error | 5904.71 | nan |
| 32345.sql | error | nan | success | 1180.88 | nan |
| 27259.sql | success | 3075.00 | error | 5778.80 | nan |
