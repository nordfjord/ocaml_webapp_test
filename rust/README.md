```
❯ k6 run --vus 80 --duration 60s  test.js

          /\      |‾‾| /‾‾/   /‾‾/
     /\  /  \     |  |/  /   /  /
    /  \/    \    |     (   /   ‾‾\
   /          \   |  |\  \ |  (‾)  |
  / __________ \  |__| \__\ \_____/ .io

  execution: local
     script: test.js
     output: -

  scenarios: (100.00%) 1 scenario, 80 max VUs, 1m30s max duration (incl. graceful stop):
           * default: 80 looping VUs for 1m0s (gracefulStop: 30s)


running (1m00.1s), 00/80 VUs, 25882 complete and 0 interrupted iterations
default ✓ [======================================] 80 VUs  1m0s

     data_received..................: 4.9 GB 81 MB/s
     data_sent......................: 2.8 MB 47 kB/s
     http_req_blocked...............: avg=9.44µs   min=0s     med=1µs      max=3.38ms p(90)=1µs      p(95)=2µs
     http_req_connecting............: avg=5.97µs   min=0s     med=0s       max=2.09ms p(90)=0s       p(95)=0s
     http_req_duration..............: avg=185.63ms min=5.19ms med=185.44ms max=1.16s  p(90)=275.37ms p(95)=321.3ms
       { expected_response:true }...: avg=185.63ms min=5.19ms med=185.44ms max=1.16s  p(90)=275.37ms p(95)=321.3ms
     http_req_failed................: 0.00%  ✓ 0          ✗ 25882
     http_req_receiving.............: avg=47.38µs  min=24µs   med=40µs     max=2.8ms  p(90)=60µs     p(95)=75µs
     http_req_sending...............: avg=4.02µs   min=1µs    med=3µs      max=175µs  p(90)=7µs      p(95)=9µs
     http_req_tls_handshaking.......: avg=0s       min=0s     med=0s       max=0s     p(90)=0s       p(95)=0s
     http_req_waiting...............: avg=185.58ms min=5.15ms med=185.38ms max=1.16s  p(90)=275.33ms p(95)=321.26ms
     http_reqs......................: 25882  430.492251/s
     iteration_duration.............: avg=185.66ms min=5.2ms  med=185.46ms max=1.16s  p(90)=275.42ms p(95)=321.32ms
     iterations.....................: 25882  430.492251/s
     vus............................: 80     min=80       max=80
     vus_max........................: 80     min=80       max=80
```
