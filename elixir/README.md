```
❯ k6 run --vus 80 --duration 30s test.js

          /\      |‾‾| /‾‾/   /‾‾/
     /\  /  \     |  |/  /   /  /
    /  \/    \    |     (   /   ‾‾\
   /          \   |  |\  \ |  (‾)  |
  / __________ \  |__| \__\ \_____/ .io

  execution: local
     script: test.js
     output: -

  scenarios: (100.00%) 1 scenario, 80 max VUs, 1m0s max duration (incl. graceful stop):
           * default: 80 looping VUs for 30s (gracefulStop: 30s)


running (0m30.2s), 00/80 VUs, 8892 complete and 0 interrupted iterations
default ✓ [==============================] 80 VUs  30s

     data_received..................: 2.3 GB 76 MB/s
     data_sent......................: 969 kB 32 kB/s
     http_req_blocked...............: avg=40.98µs  min=0s      med=2µs      max=4.95ms p(90)=4µs      p(95)=4.44µs
     http_req_connecting............: avg=17.97µs  min=0s      med=0s       max=2.25ms p(90)=0s       p(95)=0s
     http_req_duration..............: avg=270.7ms  min=16.03ms med=265.4ms  max=1.43s  p(90)=341.19ms p(95)=368.64ms
       { expected_response:true }...: avg=270.7ms  min=16.03ms med=265.4ms  max=1.43s  p(90)=341.19ms p(95)=368.64ms
     http_req_failed................: 0.00%  ✓ 0          ✗ 8892
     http_req_receiving.............: avg=104.72µs min=37µs    med=74µs     max=3.32ms p(90)=188µs    p(95)=217µs
     http_req_sending...............: avg=10.3µs   min=2µs     med=7µs      max=3.12ms p(90)=20µs     p(95)=23µs
     http_req_tls_handshaking.......: avg=0s       min=0s      med=0s       max=0s     p(90)=0s       p(95)=0s
     http_req_waiting...............: avg=270.58ms min=15.96ms med=265.29ms max=1.43s  p(90)=341.1ms  p(95)=368.57ms
     http_reqs......................: 8892   294.758861/s
     iteration_duration.............: avg=270.79ms min=16.07ms med=265.46ms max=1.43s  p(90)=341.24ms p(95)=368.67ms
     iterations.....................: 8892   294.758861/s
     vus............................: 80     min=80       max=80
     vus_max........................: 80     min=80       max=80
```
