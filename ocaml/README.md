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
    http_req_duration..............: avg=341.62µs min=163.11µs med=337.8µs  max=45.97ms p(90)=420.87µs p(95)=477.06µs
      { expected_response:true }...: avg=341.62µs min=163.11µs med=337.8µs  max=45.97ms p(90)=420.87µs p(95)=477.06µs
    http_req_failed................: 0.00%  0 out of 276834
    http_reqs......................: 276834 27682.014446/s

    EXECUTION
    iteration_duration.............: avg=357.82µs min=170.1µs  med=352.51µs max=47.12ms p(90)=441.17µs p(95)=500.88µs
    iterations.....................: 276834 27682.014446/s
    vus............................: 10     min=10          max=10
    vus_max........................: 10     min=10          max=10

    NETWORK
    data_received..................: 501 MB 50 MB/s
    data_sent......................: 27 MB  2.7 MB/s




running (10.0s), 00/10 VUs, 276834 complete and 0 interrupted iterations
default ✓ [======================================] 10 VUs  10s
```
