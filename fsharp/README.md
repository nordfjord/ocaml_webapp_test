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


running (10.0s), 00/80 VUs, 28902 complete and 0 interrupted iterations
default ✓ [========================] 80 VUs  10s

     data_received..................: 99 MB  9.8 MB/s
     data_sent......................: 3.2 MB 314 kB/s
     http_req_blocked...............: avg=11.96µs min=0s      med=1µs     max=4.69ms   p(90)=1µs     p(95)=1µs
     http_req_connecting............: avg=5.03µs  min=0s      med=0s      max=2.06ms   p(90)=0s      p(95)=0s
     http_req_duration..............: avg=27.68ms min=18.68ms med=26.95ms max=206.19ms p(90)=29.68ms p(95)=30.73ms
       { expected_response:true }...: avg=27.68ms min=18.68ms med=26.95ms max=206.19ms p(90)=29.68ms p(95)=30.73ms
     http_req_failed................: 0.00%  ✓ 0           ✗ 28902
     http_req_receiving.............: avg=13.54µs min=4µs     med=12µs    max=401µs    p(90)=17µs    p(95)=25µs
     http_req_sending...............: avg=2.59µs  min=1µs     med=2µs     max=134µs    p(90)=3µs     p(95)=4µs
     http_req_tls_handshaking.......: avg=0s      min=0s      med=0s      max=0s       p(90)=0s      p(95)=0s
     http_req_waiting...............: avg=27.67ms min=18.66ms med=26.94ms max=206.17ms p(90)=29.66ms p(95)=30.7ms
     http_reqs......................: 28902  2883.117046/s
     iteration_duration.............: avg=27.71ms min=18.73ms med=26.96ms max=210.25ms p(90)=29.7ms  p(95)=30.74ms
     iterations.....................: 28902  2883.117046/s
     vus............................: 80     min=80        max=80
     vus_max........................: 80     min=80        max=80
```
