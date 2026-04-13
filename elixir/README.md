# Elixir

```bash
$ mix run --no-halt
```

## Results

```
❯ k6 run --vus 10 --duration 10s test.js

         /\      Grafana   /‾‾/
    /\  /  \     |\  __   /  /
   /  \/    \    | |/ /  /   ‾‾\
  /          \   |   (  |  (‾)  |
 / __________ \  |_|\_\  \_____/


     execution: local
        script: test.js
        output: -

     scenarios: (100.00%) 1 scenario, 10 max VUs, 40s max duration (incl. graceful stop):
              * default: 10 looping VUs for 10s (gracefulStop: 30s)



  █ TOTAL RESULTS

    HTTP
    http_req_duration..............: avg=838.38µs min=285.29µs med=688.01µs max=53.83ms p(90)=1.32ms p(95)=1.68ms
      { expected_response:true }...: avg=838.38µs min=285.29µs med=688.01µs max=53.83ms p(90)=1.32ms p(95)=1.68ms
    http_req_failed................: 0.00%  0 out of 114839
    http_reqs......................: 114839 11483.188312/s

    EXECUTION
    iteration_duration.............: avg=865.2µs  min=293.87µs med=709.34µs max=54.46ms p(90)=1.36ms p(95)=1.73ms
    iterations.....................: 114839 11483.188312/s
    vus............................: 10     min=10          max=10
    vus_max........................: 10     min=10          max=10

    NETWORK
    data_received..................: 228 MB 23 MB/s
    data_sent......................: 11 MB  1.1 MB/s




running (10.0s), 00/10 VUs, 114839 complete and 0 interrupted iterations
default ✓ [======================================] 10 VUs  10s
```
