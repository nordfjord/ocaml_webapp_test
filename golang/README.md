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
    http_req_duration..............: avg=492.15µs min=143.68µs med=434.23µs max=29.32ms p(90)=683.95µs p(95)=808.29µs
      { expected_response:true }...: avg=492.15µs min=143.68µs med=434.23µs max=29.32ms p(90)=683.95µs p(95)=808.29µs
    http_req_failed................: 0.00%  0 out of 191233
    http_reqs......................: 191233 19122.408014/s

    EXECUTION
    iteration_duration.............: avg=517.52µs min=149.17µs med=457.6µs  max=29.89ms p(90)=719.59µs p(95)=850.12µs
    iterations.....................: 191233 19122.408014/s
    vus............................: 10     min=10          max=10
    vus_max........................: 10     min=10          max=10

    NETWORK
    data_received..................: 346 MB 35 MB/s
    data_sent......................: 19 MB  1.9 MB/s




running (10.0s), 00/10 VUs, 191233 complete and 0 interrupted iterations
default ✓ [======================================] 10 VUs  10s
```
