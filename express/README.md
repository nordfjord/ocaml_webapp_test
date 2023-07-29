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


running (10.0s), 00/80 VUs, 45765 complete and 0 interrupted iterations
default ✓ [======================] 80 VUs  10s

     data_received..................: 157 MB 16 MB/s
     data_sent......................: 5.0 MB 498 kB/s
     http_req_blocked...............: avg=7.83µs  min=0s      med=1µs     max=4.96ms  p(90)=1µs     p(95)=1µs
     http_req_connecting............: avg=3.39µs  min=0s      med=0s      max=2.17ms  p(90)=0s      p(95)=0s
     http_req_duration..............: avg=17.47ms min=10.93ms med=17.31ms max=65.33ms p(90)=18.91ms p(95)=19.54ms
       { expected_response:true }...: avg=17.47ms min=10.93ms med=17.31ms max=65.33ms p(90)=18.91ms p(95)=19.54ms
     http_req_failed................: 0.00%  ✓ 0           ✗ 45765
     http_req_receiving.............: avg=12.62µs min=4µs     med=11µs    max=233µs   p(90)=16µs    p(95)=22µs
     http_req_sending...............: avg=2.5µs   min=1µs     med=2µs     max=168µs   p(90)=3µs     p(95)=4µs
     http_req_tls_handshaking.......: avg=0s      min=0s      med=0s      max=0s      p(90)=0s      p(95)=0s
     http_req_waiting...............: avg=17.45ms min=10.92ms med=17.3ms  max=65.3ms  p(90)=18.89ms p(95)=19.53ms
     http_reqs......................: 45765  4568.791991/s
     iteration_duration.............: avg=17.49ms min=10.94ms med=17.33ms max=70.26ms p(90)=18.92ms p(95)=19.56ms
     iterations.....................: 45765  4568.791991/s
     vus............................: 80     min=80        max=80
     vus_max........................: 80     min=80        max=80

```
