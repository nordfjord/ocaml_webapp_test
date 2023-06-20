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


running (1m00.1s), 00/80 VUs, 26491 complete and 0 interrupted iterations
default ✓ [======================================] 80 VUs  1m0s

     data_received..................: 7.4 GB 124 MB/s
     data_sent......................: 2.9 MB 48 kB/s
     http_req_blocked...............: avg=8.71µs   min=0s     med=1µs      max=3.05ms  p(90)=2µs      p(95)=3µs
     http_req_connecting............: avg=5.48µs   min=0s     med=0s       max=2.08ms  p(90)=0s       p(95)=0s
     http_req_duration..............: avg=181.34ms min=3.57ms med=161.52ms max=3.06s   p(90)=331.19ms p(95)=397.66ms
       { expected_response:true }...: avg=181.34ms min=3.57ms med=161.52ms max=3.06s   p(90)=331.19ms p(95)=397.66ms
     http_req_failed................: 0.00%  ✓ 0          ✗ 26491
     http_req_receiving.............: avg=11.19ms  min=56µs   med=5.52ms   max=107.4ms p(90)=29.7ms   p(95)=38.73ms
     http_req_sending...............: avg=6.62µs   min=1µs    med=4µs      max=4.71ms  p(90)=10µs     p(95)=15µs
     http_req_tls_handshaking.......: avg=0s       min=0s     med=0s       max=0s      p(90)=0s       p(95)=0s
     http_req_waiting...............: avg=170.14ms min=3.14ms med=144.88ms max=3.06s   p(90)=323.41ms p(95)=391.34ms
     http_reqs......................: 26491  440.698671/s
     iteration_duration.............: avg=181.38ms min=3.6ms  med=161.58ms max=3.06s   p(90)=331.21ms p(95)=397.68ms
     iterations.....................: 26491  440.698671/s
     vus............................: 80     min=80       max=80
     vus_max........................: 80     min=80       max=80
```
