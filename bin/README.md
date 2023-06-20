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


running (1m00.3s), 00/80 VUs, 15868 complete and 0 interrupted iterations
default ✓ [======================================] 80 VUs  1m0s

     data_received..................: 4.3 GB 72 MB/s
     data_sent......................: 1.7 MB 29 kB/s
     http_req_blocked...............: avg=14.38µs  min=0s      med=1µs      max=3.4ms    p(90)=1µs      p(95)=2µs
     http_req_connecting............: avg=10.17µs  min=0s      med=0s       max=2.39ms   p(90)=0s       p(95)=0s
     http_req_duration..............: avg=303.19ms min=22.15ms med=285.94ms max=955.11ms p(90)=402.35ms p(95)=428.41ms
       { expected_response:true }...: avg=303.19ms min=22.15ms med=285.94ms max=955.11ms p(90)=402.35ms p(95)=428.41ms
     http_req_failed................: 0.00%  ✓ 0          ✗ 15868
     http_req_receiving.............: avg=710.68µs min=39µs    med=57µs     max=266.63ms p(90)=86µs     p(95)=100µs
     http_req_sending...............: avg=4.58µs   min=1µs     med=4µs      max=232µs    p(90)=7µs      p(95)=9µs
     http_req_tls_handshaking.......: avg=0s       min=0s      med=0s       max=0s       p(90)=0s       p(95)=0s
     http_req_waiting...............: avg=302.48ms min=22.06ms med=285.88ms max=951.94ms p(90)=402.28ms p(95)=428.34ms
     http_reqs......................: 15868  263.211931/s
     iteration_duration.............: avg=303.23ms min=22.17ms med=285.96ms max=958.55ms p(90)=402.37ms p(95)=428.43ms
     iterations.....................: 15868  263.211931/s
     vus............................: 80     min=80       max=80
     vus_max........................: 80     min=80       max=80
```
