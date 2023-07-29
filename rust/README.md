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


running (10.0s), 00/80 VUs, 30520 complete and 0 interrupted iterations
default ✓ [======================================] 80 VUs  10s

     data_received..................: 56 MB  5.6 MB/s
     data_sent......................: 3.3 MB 332 kB/s
     http_req_blocked...............: avg=11.52µs min=0s      med=1µs     max=4.83ms  p(90)=1µs     p(95)=1µs
     http_req_connecting............: avg=5.13µs  min=0s      med=0s      max=2.24ms  p(90)=0s      p(95)=0s
     http_req_duration..............: avg=26.21ms min=17.47ms med=25.86ms max=58.32ms p(90)=28.64ms p(95)=29.7ms
       { expected_response:true }...: avg=26.21ms min=17.47ms med=25.86ms max=58.32ms p(90)=28.64ms p(95)=29.7ms
     http_req_failed................: 0.00%  ✓ 0           ✗ 30520
     http_req_receiving.............: avg=11.3µs  min=4µs     med=10µs    max=297µs   p(90)=14µs    p(95)=17µs
     http_req_sending...............: avg=2.52µs  min=1µs     med=2µs     max=120µs   p(90)=3µs     p(95)=4µs
     http_req_tls_handshaking.......: avg=0s      min=0s      med=0s      max=0s      p(90)=0s      p(95)=0s
     http_req_waiting...............: avg=26.2ms  min=17.46ms med=25.85ms max=58.29ms p(90)=28.63ms p(95)=29.69ms
     http_reqs......................: 30520  3044.246608/s
     iteration_duration.............: avg=26.24ms min=17.49ms med=25.87ms max=62.69ms p(90)=28.65ms p(95)=29.72ms
     iterations.....................: 30520  3044.246608/s
     vus............................: 80     min=80        max=80
     vus_max........................: 80     min=80        max=80
```
