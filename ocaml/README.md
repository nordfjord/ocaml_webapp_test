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
    http_req_duration..............: avg=521.4µs min=247.71µs med=501.8µs  max=9.32ms  p(90)=688.18µs p(95)=739.5µs
      { expected_response:true }...: avg=521.4µs min=247.71µs med=501.8µs  max=9.32ms  p(90)=688.18µs p(95)=739.5µs
    http_req_failed................: 0.00%  0 out of 185093
    http_reqs......................: 185093 18508.638122/s

    EXECUTION
    iteration_duration.............: avg=537µs   min=254.49µs med=517.35µs max=10.14ms p(90)=704.37µs p(95)=756.88µs
    iterations.....................: 185093 18508.638122/s
    vus............................: 10     min=10          max=10
    vus_max........................: 10     min=10          max=10

    NETWORK
    data_received..................: 358 MB 36 MB/s
    data_sent......................: 18 MB  1.8 MB/s




running (10.0s), 00/10 VUs, 185093 complete and 0 interrupted iterations
default ✓ [======================================] 10 VUs  10s
```
