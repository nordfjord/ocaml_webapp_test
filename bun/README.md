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
    http_req_duration..............: avg=569.56µs min=150.85µs med=552.49µs max=41.9ms p(90)=640.03µs p(95)=701.77µs
      { expected_response:true }...: avg=569.56µs min=150.85µs med=552.49µs max=41.9ms p(90)=640.03µs p(95)=701.77µs
    http_req_failed................: 0.00%  0 out of 169881
    http_reqs......................: 169881 16987.326917/s

    EXECUTION
    iteration_duration.............: avg=585.37µs min=156.06µs med=567.77µs max=42.5ms p(90)=656.81µs p(95)=720.37µs
    iterations.....................: 169881 16987.326917/s
    vus............................: 10     min=10          max=10
    vus_max........................: 10     min=10          max=10

    NETWORK
    data_received..................: 308 MB 31 MB/s
    data_sent......................: 17 MB  1.7 MB/s




running (10.0s), 00/10 VUs, 169881 complete and 0 interrupted iterations
default ✓ [======================================] 10 VUs  10s
```
