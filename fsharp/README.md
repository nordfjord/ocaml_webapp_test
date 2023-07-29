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


running (10.0s), 00/80 VUs, 35720 complete and 0 interrupted iterations
default ✓ [=====================================] 80 VUs  10s

     data_received..................: 122 MB 12 MB/s
     data_sent......................: 3.9 MB 388 kB/s
     http_req_blocked...............: avg=9.41µs  min=0s      med=1µs     max=4.51ms   p(90)=1µs     p(95)=1µs
     http_req_connecting............: avg=4.17µs  min=0s      med=0s      max=2.12ms   p(90)=0s      p(95)=0s
     http_req_duration..............: avg=22.39ms min=15.4ms  med=21.2ms  max=200.06ms p(90)=26.86ms p(95)=27.81ms
       { expected_response:true }...: avg=22.39ms min=15.4ms  med=21.2ms  max=200.06ms p(90)=26.86ms p(95)=27.81ms
     http_req_failed................: 0.00%  ✓ 0           ✗ 35720
     http_req_receiving.............: avg=14.54µs min=4µs     med=12µs    max=1.52ms   p(90)=21µs    p(95)=37µs
     http_req_sending...............: avg=2.8µs   min=1µs     med=2µs     max=292µs    p(90)=3µs     p(95)=6µs
     http_req_tls_handshaking.......: avg=0s      min=0s      med=0s      max=0s       p(90)=0s      p(95)=0s
     http_req_waiting...............: avg=22.38ms min=15.39ms med=21.18ms max=200.04ms p(90)=26.85ms p(95)=27.79ms
     http_reqs......................: 35720  3562.192927/s
     iteration_duration.............: avg=22.42ms min=15.41ms med=21.21ms max=203.86ms p(90)=26.88ms p(95)=27.82ms
     iterations.....................: 35720  3562.192927/s
     vus............................: 80     min=80        max=80
     vus_max........................: 80     min=80        max=80
```
