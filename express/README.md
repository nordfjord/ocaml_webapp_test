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
    http_req_duration..............: avg=665.69µs min=232.85µs med=549.87µs max=41.04ms p(90)=1.17ms p(95)=1.4ms
      { expected_response:true }...: avg=665.69µs min=232.85µs med=549.87µs max=41.04ms p(90)=1.17ms p(95)=1.4ms
    http_req_failed................: 0.00%  0 out of 147346
    http_reqs......................: 147346 14732.647204/s

    EXECUTION
    iteration_duration.............: avg=676.52µs min=239.36µs med=559.28µs max=41.77ms p(90)=1.19ms p(95)=1.42ms
    iterations.....................: 147346 14732.647204/s
    vus............................: 10     min=10          max=10
    vus_max........................: 10     min=10          max=10

    NETWORK
    data_received..................: 256 MB 26 MB/s
    data_sent......................: 15 MB  1.5 MB/s




running (10.0s), 00/10 VUs, 147346 complete and 0 interrupted iterations
default ✓ [======================================] 10 VUs  10s
```
