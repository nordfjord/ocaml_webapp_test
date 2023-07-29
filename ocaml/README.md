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


running (10.0s), 00/80 VUs, 27637 complete and 0 interrupted iterations
default ✓ [========================] 80 VUs  10s

     data_received..................: 90 MB  9.0 MB/s
     data_sent......................: 3.0 MB 300 kB/s
     http_req_blocked...............: avg=11.83µs min=0s      med=1µs     max=4.56ms  p(90)=1µs     p(95)=1µs
     http_req_connecting............: avg=5.66µs  min=0s      med=0s      max=2.21ms  p(90)=0s      p(95)=0s
     http_req_duration..............: avg=28.95ms min=20.47ms med=28.88ms max=61.43ms p(90)=30.75ms p(95)=31.61ms
       { expected_response:true }...: avg=28.95ms min=20.47ms med=28.88ms max=61.43ms p(90)=30.75ms p(95)=31.61ms
     http_req_failed................: 0.00%  ✓ 0           ✗ 27637
     http_req_receiving.............: avg=11.01µs min=3µs     med=10µs    max=184µs   p(90)=14µs    p(95)=18µs
     http_req_sending...............: avg=2.54µs  min=1µs     med=2µs     max=174µs   p(90)=3µs     p(95)=4µs
     http_req_tls_handshaking.......: avg=0s      min=0s      med=0s      max=0s      p(90)=0s      p(95)=0s
     http_req_waiting...............: avg=28.94ms min=20.46ms med=28.87ms max=61.39ms p(90)=30.74ms p(95)=31.6ms
     http_reqs......................: 27637  2756.295763/s
     iteration_duration.............: avg=28.98ms min=20.49ms med=28.89ms max=65.55ms p(90)=30.76ms p(95)=31.63ms
     iterations.....................: 27637  2756.295763/s
     vus............................: 80     min=80        max=80
     vus_max........................: 80     min=80        max=80
```
