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


running (10.0s), 00/80 VUs, 32344 complete and 0 interrupted iterations
default ✓ [======================================] 80 VUs  10s

     data_received..................: 109 MB 11 MB/s
     data_sent......................: 3.5 MB 352 kB/s
     http_req_blocked...............: avg=10.62µs min=0s     med=1µs     max=4.74ms   p(90)=1µs     p(95)=1µs
     http_req_connecting............: avg=4.82µs  min=0s     med=0s      max=2.31ms   p(90)=0s      p(95)=0s
     http_req_duration..............: avg=24.73ms min=1.94ms med=23.75ms max=376.14ms p(90)=25.85ms p(95)=26.61ms
       { expected_response:true }...: avg=24.73ms min=1.94ms med=23.75ms max=376.14ms p(90)=25.85ms p(95)=26.61ms
     http_req_failed................: 0.00%  ✓ 0           ✗ 32344
     http_req_receiving.............: avg=14.01µs min=4µs    med=12µs    max=751µs    p(90)=18µs    p(95)=31µs
     http_req_sending...............: avg=3.06µs  min=1µs    med=2µs     max=5.57ms   p(90)=3µs     p(95)=5µs
     http_req_tls_handshaking.......: avg=0s      min=0s     med=0s      max=0s       p(90)=0s      p(95)=0s
     http_req_waiting...............: avg=24.71ms min=1.9ms  med=23.73ms max=376.12ms p(90)=25.83ms p(95)=26.59ms
     http_reqs......................: 32344  3227.013688/s
     iteration_duration.............: avg=24.76ms min=1.99ms med=23.76ms max=379.8ms  p(90)=25.86ms p(95)=26.63ms
     iterations.....................: 32344  3227.013688/s
     vus............................: 80     min=80        max=80
     vus_max........................: 80     min=80        max=80
```
