# ms

Erlang microservice example

### Requirements

* Erlang 17.0 +

## Services

- [ms_base](https://github.com/lpgauth/ms_base)
- [ms_http](https://github.com/lpgauth/ms_http)
- [ms_kv](https://github.com/lpgauth/ms_kv)
- [ms_logger](https://github.com/lpgauth/ms_logger)

## API

### kv
```
curl -i -X PUT -H 'Content-Type: text/plain' -d 'bar' 'http://127.0.0.1:8080/api/v1/kv/foo'
HTTP/1.1 201 Created
server: Cowboy
date: Wed, 09 Sep 2015 00:51:41 GMT
content-length: 0
content-type: text/plain
x-response-time: 354


curl -i -X GET 'http://127.0.0.1:8080/api/v1/kv/foo'
HTTP/1.1 200 OK
server: Cowboy
date: Wed, 09 Sep 2015 00:52:10 GMT
content-length: 3
content-type: text/plain
x-response-time: 341

bar

curl -i -X GET 'http://127.0.0.1:8080/api/v1/kv/foo2'
HTTP/1.1 404 Not Found
server: Cowboy
date: Wed, 09 Sep 2015 00:52:29 GMT
content-length: 0
content-type: text/plain
x-response-time: 418


tail log/2015-09-09-00.log
{"timestamp":1441759901896723,"method":"PUT","path":"/api/v1/kv/foo","found":false,"key":"foo","value":"bar"}
{"timestamp":1441759930891798,"method":"GET","path":"/api/v1/kv/foo","found":true,"key":"foo","value":"bar"}
{"timestamp":1441759950040894,"method":"GET","path":"/api/v1/kv/foo2","found":false,"key":"foo2"}
```

### logger
```
curl -i -X PUT -H 'Content-Type: text/plain' -d 'hello world' 'http://127.0.0.1:8080/api/v1/logger/my_log'
HTTP/1.1 204 No Content
server: Cowboy
date: Wed, 09 Sep 2015 00:55:11 GMT
content-length: 0
content-type: text/plain
x-response-time: 336


tail log/my_log.log
hello world
```

### status
```
curl -i -X GET 'http://127.0.0.1:9090/status'
HTTP/1.1 200 OK
server: Cowboy
date: Wed, 09 Sep 2015 00:54:26 GMT
content-length: 227
content-type: application/json

{
  "status" : "OK",
  "git_sha" : "ee55c6b13bf0c64ad41f2b581f8ffe48fae83d7b",
  "build_date" : "Wed  9 Sep 2015 06:13:11 IST",
  "now_unix" : 1441760067648246,
  "services" : [
    "ms_http",
    "ms_kv",
    "ms_logger"
  ]
}
```

## Tests

```makefile
make dialyzer
make elvis
make xref
```

## License

```license
The MIT License (MIT)

Copyright (c) 2015 Louis-Philippe Gauthier

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
