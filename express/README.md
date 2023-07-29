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


running (10.0s), 00/80 VUs, 40495 complete and 0 interrupted iterations
default ✓ [=====================================] 80 VUs  10s

     data_received..................: 75 MB  7.4 MB/s
     data_sent......................: 4.4 MB 441 kB/s
     http_req_blocked...............: avg=6.95µs  min=0s       med=1µs     max=4.53ms   p(90)=1µs     p(95)=1µs
     http_req_connecting............: avg=4.03µs  min=0s       med=0s      max=2.47ms   p(90)=0s      p(95)=0s
     http_req_duration..............: avg=19.74ms min=689µs    med=18.63ms max=118.55ms p(90)=32.18ms p(95)=37.97ms
       { expected_response:true }...: avg=19.74ms min=689µs    med=18.63ms max=118.55ms p(90)=32.18ms p(95)=37.97ms
     http_req_failed................: 0.00%  ✓ 0           ✗ 40495
     http_req_receiving.............: avg=11.76µs min=5µs      med=11µs    max=375µs    p(90)=14µs    p(95)=16µs
     http_req_sending...............: avg=2.54µs  min=1µs      med=2µs     max=66µs     p(90)=3µs     p(95)=4µs
     http_req_tls_handshaking.......: avg=0s      min=0s       med=0s      max=0s       p(90)=0s      p(95)=0s
     http_req_waiting...............: avg=19.72ms min=672µs    med=18.62ms max=118.54ms p(90)=32.16ms p(95)=37.96ms
     http_reqs......................: 40495  4044.482011/s
     iteration_duration.............: avg=19.76ms min=699.95µs med=18.65ms max=118.56ms p(90)=32.2ms  p(95)=37.99ms
     iterations.....................: 40495  4044.482011/s
     vus............................: 80     min=80        max=80
     vus_max........................: 80     min=80        max=80
```
