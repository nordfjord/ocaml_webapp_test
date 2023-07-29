```
❯ k6 run --vus 80 --duration 10s test.js

          /\      |‾‾| /‾‾/   /‾‾/
     /\  /  \     |  |/  /   /  /
    /  \/    \    |     (   /   ‾‾\
   /          \   |  |\  \ |  (‾)  |
  / __________ \  |__| \__\ \_____/ .io

  execution: local
     script: test.js
     output: -

  scenarios: (100.00%) 1 scenario, 80 max VUs, 40s max duration (incl. graceful stop):
           * default: 80 looping VUs for 10s (gracefulStop: 30s)


running (10.0s), 00/80 VUs, 44885 complete and 0 interrupted iterations
default ✓ [=====================================] 80 VUs  10s

     data_received..................: 81 MB  8.1 MB/s
     data_sent......................: 4.9 MB 489 kB/s
     http_req_blocked...............: avg=8.85µs  min=0s       med=0s      max=5.27ms   p(90)=1µs     p(95)=1µs
     http_req_connecting............: avg=3.55µs  min=0s       med=0s      max=2.31ms   p(90)=0s      p(95)=0s
     http_req_duration..............: avg=17.81ms min=593µs    med=16.98ms max=240.81ms p(90)=28.33ms p(95)=33.01ms
       { expected_response:true }...: avg=17.81ms min=593µs    med=16.98ms max=240.81ms p(90)=28.33ms p(95)=33.01ms
     http_req_failed................: 0.00%  ✓ 0           ✗ 44885
     http_req_receiving.............: avg=10.96µs min=4µs      med=10µs    max=318µs    p(90)=14µs    p(95)=16µs
     http_req_sending...............: avg=2.35µs  min=1µs      med=2µs     max=509µs    p(90)=3µs     p(95)=4µs
     http_req_tls_handshaking.......: avg=0s      min=0s       med=0s      max=0s       p(90)=0s      p(95)=0s
     http_req_waiting...............: avg=17.79ms min=586µs    med=16.96ms max=240.8ms  p(90)=28.32ms p(95)=32.99ms
     http_reqs......................: 44885  4483.075031/s
     iteration_duration.............: avg=17.83ms min=603.25µs med=16.99ms max=242.97ms p(90)=28.34ms p(95)=33.02ms
     iterations.....................: 44885  4483.075031/s
     vus............................: 80     min=80        max=80
     vus_max........................: 80     min=80        max=80
```
